Return-Path: <linux-kernel+bounces-394864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2994A9BB50F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5610D281852
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DD11B3F3D;
	Mon,  4 Nov 2024 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JrJHFmZa";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JrJHFmZa"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2084.outbound.protection.outlook.com [40.107.103.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7768A79C8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.84
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724619; cv=fail; b=nOLR/qelMLxh0Qsvh3gDGfDS+AQLlIa5MgN0hDFGvQLyl8q6W4RJyXu2Nusv5epWTtyhn05VRmf6fpFvkXr4qxma6nQ0Ru7udgKwr2hEr98No4lbvqeBTIytRmlHAx8bYA+YZ+k+PQTp55AQa7AcWoYPM+O54rZqEChsyU89OHk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724619; c=relaxed/simple;
	bh=BOhWSdMuVqvaKxA/3m3TLYRHsy4yZBkIMq1X3Ng8LoY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LuwWimGZDj5J9sL99OJ8Z4Ly6yPuvXZukjuR9OBFuehDngqp6L2wNA6Lu3r5dMlMIML+b6/jhvqPoy9sqCdJwuYn6hBiztfk2K8faYqBKamMGmGG4aSQfFTSRrsY+47BdzQgSGZBOAeNX0TEY8yblAwG/Ab4nphUJzq9jbZjtNw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JrJHFmZa; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JrJHFmZa; arc=fail smtp.client-ip=40.107.103.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yR1KziHH6cpEffnSrZg5eXhJWWEMBXIeA8TgoptPcQQF30F/2Lghk8/ZRGXSFtPAj9GpY023OZxrvjz8FKmxlrHbbQRq+7ngz1QOIzxiP3rdJaYLCTPBc/I33CiFragYWCTVxD//uGtaWAY8+ioWtgup88mqETiyTVuV0430Ao19rBJF5kwpRQuLw8/DoeeilNtK/ZOZ7F1JyPOy3foYFmQhmBPRlrstvPYpHhFdx0274Dib0tXmHCAhMM1x2YWmGGUDA22ey3FrmxsuukNZKgcpFsJJvNknATnNKcDkX49Vj9bAMrCyVrQtDy3QqiDxNSRIgNNitZ4b3Z7ktq3hIg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJtQ4a/fhFnIGFitpfwjh8KCC402KZ5o94TTtAY7Xz8=;
 b=s1AspHWLKFHMqSRAYBdHyqeJQZnJsMUcWcOyaOjLqNK0ZTLfLkvBr1BO2lthZPrdpcfocTiH8vY2Jnt/9w1G8HUaOz6oA39Aay3dYT44s3Mqc4rTYCaPusa8QoX9HIBk4mb5Pdawe9HYaSZZKsm/0v13r5Kqy0PvIhuoi1aqnUQtx4JxIZEQyiQCsbNAlZ9RYXO++KS7A8U9f8z5p4Jm2lOuP7LCzqGSKz7QON4CoOLsDzAUyC8S6sXrBXh5zl0vAWP+RSMXEytwk8CQavf20hHRAhlT8aWT28B5zwL1Ky8MSAKc6SSW81hXbgjf41PFPw2etm0V+S89upSJDtXQUg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJtQ4a/fhFnIGFitpfwjh8KCC402KZ5o94TTtAY7Xz8=;
 b=JrJHFmZaoEo80RlAVQ8vc94J/TOI+TAs5xMzKhCVOYIC5ZPMBbYE+YP8KJr3t9XWL820WSoVNiYFQM5u8vCO2J7G2tAyiXd/6YcuGBReC3jzgbfMgbyJlD2lZ5qsMeHY7HLr5/5Jyraj3qzWLlZsKDH4ARhqCkmYZ25yrp7DGgw=
Received: from AS4P195CA0026.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::12)
 by DB9PR08MB6634.eurprd08.prod.outlook.com (2603:10a6:10:23f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 12:50:10 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::1d) by AS4P195CA0026.outlook.office365.com
 (2603:10a6:20b:5d6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 12:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8137.17
 via Frontend Transport; Mon, 4 Nov 2024 12:50:10 +0000
Received: ("Tessian outbound 8223600b7a9c:v490"); Mon, 04 Nov 2024 12:50:09 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c3a3d43fcb79a414
X-TessianGatewayMetadata: 9GuFh0BAwVm/vAF63LwdUdneOMt3ejPT8cjmY9bI36aL/7gF9BOhaDiES54z2CkDocjMWNFILOFMz2i2AgkdzVYHcEDIWAsfgcBzSkOVJ+yrrGVbTvJEej//mendH+y6fApo9YEBwAj+769x1LGbV8W0liLC3+KvRo6lslFCvNg=
X-CR-MTA-TID: 64aa7808
Received: from L5acb42ce4646.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 303A742A-F4A3-4711-92FF-C81D73F65439.1;
	Mon, 04 Nov 2024 12:50:03 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L5acb42ce4646.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Mon, 04 Nov 2024 12:50:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIuvfnKYqNuyzF+1ZLT570rrhTiaQ4OIc+2eP1JdAe8CNo9PPnCN7l5G5R2ebQjvYLnyZyhR3mVXJmMPvKL8BO8+A8ugm6kBW4cPe3xhOGxEbz01LUZSlRVtQoyg/6Oi9n9yQERcMIVJL4qH5rfTvKzIoE0w1hhJs9cGcByTL6XF7Mg9dFnEiJHFzH2VY3l5hrWIrOG1gCmlUmB0mwowiMTCmxHPYV8u8klTxmUeCxlU90/gzVQ+IPRTLZ+yjGyghzsxj7gGN3CQtefaz/DE1Ahzbh9FmG88VjxLgjlMaXZf8j8tVav4rhnymA8fpje4nVJ8PNC2pRRa5eooJPTvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJtQ4a/fhFnIGFitpfwjh8KCC402KZ5o94TTtAY7Xz8=;
 b=ppvbA8GmMeVfj0ZIwmDWDqxXeIG4+6ny8e6exERK89I0+aeVodSyRPDbe+uWfHFWXGFJGEymugwTKFPiKUD2oeoMZWIAkQtLA28RT+vl/gcUDJXlg7V+ANpKVhSAs9frL7Bx5UWphFbWPccciB1ZwNZjpIzFlqbC3hKFKcG58vkpQWsWYjiVuptptBsetkgM7e+rEllbSXDJU8oeQFl8xAbdLHWC/AUS9EKqMz36KGvN/y/N00oThCvd43PxBrvkxRUAZtMEqXucnPaRwowthjhKLZZYwfjIZseo6mHi63h0Qu6BViXvmL2QnY7/jJc42ZsWfhn4MJkmGAA/9rBW3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJtQ4a/fhFnIGFitpfwjh8KCC402KZ5o94TTtAY7Xz8=;
 b=JrJHFmZaoEo80RlAVQ8vc94J/TOI+TAs5xMzKhCVOYIC5ZPMBbYE+YP8KJr3t9XWL820WSoVNiYFQM5u8vCO2J7G2tAyiXd/6YcuGBReC3jzgbfMgbyJlD2lZ5qsMeHY7HLr5/5Jyraj3qzWLlZsKDH4ARhqCkmYZ25yrp7DGgw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com (2603:10a6:20b:415::16)
 by DB9PR08MB9803.eurprd08.prod.outlook.com (2603:10a6:10:460::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 12:49:59 +0000
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd]) by AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd%3]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 12:49:58 +0000
Message-ID: <ca33d9b9-683d-4c09-951a-1bc48287bdde@arm.com>
Date: Mon, 4 Nov 2024 12:49:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/panthor: Prevent potential overwrite of buffer
 objects
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: liviu.dudau@arm.com, steven.price@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mihail.atanassov@arm.com, ketil.johnsen@arm.com, florent.tomasin@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
References: <20241024145432.934086-1-akash.goel@arm.com>
 <20241024145432.934086-4-akash.goel@arm.com>
 <20241024173935.6430159e@collabora.com>
 <40c9a0a3-81e4-4ecc-b9a0-d55523f5f594@arm.com>
 <20241104121646.687cae93@collabora.com>
