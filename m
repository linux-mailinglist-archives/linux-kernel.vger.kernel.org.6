Return-Path: <linux-kernel+bounces-267093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D766940C46
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B41B27E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD19194C73;
	Tue, 30 Jul 2024 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SSRrAqvo"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1960A194AD6;
	Tue, 30 Jul 2024 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329354; cv=fail; b=Otv8aiv7ejaR1sQclPWZ/uXeFnxm6Gfn0ywnNyxtxTXzRg7zEvmsQcmmPe90PZUu0wbUV+lybCcudR0M8Jbqn+iTSFlVyzhoe0Jq2sCVQy/6+Xo0MqonWEk5E43loy1uceMeHjzIIj2IzrypqesBB/oDcmMt4BnJk8j08RTWGUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329354; c=relaxed/simple;
	bh=jJHtN5cdjpw48j/RwDXB2cYoH8FaDj/mkqJp7Fm5m44=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=i4zCHH68hVzDxzkUlsQT5Xg0GtYtcvyu7eZpv6KbSukuzM0lEBYHUPhYvU87Uayfsqv/BuzXIYLqWIFBmjUeLkiN/IwxDRnlUhqHNrZg5cxCPoWGsi0X8d7gHo6dF40ZyGfvQhXEQ048br4KanpAw7a9E3bgytrNWL6zT1NOOiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SSRrAqvo; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLdaqUcfLt7fEpX/TUAQ6CMAnSrDfSdC8W/3SSLChgKVvcja/ourLnZqcXCrs9pC0XKgxt9xVJbjVsN3y+l+JD634J2B51vhsHNqCVIFbeWoeIMb27KktNU+3o7bIGk6PEp/2d4LpOs3m5opuh5O94j3E2M7E9mNxF5AQhlRJFJz9AtlKO5t0xLknAsScVuq9TWFZL+6cx8nB+yw2p/uDrnCdOlDB+9WhkdFNM0hK1lvVBg30/hJZVyz6FiqZl+H1wmzFwJuHPhL1v7g6GvQjgMx7KjhCFy9VSLv+DxnQJkOQNIQa9sZVVyHqS8XMhLANnWfgpYaYQl4Kqr4RN7zhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Inysam4Nwgvdh+lgZZMJHWWZI7brIH8XEIf9gyI9WyY=;
 b=aCbMP+Kpy0b8AZOm4vvY+WV4eoopEamz1xVTULY2PfAbhgALKnoEKMYlb5g4Css8ZKg8Rk+UXP7MbTBlOSqgMpuckunAAQAkbQ1KR4RfNz/wACTwWh7FkQ0ogm3uFNkEgl2ySfWhCo0xNSk/EZnZNQc48pA8h+4+NnTg3O0ywUn9dbgZygWL0UBa+HuvPr+Bz9fBP4tHa2K9pQj9Q+jQ8sAkfa7FcDYDnSAHkiLRhrQn128siYC8s5jAXXzVm6C1uI151ItsfYfhzoQCD+hkii1X/YuPGtw1H2dWDAOl8NmhJhDH16IQrHbylsZDBTJmNAxWK4p7xQRaAvLC3GdJ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Inysam4Nwgvdh+lgZZMJHWWZI7brIH8XEIf9gyI9WyY=;
 b=SSRrAqvoFZC2nSNwfrhqSBpHSlOkonmEYJ9jHoTomCKRTKfWJkCwfsThE5UsV/ysXI8j00Iz5FKZlgFp1/vE/tUct/+AOl7Q8SDm1d5D8mth7aeK/S1PocuICTkdgqSk4unm6IXRcXwxNbYapqsuKrygZmfTyiVYPc+AR5EOxZc+4c4e1E+aq7iT8EsPZJ3BzVNt3bTc7Rs1KIFJ8rS6VCdvw26phLRvVPdDHXAjerwWXXoO98cUjrD3bxQQL1Zhujal9NTf7HLz51aRcrWA/LQCJbCNFo6GmNWTj/JKu5KhNaTBWFIkizB73v9UTkCbep9p0lYDBl6P/Uwnsj+uLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PAXPR04MB9021.eurprd04.prod.outlook.com (2603:10a6:102:217::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 30 Jul
 2024 08:49:09 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.7762.020; Tue, 30 Jul 2024
 08:49:06 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 30 Jul 2024 16:57:54 +0800
Subject: [PATCH v3 1/2] of: property: add of_property_for_each_u64
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-clk-u64-v3-1-4d2b19edaa6e@nxp.com>
References: <20240730-clk-u64-v3-0-4d2b19edaa6e@nxp.com>
In-Reply-To: <20240730-clk-u64-v3-0-4d2b19edaa6e@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722329887; l=2787;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=/uWDVm5pCySyF5BAPfXac+GeAhNij296nWQXpAULzPw=;
 b=bK6nhnpFwq1vkB5JFUMKPuRmRoHYNXYUwqkzCQhqc3Ym8Qk5nbVxHISzmn6Sw2hP6MzcBqTaj
 fH9xnAKmkbIDSfthoAecvQbGh/y3sAjHWcDdAy5IvSgbfc1RC2Pdr6e
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|PAXPR04MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e68d66-e99b-42e0-9c2a-08dcb0747882
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzkrVzBKOHUxZWI5SzVCcXFDTjJZZFdrbEkvTmN0b0VGYS9jQVRzbCtVQnBv?=
 =?utf-8?B?OEIvMktsdHc5THJBNnVyY0JwSHlvbHgzSzM2UHNJZGNvMVhyV0pyeHhBS2xV?=
 =?utf-8?B?SVBvdEYyOTBCbVpKS282Zkk5ZU9Ja29FQUhHRFM0cURoanhaQjg2YUpsYXQ3?=
 =?utf-8?B?YTBBV2lpTFZkbDVmMnV3dGYycnprdVpFNTU4RlFvWCtRTGlBM0JaQXFMaGFH?=
 =?utf-8?B?REtFY01IWXFEZjh5ZHppSnVIVVlROGd3SGlzVUdYQ28vVDY2TWpodU1LY3hw?=
 =?utf-8?B?VlRDcDlYUGJLU0R0Vy9rbTRnV3ZLOXQ4RWJLOGwwVE1heW9ZRnhnUUk5c25h?=
 =?utf-8?B?ZWFpWlNkbENhTEZ2Sy8yWFlNbnVwUktCdlpINVowZFNGdlFVWTUwSVdzbUh2?=
 =?utf-8?B?aDJCbjN5TWh0bnB4N0F2VVpOVWpHKzNsTzg4RHJET1hPZlFKejNXbVNtYTJv?=
 =?utf-8?B?N1NOM1FualI4eGJNUTQzVm5XSy9xaUhpb2ZHQWFYenppMURGUDV2WmZHQzZ4?=
 =?utf-8?B?cXdMUEgwN3h5T2luQno4cVR1NjRpSXVOcTFickNHYXo1N3gxakMzS3V6RVIr?=
 =?utf-8?B?OUZ5MzRoaEtZNStsa3NNVFJMUjFSVHpoak12U0ptV28ySlVLNHVwdUdsOVQw?=
 =?utf-8?B?QTI4cDdPQSt6VmpWYlZjZHJ1bU9BSnVpeFRqanViRFlwSnJQcVMwcHJkSE0z?=
 =?utf-8?B?RVZmT054SkZ3cmFwVmxSMWsvZ2ZKclUvRHFrQlhIS0ZKc1dodlpQR1diWUtC?=
 =?utf-8?B?OVFWNkRVaFllaE8wYjE5RUVDcWtCN21FU3hZQW1JdGJuK2lpajliaklDbnd2?=
 =?utf-8?B?blZxb1I3SXMvcnc0RytzWnJJTDBwMTcyNVVlekEvc0JSSXArdFhaR1p5Ryt4?=
 =?utf-8?B?bGRObnVjVGtuT0k3L1Z2QW9MWnRXd1RhUk1vckY2elVlNi9ad3NSSDVFQmZJ?=
 =?utf-8?B?S2tteEcvZGVQL3FOSlozSXJocHdaU2JTUG5WWUg0RysvTlFxcDN4TVcxQjVC?=
 =?utf-8?B?WkxBZG1oTTdGWUJScEM5dXBkdHZudjNjcXFzdWNOMUVlaHE0R291WUdFVW44?=
 =?utf-8?B?UnlKa1dtY3lDQU50T2treTNjUEN2c05tbUF0bFA4ZXpFUUw3MnZ6alFCMERv?=
 =?utf-8?B?bldEMWNBMVphcmZQUEpjQ1lJeHR1WHh3RVdkNWF0WGlnMFZYUWlZZllxdzdH?=
 =?utf-8?B?NWlreXAxRmRzQWdvbUpxNVBMdnhYWGFvU0ZWa2hQQkVVK0dRdU9mU0d6MnZT?=
 =?utf-8?B?dGU3ZnpOdjZDWVhmZHdTZ3RYR01FbW02NTZ1S0tEU2FxYjZzeVR1L1B4ZDFI?=
 =?utf-8?B?c2w4KzBrTURCbUxpT3V3MkUyMy9RZW03TWZQNldLWktpYVJDTkZuVlc1dEw5?=
 =?utf-8?B?aXRHcEpneUdMbXdRUWtDODRWbjdJdnBuWGZFYURYekp2RGphTitYUzYzclRS?=
 =?utf-8?B?bVZmV0gvNys1c0kxNElXN09yTzVSYVBVOWZCcXdCWnFoeERhcmZtbWdtYkp2?=
 =?utf-8?B?eHE5WTNSc1ZvS1dTcXdtZ25zTUhQeFBacHNpRGVvb1ZIRkQ1Q0tMRGJZMDZO?=
 =?utf-8?B?OFdNR1o2bTYybmQ5NFdNVko2ampjbFVBSXJRRjdtRHdGc1FDTm04OW0rS1ZL?=
 =?utf-8?B?NWcrTFBjT3BVTmg5L1pKZ1ZhZmg0Sm9qelh4SWpJZjNDcVlFVWxHeVE3Z1Z3?=
 =?utf-8?B?ZjQxeEU5OHR2UHN5MlhNeW9iSFFmUEt2K3VFTjJEMHpobFlHek9mcG5HbFlx?=
 =?utf-8?B?SVZUTW84WUZRZlFibUlsbW1PbkdBVmI5K3AzRmZpUVRkUDBicElKRWxPQVJy?=
 =?utf-8?B?dlRIRXBLVE1lQndXT0U1KzdWL253cnBzZTM3b2NoeGhoc1p1NWJnYlBQa0ZH?=
 =?utf-8?B?dXYwZGFPdHhmWEsxRUNaQSthWGdBSmMrVDFraURzYnkyUlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmZVeXFwclVqeWdMV29nUlQ5MU5EWk1GYXdBM3QxN1FDSVBUZXl3MUtBc3lW?=
 =?utf-8?B?bVpMRFJXai9udkpaS0VwTEIvbmdkTGpIV3MyZmFpcnk3QnNhQ3ZMc05TWThx?=
 =?utf-8?B?V0s3RmtESnl2NE9pZGJmMkFEK2Z6YUtveTdvUmZ3SytqV1BlS0dlVlp6U3FH?=
 =?utf-8?B?OFdydUQ1SVZEcmpuOXNaeVRCQ3htYTdEOW1tWDFia0JLaGoweUpLQ3JiaVpV?=
 =?utf-8?B?UW9hZWsvLy9SdEJkS2JTMTMzZGpYVC9yN0FRc0JyK1o3LzFPZTJHSTAxK2RO?=
 =?utf-8?B?bzZnek80NzMzcXdMeDFNdUw0SXVIRmFNVHIxbVNjcUtUQUVXOU5DRkl3VklM?=
 =?utf-8?B?RmI0MnJvVVkrdTB4dHdqMDZQQ2FJR2g1bVdpRDdVSE1heFZsdzJoanhtVXA0?=
 =?utf-8?B?dm16b3RRa052L1pYb1RBVDJyZVZzNmEyT3NwS28xeTg5S25tcXgwUnVmWEVh?=
 =?utf-8?B?MFpIL3JPbTJwcjQrQ3hFUHJkc3lsM0M5UVk1SEdoQzJyaDVxcUxEcUNiTGVF?=
 =?utf-8?B?di9ZM01UZUlXOHhuVkdPeCt5YjJWKytIY3ArcHFUVHE5elhJU214OVlvYUpZ?=
 =?utf-8?B?bWpxV0VnK2tYNllTOWdhaWNRUFp6dmluajhmdVN0LzNoenVnTUtlWFcydTFV?=
 =?utf-8?B?TlJuMWpvc2p5Sm5ubUtwSjhZU0w0bjZaSWtsRDZ3bUtKVW9PWkFkaGgzS2pu?=
 =?utf-8?B?VTZsYzVYVW1QY1RWK0JmUDV2NkhqR2dtSVBZVkNYSE5peTRlc0xCRVEybVA1?=
 =?utf-8?B?LzBSKzZJVnFnL2paVXQwQVJuZkttd3JYdUJaYWcwZTYxZ2RMaWt5UWYxZE5k?=
 =?utf-8?B?QWNmT3VIYjlwazlNQnZnalplTjdaOW1IMGpST3IyOXluT09SK1JhREVjcm5i?=
 =?utf-8?B?MzM1ckUybjBiK2FVbEJTWHRsZWtieGRvN3FzdmsxT2RZck5RN3AzWWhzOTBt?=
 =?utf-8?B?aTJvb05GODArTlpwNDBiWDlseWdJaGxVSnlPdUVvU3NleFRmZGJ4K2U2L0Ex?=
 =?utf-8?B?WEltcVFqK0ZISWE5ZjhNRHpna1NxclBiaXl3MU9uSk1ORFhJMU1sOFRtK0No?=
 =?utf-8?B?RXlBUEZCTjlDRndQUHZUenJ5ZG9yNjQxQ0JseEY1T2JlbU91L05XZWV2Zjd5?=
 =?utf-8?B?MWV1VXRJQ3VpWkMzWFJobytsRlpDbHVLZWg4TTNrc3A5RldMM21GV1NzdVRl?=
 =?utf-8?B?SC9mYlFQb2hFdXpWTURISG1yeE9ER2tqUW9laFJJL3RoNjZPbkt0Y3p4RUNh?=
 =?utf-8?B?OU5JYmYwRTNmZUoyNHNnZnRNanRrbHI3Tys1ZTF2YTZBbzRrb2lkOHNPWGVU?=
 =?utf-8?B?V2NpYm1zQkYrN2ZYTy9mYzhjbFhkZUg4VWx5NEtPcnRTb21OeURiTDBWOHNW?=
 =?utf-8?B?bFFOSm85OGhDU1FHSEZZeW13V0l1VFluUGFSRksxampMNzFaU2piKy9qS25E?=
 =?utf-8?B?V2dNSVgySWkyQ2pFaFJUanNNMWNRMXFpSEg3c082VGxCeTlUZEpIQ3BQOGZk?=
 =?utf-8?B?TE9aUUNtbE9PYWROU2xSMDB5TTQ2Vy9Wd1hBNmxKcWVHZ1Zqank5T1ZiV3JZ?=
 =?utf-8?B?WUcwdTIvTUw3Z2JpUDROdlFFNFc0bUc5K2xkZGxnYlZwSzFzQmkrTFJVK3h4?=
 =?utf-8?B?NlVKUEUzZTVnRmVtdDk3UnBzR3lNL1ltempycW9XRDkxLzNYbmZ4QUJ6Z0p6?=
 =?utf-8?B?YmRITGxLSmowcERWK2N2NklUZ0UyTHdVK3RoYy9adlZPUy8wSXd2NFdsaXlx?=
 =?utf-8?B?U2NHeUpwNWtNRExJSzF6WktaZ2ErM2w1V1B1REZCMHBhZm1FRGxXdUpaVTFZ?=
 =?utf-8?B?SjE1aDQ1M0RpeUgwTExnZUhtRklab21Xc3BIRXZBaXMrblh2bTBTRVZ1TEs1?=
 =?utf-8?B?dzllMmFrb05NaXViNVhvbEZqaFh1SU5yZTEvaHVibHp1TlVnMFd0WEVZUmg2?=
 =?utf-8?B?VktiNXNBZkp6dmY1a2pjd00vRWV4SzAvRW9yWnAyZG9EZEUrNC80ZHNiU1FK?=
 =?utf-8?B?aDZjdjNQT2VVeTU0SUlMSTgwZ01kdXhORW03NVNFbGU3YTlVNmRjRVJvTC9E?=
 =?utf-8?B?TFJUaWJRa1pkYU44aVd0eWJER2l5QnZFTXV5Y2lrd0kyNlZ1azJyb0p0SXl0?=
 =?utf-8?Q?2u2/633zs6XsLSUkVU50foHt6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e68d66-e99b-42e0-9c2a-08dcb0747882
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 08:49:06.7345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4UdnlKsFilhFOYoQksr0/d95xFWB7Rjf/SQa/z9R4cGysdNNKwoaqvflv6CTaaf9ZToNRf6+ll5EDg6j8fb3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9021

From: Peng Fan <peng.fan@nxp.com>

Preparing for assigned-clock-rates-u64 support, add function
of_property_for_each_u64 to iterate each u64 value

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/of/property.c | 23 +++++++++++++++++++++++
 include/linux/of.h    | 23 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 164d77cb9445..f70fd8deb9cd 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -548,6 +548,29 @@ const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
 }
 EXPORT_SYMBOL_GPL(of_prop_next_u32);
 
