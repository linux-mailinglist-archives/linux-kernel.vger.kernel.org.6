Return-Path: <linux-kernel+bounces-571655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613CBA6C03C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B84997AA904
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D6522D7A7;
	Fri, 21 Mar 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="a7QbGzSA";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="bha7aZxe"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542B222D4DE;
	Fri, 21 Mar 2025 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575201; cv=fail; b=Zr0P8VSXczUpMJHFKLYn/d0HWBvI0oBsWkIvUcyyeb2yYX7RN0sS33AmSsmzrQ7hJdAnfEJIthacwwob89oPZte4Ws5FdPCMyr4ojbyyXDW98BeIXVDL/EVtOMAv9G6hA/lDgdl5w5dC60xMfcmdU6xNRFxY9cfhD8pjRMBK9WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575201; c=relaxed/simple;
	bh=tu7HYC7GXXkG7s/eCLPYEkjb38m2viDpjbKEz3OXp1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0PSJixOdVSYtPf4n9L9OZ7ogiKGe9NqZMb+V0+AWAb9UPyB4MFc0gkEeT6Z+QzEPxCdAqIZcH7CGuU/BO1OEVVCfQif/Z9msD9H4sRb6RQvpsO/T422hMlN95uATt+igBLSLaAdfuQWgt+wM9vumrm+KfFhtzyaGcjpRYUNncw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=a7QbGzSA; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=bha7aZxe; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L7m8Xn023619;
	Fri, 21 Mar 2025 11:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=THID0NyLaNu/WB4qD2MHyVJYRApa/bjYPcnPKoSGMPk=; b=
	a7QbGzSAehg7hzXA7Csvx758hvOThHlh/+E4YvxGPfmvrCN2a5lEs6mkbUGjRjpO
	fCxokVnTtyVOHJ60TTq2rlq6DwrwDvxOdsvetK3tU1hw+5brLgNRDzSX2U5iR6PI
	KXNwzZPf0xbHL0TNC+Jx+XXfMthnJPVOCqqFaJk99RLdnjR2AZmiklPkz5uJu/pd
	zO7GZSSHlC5074wo66pFaVpErqNWMoUjmkp+UyHBvGSr/K5Gc5giUCpSrcI3/CEX
	eCWgpqNCHZltQZqSlAeTboA276kRz0jDVfTDqYV7KKf2SoelxkHqyQpFrYYc2kLo
	xBgWR2KUngY3xsUMChdwYA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45h40m11yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 11:39:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOuMSGsGPbsWCNvZ5C49tv6XBx0iZ2o5Rf4OhFBRLSY8iBYtcpspt8W20WVmDvYzJyumypwqptPgZFAhH7rfAmL/lsctdqiaVUx1I9Ak7ljzf1lTHkyUJ1FVnTa/XFwbDP2OjAZml5b7pEUTFQvcjUfApxNSjmsnplBtv+cPs3GBr7Vf5M3DqSBI32UpkKlEGY88tjLl335r8NRRLys0Dvc2RoHXLSRYdbGV5T6Y1cpIwPR3sEBiRKtH/UQYjSkXYnwD/IZJI1Ka+Y+V2EBVye+YCUQOqqTZc0hw+TwUFa+j+yGSlRWCcn+cZWsSzrl+f0EhAG6Y8TJ1j4oVJRcX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THID0NyLaNu/WB4qD2MHyVJYRApa/bjYPcnPKoSGMPk=;
 b=n4GIWrldgFIpIgmvrpPisGAzDKgZ1EnRs1CAmn8bO9NxoQKoAUWIN8FHgjUR8wWRml0Lh8aISGTVXzhgHIadAAu3mwRnxic2a2F+PBI2S4ZLgD/PNUV5n2OnOc8J6APFZY71UcEt84Y1KvB1cJzrS8kbDz2w/KTmIsfrHRl6UEasYkxkSMJxzoP2ztk7JuTYqecin4D9N1FValoKT18V9hw86q1hhdrK+R7KnciDZcqfBcmEHkDpRgzeGr9Wpm7/RMuXhC6/8+qOUfx7pgHtKy3AtewQ/Yc32aDcS+9Rakzz9bez2oQzjL6raA+61izF69rerRwCuIPSULugwYkgKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THID0NyLaNu/WB4qD2MHyVJYRApa/bjYPcnPKoSGMPk=;
 b=bha7aZxeO1qSUEIIdRhPKglLVpUPeECqHHqE0zFzfzgN+VapOLqlU+bREky6qbPw8h3hL7TfRABAT0MfMDpTVncf3e7zy4ydyBdXE43AjyFA3vhsWJtq//5fU5Zoizp5cI2W7NO9JmfEjKvwpKUh+hHg7wrrBqNjzn8iU7zGA2A=
