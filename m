Return-Path: <linux-kernel+bounces-306652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031119641B6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A991C2494E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C5E1B3733;
	Thu, 29 Aug 2024 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rrZsoGPj";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rrZsoGPj"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38B6195B14
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926864; cv=fail; b=b4upGXpdw4dTWTE8qtqt17+EiyG5nxOYyNDJ6plqd4l3qUf6JUZA/Am3OdO+Eo07ThvY0p6xeMeiT616Y+ZLHzUME2UaIErspr+ZVkdFzhlVR8Opya1M5hlrI3GbWn8hP++bHqOXgbDneOwsIKn3IFcESOr9KIb5wkiKHc3TIbI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926864; c=relaxed/simple;
	bh=uur96DBlw2QpnK4vuYJtuO2suQnhAtqxHwcdgVus95c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NEoksqTMpH2guhafsB9XyeslMtnZoU6razx2Yt19rG4w4mXWTf6ebsxCchu1EF3T7NPUBizemJmtymZrz5XyE+5gTGYRnTyPSO3dq9a2lXl+LJGQgFWvTMrKtFlcnDHUBSkmtKS9KVk+0MZvyIu8MDX5z4HEZ7QSy8LnMOGKX3g=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rrZsoGPj; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rrZsoGPj; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Cp7vOPVeDHs9ZHDTGr8JR56GFJ+Tfm+aydsy7KW/sWYMUqUNsjs6wbi0F8NWjJMcpYiKRswmyAeeiT075grTrfk094dQCM6LdQZYNsJD2aYC9mjpXsaehVSScdGvrL7a5Z1Z7Vy5bBV44lF14vXMlENkr4ckuylP7aVMyjUeXd6WxPeDrnGXWrMPgdQvZva8CZXzOQs++2R2rQn0t4NuoDxTnNikt4Jl6QEvEL4k14+x2/QosZmXxhdxq/XxkK2woFCHm/bDVWQnWDJkRI9CHOrNb1LWujTmgnAP/A7ZezOUtZpl92LPe1zT9mPpIXwmaTaDB7/sLh00toFSUcP2bw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0k9NVxE5LX3jGRcLjg5D+saJC+P2D6zZKRNUnyZpuQ=;
 b=JqwQKIzcmymmzHubTqjvODjeskacOsjX1XWgBp4MSW2lGRFFfQz2kZpPnOXLEsbmRm1EkzHsFJwGsE1ig+jNBuPP5w25EL05Y3/BK0r1XBGT+08AemMpc60jJk2mYP9uIE+vOue6isYUrXIBXdhopie+yHLh7VCMOYrqivpLbvcSaE+3u9HmVoCnO9eDHqw2ur7Rk2CA92GQoTyqcro7rJwnHm01ZPxYxnhswOfPE5GCmjA9GYsZXZkYeB/ZhRmZQK/qCmfO8qQo9WhDRWtEOSQSN0J3zhLmNivsQ16zy9O3rzCkN/IXLzYmm5Sn2a00n2a70YPmcFUEyPrS015KQw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0k9NVxE5LX3jGRcLjg5D+saJC+P2D6zZKRNUnyZpuQ=;
 b=rrZsoGPjTeqgwazFoqsIn2tkOyDyAZqHwYQ5sACP6PIi2xMuEx8vyZ5Fbk96qpjzWD4jJSOwyFZ5rC8upMnOtIvO7Yth+PLjw9wcBR94Gya0hSx8AmcscXhUN3RDPBUUOrJ9/GrX6UNLyp3FBy4UiIvAd2eznPpdfgd1bKPAEoE=
