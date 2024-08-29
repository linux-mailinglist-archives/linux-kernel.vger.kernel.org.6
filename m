Return-Path: <linux-kernel+bounces-307703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AE09651A4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D0EB20C69
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5991BBBC9;
	Thu, 29 Aug 2024 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Eyn0RUq5"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D861BA27F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966129; cv=fail; b=dioAQ0jeho5VWqRRMcwSObY2pc0AwJVnzqTuYXKAkbRFPRnZMp+cHmNvKFG0tCNkdFdZFiYHAOwE4Xd4+OouE/HDaFyzoKBOPOoXVW4MSY/+YZYGh8FOn4paDs2VqC0QOwWiDFdX1SLlODsoYNE5RxzgENSN0ltr5wTQifqGdhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966129; c=relaxed/simple;
	bh=AHcqgly/vmoU+jJ+4HNr0fpgvCz9aPVFw5NId2LgYsM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pivVC29zJDKl4b65FAhrXf/ZHIhgzMCSUh9ZMD9/uRpVQVL7rUJF3FLlMiDsXSOJ5qiY8tVr3N4bBuNYara3nPWFcLhhamYbXhhdX2sNuqiNAtuvaIgvWhaMatroXDS5nBscHBN9mEQLz4uGcPTvs5pAsA1HVrQYFsZxDP0a0+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Eyn0RUq5; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwxaHeP3MN9BaWjLwO61fPQMynQEQKOlRf8rRmHosmxtWF2oudyvDE+WcOEbjjDpQ7PGi4AZrDiGrAxiC0PZc2vwDkdolFhR09f0KbcUBSNIuih8yK4f4x2ssarA0w9v57oHM3SPZLDIcEvr56apXMyW3OwUOcxFLGHpQ2j7fWQUl4IA9sQ7ux4DOtDhbk5lXabMOMV35Tk7nvOE6Z21pia0WFbZy8hF9Vh8Y2wWi4Tqzsr+B5EsVBjMsZ4GhnN6Cc4Mq43BiEHql5AhA6iHDByFbb6QOAkM48vzqUiqtpXRpFQs4hyIFbr4lTx4IHAKC2rmIEAqh3W81hKx24jDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+wM5XFFRbRdoH83tWAzH9EHEDGwXzNFWdNBvKh93EY=;
 b=sAxTnOIR0/Tc0Abp/IDfQI4nYm4eVEZl+oHhkQAUCB5xQ2BFBuI0osMScw90ppBigPtDb0doav1bYchbsxO2KI90zTn5RgPEdVhrtMAX9K0SN9czlGJiDESSc7zby7kBb34Ojhb6XszdQZbGsZdxupdGvwWAfdr3wYDZmSkG5ye8L5+4fzux9e8P1XvXqYVlOFt7Wnzw/i/2+QzHCzD48FdlJ2hT4gUUEjWq2gOtESio68NIJqX7IC9K293D88UyS4Qo9mg5EzixDWbjxsiOzusEuJGsBXOwovJyAPtU1pCNOc8EHjYxbqlHbg14qO4Tnjf2VGmO1hHk2j0ZWdHc9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+wM5XFFRbRdoH83tWAzH9EHEDGwXzNFWdNBvKh93EY=;
 b=Eyn0RUq59+ydzykMiopNsweBdpst1oMq5T/MQKL46/pDnEcfx7w2MR0I/9NHu+bhkDc0iruNTwRyZZ5+QGq8qcVh19fRqxfA84Sjq7jxdyD7JPkD/eLrIJvTWuKPjvEicy+dy3KlEbJ+1AtJ0OULS7dTbzLtWhHpRVI6pBdITrHsMDGqc2eIADfDpmRHNMgDC1S7lA6JaZ9eCCUUBZqxOD48le7B8u20i09cu7EZCLLFerpGBZM+CYdMBmP95GY/Qr+Ff4x9cHtJDmvcClA9UCBHlzBKWBxrmgRCA2prWM6W1tmFnoUXOOzVkmNwqcHKdfEvTxcJ6CkK0bJFfGTw0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8971.eurprd04.prod.outlook.com (2603:10a6:20b:40a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 21:15:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 21:15:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 29 Aug 2024 17:14:08 -0400
Subject: [PATCH v4 11/11] i3c: master: svc: fix possible assignment of the
 same address to two devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-i3c_fix-v4-11-ebcbd5efceba@nxp.com>
References: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
In-Reply-To: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724966083; l=3184;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=AHcqgly/vmoU+jJ+4HNr0fpgvCz9aPVFw5NId2LgYsM=;
 b=0VnkJGxAJrsl06sm4Q7m0MJStVDIHL9X8VwXMfWEyiHZdMs19KXgj9cBZzvu/mZoO7o/agbna
 XxpkRjLB24PBzgJjoLbfBoLT7OIc77CR44IMpbqnnM3g7Vectva8HmV
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8971:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6b77b2-82e0-44f9-a876-08dcc86fb119
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Q3puY1B1bDB5WlA2N3RjbVhxaURTa0daNHE0SFBSWW1Fd3RZVEZ0OStKMWty?=
 =?utf-8?B?TEhzU0tRcFFYczNHbnZUbUJhQytra0FHV1hBaVlXUFhVWmFOQ3NqNzZ1M3BL?=
 =?utf-8?B?RUtiSjNaM2FMbzRuaHZKaC8yelVVNVRBMTQ1THUxZmZlQkdocGdVelQ2N2V3?=
 =?utf-8?B?aE9MRDVucGNiWVA1dklLSE40T2JDYXc5T29BVWt2NkNkVVZRR3ZoeXBqeXph?=
 =?utf-8?B?NmJqZFFnTU1IMGZPT1cyek1mVkwyNzFocE9kRGxnUm9BNXRSMnlwMU5oWjg1?=
 =?utf-8?B?akx5WFlCRmZjMWJiM1NLRFp1dnZ4NUx5K09EdWppZEk3bWxoaVdqN0t6bmpC?=
 =?utf-8?B?dDV4VlpxWWhRcVYzWUpHQXZObys0TkRMbzhkNEZGelUyYUszSFNzSHZldkMx?=
 =?utf-8?B?eklMaXgzVVMxQll2eTFrbnNiY3N6ZVpRTGRReDdrVkZJcW1oRnc1TlFHdlhY?=
 =?utf-8?B?MHBCUzFLb05SeFJ0TzZLeWx2WnlUTURob2FsRGZSY2haK0t3RG9yWjdpNzky?=
 =?utf-8?B?RFg4clhMSmk3QWFMVkZYVVd3NXhUNW9vcnJVODRIMEFyOWZrQ0xtblJ4amc3?=
 =?utf-8?B?RmQ5M2plT1RkVTloaG9GVVR2MUlTRzhzOHgvUjBlZ1NjT05sY05LaE1nRDRX?=
 =?utf-8?B?bnhMUHJjeGp2Y3d0bVR4d0dNTkVLYml1ZUVEZFFmTEdEL3BvNUJHTG9RSXp2?=
 =?utf-8?B?TGVvTlZHTVRNWUxZcXRTc25XMUVldFJLSG5ITU5ZekkwdkpBZ3JMdHZENS8r?=
 =?utf-8?B?VGI2RkZTbUo3TUEwK3dLVGhaR01kajV0ZFlXTXRnR0hnc2kyL2JjYVltRk55?=
 =?utf-8?B?OCtGMmJtMTZtSitrcWZHTDlURjhsZmVPaU1uK24vTndVL08zQy9WNnIyem5t?=
 =?utf-8?B?aUZmQ2N6T0RORUhyallleXBtLzFkYWlvekNLaC9SUE5kdVc3Nks1cEh1UTk3?=
 =?utf-8?B?QytRRkZudzhGQjY3S1FoV1dlSWdrUFppRStKQmZCUnNOQ3ROTnlZbVE5KzZk?=
 =?utf-8?B?dnBWajlmZkxuNjYwL0doTnFEM09RRWVpSXpPVXNPMngrQnozK0QzVVEwam00?=
 =?utf-8?B?c08wem5tMHBMZlVIZXlyOTJWTkNXRWtHN3NWOTRMYTJOWnlnL21zWStmWk43?=
 =?utf-8?B?SGV5QThYZ1RSTHRyYjQ5MHlkeGFpRUEvdWljM1JUeFhjN0lkZ0c2TUJaODRY?=
 =?utf-8?B?RUxzUXlYWHU3MXVMaUY5ZFFmUEloV29oVnBlVTJVSXZXemMxcUtQekNWR0pG?=
 =?utf-8?B?NVVaVXFkYmZ2UWlKSmw5VUhwYjBZdXFvSjBDZ3NPTzVNRHpvcUpYMnR4NkJP?=
 =?utf-8?B?S1BoZXhxdXcxWDRZSlM0MG16ZzI4TVNjbmUySDlRQkhWZ3hybVRaZkhtR2hF?=
 =?utf-8?B?cE5sU3MzajhrNk9qRDRiU3A1RkkxVXZ5RDZDSGF0R1B3OG81UnIyc2RTMEtP?=
 =?utf-8?B?eU00UytGVkxSS2JXTGlmQXRMcHdnbE5yREJ2Yi9ORjdDcEQwcklzWXpWVGxa?=
 =?utf-8?B?c0FxbVFnV08xS1pUSVNlNDROZ3JERitPaXhQeTY3eUxBZDQxQTlZTlVSNWJQ?=
 =?utf-8?B?eWtKVVI5eFQ0L3lPWVNDZlZXTUVmV0d4UTE3SG51d2dzSFN5cjBuclQ3NnI1?=
 =?utf-8?B?Zm56a3dGMWNBaWh2NUpjb3ltcDZZU2RveVlSRUY0N1FSelU3L3g0TkUxN0NO?=
 =?utf-8?B?dHNGbTI1ZjVJOGFvVVY3RHRzdDFmcit4TXVrazBXR3RldmROMW4zSVkzYzRl?=
 =?utf-8?B?dG5YcTZXcWx3Y0R3WlB4OHpYT0ljNDBRWUtydGxISy9oQWhSclhHRTNUNGs0?=
 =?utf-8?B?ZWVmazc4Z1ZZSXVHMWRHc0JZb0FUUW1UcDBRWmowWCs3bFR3bURWanl4aVRH?=
 =?utf-8?B?RUkveHlGdHR4SVlzY0RiRlN3ZEd3MFZUUkJIN082dHNLZWc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZTVNaTQ2WnVJVmdiRjhieXdYeXF5S2F2ZHRyeEE4M2NOQTJGMlo0RVRSem9B?=
 =?utf-8?B?VXlYOFRwM2ZPWW9XTG8vd2xGQm1EK1NCU3hrVWZpUlU4Y0llTmtZUzhDTEVa?=
 =?utf-8?B?TXJYREpPS2dkVEFOMmFJbkdUeTdPTHY0cTVxWTdlYWpzLzI4b3BTMlNNUGlH?=
 =?utf-8?B?T3pjN3N3NGRnZlZRZWxZVjJDQ0g5U1A2S1FxNWdoYm9XRjlUVUdjVHpZZ2t5?=
 =?utf-8?B?ZWl1QU9rQ0ErYS9CcEdvVm5hZW0zVENhNnQ0akdxMkNvZVN2SitVMTNia2cv?=
 =?utf-8?B?dmp2OEhncURxblByR0R6QXJFbWJhZXNNaC8yNlBCY3FXc1o2RUx1a0VPVk96?=
 =?utf-8?B?dTRJSzhVclFXUnFvVXg1Z3NzWjY0Y1pYSFRpSXA2a3lxWDdUeVdEYzZWVnh0?=
 =?utf-8?B?OWhSU0RSaGxJS1YvVFMxTnA5d1FOSXluSjBmQWFOVE5hOGZMcmVHdjdlVmky?=
 =?utf-8?B?am1vbWJiNGJBcm05Slh1Z3RBYllaUXJuMm1PU3g3SkJxVjNZVXpRdVZ0UlY3?=
 =?utf-8?B?aS8vRUh0ZytvNksrZE4rU2s2QXFVUThuNVlJa3JXWWZxT09XZ3B0RTA4cEcy?=
 =?utf-8?B?d2NVeERhRTlpVHc3UENlWEdZelUwdW1ST2oxTmZqcDRlVzVLTjJGdGhRWVoy?=
 =?utf-8?B?TmMwcHhTcENPNGZXZWFRNlVGcFJScC9jWG9wZCtyNjFSS29oRlI5VHRUNDVD?=
 =?utf-8?B?R1FJVjdYNUFxRzlwRjZUVEg3UFA3ZjdXSUZxeGVpZWxRVGlMZUFoTXl5ZVp1?=
 =?utf-8?B?MnJ6b2Q0OHZDb0t5dWtNRE9wQU9NamhKdytiaFkrQ3I1WHRuQXJRNkJqazdJ?=
 =?utf-8?B?R1VFMU50Nkl6YUhhSEx4TEZ0KzdnUGplY1JRM2NLNXVRR1ZuSHVGMm9PQkhp?=
 =?utf-8?B?TXByZCsyQmZaTm5tK1EzK3oxdjRZQldPNHdoQUZ5VlRjemM2NFRwV2RmYW1V?=
 =?utf-8?B?d0xYUHlrY1F5NkdxT2NCY1FZMGVEYURMYWpjMUo4QjhrdkpxYmdMV0FLaFVO?=
 =?utf-8?B?OC9GM0dXL1grdWNOR2h3M2ZwVlV0dy9tTDI5SXduWVFqYUc1SHlrWVdHL2Np?=
 =?utf-8?B?dUxpcWkxWE03cmlkZmplR3ZYdHA5L2duVGdrZCtJNE5OR2luWjVrbk9XSjky?=
 =?utf-8?B?YldpV2wrRDY1cDFOT016WnpWenJLWXEyTUx5QnJFZ1F4cXpGanJtUzdwRlJH?=
 =?utf-8?B?VWE2YkFuSmNJQ0FiOGtrbmpWNGM5TG9OVkkvc0JSWXBnUlcyWVEwN2lnNWJn?=
 =?utf-8?B?NVpFQzhqYlh6N3NnK1Rsa25Ic2hCaXRWNmFBWFIyWEU1SVVCUmxldW4xTUo2?=
 =?utf-8?B?ZkYrZDBjWDYyaTlReDlKUzNrUDNKcEsvZzd3aXdhZE9GWXplZWhieVZUcW1E?=
 =?utf-8?B?bU9kcGJjVGp0eEpCdmNMbEMvVUtoeTEwTktMWng3YjJwdmdzUTVxTVlOTTFu?=
 =?utf-8?B?R0xMcTZFbTFqaVlTRFhQeWhkWGd6czB4dDcyOWwyeUo2L05UNTkzR3BlNkpL?=
 =?utf-8?B?WTBmNFNpaW1veEVTYVNsYlgvbXYvT1UvUTc1ckc4NE5GSTgxQis3Smg3eEtu?=
 =?utf-8?B?ejlXVVg1SEwyYXVpeFNuMkpBZW1GRVlSaVAweVBsVmZZck5vLy9pMm40NWo0?=
 =?utf-8?B?ak9yUGVIeXVkM0xLNGtzQjBZZllpQ2RYTmJtOVV1U2tHblVsQm03NVFiaFFB?=
 =?utf-8?B?WkFDbWsyY2ZGQ1JrdXJUa1o0c2h6clB0eWJuUzhNY05rcVRlZTRrK3JWRDMr?=
 =?utf-8?B?elpPZnpTNi9JUmZEd21TZGJhWFh5ZGp5UWZVTXdaQk9aNjlqQjlZbXVMRGZJ?=
 =?utf-8?B?VEZOL0ZiSyt6YnpZam92VDNEdmF0M0U4dGJIKzQwazJaUXVVZWM1aTZRNzdI?=
 =?utf-8?B?aEpQSXlaQklzNGE3Njd6Mi95T2VKUnRNSmxrVFVIVHh0Qk1ReW5XZGVYRlJj?=
 =?utf-8?B?YWM2bkllbGZ0c0E3Ti9jeFo5aUVRRy8vWHJHY1pWMUx5b3liWUhJR0hIc1o3?=
 =?utf-8?B?ZEdwWnZtb0wxR2ltaGIzTllCSXUvY3p2dzR1WlJEOVlBeGxFc0s2eU5LSTNJ?=
 =?utf-8?B?YmdYTGdSdm9TeWJrNmNoS2dUUnNlRWdvRC9jemNlNjlyZDhwd2x4M3FTQjUv?=
 =?utf-8?Q?a50oUXWiriox5AQStUOhCk1OY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6b77b2-82e0-44f9-a876-08dcc86fb119
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 21:15:21.9011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQk4Ej28I1weAx7kZza93Ulc0FGfZTaPPfh+f2m/0wC64762D/vT5la70piuHZ9hNO/hcsJSet30MpGBDitU6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8971

svc_i3c_master_do_daa() {
    ...
    for (i = 0; i < dev_nb; i++) {
        ret = i3c_master_add_i3c_dev_locked(m, addrs[i]);
        if (ret)
            goto rpm_out;
    }
}

If two devices (A and B) are detected in DAA and address 0xa is assigned to
device A and 0xb to device B, a failure in i3c_master_add_i3c_dev_locked()
for device A (addr: 0xa) could prevent device B (addr: 0xb) from being
registered on the bus. The I3C stack might still consider 0xb a free
address. If a subsequent Hotjoin occurs, 0xb might be assigned to Device A,
causing both devices A and B to use the same address 0xb, violating the I3C
specification.

The return value for i3c_master_add_i3c_dev_locked() should not be checked
because subsequent steps will scan the entire I3C bus, independent of
whether i3c_master_add_i3c_dev_locked() returns success.

If device A registration fails, there is still a chance to register device
B. i3c_master_add_i3c_dev_locked() can reset DAA if a failure occurs while
retrieving device information.

Cc: stable@kernel.org
Fixes: 317bacf960a4 ("i3c: master: add enable(disable) hot join in sys entry")
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v3 to v4
- add comments about not check return value
- add miquel's review tag
---
 drivers/i3c/master/svc-i3c-master.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 83b2943074866..a520f5482b592 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1039,12 +1039,27 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
 	if (ret)
 		goto rpm_out;
 
-	/* Register all devices who participated to the core */
-	for (i = 0; i < dev_nb; i++) {
-		ret = i3c_master_add_i3c_dev_locked(m, addrs[i]);
-		if (ret)
-			goto rpm_out;
-	}
+	/*
+	 * Register all devices who participated to the core
+	 *
+	 * If two devices (A and B) are detected in DAA and address 0xa is assigned to
+	 * device A and 0xb to device B, a failure in i3c_master_add_i3c_dev_locked()
+	 * for device A (addr: 0xa) could prevent device B (addr: 0xb) from being
+	 * registered on the bus. The I3C stack might still consider 0xb a free
+	 * address. If a subsequent Hotjoin occurs, 0xb might be assigned to Device A,
+	 * causing both devices A and B to use the same address 0xb, violating the I3C
+	 * specification.
+	 *
+	 * The return value for i3c_master_add_i3c_dev_locked() should not be checked
+	 * because subsequent steps will scan the entire I3C bus, independent of
+	 * whether i3c_master_add_i3c_dev_locked() returns success.
+	 *
+	 * If device A registration fails, there is still a chance to register device
+	 * B. i3c_master_add_i3c_dev_locked() can reset DAA if a failure occurs while
+	 * retrieving device information.
+	 */
+	for (i = 0; i < dev_nb; i++)
+		i3c_master_add_i3c_dev_locked(m, addrs[i]);
 
 	/* Configure IBI auto-rules */
 	ret = svc_i3c_update_ibirules(master);

-- 
2.34.1