Content-Language: en-US
From: Akash Goel <akash.goel@arm.com>
In-Reply-To: <20241104121646.687cae93@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0280.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::28) To AM9PR08MB6982.eurprd08.prod.outlook.com
 (2603:10a6:20b:415::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB6982:EE_|DB9PR08MB9803:EE_|AM3PEPF00009BA0:EE_|DB9PR08MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: 0907afaa-76e7-4e2a-a062-08dcfccf37a5
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?WTlSdXJ1Y29ESEw5dG1tVUwrN3Q3M2ZWMmt1cGkrNmVYcTR1SW5Mb3BERDhm?=
 =?utf-8?B?RnZyVm5FQkZRK0R5QTNCMTU2NlJjMStid1E0YzZJeDBxZ0dzUDVtRWFUN1dK?=
 =?utf-8?B?QlNXVDN4VmY3OWVpRVlBUXVleUtiZGJzNTgxMEZMeG03UkdlZHMzdk9mWll2?=
 =?utf-8?B?V3hOQTZ6TU5PWFQ1TjRnbGgyNUdUTVBCQnV4OHdreTJDTm42Zllka0hIZkJy?=
 =?utf-8?B?ZERnLy9peUNYdGRuRXVJeXZ6elVUWHFEZTBxNk5EMWU5MWxRQ2Y3OENuRW4y?=
 =?utf-8?B?S3RuTGErRkt6dDFnOFdXSXlpYU5BSUNIbG9MYU4vYzd3SGRpejJJRVRzVkw0?=
 =?utf-8?B?VFdZSTREcDlzNmVGNFhlektsTHRRaCtpZFJuQWJ4RWNDUXVxT1FrOGdLcEI4?=
 =?utf-8?B?bmtmN1o4d1lpYjVidE0vNzU3a1UvQlBVcCs1SE9OMlNRUkVIV1FJWkZBdVVO?=
 =?utf-8?B?WFJXdVpNbXQyNGFiand3NkN5WE9NaElEbkt4ZEY3bDlENzVTQ1N5bUpIMHRR?=
 =?utf-8?B?RnQ2bHpvSjQwMkJOU3paVkphU2pQNktReXlRZXc0S1FDWnhlUFVFbFFkSGd2?=
 =?utf-8?B?bVJtSkZRcStEaHNmSWJYYXhXUnV0d1ZvTmxGZFZxTEhMNFlINlUxZjZPckdE?=
 =?utf-8?B?WTYzaHI0RGU0VmtiSVVQV2IvaWlaWGFqR0VqMllqMkVycDE1aDRTTTB6NFVW?=
 =?utf-8?B?aHByRnZtVmxGRC9NTmpBVGZ3OWdza0FYN3I4eDhiL05LenI4SUJnbWEwdUc2?=
 =?utf-8?B?ZTlIMGtBanREVDU0OXJmZEZFdUZTMjlyOHRhK2hIdXVjRStqQ2x0V1FYazRG?=
 =?utf-8?B?aldoU1BxVFdDbzFrSjVjUUlSRzVLKzNRUEEvcnh6d0xNWFB0V29LbndqVU4r?=
 =?utf-8?B?NzNvU3h0blpzRjNuVEgvVVFnbStVek1pVmZKbCttenBCM3FBODk3VHJLbDlv?=
 =?utf-8?B?L0ZtYTRLMktQR2t3TjJ0MWpPczA2aytuamx0TnI5elg5aE9Bc0lraXRFK255?=
 =?utf-8?B?NW9pa2RFRFltQ280SG02UzdhNnVaS0tBd29BbnRyVkp3M1BBaDdqVHV0U3dT?=
 =?utf-8?B?YUQwYUFFakxSb25rRWVxWE1wck5PeEh3amlvL1BTaitrRXpEUU9xVjA5dERt?=
 =?utf-8?B?dlVObFZCM0xMWWhtNHdMcXhremhrQkx2V0JOWHNiUkxvT3lsWUt5NkVtRmsw?=
 =?utf-8?B?bHkxdC9Pa0ltQzYrLzFJWkJmMWljdExQVG1CVFlEVUdPT2NCRGlYa280UEVw?=
 =?utf-8?B?MjgzTjlXMTYzKzBaSjFlQnNsVlBVS0ttOXUrdVFZL1M5NkRsOTNkK2RoMjVx?=
 =?utf-8?B?ZmlNbTZ2RFh3VHFxeCtUR3JobVRFM2hZSFpKTnQ4TkFtTXJMMW90V1dHYUJE?=
 =?utf-8?B?Yk80OHBhNmN2bWRrOWVEb2ZxMlozczdXcWRoNmlWT1RpQkV3emtMbU1JV1lw?=
 =?utf-8?B?TDluekYxS01ONk1ySGs1Y28xb210dEtrbzZlcVU1WWoyOFlTc3FsWVIyZS9M?=
 =?utf-8?B?VVMyVkF1ZXRydW1DcU41NHZBanBDU21CNmxoTWJNRkF1REJERzNOS2pqQmJ0?=
 =?utf-8?B?bWkwc3Z2T3QwQXk5bFg1Mnh5NzFjQjdVc0l3OS9YWGNGWmxFNlVoZHlsd1RO?=
 =?utf-8?B?MzkweVI4Y1h6Z2JHVWxCSmpDZzFEMzNTNENhNVd1MzBGMmRHcUlKazhNbU8z?=
 =?utf-8?B?UDBEL0JNYm0xb3FiY0QwSXduQUNEVmE5N0ZQU2ozcnFkVXdVWTR2RFpBPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6982.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9803
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:415::16];domain=AM9PR08MB6982.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	97b39584-670b-40de-80d6-08dcfccf309c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|1800799024|14060799003|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkhXK3ZvWE5WZnppRkVqRDJHZXZia0NBWmlCd2pYWm5PUTJSMnRTaXFBNXJ0?=
 =?utf-8?B?bEh6SHlBUUNHUWllMUd0aG1XZEVlRVNoUkhWcEJjalhja29kc1VhSHUwbXEz?=
 =?utf-8?B?b3NkakY1WjkvVXpMNmpROURyamx2clhiTVJNcVFWN1BVckhub1Y4OEg3TFFn?=
 =?utf-8?B?VXVCbGs5Rm5MdmI0VXd5eUwxZ0ZURk9pQ0I5RVhscm5vcFZNK1RNaHlUTnpX?=
 =?utf-8?B?QjJXUFhPTG5ZQ0JiU0pqSDhNWG02aFlsdS9XMzBpY05QWVVSQWpxWVp4OEkv?=
 =?utf-8?B?WGRRQktKYkVOeHJSdWZsVnJKRzZocjRBRHNKa2RHb25iSlJmY0NTc3o2WVE2?=
 =?utf-8?B?bWhqWElmV2xTQ0NacU43YzFWdHVJNHJuRHJ1RTZoNFRCR0M0Snd2MHNwcFl1?=
 =?utf-8?B?a1lJdytsUVBVdmhsaHVzREZzeE5KWTBzbmdSNlBRa1ZrbnNtNkJoc3BlTEpp?=
 =?utf-8?B?ODNQVDhHVW5VbDBJbjh6UkVRTkRxZDRmMVVkVlpvZXlGYVpneFhCNWRzODcv?=
 =?utf-8?B?VmhOVUk0aDNUTy83TVlPbGtyeVAyY1dOajJnZ3BzUWhCSUoxUFRtMnByNTlj?=
 =?utf-8?B?UVpoWHZsYUtwZ1pwU3dyMXo0UDRyQkhiaTJnY2hwSytYNXNTUEJXV1Q3R21j?=
 =?utf-8?B?c0JEV0pYVzhLOElJTTNYNVpwN1B4d2tlMnM3K0dtTUJGZWU3TDVvcXNvaUxU?=
 =?utf-8?B?LzdsMkN0aXAzeG5DUnp4Y3YyeW9Od0daSGhPMUI0SXpvTis5MXRDOWM2RjVE?=
 =?utf-8?B?TjZNc1BrdTRnS29DdW9tTjJSNlFPR29KODZSWEd3ME12bzIrVm9NQlFDSTFw?=
 =?utf-8?B?dm9Pb0hhUlBBbkM0K0NIUWF0VStkVXpSRnk0c3NYemhxNi9tSU9jM2FjMTBG?=
 =?utf-8?B?cWtvYk9XNW1HQytoY29VUFV0bGVHb3oyMGpDb3E1RzNzcXZNbDF1eU82QURT?=
 =?utf-8?B?V0R6MmV6eHhpTEtJUmM2TGtpTUxLSGNiTlhYYUdnUkFmTnlTQVZVNmg5S3BJ?=
 =?utf-8?B?aXZjdGYrV2JpQWlMRlNsemZDMis5dTZtVWwwY01ZcnVNUlJmZG9tNXFLYVBM?=
 =?utf-8?B?ZHlaRXd6L0ZlL1lYMVdpS2Nwek9vWGNPQTRtNzVKMnNlV3NHWFhJOHZPMyti?=
 =?utf-8?B?b1VPN2xjQUdMa1dQY29xQWhyYWtvZW9xVHNhdEZ5N1NWckJ5MU1qSG5TMHhS?=
 =?utf-8?B?RStNR3NacVVRditJR05LbHVYM0QwdjluTksrLzROWDR4SmdTNEtWZDFjdWpJ?=
 =?utf-8?B?QlJkRGxhUFc3bXNIeVRRaGpOYWhQY2xGQWhpVUVjam51Z05XbXlrRVY3MGhw?=
 =?utf-8?B?ZjlYdnZzTlAyNnNsWXhsd1l4Q0hkS2gvUmN4elJGYkVEdmVDajUwdy9ZWHpW?=
 =?utf-8?B?YWVxZXh4V1NUVnpvNmROdXNXT040OWIrMWNqOFFFYU9lS1NzWVVMa3BFRUx5?=
 =?utf-8?B?azhnRWNzb2NrcVg5TTdKZTJaT0VLb0lPdStrTWs2U1cwLzBGZHZvcndzdnhM?=
 =?utf-8?B?WWdsNUczMkd3TnNGQ1FSTUREK1lORWcrVnBKVHpucFZtNkM3SlhiNktQcVZ3?=
 =?utf-8?B?Q3hLa0lYZW9KRmlLeDdQUGRoMlBMWlJvd1ZJc0ZXUkdwVlV0YkxraEI2OGdB?=
 =?utf-8?B?a0d1RWpEM1BsL2Nzb3Zub1VBeU5ZWXBwc294U0h5Q1Q4Nmw3NGZmZEVqUWhi?=
 =?utf-8?B?NFN3UDZzUHFqM3N0aDd2UERNb3NIaFA4TjNUTzd5K3phejVsQkFOSUpZdmNO?=
 =?utf-8?B?ZUs1ek1HMG9iWU5IaEY4a0FWSjJ4cU8rTlJES0k4bDhOU1kvU0U4MDV6cy8z?=
 =?utf-8?Q?d+Umr3cs6F3ofmtfw50/BNEEBC3UDLaMwgnjo=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(376014)(35042699022)(1800799024)(14060799003)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 12:50:10.1017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0907afaa-76e7-4e2a-a062-08dcfccf37a5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6634



