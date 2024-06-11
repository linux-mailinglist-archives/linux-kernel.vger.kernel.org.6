Return-Path: <linux-kernel+bounces-210598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3FF904606
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245341C21D68
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485C41527B6;
	Tue, 11 Jun 2024 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PTShDb9P"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BF714D2BF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718139574; cv=none; b=dFVQ2d4h+TWBwKOWnLLqpxbAsju8PJqmjuDQWVSjaH1XBvb0bYLXakdEJNs6xrhONjrlyiK5SSIz9u2AM0Kx3/QVIKmhNSPUeWMO3SyLg7dBGoVKULdDocvluEBQ7w9nqa86izjaALx+9sz2dyrX+L+Jug9CKoeQ9U4+g69IZ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718139574; c=relaxed/simple;
	bh=uPloNiuzxNq5YdU4bbihSB3VIjXRMwp5XwDqgZUS3LM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ceeogx+VfGxLDffMGEJBRSIO29WgbvvRLg7+V1PO/jxJXTD5fRjNJLxYA3VMG6x7ON6KRc2ioJ/O+iYHTPu4ckC3bQd2NQgIVDCXYScacbhldq0+3ocSUTl24f/29hBLVpqcifFDKYmffqmsPdey9rOppQiJeA5EFgvw46iD9tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PTShDb9P; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso78627501fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718139568; x=1718744368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=axkxnr9QwmTcLxLgYqkLrzWvsCW3lX313RLwHm4iieE=;
        b=PTShDb9PqQ61h1jBZAD9bwKpmAnmyOfzDYNHrPr4qmzAWvtPeRyHCJYYdNXCLSytHx
         YWqdiudGg3AVOnQElV0uh6fV6iyBcrG4UtP0MawcYCbdjjvbX8ZAceci2u/FYCIVDL7q
         VgQNWQGbWP/dvFeisEvRsovz5Zd+JsMixBQYeBJEm/6vEitlsWGHHk+u8yB9OKC3N2jn
         jBtZ09uusYn78KixtQHFD34M0j+0xgClXv9/l/PbUn8e8nfabycXpPkxTJLo4XDLyHEo
         KBdeD5OjnYcX8lF4VclkLqIYaM4Jdqen3AzEukrz2iDB8g6Dd7AKpCIEYJDlcehidV+Y
         +AgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718139568; x=1718744368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axkxnr9QwmTcLxLgYqkLrzWvsCW3lX313RLwHm4iieE=;
        b=Hvz6fv8e51oa4UesncNX1J6BOwFjwnDk4sFYBGv3Vn7sXctKW+kpOasBV01ggQBg6z
         y9mruHjfIcBxH+a1vEbiqwUmpMDdKbIC4ZNIMj7zHV9TfJbi6gr9M2QcCCbmEgcSoddo
         dgpPwkLLs8Rc3L30bBy0/6vjYQwu7VHKkQOLjPIXVwcJZuwNKCWP6YakBmVtdh6WGKnA
         sfYMeKcIXUg98a68Lp/Cb09bi/NijcGpQmImmFq81Ax03y8TQy/D7yE3q8xq/OuWct2w
         mY3Q3BgPjPJPRLKK9GbihlafHp3ylJ1IzihO9VvEj3auVzQdzkdise7b0ytHeUb51LfV
         BWyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmzoSKATj1rNwwH7wH3VDclUW1LZXIOMtr3FHyTczLX7gnN2LDJ2MV+IZDZhdRPb646xEXmvu9PNqWecUGBfKyM9MaLwNTGlD5yopk
X-Gm-Message-State: AOJu0YwAwYGU2jvOzawN/s0+F8Ybos+BkXYnvtPE1u27oO0jVYs1NES+
	URziMluTwUwdu5JSMPA93jlS2bJoJFlCHGVNi3lvkM03vIAr7y4Y568P7hVqDeg=
