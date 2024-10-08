Return-Path: <linux-kernel+bounces-356046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4261995B7B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4136C1F24B1E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AA8217320;
	Tue,  8 Oct 2024 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="H+KMxfp9"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020112.outbound.protection.outlook.com [52.101.56.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8D33986
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429528; cv=fail; b=LSzu/s7yvX3svgMqtYaiSPRilF3mJQ+/xp2NueiK0c4KU/nuVl6zhbkWLjA5n2gNSRGXd/oQ6FUv8dswXs1khq0plmvD04P0eKVun8kl5R/pHYEbTMJvMZtQMsEuumZlqNrT/AwQiWypYPsRabod0GkMHXebsJ+KTEaq8KoQYTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429528; c=relaxed/simple;
	bh=SQ9scINI0hAM+O6N4D8pyVckk5NJqYyUPrPRptU+kX0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HcVyQwnO3ZgIrZNEl6H4hHbMSOnhQRwK1SFA5qzi/N/WxUQTN9Ou4YMgHHlixGN+Mt1pCcW5GOCcu78Moa40uWOUmKyJYetEGJKdH2dmazW/wFay5RrRmpiFaUE8DXOsR0LL95VLpxuN4vncNyG2cVzK5ADc+jtnIdtaaTeEx9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=H+KMxfp9; arc=fail smtp.client-ip=52.101.56.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRfoVymCmy637QB3xaYlBaYi1ldTCmxElycUo/dtNA5dbYH1+kmNp9pjfggZrnauMl0U3y0F2IUF+oDA3s5pMcvhDQ5bP2BKvW5ZxuiKq2ShQ9kE7EayRu/1h3e0wHNjn/OjxjgH582oeeO3roAI/9+bEUGx2ZPU3euifvQ1fP1+sYc7a84NBShxlbRa1e4gigj+zzvbllm3g3kVctZTxet9o2Li0TNK5KPE9rDiki0C72/3Qzn8dWdBakUYW+55ZWRH/gXrShbCTVsIItvXrEP/XUBGMfJ4dfq1I2Zx5RTYU5EDnHaIPexlUt2aqXTsEB5H6JOYVDnXQd4HhL+6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S+SWQAWTmtVPstNmG3CZywMkiwVHJf2N9dbegLNhRA=;
 b=AQcM/Ozl81zsPKx9IEKyct+0a3jtrg1YaWZ6xajif92OtN+whVxRlukkSYo5nUJNGwNYknP1tzt20bWrMLTOzv2Z4LWgeyQ2Xr4r+bgCjS7enRr7xWorhoPhY7laq2W7KvLGAQmyxNZjHAWKQ0SoxdxUQxYX/9zvg9Y21qgY1wCPAxfrFmeTSsl+wZH+qmVmABaaA9PMk1dVCr/upOlGJd/ajTmf3z/s9JzGAEzvjPlT5G/PIRsjwC1zLW0j6xOM+Wqxsrdg12HNcCeb3ZShT8x3ntFRIFe7klaHGJELqSY93RaESE1xtJ7ewThFkOqnSTC32iRCzlg3bBUHYdqD3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S+SWQAWTmtVPstNmG3CZywMkiwVHJf2N9dbegLNhRA=;
 b=H+KMxfp9eyzZGIR3+0KqIvMdoZF0t593ymBqzPw+kH/6VFB/OuwFhz5YeM9mZeu7xhC0eX8zAz8zWtPmplNmD1cbc+E2Oki6+GCbOf3aP52Q3BHaI/UeK1L/SycD5dFcx47YsPys8ROg2ccOXp66rvqYodFmxXUKG/ZAE1CeczE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 LV3PR01MB8463.prod.exchangelabs.com (2603:10b6:408:1a2::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.29; Tue, 8 Oct 2024 23:18:43 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%7]) with mapi id 15.20.7982.033; Tue, 8 Oct 2024
 23:18:43 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH 0/3] perf/dwc_pcie: Enable DesignWare PCIe PMU on Ampere SoCs
