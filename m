Return-Path: <linux-kernel+bounces-400958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4577F9C1471
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7501F23211
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356F2190486;
	Fri,  8 Nov 2024 03:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7yWMvbj"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367F12FB0A;
	Fri,  8 Nov 2024 03:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731035441; cv=none; b=cQZGNDv6zviiwADoCU2I5Hyf5y07w8VuQsD0Q2uJZWN1Qj2lsOznqBoSjhZPhfnVikQa+AF2rBkvRDvx1LDRkphrJ9NXBwtjudrPrWaAulsNiuutddyNd6pnkRVa/yn5WmnRRGmCZqfJnA0Eeoz7udVpobFldSk68t164QWHrYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731035441; c=relaxed/simple;
	bh=voURl+v4AufVsUEZnibjLaXGHqewNPS2mz4xrJ6/0Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+pcAxNYtN1Ux1PswFqeI6uzS7976bqSt33h+EiWSJLaLfq0cbpgzBacPP1ua9AMT8o60x2zEgYp908Iy3mdPZwMfnq4gI8DM7T69+ydAJvn5kitIxpJUunP5ct/QBOCStJrw5lJJ5yzGxsXZPJSbT6cZyvLY6IO80EQxfey+Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7yWMvbj; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so1404786b3a.3;
        Thu, 07 Nov 2024 19:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731035439; x=1731640239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1Xw5cwPrydNafUpiElmyYrhOsR7tL9HwNtv3+nykpc=;
        b=C7yWMvbjubzsaMb/sAX0R/EJ6zahkZjbxR7gBT6gA5b8q6zOJ0bex+wEQi99M3xxku
         0A7Guz1aI1RTqDBGhfBG4B4EJw7MWJuv2M5TvqJ47+lPPARqo35vDPxC3UAq81fTWjOS
         OSKT1TUWPfTyZwpDwWKh3xTlo0lYJL4n6wv+R9CRIeuCVnZyxuN8sUrm0hBmJTDchv3e
         B7VMX60TQocdOeOHTOqdID4j7P6763opB4he+s/uN76Fjnna3zPtItk65QCYiPt9xhzD
         Ppr9KTFWTk2FiuMu2Wxh1E3lrvPqFOf5UCt8oLzQ6b1NKThX6ZGi3VaLrQi7eoCU3lGY
         RNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731035439; x=1731640239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1Xw5cwPrydNafUpiElmyYrhOsR7tL9HwNtv3+nykpc=;
        b=oi+VaMzaI5Cu0j+ua3pahrx7swqchesMmi06c8XChVDuHeBFbj5OdcCKcj2f4jDX6Y
         CUByuNAAUd6cpYtt1aML7CvODoNl9a/R4flQa6nnANISePhP9Wws8GfWshR9KIHHb2Ed
         SfjpePV1S8rVnfrOhNtJMZHjljVtOv5uM/ZWXaLNsgydFWMMkiAt5bFu9ddJ8UKnU/oH
         VYHMVQJyJkcbuf6vG0+DjVhpG2zrLAqRVrySuNISBif1SpdKh9Nxf2wY+8n425D1U1sV
         XKV9cGhwJCHdt0vttU9IjHfO/X9fNlSY/ImxdJxGDsKRROPqR7eZGvhhy3XTdLs6p0az
         HCgA==
X-Forwarded-Encrypted: i=1; AJvYcCU38mn2dlRiaa7xHZHqz2bLx2Z+BcBIw+Pz/vI1ahoFWFYP/3nBqUwjX9XCFVD0Z6CGy5dKSqgdurTKW5d5WoQ=@vger.kernel.org, AJvYcCWjk8Gao1K/7gt7/Xta2Wku0xzBqMJXS1Cd3880i90b0gkI2ytWwmUe0piZ01kN2PcKOUQ82MHGV4YIoYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmX754lVuuRjdC4FEgaXuephhx+hs3APOS0FJR9RFBT0ELv3/A
	+gr9EQbA7fpxqw9T+UbFdT9aHsBKeHfLniVP2uWkJ/61YVC3hPyu
X-Google-Smtp-Source: AGHT+IFcqI+OHOaWqbMesiycnnQUvNi3qr0ecHFWhui8qlqALB8YErjjPpTNGyewx35c8aVwWCxsPw==
X-Received: by 2002:a05:6a00:1399:b0:71e:6743:7599 with SMTP id d2e1a72fcca58-7241329f565mr1831341b3a.7.1731035439138;
        Thu, 07 Nov 2024 19:10:39 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa86dsm2589816b3a.127.2024.11.07.19.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 19:10:38 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: a.hindborg@kernel.org,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	alistair.francis@wdc.com,
	rust-for-linux@vger.kernel.org,
	me@kloenk.dev,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	tmgross@umich.edu,
	linux-kernel@vger.kernel.org,
	alex.gaynor@gmail.com,
	ojeda@kernel.org,
	gary@garyguo.net
Cc: alistair23@gmail.com
Subject: [PATCH v2 03/11] rust: helpers: Remove err helper
Date: Fri,  8 Nov 2024 13:10:04 +1000
Message-ID: <20241108031012.335203-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108031012.335203-1-alistair.francis@wdc.com>
References: <20241108031012.335203-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helper.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindgen_static_functions |  4 ++++
 rust/helpers/err.c            | 18 ------------------
 rust/helpers/helpers.c        |  1 -
 3 files changed, 4 insertions(+), 19 deletions(-)
 delete mode 100644 rust/helpers/err.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 42e45ce34221..0269efa83c61 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -5,3 +5,7 @@
 
 --allowlist-function blk_mq_rq_to_pdu
 --allowlist-function blk_mq_rq_from_pdu
+
+--allowlist-function ERR_PTR
+--allowlist-function IS_ERR
+--allowlist-function PTR_ERR
diff --git a/rust/helpers/err.c b/rust/helpers/err.c
deleted file mode 100644
index 544c7cb86632..000000000000
--- a/rust/helpers/err.c
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/err.h>
-
-__force void *rust_helper_ERR_PTR(long err)
-{
-	return ERR_PTR(err);
-}
-
-bool rust_helper_IS_ERR(__force const void *ptr)
-{
-	return IS_ERR(ptr);
-}
-
-long rust_helper_PTR_ERR(__force const void *ptr)
-{
-	return PTR_ERR(ptr);
-}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 426b0d7f6587..e089ecdf091f 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -10,7 +10,6 @@
 #include "bug.c"
 #include "build_assert.c"
 #include "build_bug.c"
-#include "err.c"
 #include "kunit.c"
 #include "mutex.c"
 #include "page.c"
-- 
2.47.0