X-Google-Smtp-Source: AGHT+IHXwlMipg5Zu4b5gbGo/Vp+PbC8BDeqNBBlaaCwUQT+jgYEQ/TSqDOHiMLb029imXgLMihuVA==
X-Received: by 2002:a2e:b894:0:b0:2eb:eb7c:ec17 with SMTP id 38308e7fff4ca-2ebeb7cef92mr45433261fa.4.1718139568318;
        Tue, 11 Jun 2024 13:59:28 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c6aa014c1sm6868604a12.41.2024.06.11.13.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 13:59:27 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH] modpost: Enable section warning from *driver to .exit.text
Date: Tue, 11 Jun 2024 22:59:00 +0200
Message-ID: <20240611205900.2145880-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2023; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=uPloNiuzxNq5YdU4bbihSB3VIjXRMwp5XwDqgZUS3LM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmaLqUjpGQVd1pbBw5rQONgHVu+IBd7NJY6rqZj ku+y/8TiO+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmi6lAAKCRCPgPtYfRL+ TpocCACZYUfugKVH+wz4b790vjb8CrTwyyGN5aBG1sIwU5rPn2b2Hh8ySISRD1cBkNg3cRlfH2c SZhYvPTN3oqgEWXP1KyUZ0f7s+AsWTpHMii/hU7E6BhccWDgjKlt3o67lw/nx19ql7qUbNMzSyF z3s1wcqGvwwwYk7MnSGL7v5nDj+Nd07V0NeDh+iMv4D9qrBhVP/V2ARPhPdX27AH63Pc6+UY+aK kubfgsNdf7LzwjsgdxgmxaM2kwkyqpxHNmeTWWrYNlHUYrZA0Yq2uWaUJPgV+x/5Hn+AYJj6z/B L1aAKQDU/bWULwU1fVfLwbXuLry/fOtbVBFEflVVl5AaNrkg
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

There used to be several offenders, but now that for all of them patches
were sent and most of them were applied, enable the warning also for
builds without W=1.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

as of v6.10-rc2 there are two known offenders:

 - drivers/virt/coco/sev-guest/sev-guest.c
   patch submitted in March, available at
   https://lore.kernel.org/all/4a81b0e87728a58904283e2d1f18f73abc69c2a1.1711748999.git.u.kleine-koenig@pengutronix.de

 - drivers/parport/parport_amiga.c
   fixed in next (commit 73fedc31fed3 ("parport: amiga: Mark driver
   struct with __refdata to prevent section mismatch"))

I tested this patch using allmodconfig builds for arm64, riscv, s390 and
x86_64 which didn't expose further drivers with this problem.

In my eyes this is good enough to enable the warning for all builds (and
not only with W=1).

Best regards
Uwe

 scripts/mod/modpost.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 937294ff164f..30881d94f00e 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -965,17 +965,6 @@ static int secref_whitelist(const char *fromsec, const char *fromsym,
 	    match(fromsym, PATTERNS("*_ops", "*_probe", "*_console")))
 		return 0;
 
-	/*
-	 * symbols in data sections must not refer to .exit.*, but there are
-	 * quite a few offenders, so hide these unless for W=1 builds until
-	 * these are fixed.
-	 */
-	if (!extra_warn &&
-	    match(fromsec, PATTERNS(DATA_SECTIONS)) &&
-	    match(tosec, PATTERNS(ALL_EXIT_SECTIONS)) &&
-	    match(fromsym, PATTERNS("*driver")))
-		return 0;
-
 	/* Check for pattern 3 */
 	if (strstarts(fromsec, ".head.text") &&
 	    match(tosec, PATTERNS(ALL_INIT_SECTIONS)))

base-commit: c3f38fa61af77b49866b006939479069cd451173
prerequisite-patch-id: 7300dede00db637042647e12d558fe1dd57c20cc
prerequisite-patch-id: 82cfe8597f709f05b9fbbd3e4eca8be35e077e2b
-- 
2.43.0


