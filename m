Return-Path: <linux-kernel+bounces-577580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CED5A71F19
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC9C3B28CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1791253B68;
	Wed, 26 Mar 2025 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RY/GNnos"
Received: from sonic314-48.consmr.mail.ne1.yahoo.com (sonic314-48.consmr.mail.ne1.yahoo.com [66.163.189.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460AD23C8CD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017176; cv=none; b=a3FTntZYZkkxNLvf0V8da95JpI/2nGRKvol6ZSjOZQvadnk/zQEtujvNRGzwynSqFxCvij5MZGvvYI37BxOLRsNCURCBrVUHbpY6UmeyzIITpa0r9Rex4jtTDkrWQB4tjPSv+OQ4f1/inhY8FfKcy2+aDS5E+VfsPkhS5affYLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017176; c=relaxed/simple;
	bh=PC1X3HEsEgH48fE/eyOZ1oJ29z21EtAGAhy1RT20v6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=YlMiewc3Oi0LqZKMg6BollJxBRxs6CngrhiVIJ1sudtewrQb8sMPxqiWzi1/9r8m1Ui3zaH1GgMmWRfA0GhvnVBzq7kKxUnSSlbP3ZcCnQ+4AazxZo0QUToQbjkrNPbVU4tLBceu49CpojMuYMrKHzLTZ4nR1/s8zzWuP58WHDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=RY/GNnos; arc=none smtp.client-ip=66.163.189.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1743017173; bh=P5BPCMQPyvXf+kCrxNahBE6rC2TPx4so0PvFtA5+q4A=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=RY/GNnoslkFZIx1un5413SvnA+GJJDs+KlN6eL4B/zTYjCFtkzfUWwB3ttIbnpCoAwckmSZ0PnVrpqISntGgK1uh4NbT4S0W8ZIahnliFCascH6oZV8P0nWEIZ7YjTyj4PrZN8eZPTNmJp0anZ3y7hwJi7EWRUGA/kyVoq9K1yYAM7uu0NpEqXcqU60zHe35+crgu67YftmxpOsmI/7Nsdum4EWV0sI4+ZFDWdLidG6K07YV7/y81zqY95bNLGI838Z1lckC/uroHzOBOXoub3nJg6q1zRLrebGteBGVL945oNvG/jIVm24Xi5AbfqHc52UxooHwnzEZ5CapIQ2nJg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1743017173; bh=LtsQ1sgc9O9YJRzOcfJplxT9LqK8RaH0hatUrnyoAi2=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=nL0rlzMdLTDFz5AtAstje4p/GqgV1kgJGy8D49EfLK7wYp/T189ijhAz5d9B8x7iEva+uyftgJQLc/qj0n+c0QE+kbYvC5G2cM/6o/u/C6/lkuIW43tDkjrwUGKZ6nkvVgVrSCyYzz5G+XLOcURC3QErbE/ZzaN1GPaFN0/cDRmzhi0nKu1c+hcR4niaJxa47spn3DPh+ZNoGtfxvUHTHozu9qLO0ywaM3gwdLHKhXzSUPt6YPOBAk/on6J7TkUlXlqkPCECwcavrEl9pnWolOdF2dIHQ/Vm8McW8KOBHML4PSZsIU4VYvtZtJ5fZZSwW1AJYWB+puABJuTDUQi46Q==
X-YMail-OSG: zSdiKsMVM1meCqwPCYkaxoEZdJ1j3bCR8tMNBzg5dcDp986tr9wyczEtL.AMHlw
 9nIzipiO1j_U0tyYI3PfXXNyS86skhLXDmYEb_UsjbVCtHxNp4WBfmdZq2YAfgiA6BRiZQojH1UJ
 iUNkw1gJc4Z3iZlTIANR.VcqRJIy7I5eVMLPZqsUIHXv5ZjWEwkzwEq0KmM2r.oXCipTO5lQBI4g
 sFL7VBtlDBtWNwa0rzptr6nMir.Q4sglXKj339qruUS3zJwPFB4ZAQWy1Kx7a_KlnoVXnTv9seHn
 Anr4aT1JTYcBQJyaLn22QVk2HTrd9puG5qzT.lctXfFfjUkfgFSlM_1Q1F3puEFv2os2YnCZFnYu
 89oI5mXRGVcLdnSxpm03aqN8EN3hug9j5O.sJjM5jlR.NiglJk5VeKc88HWuiNTakfhARg1uwbzb
 MjQFQapPYu8WmFGqRM5xTA7HRl94ME5V4knBQHDGTltDYrTCurZUhvjtCAyswV4sWbryGgoStioH
 JH2JiD71FxqfJWZuHIZa_xNmCa_dgQgE17GdLlw.epgGNtx.QsbTEON9WUZm8qy7cvbbEiPog3RX
 6FSTLMO1Ay.5t0uvBHqHv1UccgNeEGKZFMswKY5YawBvLYk9GlT6ozNYXpy04L4xMPl_qf8UfLuX
 6LRkoCZIPzCGqzxNXC6afXAkRZp1ApzZLLukX.iXe0AMJVi7Cf1qRBhYhq_BvMl26KOLvi9UnJo2
 p6cfPYnMeXkTca5fKRPrXOYhYWF.tt3kKxQAfvcwbgnTzS16wrwYQtSJcbt5_zMEBXkQs_93M_ZT
 kNGNfvT0AFnCTgn7ZrxtXSBbHcfpeWAT3XHe62zB4GzdwN1dvhOvL8HqpC97SnO4S8PjZ5vJum2Y
 Jbwa1nqexR4NwWb6575hvhpIMii4854citEik.PnQxxyU4zNPCF67SIa4_dnvj8qqi9vPK4HLGMA
 1vAhWx6WM7PHe2j6Li8_BSKt5qx.PnzhUUf.Fz8Nm2XjHV53fEZBq.pAWl2_ErFPu.RrjHewvYlM
 3WYSstVns47.9LE6Q_yDq.bfAQYWbHqvBiLD9MQtdfRlQ98iSFXS4fBN4tQxVopkt706N5ZIEOFb
 HrHgr0JOJp7NjPN6.NtsCbbRgRzIjpu.0P0Cz.YHre_p0VDsQniwEiAQeRjv0fsnzxW1e22QrG8C
 qL0PjsN.8YmBaISIj5xCvqh1OK5gGyVB8xlvaFdbLhQs5QHALU4ppOGVDHwbVsJAd2SvxEbMbonB
 MGGQ_L14jurJNSGd8ytzV9cHIIeCmw9d3Q6FmXTJjGa4pWvvEnAZqfvjiSXyEXGbEUQuBz0.VCIX
 PVlt4CkBNIAWk701Dg6NdCw4K6w6lqGDr.sDswz.8AxgC2VetMIItyEzZal9rL0f4MMZSgged4eP
 2f9I_1okvdaMErP_17AV51mGI6TE_KvR4W17OEcM9kxr3E1SFrk.oQQH.S.jKW_XECvWvXm_HdcH
 BtphufbPK73U8PvMaeYApChIjm3inyTfxv6hG4cMm9U2CIOQtoPfnPBbOY1idzmeVQ6EUlg1YHQ2
 n0i3icuPy8ed1x7q5l99LuuYhC3FYHFLz8f1osg.I5Mnbxgax51l81_iqh2YS5b4KDPYu3P7neDP
 lNNNk5MfhSNGIa65vwQmQlIaHQn6KX_79mFMcpCO2TVDrixymK3S92lw6BUu_HqNmntn3_r3ltih
 .81Uf0LmXrv1j1NYt7AKgcmVbOtLqpcGdq7649XceLt39rax_l2iXJAmiYtGMW0qnT_BUNThXhOz
 mUD.hr26EEWL1xG4tOinJwsz5jXYzOWxoSRIdNEAtRli5la2zs7pi6_Ycu.iWs1rMWyB.szN7Cqp
 Jt50IzPKAdQwt4FPXo0v47zpzhy7VYUOlT5e3CYxUgVjorU2Eui09xFa7En6vmBVEdRRJziVjlG3
 ETTN5TSCKien18MB6g._K4L0_lMVjI6FZfmjRwSaD8ePDPI.eMI0EZpQQROsrIkF0MCMewJ7maCp
 uujdfdEIf7HhCRcVu7TaP7zRz_BcJQmSKjCHUmcMqI8eNFQ_xkV4duEYsqgBhY.egowe2.9T1xPG
 mIN3ac7Yhi_0BAHIpSYxvmzoryCmnJaLzj6p2TVVj_Yhe_de2u2ACHKJzIGg3zIraLuCt2CLF_t1
 iUXTPLGOUubdhkBzGff_Ezai.cr_cHbkCH2WpoGUqL8.YVmUi3CcC8HQXqtcIxCat.LsM3RAT9yl
 Q7cqTtaigtQ4GwrFupTBfGN7xlot6mS6Mdw.bH0i_dLkyugttfWPWFHgWWDHFy5aT7tL5yPBp8Xv
 qfzdHG5XLN5ncu9eJ
X-Sonic-MF: <igor.korotin@yahoo.com>
X-Sonic-ID: bad28dbd-b838-4313-9c73-b76b9da4c2dd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Mar 2025 19:26:13 +0000
Received: by hermes--production-ir2-54ff696c44-s8xcj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 708334a26c0cb005829019b77067cf3f;
          Wed, 26 Mar 2025 18:23:30 +0000 (UTC)
From: Igor Korotin <igor.korotin@yahoo.com>
To: linux-kernel@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	Igor Korotin <igor.korotin@yahoo.com>,
	y86-dev <y86-dev@protonmail.com>
Subject: [PATCH] rust: macros: Fix macro referencing core and kernel crates
Date: Wed, 26 Mar 2025 18:23:02 +0000
Message-ID: <20250326182302.5650-1-igor.korotin@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250326182302.5650-1-igor.korotin.ref@yahoo.com>

To prevent issues where user-defined modules named `core` or `kernel`
could be picked up instead of the standard ones, update macros to use
absolute paths, `::core::...` and `::kernel::...`, for core and kernel
references.

Suggested-by: y86-dev <y86-dev@protonmail.com>
Closes: https://github.com/Rust-for-Linux/linux/issues/1150
Signed-off-by: Igor Korotin <igor.korotin@yahoo.com>
---
 rust/ffi.rs                  | 2 +-
 rust/kernel/device.rs        | 2 +-
 rust/kernel/device_id.rs     | 4 ++--
 rust/kernel/kunit.rs         | 8 ++++----
 rust/kernel/static_assert.rs | 4 ++--
 rust/kernel/str.rs           | 4 ++--
 rust/macros/lib.rs           | 6 +++---
 scripts/rustdoc_test_gen.rs  | 8 ++++++--
 8 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/rust/ffi.rs b/rust/ffi.rs
index 584f75b49862..d60aad792af4 100644
--- a/rust/ffi.rs
+++ b/rust/ffi.rs
@@ -17,7 +17,7 @@ macro_rules! alias {
 
         // Check size compatibility with `core`.
         const _: () = assert!(
-            core::mem::size_of::<$name>() == core::mem::size_of::<core::ffi::$name>()
+            ::core::mem::size_of::<$name>() == ::core::mem::size_of::<::core::ffi::$name>()
         );
     )*}
 }
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index db2d9658ba47..2b19a8597158 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -214,7 +214,7 @@ unsafe impl Sync for Device {}
 macro_rules! dev_printk {
     ($method:ident, $dev:expr, $($f:tt)*) => {
         {
-            ($dev).$method(core::format_args!($($f)*));
+            ($dev).$method(::core::format_args!($($f)*));
         }
     }
 }
diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index e5859217a579..0a4eb56d98f2 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -159,7 +159,7 @@ macro_rules! module_device_table {
                     "_", line!(),
                     "_", stringify!($table_name))
         ]
-        static $module_table_name: [core::mem::MaybeUninit<u8>; $table_name.raw_ids().size()] =
-            unsafe { core::mem::transmute_copy($table_name.raw_ids()) };
+        static $module_table_name: [::core::mem::MaybeUninit<u8>; $table_name.raw_ids().size()] =
+            unsafe { ::core::mem::transmute_copy($table_name.raw_ids()) };
     };
 }
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 1604fb6a5b1b..81833a687b75 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -59,7 +59,7 @@ macro_rules! kunit_assert {
             }
 
             static FILE: &'static $crate::str::CStr = $crate::c_str!($file);
-            static LINE: i32 = core::line!() as i32 - $diff;
+            static LINE: i32 = ::core::line!() as i32 - $diff;
             static CONDITION: &'static $crate::str::CStr = $crate::c_str!(stringify!($condition));
 
             // SAFETY: FFI call without safety requirements.
@@ -130,11 +130,11 @@ unsafe impl Sync for UnaryAssert {}
             unsafe {
                 $crate::bindings::__kunit_do_failed_assertion(
                     kunit_test,
-                    core::ptr::addr_of!(LOCATION.0),
+                    ::core::ptr::addr_of!(LOCATION.0),
                     $crate::bindings::kunit_assert_type_KUNIT_ASSERTION,
-                    core::ptr::addr_of!(ASSERTION.0.assert),
+                    ::core::ptr::addr_of!(ASSERTION.0.assert),
                     Some($crate::bindings::kunit_unary_assert_format),
-                    core::ptr::null(),
+                    ::core::ptr::null(),
                 );
             }
 