Received: from DS7P220CA0050.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::20) by
 IA1PR19MB7205.namprd19.prod.outlook.com (2603:10b6:208:42f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.37; Fri, 21 Mar 2025 16:39:32 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:224:cafe::1c) by DS7P220CA0050.outlook.office365.com
 (2603:10b6:8:224::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Fri,
 21 Mar 2025 16:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Fri, 21 Mar 2025 16:39:30 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id EBCAE40654A;
	Fri, 21 Mar 2025 16:39:28 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C43A482255D;
	Fri, 21 Mar 2025 16:39:28 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, pierre-louis.bossart@linux.dev,
        yung-chuan.liao@linux.intel.com, peter.ujfalusi@linux.intel.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 2/3] ASoC: SDCA: Create ALSA controls from DisCo
Date: Fri, 21 Mar 2025 16:39:27 +0000
Message-Id: <20250321163928.793301-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250321163928.793301-1-ckeepax@opensource.cirrus.com>
References: <20250321163928.793301-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|IA1PR19MB7205:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9a2c440a-68ff-432e-37dc-08dd6896f3f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dt8lu9kT0cHofBkI2vVoNiZfa0psopZLmLwNYhiZnqyOreZ1EVJ25lQnvNOH?=
 =?us-ascii?Q?PPSsAOmZG+S+x3pxIyut8N6+PewjE2ksT7B+9X/LzP+2wZtnY3HMoZ6wvrqL?=
 =?us-ascii?Q?oZcWNU7TcZ0wyvdkTsITgCfhDyKf17Y/1Yi70IsghZ0Pskv3WlDGP3B1AaOk?=
 =?us-ascii?Q?2+r5mZOFkXuD+B4ZE44O5fX+pNjjQn9NYOON4W/RIsMSxNUf/WV+9qdm46GF?=
 =?us-ascii?Q?n3AEtcBXmJFhhz/2dHg6hRXQTz570bY3UTqtzdTFgEmJJiHMxMufWQK0t/bO?=
 =?us-ascii?Q?fyXctINfGtOA+ynhWmHaxMFE1oSR7oIhYMNBMQYTQITxtT4rhl9eTXzpjjIu?=
 =?us-ascii?Q?RGIfPqiZYYgckh9fxRGnfNZDzaBILKgQup2qXHbPcmW/TuinlNhqClwproyt?=
 =?us-ascii?Q?9bb5Mnv4yKtLkXZdURQFID0Ff0GwpOXc79VQtjYmR+fNy8YreYHEyXQMZ5Jp?=
 =?us-ascii?Q?OtTLpFbGPeijrRSxCpHAJG/NB3ixcXGo9c46IjT6aZrgTXL6LKqZPKFY0mYu?=
 =?us-ascii?Q?6hBp+oqf68gYeLzKxIvthzXscOmeqqo9tohzSCWS/r3UOZR3bq6rfkvo1j8J?=
 =?us-ascii?Q?ilaeRoe59fPMkpQdYMpOrgshyw/AD5FBLl4GLgNLUscbfMfVXieQvExerAyJ?=
 =?us-ascii?Q?HtawPvDkYQ4HGOFpf+srZfsyhZ3I1JYPUcvhUfE9ShQauk2BBIOqadV8Tn4q?=
 =?us-ascii?Q?7yZ8cAU33dwF/xo2VcuNNM3ecruXtQa4Z7LHbi3Ib0j+G15AORKbxwswkoby?=
 =?us-ascii?Q?IIuhcvePcu9MkpkIwSQ8wtOF9idSm9rXMIH41RMmGEoQUrFV1/XN3BXxIt7o?=
 =?us-ascii?Q?twVDn/Alt29GTkK05nnK/iEEmOQ0EIIqdGFyjK3LXcAgOc7BTub2l4vKu4+R?=
 =?us-ascii?Q?cSQzhUezukKoKFU4Nz0Aqcsi6BG9beUVKxEf2FJcjTVwUr1gsiaQBmz4UZYo?=
 =?us-ascii?Q?ONhNQxuG5xJ0oxyxEOR3gyc58Q3iROTHdcgu10zxM2d1jWnTpb0FkV4NANG6?=
 =?us-ascii?Q?aPRrk1Ca3W7wpc96YPfz0ttm7lzpvpYeP8qv8yGZBYo+CiIU5OVTGuwMQqRT?=
 =?us-ascii?Q?GjaelcjMiWuhkmgcv1pER6jnhTCAcNM0haB+IMDjagyKqhMxlWHBlWb9AE88?=
 =?us-ascii?Q?yd7lSNhZW07PFP85WILkHCXjuIbGWEfIe4TGFTSGlQw3MBmgz337ujfBpZPW?=
 =?us-ascii?Q?PwVVgXOMsJjHMaDYw/RKGmKtH1Blp5pHknYiWd84pmSgUJyTbAd+bvInLfpP?=
 =?us-ascii?Q?mpLwB/drsAbVtFf2OAjWGr64X0j/6V4i3Xj04hUVHdw7XaiLqG/PE4wZQqhc?=
 =?us-ascii?Q?hf+Ht9k5UPM7MqRyNejne5SohWs7wFo7nKMD57KWCVeUtn6nu3xs3N5yFbTM?=
 =?us-ascii?Q?K/ErCwCz7kuoWWTwa87hwmYP8NoHd4ubhHim3LgWeHQI9g8mQ/iYJAbm2DWB?=
 =?us-ascii?Q?DtY9bnsAtDtbXHzj9gqEJvLGnWoIdRAC75TLsskmJjTj3pA5s1Q6YfbI1etv?=
 =?us-ascii?Q?3ycgwgeShIAWWyg=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 16:39:30.1492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2c440a-68ff-432e-37dc-08dd6896f3f8
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB7205
X-Proofpoint-GUID: JyB0bLWF__F0eOW49t6R3vDoN0SwxlgF
X-Authority-Analysis: v=2.4 cv=DdkXqutW c=1 sm=1 tr=0 ts=67dd964a cx=c_pps a=ynuEE1Gfdg78pLiovR0MAg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Vs1iUdzkB0EA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=x5gQ8A518QfWKtYHqdsA:9 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-ORIG-GUID: JyB0bLWF__F0eOW49t6R3vDoN0SwxlgF
X-Proofpoint-Spam-Reason: safe

