Return-Path: <linux-kernel+bounces-384220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE909B2885
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B427C1F21341
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD14219049B;
	Mon, 28 Oct 2024 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="Ntc6Azc3"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F6918FDDA;
	Mon, 28 Oct 2024 07:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099515; cv=fail; b=ehzrKtA/+g1U9t9mPz31Bu0nt9A1/fuj44Nwz1KF+2BqgmbM8HWiTUtMlmVted0C7BYily5tGhD1ircSYqaMDyy4TZhnv9g0kkjCJWUb8pCKaZTu4gVNVAodmn4gyF2+o9G37Ovyzu/YaQgUzS7P8B0LCHQHyCn4EBQ3TrV6K5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099515; c=relaxed/simple;
	bh=ul61saJyAM//zivN5FD0iRX8uWhMYdPrv4rOD1Bluow=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Flzo2/Uu30WxvfqwK/qS6GWPGScxQOtlxH8+fGQAJwlDKz/rCiCvUP3O3a8XuXvT0qlpMxqsBuaMsCQhuiyOqtEkym6l/GCZLyUsVd+YlAqH5AiiZT0b4jmqJqWgiLXdMzTASNurDJNgL91CNGu4hNbkKAavwLCSEaMI62F2HSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=Ntc6Azc3; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOq462Hak7G+PbklA3hpM7eowyicu0XwlAyt6AOpaIxwEBI5y0L7z/FMkvO7p+iIzI6t7599X63C6uLjlbj7o3wf52JlQdByCjn6RGx2TBZVS8NA3Jj4FQg31zLMYUSB+jyU/327gR2P1JPzPNVI6tQN3dZhalLFjtORbvWkkPxuk8LCxn8zIdepHSkgMg6EeAr86m7BxsRo0TkRK8keipKq0E7CtDh54kekpcAVlbVtn9/+QU6Iok71DZ3Vrn2zMUq6pV1Z/sDPV5jhxubjsQ/EeVzSy9hv0UBDskKf6t9EmOtnJrq6ooiNUxzSWvCGop7L7DcKfOF1zedZHO9dbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtFC1fYGuw+YfbcbvxbEKkvuh/P+TLFu8jUu+dgdFgM=;
 b=xEDlCKc2yzmydse8ndIU6bJWP0hgz4Pa4zz1eGOlrrEG7AnM10XuDWbhYSGsUZ9g/1rqhJo+Rsnsx9heR2ySNTlAel1qNUd//KGGbtSQ7DM6BwnZMxoda/t2dSD2EkAnMLOkkQ5PmAMh0KHu3vjwLzKDpGZFu11u/1uWlnLlb/OpbUjUGUou9LUk2tvvI+V6VyjrOx+Iu9of8kL59cq8c+1jApOCy1pzsWKl6fTXIdlGjGmXbk58p6qPH2IlBfNEE0P/YVX/XdbsLBiTT6eOTMchMdYXdSmtaDurKhKionkjrsuTwzBBCrARQUroGzZqYIYcYB5GuOqSNiwz7fADQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtFC1fYGuw+YfbcbvxbEKkvuh/P+TLFu8jUu+dgdFgM=;
 b=Ntc6Azc31Sl0mMG5zscTyW3T+UmSpkKW48Ma3st08A560IWdVCIPlV9D66xAfOE60j90gRg6GxT+vG+SdlaYvd+iSauFVU6Zq7zwefNvsl2R2oa4BFhEvkCEL1pB1GeT+lHAlzW99Adr/rvyVCwqiQBq4BflDAsKsMAcmA7L7H2Zc0ALi/y/FQYphCcaobZzP4p093PnIHWRE6E1vowzubdKmL87NRDZARf8VqN9T1j++xRlV1NhMyMIZw0U9NZkbeM1qgsBZB9uJlPXLV66QLUJ4bD6++omI59yV21wibDagQW2MHE28UaRB3ftkUD+Q3fMTcUwCJscUkxrTgY8sg==
