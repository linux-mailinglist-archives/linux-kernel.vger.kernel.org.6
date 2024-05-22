Return-Path: <linux-kernel+bounces-186450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EB38CC456
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279E3284A59
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABD413D8AA;
	Wed, 22 May 2024 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="puQCK42k"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2170.outbound.protection.outlook.com [40.92.62.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F43C81204;
	Wed, 22 May 2024 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392751; cv=fail; b=EUGF6F4l3tW5OOQIY0ijzbqLhciL4i3qaafb9KRaT61rXA+FuXdIWk4hWzBKHoQMNE4p6wT0wQh3SlwD9O+kN/v203HTsy2OmBc7ZkDOrJIqITwcqhCJu/Utb7gpv1zTSORsWPCqfy8LF1q+au5owZEIia/21Smm0eSoQgqPWsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392751; c=relaxed/simple;
	bh=w2Hyb6wm80WazVxiHshbIZjfx2yEpPxasPFe19q6WNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S/0933b6KiUW4U6pAW1usPXPgyYTtZASW4hOs84ysb3EJveY7XncfWFwSzMam8B+h5BgQlf3rH2YTGe+z/96lvfiKsO/5cpX+XKX0C1BfdEmNIbY7XCBxdcxyxKeFAEGXZ38k1tPFMTv/4SHeSgnk53I/bzE/TNWpMm6v2lkUM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=puQCK42k; arc=fail smtp.client-ip=40.92.62.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbcLBd0uRe7jirSz1zniw/OXRtNIcMpguMLMemu0TKfUM2jj5iA51v8QFdZbQ67NK0Fwt/AJZn6B3DDMEHv8V60f3siZTMefswCUVRAOOCppJtSB6UlRIarDyF7effmcNzcaBewOl0WMnwoqV3lkjvLgOOxR00qSJkQfeAGgc1krOr+Bdb0TGgKuFYYsyP093IpZnjAdNHCvDX2+U2mxvOF7cUNsKvzW0AEgg9TFkELubWf8EjRpwx25SIGZFaITI7BX4FtyMaf6twCo2pE7VBG9EA6FH6BqOD/Ubb417BL+oda33cMST+o9opeOMuF95vZ8gZNkFHDdGumEr+khhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2eqJVYsX+yguqVGpB7YatlpH3lpzKhEZKM6R6ElDk0=;
 b=im5ifOeL7hooOewnpATpO2cXweJ1Y2WFQIvXHnx5GQYpf6s49vhasP7CepxvRDrgbguWRUpc/jS8kI6yC/iwD0aIS17sRwsvG5P/lZiW4X+mkiJTmf5254KwA34AFt5UPkJNl5tAeK06b6Oxl/JQ2kCrzZy4dlHdzjzN4nJ3Gyplj9YJ+mr1YTcF7DGhv2r10vQv3nfp3E9PG7+Lc2lH3UkwwWO9GrI/OnHROq8GU4+jP7HgSLrRFLW8zyGQc6mMhnBL+VGjGH2srqZOO1pBLgld/zyqYatmH5AoO5H1Jia7z7lMywd3zXa96H+7rAuElnYMjIJamu8FAgBbdkojdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2eqJVYsX+yguqVGpB7YatlpH3lpzKhEZKM6R6ElDk0=;
 b=puQCK42kR9TKKdbK8mab5a52n2XAoZ5eni76VD2llmZUVNY/sV/6LLhqzAzQXBkP9QVzv96aeZqhtK9/miBzD3B1JOsT16V/ddMDYUoaDNdS39k48xvN0AX7AdP3ANBtpqncq1EyOKppEQyK4UjVnchuQ/LH8LAxKk0rBThhh4uW8xDXIhUykOUAJ+UxCT0D+qwWf0LYvBpzEVdcU1LDXxOSTZpQ+UHyjzOdjJCF72bP6TjRkGbUsPQ+Vrbm2JTNIP6lI5CZp2w7B51WWP6Y8ogsqQfVMOyKQWVY7iWo1HiKwluJQlEnlP2nnpjm6ppPPp1cjCfMTJ27k2Ah22WbPw==
Received: from SY8P282MB4886.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:25c::15)
 by SY5P282MB4586.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:26b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 22 May
 2024 15:45:45 +0000