Use the previously parsed DisCo information from ACPI to create the
ALSA controls required by an SDCA Function. This maps all User and
Application level SDCA Controls to ALSA controls. Typically controls
marked with those access levels are just volumes and mutes.

SDCA defines volume controls as an integer in 1/256ths of a dB and
then provides a mechanism to specify what values are valid (range
templates). Currently only a simple case of a single linear volume
range with a power of 2 step size is supported. This allows the code
to expose the volume control using a simple shift. This will need
expanded in the future, to support more complex ranges and probably
also some additional control types but this should be sufficient to
for a first pass.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/sdca_asoc.h     |   6 +-
 include/sound/sdca_function.h |  10 ++
 sound/soc/sdca/sdca_asoc.c    | 191 +++++++++++++++++++++++++++++++++-
 3 files changed, 202 insertions(+), 5 deletions(-)

diff --git a/include/sound/sdca_asoc.h b/include/sound/sdca_asoc.h
index 414d461b6fc4a..d19e7e969283a 100644
--- a/include/sound/sdca_asoc.h
+++ b/include/sound/sdca_asoc.h
@@ -12,16 +12,20 @@
 
 struct device;
 struct sdca_function_data;
+struct snd_kcontrol_new;
 struct snd_soc_component_driver;
 struct snd_soc_dapm_route;
 struct snd_soc_dapm_widget;
 
 int sdca_asoc_count_component(struct device *dev, struct sdca_function_data *function,
-			      int *num_widgets, int *num_routes);
+			      int *num_widgets, int *num_routes, int *num_controls);
 
 int sdca_asoc_populate_dapm(struct device *dev, struct sdca_function_data *function,
 			    struct snd_soc_dapm_widget *widgets,
 			    struct snd_soc_dapm_route *routes);
