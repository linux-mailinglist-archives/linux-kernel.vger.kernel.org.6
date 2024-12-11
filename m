Return-Path: <linux-kernel+bounces-440975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B469EC75E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324422843C7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08821DC9AF;
	Wed, 11 Dec 2024 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="N/XQQTdl"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1C486321
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905919; cv=fail; b=rF9nYPiSzjFane/uNZnIeBbT7bOT9N/0RoH+x3vkjnbghqGCo7ApyfVY3b+kseV/CzCWnBKCaLVOLvFJwM1o6AMY7kKNJ0bM5K20nHjqQnB0ddFUmO1JA2tAHhop5EaC+X5Z1yUd46oulgYxWySCmvTOU4/JMdPjEOYOYwxAnnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905919; c=relaxed/simple;
	bh=4Q8a2QqbCzPSYMB/xpXoJGgE9geP73rCsdg3EVMes70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jNPsO7i1zR+9AK6K2yDMkvh368CnPmy6b/qYmOOgHBk+A2L/UTiLqj1MgZ5gLQ/GRXt7MHEbYKdb/5yJaRAo13ipTtWXN23KRLlugRyqgHAgf74bhle6ayYEYzKshieMI39pX6oEgU14a8a5qym/kzawwByK0KvgbxzW0zesiLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=N/XQQTdl; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8M/RjvoeuZGBbl/EhAUSs8a3QiMNRJHpXZK7CoBfNGQmZPY7piuWyYNbh6NOdl++lQBBnRmLGjHftfGB1sJ63e8heIQ4Pxfi0PnrK/TqFhLNRiU72ZxqYupl6WBuhTMsQc49r8VrgtxO6FBosXo/2tS4H7ZFCwjj5hCK4oE4ByOpycx0QsyYUwTFLgO+t2nnH4pJAMSfSDhGLU2L7AHHQTxdaz6xw4VAkg4zgoTFVJPmt9Sqj2gte93cFXKPSD6x37zYo+r+4n2Lpfi7QOVmwb1BSGLbSZVSKcUZzWE7gJ/VW35Vbx9k4Slh/2BIZv/EK11IwZ41ovxS+zTLYf5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ifl0GJjD4vLVxpFp472b8IpigEwWKYLbnwW1bzim4/o=;
 b=H4jIZ6IUg8h83I3wx573OTEPde/JqISUFB42DVgf6fXdIpH7Z7dTp9WZsZXM85ybp+tAbpg/nMM3vU5AWzJ3aD4JMZGME62JsHKv4grOBcCQa5QovEZhbzLpAbldZZRgUOEm5YrFfQlwJ/7UgYODg57r1jZY6Odxup8+6vAf2xD+QMxX2G5214g66Fsetaz9SV/H5bZ8l6DX6yNsuFFE8Wrmun666NNnbvOEsbha9pZXGNYC6PX66Jut9znX4RUKQ7+Ump8xUfahmRkMxQiddgaHo3HFfvuGXI/Qj02Jp9Z3soqwEsk3vNUUjFMbfdCm1YAWl/u+Ep60RP26IUchAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ifl0GJjD4vLVxpFp472b8IpigEwWKYLbnwW1bzim4/o=;
 b=N/XQQTdlEJJLyCDVhnrjQPAmZG8eST/RCvawA42+qvRw44VeYabtHA1wP8E+leXjgaWUy7cLZdBgvKtl5RNpF+/W0O8m73jhP6Zql0bX9bNe4jzLSP5RMPJ+Q2pb8dLj8DmNi8l5NXGLZ+1g/lZJUzjMplMikVNJBFh1lPQAX4Y/rnshW3cDir8ewbyLgI9t+wR0ugj6275z+9SHSfvLYKeWDzhRPzh+/wvWaQTuTOptje2hIutinaKsWjUDnNYCnRecv3cxF6f7indQ2RdgZqmMTq98pQY+FhjYy1uZJrofGYGrDiLc9RdMAomHp/A2pedYwemwJM2skoUwaB4WFg==
