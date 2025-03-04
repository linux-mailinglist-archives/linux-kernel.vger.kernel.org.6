Return-Path: <linux-kernel+bounces-544073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0894EA4DD14
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECA4189A613
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF699204874;
	Tue,  4 Mar 2025 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lh82+CRX"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295B20469B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089121; cv=none; b=oSXC97ER7Uk784yvpD8uL3/eCVt7rdfASsKdDM4heCY+vsv5n/Xu7JB6Hx3c39nHBc+7eViqmcHqjj+sRV461VevRALJ+0fIVKyW/kn82qYXBN55MP8rM4PNVde0a7EYYpilpmXv44vRIjVyzS6xHMaSUiQnuhBIsCYXEesiFYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089121; c=relaxed/simple;
	bh=pfYrJhYmXOmoMeg4sKWMdZszxN5nxDKSyeUBka7g/x0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k008qJoREx9RDTF0oIIH2qbbnMp70z9V8xudvOvGWPetAgpUTURQdQ1fsyG8fosxoiDE9lo+894UZWjKR1taAY6XU1EILHTHe4kTWpC4DWi0txAAAvEjTbYxP7B5xGkZzw8id48F5kpR+nXbDZpwZ8Rzcv6AIDGgo035n5XZdmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lh82+CRX; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ba50406fbso42499825e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741089118; x=1741693918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4xQ8U/jop7C2IhA5DV1Cut5nWSl9HZJMjEE/uQKJi8g=;
        b=Lh82+CRXuAlRGF1Pb+RacfGY0iY3pwpvDQtexxwmt8jcZWhr2D2Q4Glh7f4Br/ByqX
         NHFRSWogtA1amAr6ngosOMfB+CalIL+Zhjq2FTfLB5XnQe2PAtyxZcCDnMWYcnNfXybp
         4RY8aV6qRd/yTv6xfXB1Ny9PqOaTOPwdtsbIck8ef4sz2ha8yV1S9awHfJAzMM26nY0n
         1aYKxA7xiIM/H5lEI8r/FBIckw3e9T5WnxzJuL+1H+sVKW+QoFN+LQW53THgkv1nQQQl
         vf6L0vAUebsgx7uY53IAHOkFYirQieE2QDGZ+uWQzC0tPN/fEhVGNBdrUbHnMb8RGLbd
         8Z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089118; x=1741693918;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xQ8U/jop7C2IhA5DV1Cut5nWSl9HZJMjEE/uQKJi8g=;
        b=CjAe/7TEHZzTBdeJ35Uh3d+Ryof+3f0rgdX970OzBnOy9F3mCxJ77m/UN2+b0d+s6z
         Nb4MuxKJmUAEu0uGj3NwGXFCixvppfZkAFUOOIE5+kvXaJRGAU+RBvYkEzIP4IF9PY7P
         AS9lnImUSBF6WP07aN5xkssC9XMWWMoJjp+0jIkgaH8VlkDCnUSZSVsB7pmhJJtvAcTU
         SzqsP5Zm6cFun1epaWW9oLJ0YtxPf9yRs9iekneDQpAt439okSm6U0QlMgiAnMRh2YGD
         92vEqsgan9n/l99mAMkVLysb7+G7tjJM3FwMQ9c2qNS0qz2OhakiSjrEe9tibndjm0g/
         SLGw==
X-Forwarded-Encrypted: i=1; AJvYcCU96G3UbQAmkphMTd1/vsLXTgM5M6LPrDjdktSAqHzKvNmqSsy353tKVsASld4S6/IJWOUqWscP6HyQPy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOABey1rjpmfBEVyFNSqcWSXZX6/3QmhToaT1eTvlhbDqWWNgk
	DFhFhru58LRp4UCej52fGx5NfdVsJyYyIa2Y7WtfNAdSODxoly3pX8u0E3kjYaQ9F4tYBBi9zWC
	lCBXAyga55YW6Xw==
