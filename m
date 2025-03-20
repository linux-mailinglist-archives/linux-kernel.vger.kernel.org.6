Return-Path: <linux-kernel+bounces-569801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0A7A6A7B6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15E83AFBA4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D150223330;
	Thu, 20 Mar 2025 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sKjKCnhy"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ED22222CF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478807; cv=none; b=msH2278qPQ1bTB7CPrMzrJ/C+QpTPtudBwYfm2ArpFmz0mx1AudUMW5kjdTunK3VmlSvcsa1YaNXUlp8HATU05kXp9WT79n8gQhw8a8osID1BB+odphZB8uOYEvXRwEg/2I5emmqBxnX7rBjFK0JvJ6O1J0LtKrht3+w1piBW1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478807; c=relaxed/simple;
	bh=J0uC3aDL3oLj6YZnD9xA76IjEfmuaz3e24F5seLBKfg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ElUUWPSpmNamvzPvxYp22i54c31m4DEuWXJzCGFnQCKoT3qCnOYqna3Qv755WTwUYecm3Te5b0t7405MhYgMK7+QxgO4iOio8/qtoyaR8rG6XVVZjI/VMk8r3EgRpadl33O5yXSAFb+LQbmGdXA+fM9Nn2xCtHnlRV068Ex3d4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sKjKCnhy; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d08915f61so5198965e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742478804; x=1743083604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kQtVj02TwiJWG/v1zh3yiQ3sv6heIvyrUqYF6Q0ROk0=;
        b=sKjKCnhy7XqMLb8z41h9M9Qt1UaB9w7HmgL47TOiQzDyS5y+MrufP6JbiZgFiYBlvB
         CdKQ6pCxERYlweaxH2iAqpmS/0KGq5b/DvVfIxxgfiAWVcEQsqtt0ygkCEAJ3XcCZv6a
         KTmRWH25lLLX6xXw7s6V8oQ3d9nXk2uAyeotqAcLsh/mgxtTyWviusRrgWLfAxocNOAj
         QASEy1zAah0XaxQb8TcoBpZkoQ4lgWV3VyXbS2mtLaAYt+fipuSZ/QIFP++hcteAjiMV
         7IBvyHORj5Gmksg39j/T8VIsmpnz0qPsnVpG9K3S7+f/fa+EvdaqEjn2TIRBCXiTxtU5
         vNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742478804; x=1743083604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQtVj02TwiJWG/v1zh3yiQ3sv6heIvyrUqYF6Q0ROk0=;
        b=k8RWcAD7RDmKet63UEtgHhNFJLi3JvLqsFXDf93CoTly5uFJTTzH7kT95YmZkzkL7I
         x6LL+QkagO57YsdvxhsMQO4CaxFqRJpC8zqnyt1CSUCMIvg97C3a3yUmMO/Zj8T0qGz2
         h1pv1n0rZak1NxHhnweAt/2ZVG4TcsYr0sRPG5dqJ8sja7OQqOx3gA3TA3b/mokXj0JF
         lykbhkSW7HTz+zo2zSDLZ+NgcqcbaBV6pNxtoGXxg3aadaM0SOBJqhY2hy1nfTTPVBkU
         zTWmSYlbzl//BjlZBAWF2ZIb9GiiwHn0lgmTjSfYxWdN8JCQZ0YS8nAwf6x4vBzEDmg/
         JPXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8DEbxwPslsQGERNujzx/uEih3+PDwAhj7ws6KxFvDOkSkDa//Ij04IDrL5DURulNyQYDffSRJHU3s3m8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUZC+R1a7GGP8PxUR8ZkvHqEWPyzGBubqH2OVhHwKmpdEyIqO+
	RnkHFVtWpntTbN1YzvVL2kfB2fBuLRluAO16xVV35/BbbhLUNLuF8mFggGUSOqiTUAR9pvFEGXV
	2aCzvX1ks/C40dw==
X-Google-Smtp-Source: AGHT+IFr3Jaj0KxKPJPv7ncKiiwCCnuUTmQHVT4JfL4+3EqeDzlnpXRpxUryKFoeIn/HAR32t8mMRrDNBJ3oHIk=
X-Received: from wmbay17.prod.google.com ([2002:a05:600c:1e11:b0:43b:c7e5:66e0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:648a:0:b0:391:487f:27e4 with SMTP id ffacd0b85a97d-399795addbcmr3428016f8f.27.1742478804116;
 Thu, 20 Mar 2025 06:53:24 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:52:56 +0000
In-Reply-To: <20250320-vec-methods-v1-0-7dff5cf25fe8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320-vec-methods-v1-0-7dff5cf25fe8@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=J0uC3aDL3oLj6YZnD9xA76IjEfmuaz3e24F5seLBKfg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBn3B3MjwY+fdJbvVjrUawAkOZzMIdMN+e8hxSVk
 TebQA0+IQCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ9wdzAAKCRAEWL7uWMY5
 RtSrD/4sBYp8utYA8ZOva763NUJsYY/WLMy59OqkHqFhV0FBql202y1DvBSZI0K0yBqq7zA4JlK
 8OHMKL0PhAnRvPzlVRDdH0HS6B5GzJDCdnITvE/P0V2HXtut5GQWxQHm6AkUv2Kyq3aEC0CZoSK
 05tBbHCsCfDtANwCjS39uuBIENsHAvFCrgyK32t/Ao4tZcQseyBAjTTkgEqE+CWIRkq0eCDm5qR
 TsVDL4WjDwrAXgaqZ4Cd9RzMKFgBhGnwpkNWi6V+c70++0dfzC/aos5McVCdX2F7csHRu9XzCHq
 6UyCeVQPvuyOEK5ZEM2HucjVStBS0BSyNMPm0bT2GBQ5E4Y7SMEzsFl12UIYjO/VySKEug5fno0
 yNi6NOkkyapNbuR3Gd8rjTOHz2qMIF0exSKcCruWVyDNj96YkI9cH8xl5KfWWxRCsRZ4g6SBrWa
 efVG2khzRkPEYqO6S6k/TzmVN5koopJ/guyvMLGzj+cMChhqJuKkgDAgCyO/Qf/XKBgHp+wFbPO
 HgVeullU+MoX8W2RG+YlKTUCZZ+ZwwlSvA+/FCHsOgl8u5PAr7F4pGMhXCHSSWgC0S2HlGdylGM
 fl+ePofFq3FicdePkeWL30j9Qp8OD3cuND0ffFIGLOkl97J3atWHiXrWMJkXNfMNYOEQW3q41VL iq7gfkf4AQT6jJg==
X-Mailer: b4 0.14.2
Message-ID: <20250320-vec-methods-v1-1-7dff5cf25fe8@google.com>
Subject: [PATCH 1/5] rust: alloc: add Vec::clear
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Our custom Vec type is missing the stdlib method `clear`, thus add it.
It will be used in the miscdevice sample.

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
2.49.0.rc1.451.g8f38331e32-goog


