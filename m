Return-Path: <linux-kernel+bounces-410966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA9C9CF0EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8713C1F2AA00
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067EE1D8DE0;
	Fri, 15 Nov 2024 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVHJfBaz"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C541D88D7;
	Fri, 15 Nov 2024 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686457; cv=none; b=g4EqYrrVjMmT/nIXNQATiLX8+HgpugnN3BcXSMfXNiky6+CjqsT5CvR3uabB8pjred5VkeLsEepV4piQW+GApwImfkkpzrcx0oUfZjNrOK30/PFLePm1mIaNd5Fu43ky0cKlZlEFHWGo6xssw68OcHPpqz356+oSBc+qV1M+V+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686457; c=relaxed/simple;
	bh=akhMarqEAGs2r0ixu78494NfI3AtdtjayQYRt4CjG88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DDt5fGT2CmS/CDHlqR3opfu4qgu+zLznjLXpk5LxafZjoWgreuwoY3Fe6qJMiGgJrL2wfIMjjPt0hSxViiEPzl+m0vLW/OYL7EWyVeD6W/7DW515ACJ5XihNaflX1t/A0l+Q10COuw7eVR6eGRhphC0ZbD5EvEK/AxkfO7zPD7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVHJfBaz; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b15eadee87so61821785a.2;
        Fri, 15 Nov 2024 08:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731686455; x=1732291255; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PwKabn9mlzVsv9jDUI6+PuwLrpvjcn+d7aup2iIUyE=;
        b=RVHJfBazZjOFWCVjS36lLyKHFHCx4Hodz3/c59b9dlI4zdVXMqFkNHK9YREJj4b1uS
         hf6gK/dRgR9lBXDr/rJUTkhcusFIHYyKp36KwemdItR0qdPwNY4XYwITNNjfwr0GtJPP
         lxQ2TUfhkdMUoSYbMsl9ZAr2/TG1ycS7OfO5mXVRNH3FjHuZSm9M0oo03plZUksaLshp
         6qBNepFbPaZqj1VceCgyT9uotgT4YGTVnpwN8S3FzGQsnDOk4hVfZBXS/7Fe4DpssktZ
         4M3f8eH/aJMP7XDb+OGsFUITHBIF0TsgM21QNNXtPK4yIwDuKuHNE35T/KiyFbuEOUi4
         nr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731686455; x=1732291255;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PwKabn9mlzVsv9jDUI6+PuwLrpvjcn+d7aup2iIUyE=;
        b=in9zGL/Cz5YPTsypdc3NMlceiuF7HBDLk6/+1AxQCvuqhfA7rK1mSYmgDvCkargrg9
         wGPT+YOif2jwe7rDW/vJ0H57fbEQ2AyPk7qL4PZ0dPSdu9TaJ4DXMIjfokbJmXpp1G3R
         10efx5SsRA8dYPBweAUsDIWFMl/E83Ptk9HhDrzNN9SM6x0z0aqq9D8c2TWkGSEf4dwr
         Hf2UO7M/A0+1LDDW4MSu+G0YMSBexwXOHocN+ny8TpjiEN3blisJWx3YhsxgYnZEGWTm
         l/8wcThhXqoqqrVsBmwQjmzkRLrfeHz1TZeeqrDVMPsJGiFXUqnTMIvYfaqhN6kal7jK
         tt/w==
X-Forwarded-Encrypted: i=1; AJvYcCXU3Y8UkBURxAtLKytriFZyQzRmcuk+AmCaqTVAVM5XoE0VKFQ1YktCB1n4QAGMfQPIAyNEL3xCSTAtWiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgpT3G07ErBdtbimrmDtotR8FE6rbcU3EymCFnzsHUvL/NZLLb
	3ffj84hpxOXpRsXklDCcBErqK6H1L52WSQ10GoReaHVos88wfOlR
X-Google-Smtp-Source: AGHT+IGGtij8MAipt9Wpbx1uiowQ/EDmNiw2rUXf3eZKNRpo+/YfWCyerO7sNMGBBdtsKI3P/TlSNg==
X-Received: by 2002:a05:620a:1aa8:b0:7b1:4605:29c6 with SMTP id af79cd13be357-7b362397b60mr382506685a.62.1731686453189;
        Fri, 15 Nov 2024 08:00:53 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:edce:cf6f:2815:775e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c984576sm171108785a.25.2024.11.15.08.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:00:52 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 15 Nov 2024 11:00:46 -0500
Subject: [PATCH v5 3/6] rust: arc: split unsafe block, add missing comment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-borrow-mut-v5-3-86204b249667@gmail.com>
References: <20241115-borrow-mut-v5-0-86204b249667@gmail.com>
In-Reply-To: <20241115-borrow-mut-v5-0-86204b249667@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

The new SAFETY comment style is taken from existing comments in `deref`
and `drop.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/sync/arc.rs | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 50645660a9c33cb121ee1b2469003b325000d840..a11f267ce5d40b987f1f3c459271e5317ea0bae8 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -377,10 +377,14 @@ fn as_ref(&self) -> &T {
 
 impl<T: ?Sized> Clone for Arc<T> {
     fn clone(&self) -> Self {
+        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
+        // safe to dereference it.
+        let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
+
         // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot overflow to zero.
         // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
         // safe to increment the refcount.
-        unsafe { bindings::refcount_inc(self.ptr.as_ref().refcount.get()) };
+        unsafe { bindings::refcount_inc(refcount) };
 
         // SAFETY: We just incremented the refcount. This increment is now owned by the new `Arc`.
         unsafe { Self::from_inner(self.ptr) }

-- 
2.47.0


