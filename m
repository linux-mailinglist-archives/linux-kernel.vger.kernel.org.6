Return-Path: <linux-kernel+bounces-186475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28CC8CC4A6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D5BB21CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8927E57F;
	Wed, 22 May 2024 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Gv6fMaXL"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2166.outbound.protection.outlook.com [40.92.62.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8697D1E517;
	Wed, 22 May 2024 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394144; cv=fail; b=Sj8JYbX+vT7SJ22yM51zUZsLeoWwU3eBkaFsR4v/E8lv1gRxIC0z3ujz5UX2TBDwXihLbBXtN0roSO23s8lftsVPWPj+v8aA6MRCrhpN16IypknbyWMQJUoPJdaF55nOJvA+9By/uLM717xT9cPPZyCJUQREpWSP8ITi1alVrlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394144; c=relaxed/simple;
	bh=aSumU7yZKogsyyab2peEb9XJbA3MnbXjmx8KmlGGOVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KgXy8k9mIawuntbsidtNd/M619eG8NmLXUdk7sgsaSTVq9Qkf0qcg6SLXoALXdmf1+EQkgHYSrwU0NSPtw1FHO/T8pG7SRH4ppQuQOlJxKo7F9ssHGecmTpNj4j830p8eAqPEs1Ap0uxSyEl0P8u/tjl16jwsP5Y5c73Y1SNQ7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Gv6fMaXL; arc=fail smtp.client-ip=40.92.62.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Orf6+4wc/TYu7lR2Ei3ISv8L0iPXCHgMfXDtX/3C8EZPk7BqkzWzwRNRXVGbhGEGLbOmHlL6Y6D4M+eqX1LUbslfKmOr+cRQ2vBhrWE7fkmOwGKszMP/bKYgbJrU/nivzo5iD8kfux7eHgS8upNkVJny7rc9rAb1J00rPbHLgeh0pSDD1n3rBjQ0WLp/bCiXOo1fON1cgy+orBLAs0f+aPkvKYQr0TsaHu1geYqXNPRmzGGk0Bp5fsk1i72RCA2756SClcaA2VwouSvOzOk/aomVYsOdnuWgXU1dRdbDqk+ornnFMJWzAO6HYxtdW6OJ3I1Ds6BCDad37e9uOeQ1BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+w5ET4bym7JhzelC5gBr0IQcjfrLGWgfoTMokwgMwo=;
 b=Rnj8Wnhue5Kh8SwHqWKjV/255V5pze/YhdoyI5Cj2ZClvshnNLN1jT4OkQ8U1QrdDKuKZEmZMw9cOE4pcvaVBAGKi8nfEi1msMBdrsK2mvdCnov7P2jRg+gGM+2vsnNIMlASxk38DKFVKrZlXU2r/zAKUPxzDDNMjxgl6WpY9r875fSiP/VijzVzm3lFa36XxeK2cTDSmW33/sRyYwGBYrdZJ3+0aWK+YldRDNAuessBLgV/BBpAL8DqBm2hHA+TdmBSvmosNIEG5vQ1OpgcZkP7145Iv2CLPWsWQ1mjheuiSCwyI3YyiXW2l19G07W757EwNRacMkbRGFFmdOAtQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+w5ET4bym7JhzelC5gBr0IQcjfrLGWgfoTMokwgMwo=;
 b=Gv6fMaXLZ4lwyKM98Bl9IPo3xxaSHlOxzuxYIXNbtNwIU0wJqvMlc2bSaN8650m31Vv8kmujY1oHP7gxlLCxbAHKmghUYW4Ap6nQY2Xa8rOw4r5U7i+wQV4/+UoJ6MpWkdGxANB2pWEGND/ApUug/NGGO7ybsfBUWE6bWpVfxbCasFwqOs6zLDrOOYOvymQ0WiWp/kExjaqvYZjhOYAlZqAt3uFYM1Byvda1aAfuAdpPlVBxi0pXLbum1xS1wr10XUdyvNDNZS49PcyXBWpG7iQSm7I5e25oVAUuaZHRZr9pbsbaCGXM+kdowrD5DXUzQZqIu7ivfWuUEieNqkzO4A==
