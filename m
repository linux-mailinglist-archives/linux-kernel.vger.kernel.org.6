Return-Path: <linux-kernel+bounces-562980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDA9A6354C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 12:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE627A009E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDDF1A5BA0;
	Sun, 16 Mar 2025 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKCBdxE4"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C46610F2;
	Sun, 16 Mar 2025 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742123847; cv=none; b=jLCx4/nv0lo1mdTLHmRjlUWrlpeNQ6+K+NU7Y8dR7U1VuEiKFGqIDQHy9HJm7k5ncICUeWad5FIdeEgVLkRxnWqsXFFW27izsSmPS9IZ+84tOMhnJAPc7Fg2VTCx0jZMXy+ZCqD7z6WXgK1IXhRP0fxq7wM54zre2siBTeZN6RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742123847; c=relaxed/simple;
	bh=wXrRXSKIgjjqhxlYLUjsJzrzClsQWOXKEjrXfmiVCqU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rf1aduaptSUXHrOJORT6YTW1Hnslhoa7VD3xAVDX13p5Lv7gg9W7YtFHSdASuAPj02tFt17YQEKiFddF1XmdIlqtR1FB6jvIgETEaYgDbe+KREPdltmyAwik1lMPMpWZFluQZmydm829sGae5XDZHf+FP3MmxShKmmrkX6fSeTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKCBdxE4; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f3f149c334so2227633b6e.1;
        Sun, 16 Mar 2025 04:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742123845; x=1742728645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ekjsEa3df+HXolOxxQjVErHPPoRYP8orqeSGkgsPOaQ=;
        b=DKCBdxE4YNdjAveDhQRmtqrgu4kFiiSwXcOuk2SCfjMKhrN1r2P73wJgkRmUZWl9+/
         Z9w+2l/vM+0KGcEoMreRGj8lY9dGbXNsV/pQYKIvGwMtYqyIExx9mdNE2P1FyL6KTysj
         9Su3YFHZUlseQo+Jt2gRl7/DZpAVRVk2oh5QKHuQ9T+qu3fRNgDcnq8iIkcTAIlDTca6
         9at0TiMeV1BiJfmXj9mHsM5BAMS5OyrYVxyVzjFH/s4Vg0eApIxI5bBqzh4Znal1A37w
         zOMUnyEeZq/vab9UgSFyPRNaBwjQsb8vwWhOd1uMlvY5SdM/oOjJz8L1di0e2KzhXttv
         Ckrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742123845; x=1742728645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekjsEa3df+HXolOxxQjVErHPPoRYP8orqeSGkgsPOaQ=;
        b=ugB/4gYNGeiuiX9YcgYrc+qS1nyLx9Wa9RC1Wfc42GLGBG7oyXx9hqlBTa/4F++wpK
         6OVTnkulmLDEd5YA7IzK04ubQ1ylEVvn60ePuBfl7n4gILBNo0KFw38yNvtWnNfOwk/E
         53sIuqTB0pQe5cDeh4n3xs9S29WNr+jfbGDKS7INf1YyoSCpnVn12F4kT9D36Zge4eNt
         YheYwjo+l0ahv+2z9XqvBn45BVF22Lfd886PNsiU3JBC3qZrcxW/6TS62Sk7CfCSf9zb
         5pZ2lxZTGluBz1OlQkEtZbXUvbBGYnlwhQIGwDMOsrwWUkvRuRxnwBsZOzPGURi0ZY7a
         KexQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwNjQqqZjtilOHTzeph/LVNADgH+uNK6axfhT2douId77k6d/yvZkMcmT75S/7IvziwTn1xQBoDxg=@vger.kernel.org, AJvYcCXe4zYgzZfAQsmtIuU8TNgHcF8ah6X+SHEPNwA5gQlfrC73n29vktRN8zfZAYIaGWsl+o3mycwZK4uN89dSRMM=@vger.kernel.org, AJvYcCXm8fh6AQ1YgoEzfuY3CT8W9zHwSyYNw/tQYZ++r+VF6/p2WJrnLSDKNcrjGHwvoUuCqSPh2YeMedSeZ9Ey@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7aw7ZhvPDCCZ6ru8oa2t79lJhdVbHD9wYSa9UwUxqaWr0Xx99
	wdBs8CTEibVe9ZJuf6BlYTmhHGH6nIUk3wvrzHugr7189DptQtzk
X-Gm-Gg: ASbGncvNW7POlFdxoUrfr11dStHRz1LDinEK2E+RFGkqsrqo4eOsF7HAy71x56P8Lft
	jgJymDf9c9onqWDaHGttNtQamVA/LjHaXOx6nuePyQxF+ShXrhx3j0pq1Hp/xPh8vb22jVm93Hp
	qE3+y6J3AeXZzsVV4xvcKG8UD+g71azGkh/u1glXh+vpDDzyqlJoYum0pyfiEs75sBqgw91IO6D
	RS0StBBnEnGpvhi5AEGSnbsAOQII8f2lgGCTs9/EE/iRh0wq0Wi5hRSRl/xSzGP1ZV0mkzqhyUd
	/E/EMnsQCS3e6R3ZwJ2IHjapAanCay4HUS10FIv+l5dCBlxSZWi0TFrfYUyZFRXt07kvOmRPb+L
	A7gL+gha4jZEKMph+WeAFoTEBykE=
X-Google-Smtp-Source: AGHT+IEjg2xfhvPfXaY/5Cp/9QgKkPC0d1FC1flzt29b+ldjcXyycYr78QYS2iUROkMc5ivHSaEeaw==
X-Received: by 2002:a05:6808:23c3:b0:3fa:f848:8dfa with SMTP id 5614622812f47-3fdf026db54mr5046847b6e.30.1742123844546;
        Sun, 16 Mar 2025 04:17:24 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3fe832ce015sm715978b6e.7.2025.03.16.04.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 04:17:23 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: dakr@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	corbet@lwn.net,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	andrewjballance@gmail.com,
	acourbot@nvidia.com,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v2 2/3] rust: alloc: add Vec::resize method
Date: Sun, 16 Mar 2025 06:16:43 -0500
Message-ID: <20250316111644.154602-3-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316111644.154602-1-andrewjballance@gmail.com>
References: <20250316111644.154602-1-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

implement the equivalent of the rust std's Vec::resize
on the kernel's Vec type.

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 rust/kernel/alloc/kvec.rs | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 18bcc59f0b38..eb6d40a1bf8b 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -554,6 +554,32 @@ pub fn from_elem(value: T, n: usize, flags: Flags) -> Result<Self, AllocError> {
 
         Ok(v)
     }
+
+    /// Resizes the [`Vec`] so that `len` is equal to `new_len`.
+    ///
+    /// If `new_len` is smaller than `len`, the `Vec` is [`Vec::truncate`]d.
+    /// If `new_len` is larger, each new slot is filled with clones of `value`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = kernel::kvec![1, 2, 3]?;
+    /// v.resize(1, 42, GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1]);
+    ///
+    /// v.resize(3, 42, GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1, 42, 42]);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn resize(&mut self, new_len: usize, value: T, flags: Flags) -> Result<(), AllocError> {
+        if new_len > self.len() {
+            self.extend_with(new_len - self.len(), value, flags)
+        } else {
+            self.truncate(new_len);
+            Ok(())
+        }
+    }
 }
 
 impl<T, A> Drop for Vec<T, A>
-- 
2.48.1


