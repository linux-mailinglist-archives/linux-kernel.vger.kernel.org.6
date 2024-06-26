Return-Path: <linux-kernel+bounces-230283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF76917AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21EB1F226F1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9177A166305;
	Wed, 26 Jun 2024 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PzXEnvrX"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2086.outbound.protection.outlook.com [40.107.247.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A14316132F;
	Wed, 26 Jun 2024 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719390193; cv=fail; b=mu8+HSYyyIV1CCWtPJOgWj1sGoottLB6G+LmMUaMksu8e9jiZDPaNZI6tIUA6NOohDEwkfoEB7/dmJ7FEMdEQBaWdnnURgTxksKwxS6PwWRSUKCdqrupyDArB7qbNZsHh/aJa0vyCJ2/Qubcpl2H+hMGwKvtk6CQzfrJMi9tV30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719390193; c=relaxed/simple;
	bh=PBaQgom4hhP0Jm1WJp5SsivQ1tvMebjWAaIvpmiTjmo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mr6avap4Gcq9nzyr5Qg3hSH2PxzkpQyTw1+jnG8T9Umc2KbOk5ek9IU5t+g0UT9c8xcrykS9EWtqTknOlTcilEm7LQ0A55IvDZkbOjP9aP0SdZH5skibPxfUaT4+ARO5e25WqPg6eLAuXpq5GwlFOh+2xzwZB2E7Z0EJ6+vmb1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PzXEnvrX; arc=fail smtp.client-ip=40.107.247.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKrZM/RgqKdtAzA4zDpXzrXinnzhCNHpzberPfHAzzN41uTErQrpZBy+JgMbqtT+iMLbpYTBM1GZRR1f7iz1gbHkNVvA5syqir3JMvnqfEaiIgmBOz2KRM3DTsFXsWqJ9HJUF7XD7/eOS4MXJ7hh5JFwukL97ABgJIwiBu00dz88/9EREZuK5a+uiqJaiVatvcgUa0d1QzJvbOGZ3Lj7yOkbO/U8qQkyEM8pHx9AtI7DGjHRM3qwqEgDIQE73s8hC4O3Tbp28M2XzyLxzUyk+d62YYEQp56pH8MVnQPWACgbqpUytoIqOowGmgiRerfxc5oFzCGfFDt03pNSERLJrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1w24MO4Kud+pPzTCesnFiDmBPLYy/1K1/ITNGSRDvq0=;
 b=cpmJCP84dO691vewNIDjl6C8qrIjlkZh9tk/uEe6uTEp72x8yX84iy+wrfu1qvymnJZ5S3bAmPbRYmiwxlyeJh7UVC0hYgt4/82/SxxYZWKkftlqBlg6+wpWUQtlZLWaQppr12xYBFoqdal5OBjbjRREb4IMYkHbebqP3MdVogdGVzhZKhwhxm4vgmyYvJLWREYcVT6UGcUqlcSOoDtCju3OvbboDEnEZnjR8guTuK1QvJ4F9TE29PZRgfqFYIY5klusfzoi9I+tqjwNKDoVxfuhLfEFDVVT2gV3NBMnwYXuQh073Ky4fklh6arH0UPA2pmv+7B0+BGFB/NTG5IBbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w24MO4Kud+pPzTCesnFiDmBPLYy/1K1/ITNGSRDvq0=;
 b=PzXEnvrXjhRSsQXysXbrtei7BBbUQQjCIzG49zrrcTkrLwtWCXwV+DAsCqEh6IaV/oZdr9GJsFvR054LVn4hmdx161wYdN/PzR0DpKcPanKJhQerkGPXe+b72DujYG3oD6e4l/GFpr3XyN5UTA/y45budhbgI1QhnGUR4xekj1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by VI1PR04MB7165.eurprd04.prod.outlook.com (2603:10a6:800:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 08:23:09 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 08:23:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 26 Jun 2024 16:32:10 +0800
Subject: [PATCH v2 1/2] firmware: arm_scmi: channel unavailable if no
 of_node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-scmi-driver-v2-1-8f2f85b87760@nxp.com>
References: <20240626-scmi-driver-v2-0-8f2f85b87760@nxp.com>
In-Reply-To: <20240626-scmi-driver-v2-0-8f2f85b87760@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719390738; l=2478;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=vLoegjaeZFFvt5cDFq6+YDnpF19TDeAzyy/09HgfzAI=;
 b=pkQyuSlOeKS8jKrpZUkqdRZyiIj56iuY9tMaTVxMd+snsKg+WfTN6UH9Ym3zhGpSq4qD1SK8+
 rSPVhH8p4ooBhS2Ppgm2FG1pgycmYAULvhwnjqG5Dgi9iGP7oZQveB5
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGBP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::27)
 To AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|VI1PR04MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf34084-cf60-41fb-5c7d-08dc95b93621
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3NxVDUxM1prWkU5KzdLb0hNem9iWkRyMUJlVm9MSC8yU01BeHIxMkJpWVBt?=
 =?utf-8?B?b2d3Qk9EZ3pIQStPM0lNbGl3QTFPVjNXaFNxcFVyWlVWeHRVTVdxZEF3Y0hF?=
 =?utf-8?B?UXZHT3dXKzU0MHhuZDdlRkoyTUtJekZsT1BsWFhEdm1taFBHNXhaSnI0WURP?=
 =?utf-8?B?b1FGU01mOVFDMDBvd0ZJMktNM2xhMGRmT0RCWXB1V01MdEpSVHMyMUtWb01O?=
 =?utf-8?B?MHozRTB4UnNRUGRvREFOSHBuNWFuQk9yRXo0RlQ2S2lxU0NyQW5YeGdMYSs5?=
 =?utf-8?B?T2tJRERXUGFFWVJUNFBQTWVDdmhSVS9iQjg4M00raFFvUWhaOWlPK0E5c0Jk?=
 =?utf-8?B?ZGRyTzIwWlZQZ0RoeG1NZHpCVDB5MVI3NlluKzZiOVY3OExJdkJEYjFkeXVH?=
 =?utf-8?B?azEyek9MbENYcXd4bUREcTFaOXFsSGY1R0pPQmRNVHFMZnoyVGkwRldlOHJY?=
 =?utf-8?B?MFNrM2VFamoySkJ0UnBOL0lLNk9BckVEeFhXSWdKNjdIdWYvcVRYbGdqbkFp?=
 =?utf-8?B?emlKMjJFSGkzOHJXN0F2cWU2WGpDMUFQMHF3NEp6TGh5dEdmbktXZk8zUDdS?=
 =?utf-8?B?eDNZUXgrR0VSOGwzZUJTZUhQbnUwYTllU0JYT1NMbDI5VkI1MzdtQW52QVlM?=
 =?utf-8?B?MjMrZnpNM0o0b0xndnQ3S0VrZTBrQmp2L21HNkV5RG1LeEorbGZic1gwQkxt?=
 =?utf-8?B?NENYRzZBV0pIb3NaRWZLUnpBYXZacThVbkQvYngzMWwzYW5ZTUE4TmkwZ2V4?=
 =?utf-8?B?MXhMVjNuY3RuN0xKREE4SVFWbHZybmVXOHZwOFNkUTVTckpudGlMM29VMGJi?=
 =?utf-8?B?azQxOWROY0kvQnJxZUpxWGpaQ2RzWWd6YXpLNGd0QTFaa0Vsa2VmNDZZSVhE?=
 =?utf-8?B?RmZYYjB4N0FSMFVSckJWMU1sMGptZlBnU3dCc2ZpakNmRHJRaVhxd0NUNjdj?=
 =?utf-8?B?dnE4Tk1QOEpsdlVwdVBDcDR5UUQvYklFZE9HL0tEWlMvOEZIaXVVUGJ4aklM?=
 =?utf-8?B?dUVnUWdoa2QrNEg0MGpNOE5iUENYR05iUnAzWjZJekVpckVkZHZpMlFWeTFE?=
 =?utf-8?B?SDF6MStXZFBYUVR4TmVsRTk1cGZudGMxaUpOQklOYVU5NjlxMVhrY09JczlD?=
 =?utf-8?B?emozOFlkQ3hyRHlrZFdmWWYzZUlUbGhqbHAwQmVOU1pNNmVtM1M3NmpjVGlG?=
 =?utf-8?B?UTVSVGxnUmNPZjBRVVZCcGlHMXBvWEovYWRVUE9YZG52K3NIM3FlOUM0Tnln?=
 =?utf-8?B?dHpxYWdrVXRIWkhxQ0NXYnVWazNjck13NHcyaEJ5WFBHbSt3MXZ1YkdxbWR0?=
 =?utf-8?B?YkxYRU4zZmMyTkRmQXNRWVl4RmtaY1NKV05GTjl3M2NxZGM0SGd3M0RkbFJQ?=
 =?utf-8?B?dUhTWThMSmFadGlBWkZLL1d0MzY2TEtTbVFJNDVKak8zVnpoNDNzdDBmSjRo?=
 =?utf-8?B?NTF4TlhZbGYzRVJDb05VbUszTi9vWk12MUF2U1ZsK2I0NzFqSnA1VVNZaTB4?=
 =?utf-8?B?NlJXYTJ1WWVnUkk4RG9Fa2lMVk5iRzRmZkUzZlVWS2wxNEJpQjdaNUZXWXZz?=
 =?utf-8?B?WTVFZVp0UXlxY3lBR2dQYU93S2ozM1lEcnJpT3Q1NGY4NXZNd3JFYjBYei9E?=
 =?utf-8?B?YUlNaTdhdFhZZDBGSndValZnYk5oeGRCSnFQWFRZem9EcHQrOEQ4UzA3WVJl?=
 =?utf-8?B?V05OSTI3TENsL25ZQ21TMlc2L2FkN2pXRzYvZjNKSllDSmdBTzhXek93S1Jl?=
 =?utf-8?B?bXViU0YrMjNlVTZPdWdzUVNsMnRoM0ZNVTkvQ0xpR0tqakNBVUZIUUVXWUo3?=
 =?utf-8?B?cVpraFBBK2dXN2xQRmYreGJsOGVST2JwbnU2Vm5IZDllRU5odHp1NnpaRlBF?=
 =?utf-8?B?cm5sZHBLMnlVRmpXdmJjL09wdTIyWE1NQVVtQXFpaDBNMUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEVNRXh3WVduMVp3OVFqM3pSeEorWktxRlV1ZWVLaVljYVFRbm1RY0d3L2Mv?=
 =?utf-8?B?Q0xDZk9zamVpTVlObHg5TlU5L2RaVnhXT0dSakUzT2hhYTlmelZVQVo3b0tu?=
 =?utf-8?B?Q2puUkRTY3hWUm1Lc3JZWkRiWjFOTDRMTU52R21RcEVmN3VGME5vZlhZRnBD?=
 =?utf-8?B?S0x2bndTT280Slh2N2Z6ZVZINVJjZVo2Ym1hNEdxV3BEU09Tcjk4UFYrQk5w?=
 =?utf-8?B?K0tNMzgzRGxuLytTTkxpK0RYTHd0WTBYQVpoQkIrUE9yQm9ZakpqVkRzVVdR?=
 =?utf-8?B?QWxzT0VJdHJJTENNTlVkVzdXcEpyYzNwSVZ2S0dpcTE3SFlGRFZXLzkyYWxP?=
 =?utf-8?B?T0pyakNSNVZQUzdWS1UwWWZZbitmaVBud3UzSzkra01tVjNMdFBSL1VlbUdN?=
 =?utf-8?B?c3V0andSWG1meGhKZU1oRmFtSGhsVE1iRG5ndnkrMTVINE1hMVo3UWZKQ3A4?=
 =?utf-8?B?L3hoVld0NEVPU0c1dFplVUNLQ1pyZzQ5VEh5bGYwZzZ0WEVnM3Y5M2JuZHJj?=
 =?utf-8?B?R1V6VEtkMlNVSEk5L3l5SVA3VVc1RStNSVJxQmtYeDdJZ3A1NnpHRG9jYVd1?=
 =?utf-8?B?VzJRd3FEbGJWZGcwWHZHdWRaTjJpSXg5bnFYYXN0RlYwK1U1K3FMdVl1QUND?=
 =?utf-8?B?bHVVQ1RBekE5S3hXZkg4YjFqcVd1NDNEUFJCWkE2b1dBUkpLRStMS3RqRmda?=
 =?utf-8?B?ZFlwQjRjblZBZWE1TUNXdkRsY0VvYllMUHF6MVlMZXlkYk1QbGpORXhoM0Z6?=
 =?utf-8?B?UWE5blFxL0o0OHJhK00xVGkybnB1eWN1UEpkUi9Oc2M3MDBRa3dueXdsajht?=
 =?utf-8?B?N1o4NTRFVU1qY0cwVUFta2p3eldpMUUzcklieVFIc3pnQWpCOVFoOSszVGRE?=
 =?utf-8?B?M29paU9ocW94RVE1VUsvZGhmOVZ2eFdWTnRhMUJvRmxsZUpKMVlaN2wxVW1E?=
 =?utf-8?B?UEY1QkJLTWM2d1J2Y3oxL1pyb2VTeCt5dlIrVGN0Y1gyN1BCbkZTMVBFbWc0?=
 =?utf-8?B?TEo3SnhaNzdJckpzTkczT3dsTmlsTkhVd2dIRmJ4S3dXVGJuSHJmeUlxdXZX?=
 =?utf-8?B?WXlmQmZRc2lFdUo4SWYzdU4vMUZKVUxNM1NaazdsbmdPT1F6eWZSYUl5NVJl?=
 =?utf-8?B?VkMza0drdU5nRkdENUVRMmlKb3piN0JNaXRPK1diWXArenJsOHlnTGRMYmZJ?=
 =?utf-8?B?anpaNmowRFB4R1dHQXZRTmpVeEZxM05wempFUndJYWhDeE5kM1FycDVONWx6?=
 =?utf-8?B?SjNVVzdRM0E4bEd0eXE0aGViRmtlT2tWb3FmZ0dkeEJjMDNFUDdLMTJuZWpi?=
 =?utf-8?B?QTcraVM0RjVJTWF1a3JvSlh1NVlBNEdNTXc2ME56enE5eVVlenhTbVFsLzAv?=
 =?utf-8?B?blFtZGdwb1Nxc1N1NXJkV1hmSGtDY0R3MEZrUGlLRlQ1eG5rWkdXRWxSU05X?=
 =?utf-8?B?cERTU1pQdGo1cC9veXVxQjI1TG5vaFFUWWg0Si9BVnZYdkc0L0ROUXhTZzQx?=
 =?utf-8?B?bUhpWENGa2g0QmlNZHFOU3BrOG1iL01MbUNJaVJIUlZtVU9xRFQxYmpLWkwv?=
 =?utf-8?B?ZFZXYU1FWEhZaGdNODdtcEEzb0lKTFVvVDV5bEd4c2ZoWEt4WUdNYWdUZnJB?=
 =?utf-8?B?bUJjZU45U0FGc2JIU2x1TzlpMC9TYlE2ZlkyMGdYbnlKbFNUR2ZZRVRLKzBm?=
 =?utf-8?B?TzZiK252WlJCZXB0TmlmeVc0TGphN3JyZkVRb3ZNR21uRTlxeS9qTFllSito?=
 =?utf-8?B?VUUwSmxnbE42ZEd6NGNWMnRwZVFkL2JNcnZYalJNaXRmZXd0UGVQdkt2ZEpF?=
 =?utf-8?B?VFEzamJUMHdDaFp0K2gwWW1xTWpTYVhtSWNwZlZENDhlbTRUQ2F5MncxQXBl?=
 =?utf-8?B?eXBiQjExSlJ2d2txUDlYMzRoZzdweDFpc3FwVkhGQWlHM3RjMDBIZEN2ZmJl?=
 =?utf-8?B?VkJveG9TM3BxVW5IcmlZcThuQjNOYTNxYzczQmcrZjZIZ3FiZHprZ3A4VHJR?=
 =?utf-8?B?UDZ6UHZMNGdwb1RNRlNmQ3VLanF2aDh5VHZHKzY3aXg3elRER1BBNzNxRmlG?=
 =?utf-8?B?bVgzL2xDNm5RQ1ZGQ2lSbU8rSnF2dVJnajdkZGhHR2lqUjlJMUhONnh2aVZo?=
 =?utf-8?Q?spg7n6iI7gDpqUXA23oTJ34Vi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf34084-cf60-41fb-5c7d-08dc95b93621
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 08:23:09.0628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEWR5fPOwI0llPUNrHJ64TAyOCmb0WbUbEJ2yQzTpl0K/gy2AKrsxBtlHctdnDcVo8MrJPQigckIZhIcK67pEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7165