On 11/4/24 11:16, Boris Brezillon wrote:
> Hi Akash,
> 
> On Thu, 31 Oct 2024 21:42:27 +0000
> Akash Goel <akash.goel@arm.com> wrote:
> 
>> I assume you also reckon that there is a potential problem here for arm64.
> 
> It impacts any system that's not IO-coherent I would say, and this
> comment seems to prove this is a known issue [3].
> 

Thanks for confirming.

Actually I had tried to check with Daniel Vetter about [3], as it was 
not clear to me that how that code exactly helped in x86 case.
As far as I understand, [3] updates the attribute of direct kernel 
mapping of the shmem pages to WC, so as to be consistent with the 
Userspace mapping of the pages or their vmapping inside the kernel.
But didn't get how that alignment actually helped in cleaning the dirty 
cache lines.

>>
>> Fully agree with your suggestion that the handling needs to be at the
>> drm_gem_shmem level. I was not sure if we really need to do anything, as
>> I didn't observe any overwrite issue during the testing. So thought
>> better to limit the change to Panthor and get some feedback.
> 
> Actually, I wonder if PowerVR isn't papering over the same issue with
> [1], so it looks like at least two drivers would benefit from a fix at
> the drm_gem_shmem level.
> 

Thanks for giving the reference of PowerVR code.
It is unconditionally calling dma_sync_sgtable after acquiring the 
pages, so could be papering over the issue as you suspected.

