Return-Path: <linux-kernel+bounces-389700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A444F9B7018
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2547E1F21EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5563D217464;
	Wed, 30 Oct 2024 22:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Vpen1JfB";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Vpen1JfB"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8826D1F4288
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 22:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.67
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730328898; cv=fail; b=XGqxLfwSWg5TMmtrDIucXnccq3EU7wADi7uz/ylqucNaPqrVtGFZvocegAYhdRX/LHExVYO0coQbl+hGwIiak0UB/LUNlJASA9G2FFgoVY0ba0ohFHKZA3zm8taBmoVJ7zs9bAdQt68VAXcBiznIaabl9QvfHYObaOn5sY/tgaE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730328898; c=relaxed/simple;
	bh=UPQKnA0E79gbgUa4bPOp6yrxogK/sJWjlXNUVcv0DHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rjz4D+9/wdoQHMwHnIgvGk6/4/FWdKe1UpSzfY6DXoJpnTDYICjwg6Q3mADAO+rAQZpocDgnNlMzkhwU7N69kIw2HPGHirLkOr6fP/1rZFZlQGHszKcoJbybAfPI4BVM18En1oaS6Qc08IdMngQQNnJcyBDiEGcWBCcTbaeXAfY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Vpen1JfB; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Vpen1JfB; arc=fail smtp.client-ip=40.107.21.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=bOrVoh19ruTdVCIUq32ifFKtXt54qI65Yl6XKaypc7+4PuxW3WFeOCrTX1S34qmTXDOZFoATrcGl//PfcLAIj0k+hdDNf79Z7h4bB4O/xwkO8zdQn0x9zrftrPI6yXhZj/WYanuoHrJlRExd2dESI5VlevguVkp0jDvEvwsMJar/ql1ixAe1KaZngwZwvSwOtzvdYZAHfrZyYXR1E2ngRDVsfiA5ujIjpqKgsR+XAzj2LOOlfyZ6BhiQtlJR0n/VfvPBvtnmNaTO3hfQM3GCvziPA1uF6a1h20KP+OVWfMaAs84soyibsJUYZrwIvgYRUeVanLywPzlkWC5eGKILVg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KS2RNOydT5j2+tNeEKwfMthtF+ZmUygKnhu6t3Stf38=;
 b=OpCd6yHUhz00sD6jq7O5AJm9k42lMdsnbC/x4ORz8ZuE4w7hXQpD8HE0CvlzvtbSl7nTowZWuJ2Jxjip5/kz14p0nt0z+PCO+BBZvPAgkCl3IEJHdlUPffef8GnDyXT8ysfT7v6YYKqANa5GH28RsByvSWVHGYG7Yvjtizq+oCzzXyHdq+G4fAiTfIVgquHbluJrw5MNCvaVY6xa7fTWO8WPbd9PkZZzoce7FynWFSo5AMoZjcaHlshu49NfrcSa3dv4ihF+2jYu1km/iM6SgeOTjZdopTnQ8pLX+8S4sLnf4/r7yR7ydMBNKKCIah16+2IG+UTxDB5GamYYu8ahhA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KS2RNOydT5j2+tNeEKwfMthtF+ZmUygKnhu6t3Stf38=;
 b=Vpen1JfBLIAzYXFfEjDI89yIEzS8ihScfD11VFfsfStjz79+EeSgJ1PDkO+RHHDaM5bZ6PeEOb+J4vPtP7Ap+BMsEtze0Gp8PBMuMpkrF9FFznxr8Mrz5QpSaatkHXEhQzWPt2ngPPbtgCqeAwO8v4iolTG5E8mA5j+D+s8Yv/0=