From: Peng Fan <peng.fan@nxp.com>

If there is no of_node for the protocol, there is no per protocol
channel, so return false. Then it will reuse the base protocol
channel per `scmi_chan_setup`.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/mailbox.c | 2 ++
 drivers/firmware/arm_scmi/optee.c   | 3 +++
 drivers/firmware/arm_scmi/smc.c     | 7 ++++++-
 drivers/firmware/arm_scmi/virtio.c  | 3 +++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index 0219a12e3209..4f3abc933315 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -71,6 +71,8 @@ static bool mailbox_chan_available(struct device_node *of_node, int idx)
 {
 	int num_mb;
 
+	if (!of_node)
+		return false;
 	/*
 	 * Just check if bidirrectional channels are involved, and check the
 	 * index accordingly; proper full validation will be made later
diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index 4e7944b91e38..c0a198baa706 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -334,6 +334,9 @@ static bool scmi_optee_chan_available(struct device_node *of_node, int idx)
 {
 	u32 channel_id;
 
+	if (!of_node)
+		return false;
+
 	return !of_property_read_u32_index(of_node, "linaro,optee-channel-id",
 					   idx, &channel_id);
 }
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 39936e1dd30e..913e45c205fb 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -81,7 +81,12 @@ static irqreturn_t smc_msg_done_isr(int irq, void *data)
 
 static bool smc_chan_available(struct device_node *of_node, int idx)
 {
-	struct device_node *np = of_parse_phandle(of_node, "shmem", 0);
+	struct device_node *np;
+
+	if (!of_node)
+		return false;
+
+	np = of_parse_phandle(of_node, "shmem", 0);
 	if (!np)
 		return false;
 
diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 4892058445ce..4d8d6ad3ab5b 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -389,6 +389,9 @@ static bool virtio_chan_available(struct device_node *of_node, int idx)
 {
 	struct scmi_vio_channel *channels, *vioch = NULL;
 
+	if (!of_node)
+		return false;
+
 	if (WARN_ON_ONCE(!scmi_vdev))
 		return false;
 

-- 
2.37.1


