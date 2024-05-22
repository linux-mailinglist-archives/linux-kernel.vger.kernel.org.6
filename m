Return-Path: <linux-kernel+bounces-186241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E18A8CC192
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3ABFB20A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A52823D9;
	Wed, 22 May 2024 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LZqF8H3D"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2140.outbound.protection.outlook.com [40.92.63.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FE4EC0;
	Wed, 22 May 2024 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716382119; cv=fail; b=Iy7A19MZA7j6szSA58fyGbcMf00ZGx1Geba6cg+ojQHoqfqsmvDGhIvYmuCxqgRiFWFV/ctfDZjB3/k40tVlTevd1Gfx97Kx3pDRy/T/HXh/sNEXtMW/rHj5OL7YE/kObKVMPsDwcz8hJuIZ7trteLICCakoFjNqwbeanssShXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716382119; c=relaxed/simple;
	bh=aQ9kUq2MEhfAb/16TRyiUro9Kp/ae5UjQxkFpoBobVg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ms05uQ7S+smpemVMMU8r0HlcKbmB8EhgAJqbWuo0+/5Hx5Ng+OPKZ2CdLkSNZF/zWDfYru2yJwkPpGRqF9ttUcIpoAqevLLVKzTT3jPKypGc+o2rBYZcn91tRPQCtnhbMJvanKuEf+DOfIH+FXKDC6a2rr4bTGkJ+VlMog9Us0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LZqF8H3D; arc=fail smtp.client-ip=40.92.63.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rs9BdcXOQWTwWHWS6GiGPm0XcYHfYoIOORsjkYBGgbVVdX3RxSB17sGpwxzpHt+uJ7H9LIMBp7XFUIHAWMy9r4TqY2fJyFUbVQQ2RS+GRca4P+JY4kaEcEIfbn1DsANmgtfhJfjvmfpaIQ1DwyudiYTa6/Bfi1fsGbgY2Ta4WwtLpcwe2ek3zfQFs8cOgsalYqu83gw0tTUc1qh9yI3pfeiXPKkS0FbR8rRBqNBuCwWF3gIB1T8zpju1PLBvB7G6+1d1fA42GXST7p+kff3Be7Q6jJshRmdQ0V/LKvXqD6omD1Rq8d8GrPr+mBlogag87cuORxdEBtDiG8n6HK0Bxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6GMX8euwPtGkw65psqU9W5Dd/PIjEg0c+oI/rtFnbE=;
 b=fqLajYOMplpeEsdC+rdhzQuXijUuioMIwDBifJzRSOt0Pd5AO/YEqOHmnnRLMBUDdQwgA++jfy5XbPOvr+ECrYxME30ZYQucG8sqhpeRVHW+ZdGN2KDIqdufdUVFP1YohgaaayDEou9In3RdBtQ9vP+jXgyBzzRiU6rVCFyUgXmnDUaS/dKmXL2zis0D5NwSV1NDVO6+yuFYdWzqPBibSK0ZCQtfTssKAl7bQb6E/vpOfb9MMdt8pIlSJ1IKlXyojaZaEd//YnmdHw2QXp3/1rjz+C0I/qDDLuIq4KH+V7HW9DMxBBy9zXqNbsEEfaINyMNjvmrbwXJfJYMYQu6NKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6GMX8euwPtGkw65psqU9W5Dd/PIjEg0c+oI/rtFnbE=;
 b=LZqF8H3DkKrpGiRa8Qruyk8D3l4rNg+ql+eR+wIgZ5W7n3nRQOVO9uSmOgfwyMtMjdA+47GjoCivnsl/NGsnIkQcgbBPG1/m9hIr/iH7cRNZ8Wm+u33QZQrHsEfIC1bGcXOF3fsbW7PqZWwXFXpXCkuPEyYhO8BkG/dVUNbtdKuwokGNDsbtm+ETRDItPKV5JiUNXcbBaZTVowc2yt6DULwlPYEcOG7DpYD0fCfVgpxZxtxjED7UG3UUoXiY9d7eX5fKt/ZY4/NQVN7NTJ8cHYzSOsV6yMRj1XZNglfRGM3uETvvjwoBGpjGktci4WuPqlE8VJeaAWZo5bHLqZeJrQ==
Received: from ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:228::21)
 by ME3P282MB1169.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 12:48:32 +0000
Received: from ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 ([fe80::d384:a02f:2370:f33e]) by ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 ([fe80::d384:a02f:2370:f33e%7]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 12:48:32 +0000
From: mu001999 <mu001999@outlook.com>
To: ojeda@kernel.org,
	boqun.feng@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mu001999 <mu001999@outlook.com>
Subject: [PATCH] rust: kernel: make impl_has_work compatible with more complex generics
Date: Wed, 22 May 2024 20:48:21 +0800
Message-ID:
 <ME0P282MB4890D938E60E706E937F9207CCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [y91LmgdPfvkQHY0yoRC1NAo586N1uZcC]
X-ClientProxiedBy: SG2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:3:18::17) To ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:228::21)
X-Microsoft-Original-Message-ID:
 <20240522124821.287360-1-mu001999@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P282MB4890:EE_|ME3P282MB1169:EE_
