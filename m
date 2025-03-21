Return-Path: <linux-kernel+bounces-571199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42F6A6BA53
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25FD3B9903
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1E5226CF7;
	Fri, 21 Mar 2025 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W4Qk1exX"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7F1F150E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559028; cv=none; b=pfS248DXHftm4yqTC1E22lgBrhtg6lcGSh7yU+t74fS1EnXAMbfaNURP9fIvkEXA9jtqt4atUXFPH0YmSzk0aJvED9V5wEOdCTt4YVYbsTWxoA1vAyjOhAkDYaV8iRciW/67/sri3wvnbilh0Zr8zSVqk5HRbd/pHZYXBw7SnEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559028; c=relaxed/simple;
	bh=HshBdY9tyPHXYCABit0wg9iizu5qxvE0QHr6aVv8M2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rt2RpJ67LL0wf5UL45Kl7JWw6O04j7ENK8yhyE8NQCGvM4PQMk6M4vFrpmZnW5Fg35c2bwPfiIa5CvxJfCCTYI9874rA7Nzd8w+kugIw+ylLPnn5Wz4O+IjSY23TMe1zAIu1tuqNO8bui9zMLJeO+xtvQ5IISgBpmkYlkDKbm9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W4Qk1exX; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d01024089so13929655e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742559024; x=1743163824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RzX66093NdWDWJT+/2WCtfxfnRGCxGreLydWXedi3Vc=;
        b=W4Qk1exX76iZqx3l/U0VrFChNJC0cNwGPM7VV9Lo4G1hMEiIaBvQa9FMWJigTAQvCc
         hhluYM/nZ0+Ha+volTLs1akaIq5OlxX+t19Bwj7ktdRKv3DbFsYZNRPh5s+Cd5c1UVku
         wa93+9ifT/w9+8bgeieG5Xwcxkq9QjnpSzX+JPt9WOB/9/iQwVHYUReXKiOA67qThaKr
         Nfn/rN2RvfI5ad9fZgQvsSE3a20Z/NuwtJXVOQQGnB62oEpt+wqWjCYWlrckf9mEOFkQ
         qTTI12K7rSiEIOu+Ehhe56Dw7RsxQn5nmGW489y7xXawR7+WOCvvERQY/hpAZY9Z9n/I
         nbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742559024; x=1743163824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RzX66093NdWDWJT+/2WCtfxfnRGCxGreLydWXedi3Vc=;
        b=Bt2lHRvTHHsdpRf7YrH5XNbMVOuIHiUEOSWWzbWlJD8Bajwbip15IZrp60Gafd1hPC
         30i3H8HWAioiewrOFkrJ/P4Yj1cPzeNYTgoqpmJG+LbD9HGFVD3QJS5s0So+KEGUOw88
         b7wEpGdkqsmHRdq3oAW8UTZXFFhw30vKEnL05+OyGcBqrodGwqzip+e9cXmeWXaZ5rZS
         QQbud7SijOMTKrUC4Msc5RwpP0kSS5RoXjRbjiv9Vj2rQsqvfdM1rxa6/Mpar0Gu9vWa
         S2gEvBEX6oXcRB0WHq0XYQ9wQWumb0sMQTAnz6vbDTpIqXbuqHiy72ScPTJcAhwOR0zt
         o9gg==
X-Forwarded-Encrypted: i=1; AJvYcCVsrB/ACugWKAuj75jRWLBnzC+Vh65IAOT4RFL0isGbzlw9vvHzkozuurzJXmovRmqUnGB1aJPHJHtOeJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDR/DvsC4M3olKTavIlmjHYUKcSiQJCzhWvYdp6+JbvVLhE+06
	w1up7NUZPMDUXCEkFIv8kIgZdsc2CzgGUyCe7iehZOKFUJyEYFGPdDA53KD3vdlBVtLFUBAXsDA
	+E7wNXbRTRW0rgg==
