Return-Path: <linux-kernel+bounces-556294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEDBA5C3C2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6FA3B4C16
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F89925BAC0;
	Tue, 11 Mar 2025 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VLM+zq1w"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F7625B67A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703161; cv=none; b=mFdlLbNzcFJ/2VG1s48+idL4Zl141VJD1VtQvwmkDgNho3vHHlRIg8rZKPzQ5pM0GXivh6IDUR1a5fIqrTRp3f++FHvnqhLSBkHgMsogy0LW7qFkKm9zOl+XzN0ComMTW6b4SNWz1jgAcN7MsdyAe/rZmK9oTAWTNx0TQu76Bp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703161; c=relaxed/simple;
	bh=79lDXHkxGXTpgvX4Tf1jMBZMfqeS438xlynxsP86f/o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pNLGdaEW2nUjjvrwbs+LaWRTVLQo7mR5fijvfPilT2Qrq3wKppBrYpAKaDO559SiqmI+z5+paHuyGTGttRHlUXYGOmtOYyzqGgBB65dKh/SrSSnwvitkM5iAvnqe0H9fVvt4gqnUk+llHZMrlaHoNxs3QTy8Fautc6Q/gtfW48E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VLM+zq1w; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43bd0586b86so39261375e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741703158; x=1742307958; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lC0i4WOQpGCKB2dNWp8ThzgBQKaOLrnFmghttL4ZvZA=;
        b=VLM+zq1w9fY9Q8yKHz64E+EzwNhtk8UbK4IB8gfz2QlQUecXxB3hDmO04AYLPG6X6D
         56fjwJSUX1Rr7zgy+Gma7xu/Q2CcJlTvOke3RzUhXKVEx+9Fh2ogpwF7PLVfmYAmr5pi
         Iby75AasR170e6ozuFM8YDAVipVoPJ5qs/nZFHUVWcFWTQUBXEXmoOccb83RY35cuUvO
         vLAnj9ST+/UJlbvagVzJaUUKnVK2uWFgVeLQt+p960qg2j/j26QKZl0pLPAYYNr78Zc7
         SK/czpG5abgceVIRfpYDnkp2rESu6BJ4enDR2GNCxGXvtf28ABFgpn3ivN9ctSqGHEXk
         fROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741703158; x=1742307958;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lC0i4WOQpGCKB2dNWp8ThzgBQKaOLrnFmghttL4ZvZA=;
        b=PqVI9rTFS3VyXl9FdFBfZO0GY838+q9ycj1WW7B61FqDj+YNjqWienxcHVKlBsFsNX
         mCucENc9RZris87o7vlLlnsIj1DFqlczgprJVERLIz/bH2x3oWSzB0MDRG58OjXzn9lC
         zOU9oV1NSxcqPh8mu77/xA+VaIrc4DPy2rkFAvonSnBgUr3FBBBla//bR/i4JjDLaHVu
         uyIpvRT/xaOr1UFTxbEDVz4Vj4dyFgoCCX1EzNhOnGBX4Se0EOtzbnKq66p++Kgx7wcZ
         1vpo3yaLXUB9hkxE1xTvuu9QWjA72Jq3n/nn1v4X4bifhuNSEKaZzjNgHhLKjrWI/QoP
         Qmxw==
X-Forwarded-Encrypted: i=1; AJvYcCUm5A0ivR4wMvqlppnol5d/jjDKQzIroQlwrcvSPzlC06qfE5KMD8ETSXxVQVxUkIBZIu1GSTOQ5uIX3FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcaXnPSMbOnYKFNpd6Ex5w9RxaweT+HtS2TD6Y7VwNejz1UBaW
	bMEy3yglYqUGjZp7giyxV1jhTyO6ft8jfhded/EiIeTwjRa7SyvyoejYgW+ogr+BC6y1CCt2u06
	wbRc+fhggrNEwJA==
