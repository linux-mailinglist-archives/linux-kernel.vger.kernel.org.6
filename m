Return-Path: <linux-kernel+bounces-368419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9E49A0F98
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545881F28355
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8700B210C37;
	Wed, 16 Oct 2024 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aypiDoo/"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2045.outbound.protection.outlook.com [40.107.104.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D62B2141A3;
	Wed, 16 Oct 2024 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095827; cv=fail; b=cQgy5O2DLSLShMpkvX07HDjt0bvffGtFNTl1UGxkCzPwStj7ruFtdya3P8QhnSAQZx6O2S01oWQTIf4NoA19hxQQ0R24UJuiWzjZII1cP3ToTn2QzuKK51YP9fQy3EOzv87WvyphW8HTCKFOj9NL2lTJq/8FWkIms6rTUgp6ap4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095827; c=relaxed/simple;
	bh=EpQSowENmv2+76MaNuhYEIyM0LGtLX4F0BAw4YtV4+0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=B4+KbjzVjC10j6NfW1uOFHT1iTyWRNe6NsmSohxfpG6oEMCMWO4fQseB1/sMYHixInk8AVK7zb07ITj4M3EwKOVmXpOYX0QGpBndyLIinn3kv8cZ2KnBt8f67FmQzgCz/+dWupJ3f+B+55GvYFRkts1ovE0hUrum+up7sHRLMeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aypiDoo/; arc=fail smtp.client-ip=40.107.104.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoBBerNF+jO2tmm8fnPUhOqg/F1IxbVhqN40cEKIbAyICcWOpUbF0KkAqVHQodrroOPHBhZXotC9Ga3v+PdGRL5lmvvGBP5+EEcJcm3c7iRY8sUUCghV8n24VGaz+tRoMIUEmAvkrayZqGf8uV+1nAMMesD3tThiV0NLauABF525sL73JW7eoZ/WKy+y6V9nuySbWM/AFOdozj3ZKn18OjReJMJqBJ+hZ920KPsw0/S351t4LAM7ag4wfRREbL6wWTfuYvxuirlZClq+VEXdXbl/irgkMOsvklCIODgLcPFa8oRfMZvfQW/zXdU98EjfthFeD46HCSFHyZ6+EkgOAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llS7Hd4F08G34AzdOg3c2PFe2GXVhj9lg3S7I4WmT3o=;
 b=VpfC4FnZhpBd6pLxvak3Upz7TJuarwRzCw7rDshpQt3+EsRvLGg32LrWbPazUGiNU7IZY+tsdvWOffQbUSM/jDZ9RvEJvCLhqSuqYyEBTjMRWG7n2E5bvtd2i0fECAToyJHOFFEeqxnnPZGHmAWg9DLR8xs0rmCc+CvD5J0ZXR4S62QkHtnsZWTlwGTEpfDClWvBL61eMhM1gdCMBYxLvyrnoAe33Ll6HIeqtFNffe3KBSkWzjtGlSTg4jyQZQQ/eq0ridqDx3GlBOxEXoy/8oHFxQhtTQln1NgL6VxIiTIKiB1FbyRmiWIV8yyMpswk8IW0M8/yl7tmMHejs2XODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llS7Hd4F08G34AzdOg3c2PFe2GXVhj9lg3S7I4WmT3o=;
 b=aypiDoo/pduLrpAnVnJMp/nB/12tPqi+JuKGtYv6CKDSLeBnlESd94CgdVjmJ2pJpf+WPkBmi4HzeMl8nkjySIQ1hMezMa1aRpma5nUwWXzhs0wG01Fxy2P7xFUwoRiUdc2jwaj1iPT9B9wYLa/sXTAx/f/AvkXp9STv/kLRcaW7zJBFCNfg5viPoF3efc7sQZq4vrZwR1gAESXDOJSRlM2CTRD8D2UbxeG00xlkSkMKWSJ6O6tymE2VDudajYwhW2CF8kODYKz1TNFDxpoFtc37NJbLhhI5twW62Qh8esHIlILRco/t4e51bHKgLTXUFrjYUmNxaQI1DEhfQ4wg2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8599.eurprd04.prod.outlook.com (2603:10a6:10:2da::7)
 by AM0PR04MB6884.eurprd04.prod.outlook.com (2603:10a6:208:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 16:23:41 +0000
Received: from DU2PR04MB8599.eurprd04.prod.outlook.com
 ([fe80::763:eb3b:6607:1e72]) by DU2PR04MB8599.eurprd04.prod.outlook.com
 ([fe80::763:eb3b:6607:1e72%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 16:23:41 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Wed, 16 Oct 2024 21:49:01 +0530
Subject: [PATCH v9 4/5] firmware: imx: add driver for NXP EdgeLock Enclave
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx-se-if-v9-4-fd8fa0c04eab@nxp.com>
References: <20241016-imx-se-if-v9-0-fd8fa0c04eab@nxp.com>
In-Reply-To: <20241016-imx-se-if-v9-0-fd8fa0c04eab@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729095547; l=39201;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=EpQSowENmv2+76MaNuhYEIyM0LGtLX4F0BAw4YtV4+0=;
 b=BJvt8paJdPNcPRFT+HGOdGO46zzqvzlGyVuaDonyivAwdNnzpBPtm/CK3/sQ3/mqAAePV1ZkK
 8Tw3jKvMYTWCPP6VXtJIMJWmcuiFkNkz7nG2EOgOQUPBWv7m2xZCUKq
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To DU2PR04MB8599.eurprd04.prod.outlook.com
 (2603:10a6:10:2da::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8599:EE_|AM0PR04MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b91ca0-66f6-471c-3ac5-08dcedfee5bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVViS0dFMno2MVRBMUJ2c2tCUmhvTi9BN3ZaMkdsemFpMEZYcHlpRk5aSllR?=
 =?utf-8?B?bm0rK1ZvMER5MjY3Z203U09kUFVDc2ZTQlNtYVBmUEZKNXg5NGxIcG5YaFVP?=
 =?utf-8?B?UGF3YTRPMGlqVEpsMFlVdXU3TmkvVmRLK1BaQXpNd0F1bzRxZjlSbHBZWTRE?=
 =?utf-8?B?NGFDZks3UFdRT3RRM0dXaFFoZmpsQ2cyd0haYlNxd3ZHbzVOUEV6Q3lrNkZm?=
 =?utf-8?B?NFZPUHV4aGVpYnN4RTZxVUNNczJNS29tYWNmZzgrNlZpdjlPVC9NejFVSDhq?=
 =?utf-8?B?S1MxUDdlaEZWM1UwVW1SRFZqdFRYekxoU0EyajdISWt4M2N2RWdjWVQ1MmRr?=
 =?utf-8?B?K2lpVzlMREtmL01LbjJHdU5xdzF4czBQZS96Sjk4R0JKQ2ptM25iVFF1NWFy?=
 =?utf-8?B?MHhHQVgwdmMyNWkyUDc3N2JnaTgzOU9vQTNLM29jUXpiWWgyOTB4SDUyZ29u?=
 =?utf-8?B?cjFUZ0k2aEJBR1NiRXZEMS9VanNFek5BTGYvUEdnZ3RvTXMzUDRiekxmMWVx?=
 =?utf-8?B?MEt4QUFhMTlPZTVML1VyM2JqczhpWHQvZmR0cHZWb3N2YzIzVDloamtWemhs?=
 =?utf-8?B?K3pRMG1xNFFUd013T2Z5NnUvS0J5d3F5WjJkeXQ5bWVPZDBoZFBKZ3RhZmxB?=
 =?utf-8?B?ZmtwOWx4VkVwNHN1WHVaWVpSVmdnZDlONGpBVTRqdnZsN1NjVFdmUVZPWEk5?=
 =?utf-8?B?WWRDQk1EM0xKemxkWi9XRGtQQUdGd1JRTE1TYmVZeXN0OURHK0J3OVh1WUIy?=
 =?utf-8?B?dDdhKzFFSDdrS1I3eFl4NmppVVVXY1hvbUJxS3FNZzJRSnZUWkRuaUFWbFNx?=
 =?utf-8?B?MVo2eW5uUkdubHVzcWxvRHczYjZiWU1sQ2dCTURwdVcxQUZhd1VMV0NWMHh5?=
 =?utf-8?B?cXcrb3l4NUtsYW1jSkFKUTM1NWNRVEloZjlEOUJCV256Nk1BZTUwcS9IQWls?=
 =?utf-8?B?WXFsejN1T0s3Y1NWb0NnaXoxUzR3N2hFM2pKaTB1WmduTm9QeFp5RzVHaGhT?=
 =?utf-8?B?YUVKTWd0N0lEOUt6aEdPaDd3amUyUS8xc3VxUzBNMncybFlBaFJjSEE5MTFL?=
 =?utf-8?B?UldoQ3RwUWpxTVNlaVg2M3JQUGt4NzBjZ2lIMnBlWlZFUWFtMnJ5U3h6TVlC?=
 =?utf-8?B?M3FsVElZTzgwbGIrSkI4ZGhtVXFJWFhsWGxGNitIOXJTc242bVNUNjdqUHNE?=
 =?utf-8?B?V1dHcU5SUmpodjBrajkrejZGMHhRalRYaDkzUUJXckNwQmw0bnViTnJFYndw?=
 =?utf-8?B?TjhEQVJCTlhrcVFuVC9Oa044VHVpNERnbzR0NEdJWTg5SXdJMDA2V0laSjFZ?=
 =?utf-8?B?NXY5d1paZnIxTVFOamo2YTNVOEtlczk2Y2I0eEJBTm5ieW8rVSt6ZTltVGlS?=
 =?utf-8?B?bVI2ZnpFSTlOZVFHYzFVMXZaVFM0MHVYa21PNk1oeGZ6UlJ5ODdlSjN5aCtl?=
 =?utf-8?B?RzN5K0t4NitCZ0FpMGRPaEdOaWJhS0lZalRqNXkrTXByUThOM1FIZHZ6UjJr?=
 =?utf-8?B?VnQ4cDUvc1ArU2t5NXJ5QjlqWUR3SWdabUJwZEQ0QXp0RDc1RWdxZ3dMYmZG?=
 =?utf-8?B?eUwzM2tQU0hqejJSeFJ3dm00ckV3L2hWMXRHZjNVOFZaMUQ1b2xSY2RyVXN2?=
 =?utf-8?B?UHAxa01EVU50UUN0SGdnMVE3WlZLZlhBK0lQTk1YaXVxR3ZzaVNhdnNwT0Zw?=
 =?utf-8?B?Y2ZMaitPSy9rREZPUXIxQjdlUDFPMmZKcXZQaFY1eEUxNGoxZ1B2MThhQVp4?=
 =?utf-8?B?dUFiZ2g1SzlZYlJnYTkvaGExY25EUE5hYWVRcjMvakxyMTBodEZ0VW1SVFVw?=
 =?utf-8?B?M3BzbmVBTmU5TE9vR1g1Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8599.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXhkTGZPYnRsN2FZRjZyYUNaZnVZKy91SUo4QXBCWEpWS29WSWxGa0ZPV2M2?=
 =?utf-8?B?YzNwaVJXdENoSXNyTUlGb2pOcjFOMDFpVDRXMSsyTU5SSG1FMmpkQmVkYy9r?=
 =?utf-8?B?a1h4SFlNQm9xOHJtVHJyUzFscTBCbTFQZS9YK3pML2s3WDNBQ3V0NWVFVlhy?=
 =?utf-8?B?ZldYbVVvVGlKeGpsRG9XSEV3SU9mT3lHSVBYeWNVc0JtVU11Y01FWEV6NFJT?=
 =?utf-8?B?UlgycTdwdTg0RjJNd3h2djlLdXRDbEVLRVdyNG9uZ2VGbjFMTUlJSEdmQXo5?=
 =?utf-8?B?WU14dE5CT1lVQ2xiUm8xQTJwM3V3WlpqNWk1RkdOb1kvc2lzOWtiOVEvNklQ?=
 =?utf-8?B?djVmWjJibGFSZlB1TUdBR2syNHUydmxwSmRMSStPRlZsemk3TWNvREVnR2g3?=
 =?utf-8?B?bE53cGdEYmpkcWE2R3VtMDlmR1Uxc2pYMGc4NTlHN0F2ZlBvb1dlbzZTeXFY?=
 =?utf-8?B?blJhdnZEWCs3ZjI5RG4zaEhHQjFlbFY4ekZuVmtsMHkxRjZEN1hEaGRQVTNH?=
 =?utf-8?B?dVNON2hsT3kwdTBVQ2dkN0syUXdsRzJtR3VlZ2dKTEZ5bWtlL0JhYkVCT2pE?=
 =?utf-8?B?TzFoUmpIZXdBb1lTa3VsV1FXUVc1WkZjZ0xFcGYvb3MyVkJuU2JmQ1M0bFhJ?=
 =?utf-8?B?elBVclNWcG1PUStHV093N0NJYTZvN3hhTjNOZmYrK0ZTWXpVaXJ5WDEybWtt?=
 =?utf-8?B?ZXBZdVdpOXRzVUhDcTVJc3puMldtQ0x4aUJuUElHWjFsMmNPSmE3T3FYaUV6?=
 =?utf-8?B?YlZ5VDFvVGJZWHRaODVkWU5XVmgyRTlJUXJoV3B3QWhTWWVXWDVFTm0rNXpF?=
 =?utf-8?B?Vmt1djMrelNrTFUvZzQvVGdnSjNHVUtPNmtVRHBUTWZXZ1hoalcxWUdzdW93?=
 =?utf-8?B?ckZaNDkyVnB3ejNVK3BVUkJ5Q0xCVU5DMEV1bXk1SWI1eVhnQkNra2wrSHZZ?=
 =?utf-8?B?RmpVVm9HS1gzOXhnelkxV0F2K1ZjbERWKzJ5cE5YVm9OYlN1cGFFV0hFelZt?=
 =?utf-8?B?eUdHb0tERS8zWUx6TWthcEo2cTJ6MzRWY0lOeGN0OHdHL3lHTU1pL0pVZG0v?=
 =?utf-8?B?REdSR2YwMmIxR0l3WWNFZld1TW0zbXp5TzJ3QWU5QzVEb0ZkSDdiNHNrTUFG?=
 =?utf-8?B?MktXVk8zbUR1UjVNcStQcGVPV3pOSEtqSmsxVXRJMUJFYkFobDZ2VmJOUytS?=
 =?utf-8?B?OHZyaXk0S1lEcVVOTmh4aHhFdTE1dXR4SHVvaVlWS29Iczl2THlyVGFSYUdF?=
 =?utf-8?B?U2c4VFFyWUJ0TXVRV2trajVIV3ZjSDQ5dTdwd09zL2cxK2dVQkp0ZlFYY2Ji?=
 =?utf-8?B?QnUrZGU4MTQwb0tSNG9EMEFRVDlCZnBCOGh5aUI5dE11aWY5Nmh3cFdUNkhs?=
 =?utf-8?B?STlnNDRncXJIUHlpdERyTkptcUpseFRML1FUYmhDV1E2c3o1QjR0dHlWZllI?=
 =?utf-8?B?cWh4Mjg5czRZbnVjaURraWR3YnFteVMyZG5WZ0l1NWdOWUR3bExRR3JKTUhi?=
 =?utf-8?B?Sml6NGdVQWg2N3E4WTZrSFJZVytwNnhBWnBnck04Ni81RkVmM2ZhNlJtUnRh?=
 =?utf-8?B?R3Jvbmw5WGtnbTZUc0ZDTzAydEF3b002cmVBZ0doZDJrQW4xU0FtMHhSNXhI?=
 =?utf-8?B?T3RXR2xWWDB2YTdaUnQ2YStpTi82U2FudEVyUDdUY2F1Q2gwT1pJTE92dWlI?=
 =?utf-8?B?WHhGRC84NXB1c1Y5aStqYWF6NWNyVmxnQno1emF0NlFoUS9USS8wV2FmRmJ4?=
 =?utf-8?B?Q01NRGQwalNMVVZ5YVVMUE1tNDVNWDNQVENTU2dFdjJobWlKdXVLV2xGQUZU?=
 =?utf-8?B?T1FsaEdMcFB3cEJGV1lZSWRDNFdEL3g2M3hETnZZYVVuTGZvMFgzU2NPNlNm?=
 =?utf-8?B?clkyMmVJWlRMSXFSak9vQlM3Wll0MWhKbWYwQm0ySUd6VmVEdWdQWElTcVJK?=
 =?utf-8?B?MDZWSERrRWVvVzgzd2hpang4U29tZzYzY3V3alRNRnJFSDZka0hocEZKcmYy?=
 =?utf-8?B?NkpPNzJGRVV1MEZzZ3hVU1FMTnJTWXdTUmlNOXJQTDJSZU0vekpRbEZEVUpp?=
 =?utf-8?B?U3BtRkwwdm9QbjBaYk5IZ1ErTWhXcHFZL0RGSXdwaGhIdlVUVmZ3SkFFYi9p?=
 =?utf-8?Q?8nenUqcK0errkY8VoaFUwXCUS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b91ca0-66f6-471c-3ac5-08dcedfee5bb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8599.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 16:23:41.2366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sd5rukU3jTREg9hPr6uQAwnX23SsUfkY+TqlJNOoJ30r4+c/lNWFFBOs+rLPXFNsge4z3T3fYqBd7g6GkVAHAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6884

NXP hardware IP(s) for secure-enclaves like Edgelock Enclave(ELE),
are embedded in the SoC to support the features like HSM, SHE & V2X,
using message based communication interface.

The secure enclave FW communicates on a dedicated messaging unit(MU)
based interface(s) with application core, where kernel is running.
It exists on specific i.MX processors. e.g. i.MX8ULP, i.MX93.

This patch adds the driver for communication interface to secure-enclave,
for exchanging messages with NXP secure enclave HW IP(s) like EdgeLock
Enclave (ELE) from Kernel-space, used by kernel management layers like
- DM-Crypt.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/firmware/imx/Kconfig        |  13 +
 drivers/firmware/imx/Makefile       |   2 +
 drivers/firmware/imx/ele_base_msg.c | 279 ++++++++++++++++++
 drivers/firmware/imx/ele_base_msg.h |  94 ++++++
 drivers/firmware/imx/ele_common.c   | 320 +++++++++++++++++++++
 drivers/firmware/imx/ele_common.h   |  51 ++++
 drivers/firmware/imx/se_ctrl.c      | 552 ++++++++++++++++++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h      |  94 ++++++
 include/linux/firmware/imx/se_api.h |  14 +
 9 files changed, 1419 insertions(+)

diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index 477d3f32d99a..ccd9f9e0652e 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -33,3 +33,16 @@ config IMX_SCMI_MISC_DRV
 	  core that could provide misc functions such as board control.
 
 	  This driver can also be built as a module.
+
+config IMX_SEC_ENCLAVE
+	tristate "i.MX Embedded Secure Enclave - EdgeLock Enclave Firmware driver."
+	depends on IMX_MBOX && ARCH_MXC && ARM64
+	select FW_LOADER
+	default m if ARCH_MXC
+
+	help
+	  It is possible to use APIs exposed by the iMX Secure Enclave HW IP called:
+	  - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
+	    like base, HSM, V2X & SHE using the SAB protocol via the shared Messaging
+	    Unit. This driver exposes these interfaces via a set of file descriptors
+	    allowing to configure shared memory, send and receive messages.
diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 8d046c341be8..4e1d2706535d 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -2,3 +2,5 @@
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
 obj-${CONFIG_IMX_SCMI_MISC_DRV}	+= sm-misc.o
+sec_enclave-objs		= se_ctrl.o ele_common.o ele_base_msg.o
+obj-${CONFIG_IMX_SEC_ENCLAVE}	+= sec_enclave.o
diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
new file mode 100644
index 000000000000..53c83eddd52a
--- /dev/null
+++ b/drivers/firmware/imx/ele_base_msg.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <linux/types.h>
+
+#include <linux/completion.h>
+#include <linux/dma-mapping.h>
+#include <linux/genalloc.h>
+
+#include "ele_base_msg.h"
+#include "ele_common.h"
+
+int ele_get_info(struct se_if_priv *priv, struct ele_dev_info *s_info)
+{
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	dma_addr_t get_info_addr = 0;
+	u32 *get_info_data = NULL;
+	int ret = 0;
+
+	if (!priv) {
+		ret = -EINVAL;
+		return ret;
+	}
+
+	memset(s_info, 0x0, sizeof(*s_info));
+
+	if (priv->mem_pool)
+		get_info_data = gen_pool_dma_alloc(priv->mem_pool,
+						   ELE_GET_INFO_BUFF_SZ,
+						   &get_info_addr);
+	else
+		get_info_data = dma_alloc_coherent(priv->dev,
+						   ELE_GET_INFO_BUFF_SZ,
+						   &get_info_addr,
+						   GFP_KERNEL);
+	if (!get_info_data) {
+		ret = -ENOMEM;
+		dev_dbg(priv->dev,
+			"%s: Failed to allocate get_info_addr.\n",
+			__func__);
+		return ret;
+	}
+
+	tx_msg = kzalloc(ELE_GET_INFO_REQ_MSG_SZ, GFP_KERNEL);
+	if (!tx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	rx_msg = kzalloc(ELE_GET_INFO_RSP_MSG_SZ, GFP_KERNEL);
+	if (!rx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				      (struct se_msg_hdr *)&tx_msg->header,
+				      ELE_GET_INFO_REQ,
+				      ELE_GET_INFO_REQ_MSG_SZ,
+				      true);
+	if (ret)
+		goto exit;
+
+	tx_msg->data[0] = upper_32_bits(get_info_addr);
+	tx_msg->data[1] = lower_32_bits(get_info_addr);
+	tx_msg->data[2] = sizeof(*s_info);
+	ret = ele_msg_send_rcv(priv,
+			       tx_msg,
+			       ELE_GET_INFO_REQ_MSG_SZ,
+			       rx_msg,
+			       ELE_GET_INFO_RSP_MSG_SZ);
+	if (ret < 0)
+		goto exit;
+
+	ret = se_val_rsp_hdr_n_status(priv,
+				      rx_msg,
+				      ELE_GET_INFO_REQ,
+				      ELE_GET_INFO_RSP_MSG_SZ,
+				      true);
+
+	memcpy(s_info, get_info_data, sizeof(*s_info));
+
+exit:
+	if (priv->mem_pool)
+		gen_pool_free(priv->mem_pool,
+			      (u64) get_info_data,
+			      ELE_GET_INFO_BUFF_SZ);
+	else
+		dma_free_coherent(priv->dev,
+				  ELE_GET_INFO_BUFF_SZ,
+				  get_info_data,
+				  get_info_addr);
+
+	return ret;
+}
+
+int ele_fetch_soc_info(struct se_if_priv *priv, u16 *soc_rev, u64 *serial_num)
+{
+	struct ele_dev_info s_info = {0};
+	int err;
+
+	err = ele_get_info(priv, &s_info);
+	if (err < 0)
+		return err;
+
+	if (soc_rev)
+		*soc_rev = s_info.d_info.soc_rev;
+	if (serial_num)
+		*serial_num = GET_SERIAL_NUM_FROM_UID(s_info.d_info.uid, MAX_UID_SIZE >> 2);
+
+	return err;
+}
+
+int ele_ping(struct se_if_priv *priv)
+{
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int ret = 0;
+
+	if (!priv) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	tx_msg = kzalloc(ELE_PING_REQ_SZ, GFP_KERNEL);
+	if (!tx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	rx_msg = kzalloc(ELE_PING_RSP_SZ, GFP_KERNEL);
+	if (!rx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				      (struct se_msg_hdr *)&tx_msg->header,
+				      ELE_PING_REQ, ELE_PING_REQ_SZ, true);
+	if (ret) {
+		dev_err(priv->dev, "Error: se_fill_cmd_msg_hdr failed.\n");
+		goto exit;
+	}
+
+	ret = ele_msg_send_rcv(priv,
+			       tx_msg,
+			       ELE_PING_REQ_SZ,
+			       rx_msg,
+			       ELE_PING_RSP_SZ);
+	if (ret < 0)
+		goto exit;
+
+	ret = se_val_rsp_hdr_n_status(priv,
+				      rx_msg,
+				      ELE_PING_REQ,
+				      ELE_PING_RSP_SZ,
+				      true);
+exit:
+	return ret;
+}
+
+int ele_service_swap(struct se_if_priv *priv,
+		     phys_addr_t addr,
+		     u32 addr_size, u16 flag)
+{
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int ret = 0;
+
+	if (!priv) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	tx_msg = kzalloc(ELE_SERVICE_SWAP_REQ_MSG_SZ, GFP_KERNEL);
+	if (!tx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	rx_msg = kzalloc(ELE_SERVICE_SWAP_RSP_MSG_SZ, GFP_KERNEL);
+	if (!rx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				      (struct se_msg_hdr *)&tx_msg->header,
+				      ELE_SERVICE_SWAP_REQ,
+				      ELE_SERVICE_SWAP_REQ_MSG_SZ, true);
+	if (ret)
+		goto exit;
+
+	tx_msg->data[0] = flag;
+	tx_msg->data[1] = addr_size;
+	tx_msg->data[2] = ELE_NONE_VAL;
+	tx_msg->data[3] = lower_32_bits(addr);
+	tx_msg->data[4] = se_add_msg_crc((uint32_t *)&tx_msg[0],
+						 ELE_SERVICE_SWAP_REQ_MSG_SZ);
+	ret = ele_msg_send_rcv(priv,
+			       tx_msg,
+			       ELE_SERVICE_SWAP_REQ_MSG_SZ,
+			       rx_msg,
+			       ELE_SERVICE_SWAP_RSP_MSG_SZ);
+	if (ret < 0)
+		goto exit;
+
+	ret = se_val_rsp_hdr_n_status(priv,
+				      rx_msg,
+				      ELE_SERVICE_SWAP_REQ,
+				      ELE_SERVICE_SWAP_RSP_MSG_SZ,
+				      true);
+	if (ret)
+		goto exit;
+
+	if (flag == ELE_IMEM_EXPORT)
+		ret = rx_msg->data[1];
+	else
+		ret = 0;
+
+exit:
+
+	return ret;
+}
+
+int ele_fw_authenticate(struct se_if_priv *priv, phys_addr_t addr)
+{
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int ret = 0;
+
+	if (!priv) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	tx_msg = kzalloc(ELE_FW_AUTH_REQ_SZ, GFP_KERNEL);
+	if (!tx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	rx_msg = kzalloc(ELE_FW_AUTH_RSP_MSG_SZ, GFP_KERNEL);
+	if (!rx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				  (struct se_msg_hdr *)&tx_msg->header,
+				  ELE_FW_AUTH_REQ,
+				  ELE_FW_AUTH_REQ_SZ,
+				  true);
+	if (ret)
+		goto exit;
+
+	tx_msg->data[1] = upper_32_bits(addr);
+	tx_msg->data[0] = lower_32_bits(addr);
+	tx_msg->data[2] = addr;
+
+	ret = ele_msg_send_rcv(priv,
+			       tx_msg,
+			       ELE_FW_AUTH_REQ_SZ,
+			       rx_msg,
+			       ELE_FW_AUTH_RSP_MSG_SZ);
+	if (ret < 0)
+		goto exit;
+
+	ret = se_val_rsp_hdr_n_status(priv,
+				      rx_msg,
+				      ELE_FW_AUTH_REQ,
+				      ELE_FW_AUTH_RSP_MSG_SZ,
+				      true);
+exit:
+	return ret;
+}
diff --git a/drivers/firmware/imx/ele_base_msg.h b/drivers/firmware/imx/ele_base_msg.h
new file mode 100644
index 000000000000..e390d35fc787
--- /dev/null
+++ b/drivers/firmware/imx/ele_base_msg.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ *
+ * Header file for the EdgeLock Enclave Base API(s).
+ */
+
+#ifndef ELE_BASE_MSG_H
+#define ELE_BASE_MSG_H
+
+#include <linux/device.h>
+#include <linux/types.h>
+
+#include "se_ctrl.h"
+
+#define ELE_NONE_VAL			0x0
+
+#define ELE_GET_INFO_REQ		0xDA
+#define ELE_GET_INFO_REQ_MSG_SZ		0x10
+#define ELE_GET_INFO_RSP_MSG_SZ		0x08
+
+#define SOC_ID_MASK			0x0000FFFF
+
+#define MAX_UID_SIZE                     (16)
+#define DEV_GETINFO_ROM_PATCH_SHA_SZ     (32)
+#define DEV_GETINFO_FW_SHA_SZ            (32)
+#define DEV_GETINFO_OEM_SRKH_SZ          (64)
+#define DEV_GETINFO_MIN_VER_MASK	0xFF
+#define DEV_GETINFO_MAJ_VER_MASK	0xFF00
+#define ELE_DEV_INFO_EXTRA_SZ		0x60
+
+struct dev_info {
+	uint8_t  cmd;
+	uint8_t  ver;
+	uint16_t length;
+	uint16_t soc_id;
+	uint16_t soc_rev;
+	uint16_t lmda_val;
+	uint8_t  ssm_state;
+	uint8_t  dev_atts_api_ver;
+	uint8_t  uid[MAX_UID_SIZE];
+	uint8_t  sha_rom_patch[DEV_GETINFO_ROM_PATCH_SHA_SZ];
+	uint8_t  sha_fw[DEV_GETINFO_FW_SHA_SZ];
+};
+
+struct dev_addn_info {
+	uint8_t  oem_srkh[DEV_GETINFO_OEM_SRKH_SZ];
+	uint8_t  trng_state;
+	uint8_t  csal_state;
+	uint8_t  imem_state;
+	uint8_t  reserved2;
+};
+
+struct ele_dev_info {
+	struct dev_info d_info;
+	struct dev_addn_info d_addn_info;
+};
+
+#define ELE_GET_INFO_BUFF_SZ		(sizeof(struct ele_dev_info) \
+						+ ELE_DEV_INFO_EXTRA_SZ)
+
+#define GET_SERIAL_NUM_FROM_UID(x, uid_word_sz) \
+	(((u64)(((u32 *)(x))[(uid_word_sz) - 1]) << 32) | ((u32 *)(x))[0])
+
+#define ELE_DEBUG_DUMP_REQ		0x21
+#define ELE_DEBUG_DUMP_RSP_SZ		0x14
+
+#define ELE_PING_REQ			0x01
+#define ELE_PING_REQ_SZ			0x04
+#define ELE_PING_RSP_SZ			0x08
+
+#define ELE_SERVICE_SWAP_REQ		0xDF
+#define ELE_SERVICE_SWAP_REQ_MSG_SZ	0x18
+#define ELE_SERVICE_SWAP_RSP_MSG_SZ	0x0C
+#define ELE_IMEM_SIZE			0x10000
+#define ELE_IMEM_STATE_OK		0xCA
+#define ELE_IMEM_STATE_BAD		0xFE
+#define ELE_IMEM_STATE_WORD		0x27
+#define ELE_IMEM_STATE_MASK		0x00ff0000
+#define ELE_IMEM_EXPORT			0x1
+#define ELE_IMEM_IMPORT			0x2
+
+#define ELE_FW_AUTH_REQ			0x02
+#define ELE_FW_AUTH_REQ_SZ		0x10
+#define ELE_FW_AUTH_RSP_MSG_SZ		0x08
+
+int ele_get_info(struct se_if_priv *priv, struct ele_dev_info *s_info);
+int ele_fetch_soc_info(struct se_if_priv *priv, u16 *soc_rev, u64 *serial_num);
+int ele_ping(struct se_if_priv *priv);
+int ele_service_swap(struct se_if_priv *priv,
+		     phys_addr_t addr,
+		     u32 addr_size, u16 flag);
+int ele_fw_authenticate(struct se_if_priv *priv, phys_addr_t addr);
+#endif
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
new file mode 100644
index 000000000000..f7c760bbc7a3
--- /dev/null
+++ b/drivers/firmware/imx/ele_common.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include "ele_base_msg.h"
+#include "ele_common.h"
+
+u32 se_add_msg_crc(u32 *msg, u32 msg_len)
+{
+	u32 nb_words = msg_len / (u32)sizeof(u32);
+	u32 crc = 0;
+	u32 i;
+
+	for (i = 0; i < nb_words - 1; i++)
+		crc ^= *(msg + i);
+
+	return crc;
+}
+
+int ele_msg_rcv(struct se_if_priv *priv,
+		struct se_clbk_handle *se_clbk_hdl)
+{
+	int err = 0;
+
+	do {
+		/* If callback is executed before entrying to wait state,
+		 * it will immediately come out after entering the wait state,
+		 * but completion_done(&se_clbk_hdl->done), will return false
+		 * after exiting the wait state, with err = 0.
+		 */
+		err = wait_for_completion_interruptible(&se_clbk_hdl->done);
+		if (err == -ERESTARTSYS) {
+			if (priv->waiting_rsp_clbk_hdl.rx_msg) {
+				priv->waiting_rsp_clbk_hdl.signal_rcvd = true;
+				continue;
+			}
+			dev_err(priv->dev,
+				"Err[0x%x]:Interrupted by signal.\n",
+				err);
+			err = -EINTR;
+			break;
+		}
+	} while (err != 0);
+
+	return err ? err : se_clbk_hdl->rx_msg_sz;
+}
+
+int ele_msg_send(struct se_if_priv *priv,
+		 void *tx_msg,
+		 int tx_msg_sz)
+{
+	struct se_msg_hdr *header;
+	int err;
+
+	header = tx_msg;
+
+	/*
+	 * Check that the size passed as argument matches the size
+	 * carried in the message.
+	 */
+	if (header->size << 2 != tx_msg_sz) {
+		err = -EINVAL;
+		dev_err(priv->dev,
+			"User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
+			*(u32 *)header,
+			header->size << 2, tx_msg_sz);
+		goto exit;
+	}
+
+	err = mbox_send_message(priv->tx_chan, tx_msg);
+	if (err < 0) {
+		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
+		return err;
+	}
+	err = tx_msg_sz;
+
+exit:
+	return err;
+}
+
+/* API used for send/receive blocking call. */
+int ele_msg_send_rcv(struct se_if_priv *priv,
+		     void *tx_msg,
+		     int tx_msg_sz,
+		     void *rx_msg,
+		     int exp_rx_msg_sz)
+{
+	int err;
+
+	guard(mutex)(&priv->se_if_cmd_lock);
+
+	priv->waiting_rsp_clbk_hdl.rx_msg_sz = exp_rx_msg_sz;
+	priv->waiting_rsp_clbk_hdl.rx_msg = rx_msg;
+
+	err = ele_msg_send(priv, tx_msg, tx_msg_sz);
+	if (err < 0)
+		goto exit;
+
+	err = ele_msg_rcv(priv, &priv->waiting_rsp_clbk_hdl);
+
+	if (priv->waiting_rsp_clbk_hdl.signal_rcvd) {
+		err = -EINTR;
+		priv->waiting_rsp_clbk_hdl.signal_rcvd = false;
+	}
+
+exit:
+	return err;
+}
+
+static bool exception_for_size(struct se_if_priv *priv,
+				struct se_msg_hdr *header)
+{
+	/* List of API(s) that can be accepte variable length
+	 * response buffer.
+	 */
+	if (header->command == ELE_DEBUG_DUMP_REQ &&
+		header->ver == priv->if_defs->base_api_ver &&
+		header->size >= 0 &&
+		header->size <= ELE_DEBUG_DUMP_RSP_SZ)
+		return true;
+
+	return false;
+}
+
+/*
+ * Callback called by mailbox FW, when data is received.
+ */
+void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
+{
+	struct se_clbk_handle *se_clbk_hdl;
+	struct device *dev = mbox_cl->dev;
+	struct se_msg_hdr *header;
+	struct se_if_priv *priv;
+	u32 rx_msg_sz;
+
+	priv = dev_get_drvdata(dev);
+
+	/* The function can be called with NULL msg */
+	if (!msg) {
+		dev_err(dev, "Message is invalid\n");
+		return;
+	}
+
+	header = msg;
+	rx_msg_sz = header->size << 2;
+
+	/* Incoming command: wake up the receiver if any. */
+	if (header->tag == priv->if_defs->cmd_tag) {
+		se_clbk_hdl = &priv->cmd_receiver_clbk_hdl;
+		dev_dbg(dev,
+			"Selecting cmd receiver for mesg header:0x%x.",
+			*(u32 *) header);
+
+		/* Pre-allocated buffer of MAX_NVM_MSG_LEN
+		 * as the NVM command are initiated by FW.
+		 * Size is revealed as part of this call function.
+		 */
+		if (rx_msg_sz > MAX_NVM_MSG_LEN) {
+			dev_err(dev,
+				"CMD-RCVER NVM: hdr(0x%x) with different sz(%d != %d).\n",
+				*(u32 *) header,
+				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
+
+			se_clbk_hdl->rx_msg_sz = MAX_NVM_MSG_LEN;
+		}
+		se_clbk_hdl->rx_msg_sz = rx_msg_sz;
+
+	} else if (header->tag == priv->if_defs->rsp_tag) {
+		se_clbk_hdl = &priv->waiting_rsp_clbk_hdl;
+		dev_dbg(dev,
+			"Selecting resp waiter for mesg header:0x%x.",
+			*(u32 *) header);
+
+		if (rx_msg_sz != se_clbk_hdl->rx_msg_sz
+				&& !exception_for_size(priv, header)) {
+			dev_err(dev,
+				"Rsp to CMD: hdr(0x%x) with different sz(%d != %d).\n",
+				*(u32 *) header,
+				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
+
+			se_clbk_hdl->rx_msg_sz = min(rx_msg_sz, se_clbk_hdl->rx_msg_sz);
+		}
+	} else {
+		dev_err(dev, "Failed to select a device for message: %.8x\n",
+			*((u32 *) header));
+		return;
+	}
+
+	memcpy(se_clbk_hdl->rx_msg, msg, se_clbk_hdl->rx_msg_sz);
+
+	/* Allow user to read */
+	complete(&se_clbk_hdl->done);
+}
+
+int se_val_rsp_hdr_n_status(struct se_if_priv *priv,
+			    struct se_api_msg *msg,
+			    uint8_t msg_id,
+			    uint8_t sz,
+			    bool is_base_api)
+{
+	u32 status;
+	struct se_msg_hdr *header = &msg->header;
+
+	if (header->tag != priv->if_defs->rsp_tag) {
+		dev_err(priv->dev,
+			"MSG[0x%x] Hdr: Resp tag mismatch. (0x%x != 0x%x)",
+			msg_id, header->tag, priv->if_defs->rsp_tag);
+		return -EINVAL;
+	}
+
+	if (header->command != msg_id) {
+		dev_err(priv->dev,
+			"MSG Header: Cmd id mismatch. (0x%x != 0x%x)",
+			header->command, msg_id);
+		return -EINVAL;
+	}
+
+	if (header->size != (sz >> 2)) {
+		dev_err(priv->dev,
+			"MSG[0x%x] Hdr: Cmd size mismatch. (0x%x != 0x%x)",
+			msg_id, header->size, (sz >> 2));
+		return -EINVAL;
+	}
+
+	if (is_base_api && (header->ver != priv->if_defs->base_api_ver)) {
+		dev_err(priv->dev,
+			"MSG[0x%x] Hdr: Base API Vers mismatch. (0x%x != 0x%x)",
+			msg_id, header->ver, priv->if_defs->base_api_ver);
+		return -EINVAL;
+	} else if (!is_base_api && header->ver != priv->if_defs->fw_api_ver) {
+		dev_err(priv->dev,
+			"MSG[0x%x] Hdr: FW API Vers mismatch. (0x%x != 0x%x)",
+			msg_id, header->ver, priv->if_defs->fw_api_ver);
+		return -EINVAL;
+	}
+
+	status = RES_STATUS(msg->data[0]);
+	if (status != priv->if_defs->success_tag) {
+		dev_err(priv->dev, "Command Id[%d], Response Failure = 0x%x",
+			header->command, status);
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+int se_save_imem_state(struct se_if_priv *priv, struct se_imem_buf *imem)
+{
+	int ret;
+
+	/* EXPORT command will save encrypted IMEM to given address,
+	 * so later in resume, IMEM can be restored from the given
+	 * address.
+	 *
+	 * Size must be at least 64 kB.
+	 */
+	ret = ele_service_swap(priv,
+			       imem->phyaddr,
+			       ELE_IMEM_SIZE,
+			       ELE_IMEM_EXPORT);
+	if (ret < 0)
+		dev_err(priv->dev, "Failed to export IMEM\n");
+	else
+		dev_info(priv->dev,
+			 "Exported %d bytes of encrypted IMEM\n",
+			 ret);
+
+	return ret;
+}
+
+int se_restore_imem_state(struct se_if_priv *priv, struct se_imem_buf *imem)
+{
+	struct ele_dev_info s_info;
+	int ret;
+
+	/* get info from ELE */
+	ret = ele_get_info(priv, &s_info);
+	if (ret) {
+		dev_err(priv->dev, "Failed to get info from ELE.\n");
+		return ret;
+	}
+	imem->state = s_info.d_addn_info.imem_state;
+
+	/* Get IMEM state, if 0xFE then import IMEM */
+	if (s_info.d_addn_info.imem_state == ELE_IMEM_STATE_BAD) {
+		/* IMPORT command will restore IMEM from the given
+		 * address, here size is the actual size returned by ELE
+		 * during the export operation
+		 */
+		ret = ele_service_swap(priv,
+				       imem->phyaddr,
+				       imem->size,
+				       ELE_IMEM_IMPORT);
+		if (ret) {
+			dev_err(priv->dev, "Failed to import IMEM\n");
+			goto exit;
+		}
+	} else
+		goto exit;
+
+	/* After importing IMEM, check if IMEM state is equal to 0xCA
+	 * to ensure IMEM is fully loaded and
+	 * ELE functionality can be used.
+	 */
+	ret = ele_get_info(priv, &s_info);
+	if (ret) {
+		dev_err(priv->dev, "Failed to get info from ELE.\n");
+		goto exit;
+	}
+	imem->state = s_info.d_addn_info.imem_state;
+
+	if (s_info.d_addn_info.imem_state == ELE_IMEM_STATE_OK)
+		dev_info(priv->dev, "Successfully restored IMEM\n");
+	else
+		dev_err(priv->dev, "Failed to restore IMEM\n");
+
+exit:
+	return ret;
+}
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
new file mode 100644
index 000000000000..3d8b6f83fb9d
--- /dev/null
+++ b/drivers/firmware/imx/ele_common.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+
+#ifndef __ELE_COMMON_H__
+#define __ELE_COMMON_H__
+
+#include "se_ctrl.h"
+
+#define ELE_SUCCESS_IND			0xD6
+
+#define IMX_ELE_FW_DIR                 "imx/ele/"
+
+uint32_t se_add_msg_crc(uint32_t *msg, uint32_t msg_len);
+int ele_msg_rcv(struct se_if_priv *priv,
+		struct se_clbk_handle *se_clbk_hdl);
+int ele_msg_send(struct se_if_priv *priv,
+		 void *tx_msg,
+		 int tx_msg_sz);
+int ele_msg_send_rcv(struct se_if_priv *priv,
+		     void *tx_msg,
+		     int tx_msg_sz,
+		     void *rx_msg,
+		     int exp_rx_msg_sz);
+void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg);
+int se_val_rsp_hdr_n_status(struct se_if_priv *priv,
+			    struct se_api_msg *msg,
+			    uint8_t msg_id,
+			    uint8_t sz,
+			    bool is_base_api);
+
+/* Fill a command message header with a given command ID and length in bytes. */
+static inline int se_fill_cmd_msg_hdr(struct se_if_priv *priv,
+				      struct se_msg_hdr *hdr,
+				      u8 cmd, u32 len,
+				      bool is_base_api)
+{
+	hdr->tag = priv->if_defs->cmd_tag;
+	hdr->ver = (is_base_api) ? priv->if_defs->base_api_ver : priv->if_defs->fw_api_ver;
+	hdr->command = cmd;
+	hdr->size = len >> 2;
+
+	return 0;
+}
+
+int se_save_imem_state(struct se_if_priv *priv, struct se_imem_buf *imem);
+int se_restore_imem_state(struct se_if_priv *priv, struct se_imem_buf *imem);
+
+#endif /*__ELE_COMMON_H__ */
diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
new file mode 100644
index 000000000000..40d815d0ac9b
--- /dev/null
+++ b/drivers/firmware/imx/se_ctrl.c
@@ -0,0 +1,552 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/firmware.h>
+#include <linux/firmware/imx/se_api.h>
+#include <linux/genalloc.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/miscdevice.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/sys_soc.h>
+
+#include "ele_base_msg.h"
+#include "ele_common.h"
+#include "se_ctrl.h"
+
+#define MBOX_TX_NAME			"tx"
+#define MBOX_RX_NAME			"rx"
+#define SE_TYPE_HSM			"hsm"
+
+struct se_fw_load_info {
+	const u8 *prim_fw_nm_in_rfs;
+	const u8 *seco_fw_nm_in_rfs;
+	struct mutex se_fw_load;
+	bool is_fw_loaded;
+	bool handle_susp_resm;
+	struct se_imem_buf imem;
+};
+
+struct se_if_node_info {
+	u8 se_if_id;
+	u8 se_if_did;
+	struct se_if_defines if_defs;
+	u8 *se_name;
+	u8 *pool_name;
+	bool soc_register;
+	bool reserved_dma_ranges;
+	int (*se_fetch_soc_info)(struct se_if_priv *priv, u16 *soc_rev, u64 *serial_num);
+};
+
+struct se_if_node_info_list {
+	const u8 num_mu;
+	const u16 soc_id;
+	struct se_fw_load_info load_hsm_fw;
+	const struct se_if_node_info info[];
+};
+
+static u16 se_soc_rev;
+static struct se_if_node_info_list imx8ulp_info = {
+	.num_mu = 1,
+	.soc_id = SOC_ID_OF_IMX8ULP,
+	.load_hsm_fw = {
+		.prim_fw_nm_in_rfs = IMX_ELE_FW_DIR
+			"mx8ulpa2-ahab-container.img",
+		.seco_fw_nm_in_rfs = IMX_ELE_FW_DIR
+			"mx8ulpa2ext-ahab-container.img",
+		.is_fw_loaded = false,
+		.handle_susp_resm = true,
+		.imem = {
+			.state = ELE_IMEM_STATE_OK,
+		},
+	},
+	.info = {
+			{
+			.se_if_id = 0,
+			.se_if_did = 7,
+			.if_defs = {
+				.cmd_tag = 0x17,
+				.rsp_tag = 0xe1,
+				.success_tag = ELE_SUCCESS_IND,
+				.base_api_ver = MESSAGING_VERSION_6,
+				.fw_api_ver = MESSAGING_VERSION_7,
+			},
+			.se_name = SE_TYPE_HSM"1",
+			.pool_name = "sram",
+			.soc_register = true,
+			.reserved_dma_ranges = true,
+			.se_fetch_soc_info = ele_fetch_soc_info,
+			},
+	},
+};
+
+static struct se_if_node_info_list imx93_info = {
+	.num_mu = 1,
+	.soc_id = SOC_ID_OF_IMX93,
+	.load_hsm_fw = {
+		.prim_fw_nm_in_rfs = NULL,
+		.seco_fw_nm_in_rfs = NULL,
+		.is_fw_loaded = true,
+		.handle_susp_resm = false,
+	},
+	.info = {
+			{
+			.se_if_id = 2,
+			.se_if_did = 3,
+			.if_defs = {
+				.cmd_tag = 0x17,
+				.rsp_tag = 0xe1,
+				.success_tag = ELE_SUCCESS_IND,
+				.base_api_ver = MESSAGING_VERSION_6,
+				.fw_api_ver = MESSAGING_VERSION_7,
+			},
+			.se_name = SE_TYPE_HSM"1",
+			.reserved_dma_ranges = true,
+			.soc_register = true,
+			},
+	},
+};
+
+static const struct of_device_id se_match[] = {
+	{ .compatible = "fsl,imx8ulp-se", .data = (void *)&imx8ulp_info},
+	{ .compatible = "fsl,imx93-se", .data = (void *)&imx93_info},
+	{},
+};
+
+static const struct se_if_node_info
+	*get_se_if_node_info(const struct se_if_node_info_list *info_list,
+			     const u32 idx)
+{
+	return &info_list->info[idx];
+}
+
+static int se_soc_info(struct se_if_priv *priv)
+{
+	const struct se_if_node_info *info;
+	struct se_if_node_info_list *info_list;
+	struct soc_device_attribute *attr;
+	struct soc_device *sdev;
+	u64 serial_num;
+	int err = 0;
+
+	info = container_of(priv->if_defs,
+			typeof(*info),
+			if_defs);
+	info_list = container_of(info,
+			typeof(*info_list),
+			info[info->se_if_id]);
+
+	/* This function should be called once.
+	 * Check if the se_soc_rev is zero to continue.
+	 */
+	if (se_soc_rev)
+		return err;
+
+	if (info->se_fetch_soc_info) {
+		err = info->se_fetch_soc_info(priv, &se_soc_rev, &serial_num);
+		if (err < 0) {
+			dev_err(priv->dev, "Failed to fetch SoC Info.");
+			return err;
+		}
+	} else {
+		dev_err(priv->dev, "Failed to fetch SoC revision.");
+		if (info->soc_register)
+			dev_err(priv->dev, "Failed to do SoC registration.");
+		err = -EINVAL;
+		return err;
+	}
+
+	if (!info->soc_register)
+		return 0;
+
+	attr = devm_kzalloc(priv->dev, sizeof(*attr), GFP_KERNEL);
+	if (!attr)
+		return -ENOMEM;
+
+	if (FIELD_GET(DEV_GETINFO_MIN_VER_MASK, se_soc_rev))
+		attr->revision = devm_kasprintf(priv->dev, GFP_KERNEL, "%x.%x",
+						FIELD_GET(DEV_GETINFO_MIN_VER_MASK,
+							  se_soc_rev),
+						FIELD_GET(DEV_GETINFO_MAJ_VER_MASK,
+							  se_soc_rev));
+	else
+		attr->revision = devm_kasprintf(priv->dev, GFP_KERNEL, "%x",
+						FIELD_GET(DEV_GETINFO_MAJ_VER_MASK,
+							  se_soc_rev));
+
+	switch (info_list->soc_id) {
+	case SOC_ID_OF_IMX8ULP:
+		attr->soc_id = devm_kasprintf(priv->dev, GFP_KERNEL,
+					      "i.MX8ULP");
+		break;
+	case SOC_ID_OF_IMX93:
+		attr->soc_id = devm_kasprintf(priv->dev, GFP_KERNEL,
+					      "i.MX93");
+		break;
+	}
+
+	err = of_property_read_string(of_root, "model",
+				      &attr->machine);
+	if (err)
+		return -EINVAL;
+
+	attr->family = devm_kasprintf(priv->dev, GFP_KERNEL, "Freescale i.MX");
+
+	attr->serial_number
+		= devm_kasprintf(priv->dev, GFP_KERNEL, "%016llX", serial_num);
+
+	sdev = soc_device_register(attr);
+	if (IS_ERR(sdev))
+		return PTR_ERR(sdev);
+
+	return 0;
+}
+
+static struct se_fw_load_info *get_load_fw_instance(struct se_if_priv *priv)
+{
+	const struct se_if_node_info *info = container_of(priv->if_defs,
+							typeof(*info),
+							if_defs);
+	struct se_if_node_info_list *info_list;
+	struct se_fw_load_info *load_fw = NULL;
+
+	info_list = container_of(info,
+			typeof(*info_list),
+			info[info->se_if_id]);
+
+	if (!memcmp(SE_TYPE_HSM, info->se_name, strlen(SE_TYPE_HSM)))
+		load_fw = &info_list->load_hsm_fw;
+	else
+		dev_err(priv->dev, "Invalid load fw configuration.");
+
+	return load_fw;
+}
+
+static int se_load_firmware(struct se_if_priv *priv)
+{
+	struct se_fw_load_info *load_fw = get_load_fw_instance(priv);
+	const struct firmware *fw;
+	phys_addr_t se_fw_phyaddr;
+	const u8 *se_img_file_to_load;
+	u8 *se_fw_buf;
+	int ret;
+
+	guard(mutex)(&load_fw->se_fw_load);
+	if (load_fw->is_fw_loaded)
+		return 0;
+
+	se_img_file_to_load = load_fw->seco_fw_nm_in_rfs;
+	if (load_fw->prim_fw_nm_in_rfs) {
+		/* allocate buffer where SE store encrypted IMEM */
+		load_fw->imem.buf = dmam_alloc_coherent(priv->dev, ELE_IMEM_SIZE,
+							&load_fw->imem.phyaddr,
+							GFP_KERNEL);
+		if (!load_fw->imem.buf) {
+			dev_err(priv->dev,
+				"dmam-alloc-failed: To store encr-IMEM.\n");
+			ret = -ENOMEM;
+			goto exit;
+		}
+		if (load_fw->imem.state == ELE_IMEM_STATE_BAD)
+			se_img_file_to_load
+					= load_fw->prim_fw_nm_in_rfs;
+	}
+
+	do {
+		ret = request_firmware(&fw, se_img_file_to_load, priv->dev);
+		if (ret)
+			goto exit;
+
+		dev_info(priv->dev, "loading firmware %s\n", se_img_file_to_load);
+
+		/* allocate buffer to store the SE FW */
+		se_fw_buf = dma_alloc_coherent(priv->dev, fw->size,
+				&se_fw_phyaddr, GFP_KERNEL);
+		if (!se_fw_buf) {
+			ret = -ENOMEM;
+			goto exit;
+		}
+
+		memcpy(se_fw_buf, fw->data, fw->size);
+		ret = ele_fw_authenticate(priv, se_fw_phyaddr);
+		if (ret < 0) {
+			dev_err(priv->dev,
+					"Error %pe: Authenticate & load SE firmware %s.\n",
+					ERR_PTR(ret),
+					se_img_file_to_load);
+			ret = -EPERM;
+		}
+
+		dma_free_coherent(priv->dev,
+				  fw->size,
+				  se_fw_buf,
+				  se_fw_phyaddr);
+
+		release_firmware(fw);
+
+		if (!ret && load_fw->imem.state == ELE_IMEM_STATE_BAD &&
+				se_img_file_to_load == load_fw->prim_fw_nm_in_rfs)
+			se_img_file_to_load = load_fw->seco_fw_nm_in_rfs;
+		else
+			se_img_file_to_load = NULL;
+
+	} while (se_img_file_to_load);
+
+	if (!ret)
+		load_fw->is_fw_loaded = true;
+
+exit:
+	return ret;
+}
+
+/* interface for managed res to free a mailbox channel */
+static void if_mbox_free_channel(void *mbox_chan)
+{
+	mbox_free_channel(mbox_chan);
+}
+
+static int se_if_request_channel(struct device *dev,
+				 struct mbox_chan **chan,
+				 struct mbox_client *cl,
+				 const char *name)
+{
+	struct mbox_chan *t_chan;
+	int ret = 0;
+
+	t_chan = mbox_request_channel_byname(cl, name);
+	if (IS_ERR(t_chan)) {
+		ret = PTR_ERR(t_chan);
+		return dev_err_probe(dev, ret,
+				     "Failed to request %s channel.", name);
+	}
+
+	ret = devm_add_action(dev, if_mbox_free_channel, t_chan);
+	if (ret) {
+		dev_err(dev, "failed to add devm removal of mbox %s\n", name);
+		goto exit;
+	}
+
+	*chan = t_chan;
+
+exit:
+	return ret;
+}
+
+static void se_if_probe_cleanup(void *plat_dev)
+{
+	struct platform_device *pdev = plat_dev;
+	struct device *dev = &pdev->dev;
+	struct se_fw_load_info *load_fw;
+	struct se_if_priv *priv;
+
+	priv = dev_get_drvdata(dev);
+	load_fw = get_load_fw_instance(priv);
+
+	/* In se_if_request_channel(), passed the clean-up functional
+	 * pointer reference as action to devm_add_action().
+	 * No need to free the mbox channels here.
+	 */
+
+	/* free the buffer in se remove, previously allocated
+	 * in se probe to store encrypted IMEM
+	 */
+	if (load_fw && load_fw->imem.buf) {
+		dmam_free_coherent(dev,
+				   ELE_IMEM_SIZE,
+				   load_fw->imem.buf,
+				   load_fw->imem.phyaddr);
+		load_fw->imem.buf = NULL;
+	}
+
+	/* No need to check, if reserved memory is allocated
+	 * before calling for its release. Or clearing the
+	 * un-set bit.
+	 */
+	of_reserved_mem_device_release(dev);
+}
+
+static int se_if_probe(struct platform_device *pdev)
+{
+	const struct se_if_node_info_list *info_list;
+	const struct se_if_node_info *info;
+	struct device *dev = &pdev->dev;
+	struct se_fw_load_info *load_fw;
+	struct se_if_priv *priv;
+	u32 idx;
+	int ret;
+
+	idx = GET_IDX_FROM_DEV_NODE_NAME(dev->of_node);
+	info_list = device_get_match_data(dev);
+	if (idx >= info_list->num_mu) {
+		dev_err(dev,
+			"Incorrect node name :%s\n",
+			dev->of_node->full_name);
+		dev_err(dev,
+			"%s-<index>, acceptable index range is 0..%d\n",
+			dev->of_node->name,
+			info_list->num_mu - 1);
+		ret = -EINVAL;
+		return ret;
+	}
+
+	info = get_se_if_node_info(info_list, idx);
+	if (!info) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	priv->dev = dev;
+	priv->if_defs = &info->if_defs;
+	dev_set_drvdata(dev, priv);
+
+	ret = devm_add_action(dev, se_if_probe_cleanup, pdev);
+	if (ret)
+		goto exit;
+
+
+	/* Mailbox client configuration */
+	priv->se_mb_cl.dev		= dev;
+	priv->se_mb_cl.tx_block		= false;
+	priv->se_mb_cl.knows_txdone	= true;
+	priv->se_mb_cl.rx_callback	= se_if_rx_callback;
+
+	ret = se_if_request_channel(dev, &priv->tx_chan,
+			&priv->se_mb_cl, MBOX_TX_NAME);
+	if (ret)
+		goto exit;
+
+	ret = se_if_request_channel(dev, &priv->rx_chan,
+			&priv->se_mb_cl, MBOX_RX_NAME);
+	if (ret)
+		goto exit;
+
+	mutex_init(&priv->se_if_cmd_lock);
+
+	init_completion(&priv->waiting_rsp_clbk_hdl.done);
+	init_completion(&priv->cmd_receiver_clbk_hdl.done);
+
+	if (info->pool_name) {
+		priv->mem_pool = of_gen_pool_get(dev->of_node,
+							 info->pool_name, 0);
+		if (!priv->mem_pool) {
+			dev_err(dev,
+				"Unable to get sram pool = %s\n",
+				info->pool_name);
+			goto exit;
+		}
+	}
+
+	if (info->reserved_dma_ranges) {
+		ret = of_reserved_mem_device_init(dev);
+		if (ret) {
+			dev_err(dev,
+				"failed to init reserved memory region %d\n",
+				ret);
+			goto exit;
+		}
+	}
+
+	ret = se_soc_info(priv);
+	if (ret) {
+		dev_err(dev,
+			"failed[%pe] to fetch SoC Info\n", ERR_PTR(ret));
+		goto exit;
+	}
+
+	load_fw = get_load_fw_instance(priv);
+	/* By default, there is no pending FW to be loaded.*/
+	if (load_fw->is_fw_loaded) {
+		mutex_init(&load_fw->se_fw_load);
+		ret = se_load_firmware(priv);
+		if (ret)
+			dev_warn(dev, "Failed to load firmware.");
+		ret = 0;
+	}
+	dev_info(dev, "i.MX secure-enclave: %s interface to firmware, configured.\n",
+		 info->se_name);
+	return ret;
+
+exit:
+	/* if execution control reaches here, if probe fails.
+	 */
+	return dev_err_probe(dev, ret, "%s: Probe failed.", __func__);
+
+	return ret;
+}
+
+static void se_if_remove(struct platform_device *pdev)
+{
+	se_if_probe_cleanup(pdev);
+}
+
+static int se_suspend(struct device *dev)
+{
+	struct se_if_priv *priv = dev_get_drvdata(dev);
+	struct se_fw_load_info *load_fw;
+	int ret = 0;
+
+	load_fw = get_load_fw_instance(priv);
+
+	if (load_fw->handle_susp_resm) {
+		ret = se_save_imem_state(priv, &load_fw->imem);
+		if (ret < 0)
+			goto exit;
+		load_fw->imem.size = ret;
+	}
+exit:
+	return ret;
+}
+
+static int se_resume(struct device *dev)
+{
+	struct se_if_priv *priv = dev_get_drvdata(dev);
+	struct se_fw_load_info *load_fw;
+
+	load_fw = get_load_fw_instance(priv);
+
+	if (load_fw->handle_susp_resm)
+		se_restore_imem_state(priv, &load_fw->imem);
+
+	return 0;
+}
+
+static const struct dev_pm_ops se_pm = {
+	RUNTIME_PM_OPS(se_suspend, se_resume, NULL)
+};
+
+static struct platform_driver se_driver = {
+	.driver = {
+		.name = "fsl-se-fw",
+		.of_match_table = se_match,
+		.pm = &se_pm,
+	},
+	.probe = se_if_probe,
+	.remove = se_if_remove,
+};
+MODULE_DEVICE_TABLE(of, se_match);
+
+module_platform_driver(se_driver);
+MODULE_AUTHOR("Pankaj Gupta <pankaj.gupta@nxp.com>");
+MODULE_DESCRIPTION("iMX Secure Enclave Driver.");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
new file mode 100644
index 000000000000..de0d4a1bcb9e
--- /dev/null
+++ b/drivers/firmware/imx/se_ctrl.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef SE_MU_H
+#define SE_MU_H
+
+#include <linux/miscdevice.h>
+#include <linux/semaphore.h>
+#include <linux/mailbox_client.h>
+
+#define MAX_FW_LOAD_RETRIES		50
+
+#define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
+#define MAX_NVM_MSG_LEN			(256)
+#define MESSAGING_VERSION_6		0x6
+#define MESSAGING_VERSION_7		0x7
+#define NODE_NAME			"secure-enclave"
+
+#define GET_ASCII_TO_U8(diff, tens_chr, ones_chr) \
+		((diff > 2) ? (((tens_chr - '0') * 10) + (ones_chr - '0')) :\
+		(tens_chr - '0'))
+
+#define GET_IDX_FROM_DEV_NODE_NAME(dev_of_node) \
+		((strlen(dev_of_node->full_name) > strlen(NODE_NAME)) ?\
+		GET_ASCII_TO_U8((strlen(dev_of_node->full_name) - strlen(NODE_NAME)),\
+				dev_of_node->full_name[strlen(NODE_NAME) + 1], \
+				dev_of_node->full_name[strlen(NODE_NAME) + 2]) : 0)
+
+struct se_clbk_handle {
+	struct completion done;
+	bool signal_rcvd;
+	atomic_t pending_hdr;
+	u32 rx_msg_sz;
+	/* Assignment of the rx_msg buffer to held till the
+	 * received content as part callback function, is copied.
+	 */
+	struct se_api_msg *rx_msg;
+};
+
+struct se_imem_buf {
+	u8 *buf;
+	phys_addr_t phyaddr;
+	u32 size;
+	u32 state;
+};
+
+/* Header of the messages exchange with the EdgeLock Enclave */
+struct se_msg_hdr {
+	u8 ver;
+	u8 size;
+	u8 command;
+	u8 tag;
+}  __packed;
+
+#define SE_MU_HDR_SZ	4
+
+struct se_api_msg {
+	struct se_msg_hdr header;
+	u32 data[];
+};
+
+struct se_if_defines {
+	const void *info;
+	u8 cmd_tag;
+	u8 rsp_tag;
+	u8 success_tag;
+	u8 base_api_ver;
+	u8 fw_api_ver;
+};
+
+struct se_if_priv {
+	struct device *dev;
+
+	struct se_clbk_handle cmd_receiver_clbk_hdl;
+	/* Update to the waiting_rsp_dev, to be protected
+	 * under se_if_cmd_lock.
+	 */
+	struct se_clbk_handle waiting_rsp_clbk_hdl;
+	/*
+	 * prevent new command to be sent on the se interface while previous
+	 * command is still processing. (response is awaited)
+	 */
+	struct mutex se_if_cmd_lock;
+
+	struct mbox_client se_mb_cl;
+	struct mbox_chan *tx_chan, *rx_chan;
+
+	struct gen_pool *mem_pool;
+	const struct se_if_defines *if_defs;
+};
+
+#endif
diff --git a/include/linux/firmware/imx/se_api.h b/include/linux/firmware/imx/se_api.h
new file mode 100644
index 000000000000..c47f84906837
--- /dev/null
+++ b/include/linux/firmware/imx/se_api.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef __SE_API_H__
+#define __SE_API_H__
+
+#include <linux/types.h>
+
+#define SOC_ID_OF_IMX8ULP		0x084D
+#define SOC_ID_OF_IMX93			0x9300
+
+#endif /* __SE_API_H__ */

-- 
2.34.1