Received: from DU2PR04CA0260.eurprd04.prod.outlook.com (2603:10a6:10:28e::25)
 by DBBPR08MB6284.eurprd08.prod.outlook.com (2603:10a6:10:20e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 22:54:48 +0000
Received: from DU2PEPF00028CFC.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::f1) by DU2PR04CA0260.outlook.office365.com
 (2603:10a6:10:28e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29 via Frontend
 Transport; Wed, 30 Oct 2024 22:54:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028CFC.mail.protection.outlook.com (10.167.242.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8114.16
 via Frontend Transport; Wed, 30 Oct 2024 22:54:47 +0000
Received: ("Tessian outbound 99870d44e01c:v490"); Wed, 30 Oct 2024 22:54:47 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3d5412f84220f916
X-TessianGatewayMetadata: XsGE7xrCKjTeo1U+9Vw0lzhmGLzhnALo+Gt7jV5buLgAiueOLJi1P51iJ1nva9YFOxLSgCv2lswPDGN19IHOOKwNyC8j3yYbz9N7JUIf8zP8AvdxAwpA1kLhv4pc+NEsEK4pYqX2MS8Ipyc8AB86DonfA/6E5ZIJl1wrij3dgjc=
X-CR-MTA-TID: 64aa7808
Received: from L7320d669fc95.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id C8A8A916-5F83-4A23-BA8B-08292EC32A9B.1;
	Wed, 30 Oct 2024 22:54:40 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L7320d669fc95.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 30 Oct 2024 22:54:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nflYbtHZWpmU+lkovnr34/p4MtfSz6RXEKO20WnRTfcrP06ijUPocymU7fyQigICLOhufbM+RGdaSnH3dk/p7hz0wELMApstZHN3YAAdxzTXt1gdXPVOgyCRpiswtMKFPd8WjA5TrSW69gH+KJBZ+nDDgkYxrUGjgNrCDHC3r/0pEsGP1W9xK6wIRaH6FvItFAAx2NQZtYvCqptMo23ggdHhpHkmpEy9tJyEow1XC6VDC3DIg2uVRiizz0pObH4yLvRzAUt00hfYHQ5u//krBvMSuJjULd8P1Zzuu8mgPW1vdiqFxOBydAPBBI0+0HXwadMpQtg9SMCUp5Pgc6CtKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KS2RNOydT5j2+tNeEKwfMthtF+ZmUygKnhu6t3Stf38=;
 b=v0j0L3oh/nvNl7DHXtbfOYFmykNv6B1+l3/y6MydDPKz3i4nRFPk4zB2Xr7CQwfv3Pr+ZAdDodBpldpl8Q+Q90znSO5nDzajxmjmEMAIB5fCcKqzgml0DYz1XsE6MPN38CImYn/VP1Zhccp2Bb7PsLtKrvXQDviYBzMbraplEywyb3ABz6pV6qC5SFYKa62329oZPXM0JKEwwKdVby78erYJ8rIWAoBlLhjGFT6PVoY36mIpXkYIakHplNLvCSROjheC8ra/Qlf3WE5Y9tMeUhOZs/kd0PprhY1yABs/6kD8wRht6RH9WekBugYNg2bUtuVo0ywjobz3wJZgtUeaJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KS2RNOydT5j2+tNeEKwfMthtF+ZmUygKnhu6t3Stf38=;
 b=Vpen1JfBLIAzYXFfEjDI89yIEzS8ihScfD11VFfsfStjz79+EeSgJ1PDkO+RHHDaM5bZ6PeEOb+J4vPtP7Ap+BMsEtze0Gp8PBMuMpkrF9FFznxr8Mrz5QpSaatkHXEhQzWPt2ngPPbtgCqeAwO8v4iolTG5E8mA5j+D+s8Yv/0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com (2603:10a6:20b:415::16)
 by AS8PR08MB6182.eurprd08.prod.outlook.com (2603:10a6:20b:291::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 22:54:37 +0000
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd]) by AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd%3]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 22:54:37 +0000
From: Akash Goel <akash.goel@arm.com>
To: boris.brezillon@collabora.com,
	liviu.dudau@arm.com,
	steven.price@arm.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	mihail.atanassov@arm.com,
	ketil.johnsen@arm.com,
	florent.tomasin@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	nd@arm.com,
	Akash Goel <akash.goel@arm.com>