Received: from ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:228::21)
 by ME0P282MB4953.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:223::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 22 May
 2024 16:08:58 +0000
Received: from ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 ([fe80::d384:a02f:2370:f33e]) by ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 ([fe80::d384:a02f:2370:f33e%7]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 16:08:58 +0000
From: Roland Xu <mu001999@outlook.com>
To: gregkh@linuxfoundation.org
Cc: ojeda@kernel.org,
	boqun.feng@gmail.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roland Xu <mu001999@outlook.com>
Subject: [PATCH v3] rust: kernel: make impl_has_work compatible with more generics
Date: Thu, 23 May 2024 00:08:46 +0800
Message-ID:
 <ME0P282MB4890A180B99490CC65EF64FDCCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <2024052258-trifocals-engaged-8d80@gregkh>
References: <2024052258-trifocals-engaged-8d80@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Jt8uGj0j7cqiqmURAaGoBWGxTMSlrnVtsiUgwLZ1m4k=]
X-ClientProxiedBy: SG2PR02CA0116.apcprd02.prod.outlook.com
 (2603:1096:4:92::32) To ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:228::21)
X-Microsoft-Original-Message-ID:
 <20240522160846.2620752-1-mu001999@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P282MB4890:EE_|ME0P282MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e2df24-60ee-4dfa-90c3-08dc7a797cbd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mWtSJ3EJ9nw5nwFx/Kj3prgj0OrltqNnlLDzuisIkp9ina0R7Bhb0fP63rKrYs/3fhgPbTxJGLtCI1uINoTCWnpQ0o9B2Lf00s5HFvbmBWAZ7N98ptDM+Ip/K06Mjq/hRRgXOdOS7FBam9t61G2cup0FCfBmudcL34CgcNO11Y6xXcqlJSrPKPOkwHmwdX7dv9WP7y41CDlFLNumtDNsBVkMKIN3D2VGdjy4X7mx9H8ntmciozYP8euKwPunAXzXtVihwx8YIhN14JKnFGEhiysnBcAbUfO4sM6syCDTLG64tdQ/EO4MeT7QqvBJIZbVyq4AZDYxgxKU0msF9tJDDAHivd3jXODGbNAkwS/5jH6w1+GOpMLN1Krmxd77WQhACDJwJ8RofupnVI1wLOemu5kkhLwtiNtEKMFaf/1RUJpTjvklGY20ET8ELwgXnhvkIcQC0cL1Zjhxtndw0xCmVWEYc9CzLy/MxcBOIaJC5JjM/5mBIxpBBCM0NLNOYJxLRfXDVG0xABY3fV5N90QHMxZyhHRlWcjI4ZW+z6MPgpRcyIogoxIb+/c2CoHB0qnNhiAK8cZNW2/AOtHwgFjlmf72UxHJjkhTcjp6Liz4w2o=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?orxWL2cIxSqrhwNItweEutGA3BTvPQQb8lGhf7GYNuLb5R5F1CPpfN9i6Ach?=
 =?us-ascii?Q?mU/48/TYU3r+4tF5aC0GunB1XT2m1qHYHVCcll+QQjcXCsbWjiLz6RntyUNe?=
 =?us-ascii?Q?XRdmi3L7JieVubnqhNazG8B+K2fgoAU23FxraKlhAjzlytlRqo+Dui1JIc1S?=
 =?us-ascii?Q?W7mSzUx3xEdbUAR8ptcarJQ80/B4kY9DOkzypz3x3mZn4+GmQgXHohDmfmyi?=
 =?us-ascii?Q?2ZEf06DwBh7rQdlQ6bbkG1wUtVvNVfw05kH74PIDsSzkJ/RkYJ6ZaJb9ssFk?=
 =?us-ascii?Q?o4aWcQacDZSsanUKJ3B2MMrS+4xHxmKSq5FfuBq5LPGle46NIhnQuTTDtKd7?=
 =?us-ascii?Q?GPLYfZLoPZEN936YO/C9b9PHvbsQCgU8YxGIG0PPax2CAkaToI0W7fffVENi?=
 =?us-ascii?Q?CK85ybNlv5YUd6u70uezvIYF874xkwyFc2c1rXTHn4FKzKAscRknP3CyJxC+?=
 =?us-ascii?Q?d3+FcOFuqPY+XFgNiqr4urXUPzs5F5obzM93J2LuA+rJXqGBO0zCw7UAqB3i?=
 =?us-ascii?Q?7v5/EqhMDcieV0DJyfx2UTxU/sijduBrYYj22YVYAIOeBpNz3gKet7hNq9Ok?=
 =?us-ascii?Q?VMzrzDcP8MlV7LURqOA2mVWJDqHCVZ25+ztyb5L7Vju1UGOQaP1WlEcr4i+J?=
 =?us-ascii?Q?/7s7lB73WBnJu+Um4hoPLTfblIIXU0Tpdvuq6u4Wnb5EtCqxLA0cBdmM9Kjg?=
 =?us-ascii?Q?4fxE12GHkztoE21+PG+YRuGJSCbycPjmcNgNR85DQF6i3meRFKSf/jNxMQnM?=
 =?us-ascii?Q?A8nUJvVi2PdK+5Bs5YN2I4gcotE6codJ+g3d9hMS6pNBY674u2COB9/D4Wee?=
 =?us-ascii?Q?2Sh7NyyW5QBWA3IbpNZwQfLm6gwukfTNsTBYuRGoVpHMb1Hh5QSO/Qcek+ve?=
 =?us-ascii?Q?EY+zuzDR3BvtKHPHYzjxfv/awA9tcIXVpKYr22MGFp7WHsfjT+ENiW2xkQas?=
 =?us-ascii?Q?DfcBu6do/Fl1jHP/veFm/Mtkp0myhyjj1CrAOxPND9j0EZYGLPVbqFqV2K0Z?=
 =?us-ascii?Q?xa3MbWYxWh4LKHaYj5jN6EIPGxdnna8UdO9xvNn74jGwJ+zHCm9gHv+zlo7f?=
 =?us-ascii?Q?oQn7iCflYgjn4vIv8dZuXw9u3RDeTnCJT+qs8OkpxLBCdpUgfBg06yn6jPTY?=
 =?us-ascii?Q?xrY04hZYGRGNizB4Ej+cf7s8yA2o0qPvzSsd2BAR43WGFPNOrRWuZV72DqLR?=
 =?us-ascii?Q?Z3H6LGHVkAqZgrcEEAUjBxqfX3Tzh3Z+JzBydAiRMSYv2gC9Lxx4jqQlzM0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e2df24-60ee-4dfa-90c3-08dc7a797cbd
X-MS-Exchange-CrossTenant-AuthSource: ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 16:08:58.5026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P282MB4953

Make the impl_has_work macro compatible
with more complex generics such as
lifetimes and const generic arguments.

Signed-off-by: Roland Xu <mu001999@outlook.com>
---
 rust/kernel/workqueue.rs | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 1cec63a2a..553a5cba2 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -482,24 +482,26 @@ unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self
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
+///     impl{'a, T, const N: usize} HasWork<MyStruct<'a, T, N>, 17>
+///     for MyStruct<'a, T, N> { self.work_field }
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
@@ -515,7 +517,7 @@ unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_typ
 pub use impl_has_work;
 
 impl_has_work! {
-    impl<T> HasWork<Self> for ClosureWork<T> { self.work }
+    impl{T} HasWork<Self> for ClosureWork<T> { self.work }
 }
 
 unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Arc<T>
-- 
2.45.0


