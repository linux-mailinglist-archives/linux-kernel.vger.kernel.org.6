Return-Path: <linux-kernel+bounces-403788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5299C3AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31AF1C218AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAB7170A1A;
	Mon, 11 Nov 2024 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UGLPMTDx";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UGLPMTDx"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B27146A6B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.42
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731317210; cv=fail; b=AEWQhljHA/MaYSvc3m5u/InyQsuZylAlReTrBmfzj9PuyWZYiPVpSFLjBB1smtV0UJDiNmgY3sJgp3MuZcyLUiEGY3QXJWzy9V+Wyxqmcg5DJ2R267XrNEz/1quwNL84RiDTEDkoA6Q/n1S3OIKexxU2BlIHZSzwYx0uKKoKs68=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731317210; c=relaxed/simple;
	bh=ebnA5DyNZEPixnze2+AsPmiJmkWPVAwkU/5YXbevu+8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BVMJB8oTdQWFKdIMnX0NrE36JhMsySn23XARywzgPbx1yaj6sUvpSg8pdQ5dgylnHuNJdo3BKYjLCTO7DLLEoY9NdAPcc7sRogjtXQOvaHoV8rMTBsgw0PTTAcqhtYgvKtYbUaiJQVGWH8S8gqgbwBVa3iXN+WdJ393ug5k7rr4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UGLPMTDx; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UGLPMTDx; arc=fail smtp.client-ip=40.107.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UtlZ4jK4Q5CtuZVCjYKHqfw3utyiOSXluNMX7rIHje2Xa8fjkElimzGlEDea9Kt64TnJuoQEN2XzIEKptgBt3b2hKcwM9LgSbJlsfbDjyIgKvZalSl9fFJ42khsHyOFc/kR79WxD4EY1s21PqOSCf658cSoOl9EyCRYp2kE0uaJZeQRrXuFIaSnSdDdbdUlEHSRYWp3Bv32CCrktOcQsdC1zYped7M9wLRjAnKh9SfsFeQ8RS7Q9WKz2KIhxB3WVay0b62GwxgJax50MLddIvbycEoy0y9/uBPsy0S6AG7OYdQ3+490MXE8fAbEkxHf2FYSjS3mUaQlU6TaRwv/RiA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HC7JwEPuOWZ+5EThts81jzoz8W+Pe7bbBDAfdENg1ZI=;
 b=sXb1v/hC9F+w1buO0kUCGUOsJP12xxxYdeIphBIavRjwdUXmOtBSsUPIBSUJXIebaVtOm6B4zjEeoWk7BP3ifug92G0Bsp9vDA8Dhjd0FoE7V1BC4j/Vzjf8QpkMRd91wnp3MZISpicW3KRTITZa7RBkMwr9iUagy8qssZs5+F16DzQrPDEgXXBXRZ/3ped3jXURVN9vUSOhjOSLGMdLIIB1kIcIpuUqk1KMBP4fi1kSC33sNAqTkYX3flB35vXoc5Bu+CKPBWyYTsaizrwptUd4pIJuuvTFUg6JEusIYrUQr5u8HT779o+oifgbkByoa7hWPlTyBfewLgTNZAfrkw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=bestguesspass action=none header.from=arm.com; dkim=pass (signature was
 verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HC7JwEPuOWZ+5EThts81jzoz8W+Pe7bbBDAfdENg1ZI=;
 b=UGLPMTDxevS3VuoIYI+FfrjVH5u4zTUGHIa78AD8Mmid2lh4T1XZYloEyaxrbiN9z9q5gB/eZCWZy5E04AO8G/+mqs8uqVv/oDmxhNwJ6+dvPE0vuMeJUqZb0PnOiOXp5h+CqMeaPIqN8RApnwl5gDFDDsiRescR0sWWQ9vB2j4=
Received: from DU7P250CA0019.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::12)
 by AS8PR08MB9621.eurprd08.prod.outlook.com (2603:10a6:20b:61a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 09:26:41 +0000
Received: from DU6PEPF0000B61E.eurprd02.prod.outlook.com
 (2603:10a6:10:54f:cafe::ef) by DU7P250CA0019.outlook.office365.com
 (2603:10a6:10:54f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend
 Transport; Mon, 11 Nov 2024 09:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=bestguesspass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF0000B61E.mail.protection.outlook.com (10.167.8.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.14
 via Frontend Transport; Mon, 11 Nov 2024 09:26:39 +0000
Received: ("Tessian outbound c4cd8408e1a6:v490"); Mon, 11 Nov 2024 09:26:39 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9bd48ae7aad30752
X-TessianGatewayMetadata: 2yKQP+zeo09Mb2GcXR20IfCyAnddQyS8L96EtdrhUwM7fU9a0EOh0sqX9I5oq2f90GQ9xGUvyY1YjQKRQfjlafr/QrrC4RWWsRPVO8vsPy4xBp/YxDuOa2WMMXhWDwm5RB15gSOGtFaH+gcRAepT5wiqurs+20k5jokYeyTC1ZA=
X-CR-MTA-TID: 64aa7808
Received: from L58d0780e3519.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7737FE14-5FDA-4F34-A08E-AFB04AEA32FD.1;
	Mon, 11 Nov 2024 09:26:28 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L58d0780e3519.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Mon, 11 Nov 2024 09:26:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rL1dpjB9UkgTMAUeoHqiRbaax0RwJpmE4GSnHp37yci88emWWQJAqqsYDIm8/CQTEN0R2at6FckFwxUVRONc5ekvHR2OnaCqC+EF/2mn+5rZ8JctXPrmP7bOQkkJ0WsLSii5gf/qzD624jNDNKQA9VRsDDFXZH5z4T/LROhxcP6Dx0/nqo3VM46SPjN5b6qBLldAQSgesDlXcWN29/Hsy7adyzGrRpZxKm3Y+hOzMboMLYXdqipaxr4lqm5BwGbVExYKZiPNAFPYn4TNd5yCYCvcteANzYUPr5Rub3t2DrP7mGHZZtMu9W4/q3Pp2ouNYOz1HD20OMcVa9zKdUcPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HC7JwEPuOWZ+5EThts81jzoz8W+Pe7bbBDAfdENg1ZI=;
 b=e/uDmgdhkM3ZAbvR9rtcWQ0oaIjWl48CIKIlGQUuRmNMphuucNH9BNuWo8qC6SZynmBFJGMkNtod3O1gVkDjItYsEYnr8NtfFngmmn/p8Z4JFvRvmm4UJKQ7bEOmVQe5c9+VMEOH8epO1bZK9rFMWOXXi+vQPDcTw5RNx0Jj3G7+zEoQTZTgfW0es5LzO2pWv6uSU3gv0gm7Zn2Yf/iIq0RclsMGqLFNLRytzqrpFFZDjeSxgDCpzhKufrcgrOtM5oiMQIW4xVbNN6FbZomuXTdQTUP6npBpJk5BBkem27jgC3yZB/ouCL1f9aPkyfmwg5ET8fEwmytPTpXmZGu35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HC7JwEPuOWZ+5EThts81jzoz8W+Pe7bbBDAfdENg1ZI=;
 b=UGLPMTDxevS3VuoIYI+FfrjVH5u4zTUGHIa78AD8Mmid2lh4T1XZYloEyaxrbiN9z9q5gB/eZCWZy5E04AO8G/+mqs8uqVv/oDmxhNwJ6+dvPE0vuMeJUqZb0PnOiOXp5h+CqMeaPIqN8RApnwl5gDFDDsiRescR0sWWQ9vB2j4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com (2603:10a6:20b:415::16)
 by PAVPR08MB9281.eurprd08.prod.outlook.com (2603:10a6:102:306::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Mon, 11 Nov
 2024 09:26:22 +0000
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd]) by AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 09:26:22 +0000
From: Akash Goel <akash.goel@arm.com>
To: boris.brezillon@collabora.com,
	liviu.dudau@arm.com,
	steven.price@arm.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	mihail.atanassov@arm.com,
	ketil.johnsen@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	nd@arm.com,
	Akash Goel <akash.goel@arm.com>
Subject: [PATCH] drm/panthor: Fix handling of partial GPU mapping of BOs
Date: Mon, 11 Nov 2024 09:26:21 +0000
Message-Id: <20241111092621.763285-1-akash.goel@arm.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0114.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::18) To AM9PR08MB6982.eurprd08.prod.outlook.com
 (2603:10a6:20b:415::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB6982:EE_|PAVPR08MB9281:EE_|DU6PEPF0000B61E:EE_|AS8PR08MB9621:EE_
X-MS-Office365-Filtering-Correlation-Id: eea3ab2d-f94c-4dc5-3498-08dd0232f2b5
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?5Jk04+MSpVT8cxXiVtkiWzohSqvJPi4AEZpyWrbkE8g5e6JHa7va9YhSDZ7i?=
 =?us-ascii?Q?MyRvzeXSDuURZ8mt6oXwbef1OfDMgtkHmDbHrQOL5eW7leI7/Y+97cl0D9P7?=
 =?us-ascii?Q?OxRWTKx21g6PsuPgl928z30DGDowz6BUfJAcE/kpknI0s8+lUSka/aY27qSP?=
 =?us-ascii?Q?4G3blVbLTIJ+McD5O4WQyFuN1sztpsEQkiC00JDU0dHXoweUQ570fYovsHQR?=
 =?us-ascii?Q?nx0yBVHKlhiCvOJ22TmNXrAoDU+f3omEPZUVF8jwh5mR/LB/5x4MekpOKcvN?=
 =?us-ascii?Q?nHsOMbbnffyqHQAXyv+WfnacIJurLFCDx+rI632n0tprX1nqYCPFw6xfbgoL?=
 =?us-ascii?Q?s/AhE4oVQavOfZmwIYCUYGEe2poKeNd6FMcJy6MmFzsxZNhnGXYFicxh3J1A?=
 =?us-ascii?Q?H7mYlhLPyLHUYyKjVt34zKrjxPQt9i/is1IsZPNv05LlIndzkUNhVxNmYKqV?=
 =?us-ascii?Q?0E204cqF9tld09zmfc6PHLxXAu9MElwaqTaUNxIp3Boxd/aAi37r8XPSnsxA?=
 =?us-ascii?Q?Uu+iMGGE7Lj249Um4CWnDtzmkmKPcCj7X/VEmm1AF8LpB2Z5DGWJwxuFMoAa?=
 =?us-ascii?Q?vitUgJpwrD37rJFW3vTEuWJyp42DK26ENEvaACxlzaau99kr2/JIqonANgQZ?=
 =?us-ascii?Q?APOacpkABhLvp1TRVDBtGKHKuSsLr8KReer17tL37e9BLnrE3bmWia1tnvQV?=
 =?us-ascii?Q?JCGpuUeaRkFo4uWPNQzfoc6WflV1SLGVzpIMmzEWM6pXVVfC3QhEIVCtzgOy?=
 =?us-ascii?Q?c4Fx73eTdW5uVGw5KWJu4DQ8+8dr83UjuD9VFvpHUtzIRoEYvjVkFliVFHAU?=
 =?us-ascii?Q?ugZ/TKMyzsmljbcX2k/PTQ+D793vRcnjLn18m8BML32Ud2Sc7miEJKp4DvY1?=
 =?us-ascii?Q?ZhXCTsXBMm2h1HioC3OA28jB9MsOyE0ysYXzbdBXX+vc8QozQ4ZqDasivxCJ?=
 =?us-ascii?Q?cybSRL1t4w8/5iwNGw+f0mb1y8d23dWsipgGVCBWI9aQEh1dCurBduVymW17?=
 =?us-ascii?Q?JlXPey0iYGeePxZYifNoCAmyNHJ3YXfAoXwtg5nvduPV7sbDD3CZwJV6H6sV?=
 =?us-ascii?Q?wYlMkCoAyh6XJz2w4kpKV37SAShgJ+3BXH7DgMP+qx4RHT2HTbKMJtgGVt1d?=
 =?us-ascii?Q?f4+4a5Qa9piyJVUo0HFzBpL3k4sCMw0jAP56UP7pRTy1A85dkM8VjP11JScE?=
 =?us-ascii?Q?+g0nmus75UY8zBa+k+eXKu+W11GRxmydozLX0LPP/592+zx072D0Q/TbnX9W?=
 =?us-ascii?Q?iQJ+EAYqL7sgsgLy2Oj6XdOK37Imz6/NAIAJu8dRiUGAQ/bBrTLexqhlgvqS?=
 =?us-ascii?Q?IbQAdis3YPJZb6xNqEdQtAHM?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6982.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9281
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:415::16];domain=AM9PR08MB6982.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	47894c3a-e272-49f4-15ab-08dd0232e83c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|82310400026|35042699022|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r85CN6oRqGRQ/M3uR6fzYNJTSqD55fOup547wj3zwI7QPDqZ6Kwdcj3ynwYd?=
 =?us-ascii?Q?EdDBmMo+FJvncZFgkLa/u45n0gIyLEPNKvM2q72rqIrjtsP7fDkzmQRO4u+A?=
 =?us-ascii?Q?UXada7/QzpLDfBkMBNva81nsB208sCgjQPacN6WyIJycbqCEYCTuI/l0LNzJ?=
 =?us-ascii?Q?cfxhcsbJyE2mNaVjouZHTCZ8zs3omevWXgURyBIZWyP2Y5ToMRZetVCOiTyH?=
 =?us-ascii?Q?ICe2pZ3h7AyByvsiest+6kXe69/KdDI3QY1aFHi04qm4JH6mkZf0oY5DjSre?=
 =?us-ascii?Q?cDQYqolK6PFREJbXFiNpB2CgPcxsXbxb6ppZrAkq631VUV3GX3ZcjdxWWLkq?=
 =?us-ascii?Q?8zdSTft9+vBbg34krgk4aZGl1j/VGp26IGfb6oiWw5OzCOMvSkKTVB2D7x1P?=
 =?us-ascii?Q?gP+6argat78gKg8kGIMgJLbbCmpwAfa99qAea5xrg+5l7Wfh4Y99BQx4WXjI?=
 =?us-ascii?Q?rwqTlBfn3o/r8e9SGvqrrR5aFgExP7z2HkRdB419lZD89v9Rt+wVVEXgtAsd?=
 =?us-ascii?Q?AK4f4fvjgpTYdxG+6ZlOhISoLmEZRQQHebmgZsIqxyoxM/69oOEJcuoJ96sC?=
 =?us-ascii?Q?N+xifFlgQL9PEn9MnmbIDkMkfi+zVDIv6lZ0Vvk7hWbV9H5F+KdmIDGQFGDR?=
 =?us-ascii?Q?R/Zq0/i05ZnQH+idcjclc7DB8U4XE6xaBpxlajWN0E6odC7wro/y2wXO+sQq?=
 =?us-ascii?Q?TtivajwGZGPog1WQM6LmE0q4DFJEPiSwBd25OiDEZmoMGuNG+JRqL9urxCPT?=
 =?us-ascii?Q?jBQ5Uq/kvzqDPl4438+0F8OJK8UxdCajZL6MR0YP6yCIY3Vmog3tx00UBivc?=
 =?us-ascii?Q?idUhIbOraNP3yig/CJsmJbjpcwOxauavInKYTPSbqV8EGkXmv95r9Q3TrHiB?=
 =?us-ascii?Q?Dw23marRrFz3VYuRCV2sU8VdqdGfbvb4tcuE00/AwHlZDV6S+Nb2vuN+JL52?=
 =?us-ascii?Q?e7FdW1kfPLMECGth8afGSxHBHmmPJrAuoLkATyO9FkL9Z9QF6hXhzrb6yvWX?=
 =?us-ascii?Q?aFwmYNckmXHIm3M6TnEkLTJDztWsw0QzWxs5dITND56SoFNSE3MvNXoEahze?=
 =?us-ascii?Q?wifJn+vq/JF+7oCSQTb0ZbdzUf+Oh8fzTb2HEfx+M/Tm7V4M/QCt/X5CwDP+?=
 =?us-ascii?Q?PhbepFtRuew3443dFW2UmQkUzI5gD3sWNBAzlRDawKfDuDerp4xGONjEA2tW?=
 =?us-ascii?Q?8b21MMGEzpbcLlm9QZdyCMpZ9v08f2CTUr+1xVvxCo9KYfu6Tj+AZEhpXs+x?=
 =?us-ascii?Q?BFbtVyG3P670eCjdWHLBwrfamgY30UNt7PIXnoWdxIGeGvuLjdIt+LH/qqpW?=
 =?us-ascii?Q?x/3JaoM+HlOIGFAcXhFAqoHP7sUOmprw8S/S1adz+rIpIz+2Pu5QTI1nNiHV?=
 =?us-ascii?Q?GXWZLrSfS/PrdTGiBAqPrRpIJcq0N5OQHQ7FiGJ45sgd63W7eQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(82310400026)(35042699022)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 09:26:39.9435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eea3ab2d-f94c-4dc5-3498-08dd0232f2b5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9621

This commit fixes the handling of partial GPU mapping of buffer objects
in Panthor.
VM_BIND ioctl allows Userspace to partially map the BOs to GPU.
To map a BO, Panthor walks through the sg_table to retrieve the physical
address of pages. If the mapping is created at an offset into the BO,
then the scatterlist(s) at the beginning have to be skipped to reach the
one corresponding to the offset. But the case where the offset didn't
point to the first page of desired scatterlist wasn't handled correctly.
The bug caused the partial GPU mapping of BO to go wrong for the said
case, as the pages didn't get map at the expected virtual address and
consequently there were kernel warnings on unmap.

Signed-off-by: Akash Goel <akash.goel@arm.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index d8cc9e7d064e..6bc188d9a9ad 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -957,6 +957,7 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 iova, int prot,
 
 		paddr += offset;
 		len -= offset;
+		offset = 0;
 		len = min_t(size_t, len, size);
 		size -= len;
 
-- 
2.25.1