Received: from MN0P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::7)
 by SA1PR22MB4254.namprd22.prod.outlook.com (2603:10b6:806:373::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Wed, 11 Dec
 2024 08:31:53 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::a) by MN0P222CA0002.outlook.office365.com
 (2603:10b6:208:531::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Wed,
 11 Dec 2024 08:31:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 08:31:52 +0000
Received: from bf9ba858b69f.em.health.ge.com (unknown [10.168.174.111])
	by builder1.em.health.ge.com (Postfix) with ESMTP id E9DA780C;
	Wed, 11 Dec 2024 10:31:50 +0200 (EET)
From: Ian Ray <ian.ray@gehealthcare.com>
To:
Cc: nandor.han@gehealthcare.com,
	Ian Ray <ian.ray@gehealthcare.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update after GEHC spin-off
Date: Wed, 11 Dec 2024 10:31:36 +0200
Message-Id: <20241211083136.66-1-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SA1PR22MB4254:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3e8bce11-9fe6-4dd2-ed8c-08dd19be43cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hDLmH09INyFwjuyDiahZzi6bnUdnihfLJBJ4imWQqaoP3kFf8i2R19zSSl+U?=
 =?us-ascii?Q?VJPmXF/WQLbgzwaK3M8xYmtOOIaH+c2bQ/te0ttUvvtBLX8BxJQFsCZ7v/h5?=
 =?us-ascii?Q?RIE9yoQ+l0W8KMEJbePgLyX8bNIoFjdEpkhda2hCThOfY+bDP0tHJbBxBDqs?=
 =?us-ascii?Q?xaexBrs1qCb4XV462i20zaCwbsa+/UCKuwyhiBul+aMRFU5DsTr+l7ug4nH4?=
 =?us-ascii?Q?/x6+mBnRqWh0AHWPKR9YiSBtE+avR0IdkKSdLwsyo0YjXBtCmTZAD0JpsHp+?=
 =?us-ascii?Q?YiERMHNwmrg+MAflMzN8Jk9q2jQggcg6SYCrI/aFqWGTQ6XGXoawbzi9sf9t?=
 =?us-ascii?Q?mlk9velJ9dTgpf3Ghb3E+oi8aLXYq7UXYXoKwGjXuZ20mOSk3H1YLeTS6fjV?=
 =?us-ascii?Q?RsonPShm1u3K4N1MxgT9xGhbWNyjdtGWjWTO5SmLmvC8y7CtncgyAOOc7/5R?=
 =?us-ascii?Q?gJ9LWVhzTG3udsckSnBaenchbFFQQuxasgmmGEElxEbSss4aTgOpRlIASXBn?=
 =?us-ascii?Q?2WzA6JOh/xqBohXbSAri/c+ThWs7CBQVndxS0gpJTAU/eG85jQrvIpuPyVRa?=
 =?us-ascii?Q?cmy57tQBZLvgHvtPBu3ffs7auTlibcW0peACMdoo++bndFfZfCW+RDLy2pHu?=
 =?us-ascii?Q?EiobYH7YPRhqy/bWTbJkQJQ7djjamITDKwHSTefNqRyozTMmluTRTXe+snoE?=
 =?us-ascii?Q?eOJ2mU6j2yyN4UnBeyqANul9saY9TCs+EV+u/g4nHotVWyQn8cfW+LAqXHEG?=
 =?us-ascii?Q?yOQjGpFYZHhqtm9nCOxYRR4tYrRxPf8zZWozbVfDorbB4TPA9mXw1OvipFnw?=
 =?us-ascii?Q?RCF8CDR0Am/gLiDxazz6RjvfYkRCeZC1vdo5wljyGIPwWulN9pmgs8abReLK?=
 =?us-ascii?Q?L6fIl/oz70I6XyVxGrX61walsp6Pb9Je63TKQ2yQhKVvvl4xPWWoXFziaCBu?=
 =?us-ascii?Q?F9yrtL25uBQurn0wIBTv9Qz8L7Q3SESSfoamS0PDXr3p7P+MNLICFCziUpyb?=
 =?us-ascii?Q?dFb5bzB/tyH/wwRTrI5N4lS6PiMM0wUKUbzNoREByWbaRUKZ/AhPq2jPXvbK?=
 =?us-ascii?Q?EwQFbHa0/TxDhpZPO1jNCaLPF6rw1u9/KieUPeyH5v5aKsgaScWY4Wzb8Kre?=
 =?us-ascii?Q?Eo5KD05PhNEHVmPPm2mSdWwtzc3fR0gtoVU2/5XsQ/ZoQaK0oG6cGM/WfaOR?=
 =?us-ascii?Q?NzmdwT6Rrstaw9YZ0c94pONjUZp4o5W/7OSTv51c2XnuJz9Y6iw/OODluSv8?=
 =?us-ascii?Q?MBru0U2iXUd2Jpb+zMFjrEhNnk1ZJ4w+sHVqYHx3Ij/m2bDR6Vzt/f06aV6s?=
 =?us-ascii?Q?3zwcVVQHur7FPsaub5tfQ0G4fyKpYm6okniUji2GmFnipNyxKIyDwUnlsnSE?=
 =?us-ascii?Q?RDLecrEKfhebfsjuUiLK3u3J0py4?=
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:atlrelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 08:31:52.6275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8bce11-9fe6-4dd2-ed8c-08dd19be43cc
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB4254

Update our email addresses, from @ge.com to @gehealthcare.com, after GE
HealthCare was spun-off from GE.

Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 17daa9ee9384..43e40b05bd08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14789,7 +14789,7 @@ F:	drivers/usb/mtu3/
 
 MEGACHIPS STDPXXXX-GE-B850V3-FW LVDS/DP++ BRIDGES
 M:	Peter Senna Tschudin <peter.senna@gmail.com>
-M:	Ian Ray <ian.ray@ge.com>
+M:	Ian Ray <ian.ray@gehealthcare.com>
 M:	Martyn Welch <martyn.welch@collabora.co.uk>
 S:	Maintained
 F:	Documentation/devicetree/bindings/display/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
@@ -25866,7 +25866,7 @@ W:	http://www.marvell.com
 F:	drivers/i2c/busses/i2c-xlp9xx.c
 
 XRA1403 GPIO EXPANDER
-M:	Nandor Han <nandor.han@ge.com>
+M:	Nandor Han <nandor.han@gehealthcare.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/gpio/gpio-xra1403.txt
-- 
2.39.5


