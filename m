Return-Path: <linux-kernel+bounces-186266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0EF8CC1E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B959C28222F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BB813DDCF;
	Wed, 22 May 2024 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DjSANQ3j"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2175.outbound.protection.outlook.com [40.92.63.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9641F16B;
	Wed, 22 May 2024 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716383859; cv=fail; b=kep3VNu+MvQXs0NBoy8vQN6KRCjLpSdTNnPYfrC1rV/h9p8/bLpVHoFBSI+JZc/uLShiQDTuJLa24ENRPdf1WeVQw6dPr6C4IXzQphMUuZJB5+I68NkdRP8ozpv0UzQEvhBjGpNcy4C0Z4RAKrhomafmoyi2PQgU6fHCClqLllY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716383859; c=relaxed/simple;
	bh=tSbTIkCc50DPE5cjbyB+9e1x684cU+zGfpSOBGYRQjg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Bpx3luxRovkAkgyAWrq/422vRRstfBHb2v00T7jNwgef6dD8MXgHqslD3NDXFoc7byids4wMVMZpDTwuRkeM/A+eoI/IaJYPV0ahkIJTTmAPFbbbrMu+E6PYh3W9RnSny3O9vT3kjuZMxPkOGJSHUXb1N0HBAdhv1orgdk993fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DjSANQ3j; arc=fail smtp.client-ip=40.92.63.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibroS7ZvMWV69KfHxDkLtJevCILdZLPXugbW8k7r+TCUGP4ei13ZVMVvBUX3MIJdWvmj6GDpAYW5xTS6xfxKdNsLgG34RDewHDT8KTzYAAmGCntj7KFE2kn2EBMItQrQVdycz5fUyRwEXGM6u+pSIplzgiV/EZW5dZMHzeUEEGVs3G59ctkQanwAC+51YcMbyII3a4gV/4RkErCsLEi+alaC007ZhosFoojtr20tl3da4xKQS+w29LeDkqhy9PG0VKeQYePEF3+H+FU1KyHQuarTbOC88UW6IDmqDkFsGVAcUqRJ0W+Odersjju74gy7I3hJ3KcXOdNRVgaVYpK+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOcOWTA3QEXCxZFOw+RLi6fSBNPAeCxgWPP8+kdLaQk=;
 b=batFOdXVXRy9GMaDkT1X0z1pI/o6pwFN2CxitNzZsthc6lgt0PRXDeweKCLoc48qMA8f1IynDjWywynWlSXYv2bNtge4nXdOfzknSxlG5M0G1UqdrG4+yhb+MxRfFJKqSkPZTlApdUeQsw/wbXuO3QlUzCL50A+vSuoSTThQaJeh77SPBeWBQd40CP3Qjiae1Uqnzb076erYAxXuY8VE0zSS7SidrfT+9Mi1UKzbgWK6ktrC9lG8hEFXDSSw1KI42dvYPF4q1mjQ6n3p21zsBzU3+7nZkQpmR3gfKi8kJsz9NZ6zqLZdV+ohQRBVnKqJP0HWk0bQdvQI2x247HnuOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOcOWTA3QEXCxZFOw+RLi6fSBNPAeCxgWPP8+kdLaQk=;
 b=DjSANQ3ji25+pqAxJmu5j5LPKZwFiNbupCDC2TpQYtKgL+LvvBS+G+iJD66jx8HYIVwFvzlsYq5HSKvjDYp4a9/a61vGw5xhLoI0XOEFYKy0mIqAHoHReV7/DV2G+ki8uO+nAdjRxtplNNCq2aqIOnHhBU7fcG+qOFTDWYAjZapB+OukfShKf1HkV+Sz8mkJ1czXUfSI6KjHrGGWdZuMTgoo/5THK4/b6BaI3w/PLBtPLJvcegZCmqDCqiPeVuIJol43AkN0R5AYnpi/JR2Hw0V7QjLgbNu7ZPKfiR+Ntf4+Pvus/X5RTlIvG9TmUl2VmH3SkQ6Z/dz+zEBzMNJVKg==
Received: from ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:228::21)
 by ME3P282MB1747.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 13:17:33 +0000
Received: from ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 ([fe80::d384:a02f:2370:f33e]) by ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 ([fe80::d384:a02f:2370:f33e%7]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 13:17:33 +0000
From: Roland Xu <mu001999@outlook.com>
To: ojeda@kernel.org,
	boqun.feng@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roland Xu <mu001999@outlook.com>
Subject: [PATCH] rust: kernel: make impl_has_work compatible with more complex generics
Date: Wed, 22 May 2024 21:16:33 +0800
Message-ID:
 <ME0P282MB489023110AAF1163F0A4B2E1CCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [HpMDJ4BWjNoMP++jx1jEvOTPDAkSYJ+RbaI5cuY/GqY=]
X-ClientProxiedBy: SG2PR06CA0218.apcprd06.prod.outlook.com
 (2603:1096:4:68::26) To ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:228::21)
