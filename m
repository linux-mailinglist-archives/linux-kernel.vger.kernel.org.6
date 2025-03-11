Return-Path: <linux-kernel+bounces-556222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AE1A5C2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B0F37A3273
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28431C5D7E;
	Tue, 11 Mar 2025 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8iWh3Aq"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681FD5680;
	Tue, 11 Mar 2025 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700052; cv=none; b=WGz/0TzewIKvCVkLq9aT3C4kCMa/b3dyjxRC/nsPvT3dYvbywNNpgRiaS+8BZ6t4NUUNxtcuNjSa4v4xG+ZkqbKnPHhQaw8vHn4VX9S89u4RfXLYtnPsdrmsiDkFkym/u5BXSCNpNz8c3/wtR5tislEz9eUNIwghOO9LYe5ApXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700052; c=relaxed/simple;
	bh=i1xj+zFG3UehjU44ahmp1dt39i4m5KVte78HhzKkb/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HKgbpeB0ROZkDOBNdJ32ZeKfUKQfn1O7LmcvN3DhOub5Gw57twet0Vrkp8zQWfopRX59ETpuXXJgVn8woXSlSCkJk8ohp3W8hrCO/zU7slE0595uTlRWyyDn9ShMQPXBDAcgrImKsKqyA/9C+p4Cw2DCr5VeWxmsBySF9sze92I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8iWh3Aq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22548a28d0cso11920645ad.3;
        Tue, 11 Mar 2025 06:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741700048; x=1742304848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k/e1H/WN0SKrMg5KpGRPOz286h8sEdauBj5iHRxNHp8=;
        b=d8iWh3Aqns8RJJmLWArU3QlePJ+1zRQmfKPIINYfDaa0CKt8lkUrSGZsYWoZt/AfWa
         ciueyso3dcq5f1mzcmbiDlQsjK1oZ6Quh2VwybWdoQzpX2Uc5oG9IPoiZfy8lSBR6ao1
         /WFsjTqhGd8NFhWc0geFyJ369PMQYMB9cu+mLs7PcwxX2xO1Z5c4G/iEP8uftUdkHMla
         z6kHJ/OCnttRhIqLtbAAw7Z2TGfpATkN4Igru2Kc+3Zrd9agcFsn2N1FV6I8aYUJm0qE
         VqsJsKWp7B+rJCyzsFBOQGjfkgW0b2kpfTOUCwmjWj9ZigDjtSHzsU0Emyodi8cbWf7o
         weSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741700048; x=1742304848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/e1H/WN0SKrMg5KpGRPOz286h8sEdauBj5iHRxNHp8=;
        b=GPXYYx6aneAEgKqaDpPWTo3cCONCfQ2wI2OGqfSkA+A9gGOrt4WB4prnKEItxoNpt9
         /rA/MITCaNIKQMQp6KvzOs//WtRpK1WwxY/FYeJBioDWzb+0RPFgDsLhtSEeRaBdqdEy
         wrvs3rZTVubMbC8mDhbZ3UGDtobnilK/1gXqmYvcdsLGTbAU+nBw0cr3YfXEk4OsIzxL
         MD+QDyHm8VI4QQ4sywaoz7JKLEGygJIZMrW54B2oNfQTVO4EoHMaeDhGIL71XLsnBBY7
         8UQk4lPOAJv4dLmaK/PSXhV9VQlY1vowBkdWpNpdAveszCiBCt0EdnDoH8T1OU7W+iUk
         YUIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYBUnRHiMZTcgIYjub0ABxxrvJPsLBNrUW64F5FE1AxTvp9P8D0dBs6RwMhNI+CBqT4uhKBNS+61IPF7Y=@vger.kernel.org, AJvYcCWw4wH7Ik1MGyHDBnXeDP9XfB3M++YI1jS2wzIDfn9RZqqX0RCUapzGE9kAg9SNmEie7ZQygLB/B2DLPKMZNMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgre3XpotwMXyvEXhnZMErinuYwo6lHr3H3MkwcmHO7yOOO/ry
	hLXLAmnB7z8qFUgA2aaf021omsML22wv4DA2Fdm1ZDWHwtXLhULX
