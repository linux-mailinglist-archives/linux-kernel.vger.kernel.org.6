Return-Path: <linux-kernel+bounces-186220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CDA8CC13B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782A11F23D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0B713D635;
	Wed, 22 May 2024 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KSunp74n"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2141.outbound.protection.outlook.com [40.92.62.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718358287C;
	Wed, 22 May 2024 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716380869; cv=fail; b=eTfRIGGiUIEF1TnDscQnYLwzeNyVTOENFl/63z0SBCT3Ge37q8VSmmf5TUVKTO0FmTxtCCzJabCa58kfximmEZOT2ko/yBfOtIQyi6slPTociCdfzbcwJVKxjXgpBjcx7anqzzIqYdkpl3B2bVF4hHCZgaYxqUlQM+0kHGwHp74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716380869; c=relaxed/simple;
	bh=G953yS5FUgdPdfjKmuE23S5ZKLsYS+v+wOEE1YYuiRo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mttNMFCoWdWY/FB8KqS75GfEcwd0Hw/cbA8OtX9JDy/zCbfKyrws3gu8f/71Z7asNIQyy0zTxe+iybv1yT1Z3tJOij2kOBRa8g8Xt7FAwrXo2rIqtDSjlxlDGP5YYn3ONBxc9H6N5PFY1/qBpNgEo+1MloyY1zTFVe0hd//Q+lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KSunp74n; arc=fail smtp.client-ip=40.92.62.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBirbeB0izVOVW5Mwp9QfnWu+ROAETPvcm5kDWjbPxqen8fjpTyvy7L6TgdjdtbF3SoO6MaNyLBEK/YCc21J37ICFJeGT7dIJc28Ia0XaXmk2q0fvRSE0v7t49hIBWFRXOESzBAE1iaGHRn4xJIbe+7MHi1sd/yat1HzlPgv/ZD9CLqG1j7xA7aFNTixujCi7CxT1ZifIbqn6HpZaM1G2mJuRoMf0P/4DouAXOXJS6CMqaFzHfcX3A1NDbPCCbtmH62AIilKftm+jeXOqomBwPL9fFDDVPazuA/GdbMwV6OnQzTGYWdZXHTKJak09YVouXwn5gymxQ63mmqxj4eOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVy31cflwKbOAJiDRY3V4FWPxedKKcyKu9CpqoIIHaE=;
 b=BoB+KTo+2zAkqaviu5gWJKKxigZUeqLSBDRk8A7JOGYxbb5Zl9dYd8z3iTrvEKS0ZJbFjcmwvBniJsFGVy/EVdBfII1O0YCuHB9nEKM6fIaf0i1favrM15hb65eHMjDzSltArDxkxJhVgRICvHzZPQbtAx7bDsaL2cKP2IHHRjMTpHb3zi/RpwqXjs1aGE7VjaqcjdREDDVkFDAQlTqqRzdeo4qQTtf+cGPuZuLV7YDGKyzlCGj8hkp4QM9EDhi3lVnbYoB0PYAJ/AqcO1xtm4gZdJYhIeix+562kNco9gMrP9bV6V7LNgEtqpQqmiCH9vcE7lgsr3b9coryNJxqmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVy31cflwKbOAJiDRY3V4FWPxedKKcyKu9CpqoIIHaE=;
 b=KSunp74nkgO0xX6I7yz0q/wvRhPWMRUG2XeIkk6OTrxF4qyufOKQorVcaUfOX7ETzmScnufDZr8kckjpfVtV5MRygewuLPJd9xxX0NWkROtN5wFzQ4YnsTlzhuN/41qGbgyfg+oXOXJVocIr0TEQeGtH+dU+wGPA/CQu7wIWrYMzsupg2pnbKmXgRY8YAEn0/3IYs7j+od8zx/mbPVXcNwqYvtKid/+ywoS3hKPJoG7BLBZw2iYIQYAGFwAbQjS0AbWMbHAcEgnhsf7jfc48SSbHNwo0JMpzXgXTpyNAXZ3ikcXHwFO4+AiT6s1QJ0tu9NCxr3GTgMZH5MVOVHQSWw==
Received: from ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:228::21)
 by ME3P282MB3492.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:189::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 12:27:42 +0000
