Return-Path: <linux-kernel+bounces-559740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A56A5F8EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066723B674D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE0126869E;
	Thu, 13 Mar 2025 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fna3KOAT"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629D0267731;
	Thu, 13 Mar 2025 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877318; cv=fail; b=S9qTt7fHR0sLFlNmnbRiwX5NNCLhUopMdtYFxmd7neOhZyJceiZXAsQqv6Th59OOWbgiUjmdqN5E4NQyarQZLNvcek1mlfcedlvCAYQZNk38mJovaK2scQWhMGEPiihl+1gPaFNY1Kc+PGODDOfaSbHw8CcS16IKRTeGLK5gYCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877318; c=relaxed/simple;
	bh=1+j5QqX3VxR9+oKSdttCQ43irLdYdvsgx8RQA5l8/Ts=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=AmNdkqnQUcegNJVSVMXXRWnwUQNTLaSVdnYszz2pzF37d8FK5pNwMEhahxKSd3Jus3AFN+Vcc4M0mDPvXyJMZPlAOYQxfQ3zuquV5DbWXL2+qESfSundOe7ZJV4wjprzvMFpgmMCyi+QDkszxFbhqVRzILYnssNwj+DtsHQmnyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fna3KOAT; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8s9BVvGAyjU8J4ZbatXKyW6pCkPy1pRd+ueNsAC2EVDi5DaMF3WRv0HDCpapxO70TAZRHsyrJSEDi8W6SMBQfZErbVxoDVyUM94I8EK2C1M2s+HIN+G3FDeifZbj0EPAOjQk4N5TT2igJMKX61S9WbdZ0NQRkmRQ9NVINRuLUojfwHGW0+uMvtVlUborMywRqXRbPkb29IcznHQQOomrgPigiiTH5qpRjHvlpm29HyZ1R7rKIhw3oIg+VEFWQbLXyniu92AkqgXaDE4AKsCkmMR8GgUuwE//D+sZE5DXZLHUjxEGEi+F/DBH/i+3PEeIxRlhAGY/y5pFtALTN4ssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCh6GKjGmZ/SVveGEnnrEXwk9AYaR/XECAzPWdYw4ZY=;
 b=XqZA4rgV+h50Uf9WjNHsTIY+D4wULq/9r7DPj6f1EA7Cp/ftAxBwvKC9mMZLiiLnQCBrTgKsa7ip5K2ZqSFOQLO6u9NR5zWlcioA2C4UujkIX6JiApi5TBYu4WwLsPOWaa3hau9nxCl15CDxdQ1yopRGQTszUuVaIIN6wDoLSNQCBiN5k5Aagc0YOyKxnLT29y4pPOQmGwt0LiJe1rps8kcKZw9DhISEF/c9KJDg0gDfzTvfUntwhR2P8EW1bhgg/gKhDIX/bia7Cbq1u+qc6955Pi0HarAWu0gzSLsX6goBb6yAGfWb7EyNdIAWfm9f/QqKmsGNkUBS8arDMw4sKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCh6GKjGmZ/SVveGEnnrEXwk9AYaR/XECAzPWdYw4ZY=;
 b=Fna3KOATXBF8JQbtFGY6UTcKwgzmnJaDLr9EyAGl44f57cJ2y0B0gnB9Wdi7uUaNRupUyQ4mjtErp+P65fDPFLNmaC40RBee+l54CHOeWwmbSw/iTce+npJ2xc4/4e57kEDfIsZataq/GT3hQJV3/KfkCqUHuE9BMe6eu38PZe11UbI79OEaYmLJw+u5IH2NauxNpvwyDZ1LrAhCTIkHPWMRSg1Jo4efVXDKUgd+RUheiqJIRFsIlTeMlc46GwFG5bVxtQYe8dupMD3QJJRvghALCKDZqRt5AKtCpU3eyhvqIDJ1SPAyDUEuf8sByknv69sQCG6xZgsFm50BO4L46A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH1PPF711010B62.namprd12.prod.outlook.com (2603:10b6:61f:fc00::614) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 14:48:32 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 14:48:32 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 13 Mar 2025 23:48:25 +0900
