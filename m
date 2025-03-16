Return-Path: <linux-kernel+bounces-562889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D57A6343C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 07:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E4F189388A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 06:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6906318FDDC;
	Sun, 16 Mar 2025 06:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="aQQX8LmP"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8118DB3B
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 06:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742106038; cv=none; b=p20nJP+UwXdOhOBorUkB9GHdOoPjXg2tu5/cO2behf9MIDVtR1lrCme6QLaXdrvfqSElAQt4CYwfW6+Mx3131KxhZcFWeQ+u4jIra5vso7VYEMu7mrSJo6e8W3U3T8ULubENqDiuYUHjy2IU53iiFRVBtYJLmj0/gzFQiAEPB/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742106038; c=relaxed/simple;
	bh=7xtq9V9ZKDfuDOMQ7bSuv/tuXVUycqrzxOpXl1DHs3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTMh/Zb3Nf97KIl3Pz65HRzbwh1TwgDq0WxHypJZbDHxSwDOH1NQN01WSr0YzCvMpSqrlQuJUbwO5TLCu4DVtg1380QvWb0A+2qB3i2j4lpvsoCSW5tOAabVllcabOGb2dgUgeth8ZZk0TZVw+UHsMvgERxtcjIz8lS/NDIWiBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=aQQX8LmP; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e6405b5cd9bso1207161276.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 23:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742106035; x=1742710835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vynQu5oPfCf0AJPNbZKcC+xMNQVxNSFqPXWtVec+6Rw=;
        b=aQQX8LmP/sVikylVUV3ftYl4lOoI4/SPDBlL9G5tL6mGr85gzHIuOwbReHSvaPwuPP
         1CmOxrlzN3XG7q2A48+1eGIv9UWSQO8/8/H9al94ocpDF1fjMsjjCiJLHcN7j34fwOwE
         2HlEDYxm8cAYwLuT9LYdK7BnXoqKsCqi9aj7ucxh5mZeseH7kI+IvBkiTDfJKCApkYTE
         IhWwpQZJc4sm/iCZOxyTG+hzypJURdAGYUYolU3T3lbqf7akDnoXvETMYJbk8yHyg7yK
         krMAkcHzBCh2qbWQm4NSz+6cCPwuI3MW35z9fk5Osny4Ss3A+A5bLbg9pNRlmiTiIVln
         YIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742106035; x=1742710835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vynQu5oPfCf0AJPNbZKcC+xMNQVxNSFqPXWtVec+6Rw=;
        b=AM75MYvpyg2bCKgQaFOxBdiO3ToC1OWLLIWe6T3wiAOCOaKn+5F7jariwYMtQE5j9A
         7l/7gT2KlOhHpFdQLb8/WJhEQJk9boy3dBu2/1pfDcwmI4u3Nd+z5AKvXmuH/ddctt+2
         aFby0t3yQnIGVOh8o8u7KL3isu/FHWZXiRWtMUTlLHrz5UuXYezGLUZwjbeHrEm2X6bb
         yqvgFyTBEqmb7/2JBo+4apPQE/WcMXHCr3VcjqS6a3MdEpvVm+/FLavQKI93Yo2FmdIi
         QWouyww7wf00dkwdp/cdFaqGowl3oHJqTLrmgxOuC0+kfWfddChWYjXEHIO0dMTdIBs5
         cPUA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ68KYiGV50rVz1cIVCWuTam/dzeChZGEqHEvMca8EsxHoK1nEsOLjWw5G85mGwPlE/xhsj9JgIWbulac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnRVvtv2rueial1Kuijn6I2l0SASt/f8IZkQRwEshl2B5Zu3FR
	PdPmPKNpF2l/UqU8/G6htiUxZw9khqWVAm9NEPVh2BLCvTcUbJJB2jJLmyYm2eU=
X-Gm-Gg: ASbGncthyYbRyRxOpUV4rup19hX5wcMgAISlWxx7WX2Vl20Aw2yuAMEsOnzxLlRBeum
	aLEQmneKGNh/g8xuV6xbogRnu/+04/0QY8M7p2lOvcIx5SeLOpkwcIum1cu/SsYA630wGATUyu0
	f8CvclFoY/cLWNd02t8blibCk1yxmCiJKqPSJtlbkmwX4OgeJJeH/5ZQhE+WFriMMAUJX7lRpeM
	qaNpsWQAMxrllD1rXrIxRDqzodOlEAOo+lsBa4ZqOIgHaNFsotuPAEoZaRI1X8ksG8Rv7+OKXKH
	eOAIbBHvpo2Iz9TijU65Ogcx25us0B2C/i6hzySLyIIuHbzFuOfo53ELnYw6X+DV9zeHexBpVP7
	JiALCMngtyb17a5h3NhHlN8WkI2S0qMHrwm1nrURJ
X-Google-Smtp-Source: AGHT+IGRIHeKkrWlVqgNcR+eGlkpCtZNJD/G9CDzmL+wplncMLNFsUir2r5yjGcPNmlhwKfMKaw6og==
X-Received: by 2002:a05:6902:2184:b0:e5d:ffca:7062 with SMTP id 3f1490d57ef6-e63f883a78bmr9508330276.7.1742106035532;
        Sat, 15 Mar 2025 23:20:35 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e53fd277sm1618673276.11.2025.03.15.23.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:20:35 -0700 (PDT)
From: Antonio Hickey <contact@byte-forge.io>
X-Google-Original-From: Antonio Hickey <contact@antoniohickey.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Cc: Antonio Hickey <contact@antoniohickey.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/16] rust: platform: refactor to use `&raw [const|mut]`
Date: Sun, 16 Mar 2025 02:14:15 -0400
Message-ID: <20250316061429.817126-7-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316061429.817126-1-contact@antoniohickey.com>
References: <20250316061429.817126-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
with `&raw const place` and `&raw mut place` respectively.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw const`, `&raw mut` are similar
to `&`, `&mut` making it fit more naturally with other existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/platform.rs | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 1297f5292ba9..344875ad7b82 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -14,8 +14,6 @@
     ThisModule,
 };
 
-use core::ptr::addr_of_mut;
-
 /// An adapter for the registration of platform drivers.
 pub struct Adapter<T: Driver>(T);
 
@@ -55,7 +53,7 @@ unsafe fn unregister(pdrv: &Opaque<Self::RegType>) {
 impl<T: Driver + 'static> Adapter<T> {
     extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ffi::c_int {
         // SAFETY: The platform bus only ever calls the probe callback with a valid `pdev`.
-        let dev = unsafe { device::Device::get_device(addr_of_mut!((*pdev).dev)) };
+        let dev = unsafe { device::Device::get_device(&raw mut (*pdev).dev) };
         // SAFETY: `dev` is guaranteed to be embedded in a valid `struct platform_device` by the
         // call above.
         let mut pdev = unsafe { Device::from_dev(dev) };
-- 
2.48.1


