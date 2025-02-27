Return-Path: <linux-kernel+bounces-537475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8236BA48C68
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F13E18909BC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C43126FDBA;
	Thu, 27 Feb 2025 23:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="asylf9eo"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F0C23E34E;
	Thu, 27 Feb 2025 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697625; cv=fail; b=rgypjj7rTFrKZo5JWwmZujLY5xZCEX1fPOlyn2dMA02i5ccvqzp3dzZZ/5IPiFwPMiPtBz4Y2tuWFXMvINd/cpPECYFuMDBMP0Adc7h4CDFhGaVav0Cf6/WTxIZGW/Nr5oO1UR2vYi6UQEReJYk8SejGo5KzI3LOnFIGIk1cmq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697625; c=relaxed/simple;
	bh=qKYtvIl8opeYD/PSCiV8U+/Nt9hYJpBwGqa7lOIV+SY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=gHIQQ7OoaABMKvoO5IQ4pmSffGMw0d4oPzg5NNxVmJiLoXBXDMP+7KeI5HAta47bZiQ6ByBlGpu5LAoGPOC+9VF9TK9B4gDGVxFbW9zw2I+nex7Q28MRGq109fjcSNKSY25Cd2pxslWdlWcBVcBv7YBDWl96jafCms3Bs93v0no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=asylf9eo; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaVjd4xNbr56OHXzqmfQFxP3n8jN++itiWFmsQR9VNhsc55I6nYQ7i968yl9GZtrBB38VI6xbBPY6cOdKiFX7LD8BifMNEskqOxBCY8j7alC5+o8WsctgIvP3Guspe2SuNbZxdZbQ4+FDwj9m0oouIV8yovQWZJMOwKVTM5YpmN3xnrGc5KIvyuvgbXFqBiX3tpKnCjIGuPIxI9WHOAmMVqBwStxV6ojxKQY/QNjP4lqT6BYsaL+GgILkggtIY2d4/UfAkaygW62+FCn+m2HqsiWNoXeErdOxS5T46vn0wizJlEvY2rpKhKD9iU67DLbdmex80pEWWF6QIuLN9QzMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aklm36rMuc2xY/DtPT0cGgFCDJ3YGDAxYOCeWgrIng8=;
 b=xNdwUTKi1bazW8kdfnQoj7rAsNLzsK68ImboIgUE2SGA4nNgeWxabGFThvPaYoZEgGQlwz7E2BSs0tKaymhJ8iTDF0kVI494IHddkreDOUVB07L3hVhKW/f0JE3ot9VxGDwPf+2A4w7UGrR9xKNPyTw31Oz51e2hFdVmmPIun5+A1bNpTw0JB1Sp/ndc5ch3Mib5vmqM3Sm3v3Guuw2gKTBRNS1aVRYB6gbXPxBpnnZgEZ6FCrO1fk3zM5z9wif/If2tg0v2hIfvxs0LaF7n5G4USksL+VGbX655xZp6283E6Jtxeo/+q/l3YXsFTq3l7fhlHcUFENBW1cANO61slA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aklm36rMuc2xY/DtPT0cGgFCDJ3YGDAxYOCeWgrIng8=;
 b=asylf9eoVAwtf50FYs7/lIBuJiTQBLSJhe1AXIcWesKtwSDH2nJ4G8dquXKDH8uw8nurAz+z0b7iwxEwEXQEu5c3xHaCT03O1nrATdhRnqEC5MbS3cWBS6oSUmlZYsHfIVIC5uaWpFa5IvfCV7l4lX6lp2P5navZ9WSh5qUWnPS8kK1yfO5TRgPKsZJBg2Cz8s7yqDtmrdewey7uafREHijv7fRe85JsSsHYwgHOUUIMAc7lAu6WIuPBBZwoZcGzX2tagF3MdTHFysC0jiNw0Me7CvOtIhesqsMahownqTfWJ5jQfwZueBspXptMkuAf2OyoOzxEoF/9mJsBdJyNtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Thu, 27 Feb
 2025 23:07:01 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%5]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 23:07:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 15:06:58 -0800
Message-Id: <D83LT2GGLT92.FJ3H552P6H7@nvidia.com>
Cc: "Greg KH" <gregkh@linuxfoundation.org>, "Jason Gunthorpe"
 <jgg@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Gary
 Guo" <gary@garyguo.net>, "Joel Fernandes" <joel@joelfernandes.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Ben Skeggs" <bskeggs@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <paulmck@kernel.org>
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
From: "John Hubbard" <jhubbard@nvidia.com>
To: "Dave Airlie" <airlied@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <2f062199-8d69-48a2-baa6-abb755479a16@nvidia.com>
 <Z73rP4secPlUMIoS@cassiopeiae> <20250225210228.GA1801922@joelnvbox>
 <20250225225756.GA4959@nvidia.com> <Z75WKSRlUVEqpysJ@cassiopeiae>
 <20250226004916.GB4959@nvidia.com> <Z75riltJo0WvOsS5@cassiopeiae>
 <20250226172120.GD28425@nvidia.com> <Z7-IHgcVVS8XBurW@cassiopeiae>
 <20250226234730.GC39591@nvidia.com> <2025022644-fleshed-petite-a944@gregkh>
 <D82UB3V6NZ55.3OEPPW2W8MFZV@nvidia.com>
 <CAPM=9txrRFOb6Uzm=e0S6Tfxmskm4zwAZgsWnkvCzxN=XCZ6Vw@mail.gmail.com>
