Return-Path: <linux-kernel+bounces-257684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA40937D75
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF1C1F2179F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 21:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AD1147C74;
	Fri, 19 Jul 2024 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="crAyKRMF"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2016.outbound.protection.outlook.com [40.92.23.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6A5768EF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721424033; cv=fail; b=sQ6cyQnkImIBV+pUoMYv67NkbltsE+gVxLapPg3c14QKcwpModR5Yb795eY26gvwHaUo/PtkXCPRN87b8UPf2ZzgYRRGu2m9QxHk+NWLJRXFkfIBpa1OUXtweely+OV5SvOm5yokpWWhZp/cJiJDeohM+06UGcfZIXaeL6JzlG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721424033; c=relaxed/simple;
	bh=jl2JdP/auPVW6V1hUWQ41Cx3aPM+rjd31m/7R3gRrBE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t4XnOT/iscqVWwn6Bx1AbtWxvbtOHrTM/2h2At+ErK2PHc0Kq+2dP++MwpQFKTckiUJjkebhb6wW34KvCPFJvxyl0+a8mKfjP9EYcumZsfyUEfe/N0xF/jDI0UrAo330vtQeTqlEEn7lxHlUStZgDB0IIe1x8zMHpRD8AF1An7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=crAyKRMF; arc=fail smtp.client-ip=40.92.23.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjNsmT9eLevnPu0piwr7IlPqDeO83mDI8/4iX/Xb3Ewm+hVv9IBxgEe4tUlpAxpEe0kMYRzV7XvGlr1r4AqH4h5J8wuHftrRnnz/evZ5ZwkWTsEcxFx2twamxMFaH7vryRGeBxleJdE2kWa8zfoXNzZUGhmkzjeFY0k45XfksuE4P6dXkylP8chVBYGEylwmQIycs32+7ZEAUohKZeUd1OsXC7T7plcJ2prpxitEOrqpHbryuXu8airGvpDdgDCSD7y5t43V8M13BA3pqiJ8EMgPsFCN4/doRdkb+bPbslYT7BYx6jTYPxzlJiWb9zh4NFt0LVHJpyA1PN9C2xS6vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nb7Y/Fn6bkOY/TcMy36WIugL8swNEczva9mvOlIcu+Y=;
 b=XwYHZQrjXrTdapYV0RekHT5Ro4+YsSzgk2DpmS8oNW/jD8H1fcmm7uRuCI44QKF3T+khalWOmVDRfVkUM2dr7Aq4SPo8lHGbWO6LRdmabQ1/AnoqoVlw/hVNX4nqlVj9OOWcN31a0uOjelqwTzOHd+xSVG2AtIR9FS+ozWOLWAGBbqt5fl3rlh2wimLEaYRFeiMJyGiZOS/LvIZ6NWMJf9+VyfVrHYA4pXHSLUFGdUeyMxqbFlevXZHpPfTYOEFjd8yyMc4P47AJHhvbT4syrax9EoZz6ISvQozjirLFrsK2kw4gDF5xL6r4QA9YmH6z0b4zxj7dINbzaTG0nwX87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nb7Y/Fn6bkOY/TcMy36WIugL8swNEczva9mvOlIcu+Y=;
 b=crAyKRMFPERAuBjmYIGJVmLEBJBb1376VGK4ot/sBVJWtslqGzY8W5uEsPCuEXm2iM5Sx+OtjARlVXe3pzaM3u+dereJyXkOpRahAnIAkkQy667QN9MrJplt/g8xu30parvO6j8wEGERvYMtEuMLzxm2Wt/3uDY3OjCBhxTJqiE7eFS7LnjqhAuQDzGaKpahhRJIUTnPhCwIYeaBQC3mVXc1ucDG5P9x/Y9SYfb6Hw2kJonSTcklLA2HCMlmrl3xItPa+vDEr7OK43uXrbvSRqB9KOEoF3Z2eKFNt1jWMKGK4hQMC7jjr41FMzWNT+qRov1Hn8AQ9Fo1BI4ONvQqkw==
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:a03:570::8)
 by PH7P223MB0843.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:310::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Fri, 19 Jul
 2024 21:20:29 +0000
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd]) by SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd%2]) with mapi id 15.20.7762.030; Fri, 19 Jul 2024
 21:20:29 +0000
