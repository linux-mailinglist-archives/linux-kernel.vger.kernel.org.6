Return-Path: <linux-kernel+bounces-553658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F01A58D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DAB07A2551
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B01221DBA;
	Mon, 10 Mar 2025 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgBY9/PA"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0971D432D;
	Mon, 10 Mar 2025 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592341; cv=none; b=DPYIMly0k2tD9AOYT2Sk3eYNDKRAH+vaOsLypCS2Ad+rVIhjcRKoGHgGfpGvZFLlRpDDk5TJe9I2VYNS9tPvHWqAY1WCeu4xofRsQwW1t+dmtVEFxoUGvxbQd5gSwaZRS63/qGEnIGXFC5mZG2yCcnAGmUBs7LFfZbtiDz7HwDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592341; c=relaxed/simple;
	bh=fCU1Sx5+YSnEqYbZchw3WrT1XD+n4gHGxDYXlcM+BsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Be705bqzjmFE9z+mroYTWnk+jaLR71kdnYtm6gDH9ONrYMkX7CzASSC2qFzo4ip+5K9UPTkmj3HDpCIfIvIZwOBdilL4zcuQA3Hh5k5eOErPoKS/rCYsBKlKx8WXAK9z7s/agGh0aK8LwwP5bebvRubj1QJNsiJniaWuncXD6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgBY9/PA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22334203781so87553495ad.0;
        Mon, 10 Mar 2025 00:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741592339; x=1742197139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHaWEsIHkAJUrYIbd6YYFQ+RiGXu+yZ2V3PNN6+Sztw=;
        b=BgBY9/PA/iio9iMCknSIXv08SwX1qWMy1s0BnH8bOWgKnURnuxj62dxFsLop0doJA9
         o+ITpmuM/yLSA4HW74ZQ+pi4tvYPcFgCXBGM0EbwopEk9bvWQBO5/LjJ/3+hRvVPFbxs
         /Q55NIYy8xtHIdqhYA8ZnUyccKZjIMosCl8kxTChqiuxOGY39YxgDEztPnLCUwO6ZlWm
         BeIOuGWpXoTd2MZmti/ZFje0Dtgz3euQ7qUXsbc6tsHANE0DVM/QzgjSqTmzT/eZxupA
         YFrqNhD3V8sJlMAeKvJecGHvRiyCsjYl09VnkrYQaIyHWPJI61Upuo5vaAMl75EXde3F
         L2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741592339; x=1742197139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHaWEsIHkAJUrYIbd6YYFQ+RiGXu+yZ2V3PNN6+Sztw=;
        b=oQVeF9QbseI60XAln1tzujneWqZT6eQHrpLFPuwcHo7dX6TZ/T4GJOMHf4HVCEaxk3
         9g0KnPXrGh3Ap5+Nfa9OMorU4ndbtk0BsXWcp0TKXE/tFOR9t0Hm+/b++67jofWNZn9m
         Ofi52M0fpbGs2O5oFCEQqxFydjry5tShPs/VBi+Ff6yixfLIy+LwzD0HTCfYiUvmTe3H
         r0QOGQ8bx8EozrsuwLiMHqE4NoXlxbmMVRtwUluoy1jH9lGUzeri6tX8MyHS9lMiUb20
         zLQjRy56pOm2WC/FdPegp8Jo8qNcFaShvQSzDxt1fTDg2qsEjhBKLRDu604GoUHTrz2P
         sbBw==
X-Forwarded-Encrypted: i=1; AJvYcCUPep8wdAbiDrOsG2L22trOtz5P/TUnkdp4DgKnzLJ71/lLM7c0+Te1wPDo2938MQJI5dZH85uBbXWiLX4=@vger.kernel.org, AJvYcCWhIH2f8dzshKDzjoqfpnn4KjOPMVD59Yo5u2/1erulPMlnvAV7hW2C72M0yL4UPGt0Yx81+dNrC2BIjfSJ2kU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBd3zQnLonyI2p4EuHvExdr5+eoHhaXReQUCDSvX8HBk8Rd8Dz
	CmyxuFBGn7CPo2a/mUxbxLQv7uxOpwzPizWo1jHQ7eNuFXu7oL3/
