Return-Path: <linux-kernel+bounces-254172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE52932FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763A6282956
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02141A01BD;
	Tue, 16 Jul 2024 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LmStK/SB"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225EB19B587
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721153647; cv=fail; b=R2V62KM77VWG8BH0qghF9B5NMqJXZ8e2SpWrQRYkG8wZw3zGPaRv6uWBw/Xgkis74QqU14WLEApJS7mK6NzoPlmRw4DJ297fjpF8U5vwOA4MX4WwIIpaoDlY3kL36hzIFIrGpTXbiuIKcYv5Q8eqSX+3chOFmlCxhuFQXUAAm+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721153647; c=relaxed/simple;
	bh=zFDCMVThmC8Br2GmUL9lYsuQ8LL5iip0yBKWdIR6G8w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F+PrJ1NUishoGV4B4YXJSdnTATQv0THYgSoq/FcOJEgCB0WUo8BoHx37xRJW2xVWOeM9X+xY70MsX1JNXmL+dami3/0w0AuG926Y4y8t46iAWzVMLfiiiFtFaglxfO8D9+CKxNwrXrBR43EYSPZNMSUTEEn0svJtHtuXd2gqn34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LmStK/SB; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRLpt/udJPIW0jaEn+nFpMj/xK+vYv5hdWA2/81KcyOs1/9OftNiEKpOR2kGwsotkP+9yWhpFEI7/IamF06pATOjT2BwEk1oS6QuSI+MnhEbIAz9/4x1VVxFK0L+vigbKRut8RtFBP/Om49DULIMFAhI4EBcWxutZ1yAFVoY9zXnuo5L9yBX00AEL7aWGedb+cuEcI9GrrG7kgZXa7C66pHwkJTzMprkyUEAAfSUr3beJpS3tmRRF0JTA8Kab6owvN4apXyWdD0b/Uh8nMtfIZtFhofAfC73WkHERsXJbTFFfuEvYdrz305JR3oRwFkkEAHks0eyCy9B0bsKRVYbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YFLMKoXEup6MNwJypMdgfK2s4dEbxrAwcwQWExBlG8=;
 b=spwb+hWfZsvs+D3JZAc37gdLiAAusy0LO7LrUmvGZA3NhbtTfwbMVCas6GcR036dmPK1Jl97Dt9A3A+pt+mGM5hfUP5odD+1bEut1zlTEULLNGAB0uiUxAlVrZ6XSsKAXa4sgA0Dpt0a9x06JPfnMXWlyOOdhflyR3/sQEhrKgTvAvITWt/9/wmhXmFJ/ViESqYeeo6jO4/gRv3kkKgaGwuo8WlE22vpOPjO8ENH4kZdUtc89T4qzAOfhdCLSzd8xzbi+J3ihZynGUZgglCIPfq9htJME1X7tTLI09rRjtLhOUpbQk1G2yCLYGC/viEITvIgfEBZrpeAKv5AbRXKNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YFLMKoXEup6MNwJypMdgfK2s4dEbxrAwcwQWExBlG8=;
 b=LmStK/SBAptA/+8jU1PooFHk7PLpPiWkJk8ast0FNUxyuWIuc3DGmA0YNK/cp8Cx5iIEeJJPKtWiJNFbVyh6/Ws/mHGGhyQCf1TNfvKBUdw0/DD3rMs1IBSex+d8laT+1RPnHrnO+8IY/aXigv/VVsb+Jx97MoLF39tFTXZBwe6fwp6FQJVrWYt7hnKGQkQPOi9PZ6zwtuJ2qFv5yG3CzbvPI8kCF5hvx/ANAIl3egHRytYx6bGt1mBU42xKj7yLPVLcfEy8F1rvPJaBfbF9M1M8fPtMbZZn2qdMonbcgyilzyyHeotcfB8/zoznJvmDuM7ABHFTxMFDpcHoG8MK6A==
