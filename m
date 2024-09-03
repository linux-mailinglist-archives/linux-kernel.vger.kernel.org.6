Return-Path: <linux-kernel+bounces-312815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEED969BFD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B024F1C20D22
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CEA1C9862;
	Tue,  3 Sep 2024 11:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kbM1NXL6"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F5B1A42D8;
	Tue,  3 Sep 2024 11:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363355; cv=fail; b=D8hp09POVokwc59LI5pKNwcwTOlF4fLLwQW4F/EWfSeLyCnCf+7g+6KcpJ/vqHH5CLDi+svHhZznFIL5I8BfFlixw6NSH6Kc7+t4F0a/0Hg3fqcny/bWlQTpkWo91VetKlHwQH8IBlHTx0b9qqMQLghc2z0uEIVEH/wjh8nhHgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363355; c=relaxed/simple;
	bh=CvNlxEP3SH6unceMv6raEfXf94xthuFOXRSTkaWnuZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R39qqMwXQWp7zyqiUfshqtvFMGUlY+mrlF8j2iEnwS5M1lb8IrTYL2yQAuyb0Aas8BGvUZlrxvgJ33ZCI6GAAyTkCDyh+BPjySqJm0S73uANXu7TtbrAmnX2aHkoNnH+bX4rWGCiVl8stBDJCvPbS5tSdCQ5s5Ldn1TpAiZGUUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kbM1NXL6; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oizTbxx1f0IUNUrkcRG1mApb3d+Vx+RiNndybNNkJVJK2P6gD/wqaYY2oSan6s6C+NJbj3s47Eln05JKjIJxYZfC6abTglzRd52ubs3Rqwdd7ujfmRS6pPAtWmRTJ6goLYepLI0IfaIxRPgbLVlkLqFnApFUpSZVvVMr0zAkQgYWcg/uh33v/0Pz8hOgkAkWwdNVcPU3pHRd3ASDGeMKzR3v4XcPiFkcmLoBnTl6OVK1NFyZ4TjTqE5OYCy8MvueNig50NROIXeQDW0fj+LhHS87+NruTplkxvC4mXOcuvSkCN0xkQKXB7eN65fsr2y/vEnJdX7thhgW7t5yeMfYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoYfDpXZYeD4NRq1FRTE5REBJVFe8xXnmX1KJSnAlyY=;
 b=IKzs7LvUa2zdLjukXUrnPBcQeqGwyaKZvyQhlMT8OYvp/2SdKSRF+g25AJDQZl10HBOQ3GgK5KL4vHLnqDoVm69gMHYCw3xktjcILKIFNCji4P/Xyvc0sujKePtPbWw1U+duPXOWA1WIVc8NBqJHP0YR8iPI7CNwsWSaz1okPRHK/It6XU4giS8ka872cgIuhN8q5rT8p+RPYeB1KKUIIsS9Yo6tO78h46X5KXtwj7p0rIVLNfCIzQR5Ag2qIxu/FqTYA3snwDJVsDUvqgddbrXc9mAkUZjfop2h9PFAave3ecyg+gBwDegfJLNTT700IFpAingjWXzjn7V/KfAy7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoYfDpXZYeD4NRq1FRTE5REBJVFe8xXnmX1KJSnAlyY=;
 b=kbM1NXL6yaVpsL9r+LoFyAEjZe8QiO4jGhTOnVOicFiBKmHVX9EozrUufRo7gHO5kpY7U2g3fUBKzw1Y7XUatzo2F8Y7f2gexYeqUusLuFiLGTIJc6bQvkKSQu8dl6d64RG+lqeWla1t6t8yhSwR0wVQNq4T4e1TGT8LyTjviVk=
Received: from SJ0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:33a::25)
 by SJ2PR12MB8157.namprd12.prod.outlook.com (2603:10b6:a03:4fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 11:35:49 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::57) by SJ0PR03CA0020.outlook.office365.com
 (2603:10b6:a03:33a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Tue, 3 Sep 2024 11:35:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 11:35:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 06:35:48 -0500
Received: from prasad-r9-mach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Sep 2024 06:35:39 -0500
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <syed.sabakareem@amd.com>, "Venkata Prasad
 Potturu" <venkataprasad.potturu@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, "Syed Saba Kareem" <Syed.SabaKareem@amd.com>, Jeff Johnson
	<quic_jjohnson@quicinc.com>, "open list:SOUND - SOC LAYER / DYNAMIC AUDIO
 POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 07/12] ASoC: amd: acp: Set i2s clock for acp7.0 platform