From: Steven Davis <goldside000@outlook.com>
To: gregkh@linuxfoundation.org,
	christian.gromm@microchip.com,
	parthiban.veerasooran@microchip.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Steven Davis <goldside000@outlook.com>
Subject: [PATCH] Made the error messages a tad easier to read
Date: Fri, 19 Jul 2024 17:19:36 -0400
Message-ID:
 <SJ2P223MB1026BF236AA81666C823E947F7AD2@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [GFVszrtzb9HnVSUh/uYK/CMlASjnFobC]
X-ClientProxiedBy: CH2PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:610:52::23) To SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:a03:570::8)
X-Microsoft-Original-Message-ID:
 <20240719211936.5923-1-goldside000@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2P223MB1026:EE_|PH7P223MB0843:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b4e4e6-2071-4e6b-1f43-08dca8389d13
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	D6mIk7KGDNTC7aESVeT2idF3DoulzZsbmvSTq9MDqmRJtu/5cEqDBUe4t4IFJ09GbfWNJ2kpNqcMFZ+vHck5iugpSckoS9RpC2oNYnDM9BdbaOyQ99MaG1fl+xgvJmGFwpKkupZphRc0dMLB66uyQQx3xIUyyLPbjYKLhU+tU2RmTuSolWqm/vnm8IbJEQc4Z/dncwfPs6W8D3/QMoxYCCv8nCF9V24K+LjOu22J+M+NklSeWHNWD/Ux/cC5yJVRTYQVdPcg7hsrYbnXeElgu1mMrdAC2SYffgyEOs+AE0ePMEJajVL/At4A+wEqgYWJ9VHAlGTbqyCfDxYYr3BBJCL+YMIGuBcILXfBnWAIzmnLquxqlwKlfvxO6nWOF7Yb0c23pRSGT8IpEvGqEoj1pAOXXssjumSyKOhlGTl/V7jjYZep1Nt8vE8q5q9n4xjmqmCj8ZC6pUvKv/fnoumcRQv/yYAl5iyCsmQfihDnwJad8P9tWjwQ/C2ECll3eFzIDcVdPKNPg6d+gVBJ16Lq7N+dp0BuR8iXAlC5ZE3bn/2WEnH1HmCNW1YDori0bjX06ZiwH2rrP2S1dulwCwWydc0xf4vbkuQN3Z8ttN4ehGJOnO6i2c2CgF9zkGwcxT9SNq66Fp1pXyGAewMKIdLW4UnrjssBiCEWHWkqZ4GZZ4vhYThX+EPYW/128NnYIAJM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CPWGTixCto8lLTaPXdMEPt7ngYKnYpOHQuulEx/nnTT+yH8lMoQIrseDJkrS?=
 =?us-ascii?Q?vZWH+3w32qX5VCmqXLoUNMTg+yr2Ldf2Y5BYf0cLbUi5Jc23sMvTZTpmxq4p?=
 =?us-ascii?Q?vbDahs9dlyyu0HAXRuYjmOhYZi+dR9SJdnLU3ioOa77wulBGB4JzGHH9gF8t?=
 =?us-ascii?Q?kYRDPnlS86j6LPgqdGv4YRnFnmvb723W8Vuf38aIqnUo9kY9gcHDB6/HUQ2Z?=
 =?us-ascii?Q?O+tUATpjbL3e9YFCLGIoFqVlOaFosYP5mB4Fwb1GieVTQpeL0AFCZja0UOTH?=
 =?us-ascii?Q?KhIF7ebIZyL6vWnXFf0PdjgDKW9ug4KxxzU5kRt8KP5pScxyvzBYlM5uhpo3?=
 =?us-ascii?Q?Q2e9/0lnaI2eTT/BRduIlFpmr89xJyfXWieWbFuUIFu3XfONAwFP7SPcNDTl?=
 =?us-ascii?Q?bMARPDsduCevyf9MRp20ezlt5OjBqmpA6rrTRKpKeA/Cs8Sn5vqQ/ewtNhqW?=
 =?us-ascii?Q?QByx3vl20GkJyU2je2hHI8MPPUUMNMo7KYd/L8v9xj9Prgd/uHSCilYmyEiE?=
 =?us-ascii?Q?WtcnU7idU8PAKi4zxmdpTRy+QRFIus4MWi/hgntapqQkjWpmv95wtIt+r3P3?=
 =?us-ascii?Q?nQJN6rpq0SI3/0ZuJTH1sca275XUyMvGt83e/YU4v5pUIaXgGT9Ii0Jjsb9+?=
 =?us-ascii?Q?dC71KHKrbC+e0UpLpXUIiBLEuUiEqctC/MSCCquyxysKXsgmsfxpNIld0QYs?=
 =?us-ascii?Q?wh+clo/igy9FPJHRx/vGTvPpRznZDGNuvjhP7drVpqWdrkbWRzuVLT3Qgpa1?=
 =?us-ascii?Q?iaWwAsvS+ReWHatV2WNoZvzHk8dWnHkwRv48FYNYQP7y5Pi3AWazKCagMj6m?=
 =?us-ascii?Q?9szzCbzrrTvmzDoAQ8hKFP7PPH1fXAaEeiY3rPPqUm6CWigLFTv8zkbqmATt?=
 =?us-ascii?Q?iXFCIxNJ0WW7ndYX/2H8SySG9PJi35L5KZtDOrS6LQ5b3AQlOfMkYz0iGEAm?=
 =?us-ascii?Q?ZlfKgKiYTG0FxYy4CgHj6RIdx/s6gjRflncis4ebGTCiDVO+2t0LWZhJSXMJ?=
 =?us-ascii?Q?TRErlvBQADq9+DLpcQKi2TXJsksqMrznrogksmI/aP2T+E1eDKEYL0skMoax?=
 =?us-ascii?Q?bok2sU4l5CexmBQRrCugUSBftgdPsUF3WsDji2UWtI45xsmnA3De7oaNA0cG?=
 =?us-ascii?Q?3Hn2c3aqzJB11u5Yic82UJoF1ks+TXOdiQk3P+sRFeJkFVh1UTzZseW0/VXW?=
 =?us-ascii?Q?3uNxlLNu7G/UAqN39fwySwpsAFG2glAcfjL4prjizV7K5g2Qq7Do4dYzpApU?=
 =?us-ascii?Q?wlNqLgvsreci38jhsk2N?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b4e4e6-2071-4e6b-1f43-08dca8389d13
X-MS-Exchange-CrossTenant-AuthSource: SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 21:20:28.9386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7P223MB0843

Signed-off-by: Steven Davis <goldside000@outlook.com>
---
 drivers/staging/most/video/video.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index 6254a5df2502..2b3cdb1ce140 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -454,18 +454,18 @@ static int comp_probe_channel(struct most_interface *iface, int channel_idx,
 	struct most_video_dev *mdev = get_comp_dev(iface, channel_idx);
 
 	if (mdev) {
-		pr_err("channel already linked\n");
+		pr_err("Channel already linked\n");
 		return -EEXIST;
 	}
 
 	if (ccfg->direction != MOST_CH_RX) {
-		pr_err("wrong direction, expect rx\n");
+		pr_err("Wrong direction, expected rx\n");
 		return -EINVAL;
 	}
 
 	if (ccfg->data_type != MOST_CH_SYNC &&
 	    ccfg->data_type != MOST_CH_ISOC) {
-		pr_err("wrong channel type, expect sync or isoc\n");
+		pr_err("Wrong channel type, expected sync or isoc\n");
 		return -EINVAL;
 	}
 
-- 
2.45.2