Received: from SY8P282MB4886.AUSP282.PROD.OUTLOOK.COM
 ([fe80::55f7:fecd:d862:9b1e]) by SY8P282MB4886.AUSP282.PROD.OUTLOOK.COM
 ([fe80::55f7:fecd:d862:9b1e%4]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 15:45:45 +0000
From: Roland Xu <mu001999@outlook.com>
To: gregkh@linuxfoundation.org
Cc: ojeda@kernel.org,
	boqun.feng@gmail.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roland Xu <mu001999@outlook.com>
Subject: [PATCH v2] rust: kernel: make impl_has_work compatible with more generics
Date: Wed, 22 May 2024 23:45:33 +0800
Message-ID:
 <SY8P282MB48866A68C05C6444F0340A00CCEB2@SY8P282MB4886.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <ME0P282MB489023110AAF1163F0A4B2E1CCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
References: <ME0P282MB489023110AAF1163F0A4B2E1CCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [sIM0z2YSZxtIMviuZTsbZNhE0F/Z6nb6r+4qaVrt/lw=]
X-ClientProxiedBy: SGBP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::28)
 To SY8P282MB4886.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:25c::15)
X-Microsoft-Original-Message-ID:
 <20240522154533.2618462-1-mu001999@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY8P282MB4886:EE_|SY5P282MB4586:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc05aaf-5703-466f-5e45-08dc7a763e79