Date: Tue, 3 Sep 2024 17:04:22 +0530
Message-ID: <20240903113427.182997-8-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240903113427.182997-1-venkataprasad.potturu@amd.com>
References: <20240903113427.182997-1-venkataprasad.potturu@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkataprasad.potturu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|SJ2PR12MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cdb5441-6732-4dfc-4c22-08dccc0c8f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XcSjSvs2sgY/JLqsWwZKISRdCjgMY/Ftt+PKjSCLKuuFyoYgxQ6FGvfdm45t?=
 =?us-ascii?Q?YbCGie35R0EqyFQ8wEwhhZgrot1W4hu9Ljtinx36InUCcEeW1DJGFIGcrfvD?=
 =?us-ascii?Q?IO8z+aGyQbpOXhXorLDsmjwJxNFoztbFI3tuLGGbcZI5n7a5Z9CPFRvYMAEf?=
 =?us-ascii?Q?ZbefK0UUOtOrsdEqhGK8YOUyLu70mil5AoHY9j1l9f5kCu74ybpPcsQP8Xz7?=
 =?us-ascii?Q?tsuCW8V43AeS7bN8osJGDl4G7g36d3Kq3LxweAh3gOAwLMoH/r1NuayOpifn?=
 =?us-ascii?Q?aIXxiQUFRYaTJFIc7X88zxFHSe13A/zcBqQLqHrduFQHY3EIaNlMRUDZG0Bm?=
 =?us-ascii?Q?gPvAoQpJr2UR45GIpvaJNA8aemcv/7GmEEJRAYgVIU7EjRC3CNSJqRIcU2y8?=
 =?us-ascii?Q?W/W3aZ1rxlCETftLvWF3kgzAalXbBLQx/r70BbeW4BHqjlrE1P5zpPoXNcrK?=
 =?us-ascii?Q?ylfgHGGzyINlXK/Kn52CcdlmZmbcab8khCc3qRXybn1+ye7setG9Y2V4xJBK?=
 =?us-ascii?Q?ZVTTmIAkYQf8Ht4LOGZxKD8EsTSt3DWU7jqK8PXkuUlKhpSzcpFiT+f++pfs?=
 =?us-ascii?Q?HooeffqlXFruZm30+bAgVqPsLlietSebZPiT9/ApH/pkqQjzFVP87DuGuQx5?=
 =?us-ascii?Q?92Wu3vHiz+NC8Y+ytXzG5crQErFkjwITUBBhqEjQpV5JdGzA2oh2UJEzz0Lp?=
 =?us-ascii?Q?9qe3mhclznXj/1MrU8cl+ZWiQT02/T2Yp6vWBicpjHVqWf5OuK1YJiOLZ4cw?=
 =?us-ascii?Q?UZ8HjIgicFHYoN9N2EDkJRsx5csZnWE03wFiUOw8MfVSveKw+y3Imwxshe2H?=
 =?us-ascii?Q?nKHh+mtzyw6I4CPiKWK6cUuF+eb26ezoCKfsNaPsiV1SWEwlJMQAaS51SHsY?=
 =?us-ascii?Q?707A25IJxs+vugehjfKpI6Q0Sp2wj7pOKBHXb5eZBIkZTrvBG9/wGMaAhI3y?=
 =?us-ascii?Q?GZRaBz5bv/IMACQ5A6RnqQ05F0xPBo7JU1QMLROB7TS3DeuN+OlYYfTwN41V?=
 =?us-ascii?Q?GhusZ2YDWR/buU4P+SA4kjm+h6Zrx2DRg2fYWzcclhM/M8w/rxnyUrIbWKUO?=
 =?us-ascii?Q?DAQ/Wk3WVfdXRo87tOafWHCIBrMZchuq2n79P9VjMgcaFtqDAE7ldm670q27?=
 =?us-ascii?Q?LB1OQ9s/AOXNGVsrOQm5MNN2+Lj0enLvUQHqonqnF+iZcEX0VLIknAiQbcdT?=
 =?us-ascii?Q?Ih/Jy1Fm0EJdrIaw/WhDfnpTKwTnDioaZ3d3sL+rya7lxyyIeU5CYbb+MILp?=
 =?us-ascii?Q?dTvNJti4M72jK2wGh9n+NhIUJiQoGuHQwfJ25ZYv9zAjS6FjSl/YUNX3Jh8X?=
 =?us-ascii?Q?COb5cUiUdkksV+f8YFPtpn/DNjoOeoUMqITwiXmOh6fYixrRP9mek/oS5tS+?=
 =?us-ascii?Q?OTaxeT7gq6NFvMfc7G/iXkfCXundOsbxxbWLdP7icLc9/6r/5cCFEJp+Tend?=
 =?us-ascii?Q?yZFifDY7fPmUzCtdWcOUhETbfRDduiI5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 11:35:49.0588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cdb5441-6732-4dfc-4c22-08dccc0c8f1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8157

Set i2s bclk and lrclk for acp7.0 platform.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-i2s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/acp/acp-i2s.c b/sound/soc/amd/acp/acp-i2s.c
index eceffc69bf3e..31475a4dbced 100644
--- a/sound/soc/amd/acp/acp-i2s.c
+++ b/sound/soc/amd/acp/acp-i2s.c
@@ -60,6 +60,7 @@ static inline void acp_set_i2s_clk(struct acp_dev_data *adata, int dai_id)
 
 	switch (chip->acp_rev) {
 	case ACP63_DEV:
+	case ACP70_DEV:
 		val |= FIELD_PREP(ACP63_LRCLK_DIV_FIELD, adata->lrclk_div);
 		val |= FIELD_PREP(ACP63_BCLK_DIV_FIELD, adata->bclk_div);
 		break;
-- 
2.39.2