X-Gm-Gg: ASbGncvdeDyS3UhiWcoyJBhsuJR6SenM35hxrZ9s+Jqfc10P28NsloEdCV6Bnu6NhYx
	/ULzciUcJDJTiVk7LNPAWQWPlLssoj5q21RTgeXl1b/YPNYPcu0TC37Nonu5sZYbCmxtEfY7Itj
	vDLFGfPRxlGqeIBnojY+W3I37hvnexmyKva1bXGbhoVWAJt42BxNAoShch5O/z+kPNVvUz+tGXT
	x3irzmlxI8Gn8FAJD3gMyAGW61l71FlKbqpAbLLOEzKI4HAWK+tlaHzTMGa4oNCJpRYFcAcUbdb
	mkwArU0VwkKAfGaVG1CXRfFpzSTCmI99kc3oO8F88xN3kC7pmnczYXkCIi7KQxQiMfIzTB3Jths
	=
X-Google-Smtp-Source: AGHT+IHuXyhKb1RBCu+eBFncNy9UpOy9LOExMY69QgsrQX+D8NRENRqvH1GWrXfdX3vSR02LO3SFPA==
X-Received: by 2002:a17:903:1788:b0:220:f87d:9d5b with SMTP id d9443c01a7336-22428a8ca41mr290901485ad.24.1741700048488;
        Tue, 11 Mar 2025 06:34:08 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:fdf7:beab:3280:ac4f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f96bsm97398105ad.133.2025.03.11.06.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 06:34:07 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: ojeda@kernel.org
Cc: alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	jserv@ccns.ncku.edu.tw,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [RFC PATCH v2] rust: list: Add examples for linked list
Date: Tue, 11 Mar 2025 21:33:57 +0800
Message-ID: <20250311133357.90322-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic examples for the structure "List", also serve as the unit
tests for basic list methods. Including the following manipulations:
* List creation
* List emptiness check
* List insertion through push_front(), push_back()
* List item removal through pop_front(), pop_back()
* Push one list to another through push_all_back()

The method "remove()" doesn't have an example here because insertion
with push_front() or push_back() will take the ownership of the item,
which means we can't keep any valid reference to the node we want to
remove, unless Cursor is used. The remove example through Cursor is
already demonstrate with 'commit 52ae96f5187c ("rust: list: make the
cursor point between elements")' .

Link: https://github.com/Rust-for-Linux/linux/issues/1121
Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
Changelog:

v1 -> v2:
    - Abandon new implementation of method to create a new "ListLink"
      instance
    - Rephrase the examples' comment
    - Increase the coverity of the examples

Tests was performed on ubuntu 24.04 with x86_64 architecture.

$ ./tools/testing/kunit/kunit.py run --make_options LLVM=1 --arch x86_64 --kconfig_add CONFIG_RUST=y
...
[21:13:11] Testing complete. Ran 615 tests: passed: 563, skipped: 52
[21:13:11] Elapsed time: 23.020s total, 0.001s configuring, 10.985s building, 12.020s running

Rust related unit tests are all passed.

Best regards,
I Hsin Cheng
---
 rust/kernel/list.rs | 117 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index c0ed227b8a4f..b88b63432e02 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -35,6 +35,123 @@
 /// * All prev/next pointers in `ListLinks` fields of items in the list are valid and form a cycle.
 /// * For every item in the list, the list owns the associated [`ListArc`] reference and has
 ///   exclusive access to the `ListLinks` field.