Subject: [PATCH v2 3/3] drm/panthor: Prevent potential overwrite of buffer objects
Date: Wed, 30 Oct 2024 22:54:07 +0000
Message-Id: <20241030225407.4077513-4-akash.goel@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030225407.4077513-1-akash.goel@arm.com>
References: <20241030225407.4077513-1-akash.goel@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::13) To AM9PR08MB6982.eurprd08.prod.outlook.com
 (2603:10a6:20b:415::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB6982:EE_|AS8PR08MB6182:EE_|DU2PEPF00028CFC:EE_|DBBPR08MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c8ff71-56b3-4c4e-65fc-08dcf935dacf
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?TWwCSVWdraMvxI7DEBJ9CAUb44PdD88Gz14xfTH7p6ucP0UYZIXQV626EZwK?=
 =?us-ascii?Q?cu4cIwj3lKydc8lXv7nzq6iQyUXPUcaiVtpo7gi3cO+MrYy0EkfpbJH5dqF6?=
 =?us-ascii?Q?l8kSy+519qfMgkelNaBHnWfQ8uYuLuPQ9kOzn+exc4R7r4Lgd/Swq+DVlIVn?=
 =?us-ascii?Q?XpJxZVotvQYAW8lRtQahrHeb3PHWQhQfMYbgfx44Bi8esG+oChcwSxI2l+Yj?=
 =?us-ascii?Q?IPcto1TBnFIY/v0XUsf6xM0Kglcx7tZJmM1YjmvEGPUVL6IcgGmh0K0/4JfP?=
 =?us-ascii?Q?cysehJbWuH1jot0zajDoGf33bQPCuZNEeG/RJs2R3K4bLHM6XNtdKyLEuZjo?=
 =?us-ascii?Q?hgUej2PFaibMCdp0aSGOxb4BwN7IStLJqCLo7vHRZBnNJLVvQDjsOR+G7tKM?=
 =?us-ascii?Q?nevFJwro3NskI303dAPxq+Ni/Li7Cu3QyB5SDBMSQvLxS0Y5muQHag8uGX41?=
 =?us-ascii?Q?jI2Yqe5Yn0Xq5erZ1oDtJpw8JwMhNH6G6JCGScuCZrmU5hQcd9ZcOhsQw0YH?=
 =?us-ascii?Q?ucFcDusdzWSpNNv6vZ7ZkV4M0KtKfMxJi9E8i3FQCSLfysjS76cQekRXkohk?=
 =?us-ascii?Q?+IP7Cf9UTh8gjtvVX/Z5dUQWKuI+xe7VNHNcBa9pKmfZpDgfxZkGFvlzI8gk?=
 =?us-ascii?Q?cPRzdTsYZLk4+NPHxm+XlMMZten8stCL2THxM7q3Hb5T2p9SwXGcq6P3FMBN?=
 =?us-ascii?Q?JmoZwBUOu70FDNXL9toCpQK+eOQ0jzaNRBuyNaJxOoV7RI29m/c9k9vL4Yo7?=
 =?us-ascii?Q?dOnlSMULiWY9K0Eg20ax/SES5Crn9qv5Q6JamPmBrBcYhOyp8IpMQnfPiGYY?=
 =?us-ascii?Q?o+/quxMkwp5Dp4teGzc1FgZzG+cXONPFNmmGal+rAp0MPyrJON3uDJMhvYr9?=
 =?us-ascii?Q?GTbNU/f7QGaQ4aK2TqSkFA3MKYa5fXVNXvYG5GLmtv3oMC+7HmV5q6w7NZIn?=
 =?us-ascii?Q?cmMPchY7T6sn4fXvMHvaSVBC2+kQdu8eGmOXQp1dOulZML2b7rkxvPVgxV4p?=
 =?us-ascii?Q?7UGn0A5TCihl9D/VLOOMco2Yj4EmmeJRpX+/V9csWTIV+3QNxPe6f68XRevW?=
 =?us-ascii?Q?rItPnTS5wuchd0xzkeSDhMK3Xh+OjSvPKoeQJdYvCW1TmBIzP5J88a9+AB1q?=
 =?us-ascii?Q?J5fsh2wuWFtzwAh4fLepP3w8cAfRmOUaGedt+2gsEjW8Ar/zd3zJqnE20elT?=
 =?us-ascii?Q?xQO6GPTzHHGTobYOWviXt+2DPZzteGMfod91gtRt6O4pBIWKh3YXAZPyK4Y6?=
 =?us-ascii?Q?ls+TSuOLHWV+OnKq3HfGfIgqYFzCAGTh+BWxBB2pguy7NDJY9pT13vcQyMhE?=
 =?us-ascii?Q?XLFLhSo6Vm1eOZNPJz5X0a0B?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6982.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6182
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:415::16];domain=AM9PR08MB6982.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f5d2057f-6cab-4575-5725-08dcf935d4a1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z9QQCQ0dHn6poChlAj10WYJIEplnOAAzLr5zucLAEG7+OKQJER/Ejymh7o/h?=
 =?us-ascii?Q?yJaGTxN63EMg8HN/aL4iM1kTwPUcYorufOt4v69SJVALTM0p37Ww4PD4uo5h?=
 =?us-ascii?Q?JeJABIQ66sUkD6RSsS/l5tC2WlCc/3LNW1+jj6aTqGUhT8lTGHsUllveqfJV?=
 =?us-ascii?Q?qebP8YCDE/r42VJTFr+ASZI6liQpnh/rNMy6aSEJ1nW56OxbLGmff7YjIWmS?=
 =?us-ascii?Q?cQr+p4V7ADRrB3s2Hq0A0gNOq2NJHGBC2lf45+ABrXHYGsIpQ+WX3djEBNhs?=
 =?us-ascii?Q?9nLHVQqVnoRaNtIjd/xf/rI0ePv2ZG6LMmImg1EzvtNC2eoWM/R4bohoRwDf?=
 =?us-ascii?Q?B5XCXt/+gKz9kEhD7lvSrwlI++vKvIIHRq4qb4u/VUXRkWoZePSDQn+/05V3?=
 =?us-ascii?Q?0MlF14sobVY1rlG58rpc1LRtLsDaKqkOUTgWuS7x0tJ4udHBuxRr7osuYHoR?=
 =?us-ascii?Q?QbHlZTEn4aI8TVm28SXFvATtqZItOb4Ua7vCviUdbg3I87XRRHoosjO5T01X?=
 =?us-ascii?Q?/qnLtBRSmLBZuaeqPmb1bxcurhKe3jtb8uPiWL3EBJ02aWc7qNr/OixmUO8T?=
 =?us-ascii?Q?n6YQyYv7eUR7ul70DLhx5Qk38YmNx1j1m48o+W97CL1bNXpNIReLRNuNtqKE?=
 =?us-ascii?Q?KmXMagE87d3QI4+3yTj2qeTHRd8EYIoAVhjyd7RvpfAKrbVfQmEUdnudMdwU?=
 =?us-ascii?Q?9MD9YnbredgCTUruZ1gybAPfpPOA04LpVvxdjgsKR4cr7Emjrns8pDUVBM2/?=
 =?us-ascii?Q?NpWV4ntVlUlkkLlyumeKM1j55+BIi/o7Bb0wpMenhc72jUiESfWAWJlZRLyy?=
 =?us-ascii?Q?zsSQTmde8NKVNLSw7Nx7zeRD4b+BNOiBrx9CKYcDuhtntM8t3TTz17P3TzC+?=
 =?us-ascii?Q?yyB4N3bi2pmVZQGr10B3Usx8WuhxpNHMVSGQDwcSadiMsEImk37s6CiWs+B5?=
 =?us-ascii?Q?gI3TLVV8Tem1xN4gbX4I7EkuElV20iOfeLX27LkqYByN4ZqhH5Wnv60Zr5Fm?=
 =?us-ascii?Q?k5A1RN42uvDcu1JxIOv19e/pVrr8WInBrXwW79n7nuD5zhCJyaOPyWDIkEvU?=
 =?us-ascii?Q?rLYg42FhpyiAekiMf9+KnSGghOd7mF/iQKboHzQNIwPRMZzOZCjbEwPhV9fA?=
 =?us-ascii?Q?GMo1NhHtsDO2CkSyVbTtX+YTDYzx3mWjbwzRvTUzUChK5hmmLsM2i0UJcs54?=
 =?us-ascii?Q?in+iaZrG8Bq8kR8nu/8FxpiPOzYLQNniIN5koXqJaeL3quAJfKDUeEldYnTs?=
 =?us-ascii?Q?h9aXw5rp/PlsEC7xagI8EZYhJDIhwDNVK9LzxHs/EtY8Ww2uxysdoB4mlmA9?=
 =?us-ascii?Q?j+bltk4K+jsV3bkC2D4g9FZXkvFU6jJ7pSDla+ztH1AT1v0tZTdTCSLYe9X8?=
 =?us-ascii?Q?aNjhXwbjHYuQ6c01a4cfoASh632wE0gKln0wYEYjhyruy0qIDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 22:54:47.8594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c8ff71-56b3-4c4e-65fc-08dcf935dacf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6284

