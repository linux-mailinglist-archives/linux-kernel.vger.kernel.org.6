Return-Path: <linux-kernel+bounces-207389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1222E901663
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 16:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A173E28134C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C403044C76;
	Sun,  9 Jun 2024 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b="BRz3svUf"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2101.outbound.protection.outlook.com [40.107.13.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D541C69;
	Sun,  9 Jun 2024 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717944560; cv=fail; b=aUXJL4xn/7TDqoFxEUcK2l/AlxGtz3YjHhF/7EpTB6JpjN+Kk48+RTtRaCzgpU/M/hRfowTTatnBuToFJ4vwVrsB7KOE9qRINoXXP8JAFKSysdFG5kQ40/8zidhjw41mhRGhSBl3znu4ch6sjzj+DqH21/lleyxNR44AvFbG70A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717944560; c=relaxed/simple;
	bh=HCmgduU4f22CoezaPoaJCZc7xo0+HZi9IO1I1vtYPiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OYgDzy9gaBDO7uSQs1bhKIekI+gYlFBHoUwhMCn5D7qJvggLownvya+Ly3UVW4YNd/8QkBsCl28pMJavDgLI9JUpfD31xZ58aLbQZQNDE3HvZI4o/IVF5cqzt4SD8/G9IULvBxAAcoSQA2v7rhbCWs56W5D0qCnfKvpRkatcmXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn; spf=pass smtp.mailfrom=supcom.tn; dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b=BRz3svUf; arc=fail smtp.client-ip=40.107.13.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=supcom.tn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eA3YjkYGt+kfUFzRk7tIC8M+7veZd3w0Q59Tu75NdtM1XvQygQo9ohBrTM+30At3PwKxuVtxWuH4EqyiBigga/kiT+NozjpDxwmoDPozRDmGthhwXXqhXLcg+LqaMDhsDJt9uk0TGvpUNT86UB94KqjIH2wUlKfz2xjphFBJGr3fGlIaLM3bwlp7bXUGOxCD6LW9RqOId51Ez6XLQ/TfmBliNisVT+2lRDgMa159CWD78mhTfZX0CmcnZqBK5EIjSMIssbe/a7vGbNQVyroKwGoLnQOvVQflmJPREtzIdxtnsIVvZ/p01rHib14cyk0+QQc/MGBTSgGeo9+pCIy3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvi3hv/oTMCTjttgAz9D84Zhghr/a6AESAohFIP+DVE=;
 b=PaecVZkJz8LmO30Yfoj5/nFKeC5m2FNInTPDYK9xEWJ5+wvg1EFo6vK2YDjg1NXTi7O3ZqrhGwVn9HplSDCIi//Nc7JGftAPuWqpnGpKtyObov6bqmbBRm2EYzgVgm36wyHmYsx+MGqgLcKV6LDNmsjcmlio0ElKT2qQkFWpz7v7fu5/KjoMIcJKo9aIRrF9k1gnAtZqa3tEjZhJjlaD1KAJ5E2rhfLxVMmpAFSmxwJ5UEhilcCrtSs9RqsrONMKCe4BxnzIl+A5sQCGFebnbiPL3XeR/ReZvOvNYeFsSuRqyC7Qb8Qih5bAnjitVffB30xeqd9mXpgqtfwlvK7csQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=supcom.tn; dmarc=pass action=none header.from=supcom.tn;
 dkim=pass header.d=supcom.tn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=supcom.onmicrosoft.com; s=selector2-supcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvi3hv/oTMCTjttgAz9D84Zhghr/a6AESAohFIP+DVE=;
 b=BRz3svUf3Pa/Y7QhN6fW9ywx9nqzchNqpD8n9IgUtI0RrhkaCb1uLIbQELmUhMOd29mP8Z7zLO5U9bbJq1jzRSDZlTVnukt+Fubf+tIk09PCuvT5akbCruUJZ4ZsbsPVgimGswN92TK4XucAHUyEp/Vj6TfsTk9s+11q5bVPNMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=supcom.tn;
Received: from AM8PR04MB7908.eurprd04.prod.outlook.com (2603:10a6:20b:24c::18)
 by AM9PR04MB8131.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Sun, 9 Jun
 2024 14:49:12 +0000
Received: from AM8PR04MB7908.eurprd04.prod.outlook.com
 ([fe80::eb8c:cdd5:a0a:757f]) by AM8PR04MB7908.eurprd04.prod.outlook.com
 ([fe80::eb8c:cdd5:a0a:757f%5]) with mapi id 15.20.7633.036; Sun, 9 Jun 2024
 14:49:12 +0000
From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D . Jones" <luke@ljones.dev>,
	Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Subject: [PATCH v4 0/1] platform/x86: asus-wmi: add support for vivobook fan profiles
Date: Sun,  9 Jun 2024 15:48:48 +0100
Message-ID: <20240609144849.2532-1-mohamed.ghanmi@supcom.tn>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To AM8PR04MB7908.eurprd04.prod.outlook.com
 (2603:10a6:20b:24c::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7908:EE_|AM9PR04MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 8087e4e7-f47d-4048-fa36-08dc8893535d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|41320700004|1800799015|376005|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHc1NXZnVXlUVDA4UjVINEVMZXUvcDAxeCthWTVCWjFGUUVNUWd3aUZlUmFF?=
 =?utf-8?B?c2ZmSG5rZTVvaGZENm5MYXBLa2xhVVpSLzAxNDVvcTN1b2pmMWJiY25Id0RS?=
 =?utf-8?B?cGF6SmRxTE1nT1RuZlE0ekJzNkpkeVJUaUVOZHNza3NwM3hPbWdqQW1PeTRO?=
 =?utf-8?B?Y3pjUjA1MnR1em1YQUVhZUJiQ3R5UzlKR1orS2lSNHBLekVRYVY4aFhuU1RG?=
 =?utf-8?B?LzI4bFZiYkNhS2loOVVFT2JCS3I4VEtaSXJ1RUd2N3ZzUWVxaGhxakpjcmJK?=
 =?utf-8?B?ZkF2YUJUTkdiTFkvOFFORER3bkU4QkdSdEp4SWlrT2pKWEJmSDd6TXRzTE1n?=
 =?utf-8?B?UExLd0kzRkJRcXlIb2tJMWJlSCt5TUNBQ2dGQlVPZ21QK1lEblkvdUxvRCs2?=
 =?utf-8?B?dGFsNHNuRENFWVRBb3phdUcwT0MzMEo0TkVoTXVzdlYzc2dVZzlaemp5Szk3?=
 =?utf-8?B?bU84UDlFNlBGR0ZROE1nT3BTaUtGMm5zbEhWUTEyMFF1UUNhdTJBRnJ1cTZW?=
 =?utf-8?B?NGwwZTBBQ1dtTWJ2RUNIZ2kxU2t2RElMV1ZBTGdjalpHNVB5b2lzM2JHYzZ2?=
 =?utf-8?B?ZXh2RGJlYlRXUWtDS2hGNCtmclpvNFFkVmRaNUR5SEJMWDFCQ0VqakZSUGR3?=
 =?utf-8?B?K1R0R0hPbjZ5WEl6a0hYK2RybmNIRmtZR2gvU1hlclZ1N3M0RGRLVVllR0pZ?=
 =?utf-8?B?bU0rb1pzMzRWWFNkSU9DMS83cm05eFhsVHRTck5DWFp4WURBdTBFa0V4VXFN?=
 =?utf-8?B?R1FVc3lYODlQQzYwVjIzTUxOSU5UaHdKY1lYS1k3R1pnUUlxVTF0Wi93bmNV?=
 =?utf-8?B?Sy96U1dYckllMjh0L25qT21WdWt5WXZwSXF4OEZmTGJWdXJFWG4rTis0U0Y0?=
 =?utf-8?B?MVVXSHh1SURmcHNTK2NGRHoraWlPWHZkeE5aYWp5a2RxOFZxS0NMOTl6NlZF?=
 =?utf-8?B?dXVSYU9vL1N6blVmVGVsUmV2K2M2K28yRmhrNkdpak9HUnJqNWk3ekhTenlO?=
 =?utf-8?B?MGg4Sk1oUWF6Q1A4UlA4SUxoYSs3YUh1NUpSSmlNRnpEMlZnS2xMejVQS3RC?=
 =?utf-8?B?KzVnRVFNaVZSc29PY2ZOSjdzNDFBUFVmVWlTSXJ5VldIQmFjcFhYNlJySDFP?=
 =?utf-8?B?dSt3SnhHcS9ROEZuYlRQbXdteEdJODZnU1VxUFNUQkhLRmpMaVJjUGFSUzNC?=
 =?utf-8?B?MXlhR2MzaUFiUEhabnJlK2Z3QmFGV3lOL1BkUWE2U29TTUp6SEVpbjZtQzVB?=
 =?utf-8?B?SkR3OWg5UFVRZ2NPMzh0MUVoWGYwSGlybUhlLy9aL1FWeXZTQjZIZ1VJaEli?=
 =?utf-8?B?YitpV0IxbUFZZWdqTXlTandpQmlEdHNvZk1RREFKNDFTZ25oT29zN3hSTmR2?=
 =?utf-8?B?b3NyTVVMc2RST3M2Q0hZNjdRN3Q3czZTRzdHWHA5MGNVdW1CNEVxZTZkZ2FJ?=
 =?utf-8?B?UGpUOCt4Mis2Q0lERHlDbUJKZEMyVG8yWXdrTzZEUEk3VjFHOHA2Y2xlWW9I?=
 =?utf-8?B?SXhJZkxicDVZVUtoQUU1TUJPKzJSRnp1MjExL0VZejRFUVoxNU0rL0QzUWJy?=
 =?utf-8?B?WklXSHk0M3FhVXRBWDl4b1pJMnRNMnFTSmJMZTNkMlU4NjV6My9BS25GTWJX?=
 =?utf-8?B?VVQvNDIyWWp1RUdRUVlIc0t3Uk8zcWhBS3dYT2V0c0NBTUhoRmtnYWEyd2Jn?=
 =?utf-8?B?emlGSGthalNSdTFBRjg4blFIWVIyTmZVRDloM1ViLzYrOVhlanJXOStueXFO?=
 =?utf-8?B?OWZEZnBrdGVTN1lwL0MxR3QyVFI1WVV4K0JWUnpDcWx3SFV4OUxMMnAzV0o1?=
 =?utf-8?Q?dlGn0MyT3XgQBWjyFPtffb7Q+0cpEgBiDr4mc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7908.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFg4aHVocHlNbzgvOFFZMko3bmdqa1lDWnpzTStvTGhtMFNHZXA5Wkt3bGlS?=
 =?utf-8?B?Z0NKN2VLaGttOWNUV2xaTlo0MElnbGJoanQzZWJpaFJqaTQ3RXZlVmI1aHY1?=
 =?utf-8?B?aWFVRjJlekhaSktEOGduWjYyMFpzY2ZSVW0vTmk4bk4rZHlLVS82RjNMM0FD?=
 =?utf-8?B?RWFFOWFLNGVEZ0Q3RlNRVnlKSTNzU2JEVWhHLzZKVEkzT3JYZUhrcGk1cWpS?=
 =?utf-8?B?ci8wZDY2ZFFPR2E1QUkvNS9WNnpYUktCNXF3c1NNN0tGR2VBcnBxaWVsbkRO?=
 =?utf-8?B?L1ZPallzMUVSR0NCc25kd2FkNU5CcU5HdWRyOVRqcnMvd05pVXRkS1JXMUM0?=
 =?utf-8?B?MDdOL0NVZHJSZFdwR2lWbElKVldUNHYvL2lXOFhjamxtdEhKTEpqQVNmQVpQ?=
 =?utf-8?B?QlU4OU9LVGMzUTJVNUZhTHRKY3ZKOEU4Tm05UC9qTGRZaVk1UnNBdnJkK1lk?=
 =?utf-8?B?WDNHUVRoaFh0U01wd2V4WUkzOElCSGpCblNCVnF5cXN0ekNJeGhXdWxKU2Y5?=
 =?utf-8?B?MTF4TVV5Y05IUDlsTVVtQWdPeS9kaGdQdFUveDhFSEhQbVVsRDlsM0VtdHpV?=
 =?utf-8?B?bHNOeHJuU1VvQ3hJYmdnV2t6SXBuYWs2dDE0d0hRVEF6UzVJd0ZiWXh4QWpT?=
 =?utf-8?B?ZXFPajhPUHl0WGhLbzd4RFJGamYzSUU4Rmc5U293TGdjcm1qYjJ0TUVkQ3Fv?=
 =?utf-8?B?V0JXZmpLd2FsV3RnbStwdDFjYnpMKytMSmpVQXVNZjlKc29aMENWeEFESXNn?=
 =?utf-8?B?enpLdUpYRjE3b1g0elFEaW1OVko5YzQ5SFVlQ3ZTa25TOWFLRXBlejg3TVJr?=
 =?utf-8?B?UGdPTks1NFR6Njc2SVRwMjYyVTBURUt6cWtDeGlXYjdCZ3l2V0VEUENvS1RE?=
 =?utf-8?B?a25heVA5VElYS1FqWUF2cnRRNlQyaW5FTXdUMzNUSTl2SWZTWS9XWGFyKzc5?=
 =?utf-8?B?QWJsTzkzdFNxanV1aE9yRFp2eEdGY1Mxc2VrcFpuM0FVc2thMFVHNlVja3h2?=
 =?utf-8?B?N3NzcFNJTU11cFR4dlRScHNWZ2k1Z0ZyaGhuRkFnY2ZYTkpKdCtQS2puQXVq?=
 =?utf-8?B?Q1I2c29CRXZRZjM5ZWNGQ3lUbHY2L1pIbGdObGU0ek9NMGJJVjlnODlmbHNz?=
 =?utf-8?B?QkNWZi9pemhJREROMDRVTXdzamI5aGN1M3dtei9kQVY5NFNIZmRLQ2g0a0hL?=
 =?utf-8?B?cVZFdGQ3RFNkODJMcWxIY0wxVmkvVkUzYmlrVEpBZi9vQzRlL3BQRXY3cjBn?=
 =?utf-8?B?ejdnVjV2ajNFVEd2YzZ2blBDVDRFQUptY0xEY1FsUVJlYkQzNkNhRHB5VzF1?=
 =?utf-8?B?dVNWQ3JkK1o5aGpUNDVvcUlmMUtma3VTaHNKbU92TWhvWkFUcHVxa1FkSXp1?=
 =?utf-8?B?R0R1SU44dFRVUmFzN0VvRGh3RDg5bmp2NkkybXoyTmlsMk1TYTJ2NEpsblFD?=
 =?utf-8?B?bXFCRWgzQmVHckRNUkVQUENxN0FVK0ZZTEIyY0xQNmNqYW12dmhVTkNVRUlS?=
 =?utf-8?B?NjJ4R2NBRzJaRnI1ZEpacHZscFhudEVhbUYvQi9rOGF2NWErUjl0NXV0OHJH?=
 =?utf-8?B?bXpPZTlxMTA5d2V1ejQxVHlXVGpIaWZmUTJzTUhld2tvT3pwNWNFYm9pRkdN?=
 =?utf-8?B?V3lMV09Pa2FUcDlWYTdkdCtzc2VaTXNhVUZMNGdqS2dKQS8ySWVhaHdNM1Ir?=
 =?utf-8?B?SmY2d3pBd0NlL1VBMjZiaFpGVzY0dEhaY09wbmlXSitSWmxZa2ZoeEJLQ2JK?=
 =?utf-8?B?azZtL2Z2Y3BucEpWdDdpbVp3TGhkRnduOVZ2WDdBT1F1U1FoME0rUDUxRFJO?=
 =?utf-8?B?dUZURGFIRnVnVytKVG1Va01IVlJYOGFMSm1qdUtsRHI1ckZwZURPdWZlbjRP?=
 =?utf-8?B?Q0xCL1R4UUVTU3JPU2tYb2E1QWdzVnBqdzRxQytpWEkzWk14bGYvblFxMnFH?=
 =?utf-8?B?Q1ZGUW9DRS81YmRkcEpHTGR5eXIrSEw4M0I2R1Qrc1psWVdoS3krV05XbUow?=
 =?utf-8?B?UG1VUnkzWE1uRXVISlhUNGlmZFlXVHM3N0NnbjdTOW8vOFB0VzZ2V2g2TFEr?=
 =?utf-8?B?NEV0dVhBNEpWUDhTaG1VZXBxS3hhRUc3WW45SnA4VlJ3b1hHaE41eDZDNU9E?=
 =?utf-8?B?S3AxNGpBbDJzd0VRbm5Gb0Y5T1ZFcG90MUN5WnRzOUc0RncxSmxjQkdtdHNy?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: supcom.tn
X-MS-Exchange-CrossTenant-Network-Message-Id: 8087e4e7-f47d-4048-fa36-08dc8893535d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7908.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2024 14:49:12.2244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8f85f528-6195-4e97-8e41-f5a9ad3bed4a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjdduTNaVt1waKDGbyOfPUawcs/ggLXVA9x7T8TZG5Z/T2ooh5KV3s3hljxE7QCHDcFMK6mJsCleQq3KxG975o6d1TcUKdX+4bgF7K+rpwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8131

Add support for vivobook fan profiles wmi call on the ASUS VIVOBOOK
to adjust power limits.

These fan profiles have a different device id than the ROG series
and different order. This reorders the existing modes.

As part of keeping the patch clean the throttle_thermal_policy_available
boolean stored in the driver struct is removed and
throttle_thermal_policy_dev is used in place (as on init it is zeroed).

Changelog:
- V1
  - fixes grammar in description
  - reorders macros
  - adds throttle_thermal_policy_max_mode() helper function
- V2
  - removes unnecessary braces in throttle_thermal_policy_max_mode()
- V3
  - fixes a use before declaration compilation error caused by reordering of local
    variables in throttle_thermal_policy_store() function
- V4
  - removes the fullspeed mode
  - moves the remapping from throttle thermal policy to Platform profiles

 drivers/platform/x86/asus-wmi.c            | 125 ++++++++++++---------
 include/linux/platform_data/x86/asus-wmi.h |   1 +
 2 files changed, 76 insertions(+), 50 deletions(-)

-- 
2.44.0