+int sdca_asoc_populate_controls(struct device *dev,
+				struct sdca_function_data *function,
+				struct snd_kcontrol_new *kctl);
 
 int sdca_asoc_populate_component(struct device *dev,
 				 struct sdca_function_data *function,
diff --git a/include/sound/sdca_function.h b/include/sound/sdca_function.h
index 447752f71286a..358caacc28764 100644
--- a/include/sound/sdca_function.h
+++ b/include/sound/sdca_function.h
@@ -206,6 +206,16 @@ enum sdca_fu_controls {
 	SDCA_CTL_FU_LATENCY				= 0x10,
 };
 
+/**
+ * enum sdca_volume_range - Column definitions for Q7.8dB volumes/gains
+ */
+enum sdca_volume_range {
+	SDCA_VOLUME_LINEAR_MIN				= 0,
+	SDCA_VOLUME_LINEAR_MAX				= 1,
+	SDCA_VOLUME_LINEAR_STEP				= 2,
+	SDCA_VOLUME_LINEAR_NCOLS			= 3,
+};
+
 /**
  * enum sdca_xu_controls - SDCA Controls for Extension Unit
  *
diff --git a/sound/soc/sdca/sdca_asoc.c b/sound/soc/sdca/sdca_asoc.c
index dab434a8daac2..aced9cc27a520 100644
--- a/sound/soc/sdca/sdca_asoc.c
+++ b/sound/soc/sdca/sdca_asoc.c
@@ -21,6 +21,7 @@
 #include <sound/soc.h>
 #include <sound/soc-component.h>
 #include <sound/soc-dapm.h>
+#include <sound/tlv.h>
 
 static struct sdca_control *selector_find_control(struct sdca_entity *entity,
 						  const int sel)
@@ -69,13 +70,24 @@ static struct sdca_control_range *selector_find_range(struct device *dev,
 	return control_find_range(dev, entity, control, cols, rows);
 }
 
+static bool exported_control(struct sdca_control *control)
+{
+	/* No need to export control for something that only has one value */
+	if (control->has_fixed)
+		return false;
+
+	return control->layers & (SDCA_ACCESS_LAYER_USER |
+				  SDCA_ACCESS_LAYER_APPLICATION);
+}
+
 int sdca_asoc_count_component(struct device *dev, struct sdca_function_data *function,
-			      int *num_widgets, int *num_routes)
+			      int *num_widgets, int *num_routes, int *num_controls)
 {
-	int i;
+	int i, j;
 
 	*num_widgets = function->num_entities - 1;
 	*num_routes = 0;
+	*num_controls = 0;
 
 	for (i = 0; i < function->num_entities - 1; i++) {
 		struct sdca_entity *entity = &function->entities[i];
@@ -94,6 +106,11 @@ int sdca_asoc_count_component(struct device *dev, struct sdca_function_data *fun
 		}
 
 		*num_routes += entity->num_sources;
+
+		for (j = 0; j < entity->num_controls; j++) {
+			if (exported_control(&entity->controls[j]))
+				(*num_controls)++;
+		}
 	}
 
 	return 0;
@@ -761,16 +778,172 @@ int sdca_asoc_populate_dapm(struct device *dev, struct sdca_function_data *funct
 }
 EXPORT_SYMBOL_NS(sdca_asoc_populate_dapm, "SND_SOC_SDCA");
 
+static int control_limit_kctl(struct device *dev,
+			      struct sdca_entity *entity,
+			      struct sdca_control *control,
+			      struct snd_kcontrol_new *kctl)
+{
+	struct soc_mixer_control *mc = (struct soc_mixer_control *)kctl->private_value;
+	struct sdca_control_range *range;
+	int min, max, step;
+	unsigned int *tlv;
+	int shift;
+
+	if (control->type != SDCA_CTL_DATATYPE_Q7P8DB)
+		return 0;
+
+	/*
+	 * FIXME: For now only handle the simple case of a single linear range
+	 */
+	range = control_find_range(dev, entity, control, SDCA_VOLUME_LINEAR_NCOLS, 1);
+	if (!range)
+		return -EINVAL;
+
+	min = sdca_range(range, SDCA_VOLUME_LINEAR_MIN, 0);
+	max = sdca_range(range, SDCA_VOLUME_LINEAR_MAX, 0);
+	step = sdca_range(range, SDCA_VOLUME_LINEAR_STEP, 0);
+
+	min = sign_extend32(min, control->nbits - 1);
+	max = sign_extend32(max, control->nbits - 1);
+
+	/*
+	 * FIXME: Only support power of 2 step sizes as this can be supported
+	 * by a simple shift.
+	 */
+	if (hweight32(step) != 1) {
+		dev_err(dev, "%s: %s: currently unsupported step size\n",
+			entity->label, control->label);
+		return -EINVAL;
+	}
+
+	/*
+	 * The SDCA volumes are in steps of 1/256th of a dB, a step down of
+	 * 64 (shift of 6) gives 1/4dB. 1/4dB is the smallest unit that is also
+	 * representable in the ALSA TLVs which are in 1/100ths of a dB.
+	 */
+	shift = max(ffs(step) - 1, 6);
+
+	tlv = devm_kcalloc(dev, 4, sizeof(*tlv), GFP_KERNEL);
+	if (!tlv)
+		return -ENOMEM;
+
+	tlv[0] = SNDRV_CTL_TLVT_DB_SCALE;
+	tlv[1] = 2 * sizeof(*tlv);
+	tlv[2] = (min * 100) >> 8;
+	tlv[3] = ((1 << shift) * 100) >> 8;
+
+	mc->min = min >> shift;
+	mc->max = max >> shift;
+	mc->shift = shift;
+	mc->rshift = shift;
+	mc->sign_bit = 15 - shift;
+
+	kctl->access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_READWRITE;
+	kctl->tlv.p = tlv;
+
+	return 0;
+}
+
+static int populate_control(struct device *dev,
+			    struct sdca_function_data *function,
+			    struct sdca_entity *entity,
+			    struct sdca_control *control,
+			    struct snd_kcontrol_new **kctl)
+{
+	const char *control_suffix = "";
+	const char *control_name;
+	struct soc_mixer_control *mc;
+	int index = 0;
+	int ret;
+	int cn;
+
+	if (!exported_control(control))
+		return 0;
+
+	if (control->type == SDCA_CTL_DATATYPE_ONEBIT)
+		control_suffix = " Switch";
+
+	control_name = devm_kasprintf(dev, GFP_KERNEL, "%s %s%s", entity->label,
+				      control->label, control_suffix);
+	if (!control_name)
+		return -ENOMEM;
+
+	mc = devm_kmalloc(dev, sizeof(*mc), GFP_KERNEL);
+	if (!mc)
+		return -ENOMEM;
+
+	for_each_set_bit(cn, (unsigned long *)&control->cn_list,
+			 BITS_PER_TYPE(control->cn_list)) {
+		switch (index++) {
+		case 0:
+			mc->reg = SDW_SDCA_CTL(function->desc->adr, entity->id,
+					       control->sel, cn);
+			mc->rreg = mc->reg;
+			break;
+		case 1:
+			mc->rreg = SDW_SDCA_CTL(function->desc->adr, entity->id,
+						control->sel, cn);
+			break;
+		default:
+			dev_err(dev, "%s: %s: only mono/stereo controls supported\n",
+				entity->label, control->label);
+			return -EINVAL;
+		}
+	}
+
+	mc->min = 0;
+	mc->max = (0x1ull << control->nbits) - 1;
+
+	(*kctl)->name = control_name;
+	(*kctl)->private_value = (unsigned long)mc;
+	(*kctl)->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	(*kctl)->info = snd_soc_info_volsw;
+	(*kctl)->get = snd_soc_get_volsw;
+	(*kctl)->put = snd_soc_put_volsw;
+
+	ret = control_limit_kctl(dev, entity, control, *kctl);
+	if (ret)
+		return ret;
+
+	(*kctl)++;
+
+	return 0;
+}
+
+int sdca_asoc_populate_controls(struct device *dev,
+				struct sdca_function_data *function,
+				struct snd_kcontrol_new *kctl)
+{
+	int i, j;
+	int ret;
+
+	for (i = 0; i < function->num_entities; i++) {
+		struct sdca_entity *entity = &function->entities[i];
+
+		for (j = 0; j < entity->num_controls; j++) {
+			ret = populate_control(dev, function, entity,
+					       &entity->controls[j], &kctl);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS(sdca_asoc_populate_controls, "SND_SOC_SDCA");
+
 int sdca_asoc_populate_component(struct device *dev,
 				 struct sdca_function_data *function,
 				 struct snd_soc_component_driver *component_drv)
 {
 	struct snd_soc_dapm_widget *widgets;
 	struct snd_soc_dapm_route *routes;
-	int num_widgets, num_routes;
+	struct snd_kcontrol_new *controls;
+	int num_widgets, num_routes, num_controls;
 	int ret;
 
-	ret = sdca_asoc_count_component(dev, function, &num_widgets, &num_routes);
+	ret = sdca_asoc_count_component(dev, function, &num_widgets, &num_routes,
+					&num_controls);
 	if (ret)
 		return ret;
 
@@ -782,14 +955,24 @@ int sdca_asoc_populate_component(struct device *dev,
 	if (!routes)
 		return -ENOMEM;
 
+	controls = devm_kcalloc(dev, num_controls, sizeof(*controls), GFP_KERNEL);
+	if (!controls)
+		return -ENOMEM;
+
 	ret = sdca_asoc_populate_dapm(dev, function, widgets, routes);
 	if (ret)
 		return ret;
 
+	ret = sdca_asoc_populate_controls(dev, function, controls);
+	if (ret)
+		return ret;
+
 	component_drv->dapm_widgets = widgets;
 	component_drv->num_dapm_widgets = num_widgets;
 	component_drv->dapm_routes = routes;
 	component_drv->num_dapm_routes = num_routes;
+	component_drv->controls = controls;
+	component_drv->num_controls = num_controls;
 
 	return 0;
 }
-- 
2.39.5