+const __be64 *of_prop_next_u64(struct property *prop, const __be64 *cur,
+			       u64 *pu)
+{
+	const void *curv = cur;
+
+	if (!prop)
+		return NULL;
+
+	if (!cur) {
+		curv = prop->value;
+		goto out_val;
+	}
+
+	curv += sizeof(*cur);
+	if (curv >= prop->value + prop->length)
+		return NULL;
+
+out_val:
+	*pu = be64_to_cpup(curv);
+	return curv;
+}
+EXPORT_SYMBOL_GPL(of_prop_next_u64);
+
 const char *of_prop_next_string(struct property *prop, const char *cur)
 {
 	const void *curv = cur;
diff --git a/include/linux/of.h b/include/linux/of.h
index 85b60ac9eec5..de481a4bdad0 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -437,6 +437,16 @@ extern int of_detach_node(struct device_node *);
  */
 const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
 			       u32 *pu);
+
+/*
+ * u64 u;
+ *
+ * of_property_for_each_u64(np, "propname", u)
+ *         printk("U64 value: %llx\n", u);
+ */
+const __be64 *of_prop_next_u64(struct property *prop, const __be64 *cur,
+			       u64 *pu);
+
 /*
  * struct property *prop;
  * const char *s;
@@ -832,6 +842,12 @@ static inline const __be32 *of_prop_next_u32(struct property *prop,
 	return NULL;
 }
 
+static inline const __be64 *of_prop_next_u64(struct property *prop,
+		const __be64 *cur, u64 *pu)
+{
+	return NULL;
+}
+
 static inline const char *of_prop_next_string(struct property *prop,
 		const char *cur)
 {
@@ -1436,6 +1452,13 @@ static inline int of_property_read_s32(const struct device_node *np,
 	     _it.item;							\
 	     _it.item = of_prop_next_u32(_it.prop, _it.item, &u))
 
+#define of_property_for_each_u64(np, propname, u)			\
+	for (struct {struct property *prop; const __be64 *item; } _it =	\
+		{of_find_property(np, propname, NULL),			\
+		 of_prop_next_u64(_it.prop, NULL, &u)};			\
+		_it.item;						\
+		_it.item = of_prop_next_u64(_it.prop, _it.item, &u))
+
 #define of_property_for_each_string(np, propname, prop, s)	\
 	for (prop = of_find_property(np, propname, NULL),	\
 		s = of_prop_next_string(prop, NULL);		\

-- 
2.37.1


