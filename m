Return-Path: <linux-kernel+bounces-317205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4552896DAE3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577F31C24693
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADC219D8A3;
	Thu,  5 Sep 2024 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OAf90zbt";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OAf90zbt"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3DD198A30
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544512; cv=fail; b=jS8uV6AlSIFJZTDM1AlB++szWV9LmkArp+Xwd6zxTHh7vEBQw6jun6pYtHWI+eo+oOLFgLudVsYuqpm8EblPHEi8sMF04hyj0MzdgQ1jljGOfsHpAAh/EXkEvecUmqGy+lyVcJlULiavMWdmi0wx5juxKF8m2XqMIbomofedqhw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544512; c=relaxed/simple;
	bh=X0mM8ehP7mrPMChIYfKonZ4g4SbYeac6CR7eq08qpjg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gQiqQDLQ6SYnwDKftKYbj25BCvpweVfB4Id0RzezgEUG1BJhnfhSRTmyopMZZWQu8KCZUq3tKCz98HPR3PtIz0duuFdrgg3R5pEttGHGkqVGoveSPb1h2l1i85R2oDynatiPM2zMgCdFQSJwENH9px25lhWeQnBBzb8o2ChBYkY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OAf90zbt; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OAf90zbt; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=H4Z09FoJYCYk1s1ML58hnSNp3+wnMfz4kysY7OzmBfIFnBxqoeJoQUfpt2ADNvyq3LWA+Ggq3wL5qUW9ODSGeMKxFiT6UlTwX5s0G/w/knG4KGQ9T7uXyf0+LtBRkmG1lsdSgda4Y3RdfVPS+pMUbfjzboUYcUAyoK3lRIzJ+Ju0tIwMZ7gm5BiWTScrfyT9/WI3rw4WrK+5I8T5AcM+PvXA7mNn5zPHgkTdSilyqWFUKAf2g4Vs8J2PD0cq2o+VnFNeZEu+APvs9eeK4Q/kTyxeyUr9MGfHlcn3IODbwPGKXYRPX2aMcMaGCNU3At/IIgASxlg61ja7Sb+OuUMsqA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5tXSl03cVYbA16bXo4SPakbucHqVjx3Ae/3xNBfTcI=;
 b=U7I+ztK47zDeswBzx583o7YjYqNPL8WVY7dDtGDcEY+R3lloXvPojwpa3JdsxGUHEBuwhteVPiXOVUHoI3PeKs6om/gQqiV51rEDOtDpN1Gbf5kyopECX5LBenT7lmD4xGgfYlMFCmvAczrsNK/efLK4uxbvLQrtEp8FO/u9Xbl1Ugb8jDJNxz/+hEeiLz7t4VcpzWrt+5ctDR+OQHOi7ueJpsaOhW4W+8ZG/u+eX8+lnFkg06MfUNojAB0BIgmJ2VY9xcgX0XmXqEo1mttNFjc9FKZOksM0ManP8lJnaOr5pf1hHhHKxQ73260chDnvow0T8LE0/e+J5Xf37yNSgw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5tXSl03cVYbA16bXo4SPakbucHqVjx3Ae/3xNBfTcI=;
 b=OAf90zbtH50JvZgzKwRYB5HRbO1UgnXHBrTI/phCUVgR+gafhCrUpZxhHQwfbc3yoG60fGBmsrD/601G3Z3eSq87UfPo+GpEc/8+zh6tsV1n+ZOWamC7grI7hYwIn6YGf0ImgVmfsyMJPmGKxKUqmP3VRAQNImRe9jj+Sz5n92o=