Date: Tue,  8 Oct 2024 23:18:21 +0000
Message-ID: <20241008231824.5102-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR19CA0023.namprd19.prod.outlook.com
 (2603:10b6:930:8e::29) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|LV3PR01MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 100e180c-1c2f-43ff-f4e3-08dce7ef8d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qMKALGZmN00x9W2RCuhzzSztfobe29zbZRc/hZaOLpkUzRRvemUgXxgmfkzI?=
 =?us-ascii?Q?id4spqwyqo8HmKgzQl6TLfnUHNouRSxJWiqv7KU+Z1RxVwVy9/yo72TFHGVJ?=
 =?us-ascii?Q?pJtYEOnehDwwUe3vzNVNGq+SXYqQZ90BYLRpzCy/nnYme0umse7+V3vmRPWa?=
 =?us-ascii?Q?4VmGMrIdYwJgTA/Q2jXeyRrnMAxBRnVK+BKzH88YSwOSaucCf6+vsjNBglpg?=
 =?us-ascii?Q?fk2/XkCICsxVxcojVTicoh8AKNEGQl9AAJGH9cMOQno/kIIgL1Poq02l5Uan?=
 =?us-ascii?Q?me13EORh7Utf1kCR7FXhY2SuHusDBDddQXaN6XrX6k6hMpHy0bK8NB/uNK7Z?=
 =?us-ascii?Q?2iHMR+2Kta/J4qMi+iCeMYz9Bg5IQ2W+hIdmYxjH9qDk/1fu7HEdRzIU74U5?=
 =?us-ascii?Q?HsU7Z4jQwMBgQahZATv4QKsQbv9qaJw3U5aq5gmhvGLr4X9qXEhfn//Eb6Mx?=
 =?us-ascii?Q?PdeL7kVsh0jaKd6n38Pb3R2OsfUXD9v2XodR5dGRuNBc5h/YmuOB9NFFRb2X?=
 =?us-ascii?Q?zsWrZAr3EsDvjQVdD2nY2vAGUnL5V4KUQB5dg9MspaEXRnMS7RvV2drPDNWI?=
 =?us-ascii?Q?CKvlYkr+oLN1TqpcE0zVdie+lSB+zGUiD9bOvSi7mtZIffgZyuzn7SP8Ejob?=
 =?us-ascii?Q?+c881YHb7mgIC+AvkrEKj0tWg8dE5LGldDzYbF59PX9rO2OGVyM83v+N0qfy?=
 =?us-ascii?Q?Fosq/lfAJVtBj5Avux8EvWqqdNuIleuemkPGgq6H7tTCmxwk6LwtNYWhXty3?=
 =?us-ascii?Q?0K4nUVHhIuKL7OgpbzmxUmQ86NxjRL/m3UXbJkAo70e7aPDYhJ0sjLDdgmnR?=
 =?us-ascii?Q?GABvTM2TjXS5N7t9xTEFk6yautC5gyrACXPDYU+VcqC3pMtHRfY+wJTn0KwQ?=
 =?us-ascii?Q?BQQrTKad7CYSy8FnCgF0VcHa2Wa6qwycUMezDik73UXD1/Wyg6pngbPv0pL4?=
 =?us-ascii?Q?dv1a9a439m58nPLnBnKDLMuVKslMf+/B7YGQX/ts9baKdzVG4+oinTpj0tq5?=
 =?us-ascii?Q?18OstTzIXsWqWWXHpjv3h+xCtmNL/Po4CKfToM/WOmRD8JLIio1KypQXLnsR?=
 =?us-ascii?Q?dnj6g+BId+DIaqgxfqRY6al/lCisITjFyH8ziZejuWsow/o3ehHeRplKfOEi?=
 =?us-ascii?Q?7t6tIOc+hUZqIkrqErvW4IOGKR/OoNYOyvCuO7F89v54umrx06s14DPXrSQ0?=
 =?us-ascii?Q?2oVy5A14l4+aWdhRxmHbfPbggznmRLKcdozIQu9odzOCChnnz+YHfzPXA5Kc?=
 =?us-ascii?Q?UKbsKc2CfghykPvRvmfJ8KgaPIvxR71lsj6mzW4/LBtA7smup5IdR2gFP+OB?=
 =?us-ascii?Q?fJYecew241FjkB3ZuZfmn/WbLkADb8oCBDds2GKcbFhBOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8EYEXRSmLAO4BxZ2ckkR7RYr6bZskDonYI89IqCQdAl7zyWL4Vzlmb+YZfH6?=
 =?us-ascii?Q?wjPvdbesZJM11I8fglyvbdXKxOV0E8D9sxiw4w7CtKp5NTz+2gRvx73pH/7x?=
 =?us-ascii?Q?LpJju58km8UQ6xOEcyBiqZxJkgr6wjrg52MWf06zAwbxXhK0Au5TGu1QlH3m?=
 =?us-ascii?Q?ptivnkPSyRLK4o22D7mmv0DdoINj/2575CfBULNKjyXRGnE42BICbMOqf5kV?=
 =?us-ascii?Q?wEX/nw2uEHZMqxv06qSWRJksoBkzKIYxUdK0C5jGqYvAqsRKuU5/f23sPYks?=
 =?us-ascii?Q?w49rZlVjMrnq0qIefg/tTaCa+ZsTbONDlceK1ck1E5UoKj/tNGy9mRkmnM0T?=
 =?us-ascii?Q?6t5safdAPDLY6vSs67ELwshPU6EwvTUeJLDbvdXkRUIkvH1SirHwhcXJioYl?=
 =?us-ascii?Q?LZQ1MjV5t0rRsxE1LjMlPkgS4m8VGXyFnPx9xdToJSRj/diU5307iGYEdc/c?=
 =?us-ascii?Q?RuZwcqGoI5sy/S7BuldPthFWb+0CPQbahws+4E5e/H6E/pn6JQJIppf4cb0F?=
 =?us-ascii?Q?OZmFLvuCrE8AEwMI6/e1Rmg5eN9kdDIvhX5pAOo1tNeaT931pM/c/MkiLQO0?=
 =?us-ascii?Q?QviRBSUBbQfOAQ5ciG+rDbsr0cFaBBtw4cAzf6cAXvDJUAHP2ERWYqJIn67i?=
 =?us-ascii?Q?bVoWSUTGWARQ23p1VHmCRp8fhXAr6SBJNhVX3zqXjVxANYwboBhkOruGts+b?=
 =?us-ascii?Q?vQjYiqOdMyCSb8nuPKodWyn0Om5VlxXT8wFfVqmmJjiftlguqyncvjth18oY?=
 =?us-ascii?Q?qBSQRrM8Yyf/Mr9f9RM/8YzJpAZyM/jScmOlwNM/F9D4UENw4rtraZ7mwXu7?=
 =?us-ascii?Q?WEDFv0wO/DswfnbhukjG3osILs5ZUwJURlvtJ7z5+KpCJHtCIDm+6QzdtYMc?=
 =?us-ascii?Q?olo4K+mmv81OwDDuyTL+6vROD3ASLb9a9/OsiKAqvv+qGyuOK+xUvdZNHlE5?=
 =?us-ascii?Q?36GI+czFIY1cthulIz2fNLLmAJD6mZv+AriV52CWjnxbzYWOMp+zLQkAICMz?=
 =?us-ascii?Q?3Nm90xXkhvigXAyr6R1vNpFNEY82dn/C1zJtaArqE1hI4Aghp9/NU9df5Tij?=
 =?us-ascii?Q?W7pahIib3OMsl1wS87bDZAxU7CarroKnlj6b1sySPAh426SVx88wHprSGmd4?=
 =?us-ascii?Q?31vB/tSg+HZv4HkL5EhRCi18W/Lk8NlL5Or0rwHxtat84RRKLKOli4lmPmSo?=
 =?us-ascii?Q?oLQu8uKV05+ghVzLNj1E+MnZTkNNq2mtYslTecxiiV0/NsakyoqyFqbmbazq?=
 =?us-ascii?Q?U2GJg+bKjbPijMGHJYgBZw1lEF00uEPNqR9Ug8y9rfAe5Znx5wPwt8px8N2K?=
 =?us-ascii?Q?P2YRL1on3hGeKLdKC2evfFUbW2WMBcPIP2g7OEIZuvwnoRKSxa5FMWrMvB/x?=
 =?us-ascii?Q?bt1caNRQ0myGAi302zDE8RWFMjaeABEZjwsU1TxptvZjQo7WouCQjVwnUBw+?=
 =?us-ascii?Q?EE/6tbt72cOjPZL+6B8M/3pdpAv9nYvbKC+jIaVzGHhevSDxq15f+wN0cwJ5?=
 =?us-ascii?Q?AOQUEacbRCupOOk2arOlVU5Ad/kxHjNgX/ZLwnbhUExBxKkvjgHxBr7DcTC3?=
 =?us-ascii?Q?fv+Z+vjSgDhr2L+35awf10W0pb7VYeK64fJ+mAst7DVZGaVygfWOaY2LcVF9?=
 =?us-ascii?Q?sLMP7LRMunU8TrikvrepQD4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100e180c-1c2f-43ff-f4e3-08dce7ef8d50
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 23:18:43.5470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWNBDcCuv33YFIrOsGuJl8KYE80Qg0n/2RoUYHu5f0T842lRr12pTsoKmJA85t+Uygcj/6I2QCqSowqVdXdrf4YH9FXjH+M7tWrWYfP1u3Fa/RA5Dex10+OexzQgys0A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8463

Enable DesignWare PCIe PMU driver on Ampere SoC. In addition, load the
driver automatically, if the system has a PCI bridge by Ampere

Ilkka Koskinen (3):
  perf/dwc_pcie: Add support for Ampere SoCs
  perf/dwc_pcie: Load DesignWare PCIe PMU driver automatically on Ampere
    SoCs
  perf/dwc_pcie: Fix typos in event names

 drivers/perf/dwc_pcie_pmu.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

-- 
2.46.2