X-MS-Office365-Filtering-Correlation-Id: e36875a1-fca0-4692-5d5b-08dc7a5d7c83
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3430499023|440099019|3412199016|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	SzPyWaxtWnl3rfe78Vp+raL8Mqvkplq7UniWXDcx2vdD/DlwlkXRlby42NFClFJDtWdBsNKvkqYZCU/S6tkY8aFIEQdhBEN575ZX/0JucdYGVc9CpWySnhl++mPuxoGdv95HetHNFSgwiTbb4ZiDPUtangdfdWSA7Rmd1AQkitOsolN9JN7TbX3doVjFzIhiFF5HV0Fy6fkvM4kCBqGqH8q6csRyswQG3JUoNL7SM1dcNhiEPQhU14koQ+n/AoBMLKZK71kCPIA6pukNJATT4phIRmoSQGq8gRKVkUuPIACvF/gcsdCJMcFqTWv5ZoBjHbIF/gpD8fN8mwLP7AG/J3PdNTlgRCPDjpp8cBfD3VKbAH3ahrv1i3/wgopM2T62SHgspIIgkO0mKEISyFhITKaYHNr7ICKSp8qUllTgjwrXucITLIxdQVOXStuh2dgxYDj+wDy8BF/2jdDuUzW+oh2XRC0l1hLYG8+/0A1EismRukxDGCtXyfDhgE4YZ0AEGEWygYBAXWBnC10LUXmcyKJ+t+Q3n38JOhSKi/aGeCp5CpRuSmFBovCCcyXnXkfuVzHO43ozFQhOUtbJrXiKbgnczTmRaq+q6Viz2wUoKoiRCxtKBxqDtlQtrgepOgkNNIu2vTIMiF85l3STVE501Sx5xzDp3i61J/bDUtY5tHOI5HsmOBFeyWHfkd6Fz/dx
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FarGbBMqrt4jVqFfKntCsFyNZeOqpzrI16bl1Li8EVVZX85z3gNqXn0OIVWj?=
 =?us-ascii?Q?RE+Gk8patC9FM5YUZhh06rG2D+I5X3HyL6h3wqfP8zoWNFLrySKKSLLeu4Zi?=
 =?us-ascii?Q?I2EFVPXHFMkz5Num5PPLZj510rm9eCrP1oGAgXpmmeIt1ckWG3DXELgRP+4l?=
 =?us-ascii?Q?y2cn4xMuhEqhXzzjQA2tLn2Aw/vve0vFU5OnndPqtPSZPqlWPTWUQNJIAfWl?=
 =?us-ascii?Q?AQwqlY05gtH0U0z+7kp3HO/o7tk0KNEgSgTmckxAarLWQNRY1S08BqZlbnlA?=
 =?us-ascii?Q?83H6aMjq+oh/qLwwJW4X8oKcAKsM3jvSHDWQEElslFQQJCWrZTjWWKA4sB4O?=
 =?us-ascii?Q?CpdY62fLXK6X1ptE1M8t8nlE8a5oye0io3O2LwkBaXbjjCZQ2ZBSscQIn3Dn?=
 =?us-ascii?Q?56K5L5koRo8SrLBWZswkHjkDps3HaqFilR2akB8EHe7AzvK90TocW5r1gIVX?=
 =?us-ascii?Q?jR6OomRP7wGSg8UJBG8pEeEttLSEtbVfl19n4WNYI2R6ygXULwYXBBKwYbkl?=
 =?us-ascii?Q?jvMqx12/pEfqEwLx4t2o4xTV3kKNixWMVZlg0jwu+b9C48iL8G1XOFbZWwIQ?=
 =?us-ascii?Q?I04f/LX1Frw9+jJtqh1onYbepxlRo2lCxne2wWvLI3l2/7afGfPKcJ5dYkXM?=
 =?us-ascii?Q?IDOQKL9Aa2YmRf2qy/jE4qoKVn9EI7JqtCBZ/SFGkQWtGptSK62EMCBA/Gr9?=
 =?us-ascii?Q?SgDbvG/hIqpn2a5hwLOYBILolaBf/kMqC/0OybyNruaaajK3d5RZpEtZnAcm?=
 =?us-ascii?Q?EQ2KweLxzHAzInS5jnHmdkB9dplI0THs4ZBFN9m+5JXOl2l+aUzBHpGXdm03?=
 =?us-ascii?Q?2DlXgJWI6sOGRncxyU2T5kqAWZ2YXxi6D0s4NFLJCr5iWjRD45ndUokTzEP5?=
 =?us-ascii?Q?YvUJF+t5+C+0Tgg3xuQLxDeKXKrKKlHc3aV0caa705uWMxhfhOp/aG6wA/60?=
 =?us-ascii?Q?B621Fpzu5cjBVpOcn0g40Tux+qwB4/yA0Dr9LUUn59ccmktiyY/qmT6Kp+Lk?=
 =?us-ascii?Q?hiDsudkTNGsruVgMtdz+jMkmiVKEu2rn6HM9riTISmXhacZ1tZR2xsZt6ZCM?=
 =?us-ascii?Q?HmWQPicfHp2v4h1JSdyKf5yuDqA7c8qiBycKmKjRNN7MfGI3U9oFYw5Z4vK8?=
 =?us-ascii?Q?nTvz/NAxshDObgkSG29sfDBe2pgy2jUY5/a69hM679RuWv2ZV0TQ1iUjoEET?=
 =?us-ascii?Q?Dhpw4SAy/OO2/16PetMiVpmojr1ws8NyZP0u5Pt2J0ScVhJN8E9vX7yUMaM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36875a1-fca0-4692-5d5b-08dc7a5d7c83
X-MS-Exchange-CrossTenant-AuthSource: ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 12:48:32.1261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB1169

Make the impl_has_work macro compatible with more complex generics such as lifetimes and const generic arguments.
See more in https://github.com/Rust-for-Linux/linux/issues/1077

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