X-Gm-Gg: ASbGncsYa73o+vKUHeJK/dtmlxsqxoyXUnKo2OoPMpZxb8p8euwSsHCxWRBNWTCUsC8
	KbYjHkxaukG+1ONT+HTOPTjJHcD8llLP1GJCJBkWDF3Pwwgp901sBwo7hTo96MiJFkTfXokjExh
	FlAECTQrz5cTfw2YvxniCP+sLrleYVpfd41poFrKE10aci+3uJVYHSs+fMDPfMpV5HKdoEke/tM
	WGnNxD+sLuvs5IvjZhaylS4v0kX7zHa1btuhbJ4Wdxvvdmjeeo99iWGLkM9GD3AIiYTENlOVtwi
	FnUyQFjgJ9AvukxTy0m8MVGmiseTS4IbWEGUvCKWt7qjdxKl2Vj3a45oI4DbYJteQPx+x4YZ3g=
	=
X-Google-Smtp-Source: AGHT+IFVo8LtjGiQbWI+3c2Cx6tD5XyGHqdiZkLi/zzbU3mW+ugZdMZ9j3iYsC8oE3r0nOHQUXUBdQ==
X-Received: by 2002:a05:6a00:c87:b0:736:491b:5370 with SMTP id d2e1a72fcca58-736bc0d040cmr13850411b3a.10.1741592339525;
        Mon, 10 Mar 2025 00:38:59 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:7ad0:37c7:5275:4b0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698450244sm7620234b3a.80.2025.03.10.00.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 00:38:58 -0700 (PDT)
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
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	jserv@ccns.ncku.edu.tw,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] rust: list: Use "List::is_empty()" to perform checking when possible
Date: Mon, 10 Mar 2025 15:38:52 +0800
Message-ID: <20250310073853.427954-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"List::is_empty()" provides a straight forward convention to check
whether a given "List" is empty or not. There're numerous places in the
current implementation still use "self.first.is_null()" to perform the
equivalent check, replace them with "List::is_empty()".

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 rust/kernel/list.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index fb93330f4af4..8f3919bd3f99 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -259,7 +259,7 @@ pub fn push_back(&mut self, item: ListArc<T, ID>) {
         // SAFETY: We have not yet called `post_remove`, so `list_links` is still valid.
         let item = unsafe { ListLinks::fields(list_links) };
 
-        if self.first.is_null() {
+        if self.is_empty() {
             self.first = item;
             // SAFETY: The caller just gave us ownership of these fields.
             // INVARIANT: A linked list with one item should be cyclic.
@@ -299,7 +299,7 @@ pub fn push_front(&mut self, item: ListArc<T, ID>) {
         // SAFETY: We have not yet called `post_remove`, so `list_links` is still valid.
         let item = unsafe { ListLinks::fields(list_links) };
 
-        if self.first.is_null() {
+        if self.is_empty() {
             // SAFETY: The caller just gave us ownership of these fields.
             // INVARIANT: A linked list with one item should be cyclic.
             unsafe {
@@ -325,7 +325,7 @@ pub fn push_front(&mut self, item: ListArc<T, ID>) {
 
     /// Removes the last item from this list.
     pub fn pop_back(&mut self) -> Option<ListArc<T, ID>> {
-        if self.first.is_null() {
+        if self.is_empty() {
             return None;
         }
 
@@ -337,7 +337,7 @@ pub fn pop_back(&mut self) -> Option<ListArc<T, ID>> {
 
     /// Removes the first item from this list.
     pub fn pop_front(&mut self) -> Option<ListArc<T, ID>> {
-        if self.first.is_null() {
+        if self.is_empty() {
             return None;
         }
 
@@ -493,7 +493,7 @@ pub fn push_all_back(&mut self, other: &mut List<T, ID>) {
     ///
     /// If the list is empty, this returns `None`.
     pub fn cursor_front(&mut self) -> Option<Cursor<'_, T, ID>> {
-        if self.first.is_null() {
+        if self.is_empty() {
             None
         } else {
             Some(Cursor {
-- 
2.43.0


