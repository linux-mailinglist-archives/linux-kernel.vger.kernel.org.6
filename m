Return-Path: <linux-kernel+bounces-271545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5380944FC7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD311F23AC6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EB91B3F33;
	Thu,  1 Aug 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kh9OMtUl"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7291B3750
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722527944; cv=none; b=HdBdxIBNc0U/iaA8D1tqs6BzIy1yTawhd7qTMoN7t1cbFBJMkeGorBT1+tQIwEocMOEZb49YMnv+UbKXV5SMJN5RabrHjuPI8Ori9p2uhgsdNk21Fixd0Ld8SlYvA5dRKYoE1kPcE9cnzfhbYUmAlUZ5/1FpjDNXLOUF7XksY9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722527944; c=relaxed/simple;
	bh=d2mZwICmzJvJ27AAodhOr+Y46oxVhYb6IjBNY/il33w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lmyEVuW224yOscxv+qUWaaA/KEVzChv2/3AqHNq89ThdE/iZ3i4oShaoLm8c8R7hxR+U7RqOMv5lPJ+ItKJsWSEseodDVu7NQk75I9WgldraQO6X7UzFW5ebXkUPiEdjt++JjjQ2sngcxn8qtA+feWCe7WcA2wyzDzmqwNt9ZBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kh9OMtUl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428163f7635so46065765e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 08:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722527941; x=1723132741; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+3rIwWVAhs2koP2an/xHsymvvXy7TfdqmrnKYfzcl8Y=;
        b=kh9OMtUl7e8HCEfU3omQ7Ae+dyTSfle81rBBgiQlada2AuES99NaDbEmsXDRS1G1T0
         z+InZe0zBto4940Odd03l5NGqg5O7eCbRHu53unKCO8Q0IvTD3/Cwvp5B+MRvmjayC6b
         k8xiCOQxZ5Mt8FtkTGrzHrKh+FSjN8GhDpbMpNfe3qa4dlBu4h18d7ODMs8IubXaFMdt
         eFZtNgrV4bxZyrWx9TJZn2FcO7WX8Uvba1iyLIMrWbb+5x6MDgms3UCRXGspYJvKecJ5
         vcPG2jHMxtzWT02JyJXqgM7/izHxjnmJAEZahXLminpwWJXSsjAobrmaENHXFLDo7tJY
         8Kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722527941; x=1723132741;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3rIwWVAhs2koP2an/xHsymvvXy7TfdqmrnKYfzcl8Y=;
        b=A+h0xQXWkiScK0gikeaL8u2wtS/HSXMNvBXZROn6kIi0wP9aknlwvPsRQ+G2NCZGvM
         g1LHA7jMA5e+DRsuQRDcBbQsFd8YvQ8lrvMHsRIo9P8su4LyGQIv66NQM3R/LC8fBzml
         lsoQELslYHKSkz2rN8WK/aEhBV6fzkUmeHSPIgShpyjt7HBCsgYrLcgrBWAVhZbzGabJ
         5jdJv7hD4F6H57GDN8bqeYdluMKbet9FVQiDa3YVGikRDalnlkEB9m1uFXXkYDFRmVoE
         eTzaWJyNeSg/rv3dDhb91hhowxIWqavEW5nOM5MoSHrnA8WMzlrYypVZVjVD6AeGlQY5
         7Y0g==
X-Forwarded-Encrypted: i=1; AJvYcCU1RpL9RizNKMP8FXNua3vwoaTSsu5GcBiDqqsDuZAOLxg2VRUoL+ru14jZUOeht5o6GkBif+2zGWUlCBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdV2zZS2jCzM7fy/Z7yBpXDaUlBpo4EAxePeAZ6gNXmFI8U2dP
	9qHyAPfA6JQ+0gxqPXKoVEd9TeKw7zetYCFQ4o7eAXYeWHeg6NFSvydIKdErat8=
X-Google-Smtp-Source: AGHT+IH4tgCIfEdZkiFr6JleAf1nvfhYPgPK01aByUDT2feMP3Nt2UKEZB3IL9RrFWq181StA0w9Sw==
X-Received: by 2002:a05:600c:1c07:b0:427:985b:178b with SMTP id 5b1f17b1804b1-428e6b004d7mr2506445e9.16.1722527940444;
        Thu, 01 Aug 2024 08:59:00 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:9895:bf13:f4de:f316])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e7d615sm1393875e9.29.2024.08.01.08.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:59:00 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH RFC 0/2] clk: implement a new managed helper and add first
 user
Date: Thu, 01 Aug 2024 17:58:48 +0200
Message-Id: <20240801-clk-new-helper-v1-0-81e9338b7b17@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALiwq2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwND3eScbN281HLdjNScgtQiXXMLU+M0MzOj5JREQyWgpoKi1LTMCrC
 B0UpBbs5KsbW1AP6AyIhlAAAA
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=d2mZwICmzJvJ27AAodhOr+Y46oxVhYb6IjBNY/il33w=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmq7C/vBj7XtKuQEQYbVxysX004vasG0YO8jSAB
 IEd2/b16K2JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZquwvwAKCRARpy6gFHHX
 cr9ED/41WmuZz7C6HQJhhMnovalSKE6hBTmn9nmNMBhO8KHZncYov6N3on99SN5YcT13jXPe2Wl
 WlbJGHyWg1r+h592i3spmo96ooxRluXUU7Mxy9XZVoFlkn+bLwHZ4BNGFAZi02zJYyr/srxN7az
 Kt8sSMzJ1Q2FBbsHJ8PWh3fJ6ggrNcrMo1cdJibd5GMIwpKNjby613iy9DNkARs8Fug4iDAeDHA
 4i8p3u7xgJWF8MrvKjEgUqopJsX4SdJJIEB4kdPrAF14ynhnDD8cBZ+7Me+ktm2VdA9JWDRoMOZ
 OUxQcahYFrBDbhitcyalG7CFS3WxoTNDf+ehTsNEGJJpM7Q/wR0V/dDVeUAQE1yK4C5stkS+RLV
 vx40jkIvU099JNJz1NxH8pn4kb9VTmbVMidtIoUYVAe8QNpKqWcLX4XbuLf7ukDLoPYOrH+jxpw
 KRnasYwxinFGbvu5nA3+5DPtOSgpsqc0XV28Vb8eBwgERceCnnoNN66Gja54XdKQ79S3iem9XGY
 3AONf9NeVi7pBMFUxc3xcBSXJ4TqnHZqapfmVeKsi0rhQK/hMb0iSvYGBfU6F6qv0uV2wTf7Vsq
 /UfY11wvnhxf4P2Wz6HvPf9BgnBG0pi5FeXIaJawLIPloJgT4s1lR66owanRUYcr+U+R1BsoUED
 8AvGnTyX8FiPGSw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

I'm posting this as RFC to see if there's any interest. I noticed that
some drivers do: clk_get() -> clk_set_rate() -> clk_prepare_enable(). I
was wondering if it's worth factoring this out into dedicated helpers.

This series adds a new such helper for the "optional-enabled" use-case
and the first user. Let me know if this makes sense.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (2):
      clk: provide devm_clk_get_optional_enabled_with_rate()
      Bluetooth: hci_qca: use devm_clk_get_optional_enabled_with_rate()

 drivers/bluetooth/hci_qca.c | 24 ++----------------------
 drivers/clk/clk-devres.c    | 28 ++++++++++++++++++++++++++++
 include/linux/clk.h         | 26 ++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 22 deletions(-)
---
base-commit: 048d8cb65cde9fe7534eb4440bcfddcf406bb49c
change-id: 20240801-clk-new-helper-7853f662cda1

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