Received: from DUZPR01CA0073.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::11) by GVXPR08MB7869.eurprd08.prod.outlook.com
 (2603:10a6:150:1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12; Thu, 5 Sep
 2024 13:55:01 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:3c2:cafe::f3) by DUZPR01CA0073.outlook.office365.com
 (2603:10a6:10:3c2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16 via Frontend
 Transport; Thu, 5 Sep 2024 13:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Thu, 5 Sep 2024 13:54:59 +0000
Received: ("Tessian outbound 7b70c86ee9c2:v437"); Thu, 05 Sep 2024 13:54:58 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: afafd9ca9183f82f
X-CR-MTA-TID: 64aa7808
Received: from Lcfe4f45619f9.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 38D81C33-58C7-4105-A070-AA3D7ABD496C.1;
	Thu, 05 Sep 2024 13:54:48 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lcfe4f45619f9.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 05 Sep 2024 13:54:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trC/C76n8mZdSu2/vjLEM43jOrptMYcNZ7PyKc+5q9l7s0+kRIw9mUc3qY6hasQunnPck0B7IrQwQA6J16uvp8powkJAsr5GjRgsusAK+lz6jCKVFnDEKxncDLTvyqid2AS7xEUftznWvVoOEuBtu4q9OCHDydUwxT3DjHPuyp1yOqG4GkAeUd8fILcmSDZm5alwC/ZVapvNXm3NG39PAweTFHNWFNrFBTLWJgdZO9MAKycGUKtXSQFMzznr78i7t4dt3ZlQe+/c6NyYchXwqiEyDllRk2r86K5cHLb5WkVvyZ+9+KjAsW0mwfN8lhat9jYaKLTmTtXi9ooqcR+5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5tXSl03cVYbA16bXo4SPakbucHqVjx3Ae/3xNBfTcI=;
 b=RFLA1+YThC+UHuskj3aTB4TKd5LX9YJKOnbP0fI8/hj/jXQQSwzk8yS2yKskx7tqdtVPN5K7R1clXCZeGS4zcDYa8zkTbkLO4okxmdYQmKcR7Pw7/yAhYp3dL0mD85f4kcvX/YnCannK+4itikdloOml3cLvSkGMMClvn6tjW4XGdnif/BgegSLLwMRvX3s8fX5uGRkhEXR6SRq/HNokRUoLqUb2xr6oX2ycYE2dSb1ZA8MR3oNjvPFdI7CWBmZE9nwNxJeQgSFjf2ifc+VT0EdXiBDrbqeJlCtqDyzAPhAf/ACCKZMCfrJ/wWU5b+0HtMBA+40ycEZV8x1i/GO+ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5tXSl03cVYbA16bXo4SPakbucHqVjx3Ae/3xNBfTcI=;
 b=OAf90zbtH50JvZgzKwRYB5HRbO1UgnXHBrTI/phCUVgR+gafhCrUpZxhHQwfbc3yoG60fGBmsrD/601G3Z3eSq87UfPo+GpEc/8+zh6tsV1n+ZOWamC7grI7hYwIn6YGf0ImgVmfsyMJPmGKxKUqmP3VRAQNImRe9jj+Sz5n92o=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com (2603:10a6:20b:290::9)
 by AS8PR08MB8184.eurprd08.prod.outlook.com (2603:10a6:20b:561::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Thu, 5 Sep
 2024 13:54:43 +0000
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c]) by AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c%4]) with mapi id 15.20.7939.010; Thu, 5 Sep 2024
 13:54:43 +0000
Message-ID: <2b2d13a9-9e84-406a-a803-5366036fa761@arm.com>
Date: Thu, 5 Sep 2024 14:54:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/panthor: Add PANTHOR_GROUP_PRIORITY_REALTIME
 group priority
To: Mary Guillemard <mary.guillemard@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Christopher Healy <healych@amazon.com>, kernel@collabora.com,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 nd <nd@arm.com>
References: <20240905111338.95714-1-mary.guillemard@collabora.com>
 <20240905111338.95714-2-mary.guillemard@collabora.com>