In-Reply-To: <CAPM=9txrRFOb6Uzm=e0S6Tfxmskm4zwAZgsWnkvCzxN=XCZ6Vw@mail.gmail.com>
X-ClientProxiedBy: BYAPR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::45) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: cfec91ab-675c-444e-342a-08dd5783712b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MS9uQkRRRzV5ZWp3Y3hIQVM5ZXFiMTF4THl2MnA1YVpOejRNYVYvbjVVdVl5?=
 =?utf-8?B?TnhvUDhOVHdKL2plNEh4Q1NnT1ZpdlZBcFd1K0NIeUE5ZEpqSzR5cThTRTRS?=
 =?utf-8?B?UkZFSXk2UUswcEJVVlRBSFRwV1diRGw4MTNCQnVQWlRNMVRCaExCWkFuak5B?=
 =?utf-8?B?L2dhSU50U3lvdVNWOC9NTmdjbGJOYkhLdkxhWnVmM0xTODJHaE1ZR00rNUo2?=
 =?utf-8?B?WmpwMzF4N2ZXZjZOV2dPN29yZThQRi9ydkR4TTNzeEdJR0NFRjVVc3U5Ukhh?=
 =?utf-8?B?eG5Ucks0REdyNHg5MWt3OWRUeE9aelUraytYMXpGVnZ3Um5OcEZHcld4UjB6?=
 =?utf-8?B?NFRjY2pUYVVvZGNTUHJUY1ZFQlFXTlRSUllJL3N5NThEaGFEbG1BR0t1MXBZ?=
 =?utf-8?B?LzM0bFUzOE92TTZzdHptOUNMNktoVHBLY0RPNCtPdmIzODZkcVZlVjUzdjQv?=
 =?utf-8?B?MUJ5bnJ3dmRvc1JMSlk3ZTkzclU2Ykg4VmFSNjhYNGZLSlRYZXpqc1dTV1Zp?=
 =?utf-8?B?SUZURkdnMFhUVTEySHBHaGw3SzJrdi9zTDRhV2pJRll3eW1UMHBmR2U1b1ls?=
 =?utf-8?B?djZQc1U3TmlNaEoyUGNRUVd4RmhaY2ZwZnJMalFBcDVMRnFUZit4N2hmbHU2?=
 =?utf-8?B?d0JlenhqVGR0VXNvUHBZWU12ZThWUVVVM2RTc1RHL0JLNmNUWkJXSnVlNmo4?=
 =?utf-8?B?eXZrY2FwSHlWR01zRCtiOUNCTytHSEZSYW1NcjBMNU9IQVpGbVZ0Y1FvRHJB?=
 =?utf-8?B?dTV3NytjMTkxay9OeW1UWjVoTFlVN1daKzcrQUV6OXB3bmk0V2FsU0FsZEdr?=
 =?utf-8?B?M3ExUW11T2NtYjNNK0hLU2Z1NzY0S3FwUnRZL2NXd0UySnNWQ0tBb2k0aXR0?=
 =?utf-8?B?RnpjZlpGK0R6djQ2QTduY2xYbThUMm1CVDZqNnBCMGZaZmwwWWRhNkx3WCtv?=
 =?utf-8?B?NHVraWxsb280VG5hRFdRdm8xdjFMY2RmN3VoTndtNDhmZmpNdmp5NnRLdWY4?=
 =?utf-8?B?clJZTy9ndUFiV2xnMDU4RTRRTUw0OXVhTXlaODNvVEozMG90dDZEcFVVVmgy?=
 =?utf-8?B?WEt0ZGVzd0h6RnVYbGltOG1CbXhCb3YrYUthWUdHaHgvcFlpMFRZWmFPSVlt?=
 =?utf-8?B?NDlybUpLQzBzNlVsN0JxdFBWL0puTGNsVGhZRzZuRzhVUmpTcTkrZUxvUmRw?=
 =?utf-8?B?N0kwbUFJcEJEaTM2bmxyZkZSTTdQZFFTSW1JcmRrdEl0bVVYTXphNlIvMHRK?=
 =?utf-8?B?S2p5ek1ad1lzalV4VmFDOFkrZjEyK2dUUWcvTmI3OHo1UFZ0WTFrZ1pobzd2?=
 =?utf-8?B?OWdodUJFZ2c4bE43eFFVaTF4THoxTlp4MktWMlI4aFZ6dWowZTZpd3NkeDh3?=
 =?utf-8?B?MEFnQUFpbWtOUmR6bjh2d3BMcU05TWR5Yjc2cHZGcm5Od3JLcnRZWURQVVJD?=
 =?utf-8?B?MFpWWG1zYUFuMUJZRmd1YTNwamJUUkdXMGNZWFZrMjhpL09rVlR6VXRIN1VG?=
 =?utf-8?B?UkZYdjNpazZqT1BkVTRUMU9UdTVEUHQxckhGSGpsQXNVa3FUaVFiQjRoQUZ2?=
 =?utf-8?B?Yk02c0I5NnpVRlhlT1lWRG9QRG1aV2RsaHh2L200VURETWcyVzVIN1JuY0h2?=
 =?utf-8?B?YzVvQ016UDZHTmxsbit2NjJ0WVFzOERvNmZxdFBRLzYxbW5zUmJxbmZlMlNX?=
 =?utf-8?B?RjB2TFFQMVg2cXdXbkxOQm11YUt1VkY3dENUcDV3NmNtNUZQWkJyQ0g2dlhB?=
 =?utf-8?B?RFIxaEhOSFlNV2NVZ3h3N2ZCWGlsOGlsdDlYQjVRTU5oNmZibk9GRktlNlVH?=
 =?utf-8?B?SHVNc2pnOG1QSXh5SmdxaWlRVDVqelRWNHgwSWZKQmxXbUtiUy9wcUNIeVNz?=
 =?utf-8?Q?/g31+dSuT5sTo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjVIV29GVGZXNHZEM0tRcmlXNU1JTURmbi9acm1ZbmpISkh5MnZXNDlJRjhM?=
 =?utf-8?B?NGxqeGVtWG15V0Z2eGhGSUdEeFJBbnNCVSt2WFFlR3dFeVNyRFhFVlFMSzBD?=
 =?utf-8?B?V2VuUjJQV2N3NWd5VHJaOG5ibHNmOWVjVGt2WmVma0xDdENqdW1tWDN4bXRq?=
 =?utf-8?B?TFA3VnpzNllmV0lMNkVDVmxJQXFsdUo3VllXKzkrVmUwaEF3UGN2VDhwd3Bh?=
 =?utf-8?B?MjlLRnNodUk3bHNrYkZlVmpCWVlocy9UZkowWU9qVHcwOEZrTkd0UXJWc2Q3?=
 =?utf-8?B?QUVmY2xROThYTW1nN283UFdoZEUzMis0TXVEbDVLZXBkS2ZpekJadGxCd2Nq?=
 =?utf-8?B?VkZuVENHZytKM0sxeDl2a2FUWk8rUXZCVnZ4NC81bEUrYmRHS0pSRC9lRTJT?=
 =?utf-8?B?cU81WWVVc0tEeWlaY3NsMEdHNEttT3l1R2plbEloWkYvVEhyYUNoWEc3cCtP?=
 =?utf-8?B?ZEwwV1MydVdRT3ErajlQZHJ5dnJrb2JUa2hWTDVTQXJLY2owb3BCSGtsS0ZS?=
 =?utf-8?B?QW5GNXFBMjZZaUJVUDBOQU5ZLzQ0bEE1dE9MVDl0OVR0Y3V5TDNLM2ZwREt6?=
 =?utf-8?B?K1VrNUw1RGxGVUVoZ0hnUXRKTVMrb2YyMUNBYlRjc3hzdnBKSkxzOGgvK1VK?=
 =?utf-8?B?Y0hqMmc5WW9KRHBTVjE2MFNXdmw4aXFEVUlLWUt4cmpNenBZMEtKc0htWjlz?=
 =?utf-8?B?YkdBSHE1L2ZtRytHUWFJSGI5ZnlOU1A4WFpJVk4zMWd2V0k5TEYrMC9MM0xH?=
 =?utf-8?B?SExCMitwQXZqbUJNMXk2RmlTYU80dy9Fb1ZrQjZSNXY4amxvc0lkME1scUx5?=
 =?utf-8?B?ZFV6T3JFZFV0WUtRNDFrTWhnNDJETVBYQnljN1AvM1JlRzdKcWsyUFFCUzZQ?=
 =?utf-8?B?eEdTQU9keHM5VnRJeDNnM0cwN2kwUHhMVS9oOEJTQkxIaCtNeWRrTUxJbXAy?=
 =?utf-8?B?REROcm0wanNhek1iNkE4WXkzaDBXa1hBUlEwTE1UMDhSU3NLeCsxSm5IdGNC?=
 =?utf-8?B?am1XNlVWVXYyRTd3YXVtQm5NUTlWQkt2ek1kdUk4NGhjWi8rSUMyUXBkVVJY?=
 =?utf-8?B?MVZvL1RqNko2UVROTk5SU0hFZTA4b0FGOEhxQ3ptSXdWRWhLbXVXeEZpOTJW?=
 =?utf-8?B?cklIdUd1YjM0WVBuT0ZqYm9CZzJQb1FXaG1ra2xwcjloY0hHS25laENmVVQy?=
 =?utf-8?B?WG9QbE9BTWZiODJXZmlna1FMWW9jaGViTXdKUlY3TnYyNXBwcGhLQTNNejBr?=
 =?utf-8?B?azRUY2NWUHhKakVadm1TaTFnV2tzWnM1VFpBeGxhZG9MRTExemZPcnp1VGFZ?=
 =?utf-8?B?eVBFSXpXaEJCWm4ySWxYdXNsOUZKRjlzTm41Z1VYY1BJck5wc2RqMXpEbS9a?=
 =?utf-8?B?THVNSHQ0amh0TnJrWjF6bkZmbHpkNDg2YytjMWFlNW9vWTEvcVBQMXd6d1Yr?=
 =?utf-8?B?WUtIYjVwZFhZYXg1ak53V280UTJSK3FEN3g0eTEyYzN4MThHRU02MlBOZVBI?=
 =?utf-8?B?OVJ2SEMyZEtCUUk2blprOTZjWGJ2ejF5eUpZS0lNbHo5dkRZa0drR1BKZTJv?=
 =?utf-8?B?YVBycEszeFpsRkptdlN6cVk5VzJhaFh3WmhiaU5CRHdDRis5bERCWTlXQVlW?=
 =?utf-8?B?Z1NYdmJnaXZZSFZlMEI0NkNSOU9XZm9uWEkxdkd2NTR4NEdqa01teEQrMlIy?=
 =?utf-8?B?TFF2QkU4ZGYxdWlZQmZ3dGFWSDdjV2QyTjE3OGxwVHdmalpsSTF4NnVmaGdY?=
 =?utf-8?B?dGNkTUVSK01UK2VMMUVkbkMrYXBmUU0reS9yTThXcG5XN0hEQ2dyM1ZCYm4y?=
 =?utf-8?B?eXlaYWwxSys0d1BYZWx5RDFhZjl3NkRjMEE3WnA4TG5jVTdsMnBac00zRDBP?=
 =?utf-8?B?RitCQVZDWnd4NkxPL0ZOWTFFQVI4QUZNeFA2Y1ZEWUNObUVTaTJVdHlRcDUz?=
 =?utf-8?B?eG9qYTA3QVFwNitlRld5RjJRYlVUUkxtYUNOUGlwc0lKRjZsZUl5UTJwQlFr?=
 =?utf-8?B?Qkt6Sm5KZ3Y4ZUFuSkh1cDIyMnRETVY0T1E1Y20wcytRTDR2ckx1Kzlzam9j?=
 =?utf-8?B?dzBGbWJGaHVrNDBVQi8vNTFRb21oK3pwOFAvWG1FRDJaLzNGRHdlWTQvcjg3?=
 =?utf-8?Q?iuObLOHh1bLIHf5A93X7J2uFp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfec91ab-675c-444e-342a-08dd5783712b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 23:07:00.9188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TsuGtwwGuzbXIcWXbH7sG0n18wbx8NQxe0i7X/EkQdpIZgY3UG5zK7SXDZ50Qxix9BJ+V+fhBZHpNYVSoMSbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762

On Thu Feb 27, 2025 at 1:42 PM PST, Dave Airlie wrote:
> On Thu, 27 Feb 2025 at 11:34, John Hubbard <jhubbard@nvidia.com> wrote:
>> On Wed Feb 26, 2025 at 5:02 PM PST, Greg KH wrote:
>> > On Wed, Feb 26, 2025 at 07:47:30PM -0400, Jason Gunthorpe wrote:
...
> nova is just a drm driver, it's not a rewrite of the drm subsystem,
> that sort of effort would entail a much larger commitment.

Maybe at this point in the discussion it would help to discern between
nova-core and nova-drm:

    drivers/gpu/nova-core/ (under discussion here)
    drivers/gpu/drm/nova/ (Future)

...keeping in mind that nova-core will be used by other, non-DRM things,
notably VFIO.

>
> DRM has reasons for doing what drm does, that is a separate discussion
> of how a rust driver fits into the DRM. The rust code has to conform
> to the C expectations for the subsystems they are fitting into.
>
> The drm has spent years moving things to devm/drmm type constructs,
> adding hotplug with the unplug mechanisms, but it's a long journey and
> certainly not something nova would want to wait to reconstruct from
> scratch.

ack.

thanks,
John Hubbard