X-Google-Smtp-Source: AGHT+IErPZK/k8We6HLKh56+Dy5TRrufv83EZvupyE3hnbr/ycIpO069ol3CrSRNZZquyh8P4yiRGfehrBSyACo=
X-Received: from wmgg14.prod.google.com ([2002:a05:600d:e:b0:43c:f7c3:c16e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83c7:b0:43c:fc0c:7f33 with SMTP id 5b1f17b1804b1-43d509e4a78mr30493065e9.2.1742559024697;
 Fri, 21 Mar 2025 05:10:24 -0700 (PDT)
Date: Fri, 21 Mar 2025 12:09:56 +0000
In-Reply-To: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1339; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=HshBdY9tyPHXYCABit0wg9iizu5qxvE0QHr6aVv8M2U=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBn3VcmiJ7Tf2GburnJFnABJO3jD7esdEjzlSvBZ
 Hhni4owZEmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ91XJgAKCRAEWL7uWMY5
 Ri9BD/42sQd6lHZxui9NajNxPApmfoRB/8zYhbcwQVPtfAsWTcoMGWW3iGfsywI7LDYSqEo04Xo
 qbDeXKQXhOvjfw9Z3c1Wr0ipLN1HI5ExTqApQo2NDFoM0sZqClerI7HVJ2F3H80edJDWfAaF58g
 az+XUfMlnM/SxX+c+sOi9ykJW/r3FIS7XkWu0Lqkmp/3FdKsLxa343rzKLLg4Iu3m0EePcFq+2F
 ZpV5S7sD9tz23uLT8sHnL2WaIjOAR4ONdi02ltvljwpJ8WNC+HEcgpjNuuQJGUj0DIxeJQnKnAh
 KD7GtyL0iUwK7RCJwh6+OvLoj3ae7pG6IO2tVdFyIc5ZuR65Ux0pNpK8cO+eKTjiwQfRvYiVRM+
 W3eISMpU3yzEkjzLfpj9g/T1hZHPRt/zAIQsNFIVNpC2OoQ19+lKMzI1YD+nfzBjSlTlcGt2nP5
 Gz/SRnnWr3hX1XVV+qJxTJ6PrAWBpmsvQFQyycjIBt15Ij4z0cJTN9NuTz0SD5wkm4R+T74kbl8
 w+i29+oEP5Q0SdaMXs0gZlFywFO6qB096bzWEkKnxBUT/dsiIoFs7KkZk9QEphskVQSPEv9i/2V
 /0wxJTpftfprvjS2e7Y5opkMj4hD8Zfs/aqPFl71lxlsFF6p98Gi/fj5OU0KCdgrhNhbAHwyq+5 6xWWR0dMZuvrOLQ==
X-Mailer: b4 0.14.2
Message-ID: <20250321-vec-methods-v2-1-6d9c8a4634cb@google.com>
Subject: [PATCH v2 1/7] rust: alloc: add Vec::clear
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Benno Lossin <benno.lossin@proton.me>, Tamir Duberstein <tamird@gmail.com>
Content-Type: text/plain; charset="utf-8"

Our custom Vec type is missing the stdlib method `clear`, thus add it.
It will be used in the miscdevice sample.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Tamir Duberstein <tamird@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/alloc/kvec.rs | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index eb6d40a1bf8ba45126bd47f1dd4a7b7ef86112c4..95e752ed27395fce72d372976b74fb1b0e957194 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -395,6 +395,26 @@ pub fn into_raw_parts(self) -> (*mut T, usize, usize) {
         (ptr, len, capacity)
     }
 
+    /// Clears the vector, removing all values.
+    ///
+    /// Note that this method has no effect on the allocated capacity
+    /// of the vector.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = kernel::kvec![1, 2, 3]?;
+    ///
+    /// v.clear();
+    ///
+    /// assert!(v.is_empty());
+    /// # Ok::<(), Error>(())
+    /// ```
+    #[inline]
+    pub fn clear(&mut self) {
+        self.truncate(0);
+    }
+
     /// Ensures that the capacity exceeds the length by at least `additional` elements.
     ///
     /// # Examples

-- 
2.49.0.395.g12beb8f557-goog