Content-Language: en-US
From: Mihail Atanassov <mihail.atanassov@arm.com>
In-Reply-To: <20240905111338.95714-2-mary.guillemard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0314.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::6) To AS8PR08MB6263.eurprd08.prod.outlook.com
 (2603:10a6:20b:290::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB6263:EE_|AS8PR08MB8184:EE_|DB1PEPF000509E7:EE_|GVXPR08MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 27205bff-ada6-4503-237d-08dccdb25503
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?M25vemNxdVRQRXUxd1d0cTl6ZTl0dlU4dFY2b1NZVDFLWFFSK2t2Z3oxRThq?=
 =?utf-8?B?bzVYVUlUMjNnUVJZSCtuczRwQys0T0s3TW5kRTFMVU5qL25tTEpQS1JSME5R?=
 =?utf-8?B?cjBSdUVLbnFjZFE5bDRsdXJ4SE9pZE9zcE1abjVzL1B6OGM3Zk9mRWVLcVAz?=
 =?utf-8?B?VVN2Z0pCbk5zZmQ2eFJHOUFkUExSeEpFNkFtZDIwQWd5bFY3Tm1lZTIwWTNo?=
 =?utf-8?B?eER5ZE9pUnMvMTI3bmxVTlk2VlV6akxvaXJCUHpMMm1xa2ZVRFN4UUhvbCtl?=
 =?utf-8?B?eEVGc0hsOEhuL0ZNTlY1c0RPVG5ZbHlSYVRLWnViZ2xzRHVObk5QWC9DZGN6?=
 =?utf-8?B?Y2FSNVQ3d1JvVkhtbFZ3WVIzLzE1b0kwVGd2cGVQWW13MWFhUXE4aHNKUTdZ?=
 =?utf-8?B?aG5QTWZrdFkvYU1ZazNEempiR0Nzcno5dG5kM1ZQZ1F1V2dBelpXMlY2STht?=
 =?utf-8?B?L0hmSDAvQkNMcUR3WTg2b0tKdnZpMEF5bUJqQ0JjaWZDMTVFbmtFOFpBVjY4?=
 =?utf-8?B?V2JXZDljT0ZHQ3dNdTVLUlRDOFFvTVlQQTB2Y1RoWkdHVkFOR1lhYnhVVDZi?=
 =?utf-8?B?U0NhUHgwZlNmRS9qUm1yTGFWSXpjTVNGQmRweG9BbUgwSDl1a2xSK1luZFI5?=
 =?utf-8?B?THFPMTVuUlMycUZVUUM0SEtBY0pIc2s4WUxsMU01aVVyQlZwYjdEUERFL3lo?=
 =?utf-8?B?VDdXdWxuMk1qaXZjWEJydnhBekt2K3NMaGdYZU96ekZSM1ZzdXFBZ1lCbUc5?=
 =?utf-8?B?TjR0K043NWI2MkM3V2h6bUlaVERIVEJISTFtVWNqc1VVRTIzVzE2VWttK0U1?=
 =?utf-8?B?YmVQREppbUllOUhMYkpGWHdJMFJnbmFqQkZrTEpBTFRoTSs3ckdhQzlwcFNa?=
 =?utf-8?B?N0E0UTh1NENQTVh4MG5IS1huQk5laDJlN0d6Z3VPaS9nQU90TzFaYk9adTly?=
 =?utf-8?B?TjFmSHgwRk0vdEh6d2pvUDN2R3ZNTytnWUNPVW9kZUVucVNjSEpkbFJ6UUNx?=
 =?utf-8?B?Wmw3dTg1VkRsR1U2bjA3eHpOSEVBa0dDZHYwQUI0ZWxkY3Q1MHF1dWd1RGJa?=
 =?utf-8?B?TmR2S3pPU3hOWmdkWWEvUTc3Y28rYjhmZHlvYTdFYXpnZ3lzQXhlRjFhTGYz?=
 =?utf-8?B?OEUyNFFtNHFWNm5WSGIyLzNhTGdhSVA5bkdnd0Z3YTJFVWprU04rRjhlcUxB?=
 =?utf-8?B?aGVLeUQrWXM5aE85VFl2OW00cTFuS1pRcDhjOG01TWFIRHlmbnVnVnRIOW9o?=
 =?utf-8?B?anlXNlU0RmZjQlp1MUk3bGpNWXBqUkNOU2MyUzZXVjJRMGVxU21KTHFWY0RL?=
 =?utf-8?B?akEzSGdJNkhPajUycHVVYUNONXJ1RjJ0MldJNXRWTjVtQzEzSnFOQ0p3Z0FO?=
 =?utf-8?B?WEhPU2h6b3J2U0VGNXNWUTladngrdHlIMVh4MXNJb0VlTFZNa1BES014OEU3?=
 =?utf-8?B?cWFCeE1RTktYM096cjNLeG1tWXQrNUMrOEFvTTRRVENoSVpQMUNYb3Z5NmM1?=
 =?utf-8?B?eFhtUW11cUs5dW1oUmFVZ2hnV2RoeGNQaEFBbmh2dWtLTDBHeU43RFd1NCtO?=
 =?utf-8?B?aElmcVRvNmpFdjQzZDVsOENaZS9Gbms1a3pTZGRCaVFGKytONWZTbUF6bGhD?=
 =?utf-8?B?eXU2SkxaOFExcHUxQ29Id1lwbkJTMjZ6aXF6S252SkRQZ0NQODNlc1NkY3Bp?=
 =?utf-8?B?VVZrbGhHa3R2djFpdmFqKzVESXVRelJGWG00RkRRU2dRaUFnelU5R1h5SVd5?=
 =?utf-8?B?bGpWaWZ5ZzJ3RG9HQTZNOUc4OUF2cDY0Ry8wbkVjT0VuS0ttSEpyTXVKNnBL?=
 =?utf-8?B?a1ljMjd2bEIrMGd3THBBZz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6263.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8184
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:290::9];domain=AS8PR08MB6263.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ccb8253e-f26a-4a15-9ad7-08dccdb24b83
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2hqdjhUYzdqTi9pM1lBSmFaeG1janlzNWdVMXg0aUVQbkgyQ1FZZkRJWTNY?=
 =?utf-8?B?QnVFNjFmMlVMcngvV1dweTJSNUJEend3MVRIMTBST2lZeEs3T2tpaGxWRWF0?=
 =?utf-8?B?N2JvQk1MYlljVWlTNVQ1bjdiMzgzV2VaT0lMV3gzblRWSmtwdXY2RVNKR0Iw?=
 =?utf-8?B?cGNhTjc0UGx1czgxekJ3RndDbERFRnQxenVEbEtqUTFQSzN0dWMvdzhTRXRx?=
 =?utf-8?B?SC9MSzZvSFpSSTBldU8wenVTakd3czNlYXlicTZVNno5cVRTVW1DMWNXNUxj?=
 =?utf-8?B?YUNrWHc3eEQ1OGp3VjRxYWQvbVNOZzNkcnVHajNLMUx5b2pHTFBXT1NqWlkw?=
 =?utf-8?B?WE4vYjdIQVRLMjArWFB5aGo2djBnelVwb2dpcUNoYTVlYTBvQThlczVRNE9k?=
 =?utf-8?B?S2RRNVBENFp0ajVJbWZtclMrVFdlaTlUR1dROEhvdEVCQTUzWW11SCtqSkM0?=
 =?utf-8?B?K1BoMjVPczJCWjh0VVpqN0syWjQxQ0h4cnZuUnhVUitmdEsrU0o3UzROanE2?=
 =?utf-8?B?VFF3Z3BRaWpVU0ltS2hhTEJCSndwVGFIMk01eGVGYkhNemowUVlTMmdLbFJW?=
 =?utf-8?B?YTFwcHN5a2hkTHUvSFVRWkVWOGRxMlQ0dHlZd0FnQnR5dGpXclJTandVZkow?=
 =?utf-8?B?d3NFSnNwT3hqQmw1OGRqWVluUWt2RWQ4czZwaWJsQk56Z2dNd0JvWUVEV2Jv?=
 =?utf-8?B?eDRMdVVhcnBJbWtBUWUvcGZvOElBOXo4NEI0SkFqZEd2eXJFMERhdy80N0xv?=
 =?utf-8?B?SU5sSnVpcEMwdHdUSXBzWEIvU0ZncUFLSTQxekNzTEpiL2RCSVN5Y2o2a2FT?=
 =?utf-8?B?OEJ3Q0s5eUNuWlBFZXZsMm1veW5QdmFzbDFCUjdiQ0tDNlBUVWtuUHFaZC9l?=
 =?utf-8?B?eUJWbFBJVjJMbi9NVFhSc1Zob0c5alU2a3AwY3NvOTQ2VlNIZ1VzRmd5b2Ju?=
 =?utf-8?B?bUJ0KzRrLy9qdXhKa1RxdFhBc1BCcGJweDZSQVNmQ2xlaDIwV1pPTzQ4UzNT?=
 =?utf-8?B?V2k4QXhrZUpVS3pmM1U3V1B1aDJ3cHUvTmpuK2NXeEZTcEJoZXJuZWFxSTBF?=
 =?utf-8?B?UWR2TkpuaVZDYmZaVlA4UXU5SE5uVitpeDRheStBdm5tMUs2UExMT0xwdXRN?=
 =?utf-8?B?MmhlSEJmaGJaQStLZFY1TWxLWHdOV0d5SmtQVVB0TWVPdjRJR0M1N2pLMklQ?=
 =?utf-8?B?T052UUVNRTlZYWdRSExRRDhqamZYSnZsL2JYUVRWNm01Z0ZRdVpCSGFTOXc4?=
 =?utf-8?B?cEo1ZVVhcXQ4THhNR1MxV3cwVlV1ZWhpY3NqN0p0UHh6MzdZWXMyejU0YkY3?=
 =?utf-8?B?WWg5eGxrMWhqMVZCQ05YZDIvbzhkOTcreEdONHJnTzlsdkcybGNuVzFSTTdr?=
 =?utf-8?B?MGZqVFpsVXFNZHJPZmx0VTZ6SDg1N00xeVVIaDltRzJHT3I3NHZkeHJkSStD?=
 =?utf-8?B?bUlmSlh2aitmOFVQbml3S2I4eUxpUnQ2T2oxZHhNU0hyejEvZUs4SVJ0KzlI?=
 =?utf-8?B?aGk0TU1YZU0rUU41LzZKMjZoSm9ucmRUTEdkMEpxQjVHS0FMa1RFa1JDa0Za?=
 =?utf-8?B?eW9OZENzWm0wY0x4ZlJaRTFCMWJNL0RrZUV3YnNuOHJ0c1dzK0s2OCtBZXgw?=
 =?utf-8?B?UkJVNEg3QUV4VWlrMjFOR0Z0bVA2LzNvU2hTNEJCMmx3cStWRHkxT1BIZnpk?=
 =?utf-8?B?MXgyckN6Mm5LTlFaTUxRQ0UycGpiTCs1MTYwbWNoYkNEOHlIa1k2bHNuUmM4?=
 =?utf-8?B?K09VTzErWnZDRndWaXp2bHFqMWxVQjg4c2FiNTVWekcrT1hsSFRaQmpuWXEx?=
 =?utf-8?B?YTZ1K1JlZDhpbGo2SzNzU3FrVDZHb3FNMU1oWG8ya1hZNUhuUi9jQjBQUmRk?=
 =?utf-8?B?T29RbVJhRUxTSndOSDZtMzN2Wnd0M05ldlg1cFRIKzZma2lYSmM4T0NudUNM?=
 =?utf-8?Q?qp/pUqXwEzQ/aIJ5RPwrgpTXGH41/VD6?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(35042699022)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 13:54:59.3284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27205bff-ada6-4503-237d-08dccdb25503
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7869

