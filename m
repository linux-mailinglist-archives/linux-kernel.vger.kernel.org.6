Return-Path: <linux-kernel+bounces-441693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C2F9ED2B8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040041881DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE761DE3DB;
	Wed, 11 Dec 2024 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Eg2C9PJC";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Eg2C9PJC"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA11DE2CA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.79
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935873; cv=fail; b=Xl5oRH6iT8+wLpCp12S3FHKqiHJ1O9oU4rXNkUbhHm47uW54yRZEK5MNcu++bCeqeKBOIi/nDPMPxfr5I+me6RYiD8QGSwNEagFQPfbHYCP0zpGdfo4sfVw20oAjKY07tQqUQgFgwyVg2scfeLQV2tesJQJUDyj703tLj1xCs0E=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935873; c=relaxed/simple;
	bh=tR+wnlwOItJCghUuyD5cB6uVsmeaAFpsCgu6H7Uab+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vx58QXs/9cH1qt1677GwUJOJTlT4IXP4P0jvjyyWkOqNvWj2I1Eka1+ym/5XNrMtNUd+u4s2wIbBIBmxD07/QOnvxUd+4ahyvDfpGbK8ewC8WxhZXx7z55cRjLE4grvMGAFtGWMA+myC/ujldBM1IEolCn7Jdhfx2CFdBCB6wPs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Eg2C9PJC; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Eg2C9PJC; arc=fail smtp.client-ip=40.107.20.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=E5V4aUtYnEacaDCJJiUjim4g79m1VEKR151/7iAsv40iyZoxQK7dX5qdyxQ1wZYglr4o1ZIXROAHfPKtgIsT6MSWnLUlS5AgP+yeM8NVUiVgr1o1Er7WW6UWRbiYz6STQ+PYWFS6bQzZwpGxWuwwBQp45yTYMFamDjsmhC5DROP5wS02i4pjFpYjSVZ2eWEwOzfgF1+wIKyqNEP6sPX8w23zPmAaoF01XYHQcEdhQOwKn1YknFZzoYvfQ6wfPiDtQ+jispml+pflcrQD6vOA9R9Tgv7fc5y0A6e+pn+z4ktmLG8rh9A7dpr6Hym1VGcCSuVmgkK5ehVhSRyLWGBPDg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnRRPi1qgykoryDTpNMWdOoeaBEICiR/2/DWUN0P42I=;
 b=rJjSxFo7Q0RCKrgqm9mn/LeOro1BJxQp0nfo0/0NI3rJNBh/NfeKd/RW/LXTb3f26nad9AwfmfowhtmrzBkslNz6IDLy0+MzRQVQjjJPrByPllw0wfh7/w+iRFoRcBCxbJTcUyno+U1WUY0ghUeQP4fE6lNdtXc+vnz7Uoq55OyLILI+KkCmZgvfHMy7l6P6JONeCjoPJKkhApvJ06/PvyZpfI3eW6bfqeworzAZJcGITKlmJJvJvRu8zTIWNQrOfN8XjPL7E9eZlgF/sutGinl4Fe18pyUXysQnZOcWwHRegWiHTMJH80l5SAMwRfRuth1zeYqlOCawE92PcXKTAg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnRRPi1qgykoryDTpNMWdOoeaBEICiR/2/DWUN0P42I=;
 b=Eg2C9PJC0Ctt8dr5Q85JZvFyITLvFihjQRZx85nQb0dRJJiOQNkWwRVehQxB5InvXILatnmiLS0ca6IyKca9xKYctypJtBP6iIK6Pz5tmT/ZSDolrwjnaCk9v4/s9T3nsWr3PkDO0Mgt15YCeemPFVBH3rpE+DrgPh2camk1bsQ=