>>
>> shmem calls 'flush_dcache_folio()' after clearing the pages but that
>> just clears the 'PG_dcache_clean' bit and CPU cache is not cleaned
>> immediately.
>>
>> I realize that this patch is not foolproof, as Userspace can try to
>> populate the BO from CPU side before mapping it on the GPU side.
>>
>> Not sure if we also need to consider the case when shmem pages are
>> swapped out. Don't know if there could be a similar situation of dirty
>> cachelines after the swap in.
> 
> I think we do. We basically need to flush CPU caches any time
> pages are [re]allocated, because the shmem layer will either zero-out
> (first allocation) or populate (swap-in) in that path, and in both
> cases, it involves a CPU copy to a cached mapping.
> 

Thanks for confirming.

I think we may have to do cache flush page by page.
Not all pages might get swapped out and the initial allocation of all 
pages may not happen at the same time.
Please correct me if my understanding is wrong.


>>
>> Also not sure if dma_sync_sgtable_for_device() can be called from
>> drm_gem_shmem_get_pages() as the sg_table won't be available at that point.
> 
> Okay, that's indeed an issue. Maybe we should tie the sgt allocation to
> the pages allocation, as I can't think of a case where we would
> allocate pages without needing the sg table that goes with it. And if
> there are driver that want the sgt to be lazily allocated, we can
> always add a drm_gem_shmem_object::lazy_sgt_alloc flag.
> 

Many thanks for the suggestion.

Will try to see how we can progress this work.

Best regards
Akash


> Regards,
> 
> Boris
> 
> [1]https://elixir.bootlin.com/linux/v6.11.6/source/drivers/gpu/drm/imagination/pvr_gem.c#L363
> [2]https://elixir.bootlin.com/linux/v6.11.6/source/drivers/gpu/drm/drm_gem_shmem_helper.c#L177
> [3]https://elixir.bootlin.com/linux/v6.11.6/source/drivers/gpu/drm/drm_gem_shmem_helper.c#L185