Received: from ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 ([fe80::d384:a02f:2370:f33e]) by ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 ([fe80::d384:a02f:2370:f33e%7]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 12:27:42 +0000
From: mu001999 <mu001999@outlook.com>
To: ojeda@kernel.org,
	boqun.feng@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mu001999 <mu001999@outlook.com>
Subject: [PATCH] rust: kernel: make impl_has_work compatible with more complex generics
Date: Wed, 22 May 2024 20:27:25 +0800
Message-ID:
 <ME0P282MB48901A79E405F9CF615FF2F1CCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [RRXUrFn7JKYdFT/Fwe9a3+BAvW+U9nXF]
X-ClientProxiedBy: SGBP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::18)
 To ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:228::21)
X-Microsoft-Original-Message-ID:
 <20240522122725.277401-1-mu001999@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P282MB4890:EE_|ME3P282MB3492:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f23a7b2-5ee9-41ea-9bae-08dc7a5a9378
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3430499023|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	eXu4a/IFoJuCvoW3K5oPeNmB9somzYWp9M4DdVtBm7kIWwscYlENZ1uG4vVz/BJTE/23WmJXIa+mXrZfRnnqvg6LyQPDLUjPUoCJdSy9qQBQpHZ5ijdG8Yx3fzJv39E4pANXp5KfJlumod9jrSDOIfX/XN+s2bnAkBMcNaHn73ecXZFeq/FyyFw+/P7xLMjvtMS80o2s8Qfaem3a67oaAhn0kI5LYkj6Vh/oJHhmGzX02TGBin4OjMSAlUmOiV820lMc6IDLVSWhEHIf9sYU7LhkbhgWHBcrI1llvIh0i7csHCzxCgs0rthaBNf2T0bFikj/kguwNreRWaGHxF/eaRsqEQYeQk7aTqYntKSuejMFDfGuo5Wqa7UFbqT2fOIBlfSsngKpo6jmL7VAqtNSaDybUCbaAfXVM70PsZAiKVAzBFDZea4kBKzMoi6OMHk8jU47g1W8spJTXPOco6RAdsVLv/w8yzLo3dTpDGQpHF8EWDqel+h4PSKAUGisJb4QKJTgo6/EKzj6LuR14X68SwYcLiHompwxAgulYoFCa4wF74Y4PbMA8Zdl4vFR29otQRx4Y6r5Co/Y6KYd/Wb0skMbcBd7Fi8GTcCzjlw4cDA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZGVh6Np16H4e0AvSXvR2NlC6ldHs/x5KLXq1lodMLRM2/M9FYd7og+LwzWFM?=
 =?us-ascii?Q?jDG0mdHG0AyTNYGOsGjlTaSJC2ppZWKqzbhoj61eJvSOQCBQ4KthKzGUzN8t?=
 =?us-ascii?Q?0+9/bngYStTTgKB9H0j8QfKIoPNM0R1D2gmTYHJxQCt/SSR9FO/QDrstapxQ?=
 =?us-ascii?Q?5wO5RSyUpR7rPNYkoy6pP+eD1Pfwbd0tMKjC8c8wrW07z6v8X7c6v9xQ5bBc?=
 =?us-ascii?Q?YssSUg/6cVVDONGumy5a9eWijiyO54zW6C61ccNxMdYaUzCEeBylMxhpwwO/?=
 =?us-ascii?Q?wsSxn+XYmhPJNMEPatFAtHNypT4syLIhp6fxZYeSKU/WmJ78Y3ZeYu48tkNv?=
 =?us-ascii?Q?EyzzKKnrwT7PuEhBP1mGqrJozUdwNtecy91S3TCXNm4K132wJUczndBVmqva?=
 =?us-ascii?Q?Ok4r5GwF4F09pL0Vk4HlKlN9B0Frf+rfZS/7ABB6H/mlPMjOZuFE0zFadXjj?=
 =?us-ascii?Q?7NLVKt2zQU8v3mA+TS+EqLkU0ZRrBF20kEY6AufZz/P6r5eEyUT+xqcUyv2/?=
 =?us-ascii?Q?WatmZ39aXabl8Sgst3FB3NgbIbj2O7OJf6MmNsunYm6EFEohTaVu+onNCbpC?=
 =?us-ascii?Q?rAswdaEes+Pzck+e9lgYaZh2fxKV79ACftBUBRSfBtt5gXlQFSy2BnpIfyWd?=
 =?us-ascii?Q?gNo6FFH0UIIF3pjwH8gqpq4TpwxBsvk4R+FepelnMjFWz4pcLqKh5od7+1zu?=
 =?us-ascii?Q?uzweyjxEY7lDJmcl9T/hR2VFQ4iyBmgnjYuuJ9M7re7Xoai6YiPsUJjYiINM?=
 =?us-ascii?Q?Qc9CyZYmZk+8R0YIAe80MgP7fdkj3r+YZ3qo4VQxq7Sfj7J/pCmdCt4uPmcr?=
 =?us-ascii?Q?FoDW7v8cLTMrOCaD5XaHNBwES4bluGAcTrE7zeCV0/EK0H59hHSdNB4YWdiJ?=
 =?us-ascii?Q?xzNO+ibNjVQYylXuZmT/h5Vlba9IJA+mkrOxXG+AEhqPEYJPTQ5+ROtmrykG?=
 =?us-ascii?Q?1qtdjQbN1obBwNE0SEqJYKft3D89HviLOf/OjXqBU65PdA/HpX4xsiwL98nZ?=
 =?us-ascii?Q?kMwiTsRVSCVDQWCV3uTXorVhEXZglt2AB62SbUaK0/neyJ0SP/PSr5Lx3dGC?=
 =?us-ascii?Q?U55d28tgaXNCtcFaOB8bsLncjfVIfsXhbB29//dVu3pLDnP9M2oVy+R5VRQ4?=
 =?us-ascii?Q?WTT2Ff/WxssZerYah9658DxSlUQnTFCos5zTl7Pm8ANFGkh+UBLReHuoTcK/?=
 =?us-ascii?Q?bJNPthKGvjIm+k3jJ5znE9KZhF5MdSH0ntD0Ziscc1n/wvv/eDTuvp7a9X8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f23a7b2-5ee9-41ea-9bae-08dc7a5a9378