Received: from AS9P251CA0007.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:50f::9)
 by PAXPR08MB6701.eurprd08.prod.outlook.com (2603:10a6:102:132::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 16:51:05 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:20b:50f:cafe::59) by AS9P251CA0007.outlook.office365.com
 (2603:10a6:20b:50f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 16:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Wed, 11 Dec 2024 16:51:04 +0000
Received: ("Tessian outbound b4c479532664:v524"); Wed, 11 Dec 2024 16:51:04 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 273b848151f7c5a6
X-TessianGatewayMetadata: zESo4hTlpDNPaXta/xOJhQiMWFWLFKIdZ1358u8XZBHJoi53weNnK/ZNKZx7p9x2HeYLU1lYq4M0FjXNh/q7smGZZQMvFsfZMDTxa7aU4yE2ZF+2WkU6jrWuDOIFH7k792OeEo5553vu7Df7ldVGZooXnb3UqZ3YtVttq8Yt1NI=
X-CR-MTA-TID: 64aa7808
Received: from Le3bc87cfaf57.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id D244D080-42E7-4966-9FE1-F7003380A67A.1;
	Wed, 11 Dec 2024 16:50:57 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Le3bc87cfaf57.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 11 Dec 2024 16:50:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hvpxv9WayDe3LCbh9ZDVua2Q8fFcUuq1OpmC0aXEqmvzZHNl8lleG0GKa9bfmdsKGu32UHwvrI8hzmql2tH+6TYrZrARZHJKkkJDRUKq97QhKvP8HNJYopfjm2Pz4tulerq6B/p+UynJKvGTzZl8p//yoNAL6X44bi9hu5y/mFe9OzwszbCUeWrv0z4poUcaBqLNOOVthq7Xgw5GPtj4wHqwOXCQxO6TqKK+acPZph7K/lqbMKH7Wr1UqcKRCq5LNwtMovRmRP3aKwmpdUNdR++mRBeli+LbPdTuF36RZy5tcc/XKCiWl04uABsu26hfAneUjXCLIZdyUtB2SQQIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnRRPi1qgykoryDTpNMWdOoeaBEICiR/2/DWUN0P42I=;
 b=pxZTuTZFGkoLs43eWIFRTwl1FsRrUsLAy5nCdCidvstSjjibR5znq5nYBNJ3oVjEyV9mIEnpMccYFYwzPX3SWLBpGT3BL6lgwfxM8x32zzZMC3UelqcTO40AjZSng0IKs22qwbi3DDfvcIL9C9rK0Sqqi+2vmqV0G/DP762LT/zq2wRTzrapbONUyvaTgPKiYjHkA8BtzrRqO3PekAeKqY9ymLS0cwTJa/wT85eE5wruNO9rXL7PYoM6X6UsqwcYaFtqvrSwLUmXV7HqVFCxGV+y1dOiYOe8WbtkgAmiJtB1pK7bLyzw7nEhxOT2jcizX16Gy7PiaK3y8ea/edsjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnRRPi1qgykoryDTpNMWdOoeaBEICiR/2/DWUN0P42I=;
 b=Eg2C9PJC0Ctt8dr5Q85JZvFyITLvFihjQRZx85nQb0dRJJiOQNkWwRVehQxB5InvXILatnmiLS0ca6IyKca9xKYctypJtBP6iIK6Pz5tmT/ZSDolrwjnaCk9v4/s9T3nsWr3PkDO0Mgt15YCeemPFVBH3rpE+DrgPh2camk1bsQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3317.eurprd08.prod.outlook.com (2603:10a6:209:42::28)
 by DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 16:50:54 +0000
Received: from AM6PR08MB3317.eurprd08.prod.outlook.com
 ([fe80::e42a:494c:6581:1897]) by AM6PR08MB3317.eurprd08.prod.outlook.com
 ([fe80::e42a:494c:6581:1897%7]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 16:50:54 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mihail Atanassov <mihail.atanassov@arm.com>,
	nd@arm.com,
	Lukas Zapolskas <lukas.zapolskas@arm.com>
Subject: [RFC v2 2/8] drm/panthor: Add DEV_QUERY.PERF_INFO handling for Gx10
Date: Wed, 11 Dec 2024 16:50:18 +0000
Message-Id: <20241211165024.490748-3-lukas.zapolskas@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211165024.490748-1-lukas.zapolskas@arm.com>
References: <20241211165024.490748-1-lukas.zapolskas@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0042.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::13) To AM6PR08MB3317.eurprd08.prod.outlook.com
 (2603:10a6:209:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM6PR08MB3317:EE_|DU0PR08MB8422:EE_|AM3PEPF00009B9F:EE_|PAXPR08MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: ca05156b-aa8a-4af8-f285-08dd1a0400ab
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?fa2EnVB0DefRBAh0xIHXMtgpQW4qJ+KZdIokFSkwKwqagoRNRgS0MHwocF/n?=
 =?us-ascii?Q?33An7Auj7aIfiiPWuGovaZHDlUtm3QmFHToUKrewcWsPnjrq7+klTvGcZmCq?=
 =?us-ascii?Q?S9xVykjzY9Fnn54I23DMcXwdu7jvplyqAFMTndDPk7wWxw8HxZv1e/4ye8kd?=
 =?us-ascii?Q?t9xUdoH7UzFdPb2EwAIRysTAflAcJSfiXxPqApK72ciRAfdJ0ER0xv10APw0?=
 =?us-ascii?Q?yEIvhz2rqdoVIWfdwBMl5Jm1zvd4vxEa7yZsXM0mDxWyl+BSAOj2mPdhj6Pj?=
 =?us-ascii?Q?+A+do4tQyXkl0LC/o7dRwryAU2xGqgxvfBDRseOu1SwVluaDj6wRDKyeXbpi?=
 =?us-ascii?Q?qWxO1+ZqIGKLaQwgxT7mJY6nGcumK8tJ6DTl3JcG7zyWu2jh5I5Dxq5kWIET?=
 =?us-ascii?Q?hqYyMGWM4YYH5jJRM8Vf6jyYk5NZ9p1NhFTrd6lt/5uho5l4VgktMkguAmcS?=
 =?us-ascii?Q?R7OJpaIyxNfqZ/EqaJ/A4MKt3ituHpQscL3G58er/YXi2IP4Sfi1OFiYlBvE?=
 =?us-ascii?Q?1888UK9F14WB/G2gUSsuOV0OPVvOtSRTJ4BwDYXSJvKHdkVIr2OnnW6mnSDL?=
 =?us-ascii?Q?n7LfRWYGIR/IULBKE3LcmwQn82hBQRaB0JO048+JcqodTyrW8lxcxnGkONlc?=
 =?us-ascii?Q?ISrO5EhiKt/2tmx8kLBA8BL808B0rekjP+tIl/LHzacx6U1Q8TqlUblhbzsN?=
 =?us-ascii?Q?thI/4Arcv8q+7iALY4mNXLYlUfpbIcyUGOHlJro6J6vmGnqPeUEV2/U+dysn?=
 =?us-ascii?Q?t9GET6e1kxmlq6/yt1ADBg/LKeguyIGD0X93DUsHBhuArI4/JLUOf6nmrubD?=
 =?us-ascii?Q?oKcwBLDszqnjsowFz510GTLRG6EgvPjqiyVU65iT9ot/Xrq+Fylv2dia10U1?=
 =?us-ascii?Q?VkwOtuFf+pd3Ybon4iMtlWPdaINqJsWPKB4RVJYJN3Rc4A6VvgU8QO/Vrj4N?=
 =?us-ascii?Q?YctsZCR5KoVvoOuTo1WoUweqhd2j1Ln/tTT2spvmklovqLuEMmqVXr17ploY?=
 =?us-ascii?Q?Ax8zGhIvEl6/+pl9jr3IB6dNCj9p8LmVxHBj/Ms8yawlEb/Pzo9yneoNOJAa?=
 =?us-ascii?Q?nOQh4qRF5L8fuZkNe6DkW8aZ5aYqmXX/+uOlrfFKB9fvc8AbhG/hA26eM/YJ?=
 =?us-ascii?Q?b5t+WdmIcDUdARYygpcBzdl/2TRMr9EofkgrJJwRZCahovFSxCie30sbc7/2?=
 =?us-ascii?Q?6cYbpFBRrIed8XW1ugbM2r/qODbLdrq0t1sPlUOEkuAkKj5GKyfOgsBWAtmM?=
 =?us-ascii?Q?iGiBuDwBKivQjuhWbJenNauzsiVMAOMITCO6z7bnKgCrEsMMAn5Y7yf+7De3?=
 =?us-ascii?Q?YqmU71ZCnNEgIKhIPyudrNExJSirvSRSeW1vSfzJBqKQbw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3317.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8422
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:209:42::28];domain=AM6PR08MB3317.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f36cd835-dbd7-443e-4c92-08dd1a03fa8c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|376014|1800799024|36860700013|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SeLZpXB1YE3O++YMT0/JtZnSL7K8dJGhDM5EjSXMHSXfLUgi7WlMpSxSh/4Z?=
 =?us-ascii?Q?oCEmJ8uWGZM9YumtgJY9l+tiqfZu8IPDF4pjayTSjKMHM0jGIUqy/WbT8oZ9?=
 =?us-ascii?Q?QJRGzrjjpcIwCRm/Bf95KsU7AgmHQV7P2ZqFeTvO4Ay3AL1n2WRbWwu/0M6p?=
 =?us-ascii?Q?V4zwkFVFQT3UPC1Q41nI2MD7mYVuoIO9k58nkluArf/x2VFUKmsm/8Gbs7xq?=
 =?us-ascii?Q?eXyzl5SXMP4CoYafT1ZU6KR9sETeCtlZeMIHnSDqtbPNyy1+nQV5lPauedz2?=
 =?us-ascii?Q?Zg9CD7uSn1NaW8WFUQgDs35gxivmMEUi8ufXHK4k9emFs9/pC/Z7U3b++OXn?=
 =?us-ascii?Q?cKh6hcZ90hA7c9xKO0RKk8n/RZZseTQj1YI9xII97vptqoTkX1T6qDwQPhmb?=
 =?us-ascii?Q?jRUsCxSzCFw4N17rBJAludG+hWmmYsQdwygOSIrS7l3YfYcdNmOQJTXNOP46?=
 =?us-ascii?Q?mfUOcqIl0oH5ZBoccn2ilU7tKUBoqxoTdCgZYs5mDdY+8HVlcHZOOAfhNAZT?=
 =?us-ascii?Q?DUP2kWIbYESGqL0hQ7DYbmVp1EVySCFHGUr/Lg1qb5ufK880elgaswISvORQ?=
 =?us-ascii?Q?aKPDp++mlgo267QnkiGSg7XmGdyZ5NTgH4lHePlz4L7nUtVUeFxoTWUU3fhO?=
 =?us-ascii?Q?10mizGty0Fo5v+3YZe36LiyT837pk2e/FYYn2E7NVP+/WNudmxvlobAlZ2x2?=
 =?us-ascii?Q?phOmaQ3EfxSDLQBLB6ArL+ZeTazkcHkxq7bGDhu6L7ZtwmGvfkZpKYswhQWd?=
 =?us-ascii?Q?5bN9rHm/tJYZxbIqva0+zMzAmkkR5zWKGvB+BnhHOPvRQN2MpVoF58oYw5Io?=
 =?us-ascii?Q?YJoeH+mmEfk7FTAL/URzbM2JAAgXaLam5zRxdllms/wVTPipDJmAq6b0J+FX?=
 =?us-ascii?Q?1rNwsQJSZ2IAwxHyEHIsGWSqo+95v0GOOkrgE4W5CuyqXjmGoao02lG3KOP5?=
 =?us-ascii?Q?QLtmeseK18RwlOueOEXPAn+ZBxr7RWqwb/QLQAU8Fepz1kdase8x3YBTJ097?=
 =?us-ascii?Q?PnP2XiqVF2sfqTIJh/wvnJl5F3AIyOlqJd0X2foK357MOgVEIKCGx5U3hQzm?=
 =?us-ascii?Q?/kwFoSSHDebb3D0brKEJPYfxIm+ZYfRPjua2xzTNt7WArFHPSLAAkbHog3vc?=
 =?us-ascii?Q?1X8XP4ROr1dAkHcj2ivszt3pPGzQ8ABE2BpsSPUxhHsSfy5ahf4+VZChwB5U?=
 =?us-ascii?Q?Tpfkj24G5zYGwd7C3jcBTsdO8OVuPS5770qhRQTiOzjlemGeT7I3dvkbzq7Y?=
 =?us-ascii?Q?NYl+niJsEpVyvcBuDALmW7VKfX0kyTxUtQyGD8yNraQJnUl+KQ+BrGqFpW55?=
 =?us-ascii?Q?ZNXbXLfL1sixaUT5kK/tY25rx1oIC1/snliZOTuQSXukAMczgNrE6CneqBdC?=
 =?us-ascii?Q?0BozF/3pgqrSAwafYlA79gomEW/+XS0UxEfqGvntWxsUHUjUAMMMgAXY/bwk?=
 =?us-ascii?Q?hxE1vErxSkU9Htg2vT8lKnMkvAGTZDMbUsjmyXBzfcvBKHaO3mEJcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(14060799003)(376014)(1800799024)(36860700013)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 16:51:04.8688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca05156b-aa8a-4af8-f285-08dd1a0400ab
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6701

This change adds the IOCTL to query data about the performance counter
setup. Some of this data was available via previous DEV_QUERY calls,
for instance for GPU info, but exposing it via PERF_INFO
minimizes the overhead of creating a single session to just the one
aggregate IOCTL.

To better align the FW interfaces with the arch spec, the patch also
renames perfcnt to prfcnt.

Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
---
 drivers/gpu/drm/panthor/Makefile         |  1 +
 drivers/gpu/drm/panthor/panthor_device.h |  3 ++
 drivers/gpu/drm/panthor/panthor_drv.c    | 11 +++++-
 drivers/gpu/drm/panthor/panthor_fw.c     |  4 ++
 drivers/gpu/drm/panthor/panthor_fw.h     |  4 ++
 drivers/gpu/drm/panthor/panthor_perf.c   | 47 ++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_perf.h   | 12 ++++++
 7 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_perf.c
 create mode 100644 drivers/gpu/drm/panthor/panthor_perf.h

diff --git a/drivers/gpu/drm/panthor/Makefile b/drivers/gpu/drm/panthor/Makefile
index 15294719b09c..0df9947f3575 100644
--- a/drivers/gpu/drm/panthor/Makefile
+++ b/drivers/gpu/drm/panthor/Makefile
@@ -9,6 +9,7 @@ panthor-y := \
 	panthor_gpu.o \
 	panthor_heap.o \
 	panthor_mmu.o \
+	panthor_perf.o \
 	panthor_sched.o
 
 obj-$(CONFIG_DRM_PANTHOR) += panthor.o
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 0e68f5a70d20..636542c1dcbd 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -119,6 +119,9 @@ struct panthor_device {
 	/** @csif_info: Command stream interface information. */
 	struct drm_panthor_csif_info csif_info;
 
+	/** @perf_info: Performance counter interface information. */
+	struct drm_panthor_perf_info perf_info;
+
 	/** @gpu: GPU management data. */
 	struct panthor_gpu *gpu;
 
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index ad46a40ed9e1..e0ac3107c69e 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -175,7 +175,9 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_sync_op, timeline_value), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_submit, syncs), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_create, ringbuf_size), \
-		 PANTHOR_UOBJ_DECL(struct drm_panthor_vm_bind_op, syncs))
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_vm_bind_op, syncs), \
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_info, shader_blocks))
+
 
 /**
  * PANTHOR_UOBJ_SET() - Copy a kernel object to a user object.
@@ -834,6 +836,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 			args->size = sizeof(priorities_info);
 			return 0;
 
+		case DRM_PANTHOR_DEV_QUERY_PERF_INFO:
+			args->size = sizeof(ptdev->perf_info);
+			return 0;
+
 		default:
 			return -EINVAL;
 		}
@@ -858,6 +864,9 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 		panthor_query_group_priorities_info(file, &priorities_info);
 		return PANTHOR_UOBJ_SET(args->pointer, args->size, priorities_info);
 
+	case DRM_PANTHOR_DEV_QUERY_PERF_INFO:
+		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->perf_info);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 4a2e36504fea..e9530d1d9781 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -21,6 +21,7 @@
 #include "panthor_gem.h"
 #include "panthor_gpu.h"
 #include "panthor_mmu.h"
+#include "panthor_perf.h"
 #include "panthor_regs.h"
 #include "panthor_sched.h"
 
@@ -1417,6 +1418,9 @@ int panthor_fw_init(struct panthor_device *ptdev)
 		goto err_unplug_fw;
 
 	panthor_fw_init_global_iface(ptdev);
+
+	panthor_perf_info_init(ptdev);
+
 	return 0;
 
 err_unplug_fw:
diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
index 22448abde992..db10358e24bb 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.h
+++ b/drivers/gpu/drm/panthor/panthor_fw.h
@@ -5,6 +5,7 @@
 #define __PANTHOR_MCU_H__
 
 #include <linux/types.h>
+#include <linux/spinlock.h>
 
 struct panthor_device;
 struct panthor_kernel_bo;
@@ -197,8 +198,11 @@ struct panthor_fw_global_control_iface {
 	u32 output_va;
 	u32 group_num;
 	u32 group_stride;
+#define GLB_PERFCNT_FW_SIZE(x) ((((x) >> 16) << 8))
 	u32 perfcnt_size;
 	u32 instr_features;
+#define PERFCNT_FEATURES_MD_SIZE(x) ((x) & GENMASK(3, 0))
+	u32 perfcnt_features;
 };
 
 struct panthor_fw_global_input_iface {
diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/panthor/panthor_perf.c
new file mode 100644
index 000000000000..0e3d769c1805
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_perf.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2023 Collabora Ltd */
+/* Copyright 2024 Arm ltd. */
+
+#include <drm/drm_file.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_managed.h>
+#include <drm/panthor_drm.h>
+
+#include "panthor_device.h"
+#include "panthor_fw.h"
+#include "panthor_gpu.h"
+#include "panthor_perf.h"
+#include "panthor_regs.h"
+
+/**
+ * PANTHOR_PERF_COUNTERS_PER_BLOCK - On CSF architectures pre-11.x, the number of counters
+ * per block was hardcoded to be 64. Arch 11.0 onwards supports the PRFCNT_FEATURES GPU register,
+ * which indicates the same information.
+ */
+#define PANTHOR_PERF_COUNTERS_PER_BLOCK (64)
+
+void panthor_perf_info_init(struct panthor_device *ptdev)
+{
+	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
+	struct drm_panthor_perf_info *const perf_info = &ptdev->perf_info;
+
+	if (PERFCNT_FEATURES_MD_SIZE(glb_iface->control->perfcnt_features))
+		perf_info->flags |= DRM_PANTHOR_PERF_BLOCK_STATES_SUPPORT;
+
+	if (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) < 11)
+		perf_info->counters_per_block = PANTHOR_PERF_COUNTERS_PER_BLOCK;
+
+	perf_info->sample_header_size = sizeof(struct drm_panthor_perf_sample_header);
+	perf_info->block_header_size = sizeof(struct drm_panthor_perf_block_header);
+
+	if (GLB_PERFCNT_FW_SIZE(glb_iface->control->perfcnt_size)) {
+		perf_info->fw_blocks = 1;
+		perf_info->csg_blocks = glb_iface->control->group_num;
+	}
+
+	perf_info->cshw_blocks = 1;
+	perf_info->tiler_blocks = 1;
+	perf_info->memsys_blocks = hweight64(ptdev->gpu_info.l2_present);
+	perf_info->shader_blocks = hweight64(ptdev->gpu_info.shader_present);
+}
+
diff --git a/drivers/gpu/drm/panthor/panthor_perf.h b/drivers/gpu/drm/panthor/panthor_perf.h
new file mode 100644
index 000000000000..cff537a370c9
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_perf.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2024 Collabora Ltd */
+/* Copyright 2024 Arm ltd. */
+
+#ifndef __PANTHOR_PERF_H__
+#define __PANTHOR_PERF_H__
+
+struct panthor_device;
+
+void panthor_perf_info_init(struct panthor_device *ptdev);
+
+#endif /* __PANTHOR_PERF_H__ */
-- 
2.25.1


