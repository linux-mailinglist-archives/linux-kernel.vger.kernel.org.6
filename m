Return-Path: <linux-kernel+bounces-356049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2103995B7E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB1C28519C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEDC2185BC;
	Tue,  8 Oct 2024 23:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="J2vj7Kqj"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020112.outbound.protection.outlook.com [52.101.56.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE9D21858E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 23:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429533; cv=fail; b=bbkALd18p7cgwrJIsPVrPZi1tXLI4e12isqzTVTA+zV9XJ3nHLoV4yzjT1+W/8QbFM4YveDtokZnLN9q275OA7W1i98Way5EUeXrE6fpg7BFE29bR3FvIM8cz5bIMmnn3W1DbpHca4SN0bDKJ0oWrP/UAaEuHdrofGQ5Lnha1t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429533; c=relaxed/simple;
	bh=SqarfIXwlLsPVxEZeR6fKukjnURKfoidEPBQZflqa/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PcUm8MJkNKSwyj7MHg7H2fHF572Tml3gg1xNn1kBPlKt8vW/OYqwlZkQ3iLfPxxs2S8jRg2fGm/L9wydEqCCeboTy4c75Hs5LVRXqcKUq71foT1eOFe6bwyAZj73lcvWXfvteTQBgToOVuLeirA/V4O/Z8xUbhFv4Mok0UuH6hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=J2vj7Kqj; arc=fail smtp.client-ip=52.101.56.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wco5JGCZNEv/s7LQQCEZNNxSfnX86z/SRLnerurdHgQhLwpbmEGUOF/ab+Rlk/QCUgA5mwC4gRNL0KNIo2LRqaF0xRRvmJeBmDp5ZtetlGLdyyplrwwctVtwjevvhJmaFSc2ugSdd/B8mJ9jvSUMTXZueigGIMz1/VaQ33YV7rng9jgKfsmXHmOYGQC6DgVqyBXsPhxMdINF5WCuYqWI0Ts+BGKqN/2D7Y0nfUQOL+frwH4/pAusf75R90I26MEVpq1lYNtq+gRoMGombMOXl+b5xmCO171EiOZVCD/S8qgpBtXEzXFiWiOwie3rrrl9S33256ZLIk+9cy3U0XigKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtIuVbdrCUBmzMRw2CVPn0DWaHk/ZhYHbnUuKA4REpw=;
 b=dKpm+7RFC5YwdXxf5VrNKvv3D0GADtw1GehGhs/sZ/aYOUyO5RIceqwaW31w6bK/Nv5CCkbQECn/AP0EgGmdkH0hw6mVAVBAy+LaEjg14hB8rLZi9Qj9t11QyZt1GlNPAoO8lDl5xfQ+9r4nKIEvTk14Y3Aq/SDX0vNlsVhAx6D9zz3n4zpH+ovIrJq0gZS9oUwAm+rvT0gWMZeXaplw9DkiP3oj/gIGxaSdaBrf2koXL09Mn0cdhk6p66cwRdS6BlD2un14uhQV8D0Rr2l9vysoQHBQh58s4YHkWjkF2IsvACIo5Tr0zOhMcbk8XvnQP3NQ3vjjAZJ8EVjAh1yYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtIuVbdrCUBmzMRw2CVPn0DWaHk/ZhYHbnUuKA4REpw=;
 b=J2vj7Kqjohb0+wE48hEXXrHNkoK2JSF70Rd+ECObiM7dlzZRAsiUGYm76wFtnqi9Ul6XS5v8UUPV+A2+0+ZpAGSBXQvhiJ0xLkIPdxHVNckXy0DoygW9rT+vsbHDGBC3MmTyV9fIMkdToaotpcdSe3C+YG71e4JOoIVNu8N1KpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 LV3PR01MB8463.prod.exchangelabs.com (2603:10b6:408:1a2::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.29; Tue, 8 Oct 2024 23:18:49 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%7]) with mapi id 15.20.7982.033; Tue, 8 Oct 2024
 23:18:49 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH 3/3] perf/dwc_pcie: Fix typos in event names