diff --git a/rust/kernel/static_assert.rs b/rust/kernel/static_assert.rs
index 3115ee0ba8e9..f3f8c6eb7360 100644
--- a/rust/kernel/static_assert.rs
+++ b/rust/kernel/static_assert.rs
@@ -16,7 +16,7 @@
 ///
 /// ```
 /// static_assert!(42 > 24);
-/// static_assert!(core::mem::size_of::<u8>() == 1);
+/// static_assert!(::core::mem::size_of::<u8>() == 1);
 ///
 /// const X: &[u8] = b"bar";
 /// static_assert!(X[1] == b'a');
@@ -29,6 +29,6 @@
 #[macro_export]
 macro_rules! static_assert {
     ($condition:expr) => {
-        const _: () = core::assert!($condition);
+        const _: () = ::core::assert!($condition);
     };
 }
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 878111cb77bc..aed7b2617c32 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -595,7 +595,7 @@ fn deref(&self) -> &str {
 
     macro_rules! format {
         ($($f:tt)*) => ({
-            &*String::from_fmt(kernel::fmt!($($f)*))
+            &*String::from_fmt(::kernel::fmt!($($f)*))
         })
     }
 
@@ -944,5 +944,5 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 /// A convenience alias for [`core::format_args`].
 #[macro_export]
 macro_rules! fmt {
-    ($($f:tt)*) => ( core::format_args!($($f)*) )
+    ($($f:tt)*) => ( ::core::format_args!($($f)*) )
 }
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 9acaa68c974e..cb429eceff71 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -283,7 +283,7 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 /// # const binder_driver_return_protocol_BR_FAILED_REPLY: u32 = 14;
 /// macro_rules! pub_no_prefix {
 ///     ($prefix:ident, $($newname:ident),+) => {
-///         kernel::macros::paste! {
+///         ::kernel::macros::paste! {
 ///             $(pub(crate) const $newname: u32 = [<$prefix $newname>];)+
 ///         }
 ///     };
@@ -340,7 +340,7 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 /// # const binder_driver_return_protocol_BR_FAILED_REPLY: u32 = 14;
 /// macro_rules! pub_no_prefix {
 ///     ($prefix:ident, $($newname:ident),+) => {
-///         kernel::macros::paste! {
+///         ::kernel::macros::paste! {
 ///             $(pub(crate) const fn [<$newname:lower:span>]() -> u32 { [<$prefix $newname:span>] })+
 ///         }
 ///     };
@@ -375,7 +375,7 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 /// ```
 /// macro_rules! create_numbered_fn {
 ///     ($name:literal, $val:literal) => {
-///         kernel::macros::paste! {
+///         ::kernel::macros::paste! {
 ///             fn [<some_ $name _fn $val>]() -> u32 { $val }
 ///         }
 ///     };
diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index 036635fb1621..981b9a3d57b4 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -172,7 +172,9 @@ pub extern "C" fn {kunit_name}(__kunit_test: *mut kernel::bindings::kunit) {{
     #[allow(unused)]
     macro_rules! assert {{
         ($cond:expr $(,)?) => {{{{
-            kernel::kunit_assert!("{kunit_name}", "{real_path}", __DOCTEST_ANCHOR - {line}, $cond);
+            ::kernel::kunit_assert!(
+                "{kunit_name}", "{real_path}", __DOCTEST_ANCHOR - {line}, $cond
+            );
         }}}}
     }}
 
@@ -180,7 +182,9 @@ macro_rules! assert {{
     #[allow(unused)]
     macro_rules! assert_eq {{
         ($left:expr, $right:expr $(,)?) => {{{{
-            kernel::kunit_assert_eq!("{kunit_name}", "{real_path}", __DOCTEST_ANCHOR - {line}, $left, $right);
+            ::kernel::kunit_assert_eq!(
+                "{kunit_name}", "{real_path}", __DOCTEST_ANCHOR - {line}, $left, $right
+            );
         }}}}
     }}
 
-- 
2.43.0


