Return-Path: <linux-kernel+bounces-569819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FE7A6A7DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F2F485793
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525FB223709;
	Thu, 20 Mar 2025 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gcwFm6sz"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A491A287E;
	Thu, 20 Mar 2025 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479344; cv=fail; b=CembV27uTDqmv0OMPaB3JjTtDi8LX0sgwApYNt0Zrkt6r+Sz2peB/jROOojYqxwTA+rUyEsO9GBVteKT4Hg2/gjb76Rd0YjBaVlV3UZvt0WfED6ooNTx7NeCROOW+MvPmYq5fiMaKulC/5qaOgB6cQh9nMV7p6vx09zrFwvm9OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479344; c=relaxed/simple;
	bh=HR556CLHbzWo4gytLixDt+7aHnU2Y1c5YbWNmVSap8w=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=DFE2G90MlXW1jidXKpz4bm3hY6MhzZzKSHBdIEw75WqQcGbOkEJmfKF+4WBRGnLFQrKhbVba9U6fR0GwVyBM+OiY60vnYn+hCRWPtgZhUO6iVETfUwy2uD8TTrZLmUPzCq2zebAB1AgEalwuOO9fqFc+IaYwQnt+3rqL3fCUQLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gcwFm6sz; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHfQFaJA7Wy37PkJ692JQ2WUVkHF5n0769X1jZni92NdnoWhvc5LE0b522IZLgWDrLGU93pRnRsOBYPDE5CzC0zBjSvx6A6MrOt0IZFnSkJAvAG7Gb5rYpOx2RVmQ2HXck1fNx+jFbUzsZM/Nk2WhzgFjHtVi68C/cGXnmwEqV1zvMI5zfN0lR6NiIjGEO+QSId3ZLtFc8yw7uTe2Yw/WdJRFdKye2GbBqkxnUFtcbXy+vhZGTVLHJh+lTYnGnGf1Quk452iHX5252BOasZaYiPL5KRatbLNw36OCJYUvYVxC6SFd2dHP3bcuStPynQQpE8SBAYbATiC4dXcyzcaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HR556CLHbzWo4gytLixDt+7aHnU2Y1c5YbWNmVSap8w=;
 b=F9cOvsueGQotmUGjC0BuKsDVW89QHPQh+PVXPEmUxQ4Ps49BfV4Tcyz5/1s74U/tWd/5CK3bGXxMyrRzo6qGb68kXHxVhDzpvvBOETbcSz3clcW0tTWpdFjCAsrxyRzWuTYOVXqi5Bp77Wkx1i140318L+rt7i4lcGZ36p5v1LfqU9Fu1Q4K8qKS8JAU/FaINLwGC83DCUyMnwHD6Km41c2qtcOiD9nWRDtoMxCkSjdGzBCX5LV0cCLRPt7pPU31owmUHlaywxisrhF8svL5L9++RUjyrEoqSUdiGJa9hNGO2k7EOfIMeL6ETAReKSry/udOllHHczLxgYIdrMnoyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HR556CLHbzWo4gytLixDt+7aHnU2Y1c5YbWNmVSap8w=;
 b=gcwFm6sz1HHBTO4cYyIIg0Sf9+f2ThsIUGIjxdeJcfdlESiOwAD4YC67tyZEHZ95dwyIxNBkhbnqVDKho7tjPM1xgsTIwgSKH0vXueAw5adar+vWoLqMuwIzbxarnkgiAEMXg3S9BJrJjkHWgAuYxghFgxZRnQ9Zkecz0IR7nYie/kCukdSEQDpe4DG8JjyqwdPrbohzHaMjrFtAHpSohIyJuEU1tUkXuKEQsf7u0fJ5gx5JSL+w2gwR9f+9xIjRfLqRWA661EJG24I44BsS204P3RUuTtSCQ8oiMhptVgmP1st7VmJ51mR17dN/zdahEz+3Zifz89d4UeT9xwQnrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 14:02:19 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 14:02:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Mar 2025 23:02:10 +0900
