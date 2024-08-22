Return-Path: <linux-kernel+bounces-296744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDAE95AE72
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B9F1F2256C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A63D13C812;
	Thu, 22 Aug 2024 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="e1AwMQMr"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010047.outbound.protection.outlook.com [52.101.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9E84963A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310674; cv=fail; b=E6ZI9S8JXFRnxOukuy69wJgCYzKEcQzKd3AuEQ60CuLiWqryWcRYpTQhMXAHJuU9ttMwmz83z3Gl1g/j9uu/BOIjAr8Ta24mVChtplXiDZ1KnJcjyosaOAdwxd7mvXJohSswq3DJGHLKvxeAILte3zATcxTnoAlN1MWQishRy8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310674; c=relaxed/simple;
	bh=4sLkYz3kotVFgqYkPuDWL6KEdKzx9YHMrUw50uh1Kz0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CsD8y17RaFjH3l4Cqz8ITUWnBwKsVAhdKPj46sFMYCHuI+EYFZEaVsjUW0gojPu8Uk+Bn3VtUXB0nmeEi4FzTpsKusfpMkC8eJFgVDikOfr1YO+H3la/5neDH9J5qUGNgTVx5KKdXpABGPrS1CePXHupi9D9K0i9zuGVVkTcm7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=e1AwMQMr; arc=fail smtp.client-ip=52.101.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTZz8ZAIZlVnGysvXXKVIDdvtpNoQYEZbMpbSDFnRc0zzIUPSREdP23tuZHtUk0LEVmAyddwCR6gw3eUe+MqH7QLH3G6lhr7d5gfgyIiYRMVRPJIF5oYGJA9IaWc8ePQPX/73Sqou4Dr+Q+ctrRr9qiu1ZzwglCSs45PU/PAVMpbAa8Yj+o26raQLVYJJRQ/VOeAaLyomKjIIq9GDQL6AA1L38E3saMQfJqszOWUPtnRP/vUVA12dHVSJdQBoRolY7lq4njeWMqNjfhJCQhAc6aQ3Jo335K56XTthqxjdAXichd/eINz+xnX01dgyk+oEdbsO+pCnp6/bbDSE+5sNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3i9MlsMghJyLZQjdNWYFTuWDk8mbnH5lmqE/00Vz0M=;
 b=Zhabvnas9A7PhP+f0QNPTY/KRTKgeiaY0Dmt9rMVtqyupzIrK2UYAyFZRVi+YYQT4Pe3fggD0EK+T8zFeheJDinF6RDK1L/C3z8qx/J3OYKXM6x8KMo7WYGEtGhP8IWDHqWfGoe0hrRFlsOHhIMHiQsukbEpLTYiVIND0mwFsTfomVd1uAs9dnXrS2X4/T6Lnw8UI8qWNUJLJi2Y4nu+Ir7iVwkXPLvVw3eKuJYKWh30Lu5dwuzMSqrGys5JoGS8jllYrYytjB3Ndg00F90rzWYLlZKt3GIB30rNMRc2Fc6xiJkZICsjsHnqNfmP9Npb2aioCf3shiFvRr7UHFXBpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3i9MlsMghJyLZQjdNWYFTuWDk8mbnH5lmqE/00Vz0M=;
 b=e1AwMQMrELxU1KxZH5DcpP7IBk1fGqCxe7DkBcOoTnMaULeZKwbF0MuJi0IxQDwi7G6oYzBJCSvKxSN3iIWi2z8uAnZ8qQxQNOH9llTWoPtHbAaoC8RnzgvtdUz4GuQiqimB3ohOQAbOpvOG2KWwlxeBm9Ex+KYQmPgAqHanwaUXzu0Uth/cx55spfS+3T9gWhRwFVWYwo3cHG3FToxeo5aR9n8l7ZjPW4qmDHqUuZ32jnyvwyZ7l7jyhdYc5oToiGoSzFgok5Ylx9ai9Q7O05J2N1r8jBUIci/f9qU2g5L/CDkxJrcMaIHL59YL/FyiEWMaexwHurcmlhB4j0oEyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by TYSPR06MB7257.apcprd06.prod.outlook.com (2603:1096:405:81::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 07:11:08 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 07:11:08 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Yang Ruibin <11162571@vivo.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] drivers:smumgr:Variable names should be consistent with other modules
Date: Thu, 22 Aug 2024 15:10:55 +0800
Message-Id: <20240822071056.1342551-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0135.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::15) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|TYSPR06MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: da174f75-fff9-4499-b06b-08dcc279984a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GoVa1i9oIdKAxHBpMjvQJCfOuPblprbyHTFsgG0bSaNsDmIsB+jDcg9mGt6f?=
 =?us-ascii?Q?L8X3Q/pVEuYPJARyu04A4zgwkkTR3q7cYLKeE5J5xM9yWjRM9z/Ls2HIJIRb?=
 =?us-ascii?Q?NWuWnruzd8SX2vhm5LhH7Zhc7BckWHgkQZ1jNWPjKrDQshq/lk4ju+1VwuHt?=
 =?us-ascii?Q?MtgRH657Ch9YuEhCRhCDrDfJkcU6+y7d2gwD4H3putSNXoqGiry+v+8606qc?=
 =?us-ascii?Q?wGS922g6RN5qvmHs7erqYy6azNe0GHCS7c0S/BVBkSzVi83171FHr4j1uMO7?=
 =?us-ascii?Q?w7/hjVZLLWWU2Rne7BphiBdIihADKxAgTugOT+tXs4zrLIDnjeUIR8+w0HhY?=
 =?us-ascii?Q?OHT06PICTb4Ds1K8sYbQdqyzcMTSl1XSabQS5GVFIpjGYrrpeUAh8WTSFScV?=
 =?us-ascii?Q?NGB8CHnY03N+mlMpIB7/1LDw+QCO4muQFB0hM/JJYOGTg3XlZCBa4O/899is?=
 =?us-ascii?Q?HpcjEKxQ/7MGmgUPkjTtrpWFfHvOrB/hzxAXRf2kxkvnzp3xwZaeP/cEoUyv?=
 =?us-ascii?Q?NvMLIBgOT2WFtj657AVz5vT7cbte4T7A9pQ0/DtfOaFAK7+J2NL4Ab/KWvK6?=
 =?us-ascii?Q?s8TZ02Vm4Be+L1CFR4F7/NbbfHLQXxccl5BPUxSmRVQdOVS0LcnhMCJxZdSo?=
 =?us-ascii?Q?QKFY6XEyqEsMKh4bTFnphuFzICJtbtzzB5TtdfcydxBdhtHuYd6uozOuuKDU?=
 =?us-ascii?Q?x7Sab0AEOthJ8jvETKyt8xHIizTL4ZVVBUBhMkLPb6cGI/tMg3nJjADZpG5n?=
 =?us-ascii?Q?1Ih2syg7Y+5QWhcBsx3WkOjcG0jU/9H//By18hxRxIaxpQ9dKxSfbbTAyeDd?=
 =?us-ascii?Q?Ze4a3fKuHiyAs69MIlg27IFUCsL6p9B5F80pUTTsDbZnNkHBlTAb7SX4TdIi?=
 =?us-ascii?Q?KPVO55sXPY3qJx8L4MI+hXn0nS5BcH5jTIR3tMwqpgePFV9A55jJlwLTT39W?=
 =?us-ascii?Q?eHrT/r+Q0OLa1QvRCeziti27jwycsKu0z35GgyYHGb1cMwCx/nPI13eb/b+2?=
 =?us-ascii?Q?hMoQMC1tClUwwuIWlCO+bq1Au5Av2cfqcvVJ0g+IQDiDqMyb4YYNKGPXh5nc?=
 =?us-ascii?Q?tHoY3QVEpymWcDC7v7k1NJ7IkxKk3Ko+IFUf938ecAOT2Xl3HIfco2634wGN?=
 =?us-ascii?Q?bFBpFQtiBYpVlv/HCiLInzI65JT4CBCWf2NUrbPoV0f4CTfHynYf+NzA7Ri4?=
 =?us-ascii?Q?Mwe7bs/Vk0uOU5flu8Ui15QIdvtzUbbwqPamuhxVjC74Hyi5q70hexxhfK7B?=
 =?us-ascii?Q?mGdWJ+0vzT+PUi5EkztSRVQVd/dJRWvAF10btcLGmz5Xc9G/wXBr+Anwm/vR?=
 =?us-ascii?Q?XEAKtde8Ht62fslThnNUr0vDgtIpSk2L/pCPHUKxUipaemA1Ctukwobz4sgo?=
 =?us-ascii?Q?ON0IOEna/Ktp3UtpsZqX+xZnbMKezlVIO2WncJcXWr1wVfcuFHSrDAKj70Wc?=
 =?us-ascii?Q?jxa3tlJ/OfHlQr4aIoyqYfGE+3PND+Xk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8GH/TN0wVl9G0pqmz7hG799MZ7nXkSVRumQfQITJSzKTI9RwV32lNrAKD2HI?=
 =?us-ascii?Q?VxAGiyTFwd4+bWSAMR22bhftSw21k3DuC1PIJ5vUuWvd6xE90OPjGrH1Mx93?=
 =?us-ascii?Q?xA8+WAFV4eh7fN+QwzL7+MgliPHcWQVUZXMHTqEcapJkHfd9Li4YpZ8NRvft?=
 =?us-ascii?Q?+QOrN/ESoQW5Ul/bBIAkpALfdZh5BIPKRMD7U8WaUOOTle5YgUDMM4mov758?=
 =?us-ascii?Q?h5QyOfoZhIJEIqGr50+toF20vXS0G83oAStwMqlljV0HjCyXTW8xAI6ec5yi?=
 =?us-ascii?Q?LXMKaQDNqu37s/IdsbATdm9ny9Tonz1rF284bcli8YW3UHK3hbkGejTOkxGm?=
 =?us-ascii?Q?26W+8Ju88VmMlZQ1OYkfVdn8QS+GKHGmj0KUOkHMPu/yhAgHn1wQg/YDe6cI?=
 =?us-ascii?Q?Y2UNsyUbAVc1z6WaVs3njIYDXS+ii3NMPIUUO855dfpkPxj7G9F1m88QmYEM?=
 =?us-ascii?Q?TdWhJ6bC9Klkwsp0nRM2eibtq8a0yBMLZtps3DpWhakQjmbegsU52+43+KCi?=
 =?us-ascii?Q?IGGEgqrkLGdpOWgCnVwsfFurODcTjRyOBRZ3pDD4zvknN58IWeczM8JQmou2?=
 =?us-ascii?Q?b4GbBCPDQihsJzTgA5bGWpy8yzbMaroeer8l5SqO5u49NCP6wju9CZueqK9J?=
 =?us-ascii?Q?SCbh+he3vRq0EP8XwIkFt8xZikKDkbUki9UmhmoWveVn2ojf9dMQHR+VSiGN?=
 =?us-ascii?Q?kSZ4W1kQZHEm5403ckdlotY0HzbXNPGvKaiv77iJX5PON9l216M7ltwJT1xt?=
 =?us-ascii?Q?BH/hitrD8E9IT2TPQ1m+1DIE5m6bMF5qCwF4RQq5G2DnRj6oeOsVYsEoBeuv?=
 =?us-ascii?Q?kz7vASz8RkJi0JKwY9Wa1dDRigcoyqw36Tkozk4sGKVbkaouN0J/FCGzNI/V?=
 =?us-ascii?Q?ukoWlsi/5pytBBf0Eo7m4kOjdYe/79UpXaPJuQPm8EynTAjRsWoMVpzEm7ic?=
 =?us-ascii?Q?udrF4ZABQZMNGZIJ29KsJ436vmeWqJ1UeeRpSeJetn0Qn0m15+c78OqhurPt?=
 =?us-ascii?Q?PQgA3i7E/4DoAedJWOHgIIqN3ONQbKlk1m/Jr8KtTNyBuHkr9MPorjRc3zoH?=
 =?us-ascii?Q?ClNf4g86zVST4epicp49cRQ9+6LeKBLidJ5MzkWtYiP6GbbjBnf6Ee5DMG8P?=
 =?us-ascii?Q?+LYUiXs9BX6XXxPrGXjeWtaHFbFJRvE3HofU29RhflfQNb2kDilMLOHIKAGb?=
 =?us-ascii?Q?ZoZgyzqE9Ow8TLeE2xSXRvxuJAErXBVvUSNthr403JVC23zgd9jUndIcRSbo?=
 =?us-ascii?Q?2wJt+9fKUx5vNbgAObqHMOPA9cr84EvVZtvsUuo+yZuo4CCYW69IpFr3JD9v?=
 =?us-ascii?Q?L8V3DnsxToim3xArWtAYgBLdRQ/iOA4pt3T+DusF1Y3VYsL73rFIKPEmgWUL?=
 =?us-ascii?Q?8HtGewhqQhGBWH8zdlj7HXXtM/mRtq2YuVDzQNxTXVnVISYxUJoiyDb7mQFl?=
 =?us-ascii?Q?W2q+Dz0jQRg1eUP7w/UpbFguPDHspeK002Ys7I6zlMD89LxdTi0KNZwOuQlP?=
 =?us-ascii?Q?TrrIEhWb3rVwjvqHEFN+UOuce+O++iAG/9inhT6txR5d8dFP5PkDvW0xZ8Bl?=
 =?us-ascii?Q?UkBbY8lDAOQfkaBXHy/xIeV5O/A/ZeOH5qw8FlUc?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da174f75-fff9-4499-b06b-08dcc279984a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 07:11:08.7251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkhsozhsO6gX0Hx/k+DeCgjYqAUiegM0bMs5YZyrwTbCIu8HeJ3Ws8FCQX73MsBrZCMWLgt5MqVvT+5AeDNSOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7257