X-Google-Smtp-Source: AGHT+IHObWBudLSNtdlwggAkdEg4nz/CJMyp8c7bGwJLWJCSzcPLWepW0RpiTZDtyFKNwXvPaWD7Vm2Q2jQ6++A=
X-Received: from wmbay27.prod.google.com ([2002:a05:600c:1e1b:b0:43c:f3b7:f2d7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3ba3:b0:43c:fb95:c76f with SMTP id 5b1f17b1804b1-43cfb95cc9emr61468885e9.9.1741703158566;
 Tue, 11 Mar 2025 07:25:58 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:25:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMhH0GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0ND3cz8Mt3MktQi3WRLC5PE1EQD8xRDCyWg8oKi1LTMCrBR0bG1tQB qct4gWgAAAA==
X-Change-Id: 20250311-iov-iter-c984aea07d18
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1483; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=79lDXHkxGXTpgvX4Tf1jMBZMfqeS438xlynxsP86f/o=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBn0EfYNTjv0Lr2ZQvM38OJGqhfN5FIbHP0QU5vk
 EqXglINxOSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ9BH2AAKCRAEWL7uWMY5
 Ri3fD/41qzMbjnvzYRw6OV1nkBbjtMG+HQfXOFQfyP1Q4ySyToRSBLHhcLoOncHjbtq5S0duK0N
 yvsfBV8yczH/k91FLBIgzOGExLQFcmWehkEP20nAdYMFBB/y4GiejjEW29F/FUTKej3krvtRSuR
 H4b3UNeS8cKKdN6mxZhA/qPk1V05MlV/GRR+w6TOnqo0Bbiry+NLTVArDunjrO1h9BrcKLj774D
 s+ZjP594sh7LF4NdAcNfvVXBR+EkKbql42EPrJakEAYT2mUE1UvMPPz/Nq0b0qXmBg2PsiWJbpx
 dbDhG+w6QFcPO4W0X6ravv9TGciUMSsb2Yh3vZTwvcfwT7gmetyqzQ0sNM9TY1LDptTmUHSxtqm
 2+/pbwPVR603mjxHyqH2UHCz6xhIF462KkEWDOOQeI2u3bCeQQJ3t+sR36unvlgv/Z9yNSOqqxN
 Ny2S+j65lyzKkmkHzT35tkuGlS2yokdpeAYzLQM2jnoCONTo8z4ikV+JdEhqPcYaKKLlaVfhb0Z
 ttqsYxFfv55EJvy6wCBN/OU7I5IzWt0vVN+eUGszlK1bxUbXM7NVB1cG7Q2upTu29bVgPCbZcYf
 l4ct+hmWWzOzLuaQy34xszPStgKAlniLBy43n84V5qKeptiYN/fj3XxZPuUZnt/GEwQQdEJn6it 8TqVbUcFgGDeCww==
X-Mailer: b4 0.14.2
Message-ID: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
Subject: [PATCH 0/5] Rust support for `struct iov_iter`
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This series adds support for the `struct iov_iter` type. This type
represents an IO buffer for reading or writing, and can be configured
for either direction of communication.

In Rust, we define separate types for reading and writing. This will
ensure that you cannot mix them up and e.g. call copy_from_iter in a
read_iter syscall.

To use the new abstractions, miscdevices are given new methods read_iter
and write_iter that can be used to implement the read/write syscalls on
a miscdevice. The miscdevice sample is updated to provide read/write
operations.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (4):
      rust: iov: add iov_iter abstractions for ITER_SOURCE
      rust: iov: add iov_iter abstractions for ITER_DEST
      rust: miscdevice: Provide additional abstractions for iov_iter and kiocb structures
      rust: alloc: add Vec::clear

Lee Jones (1):
      samples: rust_misc_device: Expand the sample to support read()ing from userspace

 rust/kernel/alloc/kvec.rs        |  27 ++++
 rust/kernel/iov.rs               | 308 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs               |   1 +
 rust/kernel/miscdevice.rs        |  97 +++++++++++-
 samples/rust/rust_misc_device.rs |  37 ++++-
 5 files changed, 467 insertions(+), 3 deletions(-)
---
base-commit: 046cc01be6b9d139b49dfc396b7201c633ff1a26
change-id: 20250311-iov-iter-c984aea07d18

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