Received: from DUZPR01CA0307.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::23) by PAWPR10MB6877.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:33a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.11; Mon, 28 Oct
 2024 07:11:49 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:4ba:cafe::71) by DUZPR01CA0307.outlook.office365.com
 (2603:10a6:10:4ba::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24 via Frontend
 Transport; Mon, 28 Oct 2024 07:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 07:11:48 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 28 Oct
 2024 08:11:48 +0100
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2001.de.bosch.com
 (10.139.217.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 28 Oct
 2024 08:11:47 +0100
Message-ID: <563e12c3-7910-4b40-8f1e-e39e5a54b79c@de.bosch.com>
Date: Mon, 28 Oct 2024 08:11:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] of: unittest: Add a platform device node for rust
 platform driver sample
To: "Rob Herring (Arm)" <robh@kernel.org>, Saravana Kannan
	<saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Dirk Behme
	<dirk.behme@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
 <20241025-rust-platform-dev-v1-1-0df8dcf7c20b@kernel.org>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20241025-rust-platform-dev-v1-1-0df8dcf7c20b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFD:EE_|PAWPR10MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: e726700c-9668-467c-845d-08dcf71fca39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVFyMzlpb3JCKzl4dy96VXQ5dXloRU5yQkNkdHRnQzlIT2hzdUlGamV2RFI2?=
 =?utf-8?B?Qlo2ZjZqUGdzNkpZWXRpWTUycmQxcWI4Vmt4OG1rcEJrSmxBYnN5SVo3WUgy?=
 =?utf-8?B?ODRMc2RJdy9vZ3BZUGw1bnZ4VkIzTHFlbTJxN0Z3Ymk2b3BBRkZ6ZVFlSlBD?=
 =?utf-8?B?NGJ1dVM4eStaejE1aTZGTktPTUFMK0ZaMW5kQ2JYNEoxZ1FwejFpaTFpdGZZ?=
 =?utf-8?B?dlFjcHJQc3MwUFFvcEl3ak8vdWl5NGRaUWtna0hNdDNHdzIrcEVmRjZvcjY4?=
 =?utf-8?B?Rm1kZlpUdkxGTVJQUVVoTGVNUlVwVUV0YkJBYkFDcXFuQ3g5cXphemVsbzhQ?=
 =?utf-8?B?YVNqcmVhUVNlUzFUTlU2ZUp2dFdqdU5zQ1Zib2doK25BVDZDWFBhUEJFaGNC?=
 =?utf-8?B?YldDd2JTY1J1WFFNQlpOK2Jid3Nwd0JCNDVPaW1ISmxXUGVLUlBiNmZXN0lM?=
 =?utf-8?B?b1VRaU1lUVRjTTJBbHZqaTBybGcyZ2t3dE5yM0JXSUM3R0dvL0duZ25KaTdt?=
 =?utf-8?B?LzNuQzRwTEU2dzhKN2hZUDNvMVo4RERLU3NvQkxzQjQzTlVIZHlIaTJzZSs1?=
 =?utf-8?B?Tjc0VTVJYkN0a3g4NVAxR3BFeXVySU9ZR1YxS0xNcUpBeG91cWZ3a1NMbHB6?=
 =?utf-8?B?M0lHZG1OSW1xWjkwUUVhSlBnQ3RKQlNmd3JrUnhibzk3VTM2ZzNOc3VrUjJM?=
 =?utf-8?B?QVJROG1yd2ZQcEZ0T05ET1V4ZU0zUmRRcjRvNHBWWEhVVUNUYlpiSmpDdHZ3?=
 =?utf-8?B?RXZvc3FaTnNpb1duRG5tNURiZlRpSjdFb3BmTXlhVlNIcmpYRVpBT2UvNEo4?=
 =?utf-8?B?WEpIeXRISjhsdHBNRGpSVlk4YU9XK05YeUJ6T1ZhbDJhMmRsZXdBV2hTVHFL?=
 =?utf-8?B?MEozQlRTTDQxZFNUazVKODlrTitVckxpOG01a1BKYlZ3Y3U3c2kwYXpsSnhv?=
 =?utf-8?B?QkdrNkJTOHZyMEVGOTRBb0VubXQ1T1JIaGptbnpFYUhHbmlpd1g0QVZYU0pG?=
 =?utf-8?B?a1lhUUdzQkJwVjVaKzFVWS9TUHZPUlZFZHFJNks2NndrVy9jMzdqZ09GUnlS?=
 =?utf-8?B?T1JkeUsvd2NzWWdMSk51eHBNeTVrdlpZWXNOVnBYMXRKU0VkNTc4NEZ1eG5i?=
 =?utf-8?B?dVh5cCsxL01LSnBVOHJ0TEVWUDIyQ3llSzN5YmtwYXBzTW9WTStKeVNFVnF5?=
 =?utf-8?B?eDJrRk9jUGFvVk5tejR6NXNsZUI0dFpsMWtScUh0cDdKKzNkUmRIRmw0Uzk1?=
 =?utf-8?B?OG5LNmFXbTZMaVhBc1dHRWxBVHo1eWJEVDV6azFzbEw3R2pxVks0OHFMUGVu?=
 =?utf-8?B?eGtSdURFOWZoZGg2dzh0WlZDbFhhamVaT1E2ZUYyVXF4ZDk2WFRFbzNKV2R3?=
 =?utf-8?B?L3FmTnVLZjVVREtVeE5LTUJZUDErU09XSE9UbTlRcDhWZFFzUVpnZjhJNUhS?=
 =?utf-8?B?Sm5pemdoMG4rMUZ2ZmJ5eUwwMWE3czREb01Ndm9BMGk1Ti9DdU9EVnNUQjJz?=
 =?utf-8?B?ckh3RjlJV3plMW9LWmM4L0FWMkttMnJvU3pndEZoK0o2UW4xTEN6YXdneHdL?=
 =?utf-8?B?dHRTTE4zTGIzemE1dVMzZ3VmKy80WG1hc1YrUE5McVRYTklHb2lUajlFRFBv?=
 =?utf-8?B?N3dBRXliUHVKVjk3TjlTYWxha3dvZ3lZVVZQNHBLQkh0ejZtZDRsdlZEM2cz?=
 =?utf-8?B?cStXUnRKQk5IcjJ6ZVZlLzhINjI2YTBKa0MvZ1hKMnFaclVVbTd4M1BxR1VZ?=
 =?utf-8?B?UVVFTHI2ZmtST2NSWDBFWDA1cFVFRkRiNzd5d04rWDk0TzR3UTc3U3MrWFlQ?=
 =?utf-8?B?aFNudWlPd3d1Z2FKMjNGU2paem9SMHBNcWt6dUdFQ0pRQ3pRd3M5QmFGV0E4?=
 =?utf-8?B?cmFHZVJEZjlOcFJPTE8zMnhvd1R2V01xL0NYdHB3M2tNZUt3cSt4KzcvaTgw?=
 =?utf-8?Q?p2eputNWILQ=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 07:11:48.7800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e726700c-9668-467c-845d-08dcf71fca39
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6877

On 25.10.2024 23:05, Rob Herring (Arm) wrote:
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   drivers/of/unittest-data/tests-platform.dtsi | 5 +++++
>   samples/rust/rust_driver_platform.rs         | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/unittest-data/tests-platform.dtsi b/drivers/of/unittest-data/tests-platform.dtsi
> index fa39611071b3..2caaf1c10ee6 100644
> --- a/drivers/of/unittest-data/tests-platform.dtsi
> +++ b/drivers/of/unittest-data/tests-platform.dtsi
> @@ -33,6 +33,11 @@ dev@100 {
>   					reg = <0x100>;
>   				};
>   			};
> +
> +			test-device@2 {
> +				compatible = "test,rust-device";
> +				reg = <0x2>;
> +			};
>   		};
>   	};
>   };
> diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
> index 55caaaa4f216..5cf4a8f86c13 100644
> --- a/samples/rust/rust_driver_platform.rs
> +++ b/samples/rust/rust_driver_platform.rs
> @@ -15,7 +15,7 @@ struct SampleDriver {
>       MODULE_OF_TABLE,
>       <SampleDriver as platform::Driver>::IdInfo,
>       [(
> -        of::DeviceId::new(c_str!("redhat,rust-sample-platform-driver")),
> +        of::DeviceId::new(c_str!("test,rust-device")),
>           Info(42)
>       )]
>   );
> 

I'm not sure if parts or all of this should be squashed into Danilo's 
patches. Anyway:

Reviewed-by: Dirk Behme <dirk.behme@de.bosch.com>

Best regards

Dirk