X-MS-Exchange-CrossTenant-AuthSource: ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 12:27:42.1646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB3492

Signed-off-by: mu001999 <mu001999@outlook.com>
---
 rust/kernel/workqueue.rs | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 1cec63a2aea8..1ff81d88b61d 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -482,24 +482,25 @@ unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self
 /// use kernel::sync::Arc;
 /// use kernel::workqueue::{self, impl_has_work, Work};
 ///
-/// struct MyStruct {
-///     work_field: Work<MyStruct, 17>,
+/// struct MyStruct<'a, T, const N: usize> {
+///     work_field: Work<MyStruct<'a, T, N>, 17>,
+///     f: fn(&'a [T; N]),
 /// }
 ///
 /// impl_has_work! {
-///     impl HasWork<MyStruct, 17> for MyStruct { self.work_field }
+///     impl{'a, T, const N: usize} HasWork<MyStruct<'a, T, N>, 17> for MyStruct<'a, T, N> { self.work_field }
 /// }
 /// ```
 #[macro_export]
 macro_rules! impl_has_work {
-    ($(impl$(<$($implarg:ident),*>)?
+    ($(impl$({$($generics:tt)*})?
        HasWork<$work_type:ty $(, $id:tt)?>
-       for $self:ident $(<$($selfarg:ident),*>)?
+       for $self:ty
        { self.$field:ident }
     )*) => {$(
         // SAFETY: The implementation of `raw_get_work` only compiles if the field has the right
         // type.
-        unsafe impl$(<$($implarg),*>)? $crate::workqueue::HasWork<$work_type $(, $id)?> for $self $(<$($selfarg),*>)? {
+        unsafe impl$(<$($generics)+>)? $crate::workqueue::HasWork<$work_type $(, $id)?> for $self {
             const OFFSET: usize = ::core::mem::offset_of!(Self, $field) as usize;
 
             #[inline]
@@ -515,7 +516,7 @@ unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_typ
 pub use impl_has_work;
 
 impl_has_work! {
-    impl<T> HasWork<Self> for ClosureWork<T> { self.work }
+    impl{T} HasWork<Self> for ClosureWork<T> { self.work }
 }
 
 unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Arc<T>
-- 
2.34.1