Received: from BN9PR03CA0587.namprd03.prod.outlook.com (2603:10b6:408:10d::22)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 18:13:59 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::86) by BN9PR03CA0587.outlook.office365.com
 (2603:10b6:408:10d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Tue, 16 Jul 2024 18:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 18:13:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 16 Jul
 2024 11:13:44 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 16 Jul 2024 11:13:43 -0700
Received: from 717d7c0-lcedt.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 16 Jul 2024 11:13:43 -0700
From: Dipen Patel <dipenp@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: <dipenp@nvidia.com>, <quic_jjohnson@quicinc.com>,
	<linux-kernel@vger.kernel.org>, <timestamp@lists.linux.dev>
Subject: [GIT PULL] hte: Changes for v6.11-rc1
Date: Tue, 16 Jul 2024 11:13:35 -0700
Message-ID: <20240716181335.954154-1-dipenp@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|IA0PR12MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea501ba-355d-483a-307e-08dca5c31080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JhZGzQckePC9gxrJDOOg69YYCxvEye2Ofxbx9Im+3aLcbfB4WC2RW4VBckfK?=
 =?us-ascii?Q?2liclESnU5qCzULCT/9s/tM44MdYL9i9hUneH//8ziEK6Qvv/WMiNCiG2VpD?=
 =?us-ascii?Q?WFoPkq3/ibrC4egIwGVi+jxt8f2MEe4Y0cH4b1ZUYPUgnAMhyaZhjmpbYTTA?=
 =?us-ascii?Q?htFhMgRTs76hM02TyJl4P0ibozzYEgWJl+9Rpoh215YzgCZjQ8HCubT9K5Qa?=
 =?us-ascii?Q?HcpATGkKHDFxw26hnxHmsGDt4RdUodBbPYD5/mR3IBSAlULDIw4MBzlgI8ys?=
 =?us-ascii?Q?aXu2+aXnQgQ0qOJnRZ9gI/w11nUAFE28n9WJR4zWlBTt+ectV4EIppaglYMU?=
 =?us-ascii?Q?A3Wa8Ca2iPFVvm+i+D4WGVfUNHz0qxrPWS7ljx3yvbe2HXNdntDHL1dgev5T?=
 =?us-ascii?Q?Hhbd3I0bngfsfDCQws6HmJo82RNs7r3wn2rQN5RNLagq1+eCipwBMhiQd9Un?=
 =?us-ascii?Q?Holxwel8ThdsJkupGPvHIcXNorQEgLRzAlER9TcTl6R0V5oBxDponlI6Qry7?=
 =?us-ascii?Q?Hof1wwPpEbTtXtqXezpuH/QC5YShR9/vWCTcAgz7qiumVa2fPZXq5ihZZHaa?=
 =?us-ascii?Q?iy6706ukuf0eWoKyt2ibyPiM6zpDjL6p4gpihr0D3Ph2vQ1T/8E9q3QqL304?=
 =?us-ascii?Q?MxviEO6NO2eosKHllq/0NzcZAc7RHT0GFsn68+9uY/owlsdkpkK6aklbXBLF?=
 =?us-ascii?Q?AM0OsAJ0Qk0HmbvHxIzIJXKSyczefwf35tCGQZDNjGRAD81QcjiaofAWWsc6?=
 =?us-ascii?Q?67uVFPcF/Rp5jlKaO3Xk/VH5lFDAME2j39FhnS9OVTkxBlD7AuT9jjWDTgvo?=
 =?us-ascii?Q?v1dcnrRDf+ihvTxvJbASsREQxcKyb5ADamPqj59Tqyxesdw+O1uNQLaClyW0?=
 =?us-ascii?Q?CsdJQlOfJaFVWizjIwoNGYYOE/EJox2nAxCAeMx6F49/xGbCiNam5YzhXFot?=
 =?us-ascii?Q?PheaUrEDbO9Qld2fCQ4b9sG76HshLWDtbPj6tbhQPR5OvA9xVGeCjRaFfCtP?=
 =?us-ascii?Q?4Kxd6s8HYdOQwpUXE/G/C+Ys9v1G78IConLVExoyCsr8HddEHCgJkFeBE0Q/?=
 =?us-ascii?Q?b4ZmUpS4xSAE3ZeiVpFX+1b4QMMFbcfZKRQJbJXakmtfSrEtzChiaXTwcga9?=
 =?us-ascii?Q?ZaQzuZw0z2F1DoYv6LvJtteE9AQ8w0Xzwm4giLgZmcZoTtb6S9Zw72RiOtFi?=
 =?us-ascii?Q?2HDaTyT4iKg+G8m5danM4kb8E3IGmOyMWTln+lBe8mEiF/4r5EpWdWVLCxfW?=
 =?us-ascii?Q?i1Mm/oO3y0iVl5O4nreYFZeGwtvsi45eUck6JHFDlMQeV2hpylMORaj43Qhi?=
 =?us-ascii?Q?rlmax3Y8cMjBhhRPevv0GkmqjOCdVAAbzq24LMetVH/TtJBgM26vgJ53I4Mx?=
 =?us-ascii?Q?5RYX42FHekOFmv1oAiOom0Cwa993z4uuwQBr6HngOrFj3esOh8nVaYCPZaKM?=
 =?us-ascii?Q?Qp78kzXsw+VK8+GgRQfGsfwuQRS1h1rE?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 18:13:59.2403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea501ba-355d-483a-307e-08dca5c31080
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git tags/for-6.11-rc1

for you to fetch changes up to 9e4259716f60c96c069a38e826884ad783dc4eb4:

  hte: tegra-194: add missing MODULE_DESCRIPTION() macro (2024-06-19 12:24:03 -0700)

----------------------------------------------------------------
hte: Changes for v6.11-rc1

The changes for the hte/timestamp subsystem include the following:

- Added module description in hte test to silence modpost warnings.

----------------------------------------------------------------
Jeff Johnson (1):
      hte: tegra-194: add missing MODULE_DESCRIPTION() macro

 drivers/hte/hte-tegra194-test.c | 1 +
 1 file changed, 1 insertion(+)

