Return-Path: <linux-kernel+bounces-404130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449999C3F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 980D4B2329E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8A719D075;
	Mon, 11 Nov 2024 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="j+NXb3nK"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2043.outbound.protection.outlook.com [40.107.103.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9982215575E;
	Mon, 11 Nov 2024 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731331415; cv=fail; b=Tzi6ieiWRhmRG6+TMpHv4Zvkqw/6FqqjuwO6qdS15cLkq4QnzNDAZhm/4bS5m+9L0IIuuVluVG3G1Ph0YjYdoHMStx+NwcWquydaPHA6/Ma6f/ZoKIJf/Vpl0Opz5NC4isfP3kBTs4GdhTQuHBrODBKz8wMyH3AIXs7OfuVOyFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731331415; c=relaxed/simple;
	bh=jejUd6cZBhnxuSn3GApacZEh9MeW1jJGd+6iV9XJxNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uLtulrOJ6Euei09DtLYdczKBqCTKyDkqN4dwHBY/E5tYOmhpfNRbsunv6ysfX9UTyE88PFSvOZFoiekl/0T4DshNhK7IRsjXXiNakbFcHR6ly718WTTtNzdN8YGOsBl62NJasCA0kxYieUi/GZEvDmVweR+KQDNDw1/YMiFscDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=j+NXb3nK; arc=fail smtp.client-ip=40.107.103.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+HrWVu7DfoJCXiRDSMoHMQ92Wl3ZCnR3g6KSImmNDHpzZ3p6JT6O1P8n905lal52VIFnDrUtKpcIA+LZ1sAF0xcgGoAsWEffKXLZ/2AOjlNkjnOqSzWYmSaxdYPaVT1xe1fbba8j3iAf9Db02C4w2m3CmJtJA2QqH8hDQMGA//S4sKsGswsJg6Vv6Ekf8XMFrM7MrtbQKPWfuEH/kL/GDtZ4Dd02UaUHY5GcLbNSDyT8jDAlKRUINKtS6t7uDq5FHvREdyriES02fA/IufzwtgK/eyiKMTjueWd51GHDI9UeXmtsfXnUJgVfL60Mp/AHgDboxD+ikT+xXuN38/sIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmA9+7tOsOLmql2C523VhIBQhpLaxcwkiLy6O/QmM+I=;
 b=Ksb+rh7fgSKk6JmVQRJE0HjmSn2aUgdr7sDlRh+rhxlXxVD4aEJhGPZWamGmfGR/hYLfx4ui4QKvz7nKeng+IiRgfNZX3zeiPuHV8MQn/R+BCeAeEXzH4lQzly8qpWzQMoMAswKgWl/EqoUJiRz00qR0XVWUthD/vk+zFcdvu/XQ9mxC9rvfKiAktzDbq5MvWn+VXDK5TfnnSZ+dJ747kFe50Zs2t2ir544eG0PpGDYnjOXFRrLWwxm0oL6jGI7NfOKIKEcuV93dfubnS4pXSRE26CjHlTcv8oBcdE8ZQasPKNfXIxdL5/wt63DueqQejAKN0UuC/ZLth0ylAqzqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=alistair23.me smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmA9+7tOsOLmql2C523VhIBQhpLaxcwkiLy6O/QmM+I=;
 b=j+NXb3nKEFObkB/rAn3d8wf3OGo9hxpFUfPjTBbbyuGhlZE4xLJzXBgjp6LR97GJ0KflL0wDgKwea8Ut/bdiHXcqy9vtPdU2sWEC41VExEadAFi25KkEzltQdvFDbHOWZTPsC5ftMlLhPPVyfffbQOM6u+djLywwXuMcBWHikDkUo0DWlJ69V+OD/lQzfUyU/pTV99K/m7Fx0tE46jBxZJRNpDzJPYroQO0kZnNBHJPVm1eyxAWSznmioXeWMrCiyVf40AYKIfgCmeuMZruS2OXPpTK8hiVu9sQHg5Z7DZU7/aV3sJk2JoAd0jzrPaGQLgTOz8tgoCU/nrr10FN9IQ==
Received: from AM9P192CA0025.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::30)
 by DU0PR10MB7408.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:443::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.14; Mon, 11 Nov
 2024 13:23:28 +0000