+///
+///
+/// # Examples
+///
+/// ```
+/// use kernel::prelude::*;
+/// use kernel::list::*;
+///
+/// #[pin_data]
+/// struct BasicItem {
+///     value: i32,
+///     #[pin]
+///     links: ListLinks,
+/// }
+///
+/// impl BasicItem {
+///     fn new(value: i32) -> Result<ListArc<Self>> {
+///         ListArc::pin_init(try_pin_init!(Self {
+///             value,
+///             links <- ListLinks::new(),
+///         }), GFP_KERNEL)
+///     }
+/// }
+///
+/// impl_has_list_links! {
+///     impl HasListLinks<0> for BasicItem { self.links }
+/// }
+/// impl_list_arc_safe! {
+///     impl ListArcSafe<0> for BasicItem { untracked; }
+/// }
+/// impl_list_item! {
+///     impl ListItem<0> for BasicItem { using ListLinks; }
+/// }
+///
+/// // Create a new empty list.
+/// let mut list = List::new();
+/// {
+///     assert!(list.is_empty());
+/// }
+///
+/// // Insert 3 elements using push_back()
+/// list.push_back(BasicItem::new(15)?);
+/// list.push_back(BasicItem::new(10)?);
+/// list.push_back(BasicItem::new(30)?);
+///
+/// // Iterate over the list to verify the
+/// // nodes were inserted correctly.
+/// // [15, 10, 30]
+/// {
+///     let mut iter = list.iter();
+///     assert_eq!(iter.next().unwrap().value, 15);
+///     assert_eq!(iter.next().unwrap().value, 10);
+///     assert_eq!(iter.next().unwrap().value, 30);
+///     assert!(iter.next().is_none());
+///
+///     // Verify the length of the list
+///     assert_eq!(list.iter().count(), 3);
+/// }
+///
+/// // Pop the items from the list using pop_back()
+/// // and verify the content.
+/// {
+///     assert_eq!(list.pop_back().unwrap().value, 30);
+///     assert_eq!(list.pop_back().unwrap().value, 10);
+///     assert_eq!(list.pop_back().unwrap().value, 15);
+/// }
+///
+/// // Insert 3 elements using push_front()
+/// list.push_front(BasicItem::new(15)?);
+/// list.push_front(BasicItem::new(10)?);
+/// list.push_front(BasicItem::new(30)?);
+///
+/// // Iterate over the list to verify the
+/// // nodes were inserted correctly.
+/// // [30, 10, 15]
+/// {
+///     let mut iter = list.iter();
+///     assert_eq!(iter.next().unwrap().value, 30);
+///     assert_eq!(iter.next().unwrap().value, 10);
+///     assert_eq!(iter.next().unwrap().value, 15);
+///     assert!(iter.next().is_none());
+///
+///     // Verify the length of the list
+///     assert_eq!(list.iter().count(), 3);
+/// }
+///
+/// // Pop the items from the list using pop_front()
+/// // and verify the content.
+/// {
+///     assert_eq!(list.pop_front().unwrap().value, 30);
+///     assert_eq!(list.pop_front().unwrap().value, 10);
+/// }
+///
+/// // Push list2 to list through push_all_back()
+/// // list: [15]
+/// // list2: [25, 35]
+/// {
+///     let mut list2 = List::new();
+///     list2.push_back(BasicItem::new(25)?);
+///     list2.push_back(BasicItem::new(35)?);
+///
+///     list.push_all_back(&mut list2);
+///
+///     // list: [15, 25, 35]
+///     // list2: []
+///     let mut iter = list.iter();
+///     assert_eq!(iter.next().unwrap().value, 15);
+///     assert_eq!(iter.next().unwrap().value, 25);
+///     assert_eq!(iter.next().unwrap().value, 35);
+///     assert!(iter.next().is_none());
+///     assert!(list2.is_empty());
+///
+/// }
+///
+/// # Result::<(), Error>::Ok(())
+/// ```
+///
 pub struct List<T: ?Sized + ListItem<ID>, const ID: u64 = 0> {
     first: *mut ListLinksFields,
     _ty: PhantomData<ListArc<T, ID>>,
-- 
2.43.0


