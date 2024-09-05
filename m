Return-Path: <linux-kernel+bounces-317519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F66996DF6D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB0F28382E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0D91A00CE;
	Thu,  5 Sep 2024 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Sy1yHoBp";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Sy1yHoBp"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2065.outbound.protection.outlook.com [40.107.249.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81BB19E831
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.65
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553355; cv=fail; b=WeqfFB5G4CR0FRJOg7o1fwAxS2mPy8JNycFNLnXbUgQMp1+x3HY1NP6s6CKhXCvGG3ruDTnFe6JDdy0kUlY6lXL9bfHvkkOzalzmYR7WwAHuSEvhdtWLtpc7A5uU9fp64BRujA0kzxK6gPClENWA2QCKEzJcy5TU6HvrVm39kos=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553355; c=relaxed/simple;
	bh=qZ370zHa0LfsRGxwQdF89I+olRk+AUOaNthEgLpmfo0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M6+0w9Js0e1gYclVYc3AEWun5ZBUXfYqbCSdOI5CDDivTol259qK38DTka/6DxpwgXu2zBvQHuHZhDFJNeD5a8PRqE41DWiwBLVNNbRiojs5HJQFDN6jTKtRSR63Z/tk+a4JCwgeUxFhIUs+yGdnCqN8aaoZBxuGBCJ+x70a11U=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Sy1yHoBp; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Sy1yHoBp; arc=fail smtp.client-ip=40.107.249.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=IeDn2XxVwN1PDJ2vj0Ol1QEx9HevZIA9sexOWCMVaqqyyQHbw7IrOn1OkwmYqLmLudxW1m2E0qj3ub4CqKKt65VouMdOTy1rhzHjeAnTNtjXDEAVqnpZ1eukOeYbO5L/QMuZ11EZKni75V1bp5u433wfeT1b8+JYGQ+bwUpHP7xtftirB55atxBPE0zhdSgHLaYJV39yNK0w9jeEBJ0x/Lsrg4AVPzfcFxnzHlAJ7dYqdZI9OUh8n/xR1b3MuykeDnBIctIShw8FVoJ4UxcMjCz0QPqFbdbDmNnJkUR3kovfjjmjqXXhNnK2MgE80kywG47fjUmVw/BEryMa1QSEkw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RROHgrsRCaIdXSpoLC+Yi+hnQXFcWsOsAztcm5/p+N0=;
 b=vTJEaN5qweZ+96/6ECki45NKsK13dcVPXH1SkKys3KGL/pd6dmbf6zwGA7gPTbyWjPRPPX7XEK/BAJE3w+qQot5jyjacH38U9jYk8Rsoq56a+LxwX0l8BAsi5LyW3X7vCFNMFmwt0H0WeyxitXXCqspyyFoYKEmZ8R+7tHKqBwJO5bkNu6nXq46k818r4EsIF2griDYVKRD7MvJ+OUMI+N71atgb+brB/tqb9n8VnojHx5NgB6QZxFgUNszzbQVwLoWi7Z4aywh77iUyYkYuotqH3/9HMfpnof67rpfFRxogTd9p3kIxX5zlMq8W6s+QsnoZYH+LGBiaoDI8uzHybw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RROHgrsRCaIdXSpoLC+Yi+hnQXFcWsOsAztcm5/p+N0=;
 b=Sy1yHoBplZQM9BYiKVJrXfnHkse8E87UeqRZbdZXnJwSLfvbXiCNT8xZZotWehXbVxbgmh6cN6s4jympOpk9kQks0cN9/+MpUmq3U/NtHPx+K/L2wUjBwp+y51QsWyCn5NwZ1jCqxhKNI9gqgDpTRf0ZxLD7EU9VjtqmOb4HXdo=
Received: from AS8P251CA0011.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:2f2::31)
 by AS4PR08MB8168.eurprd08.prod.outlook.com (2603:10a6:20b:58f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12; Thu, 5 Sep
 2024 16:22:26 +0000
Received: from AMS1EPF0000004A.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f2:cafe::4a) by AS8P251CA0011.outlook.office365.com
 (2603:10a6:20b:2f2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16 via Frontend
 Transport; Thu, 5 Sep 2024 16:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS1EPF0000004A.mail.protection.outlook.com (10.167.16.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Thu, 5 Sep 2024 16:22:26 +0000
Received: ("Tessian outbound 581e74bc26e5:v437"); Thu, 05 Sep 2024 16:22:26 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6f441a84709157ca
X-CR-MTA-TID: 64aa7808
Received: from L1340ad7ecd5b.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9382E206-229B-464E-8AC8-CB322AD545F3.1;
	Thu, 05 Sep 2024 16:22:16 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L1340ad7ecd5b.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 05 Sep 2024 16:22:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEZwA8sgUp304igQ+O9P7crQfHlRXnuSOs9uupz3x7NTb94ODrqNmyxE3U3i4SHw6wQGs0kqImy/lGxGphdIyoKcTXoUOLumoDq7aLAvY7Xp9W//bruUmcDh96ejy6u1f/2PYiY7Y0ZKVqEsuxfeSj6TGgtUh10CFGlTT1Ft6kdSBZZy6R4ymOgHNTgzW0iL2evvAGkFx5iOz3qGAQ6S072CG0w3l9eq3/wRZxXSBN6DKc70oG6VseZ2BEEpiKrHdE9WyiIpgLS8G9oJjPs7fPWnIQQhXqTpyg+PCC1imjTwZiRPr2JTIPaQdmyUi9A5ITJJnmC/N/ftgqyU6qRuVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RROHgrsRCaIdXSpoLC+Yi+hnQXFcWsOsAztcm5/p+N0=;
 b=IUtjXlVffYi3cD2+AIdp+qJhweZkZYQ7lSS9UvVWPYOtmR4YWtBQuQa0zYU7sz/p3MicV75i3mC/deXDhzbFvfaIE/l7QvYiFZTC44IBU+sn1PIZHNcQJro5gkUkK4nlfUO7vNgVcySatzc9Q1B03t6zRpOEYSOkf+Tu6ch+FyQmaVEgdkC63ELsLcy2V4Z5OTl/oMzBdOewUF2jEn0WcdpJz8Eue7LiZArZcqZEbBS9nCjoPhxtOWrWM7LUr5RDv7i61DKtILVzpDAdScfkvL7lefVwrNMWfpg+AcwdSCX2cln3sgzIaWySI714UEqzFFZPuvM8nUXczW69AL+YUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RROHgrsRCaIdXSpoLC+Yi+hnQXFcWsOsAztcm5/p+N0=;
 b=Sy1yHoBplZQM9BYiKVJrXfnHkse8E87UeqRZbdZXnJwSLfvbXiCNT8xZZotWehXbVxbgmh6cN6s4jympOpk9kQks0cN9/+MpUmq3U/NtHPx+K/L2wUjBwp+y51QsWyCn5NwZ1jCqxhKNI9gqgDpTRf0ZxLD7EU9VjtqmOb4HXdo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com (2603:10a6:20b:290::9)
 by AS8PR08MB8611.eurprd08.prod.outlook.com (2603:10a6:20b:563::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Thu, 5 Sep
 2024 16:22:12 +0000
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c]) by AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c%4]) with mapi id 15.20.7939.010; Thu, 5 Sep 2024
 16:22:11 +0000
