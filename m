Return-Path: <linux-kernel+bounces-208330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 059A890239B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D6E28CE16
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606D2139CE2;
	Mon, 10 Jun 2024 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="csi4S4rP"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31FE12E1F1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028359; cv=none; b=O98GGwk6gSzD3sxQ0RQAVoUhCCRk4djOEZIxLBHo+J+wDN5EdWwecOgr817oS/CGuVqZgSzT/7tO1/VpZM6yZdZd1QijELD2qeGSWH0ZpFsbKfONNgF9T483CBAZEg9+6iE5g7ZO8E0Gc8Xy9Acgqaj7yhB6+w0Ua4T14k3qfVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028359; c=relaxed/simple;
	bh=yr3jIRicmchwz3anKNej8jnzLR/OgSff3SwQWvHQmQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g9+WZJeuP0dNZS6UBe2i/NH2bpJJOCTx8ubZlBIGMK0vljZN47M1S33ww7btKVTsuwwfNKOrYU87x57TZUEtSld+cRNpreZjA1eqXK6o+N1nmKOTdDXV384LZNX4YZYm+Gs9oA+Fgq/YkvJP4eSPWVRTWEinsQsNZRmmygynjyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=csi4S4rP; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52c819f6146so2411310e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 07:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718028356; x=1718633156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VVxvwUJERs3T0J4gSW6t9kiiGJorZXzW48W5+k3rC2E=;
        b=csi4S4rPqK/PVbh1mL+SYyY3vrXOJLXJyUAko5Q40ZE/q797Fzw3qkpCWs45rXPIEa
         yFN+hY8LJl+2f+39MzeAA6mLFXA43/i7Ixy43q61b1knAaZLf+jbRu3QgmnSzytZC75U
         N3rMxRNGBUJZzQoOyCCChcLgkfibp2YFlcjDWQbaVk4OOuUz9Zsx0PRJo31AlXW0Al6h
         /rQL/cJP+EeeN3FMRIQaTG5N/GnK+I+D59lcVu3yoKTqTyp0X6rNx/BEbcaTrVQvRKpw
         13er4GKDzowmxJW90HKxzZVKdUllFwgowlqGnw17i56kbYn04AdJhCvSL9lIwKVavaV0
         S3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718028356; x=1718633156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVxvwUJERs3T0J4gSW6t9kiiGJorZXzW48W5+k3rC2E=;
        b=U32U3vzUo+RfVvyUXVyTFoqNr548r7E2afJZjkquMLJYxLHxvSlcOI2KeXGUWbsne0
         NaTrZ8Wsy+WnmjdRwr9s0k2byiH638dESi1qATrCuu7lwQHS5nwuA3RJknS6L/jUmNw8
         R1kiJOA3V4o5k3bXFpBcDt3vaQDFbKnzIV3K9vg10d1LLS6U3NXdq4Uz5DRHihhNCIgw
         AUyBDnuaQPiIt/0LYd3f0+tgep3fGmup2ZOEfMOHoNXIrqxGWca9cQvW02xZeC3TCVV1
         kupVOv/e4ObMOtIZc9QkstcQ2bDJhKGxzbG1NgRinR0vs3JwS5o22Z+uEnYXCLlgjE9C
         m2UA==
X-Forwarded-Encrypted: i=1; AJvYcCVNJiMNAfp4DPirYBHw9++9ijttcom5vo8I32CEu5NwXbUcZ7wHKQQx5zEfOTZiRpXEi/oyvXiCxIg3ZjPA7NmQlZdDNR6CLIGFPJXr
X-Gm-Message-State: AOJu0YxBy6AlPEO6uyqknmdE45tS2VXFfAFiWoDLiER+PUPhEi+DzcOP
	p7noQhdtCwKL0uPVwDChTV+9rO4iN3/e+/xpUY5oc1wMtj1tVFkW9dbKfYqt7T8=
X-Google-Smtp-Source: AGHT+IGVo21ZRRBzKH4LlG9aONaYeAa+lIIRzKsOCoWCppugjCXj9j36EmeUQnmpOThnit21MSrWQA==
X-Received: by 2002:ac2:5148:0:b0:52c:5f12:5313 with SMTP id 2adb3069b0e04-52c5f1255d3mr3906233e87.18.1718028356003;
        Mon, 10 Jun 2024 07:05:56 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:b790:b49b:9038:8e99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42217ff4302sm11113845e9.31.2024.06.10.07.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 07:05:55 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 0/3] gpio: sim: driver improvements
Date: Mon, 10 Jun 2024 16:05:45 +0200
Message-ID: <20240610140548.35358-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Andy had some suggestions in his review of the gpio-virtuser that also
apply to gpio-sim so let's use them.

Bartosz Golaszewski (3):
  gpio: sim: use device_match_name() instead of strcmp(dev_name(...
  gpio: sim: drop kernel.h include
  gpio: sim: use devm_mutex_init()

 drivers/gpio/gpio-sim.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

-- 
2.40.1