X-Microsoft-Original-Message-ID:
 <20240522131632.294442-1-mu001999@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P282MB4890:EE_|ME3P282MB1747:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a7ad79c-d884-4d04-0500-08dc7a618a48
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3430499023|3412199016|440099019|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	q5ucmsJpPZGTNItzo+GtZ1OwJMSTQljaI1lI8w+JkcxHMjywOu5HWzSzJJm4Xu94IrRM3+VqE7kxtaR+FFBBTmE9zOMV8+jQY5UmOv97twGAV8hyjqpbdMZIuZLvNdg0tacrtd/yXfuHQj6EmahmpSmxcB5ehpIZg/Au0qEd7m/XLwOPglpjB5L5M3W7syf9MWSTK7p0XyCM7IpmEz0LZicBMI8YjXzsCi+3RLQl9oxH4rVNugurHdRt2vq0MmoBaqnrkMye/dEi7lHfnSNtTeVXIBy9VwANVOlUaWgjgw3zU40EkzdXlkeObgTGdk7pzImQrYPVCoPZm70VRft8HlzLrLLcO4y0aoT5W7h0JSbMisL0J2rJ5BUwFAvM+o9Bs+ZnxhJYNSJJ5z/1cw/W5KTQUroxM6OmKediqRp3swgjDphOjvp90jj2a2uOXjrk23AcVftZwRv/qmDU0XTxUIIf60HM35AkABQp4J7rdSteAi41IKdlmc5z8/qa4Lmb+fSOgKvGF2D1xjLDteO0REudDuFjbFF/cQM1XJ16VOwEGviz0xPwr4cuyGX8anddnxQrryhQnntG87T5xdCq2kkHxWtObjC0VjW+ENbo77TGiEmr1RBIBLDY+nl2K38/QyLLoJahPp6ZWhAB87lX6jLEk/CLVWgKyFXw7WqXuHJjk5KOXNAqYUF5jsmagNW8
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kbyXEvtbHfRAXTaM4vticpiT3udGuNSxXIWc0RHkr6ECJtsD0ovWjlWUzbga?=
 =?us-ascii?Q?gZFUQebJi2ktPkeOOuijfD0Nfk8iyr+czGqAxODjXKyf/fKwZ0/fxyo05Iqk?=
 =?us-ascii?Q?OEC73/w7XMWxMkOvyLX2UwFzlWgOsPDKvUvsya+Pj1VlatZiVGVah76d7HCg?=
 =?us-ascii?Q?IHhVxvrnQ6tA72Meuc+wkOTBGg8UpdxYyh7TMoj2GYDy4/Ycgy9a7ji+7x71?=
 =?us-ascii?Q?20mYcgejLg5na6uOukxT+74pNfrN/V+dl4rwSdG/q0Mdc3EsznOwI2p/mS6A?=
 =?us-ascii?Q?MRuTTO9iRxQNls9VXMI6ByVpdsJuq2i62ntrr5xFdHaxtDwSS1EjOI3w54On?=
 =?us-ascii?Q?iXxkzShBCFWKte3I+DQ4zrruemYd98Th1YnqHinuf1UdmufW1nujMmNwDZnM?=
 =?us-ascii?Q?DupjMy4aoMuoRMBPsYrqZIUbLZoPSQQq0Wxz3w0AapH/2sTiaO2sa/le6b4p?=
 =?us-ascii?Q?NLNmEBg53vQRqaVML6//zcdRCElvy2JoLHhnYiPLtAdr4WNa9QXcMiR3ARXg?=
 =?us-ascii?Q?ygOR+J2+GSGXPuHXClkMAkCc9szQQXuvAjSd8OBxaLXFJRTKX95lhrbtVGHQ?=
 =?us-ascii?Q?Taa3Jhp4xM7I1ndz/h/MbPvhznAMl/dns/OtgXE2SMimIFc3L4YZKhUvGPSj?=
 =?us-ascii?Q?nev4LSAnsdrrPxo9CWo/B9xlavssZbkIX0XJtY3ZpYpBhNbkSp6tMfQrppXy?=
 =?us-ascii?Q?f3b1FcdXEzAKl3cjUmeQyydLnWWaH1LWeDVW6VOf85uQohQ+clzV39Xarf8Y?=
 =?us-ascii?Q?eCCVPeWpvvyulkJzhqVVe7t4SzNnzSDdDGQX2eyvVlM6WJCfUB5OyLQ+P7ad?=
 =?us-ascii?Q?tybkHWDj6X/r/jRnpGwQpb5TrWKLizvT8nEawN6X1ufkM/hUVL+46dkgHfwr?=
 =?us-ascii?Q?gSVvWsthToQyTrX8/bAHWZq40DPO0fsCztk8MIWMK8YorvKpZd+Wd4ApmUPm?=
 =?us-ascii?Q?xvHbsyCgMLTGyDmb2SkVCmuVYyIcqTvLahkZGBukZd5qgwu2VqgT6dfTwtiZ?=
 =?us-ascii?Q?THX9OLe+aAoUXDNYBc2KzQe3ZVSJgfE140JJfMpcLE73Bs6iaeEkLQwzPjQV?=
 =?us-ascii?Q?VBEOk560QHFg/UhMZOkMpCbhw8PWiecnftrt0FXZJQbSAq3WIgRTTFvzCQWl?=
 =?us-ascii?Q?6dNwsmOactNhkF58MxQV4Bku5DpeXq1tRVO08/J5cw4RGd9isO7WlbA5tgZf?=
 =?us-ascii?Q?hdbN/DIABcKy0umUpukTerH72tquqt40bHgrXp/Ud4GJklolOPpzdvoXySs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7ad79c-d884-4d04-0500-08dc7a618a48
X-MS-Exchange-CrossTenant-AuthSource: ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 13:17:33.2309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB1747

Make the impl_has_work macro compatible with more complex generics such as lifetimes and const generic arguments.
See more in https://github.com/Rust-for-Linux/linux/issues/1077

Signed-off-by: Roland Xu <mu001999@outlook.com>
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