Hi Mary,

On 05/09/2024 12:13, Mary Guillemard wrote:
> This adds a new value to drm_panthor_group_priority exposing the
> realtime priority to userspace.
> 
> This is required to implement NV_context_priority_realtime in Mesa.
> 
> Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>
> ---
>   drivers/gpu/drm/panthor/panthor_drv.c   | 2 +-
>   drivers/gpu/drm/panthor/panthor_sched.c | 2 --
>   include/uapi/drm/panthor_drm.h          | 7 +++++++
>   3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 0caf9e9a8c45..7b1db2adcb4c 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1041,7 +1041,7 @@ static int group_priority_permit(struct drm_file *file,
>   				 u8 priority)
>   {
>   	/* Ensure that priority is valid */
> -	if (priority > PANTHOR_GROUP_PRIORITY_HIGH)
> +	if (priority > PANTHOR_GROUP_PRIORITY_REALTIME)
>   		return -EINVAL;
>   
>   	/* Medium priority and below are always allowed */
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 91a31b70c037..86908ada7335 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -137,8 +137,6 @@ enum panthor_csg_priority {
>   	 * non-real-time groups. When such a group becomes executable,
>   	 * it will evict the group with the lowest non-rt priority if
>   	 * there's no free group slot available.
> -	 *
> -	 * Currently not exposed to userspace.
>   	 */
>   	PANTHOR_CSG_PRIORITY_RT,
>   
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index 1fd8473548ac..011a555e4674 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -720,6 +720,13 @@ enum drm_panthor_group_priority {
>   	 * Requires CAP_SYS_NICE or DRM_MASTER.
>   	 */
>   	PANTHOR_GROUP_PRIORITY_HIGH,
> +
> +	/**
> +	 * @PANTHOR_GROUP_PRIORITY_REALTIME: Realtime priority group.
> +	 *
> +	 * Requires CAP_SYS_NICE or DRM_MASTER.
> +	 */
> +	PANTHOR_GROUP_PRIORITY_REALTIME,

This is a uapi change, but doesn't have a corresponding driver version 
bump in the same patch. You also document the addition of this enum 
value in the next patch, which also is a tad wonky. If you reversed the 
order of the patches, they'd make more sense IMO.

>   };
>   
>   /**

-- 
Mihail Atanassov <mihail.atanassov@arm.com>


