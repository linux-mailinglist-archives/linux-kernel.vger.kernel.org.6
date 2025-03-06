Return-Path: <linux-kernel+bounces-549450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D2DA552C6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD7E77A327E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677E92116F2;
	Thu,  6 Mar 2025 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RAITNAsP"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B693A1DE4EC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281576; cv=none; b=TbRQTaQHpUCjC9XubD7Z1M5y6GI0a++SBBHiSmbfPAavKPnraUp2pdxebA4ctaYU03/2TR3N1H8QQWorZhF5KwKKr2hMPgQo9M3GRCG2rttdlcIs3FISrkDRH6f2gZEOI+UI53469DoAHz5/Jsay2K1+gyQtVh0n9KZ6I1Td7Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281576; c=relaxed/simple;
	bh=vK+5AeBaZnDdQ23qIss95u9Wtz0NcMLwIA36ctMYRjc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LWEJDIEVZTqCR70wvB3aTkyusq2p9lLWF/GwDfGyHBJkvZCt1yIy52CXGooFqnIg2oc1dYCgdn7PKYjU9FANlPrM9rx/d1v/HUg1nY/pjRe9dKkfwAe3MnFrB6XRYQ1oWaV7BRGKtVgvzLdAN7a2wGUnFRdQwlae0iLtoMV4KPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RAITNAsP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390d98ae34dso749350f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741281573; x=1741886373; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s25kzYytfxXR9pSgYBTx1nhtiAoOiQrPPxSqibwddWc=;
        b=RAITNAsPqVBJjtDqkPPsbXjtp+ZJhU/X3EpH+z4Czl/kpukJeGE+wua9iLm9RlXolb
         3MEENRxwBlk1gdg6iaGBQ/kD+CiVeMVeCXeaKmOzmoESsTIVpUnfbf8ISRMxSbJu6qs/
         3Bgvqsao1+Lmk+ORWOrN/ggGoQFEBFTLeoXUJPmOOLnK/0W1lnA368vB1Z5+2go+j6US
         pMFpZoFA94QgYe+Ff29GvmY4i6o7bDAzLjv6AhuzVidHC0cWireL7kEktiJrlGJtnmOl
         Z1iezHH+lmpBVs1vkCuZ6aG7cPPZc4oicpJEkOkg4vitoNXIqU9bYBppa3QZgDYBnKZU
         CJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741281573; x=1741886373;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s25kzYytfxXR9pSgYBTx1nhtiAoOiQrPPxSqibwddWc=;
        b=K2fql0hcAwEkBu86vKfBoM1SOeeQ8/rTp3ej6g4dDTyI6J0WnccSYT+ysn4BcrrsUN
         3WdJYp72LSZkThH4RSVrKUKZt+2HTOo28z/8p6BHFVx9KQ+WAErtJwbUnwJg6umR7VJO
         lBYO80CNQbkJo2tnsxPp3tfRbvEdccuhXm2SngfxJM5tK3GKyMq4lFNKHkv3DGch5Fwg
         8ncaT/bdeM9nLvjT6B1Yq9NnksqrkPczSTwF5m8smwWXLZlWe7zKjZklolsDzwtufdGU
         v0o8fq999Sb0yjYVjiXrQLlbUF3Of43gxNNLlM84XsrG65smdBTrpwnI+XncYAZBLRAz
         r/+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkJkCqauUnLx030Rh/A3dqpXI5CUi46hmzQjzwa1ASjbPISzpkDXXQHKOxvsit2d8dxG+rpJ+Pb7TvX/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YysgIG4HIeUxPb5tov6swvffMYyizfpl24mj/3vASsuyyQkKMkh
	CWNhl3bLzxff9OF8rY7NS0IsBMUIJmLz4EGhGgzyzDYQvbt5hspmMcB+nnF+3V8bhvmpxSzvEC6
	f
X-Gm-Gg: ASbGncuLukdxmNg6kgYzghjJmRuXL+R/FgdgfdKmFG1QnuZ5w3AOeAXqNh5/2qtclWq
	r5NJh/bk2cJywcKTHRFlgtCMZ4MzCBNI33JhuHdTSUKvuEYeQDdF7iIjcIBXUVb1pg5b6CtfBvw
	j4lixQcKvLz8iOnLZBdVXPwrLjnLvBVi9pdD9GrOXwbYlMtgMbMsmf2qANRnmrRmwaVM6CnYHmq
	OzWl0UWnpwMWIelvy6JUSmcq5V9lHkKJYUZM0QMu6eh8WuqKq9jZ8oCauCaqZhGoUsWz4yUZtm7
	A4LGX/xSvn0Ab7mke10gHIOFRojX7l0VlxPf