Received: from AS9PR05CA0018.eurprd05.prod.outlook.com (2603:10a6:20b:488::22)
 by GV1PR08MB8498.eurprd08.prod.outlook.com (2603:10a6:150:82::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Thu, 29 Aug
 2024 10:20:52 +0000
Received: from AMS0EPF000001B1.eurprd05.prod.outlook.com
 (2603:10a6:20b:488:cafe::57) by AS9PR05CA0018.outlook.office365.com
 (2603:10a6:20b:488::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20 via Frontend
 Transport; Thu, 29 Aug 2024 10:20:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001B1.mail.protection.outlook.com (10.167.16.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Thu, 29 Aug 2024 10:20:51 +0000
Received: ("Tessian outbound bc251c670828:v403"); Thu, 29 Aug 2024 10:20:51 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: dace276c30686136
X-CR-MTA-TID: 64aa7808
Received: from La424c04fb085.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7375C9BD-4F74-4E14-8ED0-61E3CD6DEBE9.1;
	Thu, 29 Aug 2024 10:20:45 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id La424c04fb085.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 29 Aug 2024 10:20:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4o4ok83yE9K246Fhq2e51dOo9D2gMbDLeiYtpvUNPginrJ0XcmemOM5Dp+dKI/i2r8rd7KNBdAezRUvx1T6a+vF4dqxFNgnebPkF+ME14g5R6ZVxkuiFUVkGoHymzzJwkJE6RyjrmEp7Kg1ewy49A6zNqVlsG9wcTR/QWUoedO8SvqM2vGN+wHrq32b1x1YNqfFe/CB4YLJaS0LmNQZg+pPGnJxQRBvARMd63rL7+XpQIB1rdaJw6l72XEyOKgcmd6dG2Isqc1gl3/qS0abvFH/m32vpufCAn3J+q3DxhPMT7l9zP2ejQA8I3Lf8sj4E9HeoVLBk2YGP3s5cBOgqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0k9NVxE5LX3jGRcLjg5D+saJC+P2D6zZKRNUnyZpuQ=;
 b=xgJ9qnn0SFLBlWFzWRX8W0sJ+vcWWB8s4CRLAb/n/Qp1OHuiSqgLsDQlyQvHnVZ6TPwymMKzXe4Ei1lxONEg8oJ0lhcvz2J8JqCzENG+WlegYL4xQ1XLv0TpQUi5hnbMiozxRwYa4VzAA3O0gjuH6IXbvS10tm9lfYqwjFnmoh4+Pq+D9ZGZumX5G76xTomxE/pqPHxXjx7YC9xN+MSvppogMmiwFDQBUwyIhtC1ph4A7gQoS1F9XcIo3wANKdzvTfO0Fy4ZqSczeOmYrwmLsKTVczMh1TbDcC9h04qLQ6C9TzEr4Wm86522d7wPNRLvO2yPLDXy3aMUSiiIdISBqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0k9NVxE5LX3jGRcLjg5D+saJC+P2D6zZKRNUnyZpuQ=;
 b=rrZsoGPjTeqgwazFoqsIn2tkOyDyAZqHwYQ5sACP6PIi2xMuEx8vyZ5Fbk96qpjzWD4jJSOwyFZ5rC8upMnOtIvO7Yth+PLjw9wcBR94Gya0hSx8AmcscXhUN3RDPBUUOrJ9/GrX6UNLyp3FBy4UiIvAd2eznPpdfgd1bKPAEoE=
Received: from DUZP191CA0046.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::15)
 by AS8PR08MB8157.eurprd08.prod.outlook.com (2603:10a6:20b:54e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Thu, 29 Aug
 2024 10:20:42 +0000
Received: from DB5PEPF00014B8D.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::ac) by DUZP191CA0046.outlook.office365.com
 (2603:10a6:10:4f8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20 via Frontend
 Transport; Thu, 29 Aug 2024 10:20:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DB5PEPF00014B8D.mail.protection.outlook.com (10.167.8.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 10:20:42 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Aug
 2024 10:20:41 +0000
Received: from e122338.kfn.arm.com (10.50.2.57) by mail.arm.com (10.251.24.31)
 with Microsoft SMTP Server id 15.1.2507.39 via Frontend Transport; Thu, 29
 Aug 2024 10:20:40 +0000
From: Yulia Garbovich <yulia.garbovich@arm.com>
To: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<liviu.dudau@arm.com>, <rosen.zhelev@arm.com>, <nd@arm.com>, Yulia Garbovich
	<yulia.garbovich@arm.com>
Subject: [PATCH] drm: drm_fourcc: adding 10/12/14 bit formats
Date: Thu, 29 Aug 2024 13:20:38 +0300
Message-ID: <20240829102038.2274242-1-yulia.garbovich@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DB5PEPF00014B8D:EE_|AS8PR08MB8157:EE_|AMS0EPF000001B1:EE_|GV1PR08MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: df01afa2-1891-4fb5-3c80-08dcc8144279
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?cnSDlFhXzQwwBuND+N3sNqvmjPwHp7IQyn9HIhB4Czdd7XiBXb9AvQZeXER2?=
 =?us-ascii?Q?M35ZkQ+4IybZqN/VD+EIvNvsf2op5E7JugOgHNmhzaI0XYRq+1uA8XN+L8nt?=
 =?us-ascii?Q?kYGG5b8+ZWP8VyWMEBH4CwV5R7cpZTXZTTQNDywy+SdY1w1USb/EHM57EeOT?=
 =?us-ascii?Q?Or9hijDi4L1z1UeOv4vZz/yg3bR7dx2kgvcbwxgCKoMgNeMoTVdHIQn/gUIA?=
 =?us-ascii?Q?K34flwi2pTlp3FnE0VBQedp+TQOdC8hrGUnDvAFjjZdM2Jm1rXR040k1SFwC?=
 =?us-ascii?Q?GcchJmQD/HmLJdRVoH03b6j10/KsptAV5X1z59HbTxiceowfiQvu8iApnJhW?=
 =?us-ascii?Q?PggBjE4tjkQWPEMQWTqFtZl+pyFq+Q/YN5Fpbpf+LBvglwSrTo71YAzC1YKq?=
 =?us-ascii?Q?7T55y/G5kuzR8wkkKvoRMi3MJqQ6irrvRG3tO2NcfS11XgqZMiBzo+WqMT6o?=
 =?us-ascii?Q?Yuhc4yYcNYRzabX8jte1+hPTDWV4xzZbvxsgvQRZVUxJALlU9NQE99CKKSEI?=
 =?us-ascii?Q?xnIpdxhByYsIpC4SxvaSrOCQQgJTBK/HYEIdNEdldgWwUOu5J0qlOKUaP76J?=
 =?us-ascii?Q?77q5nKo/PmCZ3PBJ3EISu2fT2OF8O5RzC7oja68wZHedbiN6a20MrruHSLrD?=
 =?us-ascii?Q?AEd/zCUPLWBRqmG7PtFnv83yCHpCs1M8NGslgGHJSAnF2dbNPoXIedXVFTI5?=
 =?us-ascii?Q?XHxr843dmsLiFQCteI9yqeOtgKSWJkz8ObOjdfppwqTdXwTEHIZGxqkNaX6h?=
 =?us-ascii?Q?We5oHh9jRrZJjI1w7yyLkNRSlXkT8fnj1LNqdTNBzGU4qkuHrfngWCtHq4dq?=
 =?us-ascii?Q?Toy//ERFpiK6HkFuBtPyPWxp6M+9LWojCotbKXrMXaCEF+N85ik993Oz6bTI?=
 =?us-ascii?Q?HzgZenW+o0cRw4KRSBCwlci1TVLHwzZsuaxlAGGPbeUil8YypCOkE50EOJGV?=
 =?us-ascii?Q?hFYZu9jxYd6vz98O6IV2IelmIMVf+oHcTV2SHwOG3ovrUVp7RqsRZ8WK2dUQ?=
 =?us-ascii?Q?Nd/Kvl6gtyJB79j9FIVxA4LmuWsFuXviIEU4W77FqGMKowAWgNHYVr5QNt5l?=
 =?us-ascii?Q?nddeQ0LdJaXFwdhlx3hP8jvBhCR5lfR2CLGbTICoRzUdDxmDTLIL9rHRhyuk?=
 =?us-ascii?Q?p2xfi1aO/YbdPxZFfDZbfbCvu4Hv7VwLJVxaU9pV6IL+KQ1oItV0aU9rdvJm?=
 =?us-ascii?Q?8BklJpg2RbKJMw1qWHt2Itvl2+rKQNcoKS4emVoAaCJnxB7vrGK0PtFX9IHO?=
 =?us-ascii?Q?ej/4v0v19aNd57Ks1NMbou0b4W3EnTANirHQBiK8uLrrWn/m1RLpO5/2sPtz?=
 =?us-ascii?Q?tbf8nGkiQM5RJkFmr7CayRzATlRC42DXXOxEOWhEKDGOFrbEzfDeq0ufruwD?=
 =?us-ascii?Q?e0CtUd+miPC3vBHdWoZ6B3vEjts6EQNr1mw1cLRHsI6kAfMgJPM6+oY/JRwH?=
 =?us-ascii?Q?uc5Z4YYVlBPyszGULk6ufE0EEuDYEg3Y?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8157
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:4f8::15];domain=DUZP191CA0046.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	14ead515-6646-4aac-22d4-08dcc8143cf5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yL3SujrmtPPpDGWeVVzaJNkhE9Z88x32oPWvlaaSpiRAA4/PcKioB3n4r+uh?=
 =?us-ascii?Q?SxgTV3UAey9n9r6UETOH9Kv+KbFDKxuFaKOhc6JxRSkgNtP20hn9kApHxer6?=
 =?us-ascii?Q?S9Z6zLRxmQ7ziRJgSJzaM1AZMTpOYlPqTgdJzFk2R5L9nL/7kfyNdYsRiSin?=
 =?us-ascii?Q?/UU+Wu+jmF+C4YBnJJvZhjNrdXbPP36H78MIpsVnvPT1CT0XyhNcD/znCP5b?=
 =?us-ascii?Q?E/lmAbeb/hMQ04P9J2Vw6JR0ciCUgTsDXFcXMPqQnUnTRziRVNUhNSDOJnHY?=
 =?us-ascii?Q?TDojo8qYqDNC3VoAT3bRh6il4v1tinL7a7Ep6IYReu5LxhY5TdzLndMm60Qa?=
 =?us-ascii?Q?gyno5E7LjGrZLmR1TRo3aML2QqzXFk2DCs0jDQng3tUcLIjxk9eI0wy2a1i6?=
 =?us-ascii?Q?wITakopz/nOfmC0LLnlOJUSupfh9GGcKYvcX59sZAOHKOBUY1a/OYvDnqdjY?=
 =?us-ascii?Q?oiCfMFkEVWP1cEMrl/X5aBbowzed/LIyXBi+AT/5+E2gOQOGZSbhD7EKBTeL?=
 =?us-ascii?Q?wFZGneIdTKjYU1pBfr2YQ0avpZ480e7OJqWvHOTn8hmbAs4x+CYPkRr86QVK?=
 =?us-ascii?Q?bVE/iLmBIVCg+LRZJjFJA3bRAhXvqw0Td/Esi25Yxm7zysjuq2qSQU+asQ/E?=
 =?us-ascii?Q?tHpFHeTO7KxrWhYHu+sh62UXL5EiaTiucxfSjhShnzs2qJ/MWorX1KI5+/9M?=
 =?us-ascii?Q?Zl1++qCjk3mVAJkyu3Te3zU8jTBTOIgg+cZ1Z+0te7VvCwXAbagBjAzy3JGR?=
 =?us-ascii?Q?Gy8bzSV4sOVfRcW5hx/GofK9Sutw470GFtJ86OgyPvZ3wpq2E5TmVHd7IK1T?=
 =?us-ascii?Q?yS4BmeZFUCzJ+fQOKm/XwttvisTPSOATs0n5UiE+AIznc7xcP+i5LlA+A0sw?=
 =?us-ascii?Q?BhrARjbgG04l21/69oNF4ssZCujf5chHKCFHifrXeqzIhT+TWVQZMua9H+KI?=
 =?us-ascii?Q?nmRbU0d4Kow/GF+I7uraNIMSR2rZpOpwUx+LmYVDIU4D7wHCZihlKUJjEkgI?=
 =?us-ascii?Q?cW9MvtooxQHfskyA9y0S6CaSkR54nDEl4oC0TD6ND9RQzV9GczUjwYhud33F?=
 =?us-ascii?Q?DiP6Vyudxojt/skJ997QGH78EqZI+9ZLLUk4XoO566eztVUV9DhnE4oUSweu?=
 =?us-ascii?Q?jns8i641UQ+81e9V2epIHqbeb/PjZbY0XBCYjIRCr9UwI+YrNtVR0P+TuL/c?=
 =?us-ascii?Q?Xcyoeu7idEWu2Ol/bY4Fat9N0pKtoAxnkdR0JcHpo0GFFxJAwJh7OQEmVPPQ?=
 =?us-ascii?Q?/xaFy9ytHm9pJNVX1Dbvk3UIyhe54xytSxKKbM8YBH+4M5kji52B6MX5IQZd?=
 =?us-ascii?Q?Dx2oEvNMyX5Zq39CrSqRmwXjaN/UKs7NHxHhH2Axqjvk/Yn/ViS0+f+iPZxT?=
 =?us-ascii?Q?PYcbESvFATCT8wRMbnPSiojYusaS90/CTVDBcPe9qLbNiLwE0+sryPGAfSu1?=
 =?us-ascii?Q?8hin+H/hah/GcOSSUOaRPbpNJ7M6j7RD?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 10:20:51.9129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df01afa2-1891-4fb5-3c80-08dcc8144279
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8498

Adding the following formats
     - DRM_FORMAT_RX106
     - DRM_FORMAT_GXRX106106
     - DRM_FORMAT_RX124
     - DRM_FORMAT_GXRX124124
     - DRM_FORMAT_AXBXGXRX124124124124
     - DRM_FORMAT_RX142
     - DRM_FORMAT_GXRX142142
     - DRM_FORMAT_AXBXGXRX142142142142

They are useful for communicating Bayer data between ISPs and GPU by emulating GL_R16UI and GL_RG16UI formats
Signed-off-by: Yulia Garbovich <yulia.garbovich@arm.com>
---
 drivers/gpu/drm/drm_fourcc.c  |  8 +++++
 include/uapi/drm/drm_fourcc.h | 61 +++++++++++++++++++++++++++++++++--
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 193cf8ed7912..cd5f467edfeb 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -170,6 +170,9 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_R8,		.depth = 8,  .num_planes = 1, .cpp = { 1, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_R10,		.depth = 10, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_R12,		.depth = 12, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
+		{ .format = DRM_FORMAT_RX106,	.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
+		{ .format = DRM_FORMAT_RX124,	.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
+		{ .format = DRM_FORMAT_RX142,	.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_RGB332,		.depth = 8,  .num_planes = 1, .cpp = { 1, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_BGR233,		.depth = 8,  .num_planes = 1, .cpp = { 1, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_XRGB4444,	.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
@@ -200,6 +203,9 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_XBGR8888,	.depth = 24, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_RGBX8888,	.depth = 24, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_BGRX8888,	.depth = 24, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
+		{ .format = DRM_FORMAT_GXRX106106,	.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
+		{ .format = DRM_FORMAT_GXRX124124,	.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
+		{ .format = DRM_FORMAT_GXRX142142,	.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_RGB565_A8,	.depth = 24, .num_planes = 2, .cpp = { 2, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_BGR565_A8,	.depth = 24, .num_planes = 2, .cpp = { 2, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_XRGB2101010,	.depth = 30, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
@@ -219,6 +225,8 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_ARGB16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_ABGR16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_AXBXGXRX106106106106, .depth = 0, .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
+		{ .format = DRM_FORMAT_AXBXGXRX124124124124, .depth = 0, .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
+		{ .format = DRM_FORMAT_AXBXGXRX142142142142, .depth = 0, .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_XRGB16161616,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_XBGR16161616,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_ARGB16161616,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 84d502e42961..30d0f4b6247a 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -146,6 +146,24 @@ extern "C" {
 /* 12 bpp Red (direct relationship between channel value and brightness) */
 #define DRM_FORMAT_R12		fourcc_code('R', '1', '2', ' ') /* [15:0] x:R 4:12 little endian */
 
+/*
+ * 1-component 16 bpp format that has a 10-bit R component in the top 10 bits of the word
+ * in bytes 0..1 with the bottom 6 bits of the word unused
+ */
+#define DRM_FORMAT_RX106	fourcc_code('R', '0', '1', '0') /* [15:0] R:x 10:6 */
+
+/*
+ * 1-component 16 bpp format that has a 12-bit R component in the top 12 bits of the word
+ * in bytes 0..1 with the bottom 4 bits of the word unused
+ */
+#define DRM_FORMAT_RX124	fourcc_code('R', '0', '1', '2') /* [15:0] R:x 12:4 */
+
+/*
+ * 1-component 16 bpp format that has a 14-bit R component in the top 14 bits of the word
+ * in bytes 0..1 with the bottom 2 bits of the word unused
+ */
+#define DRM_FORMAT_RX142	fourcc_code('R', '0', '1', '4') /* [15:0] R:x 14:2 */
+
 /* 16 bpp Red (direct relationship between channel value and brightness) */
 #define DRM_FORMAT_R16		fourcc_code('R', '1', '6', ' ') /* [15:0] R little endian */
 
@@ -157,6 +175,27 @@ extern "C" {
 #define DRM_FORMAT_RG1616	fourcc_code('R', 'G', '3', '2') /* [31:0] R:G 16:16 little endian */
 #define DRM_FORMAT_GR1616	fourcc_code('G', 'R', '3', '2') /* [31:0] G:R 16:16 little endian */
 
+ /*
+ * 2-component  32bpp  format that has a 10-bit R component in the top 10 bits of the word
+ * in bytes 0..1, and a 10-bit G component in the top 10 bits of the word in bytes 2..3,
+ * with the bottom 6 bits of each word unused.
+ */
+#define DRM_FORMAT_GXRX106106	fourcc_code('G', 'R', '1', '0') /* [31:0] G:x:R:x 10:6:10:6 */
+
+/*
+ * 2-component  32bpp  format that has a 12-bit R component in the top 12 bits of the word
+ * in bytes 0..1, and a 12-bit G component in the top 12 bits of the word in bytes 2..3,
+ * with the bottom 4 bits of each word unused.
+ */
+#define DRM_FORMAT_GXRX124124	fourcc_code('G', 'R', '1', '2') /* [31:0] G:x:R:x 12:4:12:4 */
+
+/*
+ * 2-component  32bpp  format that has a 14-bit R component in the top 14 bits of the word
+ * in bytes 0..1, and a 14-bit G component in the top 14 bits of the word in bytes 2..3,
+ * with the bottom 2 bits of each word unused.
+ */
+#define DRM_FORMAT_GXRX142142	fourcc_code('G', 'R', '1', '4') /* [31:0] G:x:R:x 14:2:14:2 */
+
 /* 8 bpp RGB */
 #define DRM_FORMAT_RGB332	fourcc_code('R', 'G', 'B', '8') /* [7:0] R:G:B 3:3:2 */
 #define DRM_FORMAT_BGR233	fourcc_code('B', 'G', 'R', '8') /* [7:0] B:G:R 2:3:3 */
@@ -229,11 +268,29 @@ extern "C" {
 #define DRM_FORMAT_ABGR16161616F fourcc_code('A', 'B', '4', 'H') /* [63:0] A:B:G:R 16:16:16:16 little endian */
 
 /*
- * RGBA format with 10-bit components packed in 64-bit per pixel, with 6 bits
- * of unused padding per component:
+ * 4-component, 64bpp format that has a 10-bit R component in the top 10 bits of the word in bytes 0..1,
+ * a 10-bit G component in the top 10 bits of the word in bytes 2..3, a 10-bit B component in the top 10 bits of the word
+ * in bytes 4..5, and a 10-bit A component in the top 10 bits of the word in bytes 6..7,
+ * with the bottom 6 bits of each word unused.
  */
 #define DRM_FORMAT_AXBXGXRX106106106106 fourcc_code('A', 'B', '1', '0') /* [63:0] A:x:B:x:G:x:R:x 10:6:10:6:10:6:10:6 little endian */
 
+/*
+ * 4-component, 64bpp format that has a 12-bit R component in the top 12bits of the word in bytes 0..1,
+ * a 12-bit G component in the top 12 bits of the word in bytes 2..3, a 12-bit B component in the top 12 bits of the word
+ * in bytes 4..5, and a 12-bit A component in the top 12 bits of the word in bytes 6..7,
+ * with the bottom 4 bits of each word unused.
+ */
+#define DRM_FORMAT_AXBXGXRX124124124124	fourcc_code('A', 'B', '1', '2') /* [63:0] A:x:B:x:G:x:R:x 12:4:12:4:12:4:12:4 */
+
+/*
+ * 4-component, 64bpp format that has a 14-bit R component in the top 14 bits of the word in bytes 0..1,
+ * a 14-bit G component in the top 14 bits of the word in bytes 2..3, a 14-bit B component in the top 14 bits of the word
+ * in bytes 4..5, and a 14-bit A component in the top 14 bits of the word in bytes 6..7,
+ * with the bottom 2 bits of each word unused.
+ */
+#define DRM_FORMAT_AXBXGXRX142142142142	fourcc_code('A', 'B', '1', '4') /* [63:0] A:x:B:x:G:x:R:x 14:2:14:2:14:2:14:2 */
+
 /* packed YCbCr */
 #define DRM_FORMAT_YUYV		fourcc_code('Y', 'U', 'Y', 'V') /* [31:0] Cr0:Y1:Cb0:Y0 8:8:8:8 little endian */
 #define DRM_FORMAT_YVYU		fourcc_code('Y', 'V', 'Y', 'U') /* [31:0] Cb0:Y1:Cr0:Y0 8:8:8:8 little endian */
-- 
2.34.1


