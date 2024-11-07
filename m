Return-Path: <linux-kernel+bounces-399422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FA69BFEBC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412741C21672
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8BC195B18;
	Thu,  7 Nov 2024 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="Rr8PQo+b"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2067.outbound.protection.outlook.com [40.107.105.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861CC192590;
	Thu,  7 Nov 2024 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730962913; cv=fail; b=OdoSU0a0iJ1FEldZ99LorCYDiz2bL/6gebmt9PXTOVYdDIoTV1jxisQCXdQLKGDQyXczYiz4etTsI6X/hmNwxJ3tD0lKRs5m9Csdutz7eeFJrPTqudtY39PhVG2gxIBKzLsKUkePGsGkn6PxnM4TnAe4bwYszwdSHNcX54IEhSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730962913; c=relaxed/simple;
	bh=MNtgrkf0PRoLxoF4ODsleHRY0FW0UB3G0uiC3fHq04s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M2YJIwEtl7sd3tXi4iH7iIBCl2t9MdBw+/Do5s9KIGw9sJ39xyuST5N/GTANWWjeCC54xEJbzj2msin6sbB+9bXMxheREIsavIqIJuNo0wb5K5WqPW0bpvfId0NbNhT2U6SgBLdEXV9t0Y7fDvJ2rqN0g7//dNeXJnXiR+REe9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=Rr8PQo+b; arc=fail smtp.client-ip=40.107.105.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGYzOBBHu/Usvwp7SEQ73d9D8hyT0m+fKyXD1jTKDY/OENPuBEBJUdnOCUuG951L+n5qVN1qluSBCba7cYywGGE9KYo6rGc7r1Aq+idiByMtMrjnuHtj7HiWWD/yEoPiflcLhIoAjXBJqYlm0S5nuy93vpiCOGL4679YB3xAqls4rF5xlsnO9dO/vo/7OllbAyawwgVSPt1F8m0HnkUCIwfitmBlEjmAotGns6xNuqwkbEHYcu5pFzN2WNYgnnCcFDDSFc3NWtyP5hIMaQ25vsReEBWy4Gr1DltSqYuiE6WtQT0EDNHY+pPTwulxrlf+Tbmq0Z8KdLa8VeDeCUwYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2jsow5xzAxttWH1dpZFeA5beqTPv+k+HxRX6sI31Ro=;
 b=Q9WIJAFY5ptGZGdfLAUi8XsuivBoVv3UzprZ6l7ELB+QAcDoIBgo65OMhuqlfXi1jVS7ucE+M0nahysGnNTdqaSGVPABHt68ZnvU4RyxRu+Go+YIVJBTMHk8jxb2ktBKGOuWWe/JBHnqL4hAEOsRaj+zMgihc9/ZLJTcSQIDY8Qq/QCvE9CfJkRnAZFIAExOgiqiUUu9izAihwZYiiwVhxng0AIOq4aX4ya6wKQ6oNSzOeSd8ypcVUtfPmKPSqncCWWklCt66BgC5Yr+Vo0Y1C77aouWawMfNIWBscvlwWskkPyY/dXr1SdhdWqMl5v/w/VMR8+G26WS4lQM+z2NtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=gmail.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2jsow5xzAxttWH1dpZFeA5beqTPv+k+HxRX6sI31Ro=;
 b=Rr8PQo+bVorbhyE5hGFFuKIPsqGVe1zm+zQRlSCuhmNH0wRFIxOOid5rtoTZ01UG/WyyQdZuCEvNBUVx113MfD4lTvV6XaBfQ+sxfHxZvyTPa3aCoRcawcQ4fn0VNIfAkmT3YsyZUv1PboAJA/Fx5DgP1IH7SisGSCn37t+0fZLxYvn1QwnMQBDgu5wzwhh74FtCbO57lUTeyipLTreaHM4K919ZPWBMkNSF8ncoNW80f5ueDF1kDcDKm40osb4qk9DPNqHaAbGah+IvUfOkxO3GVT8qhRwd+PteWxLwpXUC2PpPgzjjvlUVYKFSHHbF8+JRF0ukyPhy4qVs1DeKzw==
Received: from AS9PR06CA0164.eurprd06.prod.outlook.com (2603:10a6:20b:45c::15)
 by PRAPR10MB5252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:292::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 07:01:46 +0000
Received: from AMS1EPF0000004C.eurprd04.prod.outlook.com
 (2603:10a6:20b:45c:cafe::40) by AS9PR06CA0164.outlook.office365.com
 (2603:10a6:20b:45c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 07:01:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AMS1EPF0000004C.mail.protection.outlook.com (10.167.16.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 07:01:46 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 7 Nov
 2024 08:01:31 +0100
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2000.de.bosch.com
 (10.139.217.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 7 Nov
 2024 08:01:31 +0100
Message-ID: <3d898bd0-315d-4e3d-a500-5605e9047946@de.bosch.com>
Date: Thu, 7 Nov 2024 08:01:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] rust: bindings: Auto-generate inline static
 functions
To: Alistair Francis <alistair23@gmail.com>, <alex.gaynor@gmail.com>,
	<benno.lossin@proton.me>, <gary@garyguo.net>, <linux-kernel@vger.kernel.org>,
	<ojeda@kernel.org>, <rust-for-linux@vger.kernel.org>,
	<bjorn3_gh@protonmail.com>, <alistair.francis@wdc.com>, <me@kloenk.dev>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <boqun.feng@gmail.com>,
	<aliceryhl@google.com>
References: <20241107020831.1561063-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20241107020831.1561063-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004C:EE_|PRAPR10MB5252:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e293f89-a8ad-4fd4-eae9-08dcfefa0b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmJJSmQyR3o0cC9FMnpKNElRK01XTWVobEJGOFdqSmVKeDFZWStnb3ZmeFc3?=
 =?utf-8?B?QzZUcEVMWm4rNU8rRndVbTY0VmthRWltT1VENDdXWGJZT3lmUGFhMHF5TWVG?=
 =?utf-8?B?Q3Fybis2RGZlNTE1N3NJa051cGhwVCtMZUs2SWE0UkJCWTRJNEQzaGl6T0pL?=
 =?utf-8?B?ZDltME0zOVFpSnEyc1l0cmxEZzlmY1M2ZHEwRFdQTW4vYkZJUDRXeThaTFJm?=
 =?utf-8?B?N0ovaG05eGxBTUVCdHpoYi9wcnR5SG93UlZmZmJQUWZ6NGV4dnZYZGV3T2pj?=
 =?utf-8?B?SHVEWThXcytERlo5ZWFBSHlCQkZyQTVKYS9Td0l6SnFlc3ZUVGRyL1poOGJh?=
 =?utf-8?B?M09JVm5MbmVEZVB0eFEwZHErSGM2c0hYZDRFT040c0VrVzdHd0FEbHhSM3NR?=
 =?utf-8?B?OGQxYzFwck5aOUEyb1ZIUTlWOFNiUTdjV2dHeWR2aENZcUpRaWVaWTlNOUFi?=
 =?utf-8?B?cFZSWFJpTFJxUXV2TTdsM3FaZzVEMDJQRXI0K1lYMzlsU1dKbzdwMVBuVGFj?=
 =?utf-8?B?VVNFV1R3TVMreWNjRjZsbno0K0NFSmxFTGlzUFFKNUlaRVdNK3g0MURnME5p?=
 =?utf-8?B?Nm43VFNmQXpMRFBpK3pscWhFOUF4Kytuck84VXhEcVJCaFRUQk1rSExwUmox?=
 =?utf-8?B?RG9vVXc5a0FYVzdNNndZQy9qQTBIVzFMOFFVby9mSWwxUkhhdFVJdWxwMjBq?=
 =?utf-8?B?UG4vYWNZclo3UHpQYW1tQVFmbFlnQUxYeHBMVTdSaVo2WEhkcGszTCtNZFJ1?=
 =?utf-8?B?TUJDUWhYaUpGUUl5QVFvMDI3NSs1SXh6VjY4d2huYnVHYlAxRm9zZ1lxb2Jx?=
 =?utf-8?B?L3lBYkkvcjdZZEtHaURqdkZtd2RvNlBlVTVvK1R2eFM0bS91d1B0eDVHb0sz?=
 =?utf-8?B?Y1lEa1RYcjVIRTJiSDcrYVhWd0FKSExLM0dlYkpZOGxmVk9ydzJwd1Bkc2tP?=
 =?utf-8?B?Z2pBaDlmQjF0VlZIT0VaeWZJUzEveTZYRjdBOEUzanhTemo3cm5tVTl4Sy9G?=
 =?utf-8?B?WEs2S21uc090STNTUFRHcDNXV2N6dUpLQ0tBR1pIc25OUGlOc2E5VGg1REt2?=
 =?utf-8?B?dkNhNTNxVCs1M1Qrb1ZnSko0NFlzdklHM3FPR01NRXV6dUxHenNNd0dFYkpx?=
 =?utf-8?B?WEtncXdzdlNlbisvbS84SVVmdVp3cnkrZGNYSDk3em5zRkdiVGhRd0VCTUhW?=
 =?utf-8?B?eXptdHptZHlWUnpOOEJWaGFoN2RVSXMxd00vcmJsaldqVGc2MWlnVE01TXFy?=
 =?utf-8?B?V2E4THRaa0xBc0lhN0dBWkNUdjRFak9vQzBJanlzenJFUUQ2dGZjeDhuaGZl?=
 =?utf-8?B?U3ExeVNLVWhSVzhLbTFMSFNsVlQyZlUyNDJybmZUeGJKTHU1ZlhtVW16bHpR?=
 =?utf-8?B?VmM1aEsxVE9sc3pZVUhjaHhPRVZOTHB4anJkTWFTa0N0bVYyN2lhQjJhZ3JO?=
 =?utf-8?B?cDVPTU9zbWhZWkd6UlBHeUFjS2p3ektuRE5aUTR0QWZwQlRPSnBSWktZWVpR?=
 =?utf-8?B?U0JOeWk3WXU2S3Z4WG5mVTVrVEdaRVZXaFZBNVRmNDNpODNhY0NYK2FLdnJr?=
 =?utf-8?B?cnZSdzRmMEVSYzJUaklqOVBZZTJyWFJpOTc1SmpZMkgzMjNYdTdLSGYxK1Iy?=
 =?utf-8?B?M0FxVko0dXdpbyt0a2Y3UnY1bkRXeW53NXVGMTFDdTVkVi82c0VVRUQ4WkRo?=
 =?utf-8?B?QXoxcE9RR2EvN3pGWklnZzlCMW1BQVRNS2l5bGxBcjVyb2labjdSemo3aVB1?=
 =?utf-8?B?Tzh3MFVxUzFLeFY4VWEvcG1lNy9Fb0hrL0cxbXJWMXAxdVNFd2grMVhjNGRC?=
 =?utf-8?B?NlBvZzJzRWcxeVJhZ25iTm9LZ21QbDJ5SzQ5cmY2dWZKbDZ0TGdvZWNzSW5K?=
 =?utf-8?Q?bV4gCO1eLrXGK?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 07:01:46.3815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e293f89-a8ad-4fd4-eae9-08dcfefa0b49
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5252

On 07.11.2024 03:08, Alistair Francis wrote:
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
> non-experimental (dependig on your version of bindgen).
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

Maybe this should be re-done against rust-next which at least contains

https://github.com/Rust-for-Linux/linux/commit/d4d7c05f9656fd8e14c6977a54986264eb296ec8

which seems to conflict with the removal of some helpers file in this 
series.

Thanks!

Dirk