All CPU mappings are forced as uncached for Panthor buffer objects when
system(IO) coherency is disabled. Physical backing for Panthor BOs is
allocated by shmem, which clears the pages also after allocation. But
there is no explicit cache flush done after the clearing of pages.
So it could happen that there are dirty cachelines in the CPU cache
for the BOs, when they are accessed from the CPU side through uncached
CPU mapping, and the eviction of cachelines overwrites the data of BOs.

This commit tries to avoid the potential overwrite scenario.

v2:
- no change

Signed-off-by: Akash Goel <akash.goel@arm.com>
---
 drivers/gpu/drm/panthor/panthor_gem.h | 10 ++++++++++
 drivers/gpu/drm/panthor/panthor_mmu.c |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
index e43021cf6d45..4b0f43f1edf1 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.h
+++ b/drivers/gpu/drm/panthor/panthor_gem.h
@@ -46,6 +46,16 @@ struct panthor_gem_object {
 
 	/** @flags: Combination of drm_panthor_bo_flags flags. */
 	u32 flags;
+
+	/**
+	 * @cleaned: The buffer object pages have been cleaned.
+	 *
+	 * There could be dirty CPU cachelines for the pages of buffer object
+	 * after allocation, as shmem will zero out the pages. The cachelines
+	 * need to be cleaned if the pages are going to be accessed with an
+	 * uncached CPU mapping.
+	 */
+	bool cleaned;
 };
 
 /**
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index f522a116c1b1..d8cc9e7d064e 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1249,6 +1249,11 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 
 	op_ctx->map.sgt = sgt;
 
+	if (bo->base.map_wc && !bo->cleaned) {
+		dma_sync_sgtable_for_device(vm->ptdev->base.dev, sgt, DMA_TO_DEVICE);
+		bo->cleaned = true;
+	}
+
 	preallocated_vm_bo = drm_gpuvm_bo_create(&vm->base, &bo->base.base);
 	if (!preallocated_vm_bo) {
 		if (!bo->base.base.import_attach)
-- 
2.25.1