X-MS-Exchange-SLBlob-MailProps:
	7qh87CJt6y1ldj20lgX6nTCiJ+uLyq8RkgZB03JZ6sBFuSZP6gNlwqAqUl+RmyuPjLOw1bk+O8F9icT+EV6wQGryFOvsvd6qWjfxRzsk3LJXrfFQqJHOA6AJMbxZhTw8h0asMAKj2riCtHmUuLrdHzeeX5B4ZdsnPuR7dKPo5qcQSzlfmKqC8cjFcEE6W/XWF7Ds8TYlwXXQEf0Yx8di/QlW91+04OA8sh6bFOoFK9t7expM5DMRa7yWbBKkg9qjbq3FztkRz4DXrtkL+r7OFwgXwJpZ5Y+NQG6CB24FY3cgGNAShO4TQP2LsNI2HBnm/qTHYlL/e/4z4IXmIcXXT7PseNBz1jbCCnuTlkZRIgtwKaOUcFX9dtzlCDk7mI6Iw1d6HSz3rxfCHH7RMnHDjVIHmJndqnj1pu3XyOIdJzS6kJ0uYGC8QfWEKXRnCnbAniz8aNdBQZ2vOG9xzKyyieuCwoBa0MTv1lG7brY/+iXaOh2gVVdZmjBdBkUzFguCC/UCXMYbRxl1zshf8gJWrX2WJkYR6HzOrOmlsFv7Z6ZS/LQR3yxLlQjVLiVsWKkMxxFM4BuIoW6luD2Pev7IG90GVKD/mTZLNSTAE5K3VV9g1gGZOlg2cmRqr7uiD/nW9LUZQiVHTccbHWa3hwdaw6MUJv799uswaTV3YIwi9RUVgl5I8F2tkGvK3WMLMlMIyRxhj4w6ippBlx2EDS/QHBuevOVJpPIO3FmvEYlK8lwfGi64SX5uUfem3gNGbmlm
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1roJKE7TqwI8CZwDedKzaIHJEtXZT95c3DmlG1vFIsQ2oAZCkXAWxXalcihut91GmIM8tExswz1pioFaELkisi+AF7xsP4owuNK7fhprs5PbDy+PZL0DdpJoLeKdMJISqrPX8i9EO48uB8by6hNFKrdwcQUMkuR//siR+5VYwRBboZt4Mn7jjnUxHtJ2faXRZIV475vbyUzNGvPKRklbkyezN640nqO0/TEvBBwTVuTzY5mF4PKwMK0uHfH5wJJK0Tuq1LmZJqBh6mCob5azBisQbleA5hjzHrnOEVlK7DIpu87EWKR9vKZMiYEqzUXZl2A3hFWMLDYVCpo558cbJNF3yWHuwG1FliJhMsNkhhfqz/T+3YYBHCxnGUFgyi5zkNZL044c0uUcVAMhenQlY6nv9HkTclVVQ2wReh5YKfM/vVMzWV/DuTu/iCpCkyayvYMC3i8TnZ2C0KKbrIEA88UacEKf6fcAnjgbhiJo2amEmXlaCwvQxHFjiqB+a7s4y5gbIK0B7Cbp3YU+lyEvrel7fvW6ejSe7i2SpfSE28rhiOkeeTOwiSYOAdddRgM2M3UGgvOb6cwiEsa7fnLv6so3pECqRRHNWC/lvdYl+qw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?95OPAe+e5w08yGVzLyaHYWnpTHYmCizJxNv1PQDc8UYpXDf1ZZOzYVf5W/Ep?=
 =?us-ascii?Q?HtG64xy2akJ2mkNwwtpPVAZVKKXfEyNRFwB/0NVqVZefecZwnlzUlW+4WO5P?=
 =?us-ascii?Q?iLilVOqXLtt3Rk39s/ygEWvuj514WNu5wvq/bLsaSfPbwbxzii6pat3+O4z4?=
 =?us-ascii?Q?lwRA8jbreyGQXF9oZk3q5q2RJ2P4S0vIT+8DCGIybOF6aQSiGsXaQzikqxeb?=
 =?us-ascii?Q?tQxdB2/5nWmX8kVImtof4jA92sFxN1/50eRMYUeLfaibEa6V5BOarTADAz3S?=
 =?us-ascii?Q?tyC1rmWgfJvW9XhQMqdAYb/+WEs4HTdP2uHUIWBrtG06avszTI7CqwjneX7g?=
 =?us-ascii?Q?fgxnP8epRDO61YKT5O4el/Xk++/5i7zx1aebI22Le8SCbTXooPPrZBRbf0+8?=
 =?us-ascii?Q?vEVdvN+tuzueMrSQvXM3p/EGVKxAw4SsLLZXMG7Yd644I2A1cPhpq9vgeQir?=
 =?us-ascii?Q?OLuhO6ruco3gOw3G/V+tOd88IjYCKeHBjO1DRBO+9cbftORBmVV8YoOfh6Qx?=
 =?us-ascii?Q?x/rEHjE96DwWMvi9VAUUamnsnhLUqmSDm4K6y/gATz7gjuDB3DVDU/oGi7TX?=
 =?us-ascii?Q?Z0HLn/UjMI8KHbXUyNiDwjYvrSRRKk5eBp9RlmnaFXdaQ6BbK4vzJs6lZEYn?=
 =?us-ascii?Q?UBCNmbGchaFb80hpD6ga0kzp/wH19of4JhGDaQ6MIdRSI9fK07wDV9UvFXIB?=
 =?us-ascii?Q?KGQaGsTEsIlkA9quzhYmoblRuwwPihSbXoDmpAQn6fwjl60hR0FhA+onCzNA?=
 =?us-ascii?Q?5gPa0jsU0h9f8xn3zgAjqwL1FJhWAtwKhuU/pzK9Ruq2rKoEiWSvSWSR+1z0?=
 =?us-ascii?Q?diGLssIZjaEiBuDx3Vg+1typfQoljg9tMjnYh6UnDjh3JPpI13Q7pmORmswY?=
 =?us-ascii?Q?0Es0M02BVS6dnrAGiWM4LdSO8ZtoSnNKVerHNx3sZH5osWXi/+yBEG3gkanp?=
 =?us-ascii?Q?wf9FT+mSMxUOx9lFehQ85xtZAIJDpgIirrTbVCteqN0i7DtSv6tkooEO5ecR?=
 =?us-ascii?Q?tdRQAVcXwMlLhXZiSRc69RJpYTcwuAtWtuDE0wl4Ixij72a8vsCn1BB0MHcK?=
 =?us-ascii?Q?NIuVs11SrIZqtIiQf0mNEelAj4MWk7gcSJwm41/ktXISmJ3LSo+YrR6w0BTC?=
 =?us-ascii?Q?yROyu7cX+O1xlKk50jaPVSQ2WmHFkpsutvUeRMJH0R/+xpoGafmFzp7hJAH+?=
 =?us-ascii?Q?FdNbCCvFobIsFdLVJ2Hl5CXGcWvFfBMaxcE8OaVt9WHFzBJIUyNW5+FKRsA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc05aaf-5703-466f-5e45-08dc7a763e79
X-MS-Exchange-CrossTenant-AuthSource: SY8P282MB4886.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 15:45:45.4825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY5P282MB4586

v2: apply comments, wrap lines at 72 columns
---
Make the impl_has_work macro compatible with more complex generics such as lifetimes and const generic arguments.

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
2.43.0