X-Google-Smtp-Source: AGHT+IFceWf4XUlh2+JMEehSRrh8c8UjCCcNzqqgkJfstjIdQWR01E3taQJhEZ2K/V5QkbLbeT5bUQ==
X-Received: by 2002:a05:6000:1a88:b0:391:2da8:6e26 with SMTP id ffacd0b85a97d-3912da8722bmr2487023f8f.52.1741281572826;
        Thu, 06 Mar 2025 09:19:32 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ce13:b3e4:d0d:c6a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd426c33asm57673915e9.3.2025.03.06.09.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 09:19:32 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 0/2] gpio: convert more drivers to using the new value
 setters
Date: Thu, 06 Mar 2025 18:19:25 +0100
Message-Id: <20250306-gpiochip-set-conversion-v2-0-a76e72e21425@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB3ZyWcC/4WNQQqDMBBFryKz7pSojdqueo/iwsRRB0oiEwktk
 rs3eoEu34f3/g6BhCnAo9hBKHJg7zJUlwLsMriZkMfMUKlKq1rVOK/s7cIrBtrQehdJDgfbupl
 Mo2/dvdWQ7VVo4s9ZfvWZFw6bl+95FMtj/d+MJSosR20tEZmpM883u0H81csMfUrpB/HiH/i/A
 AAA
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=vK+5AeBaZnDdQ23qIss95u9Wtz0NcMLwIA36ctMYRjc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnydkgmL9yX3Qcne5FZPyGCuWZGjdy9Mwv/Iko5
 yQS3HezxzmJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8nZIAAKCRARpy6gFHHX
 cj6tD/49LKbBzG1FOOlAEKjmVqwPPIyjHH+D+bazsJ1g2e1oe79EM71GhyBn+l91sbL7gJki8e0
 t5dss3vmE9QtinR5fIMGYVeytQazDf514D9UCDG0bfSX13LZuogdTpmudHbQkrm6/hNnTpmJPqR
 7ZqbO0lBQVoP6ETJNDsmFH7IQsmJZHk9l3Ti1gTngmfBbyWk5/UTEaXLuqii9Wf5vU+v8pgruwh
 ihEwaNWffHQF/AEMQUADjusuYtbJ6ZILFwQZFWhOnx82Mhp07BqtYzLJiIOf+ykrpinbsdMQS59
 XEMYYJaWeOjLCWfaR1/HT23b4e4A6G4VSUGE34pWpAjQGHOmh3pqm4DNycQ1mtKR8jJvimcAgZy
 Amc7nBDG0ZpAH10N7nTgzr6eytNoo0K9XZqugvqcMeGqv2Ksihk8AYRhsiHU5wnWpU4QitOMinQ
 /+Xvt+ot+B/TajSDs1DosBWZj+F93Ckj5857qg4SfD+C5F7TyRA54Gxty9Y/Ux2OLeegOgksQAC
 VfTUJdjgjGTdj4WjBcNTIl18XAwBLSNRRX+0kcIxh08XMGiwuG3ddVGGZd2GYfZhPcPxRurvEK5
 MwJjMBJxJbaF5VaEq+hYy7nSU82sRKVhnDwfqxw3o2epHyo0u00oNpDl3bHbYjxf73SiwGGWLCh
 CqT3MdnSygKEk7A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

I don't want to spam people's inboxes so I'm resending just the patches
that caused build warnings. The other ones will be picked up from v1.

New variants of set() and set_multiple() callbacks allow drivers to
indicate failures back to callers. Convert more GPIO drivers to using
them as the old ones are now deprecated.

This series also contains some additional refactoring to the affected
drivers wherever it makes the conversion easier.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v2:
- drop patches that don't trigger build bot warnings
- rework the gpio-adnp patch: we need to initialize variables modified
  within scoped_guard() as it's implemented using a for loop and
  triggers warnings due to the compiler thinking we're using variables
  that may be uninitialized
- Link to v1: https://lore.kernel.org/r/20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org

---
Bartosz Golaszewski (2):
      gpio: adnp: use lock guards for the I2C lock
      gpio: adnp: use new line value setter callbacks

 drivers/gpio/gpio-adnp.c | 134 +++++++++++++++++++----------------------------
 1 file changed, 55 insertions(+), 79 deletions(-)
---
base-commit: 7ec162622e66a4ff886f8f28712ea1b13069e1aa
change-id: 20250303-gpiochip-set-conversion-736fb6548975

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