Subject: [PATCH RFC] rust: add macros to define registers layout
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-registers-v1-1-8d498537e8b2@nvidia.com>
X-B4-Tracking: v=1; b=H4sIADjw0mcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0Nj3aLU9MziktSiYl3ztJTkJOMUSyOzJAMloPqCotS0zAqwWdGxtbU
 AHuMk2VsAAAA=
X-Change-ID: 20250313-registers-7fdcb3d926b0
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: TY2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:404:f6::30) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH1PPF711010B62:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b349fe1-20dd-4aa2-48df-08dd623e203c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1podkZoZDFOUTJPdlVnN0o4UU1mWUIweFlsV2YxbVI4STRhVlQwNWhBTjBC?=
 =?utf-8?B?bE5zNFVKajJGaXorNHExNFk5dnVNWENyUmRmR0pGSGU1WXF2M0VHUU9VNWQ0?=
 =?utf-8?B?bzQ1NnRtYjJIdWI4ZXFCd0JNNVBJUG9zUGZvcjJhT0xINElsRVV5eEI0OWhw?=
 =?utf-8?B?c3VhU2NHN29XVHV5ZHkyeTdHK090Y0kwc2U3L1FxbFhaUGp2OGF4TnJMY3BF?=
 =?utf-8?B?OGlZSGFpWWxSYjRsL1llaGl3aWRWSkZUV3RiZnYvNHYwU0k0Zm9xajRVcVdr?=
 =?utf-8?B?V2ZIYVB2dzh5cHBzTlIxWUFIM1ZJWVJuVHVmQzNXd3A3ZG50S2VjbFZBM0hn?=
 =?utf-8?B?K3ZJTG1rQlQ2b3Q3azdzeFFFZ1pXcXVWbjFqZmt5Z1BxN25ycU1GRzhRM1l2?=
 =?utf-8?B?MDI3L1NmQmtUa1k1L3pCbVd6clgzOXJad1VUZ2diVjJMUll5eFJzWjZXdVhN?=
 =?utf-8?B?cjJLS2s1K0xGUFprZEZ5TFhQMFNnRXJZZEhqa0V2SW53K1Zad2tNdHVWKzFQ?=
 =?utf-8?B?YkpQM2c2S0tRTXVqMUxvVDBQd2t1N1FtSzZsSFJWOGdKbTZvays1cUIvSUNF?=
 =?utf-8?B?ZVNQRU9nUHJIWFJkNHlnUFcxeHJ6QStDeitaNjNrdUdSU2QxTHNCN3R2RDRa?=
 =?utf-8?B?WTNOL3poUEFDZ0JMOTFjS2syLzExaVg0czVHTDNtYncySzdJdkhES0FSZlNU?=
 =?utf-8?B?QXlEeEVBVDRVVmFieVdsaEZxZklVT2c4ZHAyWGltVzR5NUZpbGZmOFVDNHB3?=
 =?utf-8?B?aUI1UUxwWnlSdW1aTXZzaGcxMSs0Y2pVSHBHcjlNdzRleWFObk5ESU42TjJt?=
 =?utf-8?B?bjY3a2dHdmpoY1FWazVBcGpXT0J5QWNBS3kwTGxQdS9mNmtJcnMwQys4ajc1?=
 =?utf-8?B?WW9BV2JyYzA5MTlhRUlqY1I1Z2RHZE9KNjBmZVpXV3l5TVBDWUJYQS8yYTdq?=
 =?utf-8?B?eHJ2Um9FbGNJZ2dKTTZIbDlmZVRieWMxUCtOMTZMNU1VeWUzMTJNcXdCZXBX?=
 =?utf-8?B?UGhZV09KYVV6SGxTaHdHMGM3c1RxT3Q1T1d3ZVJVbW8yVVpsNm5rejZsazRD?=
 =?utf-8?B?amF4eGNBWk9LK3dnM3VKSGxsVHBvbllDTGJaY0xka2U3dmdGaHdHdnU3bEhZ?=
 =?utf-8?B?UVpHM0JVcnBiaEVtZU5XZ3J6bnY0Z2MzM2ZMQ2RVdXNYOGMrVDNiYWY5Y3NL?=
 =?utf-8?B?OHdkb1FDSktLN3AzdS95VnNUSEtwRU9Ya1BmQjlOYUdPdnBKOXV6RXRNakZW?=
 =?utf-8?B?dU1VZUlQRGVGdVFDSHVjRVY5dVQrek14V3Y3NmU0bUNKcXR2clBHdk1GZENR?=
 =?utf-8?B?eXVRbEhETHh6QTFWc2NDaU9iU29uMmtGWDRuYnlyZWs0eFRWaDVOSXdBY0N0?=
 =?utf-8?B?RWtoQkEwSXUrS2JTb0tva0llQWZlWCtNNWRIN2o3RG1vQ2wwS3YzWmhFQk1J?=
 =?utf-8?B?YWJhV0hON0IrWWhtc01YVCt1RDZIQWJ3Tk9RSFd5dTl1UnE3KzZvS3F0N3BU?=
 =?utf-8?B?dFp3bGU0RUkza0tlTjRVREVZaXNJUnJ5SEJCMk9LSGNSc2FSNTNHWUJmL2FU?=
 =?utf-8?B?dEI0UDVndWh1UlpSTEVQeFFKdThhMHdmM3RrZnY3T25wT08xYUJaeHo5Nkpj?=
 =?utf-8?B?Y3pZOGpkN2h3NGNnTW0rZVlLTzhTWXNsZTBZZ3NMMUxHV0Y5ZlV6VEF6S1NI?=
 =?utf-8?B?cnQ4NkdaWUJ2TWlkdjhMN0Z6NkxzWTB0ai93eGZPT2lPeXgzQWUyV3dVbkwy?=
 =?utf-8?B?NkxvQVo0T1NsQWxRQ2VuUzdSaytoV2JpS1llb2dwb1JiWlVnck9UQ2N2cFZN?=
 =?utf-8?B?V0hZT2pqWnlON0kwSkFRU1QzeVBiTzRLa0JGdHkyWkY3eHUwUVErRjZvZ1VI?=
 =?utf-8?B?MGcwbERaZ3AydDhqSzdpNkR3Y01GbHhaNGZPcnhtenEvbzZCR20xdWxFRGh4?=
 =?utf-8?Q?/kSWzfxFl1s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEsvSDEzRm9hSE5aNWlEZEdQN0M0U2hETmlmN3pNSjMzaVFJNzRoVDVkeEM1?=
 =?utf-8?B?amd5NVdnS2hncE1rTkRJMVBZMmV2Q3grbUtuOXgrdFRZbDZuS0FkZHJXZGlw?=
 =?utf-8?B?UTlET2ZHemlsbk83MEtsUm4yd3ROTG5jMGJOd3lYMVEwY2UyOGdaZkUxYWMr?=
 =?utf-8?B?Z2JwVTluNDE2RXRQTHZ6OUZxaTUrMGlNcWx2MGpYclhteHdVVHd0TW9qVUtG?=
 =?utf-8?B?UEVzZDZJdTA1QVE4VThXTWdsK3pZbDI1RkdmTERLL3ZlUlNGMUMrN0lvNXFp?=
 =?utf-8?B?NEUwQ2g3dnhETFI1TW9ablZoU3o4dWEvUUI4aDlPYnFycE5JRnFKMkg3UVE2?=
 =?utf-8?B?dzRtTzNYN2xNb0ZtZ3ZxVEt4bE9xbTYvNDZ4QW0xb1c2WjMwMERpVCtDZjB3?=
 =?utf-8?B?U3EyTVV1UVNHUFpqSmY1a1hsZWNBZ2creDQxbEZVc3o4T1VVSTA2WnNFUWVz?=
 =?utf-8?B?YXNCeHVFNmpmWWxGd2hyZko3VnBQMUJKWTA0TnpvdlI3M1hnNGNqODJoYlll?=
 =?utf-8?B?aklqWTByUUJjVmpWc0tlQkRab3d0NW9TaEx3RHBxYithVjEzN2k0U3dKNERm?=
 =?utf-8?B?S0ZUSHF6YWptemNpY29MeG9YUHhYSWVrcVY5QXlrcjFmNzRMaU9kY04xOE1D?=
 =?utf-8?B?UUhheUNGVzB0SS9vVmdWTkxDZ3hROVR3Z0IxZHQxbmZNekl0RzBqTjh2NEdX?=
 =?utf-8?B?YTJ6WjR1dnNjbGVucnNCYUtPUEpiS1NNVFJlVU9taWl2ZUtybEJSeGhlaC9v?=
 =?utf-8?B?eFBCMkIraWRzcVRwYnZQSzNYTmNUVnh1MnpaazNVY01BZFByMzBmdmRUTkh0?=
 =?utf-8?B?Nm5iRVdmM0JvblBzU1FuK0tGY054TDY5RDlBVlF3RzhNZGR0M0tXK1VMSDJH?=
 =?utf-8?B?d1IwNVRWdFFxOGN0eFdscm5oNFg5OEw1YUUvUUhYTUJCUjl6ZVI0S3NjdW5Z?=
 =?utf-8?B?dE1qQWJxMDhuQUxtaFRKTzhaWWxmdWxKenZMQ3RoMkVva20yZFlKamViQm1Z?=
 =?utf-8?B?TVFaV0ZMRTg4WU9ROW01b29KWlpIb3ZOc0FPaTU1dCtEL1IzUUR6Vm9tZGZO?=
 =?utf-8?B?R0dXZGkwT21LWDhiMG8xd09VQ1lmVUR1UnQxcldYVVVZSzM3TWVMQTFwWWtJ?=
 =?utf-8?B?eEdLd0E3NnpyeVByTU05a3JjaENPa1grb3VkZ09YczZ3Tm9nVHhsVkRCSkhj?=
 =?utf-8?B?VHh0TUJyMTU2M2htaG54SXltQ3d4akZYOWRlSytxMWRya0N1TkloNGZqTUpG?=
 =?utf-8?B?WWlhaU5Wb01kbmNmWWxxNXhTRGMvY1lwNTl4d1R3aW50bS9qMUFhd3pYaTd0?=
 =?utf-8?B?S0V2b0hDYlZLL3N4NWtKRUU5UldzZFU4czVTM0txREYyTldTendRb0dGVXMr?=
 =?utf-8?B?aVVzSzB6WHIwc2ZxdGFKTVd1K3dBNDcrRHpHMkxuMmsyVXJjVGRYMWUvUjFX?=
 =?utf-8?B?WEk1b0s3emVqU0E5aW52dTA5SWNweUFZRmxoQW45eE1XUWJMZ3JBb0ZIbjF4?=
 =?utf-8?B?cEgySXRJcll3TXc3cG9wMm5SajB4d3kwcFZJbTExZno1cnF5L2xJUExVdVc2?=
 =?utf-8?B?M05HSW9wL2JNQ0VhRHBJWjBIdnVMVkh3N2xPc0lMTXNSdGZCelYvSnZlZ2l0?=
 =?utf-8?B?STduUTFTTUZDTUFnazRoYjJqNmlQTlNNckFyNmZaaENkRi9Yazh6WmRaVFdZ?=
 =?utf-8?B?T1Z0V1ZZeDRWeHVVdzcyRHlmdGQrZU4weHAxRGQwcnpxcHQzbmZ1S0FXbUdh?=
 =?utf-8?B?MVJyVEJxWWwweS9JS3BkL29OemZLTE1MQWZaSEZXM3QrSy9kUnQwTTJXL3Z1?=
 =?utf-8?B?bzFFWFFFVXNvaVA0TGZCS0RnTFBFUzc2amgrMVBPZ1pQaHgwZjlLRWM3Y3BY?=
 =?utf-8?B?S3VsTXBiSlFXRzZhRHVnSEhHUnRESlFZNDQ5WkxFd2c4TWhkRTNNOUJYd1U1?=
 =?utf-8?B?U003amM1cGVpNHU3aUYvZmlZK2J1L2VBZm1hcXFHNVFPNzFjU05qamlKZmNW?=
 =?utf-8?B?cUVzUzM3bE5zUkdTWmJPVFJIclFxVnBENktXRDVlbzVvaGx1ZEFkUUJhUlgv?=
 =?utf-8?B?WVRqT0ZqQlFtNlhzMGxMTFRDMEg4RUxkcy9UMWFrdHhmSjdzT3hKL1BXZkh5?=
 =?utf-8?B?MHFKNElONUpCREFObVM0YUk1R3V5aDE5cU11NjIzb0xUcjdYYnhneHNNbUNo?=
 =?utf-8?Q?eP0xd4qOuSnHbfX7UhtiGVscFVGW6nT1dFDBavfbieep?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b349fe1-20dd-4aa2-48df-08dd623e203c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:48:32.6036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdQkis0oMJ8rD7J2yzTL4aG8Y1JN6hvSs/B2gNF51H3ThOkDygEO3VijT0hL6fGcEsInESG2B/zME117GnkStQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF711010B62