Message-ID: <8f4329e3-613a-49b1-9d01-0e8451bea54e@arm.com>
Date: Thu, 5 Sep 2024 17:22:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/panthor: Add PANTHOR_GROUP_PRIORITY_REALTIME
 group priority
To: Steven Price <steven.price@arm.com>,
 Mary Guillemard <mary.guillemard@collabora.com>, linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Christopher Healy <healych@amazon.com>, kernel@collabora.com,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 nd <nd@arm.com>
References: <20240905111338.95714-1-mary.guillemard@collabora.com>
 <20240905111338.95714-2-mary.guillemard@collabora.com>
 <2b2d13a9-9e84-406a-a803-5366036fa761@arm.com>
 <d24272d4-e21a-4f62-8797-ce29dd6d2147@arm.com>
Content-Language: en-US
From: Mihail Atanassov <mihail.atanassov@arm.com>
In-Reply-To: <d24272d4-e21a-4f62-8797-ce29dd6d2147@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0191.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::19) To AS8PR08MB6263.eurprd08.prod.outlook.com
 (2603:10a6:20b:290::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB6263:EE_|AS8PR08MB8611:EE_|AMS1EPF0000004A:EE_|AS4PR08MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ddf6ab-645c-4254-828a-08dccdc6ee68
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?OEk0RW56T0d5Y2ZjaHY0c1VlWW1JVkhsbExiZXhhV3BXNUNBWTVCdUwycUMr?=
 =?utf-8?B?Vk1KdHVlekZyRkRzS2h2RnpBVWgzbS9BNTdBcisrVmp1eE1tU283Qndsa0ov?=
 =?utf-8?B?dlgzNVByWnNwd1EwTUNadStDNmpTR1d4cVRpajk0T01OcUhNTTJpb1A2VXBh?=
 =?utf-8?B?b050Y1l1ZUk4Q2w1TmJxWEc1Q0JiZTRWcFgwaHNucVdpMDN0ZldmT0JyVUZx?=
 =?utf-8?B?VlFqblpoSVZpeW9Xai9Uc1RzcEhjeTRiMzZ2MU1rVE82ZEdjUmRPbzFPUGxW?=
 =?utf-8?B?L0FBWW45ZTA2RCtmOTRaRHlad0pBSmdxM2o5WVZMUUZzRTQ5ay96VUlsU3BR?=
 =?utf-8?B?WDJhVnkrSjVTN1Nibk82WXBBeDZpdWJ5RHNVdFZ0M0xtN1FXbnZZNUJwOFNu?=
 =?utf-8?B?TEptbkpKUysveWdMYUdIOTlwQUJLTkFpM0wzN2hJRGNyeUdkZ0NBOTlLWmo4?=
 =?utf-8?B?NGhjL3g4MklnOEI4LzhLTzFzM1paWndTcVBEUWczLy9HZVFJU2gxYjVwU2Ja?=
 =?utf-8?B?Ylh1YjVoRDlOL2ZCc284VldMR2R6eDlVL1p4S3ZQWkh1c0l0MEVhVUJOekxU?=
 =?utf-8?B?d2RqRFVjWGt3UEN2N21MTnN6alVaMUF1MVdaWjZvWmNkaE5wWXN4ckptOWIv?=
 =?utf-8?B?VDlSSVkvTWtZYWVPUkNyRlo1cG4wVFhRMTBXMlBYUms5VFhvQ2dibGlGM0tM?=
 =?utf-8?B?bklpVTZhdUVaendudnYySUpYTVBFM0tvS0xWRUt2ckxHWGJDeVRCOEROWHYx?=
 =?utf-8?B?MzNiMW5GTytwUzJFOVZTbTdPdFo3YVkxdDNMblhrZDM0dTNlcmJrZDJrZHZI?=
 =?utf-8?B?ZFdxUHpxM1BpR1ArREtmUCtUTWowajJFM0Q3Q0xuVlRtWS9yTEdUMkJvUHkr?=
 =?utf-8?B?dWNvRjYzSGhOK0dXc0ZVMTFEcExBYm4wS3hHdnNBVWFBd2J3TVpBbFVXQUd6?=
 =?utf-8?B?MFljc3Y3WXNTcTluVDJxZ0QyeTNSbWRkbkhHVjRVQkF4b0xkK3NISlc1M2NB?=
 =?utf-8?B?V2c2dWJpcVg5ZktIdkpkZXMzakVITm5MSUNjTHNLM2Y4azBIUG5RZlk0ZDNi?=
 =?utf-8?B?RHNBZkFMaHUwbnZmSkRMT05NU1BWdGRsSlFwOHpvYkNTa0I0cGdSamR5SE5p?=
 =?utf-8?B?RnJiSG14UkRGUXhIMU1nTk1UcnpnT0J1empzb2dmalZvMmZCKzRuK05hOGt3?=
 =?utf-8?B?WVA0R3ZYdDBxR3dJbW5QQ0xCKzlRTzlWUkVXSEdOclFlMzMzWWhlbEdpZE93?=
 =?utf-8?B?WnVRYzQvdE1IT3F4WlhUcnE4RGxObFJpeGxlb1IwYmM1ZGgyamIrUjlyQ2Zh?=
 =?utf-8?B?b25pUmw3UWdXMXpqcGwwcnZoS083UThwUWpxY3dzRkdwcnVCTUFPZTk0QVUy?=
 =?utf-8?B?TG5WQVY5U1dSK2lLWjlpd0NQQkJUREh6V2g5K1E4eVBpY2gwYVcrZ3lqN0l2?=
 =?utf-8?B?czk2OVlXU0wyeGpibXEwNWwrc25XYkwyVTVFUW1mQlJvem1CVTB6d0I2eEpO?=
 =?utf-8?B?MjFiam8yVmtkZ1lXSHFrSWI0MlpGUU51dDdYM2g4SUVUdVd1U3REWmVmQnYy?=
 =?utf-8?B?cEMzWUJlWXE4QTNWRWorbVR0TXJKa0tUZkVLTnJ5Ulo1dmFDREEyL1Q5YjVv?=
 =?utf-8?B?bThNZktMeTdBNlcrVGxlMnJqbzd3QTRwb3hBVDNYc2ZldFRuMUpLbVpwaUZy?=
 =?utf-8?B?YXVxSDVKSDlvcjFGc29DZDFzdnNWejdueXcxTFMyemxINkZXYVJMUWgxY1Yv?=
 =?utf-8?B?bUZWS3k3VWhRZ0NiaFo4N2QyYmJJQ3NhbmNSbHlyUnpYam9CVGZpTG9Ha3NC?=
 =?utf-8?B?NjMyZHFnMWdiSzZ6THVidz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6263.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8611
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:290::9];domain=AS8PR08MB6263.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	12f511ff-9744-4824-31eb-08dccdc6e58a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmxIRzBqL1FJRmlHUnVVa25qZDhDdmlDWXFMTXJPZUhXWWNMTmFKc3U3OEhR?=
 =?utf-8?B?QTlXTG1jWnNPUjNuWEtqaDRIL2xxdGFXZHR0K3F3VjVpRjNCTkJhTHVGSUVV?=
 =?utf-8?B?ZmhZS21FTUF5SEE0N1FQOStuc1MrTjc2NGJBb0FjRmdkUVpLMFc2d1dQZ3BV?=
 =?utf-8?B?VXFKUWlFeWtWay9zK29LQkRBS3NaTUZCNXltV00wa3E2d0xFN0RocmNYN0tM?=
 =?utf-8?B?bmMzNndmenBTd1htak1PRzBzMnJiSXFEbmJGaXJ1TTQ1VGFvc3JNRnZIa2k2?=
 =?utf-8?B?ZUpGeHF4bTZoZ3ErQXZVRkpYMGtGcmFxdm5pOFVxNjRGZ2JqeW55ZzlIbVV4?=
 =?utf-8?B?c05XSHNHdDNmL2FNYzFrWlpKMlEreUJ6OWxDbXZmVEVXTEJtZzNEUVpWNEFN?=
 =?utf-8?B?QU8vZVliL0p5NFVJWElaRVZLNVVIVy9ubjF4MXc0VzBGYjRMQVBYMUxhQzZ6?=
 =?utf-8?B?a3gwWWkzN2VXSzR5MFFET2J0c0FtWDJ6dGtoTThuTlJSYk5pSmlFZ3prKzlG?=
 =?utf-8?B?T2I1MXVUK29BNVZkQVU0Vi9NSXdHTGJuZStZQmc1MWZJOHZzZ3ZPZHhRM1dh?=
 =?utf-8?B?b3RMdmxHNmFxTVV4K2l2SHYyc2QwV1hhYVhNbDdBMHlXKytWNDVyR3MzdGFo?=
 =?utf-8?B?MEdiZWpCUGhwUWNMaW5HQnhjUGJNUUgybFlmak5oTUdFNGI0a1ljRGtOWHlB?=
 =?utf-8?B?bHlnQXc1bkRHOUFpRUFobE03N2laejFJVjN3bmdyblkxZlBjNUhDSjhONGxx?=
 =?utf-8?B?U1cxUk1mcWV3cmhKU3BqQU9UTjI0UUFvbDg3cisvNmo0eUVEM0p5cGVGS0R0?=
 =?utf-8?B?TEhYRys2VjBPTDZ2bnJKSzZ2TG5VS0xKclV3UVc3SWtzNmZNbkl6d0xzK2U4?=
 =?utf-8?B?S2xMSlhDclBnNHd5SW5sb3RyRTdjSW5jSjc3ZllFeHpkOGZZREZ4RGRKQm1T?=
 =?utf-8?B?U00vbjN3WDhNVjJOeUkrNEF2S1hBc3orUEhsdkRPejFaTnBRRWhYd1hxc3o1?=
 =?utf-8?B?OWRrZVNRbXdhRHEzUGxMNUdJUFVwV2VsSW1MVEhqbFcwTnVrZ0RGZ2NGYU9w?=
 =?utf-8?B?M1JRNjdINnRsSVFnUEF1bC9PVnFxVE0xYkhENXdGcUpGQnhsaFpJeHA3NUgz?=
 =?utf-8?B?SkFnRzZSV0hYcitvalEwbEdJdURQUEVIdE0zcldVVVREL3RROVBKZTYreHNC?=
 =?utf-8?B?Wk5XelhBTGJ4R2VTejV5OU1CM29JelBEdHVkUUhSMVFvUTRwNjg1VTMyREdk?=
 =?utf-8?B?V1VGelFGNnJRNTIyeDVCd0xyMjY0eHl4akMwV0hCcTU2UHhhOGVEVTFnWm9q?=
 =?utf-8?B?eXpReHZJbVZORW90ZE5kU0hMTXVrV2VCZzg4SkswVHV4MHlTN2lXK1F4dWZK?=
 =?utf-8?B?TFY3NjRacURIR2NDRFRoampQaW94MmVXbzdpR1E4L3dzTC9hTjRBZHJ3UC92?=
 =?utf-8?B?akhCK055Z3dsVlJTa0x2VmpxbUJqZ1ZkQU9rTzJjQXBFWVlBNGdSZDN4MU1r?=
 =?utf-8?B?SHM2dkYxUHRZdnMxMXBWNXozWnVKdTBuSFBmc09OZ24vRk1MS2t2bzBZcHNz?=
 =?utf-8?B?RkRRSE8vMUxaUk0rVC8rbVUrU2Z1QkxnU1ZXbmJYUTJzV3QwRWZaK04zSHA2?=
 =?utf-8?B?bjdyc0xDOUtrNGh4bTlxNXY2bTVoKytBNGNoa2ZhaDM0Z3dPMzA5WmlZTysx?=
 =?utf-8?B?QWladUVVaFVOZkpnaUZzS0FuMHlISFdsODI5VUdyMFlobHhMNXlGMVQrRFBJ?=
 =?utf-8?B?VjJQR0c0dTRMNHE1K0J0SmNaVWptZ1RSTk83T3BNRnY5MGdXaHFZUUFRQitU?=
 =?utf-8?B?N3dWQlNDREJtWlZPVzBteHRsdUdjdGZlM1lzS1FvOEo1N3plZ1kyMThhcEcz?=
 =?utf-8?B?VUpEQ3dKd2I2cEIra054cHR0d3VGT0N0cFlsRjF3UmxGaXY3ZE5pNWpjV0hC?=
 =?utf-8?Q?k0VzbviIXxZsT3bqm+IGDwfLt8M32IXq?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:22:26.6031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ddf6ab-645c-4254-828a-08dccdc6ee68
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8168