The variable highest_pcie_level_enabled is named 
hightest_pcie_level_enabled in other modules. 
Please ensure the consistency of variable naming
and use min macros instead of the triadic operator.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 .../amd/pm/powerplay/smumgr/iceland_smumgr.c    | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
index 17d2f5bff..165fbfa2e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
@@ -970,7 +970,7 @@ static int iceland_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
 	SMU71_Discrete_GraphicsLevel *levels = smu_data->smc_state_table.GraphicsLevel;
 
 	uint32_t i;
-	uint8_t highest_pcie_level_enabled = 0;
+	uint8_t hightest_pcie_level_enabled = 0;
 	uint8_t lowest_pcie_level_enabled = 0, mid_pcie_level_enabled = 0;
 	uint8_t count = 0;
 	int result = 0;
@@ -1003,8 +1003,8 @@ static int iceland_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
 		phm_get_dpm_level_enable_mask_value(&dpm_table->sclk_table);
 
 	while ((data->dpm_level_enable_mask.pcie_dpm_enable_mask &
-				(1 << (highest_pcie_level_enabled + 1))) != 0) {
-		highest_pcie_level_enabled++;
+				(1 << (hightest_pcie_level_enabled + 1))) != 0) {
+		hightest_pcie_level_enabled++;
 	}
 
 	while ((data->dpm_level_enable_mask.pcie_dpm_enable_mask &
@@ -1012,19 +1012,18 @@ static int iceland_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
 		lowest_pcie_level_enabled++;
 	}
 
-	while ((count < highest_pcie_level_enabled) &&
+	while ((count < hightest_pcie_level_enabled) &&
 			((data->dpm_level_enable_mask.pcie_dpm_enable_mask &
 				(1 << (lowest_pcie_level_enabled + 1 + count))) == 0)) {
 		count++;
 	}
 
-	mid_pcie_level_enabled = (lowest_pcie_level_enabled+1+count) < highest_pcie_level_enabled ?
-		(lowest_pcie_level_enabled+1+count) : highest_pcie_level_enabled;
+	mid_pcie_level_enabled = min(lowest_pcie_level_enabled + 1 + count,
+					hightest_pcie_level_enabled);
 
-
-	/* set pcieDpmLevel to highest_pcie_level_enabled*/
+	/* set pcieDpmLevel to hightest_pcie_level_enabled*/
 	for (i = 2; i < dpm_table->sclk_table.count; i++) {
-		smu_data->smc_state_table.GraphicsLevel[i].pcieDpmLevel = highest_pcie_level_enabled;
+		smu_data->smc_state_table.GraphicsLevel[i].pcieDpmLevel =
+					hightest_pcie_level_enabled;
 	}
 
 	/* set pcieDpmLevel to lowest_pcie_level_enabled*/
-- 
2.34.1


