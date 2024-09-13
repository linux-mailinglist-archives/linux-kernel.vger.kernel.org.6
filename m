Return-Path: <linux-kernel+bounces-328900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A29CD978A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0AA288EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D02D155C96;
	Fri, 13 Sep 2024 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="fXY8+xKk"
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020103.outbound.protection.outlook.com [52.101.195.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D9F2BB13;
	Fri, 13 Sep 2024 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263148; cv=fail; b=gQcJl+Jx5BHKiVDDC9AWmJIsAfS0tynj8BjENGCARBya3GWT/AZyW5POnksm6FClx3vS/W41UJvNGmJ/6coQk3cIlCy24tXvnswTH+h2B65yk2qNGrD9yznOBM4Em9jibSOLhr7Kri6++H5oZekepYk3ELRGVQGUBLFXuFjdVY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263148; c=relaxed/simple;
	bh=PD1lw3UOEIEnVqfH+hu8jpKUwrFjwwrZ+oY+aOyBqv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EKu0fDxpN488Aocc72Tb5RdatN9NDSPvDP1lPaSeLG3gNEowFne3NToKVWOI9R0E4yvTK3vkOfYez49ZEiDXaxEzbwuo0BrepapufJIYgdiMeuqQSjdZdWChlj7vNUgOKiTxxMdgoRg66wN7ax2msyzmIbRnTESaBEp//umRy4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fXY8+xKk; arc=fail smtp.client-ip=52.101.195.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrU+oMe7drjYVwvHFMMhB/SFNIN51LQtKxKduI3JToX5xtZ2faxjb/X+fXW6dzLeTpxqE8GR0aMuVtfVaTxAy6UwZGnvyM19dLePZFkCb41mvbr3pV78tPe1DJf5UGbkLA++BA4rYDJjYSwIh3zx2/isha+zJCJIFQ/GBCwZjwLhlarCnO7+55vei6b2ACVx1gSX9IhkAcY63zeCYul+4xumW0xQIwojtz31nwhYEKdCGbZFuno0eTjOBpJ4rLKx+FsrOPxZVAc7MJfmUuPS5T+pw3SKBqO4tvgYCDquVzzY1Q0CBd3ojPchEmxa564WadYv8yxOPRfEeaIKTQeWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ac0jSELi7yKkjeaDaZ7aCndbA2axL93+ElTQ00gNBHc=;
 b=URh+QawKMQ77vFsVRV/LmPEQlAD8bgTs2cJCcQt/d8mHhhhQRHUyqMZ1e/hRu18N2rKSlWVdQrtbvJhir+RQwCEs4B1vxY4dM6MLpiqinZYCMMKcusvr9Q19ILXXM0GLQcA58pwHYOaJY+qriDVXUSfrMDErGHeP0ZbdzHD69/UuQRwYmj/sGuqLBWp7DK5HET/cJvFIi4+DNaUAOtsvuAQTbneicCWciqq9IODlAJ/ZhpC8yJz3BYp4GfoHWp4pivq1FsDifaJ+4AsPCcS8SzA9vakuMfLqBwItjZEfefnN85GynDDw3Gp01LqVcna32+oAH2Z6CihbgMuin/nXbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ac0jSELi7yKkjeaDaZ7aCndbA2axL93+ElTQ00gNBHc=;
 b=fXY8+xKk2/aLgGQEVSRls3VQ7r92nFXkE2BI6Glx2wWGCSrmGgLU7RzpmkdGA7S84nATaMGlctFMk0+nITh7AoiFYWT7arrh03iLpXyM7AnRa4xWIJb+4LIove8lbcijzHm1+Bcozoxa+AQDG2o0/CPb9DGmGw+qMdN75IiTU4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB3594.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Fri, 13 Sep
 2024 21:32:24 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 21:32:24 +0000
From: Gary Guo <gary@garyguo.net>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 1/5] rust: fix size_t in bindgen prototypes of C builtins
Date: Fri, 13 Sep 2024 22:29:21 +0100
Message-ID: <20240913213041.395655-2-gary@garyguo.net>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240913213041.395655-1-gary@garyguo.net>
References: <20240913213041.395655-1-gary@garyguo.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0136.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::28) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB3594:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9972e4-0984-4cb0-e137-08dcd43b8eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LPxUhICkMEoNZPpUFld5bHQqJNyBbknk27CvNjZchNtKQTycrdWE33ZHo5HC?=
 =?us-ascii?Q?Kx80bdqmOo31fL5zHdtT8LNGTU9/Uodq7WiFZycy5Af85l46g5qiTWknFOFo?=
 =?us-ascii?Q?621aGZD+rS8DNOxqGRbiORSJV/6km/enf4YD7x2nKSVAXNbxVF05gFlaCF8s?=
 =?us-ascii?Q?a+swyrySxKfVb7uT7Tnoaf2SoLRmwM5X1Zex8zYGgsEhMU7rqYqzdosd3z93?=
 =?us-ascii?Q?MkwTqTYBUfn30EJsKft0Ba8+MxZbAyvo6IK9MWMDn3qagAptC0QBTDqj6DFo?=
 =?us-ascii?Q?/N7yLwIch04WNvOkWmJVv4jrrXSua7N9pTpvdyXfYLzGFlO0/AqhHuvkutKW?=
 =?us-ascii?Q?Vga985u0PjAi9eLbM6ma9eYWIG33fh0IPVfhbcigpZfB1gUD65YgXkJ3uAp0?=
 =?us-ascii?Q?9O71TOvCv83946eolZmls8L6tjgBS8MLk7R40Z5FH8kEttpvEE7t40w/It+1?=
 =?us-ascii?Q?WyROJyn3JFO5aTNLs8KyR81YiGRuwiVW4hIvDhJrxAMgKof5NAKrizunqiEn?=
 =?us-ascii?Q?hCrSl4eys9PrGaMy55vyGc9ZPXPf2vgArBHsquQEzmsOYURs+sFoipvIw+SU?=
 =?us-ascii?Q?/ilyQM/1Oebo7/zlRxbq1vlIIdNwgFwIS2I7vmH5q11Zaa83r8zYtxY48h0W?=
 =?us-ascii?Q?bVkR3EDRqzSb8yXixpvDQb1CXjWXF0Gfxsioy+fBE5bdlYbC9VUHyUAglnjQ?=
 =?us-ascii?Q?ZEmHBE8pv2kRFdcC5+o8/qnU/cqVz1lbhz9LIpYidveYJvBmGrgQS9BCGbkQ?=
 =?us-ascii?Q?1JaKAGzhKjm6ULJKJn3BN1Q5+E4PFIbe0LoxOIXAKXCqQoNZAEaBtFb28Ssw?=
 =?us-ascii?Q?mve+nNvetBzkqjSAih7a6h24G0NnH9RIngAGCT+lWv6lCYIZ551dzWqCE/nS?=
 =?us-ascii?Q?2o1sg9B9rKRZC/6FOE2CivFUbplDmnYR1sKA7VtKKrDzFpInN19ACTkVm1s9?=
 =?us-ascii?Q?0ZchtudkiX8HfZuBwKV+PZiT7J7l8OdFBub/NBsuL357F33NzlLVhejLd18i?=
 =?us-ascii?Q?yQhPTN5Sq8YIu4cFFDB51rCthm8uNN0xqg99TLMafLUyfHSCXN93LTUqgHsW?=
 =?us-ascii?Q?c/7Je15I1jhzZaRAoiJf4gDeC2tzG3hHHg1ruA/7Mc8JaieqSA/XSLh3Tpko?=
 =?us-ascii?Q?4h4vt8hUUwnx/HngnjPoP6+9P2R0e6XMCvduPMuxhJfWhxTexRgr8561lscA?=
 =?us-ascii?Q?OmHYz4/Xpx4aGwEjVOwSxaRHb749ji/K0WCHjERotV+xVW/vC9jeEy6xEncy?=
 =?us-ascii?Q?7yrVgkWnzK4DkfS9VacfYYy+flmOWCUMDkkfDZ74TIHOCLJKecCznJ7Ju+eK?=
 =?us-ascii?Q?j1YySB6/DOXeN9ISNn/PlDG+RengIofrX1WNT3sRlb56qj1uLAhq3j3el04Y?=
 =?us-ascii?Q?zsU9m7OuaTlNUQCBAO+sb3V3kOlU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UIRLq5QHzZbhB5ersE3thw+3y36YoKG/X3AJCfF8574t7vzZekCkiRVm2SoS?=
 =?us-ascii?Q?/EMNLDgxIYfTbdKn0xF3mD7q7QW4uYttlDwdjReZt0Xrzmg+7rSElnltxpgL?=
 =?us-ascii?Q?/64DGm6bNXUja3L4itrRRFcxhP70w8XvvP8pomh5Oh27dWoqoJcrlIu6ZzHI?=
 =?us-ascii?Q?ftsMxniy9T2YVR94w29kXy0VGvq0sncpXz1X3vaeIgL65x0w0bH2U/Tng/5i?=
 =?us-ascii?Q?kUeFvYong8P9KnB7c3aYxxUVvqR9jt76P95oQV+jtTeMM3m5rIoDISHsCmos?=
 =?us-ascii?Q?geqZp13CRX57/bUkWEEluVgIA00ICGsu8fLabH9QLzndvPgrNJf1bneVJrjG?=
 =?us-ascii?Q?4thnK7B+WBv6+9IQ1yt6ymOcdqM6OTYaL3AVvIx5nNmmcTavJEHB3zYlSC13?=
 =?us-ascii?Q?70y7KLetEJtQsRVsa+QUH7k9kX1v4lu0pSw16ymCNX9JKVzMxQ++4pMKgjDA?=
 =?us-ascii?Q?/DMzV7C4H5sovZOBEqHvWIPnUqx/2JN8hR2VtMqdL0lJb9uCL8pDu6+0YuX0?=
 =?us-ascii?Q?LQRkQsJW3dwzQ3wpHxVLOrTjMnGQo3MIE9MhEJIMkDcATMAsGhR+3jRR7O95?=
 =?us-ascii?Q?fNEkCVDozoMNRW5ytyYtZEBnLH+kFVbSie4c1xG3yUNSW+LN2UAvNvXm3YMw?=
 =?us-ascii?Q?79FvxBrXgiIM+ClmfLLDfG2ZA4WX/GuGuUEzj0real+qc+V2N7gAdEGB+gbT?=
 =?us-ascii?Q?0G32D4VElHBrHlDuwTZWXmIfBe1HmiAsY13Wr/NJ9BHYh65Q+FWGsUOAW6A7?=
 =?us-ascii?Q?wfcukVQn9aatdS4CR4zYMTonMdELLsgP8KdBs67o3fG5b+jrMYaB6oFP524C?=
 =?us-ascii?Q?TmHdBS3oT+qtH+7xQLb2EiDpc+GEOCrk1YhxcGq4F1p5KQSkQD6J7hw9Oxd1?=
 =?us-ascii?Q?VNABjJbaiPW4gY+zgUFcyX1IOwFnfRbWL0VCdzuHEzv80LW6CdvmCrwtXMue?=
 =?us-ascii?Q?6f3xcQUsf9TVdcxfW7j01upsC3ufTkr8SahipRTApOWgFI8FduHpUbBISUB1?=
 =?us-ascii?Q?XozJa4Rs8X39b6/IXTf1nTCPzJNfbUXjlDU0dsRuyBO9Ik+WBhxAFyqbLSR4?=
 =?us-ascii?Q?elFzTgUjorzeMUL8jegtgES6bf2LjfrotxUip1ecZR9TSB45m85bW0vpOn9U?=
 =?us-ascii?Q?mGuS6L7jqcb5J9A/z89/SIhW+LHJv0pMYc0uBN36rKs3yYOd82Ci1XvEeev/?=
 =?us-ascii?Q?xzOfcI7K49J5HCkL1em+wA7ySZ5VaII5eMqlATM/7tus27Avs+pffV/DAYjn?=
 =?us-ascii?Q?de0iOz4VDV40y5FpVntUfh3fQoArk5jXZ/NrjbZmWdFVr7enn9x64n97gxcE?=
 =?us-ascii?Q?OAH5bXTcOZqzXiHKxTeQaq8VaMEnXjLt6Se4wUIkHVx1Ke4LkyNtSNLn43TW?=
 =?us-ascii?Q?HlH5mUB6bNKu4O5VeAlEOqHvIckm16DOopo0RPUx1RVcMEPr4OOlHB+Yzgju?=
 =?us-ascii?Q?nW6TFcCSPiMsxyIH/9lc7P3OPZggGNlNIqrdGlrYAR1ZSgkEyArD2bJgtIeQ?=
 =?us-ascii?Q?8ZWy2kq2K3+mw1WVG/D+xNOYCRA12rSOSChSEJWXyj3ibq0IWesHbeMLWEPg?=
 =?us-ascii?Q?Fs1Jqb7Foio4rAUmShW84jkXcsaRDRHKFDRGGWoJ?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9972e4-0984-4cb0-e137-08dcd43b8eae
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 21:32:24.2998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfi4eZ05+UzS1YYYPuh0JVXeEqlAuVWSiYhiUfdFmJSF8Rvvn2BkepY95iXzgwZTQidlqECM+R0hsw67ITqEOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3594