Date: Tue,  8 Oct 2024 23:18:24 +0000
Message-ID: <20241008231824.5102-4-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008231824.5102-1-ilkka@os.amperecomputing.com>
References: <20241008231824.5102-1-ilkka@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4c7160f2-1df5-4d87-09ad-08dce7ef9094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5nlhjCaYMpDD3smhvRgdP4lfyAXxpUSPlH6B3kO9aS9KHXbJXqAM09rFMKfI?=
 =?us-ascii?Q?LYSToDh/pjpf0R6IJZbIuPmiLJTMU+5tkk6dRrhUbji5p8ImOyrSuj3Nh1UI?=
 =?us-ascii?Q?48dX4AYwtCTLYd57tgrBllIa6S/hw7IoLl1hAgSrEvSEuMcCq/DHEa/GAam8?=
 =?us-ascii?Q?3CB7C1TaxysCBV+giRFgWZGm7p5aN9usn394C/gpGJD8EkRcNFtKPZ6SLp6I?=
 =?us-ascii?Q?ZyihZFVWXtZK3mhu3DgWL5hecQK9WsoNPdeDkFcglWsaNbh+O583mfIjpobK?=
 =?us-ascii?Q?Oo9KX5bhpWXKuEKX4UlPVrcgWACmfBKjicS2TTgaqk3KpoIxqNr773YLMNt2?=
 =?us-ascii?Q?uGNY+VEiOkjCBSKr2Bm1bBKW5qkj+fPallehoHnCCIouzJ70ZYEmswuNcAX6?=
 =?us-ascii?Q?3r/M7jHpuWOfGDPHmfjYUv7UqAq01/6QfU0OjkbNXCdXEMTW1+mfFMO75lyI?=
 =?us-ascii?Q?IXjQ2arPbbtwJDHcfANIjYhUSt/bGFvTIIjOZDgrCq18na1+ejsM8NxU8rJw?=
 =?us-ascii?Q?Y3Khvft7lIWU336z97qLGcMIywEhpA+811Rzs5cYA9iCEgOXV1u05B4cr7C8?=
 =?us-ascii?Q?1c7N3qh2zFcRwr4MvlcMioVGAggOSTiDQh5HacNpUAiPeW7geAx3QqQs6+3/?=
 =?us-ascii?Q?rfxNx9clLk8NPMsauKOpCdrpSfBjFKozgY9p5A/DnIhA5jskywoGWGtJhhJa?=
 =?us-ascii?Q?J3JGvu2PanhUt/2ALY+F13KQZC+lasWUArwcfRWIOX96L4bdiJL1pyMeLxht?=
 =?us-ascii?Q?szU/2YJtZe4EuexsYsIMJRbdXRwnyKd+6aNMt6Kdo6amoiEyD9CEFqIz2Mfk?=
 =?us-ascii?Q?pTmSAelGsQCK2oQYJu3X6jsE6zIvcMAYk7/p7FzoX0y5c5u6qcXIXJr22yDY?=
 =?us-ascii?Q?qlAhAz+Qj0SlCDLLaIHRP1JkbAd1/7VvKVv8DpTaDtI3+lgkcuMtL56fhXB1?=
 =?us-ascii?Q?mvX1PjxGip2qn3xHaJJMl4pjqNTOKzCA/OGMA8Uef4KO/KS2kr2z8qedudpi?=
 =?us-ascii?Q?oqG/XGhzCrF3mbxGJKd1VTp41jtxIXfmiYO0NpsBvdFaOtsSAI6xjBDFoEJb?=
 =?us-ascii?Q?2PRKbsBYbkDLyOnTbMRsLUPQWmR1txrXVKq9N6bV8tuWulIowW4k7h0kIzrF?=
 =?us-ascii?Q?vBN7dsJeSuUfmrFz/z5lne1jUHucGr4NOVIBlVxtMV3C3ATAJ1n++Ax+4/Gh?=
 =?us-ascii?Q?emhIjKObAnbBbiNz90zjewTqIoQ8oK1nQgTxIK265kdns4DHu+dD+QPTO0HF?=
 =?us-ascii?Q?fd65Ks5p26rpEXHIlYz+AlXXModUhYMP8RXyHnzq+FdBFIY9yIXGFEfZQWey?=
 =?us-ascii?Q?+phV0JXkOsxhd2jYkHmMMBdO1r6mN5SO0mXlQ7pqghrDbg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HCgrK6fFw+jXnG8MlINfufxsvbDtRAfL/nDQUZnH2AUUtFpG3AP43N/a6gg/?=
 =?us-ascii?Q?tOrNvYMS/gN8q+bk1aDGNsp2g6c5bFqOxLX1/NLCbWzqWoQFM2yXk+AaNqXO?=
 =?us-ascii?Q?uaYwmkK5MGTV0YAQe2fpQcLoma87kqCbm/On8vhVqgjB3huBkg/HuBxgD//3?=
 =?us-ascii?Q?qCv/4eKTlMF1DKi5V8gq7E09AcdG6HOH8sM9zhytY2Tqk0OlRMI1rpCixjMB?=
 =?us-ascii?Q?kNCGCqKrzF73xw32lPwPjye4i80P65Yhr7o40D/Wjz5nZjuy62Ji84r+6vlR?=
 =?us-ascii?Q?/RN/geEJS95NVhrjNXdsSq2/3mDnGwM6fHcH/wIjVlAkIab8mXN+LgFIfXkN?=
 =?us-ascii?Q?1Lsplf94fyKWbIdJ3GLqkHvXvRUUmIk5eu2FtHrnoeDIuICOeS24HALq6ozh?=
 =?us-ascii?Q?TEJNfw7PHPumIpIF53Pq6e8RkUfMgvt0efeN5Ch+fTWGNIq15qOxFuZ1EYzJ?=
 =?us-ascii?Q?swxm/ccJHF/3Aom595wkg5g527yhhgaEIE+27zP7F0w0pTuO5s27ZvIsySja?=
 =?us-ascii?Q?m3QD1EkxJJaR2idKIYEUWyn1MvTUZJ5EnTyKPx1l4wHDCOOSBX9g2Hn6F4z/?=
 =?us-ascii?Q?QEi1t0nkq2LjXiX+Fz1a6fjPj7GynpuQcnxVwAK007NxDOM343MWXHjkMomR?=
 =?us-ascii?Q?ESDJrhIV4axBvL9l4+lNy5x68yfyV06rq7hqMc6LXQjjSkscruMx2OE5hKtq?=
 =?us-ascii?Q?lPn1w/bfdJSmLWU9BZSWrx+SW5FT5WhNYaJJOzX/7pFRSIot+4U0Y7IJIPy9?=
 =?us-ascii?Q?hs71oxvJpMxBO1X6e/p1YuKKAzB3am6fkE8pMdqR91x7f1mhLYCAMGSiIUIt?=
 =?us-ascii?Q?adjH/BRh0ZSfVnJt3GFJVJExxyHO7IlVApxOvJzdDcVIAZX1XSKHseQlQGc0?=
 =?us-ascii?Q?Lw4+dTgjqU2wgIXgdVgT2mfgSx99o3sBGy5IjA7AyhP6NLTWov41zx4NmnKp?=
 =?us-ascii?Q?FT4CwMUToHeEeXRsLCcSuRFG5XD6cQYdRGsnhCtEFEQ3VVNrNYdxoBSouaCX?=
 =?us-ascii?Q?r31BJgxn2D7EhbniY4GSDtc9VNLNaOL5ANRWgVhtpv5SYNqGbXIu8CGvfnzh?=
 =?us-ascii?Q?HCNG2kmegS9ILoJepyvEltwnQvz6vghxBpeIcVWRLiY+yjML+b5SPHeWkQ96?=
 =?us-ascii?Q?svjPaW7gtGwVWwLY2xQHltiLGrj5cwTrysMpdJeldDqk5aQqfs5wOrhrKGNM?=
 =?us-ascii?Q?470BeB4lSyLuteMKPbQ+ZbPUoRtzAabEuvBRH7sazoYgGmVUHHnFdZ99D7ut?=
 =?us-ascii?Q?Sa2I43uHzJljmjq+2Y4lykb/1W/v1p7FpnB9zE2s/md7E/5e/sAqcABMp02M?=
 =?us-ascii?Q?ma1Fygu7kzmh6oxl3tA7/c/0Skzy1D2tdlesmav/kGzhwBLhufi77PdaR8xo?=
 =?us-ascii?Q?WY8K1/bg68glTVehBy6uc0hbad82HWIgPgkie6XOiaotntKYPdYuiERWNSbU?=
 =?us-ascii?Q?eHC9U20t3iw9a16s2B1+ltDP/G/s99fPVrCZtm4nSoTFS7LInlzQLFqZH6OT?=
 =?us-ascii?Q?1ZhzWaZLj2Ybd2JZILSVz13zMWOefbI+J9k0bx9O/E4OaNoZTawFIOXrdzTK?=
 =?us-ascii?Q?KbR8U8Whh/XV77+XuEW9mtCS0AjI1pwfNIUGaeTC10ZyykZ37bN+ewfCjCOf?=
 =?us-ascii?Q?ur+cByjOZk6dvUsdXAz7OJA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7160f2-1df5-4d87-09ad-08dce7ef9094
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 23:18:48.9627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erF2Vjv+254g3j7Qu2EnF/PW0etckwDBvwGgO/4/MVFQ5v/LsMvst1Qro3Z2jRFsAzg54iqw3VT0rVdyBJ/f5vuRus1rWx0lgZ91L3nwv6VQn+FPizj+vALEQgYLUdBQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8463

Fix a few typos in event names

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/dwc_pcie_pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index d752168733cf..6e2214a6d6d8 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -217,9 +217,9 @@ static struct attribute *dwc_pcie_pmu_time_event_attrs[] = {
 	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_update_fc_dllp, 0x601),
 	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_ack_dllp, 0x602),
 	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_update_fc_dllp, 0x603),
-	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_nulified_tlp, 0x604),
-	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_nulified_tlp, 0x605),
-	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_duplicate_tl, 0x606),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_nullified_tlp, 0x604),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_nullified_tlp, 0x605),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_duplicate_tlp, 0x606),
 	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_memory_write, 0x700),
 	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_memory_read, 0x701),
 	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_configuration_write, 0x702),
-- 
2.46.2