Message-Id: <D8L5DDS82E64.37ZBEA441AMJS@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Fiona Behrens" <me@kloenk.dev>
Subject: Re: [PATCH v4] rust: kernel: add support for bits/genmask macros
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250318-topic-panthor-rs-genmask-v4-1-35004fca6ac5@collabora.com> <D8KB8CPBOIY1.10ATK35TV2X79@nvidia.com> <BC968EEF-03CD-49A2-818D-08789791E461@collabora.com>
In-Reply-To: <BC968EEF-03CD-49A2-818D-08789791E461@collabora.com>
X-ClientProxiedBy: TYCP286CA0245.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: c48c00c6-4e48-4519-5247-08dd67b7d0c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnhyaG5wUGJpM05TQS9LMkFTa2RYWG1MaFhuMXdUWUNldllCT09QelN0Unla?=
 =?utf-8?B?dnpBOWpHcEVSVHRsU1Q4L0JScEpIckZzTE9WeGJKT0tjM3FYRHJ2YTN1WDdH?=
 =?utf-8?B?Q3R0aVNSTmRiQjA5WGRMaS9ha1dpb0lOcWN5UUpJcGFqKzZmUnZpTVVGUjBi?=
 =?utf-8?B?bnRIQnFKR0ZVREh0NlZaZXF6azd6YVczZzV1Y25QMUdtMVhBZlFUVmw2Kzda?=
 =?utf-8?B?SWluYTJyWWxxcDlzZkU2TWhpaUZESFI1Nkw0Vk96akgzaGlkQWNNaEJiUzQ2?=
 =?utf-8?B?YlBpWm16SzZmNGc3S2ZuMlhHRzFQcUtEMm1GRXlmQlhaVG5LaW9zdDFESXFn?=
 =?utf-8?B?VjNLbVFYdjZwY2NaNG9tNzFHS2dvQ01RM1lUMGVBdWNyTmNpT2NuSk5uSEIy?=
 =?utf-8?B?SnllS2hpUTc4dVhkdFppKzFUU2ptcDVRaUZYZ2dIYmpVZitlRXFSanNiVEwv?=
 =?utf-8?B?THhNMC9yTncwTnA2a3M4eTZaNXFpZjJ6aFFsYUFzeWQ0bDA2YVVZaEZmbUVx?=
 =?utf-8?B?azE5bmhGSXMyTkFZZ04rM2dxRHpGdE1YaDNHNFRlMUlDQ1ZoUnlEZFpUVXBF?=
 =?utf-8?B?WGdkL3RKaVlTQnNDMldiRkM5V0MxNTRmNllHT2FuSU5pa3BqemNtZW9STGp0?=
 =?utf-8?B?cXkrb0FPWXVERGt6NEFMM1k4aUZnbWNsZ1NBMm5DY3R5Vy8wNW5nSkM4eWZs?=
 =?utf-8?B?NmdlQVZUcDNRZForMU5pdVNYampFNGVMTTRHNWUvTkNZdEp1cXN2TVBNemky?=
 =?utf-8?B?S0I1WWZ6RWlQK2JJb01GZW9kWEVTS29XQ0VvTTBDeDh3OThsQ2dNV1J6YWZZ?=
 =?utf-8?B?ZjFhY0NCWVdxRjZjN2lXUmNUU2JzcXBpQ1Fnd2lDZHU5ekN3NVlZTTdTeTVy?=
 =?utf-8?B?L0dhZlJqWXB1anBTZGU5R0NPY3pkM2l5cHR6QVFRYVdTRTYvd2xDWCtTMng4?=
 =?utf-8?B?LzNSd1JKUTYrNEhnSFNHVmNUak0yeXpiQld4aWFOS25jQjVLb2dZL2tJVWlU?=
 =?utf-8?B?ZXJsbjdxenJQNmNzZllWbFFrbmd1MGdXNWlsREhZNzhGdTFpWldkZTdrb3NP?=
 =?utf-8?B?U3FBb0lROFpmd25LMWxBZ3VidHBJdjZuL1JjdFZzSm5rN014a3RSZkZ4YWpy?=
 =?utf-8?B?aEx5ZHMyY09Qb0s4bzgyUmdrbCs4ZkhrbC9wR0ltZU1OWUw2S21kMHRHNncz?=
 =?utf-8?B?WlJ4MHI5WWhRYnFNbWYwSHZueGoyeGJEM0N6a0l0eC81NzdkdzlsSlh5d1dZ?=
 =?utf-8?B?am55NytXelRDc1BJTTNjcGVhaEltcWZ3blQrWm9pRnNsazNwazl6Q0FaNFMv?=
 =?utf-8?B?dUVod0R4ekZKR04vUmtkc01ISktoTjB3dG4zdG1yWjlERlFVQzB4dWtiWHl5?=
 =?utf-8?B?Ny9DaER0bWE3aWU0VFVva0pzNFJvVkcxKzgxdEh3S0h3S1UwcWxkY2RyYUh3?=
 =?utf-8?B?TWE1V1FaU0NOTTFPU0xVbWc5NXBvSzUvR0FFdHBENnIrYmIvSFJJclNpbXdI?=
 =?utf-8?B?aE82VmFhVnRGSUgrREZUbWRQZExOOWl0SmVTQTQvMTFHU2lzeXNSa2pIRXh6?=
 =?utf-8?B?K0RCWFNQWjFWUXpzSU1SdTljbWMvMERyZ2twaUhqazVnMjdzeXljNyt6a3Vu?=
 =?utf-8?B?QlRuWWh2NTZGN29oNEVnSDVDbkJTdmo3cDNjc2d5aFJKVklCWWRkVGVlMlVH?=
 =?utf-8?B?dnZiVTRJczhWem1DazdNeit3bGR5K0FLRXpnN0dIaXhON1Y1S2RkQWQ4OS82?=
 =?utf-8?B?UTRHaXYzZzNycTFXdVlIVXBMZFcrR0JwYmF5YzI5ZWxyVWpKMHBScUM5QTM3?=
 =?utf-8?B?SzhXYWpaK3BRUTEyeUdLMHEreU9VK2tlcmZTNkpFdEhva2ppYUhVTFZXbUhm?=
 =?utf-8?Q?uG8OarRUqZuyu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFYrNVVaUjZXalZoTGVkMnJpb29rckFvT3d5ZUJKMHU5NmFDRitnQVd3eWxr?=
 =?utf-8?B?NU9HaGh5ekRQRnc2ZkFrbTRaWmI1TGpjd0pxWDJjc0JRSDMyUWRXR3pUSnRo?=
 =?utf-8?B?Z1hWbUk1S01IZ0tnRUQ1c0dOSVl2U3h0cjdmZVlJR0I0QUVkbEFYalNTWVFa?=
 =?utf-8?B?S2ZYVDc1eTF2bTBHQmZPTDBPdVA5LzBNYUdVVEdMYnhRd0RaYkorQllCNUJX?=
 =?utf-8?B?VXAzLy94ZHRpSi8xQ2MrSUVIVEdZMDdUbVJ5WVdxNVdMZVVuOXhGdC93c3ZI?=
 =?utf-8?B?UGtMRmNteGxHbWtWbEZOWnNMd3RMZUlvamh4N0JXK0xYaTVsem9ZZEJZcEdw?=
 =?utf-8?B?ZDQvT1V6VHBpT1k3dk1vcVRXVlFwemxiOFg0MTMvY2hiS1ptcmo1L0p3TnVj?=
 =?utf-8?B?ZENFeWNYb2Uvc01yWTZlWTJpRHpFOXRwbVpZY1NTTWo4WnVoSmVla21oK2p4?=
 =?utf-8?B?eTJra2ZmS2IweUdmeURlNjN1Z1RrNXhoWXlzWkkvUS85M1JPUmt0TEpNSis3?=
 =?utf-8?B?VENuSGQzcTZlZE1IN3dIdmZoc2NVckJRRmRGZEpZUUx3cERlZjFNYmgrRG1H?=
 =?utf-8?B?N2orOEt6ZkFOOWwvSzA1Yk9GWmIvMGVaN085Q3B5OUxteTFUTTB4czJheXM3?=
 =?utf-8?B?UllxV0s3b2hTRktGQkdNQ0RvWWxoYUZpbnJNM25vTC9nVFlYSklCZitZZC8w?=
 =?utf-8?B?bEl6YkppUEhkVlRZeEVMOGFOQXlzbVdtZVRySm1WNVRFZ3RoZVlMY3V6TTk2?=
 =?utf-8?B?eHdSTHBQZStSZDlnakZPb1ZSbDdVa244R0d2YktTc2tuRStRZTBOMStEcnBj?=
 =?utf-8?B?VjI3MkQyWGpNR2JUVE8rL3NOUUpYVzZUMmQzUkt6Nzh1TUhuM1F5UEhNV1JC?=
 =?utf-8?B?dW5EYkIwRStsY2ZXSzlMZlRHQlE1cXdaM0ZleDY2Y1pUMlU5a0EzNnFrV0ZV?=
 =?utf-8?B?THA5Qit2MElyeEJsbUZvMm5CYkRWWEIxczVpWWlPWkxkb0Q5aFAxeVYya3RF?=
 =?utf-8?B?VkdnNVROaFRJeHk4Mmgrb1REQTJCTGRPM3dld1M0UEpqVnBpRFM2RDMra0o0?=
 =?utf-8?B?RkNzY0ozUEVrSzlyQUZGTmsxcE5XNTJuMDZhb09yRWFpS3F5c3pDTERienF1?=
 =?utf-8?B?OFVSb1pES0ZjcmxialMvVVpIdmQ5OFRjRXlXYlAycWhKUVhMZU1DeDU2bHdj?=
 =?utf-8?B?WTRHd1VUbC9qOGRlZ2xxdmJsT0s2VFhKYUIwUGo0Wk93dkpWQS9teWdOaWJ0?=
 =?utf-8?B?cTNqVmhSMVJKVnMrVWd5MjBjNWxZYW9xL1ZKNVNSU2hGMHZ3bXN1ZGNTRnNB?=
 =?utf-8?B?NVJkWUhCWWgyWGMvQ3VrZENGZFg4cGtGT0lOYkp4blpwYnpya2tFNFYwUVNJ?=
 =?utf-8?B?K2FWWmV0MDNKdkdYSGwrMXNLUThac0VwWU9GUXdBaE13VDJOcjZwUS9IbU82?=
 =?utf-8?B?bmZHaFZjeW53TFNpeDlJVlJVWHQxYlhpWDB2Q0MyYktiUnc3bVJWa2pEN25X?=
 =?utf-8?B?M1FVRUw5NHhBQnllRTRtRThNbDZWRndCSENtV245RitIZkJSYWFRMTR5dVlG?=
 =?utf-8?B?RktVeU4rQ1Vpb0lIYXhtWVROYVdocVRJM1h3N0JiV2ZON0VFbTZaQTYrYVk5?=
 =?utf-8?B?ZFluM2FGSUczL0s0ckxXYWg1Vi84YVV6bFNnZUdVbUFjdmZoTGxPK0RkMFpk?=
 =?utf-8?B?SkpyVmVvZUNUTWZhMnRQMVdFOStJaGtOYnhrZWIyN3FXc0RPR2lKbFZXUDNF?=
 =?utf-8?B?b2RHN3lqKzBmc0ZkeSs2VFZVWHNuMm1JWTdqWmE0cDFtNFpTbCs5RWw4MUs0?=
 =?utf-8?B?Rm9rV2hsL3lRQlZvenArbVUvYitPWCtsMVkrKzUweUtWTFhDUTVIcG12QlN6?=
 =?utf-8?B?UXlxNGZTalJzYVMzNzZURFd6anlCVC9objBNckg1TmZPWWRmNlFsbkYvMkZI?=
 =?utf-8?B?amREZHhKNGhBYmlNYTRZaGJNSGVtQzdMcnFMckJBZ3J2SkJLRGYrbjNOd3hD?=
 =?utf-8?B?b3pJNHMraElBOXhXelBJOTVVYkl1QjlXbFBabDEzcmhTcnUwVGhSNGVKV3Zu?=
 =?utf-8?B?a1NSUkRyeFlzVStUQzViM2FlYmN5eURHNWd0MG5EdGc4aUtDYnNVN0FvV0kx?=
 =?utf-8?B?Y0FsclNqb0cvUThiTUlWcXpteC9sTkNBVERETTN4TGhOMFVQMUJoZzR3U0lF?=
 =?utf-8?Q?InVTpxx6VCbg75HzH4peCxoErqmRt/O90XOc1dvjGGJx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48c00c6-4e48-4519-5247-08dd67b7d0c7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 14:02:13.7520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEHjqGKa+xuH/kBDUQBzsKhTRn67B2UaLjgpB/zuc4ZpkLHAnBklqP367WCDh5Wll2WyTwgIqE8L4INLaOYgLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936

On Thu Mar 20, 2025 at 10:50 PM JST, Daniel Almeida wrote:
> Hi Alex,
>
>> Would it make sense to also have u16 and u8 variants? I guess one can
>> always use genmask_u32 and then cast to the desired type though.
>
> There=E2=80=99s no u16 and u8 variants because I did not think there woul=
d be users.=20
>
> I can add them otherwise, IMHO we should refrain from using casts when po=
ssible.

The plan with the register definition macros is to also support 16-bit
and 8-bit registers, in this case it would be useful to have these as
well.

Since the body of these functions is roughly the same, maybe you can use
a macro to define all the variants?