Add two macros, reg_def!() and reg_def_rel!(), that define a given
register's layout and provide accessors for absolute or relative
offsets, respectively.

The following example (taken from the rustdoc) helps understanding how
they are used:

    reg_def!(Boot0@0x00000100, "Basic revision information about the chip";
        3:0     minor_rev => as u8, "minor revision of the chip";
        7:4     major_rev => as u8, "major revision of the chip";
        28:20   chipset => try_into Chipset, "chipset model"
    );

This defines a `Boot0` type which can be read or written from offset
`0x100` of an `Io` region. It is composed of 3 fields, for instance
`minor_rev` is made of the 4 less significant bits of the register. Each
field can be accessed and modified using helper methods:

    // Read from offset `0x100`.
    let boot0 = Boot0.read(&bar);
    pr_info!("chip revision: {}.{}", boot0.major_rev(), boot0.minor_rev());

    // `Chipset::try_from` will be called with the value of the field and
    // returns an error if the value is invalid.
    let chipset = boot0.chipset()?;

    // Update some fields and write the value back.
    boot0.set_major_rev(3).set_minor_rev(10).write(&bar);

Fields are made accessible using one of the following strategies:

- `as <type>` simply casts the field value to the requested type.
- `as_bit <type>` turns the field into a boolean and calls
  <type>::from()` with the obtained value. To be used with single-bit
  fields.
- `into <type>` calls `<type>::from()` on the value of the field. It is
  expected to handle all the possible values for the bit range selected.
- `try_into <type>` calls `<type>::try_from()` on the value of the field
  and returns its result.

The documentation strings are optional. If present, they will be added
to the type or the field getter and setter methods they are attached to.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
I have written these initially for the nova-core driver, then it has
been suggested that they might be useful outside of it as well, so here
goes.

This is my first serious attempt at writing Rust macros and I am sure
there is a lot that is wrong with them, but I'd like to get early
feedback and see whether this is actually something we want for the
kernel in general.

The following in particular needs to be improved, suggestions are
welcome:

- Inner types other than `u32` need to be supported - this can probably
  just be an extra parameter of the macro.
- The syntax can certainly be improved. I've tried to some with
  something that makes the register layout obvious, while fitting within
  the expectations of the Rust macro parser, but my lack of experience
  certainly shows here.
- We probably need an option to make some fields or whole registers
  read-only.
- The I/O offset and read/write methods should be optional, so the
  layout part can be used for things that are not registers.
- The visibility of the helper macros is a bit of a headache - I haven't
  found a way to completely hide them to the outside, so I have prefixed
  them with `__` for now.
- Formatting - there are some pretty long lines, not sure how to break
  them in an idiomatic way.

Sorry if this is still a bit rough around the edges, but hopefully the
potential benefit is properly conveyed.
---
 rust/kernel/lib.rs |   1 +
 rust/kernel/reg.rs | 284 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 285 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 398242f92a961c3a445d681c65449047a847968a..d610199f6675d22fa01d4db524d9989581f7b646 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -69,6 +69,7 @@
 pub mod prelude;
 pub mod print;
 pub mod rbtree;
+mod reg;
 pub mod revocable;
 pub mod security;
 pub mod seq_file;
diff --git a/rust/kernel/reg.rs b/rust/kernel/reg.rs
new file mode 100644
index 0000000000000000000000000000000000000000..3f0bad18b4f757fb3e7d45f2fde6c3214fa957c8
--- /dev/null
+++ b/rust/kernel/reg.rs
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Types and macros to define register layout and accessors.
+//!
+//! A single register typically includes several fields, which are accessed through a combination
+//! of bit-shift and mask operations that introduce a class of potential mistakes, notably because
+//! not all possible field values are necessarily valid.
+//!
+//! The macros in this module allow to define, using an intruitive and readable syntax, a dedicated
+//! type for each register with its own field accessors that can return an error is a field's value
+//! is invalid. They also provide a builder type allowing to construct a register value to be
+//! written by combining valid values for its fields.
+
+/// Helper macro for the `reg_def` family of macros.
+///
+/// Defines the wrapper `$name` type, as well as its relevant implementations (`Debug`, `BitOr`,
+/// and conversion to regular `u32`).
+#[macro_export]
+macro_rules! __reg_def_common {
+    ($name:ident $(, $type_comment:expr)?) => {
+        $(
+        #[doc=$type_comment]
+        )?
+        #[repr(transparent)]
+        #[derive(Clone, Copy, Default)]
+        pub(crate) struct $name(u32);
+
+        // TODO: should we display the raw hex value, then the value of all its fields?
+        impl ::core::fmt::Debug for $name {
+            fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+                f.debug_tuple(stringify!($name))
+                    .field(&format_args!("0x{0:x}", &self.0))
+                    .finish()
+            }
+        }
+
+        impl core::ops::BitOr for $name {
+            type Output = Self;
+
+            fn bitor(self, rhs: Self) -> Self::Output {
+                Self(self.0 | rhs.0)
+            }
+        }
+
+        impl From<$name> for u32 {
+            fn from(reg: $name) -> u32 {
+                reg.0
+            }
+        }
+    };
+}
+
+/// Helper macro for the `reg_def` family of macros.
+///
+/// Defines the getter method for $field.
+#[macro_export]
+macro_rules! __reg_def_field_getter {
+    (
+        $hi:tt:$lo:tt $field:ident
+            $(=> as $as_type:ty)?
+            $(=> as_bit $bit_type:ty)?
+            $(=> into $type:ty)?
+            $(=> try_into $try_type:ty)?
+        $(, $comment:expr)?
+    ) => {
+        $(
+        #[doc=concat!("Returns the ", $comment)]
+        )?
+        #[inline]
+        pub(crate) fn $field(self) -> $( $as_type )? $( $bit_type )? $( $type )? $( core::result::Result<$try_type, <$try_type as TryFrom<u32>>::Error> )? {
+            const MASK: u32 = ((((1 << $hi) - 1) << 1) + 1) - ((1 << $lo) - 1);
+            const SHIFT: u32 = MASK.trailing_zeros();
+            let field = (self.0 & MASK) >> SHIFT;
+
+            $( field as $as_type )?
+            $(
+            // TODO: it would be nice to throw a compile-time error if $hi != $lo as this means we
+            // are considering more than one bit but returning a bool...
+            <$bit_type>::from(if field != 0 { true } else { false }) as $bit_type
+            )?
+            $( <$type>::from(field) )?
+            $( <$try_type>::try_from(field) )?
+        }
+    }
+}
+
+/// Helper macro for the `reg_def` family of macros.
+///
+/// Defines all the field getter methods for `$name`.
+#[macro_export]
+macro_rules! __reg_def_getters {
+    (
+        $name:ident
+        $(; $hi:tt:$lo:tt $field:ident
+            $(=> as $as_type:ty)?
+            $(=> as_bit $bit_type:ty)?
+            $(=> into $type:ty)?
+            $(=> try_into $try_type:ty)?
+        $(, $field_comment:expr)?)* $(;)?
+    ) => {
+        #[allow(dead_code)]
+        impl $name {
+            $(
+            ::kernel::__reg_def_field_getter!($hi:$lo $field $(=> as $as_type)? $(=> as_bit $bit_type)? $(=> into $type)? $(=> try_into $try_type)? $(, $field_comment)?);
+            )*
+        }
+    };
+}
+
+/// Helper macro for the `reg_def` family of macros.
+///
+/// Defines the setter method for $field.
+#[macro_export]
+macro_rules! __reg_def_field_setter {
+    (
+        $hi:tt:$lo:tt $field:ident
+            $(=> as $as_type:ty)?
+            $(=> as_bit $bit_type:ty)?
+            $(=> into $type:ty)?
+            $(=> try_into $try_type:ty)?
+        $(, $comment:expr)?
+    ) => {
+        kernel::macros::paste! {
+        $(
+        #[doc=concat!("Sets the ", $comment)]
+        )?
+        #[inline]
+        pub(crate) fn [<set_ $field>](mut self, value: $( $as_type)? $( $bit_type )? $( $type )? $( $try_type)? ) -> Self {
+            const MASK: u32 = ((((1 << $hi) - 1) << 1) + 1) - ((1 << $lo) - 1);
+            const SHIFT: u32 = MASK.trailing_zeros();
+
+            let value = ((value as u32) << SHIFT) & MASK;
+            self.0 = self.0 | value;
+            self
+        }
+        }
+    };
+}
+
+/// Helper macro for the `reg_def` family of macros.
+///
+/// Defines all the field setter methods for `$name`.
+#[macro_export]
+macro_rules! __reg_def_setters {
+    (
+        $name:ident
+        $(; $hi:tt:$lo:tt $field:ident
+            $(=> as $as_type:ty)?
+            $(=> as_bit $bit_type:ty)?
+            $(=> into $type:ty)?
+            $(=> try_into $try_type:ty)?
+        $(, $field_comment:expr)?)* $(;)?
+    ) => {
+        #[allow(dead_code)]
+        impl $name {
+            $(
+            ::kernel::__reg_def_field_setter!($hi:$lo $field $(=> as $as_type)? $(=> as_bit $bit_type)? $(=> into $type)? $(=> try_into $try_type)? $(, $field_comment)?);
+            )*
+        }
+    };
+}
+
+/// Defines a dedicated type for a register with an absolute offset, alongside with getter and
+/// setter methods for its fields and methods to read and write it from an `Io` region.
+///
+/// Example:
+///
+/// ```no_run
+/// reg_def!(Boot0@0x00000100, "Basic revision information about the chip";
+///     3:0     minor_rev => as u8, "minor revision of the chip";
+///     7:4     major_rev => as u8, "major revision of the chip";
+///     28:20   chipset => try_into Chipset, "chipset model"
+/// );
+/// ```
+///
+/// This defines a `Boot0` type which can be read or written from offset `0x100` of an `Io` region.
+/// It is composed of 3 fields, for instance `minor_rev` is made of the 4 less significant bits of
+/// the register. Each field can be accessed and modified using helper methods:
+///
+/// ```no_run
+/// // Read from offset 0x100.
+/// let boot0 = Boot0.read(&bar);
+/// pr_info!("chip revision: {}.{}", boot0.major_rev(), boot0.minor_rev());
+///
+/// // `Chipset::try_from` will be called with the value of the field and returns an error if the
+/// // value is invalid.
+/// let chipset = boot0.chipset()?;
+///
+/// // Update some fields and write the value back.
+/// boot0.set_major_rev(3).set_minor_rev(10).write(&bar);
+/// ```
+///
+/// Fields are made accessible using one of the following strategies:
+///
+/// - `as <type>` simply casts the field value to the requested type.
+/// - `as_bit <type>` turns the field into a boolean and calls `<type>::from()` with the obtained
+///   value. To be used with single-bit fields.
+/// - `into <type>` calls `<type>::from()` on the value of the field. It is expected to handle all
+///   the possible values for the bit range selected.
+/// - `try_into <type>` calls `<type>::try_from()` on the value of the field and returns its
+///   result.
+///
+/// The documentation strings are optional. If present, they will be added to the type or the field
+/// getter and setter methods they are attached to.
+#[macro_export]
+macro_rules! reg_def {
+    (
+        $name:ident@$offset:expr $(, $type_comment:expr)?
+        $(; $hi:tt:$lo:tt $field:ident
+            $(=> as $as_type:ty)?
+            $(=> as_bit $bit_type:ty)?
+            $(=> into $type:ty)?
+            $(=> try_into $try_type:ty)?
+        $(, $field_comment:expr)?)* $(;)?
+    ) => {
+        ::kernel::__reg_def_common!($name);
+
+        #[allow(dead_code)]
+        impl $name {
+            #[inline]
+            pub(crate) fn read<const SIZE: usize, T: Deref<Target=Io<SIZE>>>(bar: &T) -> Self {
+                Self(bar.readl($offset))
+            }
+
+            #[inline]
+            pub(crate) fn write<const SIZE: usize, T: Deref<Target=Io<SIZE>>>(self, bar: &T) {
+                bar.writel(self.0, $offset)
+            }
+        }
+
+        ::kernel::__reg_def_getters!($name; $( $hi:$lo $field $(=> as $as_type)? $(=> as_bit $bit_type)? $(=> into $type)? $(=> try_into $try_type)? $(, $field_comment)? );*);
+
+        ::kernel::__reg_def_setters!($name; $( $hi:$lo $field $(=> as $as_type)? $(=> as_bit $bit_type)? $(=> into $type)? $(=> try_into $try_type)? $(, $field_comment)? );*);
+    };
+}
+
+/// Defines a dedicated type for a register with a relative offset, alongside with getter and
+/// setter methods for its fields and methods to read and write it from an `Io` region.
+///
+/// See the documentation for [`reg_def`] for more details. This macro works similarly to
+/// `reg_def`, with the exception that the `read` and `write` methods take a `base` argument that
+/// is added to the offset of the register before access, and the `try_read` and `try_write`
+/// methods are added to allow access with offsets unknown at compile-time.
+#[macro_export]
+macro_rules! reg_def_rel {
+    (
+        $name:ident@$offset:expr $(, $type_comment:expr)?
+        $(; $hi:tt:$lo:tt $field:ident
+            $(=> as $as_type:ty)?
+            $(=> as_bit $bit_type:ty)?
+            $(=> into $type:ty)?
+            $(=> try_into $try_type:ty)?
+        $(, $field_comment:expr)?)* $(;)?
+    ) => {
+        ::kernel::__reg_def_common!($name);
+
+        #[allow(dead_code)]
+        impl $name {
+            #[inline]
+            pub(crate) fn read<const SIZE: usize, T: Deref<Target=Io<SIZE>>>(bar: &T, base: usize) -> Self {
+                Self(bar.readl(base + $offset))
+            }
+
+            #[inline]
+            pub(crate) fn write<const SIZE: usize, T: Deref<Target=Io<SIZE>>>(self, bar: &T, base: usize) {
+                bar.writel(self.0, base + $offset)
+            }
+
+            #[inline]
+            pub(crate) fn try_read<const SIZE: usize, T: Deref<Target=Io<SIZE>>>(bar: &T, base: usize) -> ::kernel::error::Result<Self> {
+                bar.try_readl(base + $offset).map(Self)
+            }
+
+            #[inline]
+            pub(crate) fn try_write<const SIZE: usize, T: Deref<Target=Io<SIZE>>>(self, bar: &T, base: usize) -> ::kernel::error::Result<()> {
+                bar.try_writel(self.0, base + $offset)
+            }
+        }
+
+        ::kernel::__reg_def_getters!($name; $( $hi:$lo $field $(=> as $as_type)? $(=> as_bit $bit_type)? $(=> into $type)? $(=> try_into $try_type)? $(, $field_comment)? );*);
+
+        ::kernel::__reg_def_setters!($name; $( $hi:$lo $field $(=> as $as_type)? $(=> as_bit $bit_type)? $(=> into $type)? $(=> try_into $try_type)? $(, $field_comment)? );*);
+    };
+}

---
base-commit: 4d872d51bc9d7b899c1f61534e3dbde72613f627
change-id: 20250313-registers-7fdcb3d926b0

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