Received: from AMS1EPF0000004C.eurprd04.prod.outlook.com
 (2603:10a6:20b:21d:cafe::68) by AM9P192CA0025.outlook.office365.com
 (2603:10a6:20b:21d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Mon, 11 Nov 2024 13:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AMS1EPF0000004C.mail.protection.outlook.com (10.167.16.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 13:23:28 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 11 Nov
 2024 14:23:18 +0100
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2001.de.bosch.com
 (10.139.217.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 11 Nov
 2024 14:23:18 +0100
Message-ID: <9369b621-47d1-4967-8a68-874bb602deeb@de.bosch.com>
Date: Mon, 11 Nov 2024 14:23:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] rust: bindings: Auto-generate inline static
 functions
To: Alistair Francis <alistair@alistair23.me>, <linux-kernel@vger.kernel.org>,
	<boqun.feng@gmail.com>, <a.hindborg@kernel.org>, <me@kloenk.dev>,
	<benno.lossin@proton.me>, <tmgross@umich.edu>, <aliceryhl@google.com>,
	<gary@garyguo.net>, <ojeda@kernel.org>, <rust-for-linux@vger.kernel.org>,
	<alex.gaynor@gmail.com>, <alistair.francis@wdc.com>,
	<bjorn3_gh@protonmail.com>
CC: <alistair23@gmail.com>
References: <20241111112615.179133-1-alistair@alistair23.me>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20241111112615.179133-1-alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004C:EE_|DU0PR10MB7408:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7869f4-9265-4000-711a-08dd02540763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UG5sMnRkN2hqV0ZLQTZvLzVMV3pNR2ZCMVNHaW5IMWVWZmVwd2FxVXdBWGdv?=
 =?utf-8?B?bHlnaGlYL2RUK0FDM2NFOW9SY0VoUFowVEx5MlA3NHhISkhYcEpFc1lWWkJQ?=
 =?utf-8?B?azFUOWdHbVB6bHNOVHViTXRVY2oxcTFaR1BlU2tBc1dmQlpuTzluTC9RenJk?=
 =?utf-8?B?NUNBK0tYKy83NHdKRXVLemVEZktkMUR4ZitmYldrcVk4Y0p3SmZMNDhLcVBV?=
 =?utf-8?B?Q2wzT2FZcWxlS0VPLzFWR0NPWlBXMXA0QWg2MWprZENPMURBcnhObDFEdVlE?=
 =?utf-8?B?VnptbTlTNnJzZVZ4a2daS0piYldBZ2R2NFBseDVWaVZOMEI4RXBsQXJ1ME42?=
 =?utf-8?B?UDBWcyt5dUo5TUU3NjdOZEVyMWlLKzM1VUZCZDNNdTVkdW1Udkd6dU84L0Fu?=
 =?utf-8?B?SkkxNEp0cE9YbXF0VUVrbktTcXVKWU04VEx4LzRjaDlMNVhYRkI0S3lsN1VN?=
 =?utf-8?B?OEMyZmEzVnB4aEY3WndXQUx3M2JXSUNLRjRkaitiLzJMdGdaalJYejExRkxa?=
 =?utf-8?B?bkFFb0Y0UUx0MC9Va0hYMm9rODZoSTcwRWIwbWRwUWJ5YndqTWpxTTA1T1ps?=
 =?utf-8?B?dnNIUGx4LzI1RGhERWkyR2xQTy9GSk8vRUhoNG4wb0xzaWhQNktsdVY0RDFu?=
 =?utf-8?B?blNCSUJUUkhKM1NpT2RsSURLMzdCaXQxbUlGak1WRVFkQ1Y0S2JmV1NnSW8w?=
 =?utf-8?B?eDNjbHBPNVlrN09SV09BQXZaaE90R1ZnQnd0V2FBdXBrWlZINTYrWFNpOVVG?=
 =?utf-8?B?eFFsd0xhNzlPSmlNcExhL2hYWlIwMU11OGpBQzR0ZURSQitrTDg5cm5BZEVa?=
 =?utf-8?B?ZmJiVHhBUXZEVXNHakprT1BHOWcxdXJLekp4UmVTUU1CcUJOUWMraFBSbEV0?=
 =?utf-8?B?TWh5K1AxQUVJWUl4QzU0WDBQenNwM3JnWldJZytDMlZJRE9nbzVQV2JWeUhC?=
 =?utf-8?B?Y1dGMndzd0lRZS9SZ2JTR1I0NDloMHV2ejk1eFNBV2ZxbkpOc3RBKy9aMitS?=
 =?utf-8?B?YlRFV0FkM1R6V3hSQXVpNHpvR3lkMk1KZXpsYkFmbnZRd3FQQkk3TERoQlhW?=
 =?utf-8?B?UVlKV3lHNmREK1RPdGllS1c0ZUNsWEo3cFI1c1BsdGVmVHFuOE1KNlBETVRO?=
 =?utf-8?B?SXdseVRCWEhXR1lIS2QzNFRqRkxyTEtqdXZOOGpiS2lvait3L2I5VDBUUGNU?=
 =?utf-8?B?TnJLRWp2MSt3Vlg2MXltWVpBcWlHeHcxbXUxY1VuTTYxRFRLMG1jcnpGT3c5?=
 =?utf-8?B?YkxSM0ttZW93L2FIazVsVGZvVzJoQUxBelVUc1NUNzh0M00xK2kvdUFQYlRP?=
 =?utf-8?B?d3RIazlVVllyNGpZem1DellkOGtkSXdWaTB4OW1FSWxXSi9hTE9UQ2dUaFVD?=
 =?utf-8?B?dDJtL3p3MElVbDhjS1Y4MHI1ZC8zSEVkd1pSTVg1REFZR2hWSGFocWdrMm8y?=
 =?utf-8?B?WmwrWm1kR2h6aDhYa2tsVmtBU3EzdDlMcWpGcllQalR1cDhOb2tTSzJ4R0k2?=
 =?utf-8?B?VzlvSXJZODdOS1J3M2xMUGFEbkJhMVM3YTdxMFRCVE8xM0dGc3NDeUFkNVhk?=
 =?utf-8?B?K2xtSzFIRnY2U3ZkYi95aFE5SGZkS2RtWlFHbCtmUTFmT2FWcmhrRS9zMEN5?=
 =?utf-8?B?TU1Wd0hxeDAzc2hrZ2dHVGw2NzBHSVE4cXZJRWZreTFmaUFuTGxvU0RhNTVY?=
 =?utf-8?B?Yk9kTUxCNUdjcEtxdVhhdURuRmdYUnBTWnU5dUVieXYrTXVaQi90R0lOc05E?=
 =?utf-8?B?QU02a3hzZ0kvanE1cSs4cGF2K0doL1dLa0ZTM253bU45RFBZNmswUllJRU9O?=
 =?utf-8?B?UG4ybkk0UVJZaUdHODQ2eExlY2hOYTdyTW1GaHJXWkZOaURqQ2hNczhucGNq?=
 =?utf-8?B?VzFqK3pnQ3Y4U1pGTDNNaDR6NVdJZzBvN2RuaW4zODFjNlYrS0F4bEpuK0NT?=
 =?utf-8?Q?4FqIZUJXrkI=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 13:23:28.0319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7869f4-9265-4000-711a-08dd02540763
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7408

On 11.11.2024 12:26, Alistair Francis wrote:
> The kernel includes a large number of static inline functions that are
> defined in header files. One example is the crypto_shash_descsize()
> function which is defined in hash.h as
> 
> ```
> static inline unsigned int crypto_shash_descsize(struct crypto_shash *tfm)
> {
>          return tfm->descsize;
> }
> ```
> 
> bindgen is currently unable to generate bindings to these functions as
> they are not publically exposed (they are static after all).
> 
> The Rust code currently uses rust_helper_* functions, such as
> rust_helper_alloc_pages() for example to call the static inline
> functions. But this is a hassle as someone needs to write a C helper
> function.
> 
> Instead we can use the bindgen wrap-static-fns feature. The feature
> is marked as experimental, but has recently been promoted to
> non-experimental (depending on your version of bindgen).
> 
> By supporting wrap-static-fns we automatically generate a C file called
> extern.c that exposes the static inline functions, for example like this
> 
> ```
> unsigned int crypto_shash_descsize__extern(struct crypto_shash *tfm) { return crypto_shash_descsize(tfm); }
> ```
> 
> The nice part is that this is auto-generated.
> 
> We then also get a bindings_generate_static.rs file with the Rust
> binding, like this
> 
> ```
> extern "C" {
>      #[link_name = "crypto_shash_descsize__extern"]
>      pub fn crypto_shash_descsize(tfm: *mut crypto_shash) -> core::ffi::c_uint;
> }
> ```
> 
> So now we can use the static inline functions just like normal
> functions.
> 
> There are a bunch of static inline functions that don't work though, because
> the C compiler fails to build extern.c:
>   * functions with inline asm generate "operand probably does not match constraints"
>     errors (rip_rel_ptr() for example)
>   * functions with bit masks (u32_encode_bits() and friends) result in
>     "call to ‘__bad_mask’ declared with attribute error: bad bitfield mask"
>     errors
> 
> As well as that any static inline function that calls a function that has been
> kconfig-ed out will fail to link as the function being called isn't built
> (mdio45_ethtool_gset_npage for example)
> 
> Due to these failures we use a allow-list system (where functions must
> be manually enabled).
> 
> This series adds support for bindgen generating wrappers for inline statics and
> then converts the existing helper functions to this new method. This doesn't
> work for C macros, so we can't reamove all of the helper functions, but we
> can remove most.
> 
> v3:
>   - Change SoB email address to match from address
>   - Fixup kunit test build failure
>   - Update Rust binding documentation

Many thanks for the update!

It builds for me now and the htmldocs were built as well.

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Thanks!

Dirk