On 05/09/2024 16:41, Steven Price wrote:
> Hi Mihail,
> 
> On 05/09/2024 14:54, Mihail Atanassov wrote:
>> Hi Mary,
>>
>> On 05/09/2024 12:13, Mary Guillemard wrote:
>>> This adds a new value to drm_panthor_group_priority exposing the
>>> realtime priority to userspace.
>>>
>>> This is required to implement NV_context_priority_realtime in Mesa.
>>>
>>> Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>
>>> ---
>>>    drivers/gpu/drm/panthor/panthor_drv.c   | 2 +-
>>>    drivers/gpu/drm/panthor/panthor_sched.c | 2 --
>>>    include/uapi/drm/panthor_drm.h          | 7 +++++++
>>>    3 files changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c
>>> b/drivers/gpu/drm/panthor/panthor_drv.c
>>> index 0caf9e9a8c45..7b1db2adcb4c 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_drv.c
>>> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
>>> @@ -1041,7 +1041,7 @@ static int group_priority_permit(struct drm_file
>>> *file,
>>>                     u8 priority)
>>>    {
>>>        /* Ensure that priority is valid */
>>> -    if (priority > PANTHOR_GROUP_PRIORITY_HIGH)
>>> +    if (priority > PANTHOR_GROUP_PRIORITY_REALTIME)
>>>            return -EINVAL;
>>>          /* Medium priority and below are always allowed */
>>> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c
>>> b/drivers/gpu/drm/panthor/panthor_sched.c
>>> index 91a31b70c037..86908ada7335 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_sched.c
>>> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
>>> @@ -137,8 +137,6 @@ enum panthor_csg_priority {
>>>         * non-real-time groups. When such a group becomes executable,
>>>         * it will evict the group with the lowest non-rt priority if
>>>         * there's no free group slot available.
>>> -     *
>>> -     * Currently not exposed to userspace.
>>>         */
>>>        PANTHOR_CSG_PRIORITY_RT,
>>>    diff --git a/include/uapi/drm/panthor_drm.h
>>> b/include/uapi/drm/panthor_drm.h
>>> index 1fd8473548ac..011a555e4674 100644
>>> --- a/include/uapi/drm/panthor_drm.h
>>> +++ b/include/uapi/drm/panthor_drm.h
>>> @@ -720,6 +720,13 @@ enum drm_panthor_group_priority {
>>>         * Requires CAP_SYS_NICE or DRM_MASTER.
>>>         */
>>>        PANTHOR_GROUP_PRIORITY_HIGH,
>>> +
>>> +    /**
>>> +     * @PANTHOR_GROUP_PRIORITY_REALTIME: Realtime priority group.
>>> +     *
>>> +     * Requires CAP_SYS_NICE or DRM_MASTER.
>>> +     */
>>> +    PANTHOR_GROUP_PRIORITY_REALTIME,
>>
>> This is a uapi change, but doesn't have a corresponding driver version
>> bump in the same patch. You also document the addition of this enum
>> value in the next patch, which also is a tad wonky. If you reversed the
>> order of the patches, they'd make more sense IMO.
> 
> You can't reverse the order because then the version bump would be
> before all the features were present. Generally we put the version bump
> at the end of a patch series because it's indicating to user space that
> the new features can be used. This way round if a bisect lands in the
> middle of the series then the new priority is there but won't be used
> because user space won't know about it (which is fine).
> 

Ack.

> Steve
> 
>>>    };
>>>      /**
>>
> 

-- 
Mihail Atanassov <mihail.atanassov@arm.com>