X-Google-Smtp-Source: AGHT+IG2AMKbWFBJdIDE/KQqr7FWEBjtkYhI8RMcgWJbZq3RCOLTY4UH5ylub+jcjaVg9xtq9tEKZxH8Zpsb0+c=
X-Received: from wmsp7.prod.google.com ([2002:a05:600c:1d87:b0:439:88bc:d27d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f88:b0:43b:cac6:afed with SMTP id 5b1f17b1804b1-43bcac6b01amr26242355e9.19.1741089118021;
 Tue, 04 Mar 2025 03:51:58 -0800 (PST)
Date: Tue, 04 Mar 2025 11:50:00 +0000
In-Reply-To: <20250304-vma-v15-0-5c641b31980a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304-vma-v15-0-5c641b31980a@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=pfYrJhYmXOmoMeg4sKWMdZszxN5nxDKSyeUBka7g/x0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnxulI1cTJusWcBTCMCV8E308MKzphWs+XSbM1l
 Hz1AqO5grqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8bpSAAKCRAEWL7uWMY5
 RkUdD/9S9VVPwCSO26UGmBZ/OmG3EriY6UTnIBpk5NPvullTUYJY3Zlp/66cdtLbu8WTJOZ9szF
 XQT5s3mUTicmHQZAlsZwsyVIplAmPfNn3p63oOfleS79W8OwjfHtXGNsWp8DHvBvdDvpf7/ukq7
 lzFLV2niaQGAoJiiANGIyc6RYiCKyVEOvgvmU+Okr1f0B3CPFhY1KdGGXWfVLuhl8jrC3JO1Ey4
 FXVkkDLN997uTyiju1T4tt553y3A3FQNf2lG7rOMTImAkyGMUFGYdKdieVySgTAUHKLgjhEihw0
 mIX5VTQeHPctQKzQNuKpdXYQzbmNz0iAg6QNRiuE66wdEavAlrlP8HwyfkfQUPcwHV3l2HDh7+G
 bV/mjic1RKMA0XRIlOhVixB1m3zhn+ESLpcKdYL21xZ+V9LsskTmDOldn9A2HgI+BmLgqUj2JO9
 k89eJj+FlozF6ZKeGtmz8Ho8oUGSiPX4zZP1lkSUKPC4qwLJtKRZXmE1mV8QV/ojeIgwh98PsgZ
 dieETycPZZZ1w3bBgEG27qWiL4XJjML5GSpcZX+jRI2k/fT/Ch6FGWmu1kezWeJpeQn9UV5OoFZ
 +C4B3gRwEl+V5T0OifW6SwxuruC2sQOzyMdFHkj0VehR1/uqazg/zwi7ucgp5iY12K6EDvBITxS Zm7tfasNdodcx5Q==
X-Mailer: b4 0.14.2
Message-ID: <20250304-vma-v15-9-5c641b31980a@google.com>
Subject: [PATCH v15 9/9] mm: rust: add MEMORY MANAGEMENT [RUST]
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@Oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

We have introduced Rust bindings for core mm abstractions as part of
this series, so add an entry in MAINTAINERS to be explicit about who
maintains this.

Patches are anticipated to be taken through the mm tree as usual with
other mm code.

Link: https://rust-for-linux.com/rust-kernel-policy#how-is-rust-introduced-in-a-subsystem
Link: https://lore.kernel.org/all/33e64b12-aa07-4e78-933a-b07c37ff1d84@lucifer.local/
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25c86f47353de25c88291cc7fd6c4e9bfb12d5c4..3f610b3ab66ed5e502261deb867099fec6e4ab17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15196,6 +15196,19 @@ F:	tools/mm/
 F:	tools/testing/selftests/mm/
 N:	include/linux/page[-_]*
 
+MEMORY MANAGEMENT [RUST]
+M:	Alice Ryhl <aliceryhl@google.com>
+R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
+R:	Liam R. Howlett <Liam.Howlett@oracle.com>
+L:	linux-mm@kvack.org
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+W:	http://www.linux-mm.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	rust/helpers/mm.c
+F:	rust/kernel/mm.rs
+F:	rust/kernel/mm/
+
 MEMORY MAPPING
 M:	Andrew Morton <akpm@linux-foundation.org>
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>

-- 
2.48.1.711.g2feabab25a-goog


