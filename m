Return-Path: <linux-kernel+bounces-324133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29F7974840
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 04:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7842883FC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE9937171;
	Wed, 11 Sep 2024 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="Ty0RCFD1"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2040.outbound.protection.outlook.com [40.107.255.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA22A8D0
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726022502; cv=fail; b=ojy/BYW0mRBH+6llVbTugLMZPRA0Iae6OI7cOAwv4Vgphxujq7cc0gy4MQUI9Cp6WCqEwLDpJr2HC/du1FL2KP1393nMzjE4ZDNLHsgho2H3vY0i33JMpLMa4y+YswBTLLnC1KGTtjt3WGR+fY1icbM0jC0pQYb8STAlbD/Tidw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726022502; c=relaxed/simple;
	bh=dXbb7+L3QzCgaspUV8CYJDqChAQZNHvDcQsdiQisK0s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f19AIb0mk5xB3gFm2BprEOAIH9RRYzBOjWnJKscHI/rw74FxJhRp1b/FmRgtGbhmAyOcvKZnWKaePd8SsAyIps/1ETfja77ujuIrHdWlC3zulVcWMISsPpt2jjI+9FPF1YCoRLDq3QJFTiIee18kA1n4QemxyCJIlmmH9hW9bRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=Ty0RCFD1; arc=fail smtp.client-ip=40.107.255.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTEiSCvSeGuyknEF1qi4gDkqp6gEBnRa1FcTPOKLXj/xe8+hkIxcFc10BZt0UHg0iVn/rpc/mBH2HCFKPgbNrNfWP4BJJz1ffNH7F/kjhg3IIktptbsuCbi4tDqKJRh/PZwkqvP/K+54G11uUo5A+EORagaI5WIFGDDU5HMaYgR2htfNLhwPdyillbEVozQSDtff4B8BK1+JwiNNAuXZZLLSbqmudobPIKHquAtjV3+phJb1RQg5WBgQyW4JRx14j5EwH+uFF4X6nfWS/pEdmd8hqWoB8yICfCfhw0aF3D+1COZj1GOUf7XbUfb5A+aZC/M9C3EV8dXLkOAVzGs9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9oclsWyfE1RckQagOejlQqJpLIxCW1Wl2J22LW9tQA=;
 b=nqCtz/ggfMHCVhXyzM0W5hsbD0NokMzjGfYWFYTodC3oqMA8ywxw01awwQOxLE4UVQRf/sxjnw/kYsiIB1DlsDa2yv0WNrTBNhJjw7cEr8DhG9khfNQjh6UhhLnu2ofCoN3i28pug+X5Gcym7o69OO2Ypo9pdebpG6JdI5NZpPyLKB1vjw+J5VTLAugtazid4iumPIRNnJ3drOMAne6eM313C25SvDtG+CzHlRz+lhcdAxpRokkTLRhAANbspcaIyTlL339fsLCh9HUU/pscws+HIFbGz0QT7dOb+5+S5da6SuDqiVbIbTheTjoKyezx4vr0ZIZbapVndWx60KNY5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=kernel.org smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9oclsWyfE1RckQagOejlQqJpLIxCW1Wl2J22LW9tQA=;
 b=Ty0RCFD1AJhWTIVA5PRYZlQCmaB7E1TkiibaBs11x4ds/wkirIXgInwi+7SKekOTdyur7J4RlS1YdKltZCh5jB/Tye8/Qf4kqwrHzum2G0BiiHwG7r9sopwlY7noznHKzDW0lcUg2PvOo2NDhLyUB3MlOgaLOzn8XGN+wIFr8Ac=
Received: from PUZP153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::18)
 by SEYPR02MB7518.apcprd02.prod.outlook.com (2603:1096:101:1d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 02:41:33 +0000
Received: from HK2PEPF00006FB5.apcprd02.prod.outlook.com
 (2603:1096:301:c2:cafe::8) by PUZP153CA0016.outlook.office365.com
 (2603:1096:301:c2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.6 via Frontend
 Transport; Wed, 11 Sep 2024 02:41:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK2PEPF00006FB5.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 02:41:32 +0000
Received: from cndgdcavdu0c-218-29.172.16.40.114 (172.16.40.118) by
 mailappw30.adc.com (172.16.56.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 10:41:16 +0800
From: <liuderong@oppo.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	liuderong <liuderong@oppo.com>
Subject: [PATCH v1 0/2] f2fs: modify the calculation method of mtime
Date: Wed, 11 Sep 2024 10:40:19 +0800
Message-ID: <1726022421-58677-1-git-send-email-liuderong@oppo.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw30.adc.com
 (172.16.56.197)
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB5:EE_|SEYPR02MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: eef89567-f0b8-4e14-b92a-08dcd20b3f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QBT8x2oBUUo2omxmVn8559Z4K0/9jUvrQhAwjVXy74AZMO8ilYLDC+/O+k4d?=
 =?us-ascii?Q?ar20jvLgjcoVz75awbp/czobNMOsdecTRxKjkQr4wXTqeP7kTZoVWHQy1Cez?=
 =?us-ascii?Q?QVwe/TRl60zKr6m0UMKzzPGyYRyb6WdZJbPf7YPhePtxFNcrq0hGoG8SUFT5?=
 =?us-ascii?Q?4/8f8SXCLrIpwMQfaU7IdPRL7irz0CI3w+Dk5Q4X0EfXzRek+FJOeoj0+cuh?=
 =?us-ascii?Q?CHs3pec/ZkTz6lb9QDqcebjDdKu2ZSeG4tk/X54RThA/waHIi5wpn9uiVUNf?=
 =?us-ascii?Q?RrIx3lkeJcar/B5yF+hNiIirLTrFGo82yExwOAcqAJcMTJvkQLl76VmscfC0?=
 =?us-ascii?Q?MHfCMmJNs0lHQjikwMDIIi0T3Kyaba4japCEbw6A4pd/e3Iu+li2ZrDca8AW?=
 =?us-ascii?Q?5qcBkW8DJClPNU/b4OWKdDwh3RLNcNaCzn85YZRUm/seH8icqaWOj6IfR6gl?=
 =?us-ascii?Q?0nF/ns1+VGlL2D5quRBr3yTbI0qYT5QfvY8lX39LPXyEQQHL60/1oNsZCQsv?=
 =?us-ascii?Q?dHCRPgMfkaFwy++JbrrJZlETPPya7KsEU/BQgRW6lWmertP9h7E0P2sJk1aR?=
 =?us-ascii?Q?XKcB+3dD0H6ABUB+s9pMPSK7kK/wP2z9Xqr3yyWKIaQorB7G6615ZFdyylfI?=
 =?us-ascii?Q?DSaGM4mUXT3crPoOgZOQSWEefbkGWEXKDAHkj+EUj3GQHjLsr/l3qt9Y5I5+?=
 =?us-ascii?Q?IO5j3UvHkLGKKfBU6E2PRMJpD2pg+GOQiEHAn3Apk6og9vjlcc37Zf9uHp6m?=
 =?us-ascii?Q?eOYJJ/FoJ+ycGnXc2eku7bU5dPX/5IlwlW/+O+IgIHCJcGapye0KzY7OUtBd?=
 =?us-ascii?Q?DBmKaLdx56wdAkJ6St7Ga7PNPkCYV5dAaGtfw85QcqevCDfEp8wC7YvOyGgZ?=
 =?us-ascii?Q?98zV2KKBSQUL7zo86hoqjqsE29vszDsjwqOB0KBieJUyYGSpWdMDhNysUz/Q?=
 =?us-ascii?Q?OVquJWgMPv5VGdJm5qsS1Zhr2FLaHN5dkRW/YmkGB3Z8Gzjgf2VdcbHzwUWt?=
 =?us-ascii?Q?QQCHOkrwm9JFYPNz4qPd/d/0ueRBWygHDwVdaHwgf/IUy4JzvJhtLyn34aSq?=
 =?us-ascii?Q?UCW6hV5v1CBUZixHXYqM6c/XhljmSSJtoyK3F5dc0euRS2wHd5c5/YhuU5tt?=
 =?us-ascii?Q?aRSRSXw8Gwumzk19fWRQg86GnunFpM9vswsg3QxeLylDpBj3sldKAGWH2Ykp?=
 =?us-ascii?Q?sN0Y193kneOsJfEg6TpU1a1HdgpUz8DQQG6Z1OXQ5pgq2J5UjKBp/8f8RYxP?=
 =?us-ascii?Q?8AgJatAfsfZ4xdOLQejbmLxWkfrrTqxBuyU/G6Yrq3ZahdgeEGsIOwos6W8y?=
 =?us-ascii?Q?wfef2B0pdC2RnICIfup11zyLWED0OEtHlnwVbzMqqpAE+qajlPHaPDwdq68u?=
 =?us-ascii?Q?B3M34dYHUXPFG+BJSHG+K1qC8et19RsoTzGNCPtcE0+ej95vrQ4kVkKuFIax?=
 =?us-ascii?Q?ij7jBzeefTjS3+6+A30oYhEyds9ss+/e?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 02:41:32.9005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eef89567-f0b8-4e14-b92a-08dcd20b3f72
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7518

From: liuderong <liuderong@oppo.com>

In cost-benefit GC algorithm, mtime will affect
the selection of victim segment.For a large section,
mtime should be the mean value of valid segments,
in order to select correct victim segment,
it needs to modify the calculation method of mtime.

liuderong (2):
  f2fs: remove unused parameters
  f2fs: introduce get_section_mtime

 fs/f2fs/f2fs.h    |  5 +++--
 fs/f2fs/gc.c      | 21 +++++----------------
 fs/f2fs/segment.c | 52 +++++++++++++++++++++++++++++++++++++++++++++------=
-
 fs/f2fs/segment.h |  4 ++--
 4 files changed, 55 insertions(+), 27 deletions(-)

--
2.7.4

________________________________
OPPO

=C2=B1=C2=BE=C2=B5=C3=A7=C3=97=C3=93=C3=93=C3=8A=C2=BC=C3=BE=C2=BC=C2=B0=C3=
=86=C3=A4=C2=B8=C2=BD=C2=BC=C3=BE=C2=BA=C2=AC=C3=93=C3=90OPPO=C2=B9=C2=AB=
=C3=8B=C2=BE=C2=B5=C3=84=C2=B1=C2=A3=C3=83=C3=9C=C3=90=C3=85=C3=8F=C2=A2=C2=
=A3=C2=AC=C2=BD=C3=B6=C3=8F=C3=9E=C3=93=C3=9A=C3=93=C3=8A=C2=BC=C3=BE=C3=96=
=C2=B8=C3=83=C3=B7=C2=B5=C3=84=C3=8A=C3=95=C2=BC=C3=BE=C3=88=C3=8B=C2=A3=C2=
=A8=C2=B0=C3=BC=C2=BA=C2=AC=C2=B8=C3=B6=C3=88=C3=8B=C2=BC=C2=B0=C3=88=C2=BA=
=C3=97=C3=A9=C2=A3=C2=A9=C3=8A=C2=B9=C3=93=C3=83=C2=A1=C2=A3=C2=BD=C3=BB=C3=
=96=C2=B9=C3=88=C3=8E=C2=BA=C3=8E=C3=88=C3=8B=C3=94=C3=9A=C3=8E=C2=B4=C2=BE=
=C2=AD=C3=8A=C3=9A=C3=88=C2=A8=C2=B5=C3=84=C3=87=C3=A9=C2=BF=C3=B6=C3=8F=C3=
=82=C3=92=C3=94=C3=88=C3=8E=C2=BA=C3=8E=C3=90=C3=8E=C3=8A=C2=BD=C3=8A=C2=B9=
=C3=93=C3=83=C2=A1=C2=A3=C3=88=C3=A7=C2=B9=C3=BB=C3=84=C3=BA=C2=B4=C3=AD=C3=
=8A=C3=95=C3=81=C3=8B=C2=B1=C2=BE=C3=93=C3=8A=C2=BC=C3=BE=C2=A3=C2=AC=C3=87=
=C3=90=C3=8E=C3=B0=C2=B4=C2=AB=C2=B2=C2=A5=C2=A1=C2=A2=C2=B7=C3=96=C2=B7=C2=
=A2=C2=A1=C2=A2=C2=B8=C2=B4=C3=96=C3=86=C2=A1=C2=A2=C3=93=C2=A1=C3=8B=C2=A2=
=C2=BB=C3=B2=C3=8A=C2=B9=C3=93=C3=83=C2=B1=C2=BE=C3=93=C3=8A=C2=BC=C3=BE=C3=
=96=C2=AE=C3=88=C3=8E=C2=BA=C3=8E=C2=B2=C2=BF=C2=B7=C3=96=C2=BB=C3=B2=C3=86=
=C3=A4=C3=8B=C3=B9=C3=94=C3=98=C3=96=C2=AE=C3=88=C3=8E=C2=BA=C3=8E=C3=84=C3=
=9A=C3=88=C3=9D=C2=A3=C2=AC=C2=B2=C2=A2=C3=87=C3=AB=C3=81=C2=A2=C2=BC=C2=B4=
=C3=92=C3=94=C2=B5=C3=A7=C3=97=C3=93=C3=93=C3=8A=C2=BC=C3=BE=C3=8D=C2=A8=C3=
=96=C2=AA=C2=B7=C2=A2=C2=BC=C3=BE=C3=88=C3=8B=C2=B2=C2=A2=C3=89=C2=BE=C2=B3=
=C3=BD=C2=B1=C2=BE=C3=93=C3=8A=C2=BC=C3=BE=C2=BC=C2=B0=C3=86=C3=A4=C2=B8=C2=
=BD=C2=BC=C3=BE=C2=A1=C2=A3
=C3=8D=C3=B8=C3=82=C3=A7=C3=8D=C2=A8=C3=91=C2=B6=C2=B9=C3=8C=C3=93=C3=90=C3=
=88=C2=B1=C3=8F=C3=9D=C2=BF=C3=89=C3=84=C3=9C=C2=B5=C2=BC=C3=96=C3=82=C3=93=
=C3=8A=C2=BC=C3=BE=C2=B1=C2=BB=C2=BD=C3=98=C3=81=C3=B4=C2=A1=C2=A2=C3=90=C3=
=9E=C2=B8=C3=84=C2=A1=C2=A2=C2=B6=C2=AA=C3=8A=C2=A7=C2=A1=C2=A2=C3=86=C3=86=
=C2=BB=C2=B5=C2=BB=C3=B2=C2=B0=C3=BC=C2=BA=C2=AC=C2=BC=C3=86=C3=8B=C3=A3=C2=
=BB=C3=BA=C2=B2=C2=A1=C2=B6=C2=BE=C2=B5=C3=88=C2=B2=C2=BB=C2=B0=C2=B2=C3=88=
=C2=AB=C3=87=C3=A9=C2=BF=C3=B6=C2=A3=C2=ACOPPO=C2=B6=C3=94=C2=B4=C3=8B=C3=
=80=C3=A0=C2=B4=C3=AD=C3=8E=C3=B3=C2=BB=C3=B2=C3=92=C3=85=C3=82=C2=A9=C2=B6=
=C3=B8=C3=92=C3=BD=C3=96=C3=82=C3=96=C2=AE=C3=88=C3=8E=C2=BA=C3=8E=C3=8B=C3=
=B0=C3=8A=C2=A7=C2=B8=C3=85=C2=B2=C2=BB=C2=B3=C3=90=C2=B5=C2=A3=C3=94=C3=B0=
=C3=88=C3=8E=C2=B2=C2=A2=C2=B1=C2=A3=C3=81=C3=B4=C3=93=C3=AB=C2=B1=C2=BE=C3=
=93=C3=8A=C2=BC=C3=BE=C3=8F=C3=A0=C2=B9=C3=98=C3=96=C2=AE=C3=92=C2=BB=C3=87=
=C3=90=C3=88=C2=A8=C3=80=C3=BB=C2=A1=C2=A3
=C2=B3=C3=BD=C2=B7=C3=87=C3=83=C3=B7=C3=88=C2=B7=C3=8B=C2=B5=C3=83=C3=B7=C2=
=A3=C2=AC=C2=B1=C2=BE=C3=93=C3=8A=C2=BC=C3=BE=C2=BC=C2=B0=C3=86=C3=A4=C2=B8=
=C2=BD=C2=BC=C3=BE=C3=8E=C3=9E=C3=92=C3=A2=C3=97=C3=B7=C3=8E=C2=AA=C3=94=C3=
=9A=C3=88=C3=8E=C2=BA=C3=8E=C2=B9=C3=BA=C2=BC=C3=92=C2=BB=C3=B2=C2=B5=C3=98=
=C3=87=C3=B8=C3=96=C2=AE=C3=92=C2=AA=C3=94=C2=BC=C2=A1=C2=A2=C3=95=C3=90=C3=
=80=C2=BF=C2=BB=C3=B2=C2=B3=C3=90=C3=85=C2=B5=C2=A3=C2=AC=C3=92=C3=A0=C3=8E=
=C3=9E=C3=92=C3=A2=C3=97=C3=B7=C3=8E=C2=AA=C3=88=C3=8E=C2=BA=C3=8E=C2=BD=C2=
=BB=C3=92=C3=97=C2=BB=C3=B2=C2=BA=C3=8F=C3=8D=C2=AC=C3=96=C2=AE=C3=95=C3=BD=
=C3=8A=C2=BD=C3=88=C2=B7=C3=88=C3=8F=C2=A1=C2=A3 =C2=B7=C2=A2=C2=BC=C3=BE=
=C3=88=C3=8B=C2=A1=C2=A2=C3=86=C3=A4=C3=8B=C3=B9=C3=8A=C3=B4=C2=BB=C3=BA=C2=
=B9=C2=B9=C2=BB=C3=B2=C3=8B=C3=B9=C3=8A=C3=B4=C2=BB=C3=BA=C2=B9=C2=B9=C3=96=
=C2=AE=C2=B9=C3=98=C3=81=C2=AA=C2=BB=C3=BA=C2=B9=C2=B9=C2=BB=C3=B2=C3=88=C3=
=8E=C2=BA=C3=8E=C3=89=C3=8F=C3=8A=C3=B6=C2=BB=C3=BA=C2=B9=C2=B9=C3=96=C2=AE=
=C2=B9=C3=89=C2=B6=C2=AB=C2=A1=C2=A2=C2=B6=C2=AD=C3=8A=C3=82=C2=A1=C2=A2=C2=
=B8=C3=9F=C2=BC=C2=B6=C2=B9=C3=9C=C3=80=C3=AD=C3=88=C3=8B=C3=94=C2=B1=C2=A1=
=C2=A2=C3=94=C2=B1=C2=B9=C2=A4=C2=BB=C3=B2=C3=86=C3=A4=C3=8B=C3=BB=C3=88=C3=
=8E=C2=BA=C3=8E=C3=88=C3=8B=C2=A3=C2=A8=C3=92=C3=94=C3=8F=C3=82=C2=B3=C3=86=
=C2=A1=C2=B0=C2=B7=C2=A2=C2=BC=C3=BE=C3=88=C3=8B=C2=A1=C2=B1=C2=BB=C3=B2=C2=
=A1=C2=B0OPPO=C2=A1=C2=B1=C2=A3=C2=A9=C2=B2=C2=BB=C3=92=C3=B2=C2=B1=C2=BE=
=C3=93=C3=8A=C2=BC=C3=BE=C3=96=C2=AE=C3=8E=C3=B3=C3=8B=C3=8D=C2=B6=C3=B8=C2=
=B7=C3=85=C3=86=C3=BA=C3=86=C3=A4=C3=8B=C3=B9=C3=8F=C3=AD=C3=96=C2=AE=C3=88=
=C3=8E=C2=BA=C3=8E=C3=88=C2=A8=C3=80=C3=BB=C2=A3=C2=AC=C3=92=C3=A0=C2=B2=C2=
=BB=C2=B6=C3=94=C3=92=C3=B2=C2=B9=C3=8A=C3=92=C3=A2=C2=BB=C3=B2=C2=B9=C3=BD=
=C3=8A=C2=A7=C3=8A=C2=B9=C3=93=C3=83=C2=B8=C3=83=C2=B5=C3=88=C3=90=C3=85=C3=
=8F=C2=A2=C2=B6=C3=B8=C3=92=C3=BD=C2=B7=C2=A2=C2=BB=C3=B2=C2=BF=C3=89=C3=84=
=C3=9C=C3=92=C3=BD=C2=B7=C2=A2=C2=B5=C3=84=C3=8B=C3=B0=C3=8A=C2=A7=C2=B3=C3=
=90=C2=B5=C2=A3=C3=88=C3=8E=C2=BA=C3=8E=C3=94=C3=B0=C3=88=C3=8E=C2=A1=C2=A3
=C3=8E=C3=84=C2=BB=C2=AF=C2=B2=C3=AE=C3=92=C3=AC=C3=85=C3=BB=C3=82=C2=B6=C2=
=A3=C2=BA=C3=92=C3=B2=C3=88=C2=AB=C3=87=C3=B2=C3=8E=C3=84=C2=BB=C2=AF=C2=B2=
=C3=AE=C3=92=C3=AC=C3=93=C2=B0=C3=8F=C3=AC=C2=A3=C2=AC=C2=B5=C2=A5=C2=B4=C2=
=BF=C3=92=C3=94YES\OK=C2=BB=C3=B2=C3=86=C3=A4=C3=8B=C3=BB=C2=BC=C3=B2=C2=B5=
=C2=A5=C2=B4=C3=8A=C2=BB=C3=A3=C2=B5=C3=84=C2=BB=C3=98=C2=B8=C2=B4=C2=B2=C2=
=A2=C2=B2=C2=BB=C2=B9=C2=B9=C2=B3=C3=89=C2=B7=C2=A2=C2=BC=C3=BE=C3=88=C3=8B=
=C2=B6=C3=94=C3=88=C3=8E=C2=BA=C3=8E=C2=BD=C2=BB=C3=92=C3=97=C2=BB=C3=B2=C2=
=BA=C3=8F=C3=8D=C2=AC=C3=96=C2=AE=C3=95=C3=BD=C3=8A=C2=BD=C3=88=C2=B7=C3=88=
=C3=8F=C2=BB=C3=B2=C2=BD=C3=93=C3=8A=C3=9C=C2=A3=C2=AC=C3=87=C3=AB=C3=93=C3=
=AB=C2=B7=C2=A2=C2=BC=C3=BE=C3=88=C3=8B=C3=94=C3=99=C2=B4=C3=8E=C3=88=C2=B7=
=C3=88=C3=8F=C3=92=C3=94=C2=BB=C3=B1=C2=B5=C3=83=C3=83=C3=B7=C3=88=C2=B7=C3=
=8A=C3=A9=C3=83=C3=A6=C3=92=C3=A2=C2=BC=C3=BB=C2=A1=C2=A3=C2=B7=C2=A2=C2=BC=
=C3=BE=C3=88=C3=8B=C2=B2=C2=BB=C2=B6=C3=94=C3=88=C3=8E=C2=BA=C3=8E=C3=8A=C3=
=9C=C3=8E=C3=84=C2=BB=C2=AF=C2=B2=C3=AE=C3=92=C3=AC=C3=93=C2=B0=C3=8F=C3=AC=
=C2=B6=C3=B8=C2=B5=C2=BC=C3=96=C3=82=C2=B9=C3=8A=C3=92=C3=A2=C2=BB=C3=B2=C2=
=B4=C3=AD=C3=8E=C3=B3=C3=8A=C2=B9=C3=93=C3=83=C2=B8=C3=83=C2=B5=C3=88=C3=90=
=C3=85=C3=8F=C2=A2=C3=8B=C3=B9=C3=94=C3=AC=C2=B3=C3=89=C2=B5=C3=84=C3=88=C3=
=8E=C2=BA=C3=8E=C3=96=C2=B1=C2=BD=C3=93=C2=BB=C3=B2=C2=BC=C3=A4=C2=BD=C3=93=
=C3=8B=C3=B0=C2=BA=C2=A6=C2=B3=C3=90=C2=B5=C2=A3=C3=94=C3=B0=C3=88=C3=8E=C2=
=A1=C2=A3
This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you ar=
e not the intended recipient, please do not read, copy, distribute, or use =
this information. If you have received this transmission in error, please n=
otify the sender immediately by reply e-mail and then delete this message.
Electronic communications may contain computer viruses or other defects inh=
erently, may not be accurately and/or timely transmitted to other systems, =
or may be intercepted, modified ,delayed, deleted or interfered. OPPO shall=
 not be liable for any damages that arise or may arise from such matter and=
 reserves all rights in connection with the email.
Unless expressly stated, this e-mail and its attachments are provided witho=
ut any warranty, acceptance or promise of any kind in any country or region=
, nor constitute a formal confirmation or acceptance of any transaction or =
contract. The sender, together with its affiliates or any shareholder, dire=
ctor, officer, employee or any other person of any such institution (herein=
after referred to as "sender" or "OPPO") does not waive any rights and shal=
l not be liable for any damages that arise or may arise from the intentiona=
l or negligent use of such information.
Cultural Differences Disclosure: Due to global cultural differences, any re=
ply with only YES\OK or other simple words does not constitute any confirma=
tion or acceptance of any transaction or contract, please confirm with the =
sender again to ensure clear opinion in written form. The sender shall not =
be responsible for any direct or indirect damages resulting from the intent=
ional or misuse of such information.
________________________________
OPPO

=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=E6=
=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=88=E5=8C=85=E5=90=
=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=89=E4=BD=BF=E7=94=A8=
=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=E7=
=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E5=
=88=87=E5=8B=BF=E4=BC=A0=E6=92=AD=E3=80=81=E5=88=86=E5=8F=91=E3=80=81=E5=A4=
=8D=E5=88=B6=E3=80=81=E5=8D=B0=E5=88=B7=E6=88=96=E4=BD=BF=E7=94=A8=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E4=B9=8B=E4=BB=BB=E4=BD=95=E9=83=A8=E5=88=86=E6=88=96=E5=
=85=B6=E6=89=80=E8=BD=BD=E4=B9=8B=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=EF=BC=
=8C=E5=B9=B6=E8=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=
=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=
=82
=E7=BD=91=E7=BB=9C=E9=80=9A=E8=AE=AF=E5=9B=BA=E6=9C=89=E7=BC=BA=E9=99=B7=E5=
=8F=AF=E8=83=BD=E5=AF=BC=E8=87=B4=E9=82=AE=E4=BB=B6=E8=A2=AB=E6=88=AA=E7=95=
=99=E3=80=81=E4=BF=AE=E6=94=B9=E3=80=81=E4=B8=A2=E5=A4=B1=E3=80=81=E7=A0=B4=
=E5=9D=8F=E6=88=96=E5=8C=85=E5=90=AB=E8=AE=A1=E7=AE=97=E6=9C=BA=E7=97=85=E6=
=AF=92=E7=AD=89=E4=B8=8D=E5=AE=89=E5=85=A8=E6=83=85=E5=86=B5=EF=BC=8COPPO=
=E5=AF=B9=E6=AD=A4=E7=B1=BB=E9=94=99=E8=AF=AF=E6=88=96=E9=81=97=E6=BC=8F=E8=
=80=8C=E5=BC=95=E8=87=B4=E4=B9=8B=E4=BB=BB=E4=BD=95=E6=8D=9F=E5=A4=B1=E6=A6=
=82=E4=B8=8D=E6=89=BF=E6=8B=85=E8=B4=A3=E4=BB=BB=E5=B9=B6=E4=BF=9D=E7=95=99=
=E4=B8=8E=E6=9C=AC=E9=82=AE=E4=BB=B6=E7=9B=B8=E5=85=B3=E4=B9=8B=E4=B8=80=E5=
=88=87=E6=9D=83=E5=88=A9=E3=80=82
=E9=99=A4=E9=9D=9E=E6=98=8E=E7=A1=AE=E8=AF=B4=E6=98=8E=EF=BC=8C=E6=9C=AC=E9=
=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E6=97=A0=E6=84=8F=E4=BD=
=9C=E4=B8=BA=E5=9C=A8=E4=BB=BB=E4=BD=95=E5=9B=BD=E5=AE=B6=E6=88=96=E5=9C=B0=
=E5=8C=BA=E4=B9=8B=E8=A6=81=E7=BA=A6=E3=80=81=E6=8B=9B=E6=8F=BD=E6=88=96=E6=
=89=BF=E8=AF=BA=EF=BC=8C=E4=BA=A6=E6=97=A0=E6=84=8F=E4=BD=9C=E4=B8=BA=E4=BB=
=BB=E4=BD=95=E4=BA=A4=E6=98=93=E6=88=96=E5=90=88=E5=90=8C=E4=B9=8B=E6=AD=A3=
=E5=BC=8F=E7=A1=AE=E8=AE=A4=E3=80=82 =E5=8F=91=E4=BB=B6=E4=BA=BA=E3=80=81=
=E5=85=B6=E6=89=80=E5=B1=9E=E6=9C=BA=E6=9E=84=E6=88=96=E6=89=80=E5=B1=9E=E6=
=9C=BA=E6=9E=84=E4=B9=8B=E5=85=B3=E8=81=94=E6=9C=BA=E6=9E=84=E6=88=96=E4=BB=
=BB=E4=BD=95=E4=B8=8A=E8=BF=B0=E6=9C=BA=E6=9E=84=E4=B9=8B=E8=82=A1=E4=B8=9C=
=E3=80=81=E8=91=A3=E4=BA=8B=E3=80=81=E9=AB=98=E7=BA=A7=E7=AE=A1=E7=90=86=E4=
=BA=BA=E5=91=98=E3=80=81=E5=91=98=E5=B7=A5=E6=88=96=E5=85=B6=E4=BB=96=E4=BB=
=BB=E4=BD=95=E4=BA=BA=EF=BC=88=E4=BB=A5=E4=B8=8B=E7=A7=B0=E2=80=9C=E5=8F=91=
=E4=BB=B6=E4=BA=BA=E2=80=9D=E6=88=96=E2=80=9COPPO=E2=80=9D=EF=BC=89=E4=B8=
=8D=E5=9B=A0=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B9=8B=E8=AF=AF=E9=80=81=E8=80=8C=
=E6=94=BE=E5=BC=83=E5=85=B6=E6=89=80=E4=BA=AB=E4=B9=8B=E4=BB=BB=E4=BD=95=E6=
=9D=83=E5=88=A9=EF=BC=8C=E4=BA=A6=E4=B8=8D=E5=AF=B9=E5=9B=A0=E6=95=85=E6=84=
=8F=E6=88=96=E8=BF=87=E5=A4=B1=E4=BD=BF=E7=94=A8=E8=AF=A5=E7=AD=89=E4=BF=A1=
=E6=81=AF=E8=80=8C=E5=BC=95=E5=8F=91=E6=88=96=E5=8F=AF=E8=83=BD=E5=BC=95=E5=
=8F=91=E7=9A=84=E6=8D=9F=E5=A4=B1=E6=89=BF=E6=8B=85=E4=BB=BB=E4=BD=95=E8=B4=
=A3=E4=BB=BB=E3=80=82
=E6=96=87=E5=8C=96=E5=B7=AE=E5=BC=82=E6=8A=AB=E9=9C=B2=EF=BC=9A=E5=9B=A0=E5=
=85=A8=E7=90=83=E6=96=87=E5=8C=96=E5=B7=AE=E5=BC=82=E5=BD=B1=E5=93=8D=EF=BC=
=8C=E5=8D=95=E7=BA=AF=E4=BB=A5YES\OK=E6=88=96=E5=85=B6=E4=BB=96=E7=AE=80=E5=
=8D=95=E8=AF=8D=E6=B1=87=E7=9A=84=E5=9B=9E=E5=A4=8D=E5=B9=B6=E4=B8=8D=E6=9E=
=84=E6=88=90=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=AF=B9=E4=BB=BB=E4=BD=95=E4=BA=A4=
=E6=98=93=E6=88=96=E5=90=88=E5=90=8C=E4=B9=8B=E6=AD=A3=E5=BC=8F=E7=A1=AE=E8=
=AE=A4=E6=88=96=E6=8E=A5=E5=8F=97=EF=BC=8C=E8=AF=B7=E4=B8=8E=E5=8F=91=E4=BB=
=B6=E4=BA=BA=E5=86=8D=E6=AC=A1=E7=A1=AE=E8=AE=A4=E4=BB=A5=E8=8E=B7=E5=BE=97=
=E6=98=8E=E7=A1=AE=E4=B9=A6=E9=9D=A2=E6=84=8F=E8=A7=81=E3=80=82=E5=8F=91=E4=
=BB=B6=E4=BA=BA=E4=B8=8D=E5=AF=B9=E4=BB=BB=E4=BD=95=E5=8F=97=E6=96=87=E5=8C=
=96=E5=B7=AE=E5=BC=82=E5=BD=B1=E5=93=8D=E8=80=8C=E5=AF=BC=E8=87=B4=E6=95=85=
=E6=84=8F=E6=88=96=E9=94=99=E8=AF=AF=E4=BD=BF=E7=94=A8=E8=AF=A5=E7=AD=89=E4=
=BF=A1=E6=81=AF=E6=89=80=E9=80=A0=E6=88=90=E7=9A=84=E4=BB=BB=E4=BD=95=E7=9B=
=B4=E6=8E=A5=E6=88=96=E9=97=B4=E6=8E=A5=E6=8D=9F=E5=AE=B3=E6=89=BF=E6=8B=85=
=E8=B4=A3=E4=BB=BB=E3=80=82
This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you ar=
e not the intended recipient, please do not read, copy, distribute, or use =
this information. If you have received this transmission in error, please n=
otify the sender immediately by reply e-mail and then delete this message.
Electronic communications may contain computer viruses or other defects inh=
erently, may not be accurately and/or timely transmitted to other systems, =
or may be intercepted, modified ,delayed, deleted or interfered. OPPO shall=
 not be liable for any damages that arise or may arise from such matter and=
 reserves all rights in connection with the email.
Unless expressly stated, this e-mail and its attachments are provided witho=
ut any warranty, acceptance or promise of any kind in any country or region=
, nor constitute a formal confirmation or acceptance of any transaction or =
contract. The sender, together with its affiliates or any shareholder, dire=
ctor, officer, employee or any other person of any such institution (herein=
after referred to as "sender" or "OPPO") does not waive any rights and shal=
l not be liable for any damages that arise or may arise from the intentiona=
l or negligent use of such information.
Cultural Differences Disclosure: Due to global cultural differences, any re=
ply with only YES\OK or other simple words does not constitute any confirma=
tion or acceptance of any transaction or contract, please confirm with the =
sender again to ensure clear opinion in written form. The sender shall not =
be responsible for any direct or indirect damages resulting from the intent=
ional or misuse of such information.