Without `-fno-builtin`, for functions like memcpy/memmove (and many
others), bindgen seems to be using the clang-provided prototype. This
prototype is ABI-wise compatible, but the issue is that it does not have
the same information as the source code w.r.t. typedefs.

For example, bindgen generates the following:

    extern "C" {
        pub fn strlen(s: *const core::ffi::c_char) -> core::ffi::c_ulong;
    }

note that the return type is `c_ulong` (i.e. unsigned long), despite the
size_t-is-usize behavior (this is default, and we have not opted out
from it using --no-size_t-is-usize).

Similarly, memchr's size argument should be of type `__kernel_size_t`,
but bindgen generates `c_ulong` directly.

We want to ensure any `size_t` is translated to Rust `usize` so that we
can avoid having them be different type on 32-bit and 64-bit
architectures, and hence would require a lot of excessive type casts
when calling FFI functions.

I found that this bindgen behavior (which probably is caused by
libclang) can be disabled by `-fno-builtin`. Using the flag for compiled
code can result in less optimisation because compiler cannot assume
about their properties anymore, but this should not affect bindgen.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index 4eae318f36ff7..863d87ad0ce68 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -265,7 +265,11 @@ else
 bindgen_c_flags_lto = $(bindgen_c_flags)
 endif
 
-bindgen_c_flags_final = $(bindgen_c_flags_lto) -D__BINDGEN__
+# `-fno-builtin` is passed to avoid bindgen from using clang builtin prototypes
+# for functions like `memcpy` -- if this flag is not passed, bindgen-generated
+# prototypes use `c_ulong` or `c_uint` depending on architecture instead of
+# generating `usize`.
+bindgen_c_flags_final = $(bindgen_c_flags_lto) -fno-builtin -D__BINDGEN__
 
 quiet_cmd_bindgen = BINDGEN $@
       cmd_bindgen = \
-- 
2.44.1


