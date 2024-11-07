Return-Path: <linux-kernel+bounces-399236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD99BFC61
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38681C21E50
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEA97E782;
	Thu,  7 Nov 2024 02:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaB5NgNn"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1547C74E09;
	Thu,  7 Nov 2024 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945359; cv=none; b=QpmffLOXi25YwyZCFOqQHQr6aiFTbLbNjo1K/WodvOhzgLMTtfQfKJiR5i9/+lPDHNXi/hWwN3mab9/H6D8UBdWLaaw3KZci1StWTK/v7ecZRFlI5uidKQUiwVkl2EuskmO4o1Z4fh36GI8jVFUNIfE4oAF/jHWo0g48JnDGXz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945359; c=relaxed/simple;
	bh=cYOpiQickTgC+Mplcot3xmEYlpUhGFzhNQSORbuD9Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mgb0nvjTz23b7gHRh0fsBKbYCXGDWcSH9ip2v9QUQcuOJMET2LNVBENA27QoMfgiWIrwB1O9aoIhjLpyLqXXI2K++VrOk8c19j+jISiZ7qfdklH5hqXuB3qzlwpkK7AZiUWURXBpxLYIz6ZbuLpi+dRTmtk7d7ZZW99FAPXqgJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaB5NgNn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e625b00bcso269407b3a.3;
        Wed, 06 Nov 2024 18:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730945357; x=1731550157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XJ6HmFVVf2xmJmPPwMaXX7al+Tj25yJ5hDxjBV8Tlw=;
        b=XaB5NgNnLE03p4gppoTkSAhPAwU4wT+CkwJjT+qpY1lZqGNaTxPiwSiqmRWAxf7Lpt
         OHzfcfdoe+UYnofXHw6yP5jX5j5pfnjAaQn+QB2ldlSjOYKM2p8GHwg3D5xMiF4sYeqe
         aR1E32hUxykWO2j38CId7uZSgSkZFE2dskPjXb80XCYiFnkHA3pEzQHNOGOowx3OlBls
         2LVyShKrpAZfcNNjCXUtGKO9tAgDwsvpIGbrzFNAYgarfpC3jpoLON553St8AosB+OC/
         D6ro+fECvkEc7RBm/LPAFu3gWpyHeFr0FsldZPWvtqfMA7D0pRCZu95i9pICEpcNGaXj
         Cn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945357; x=1731550157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XJ6HmFVVf2xmJmPPwMaXX7al+Tj25yJ5hDxjBV8Tlw=;
        b=gAL5utt0s+neEb1mw3k9UxTsiz1g2YtenvCJsn4idP3ocwHdSoYxE/x46XIqJ/m0Qu
         i1T4PuubSRo1DlXHPctAq0zsQZ7syrILagBGBvA5ZgLHN0pdYYo31M9VV8jod7p98L1v
         Umpkqv5W5Nb/mXR1JGJWZ8mUjCnV9u6KPoc59FB6SbiJSPBB8o5fyg4gGOtWnBYt2CWR
         YjieusobdULMpjlwOigAitVubUWaA/lhSrjCp66osTkqfAAHZ+yAPYXTgnMd2usU8VT8
         aPkmlptUZxUelZq6uKnlUj0xogyi+PJG3ocjlfQ4SapHaL8gK9ZBs2uWveSz28DUF4st
         sxQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM/0ONzGaRO2ENJq+7H67vfw7cQ0XYegbeuuNg6Lhf6Ag46VJQDY967Vs+ZFG2A9KAqF8bF9kz5V4bUwfWMug=@vger.kernel.org, AJvYcCVN58tDR8BFzbaZIIY7jPvmW9Hq54skw8OYkkvenGETu3D3lMmqKaFuBB9YVYWykXfvq5dbjw80FAFwzj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE/jEvq9cdok3R7erwXIX0Yex5MPcwED7Vj3hlzKtoo7BwvDeP
	j9WNQd1XF0DeQEWdh3brQs5k36+IkVmUVHCinLCA/w4E51W9b7+3
X-Google-Smtp-Source: AGHT+IG8DYPEyNFVaTuvEL6a2qxV0/VVZ2TCGsEQfMKevTpVFyfjmKFn0mwWwWUp0QInffG27sfgQw==
X-Received: by 2002:a05:6a20:d808:b0:1d9:76a3:634 with SMTP id adf61e73a8af0-1dc12964e98mr574349637.42.1730945357324;
        Wed, 06 Nov 2024 18:09:17 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f98b3sm2549916a91.32.2024.11.06.18.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 18:09:16 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	bjorn3_gh@protonmail.com,
	alistair.francis@wdc.com,
	me@kloenk.dev,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	boqun.feng@gmail.com,
	aliceryhl@google.com
Cc: alistair23@gmail.com
Subject: [PATCH 07/13] rust: helpers: Remove some page helpers
Date: Thu,  7 Nov 2024 12:08:25 +1000
Message-ID: <20241107020831.1561063-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107020831.1561063-1-alistair.francis@wdc.com>
References: <20241107020831.1561063-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helpers.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindgen_static_functions   | 2 ++
 rust/bindings/bindings_helper.h | 1 +
 rust/helpers/page.c             | 5 -----
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index b4032d277e722..ded5b816f3041 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -11,3 +11,5 @@
 --allowlist-function PTR_ERR
 
 --allowlist-function kunit_get_current_test
+
+--allowlist-function kmap_local_page
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ae82e9c941afa..084468123416e 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -13,6 +13,7 @@
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/firmware.h>
+#include <linux/highmem.h>
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
diff --git a/rust/helpers/page.c b/rust/helpers/page.c
index b3f2b8fbf87fc..52ebec9d71868 100644
--- a/rust/helpers/page.c
+++ b/rust/helpers/page.c
@@ -8,11 +8,6 @@ struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
 	return alloc_pages(gfp_mask, order);
 }
 
-void *rust_helper_kmap_local_page(struct page *page)
-{
-	return kmap_local_page(page);
-}
-
 void rust_helper_kunmap_local(const void *addr)
 {
 	kunmap_local(addr);
-- 
2.47.0


