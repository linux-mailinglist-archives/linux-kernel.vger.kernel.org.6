Return-Path: <linux-kernel+bounces-566883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C918A67DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749B03BF385
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF662144B1;
	Tue, 18 Mar 2025 20:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+v8vXZu"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81316213E92;
	Tue, 18 Mar 2025 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328865; cv=none; b=DLRQcgqszQ8C/ka5b7JikZzE2PN37ofFCT9L1OewfhCrn7VqQooCoKgXRra/n7su3XloMmtZt1rZPUpga05S24sFopkT68NDKoeNvbZbgPyWCCsu4QIlAZmY1QNB+1cFjQIMjON1yutwoYRyhZzET9so/hftEo7QgTl1yyIB6RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328865; c=relaxed/simple;
	bh=7+0rzdIb3E5uC+bBhbWSE1kHLKPgCfbyaxKsl765tN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QLnHEFPo7HWCaoA9R4dh/WWwb7azT4008GfThcxjT15VOiZfBb+8/TCRROxrTGNId0vlwnGWFmroztEXLLP/kh09DNCRyv7KDIGykHKGYN0xUke7Ll3Mo3DzJ5pOYRK9QvZr8oTHhvaruyJRYJaCYyuE2NpQnfadcdCXOvMx4ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+v8vXZu; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8f8657f29so47998386d6.3;
        Tue, 18 Mar 2025 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742328862; x=1742933662; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Ui0Js7vP/HnV0ydOiZt9XbGjxD0E4LWZMWUPUUTT4M=;
        b=Q+v8vXZuntbk+zqYH9vcxefNe4ku8G8F27LeSyQnyPF2BNHwii/dJXqmKcbBPUPTIZ
         1P3n/9km7TsvcBiQCALf4kGBbzzilzG8uibbsdgny8AjUqr2Zq7s8zp7ggvPLw3VtFPV
         Qm14izBaw8e6iO4+GYe1PyCN1qlnNB14Bq9Kd2iu3u+BvI3RglmSOkOoxtVtBqslwba8
         4FnCHpvVQ4TU1vmBNqz3gT2yBYRQbRjzuc+inaWR0qsTeUvrxW2sUMfVqTGK1xtg2+WQ
         GUJZYV6DN1QpUsVPsJ1thahyDF0tbcVEZXU+LfZMl/5obv8h+4Li2skVcZacrmGJpN6e
         Q/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742328862; x=1742933662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ui0Js7vP/HnV0ydOiZt9XbGjxD0E4LWZMWUPUUTT4M=;
        b=vNUG3E+XGrBfNhzKTPS5/M3n2UET9FXxa/bx4hnyetgtmiPU5Vig3l9Vp2tPjicUgS
         9wsgS8hu2Y34khjf48xR1LPosCpSm1t8qWEhNv6hbw0M74Jp0FbO1rwZe8BaqL5tiJ96
         DD3Ndi0a4PKAKjM96mSNJR8MOPchMDXB1lBW2nK9VJp0ac638pPu/np1rYY3IXg0Lz68
         8a2Uv0ayJKZgH1tQkGFUhgJd7xZAPoFCtsN2opoHteiLW0Q47BVGEprsunCuXvEvtqG2
         LEc7WA+AC/w00oFGNiSsan4ZLrvqG6swyuGPeEEZ+FT+7mEse9/S8WGYDDfpBvW7YFZ6
         wlPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwKL2zZjCd78/EcXtlo4jyPacBmuBcUHak03/HQmElhHgMdawAvSbhm2MnUddMgxxCXZgQU2eTBhY+KnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR/vL05da600x6U5bRpqd+h1qMGXP2dm+meXfegIZVcquOKLWs
	uTfpB+s4R+0pSydcJEGZYyISfqQgJIfgpoyO+AXoFTaV4EOWZhg2
X-Gm-Gg: ASbGncvhzOOT71MFnvCufiG9/gSvjXPiryoRtrJUee0twYXYYRodWbB+cjUjTfzEZoC
	DzM1yrQ0SvUC7moeGcT/Byk9RNzrrhVIOTeqbFmudzeQXV4jR+pLoIIK+08lshAFxYowds1QX37
	OQ6+0URdzIe0c7QMXxxwl1CgwzSBSZFU3NX4T7FR6n0Bbxssyp2YBN61L7IFVruaxBLk36+Fn/B
	q2z/3o3XXGzu68kmwBgpwYZ4goFMuN4k+87rivpMqkwruztqX+1//gwR51Mxaq0x2Tfbh7/9dH5
	CYhv4hLoIOFg2X6fVaJ3GGM8xbBUXkPwgfwQO9MIlVxheWs91LIaAVMDFijQWBRAAH7c
X-Google-Smtp-Source: AGHT+IH3owlftZQk1ycNvpWBiE0nuK9EkqNgNzbk0uPgTfoU1HhTlRK3YIlb66/5OuxO+c94pRsULw==
X-Received: by 2002:a05:6214:27c9:b0:6ea:d69c:a22e with SMTP id 6a1803df08f44-6eb2940f29bmr2364306d6.30.1742328862311;
        Tue, 18 Mar 2025 13:14:22 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([2620:10d:c091:600::1:e903])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade209335sm71301046d6.22.2025.03.18.13.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 13:14:20 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 18 Mar 2025 16:13:54 -0400
Subject: [PATCH v2 2/4] rust: alloc: add `Vec::dec_len`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-vec-set-len-v2-2-293d55f82d18@gmail.com>
References: <20250318-vec-set-len-v2-0-293d55f82d18@gmail.com>
In-Reply-To: <20250318-vec-set-len-v2-0-293d55f82d18@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Andrew Ballance <andrewjballance@gmail.com>, 
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Add `Vec::dec_len` that reduces the length of the receiver. This method
is intended to be used from methods that remove elements from `Vec` such
as `truncate`, `pop`, `remove`, and others. This method is intentionally
not `pub`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/alloc/kvec.rs | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index ce58ee66c99b..97cc5ab11e2a 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -198,6 +198,25 @@ pub unsafe fn set_len(&mut self, new_len: usize) {
         self.len = new_len;
     }
 
+    /// Decreases `self.len` by `count`.
+    ///
+    /// Returns a mutable slice to the elements forgotten by the vector. It is the caller's
+    /// responsibility to drop these elements if necessary.
+    ///
+    /// # Safety
+    ///
+    /// - `count` must be less than or equal to `self.len`.
+    unsafe fn dec_len(&mut self, count: usize) -> &mut [T] {
+        debug_assert!(count <= self.len());
+        // INVARIANT: We relinquish ownership of the elements within the range `[self.len - count,
+        // self.len)`, hence the updated value of `set.len` represents the exact number of elements
+        // stored within `self`.
+        self.len -= count;
+        // SAFETY: The memory after `self.len()` is guaranteed to contain `count` initialized
+        // elements of type `T`.
+        unsafe { slice::from_raw_parts_mut(self.as_mut_ptr().add(self.len), count) }
+    }
+
     /// Returns a slice of the entire vector.
     #[inline]
     pub fn as_slice(&self) -> &[T] {

-- 
2.48.1


