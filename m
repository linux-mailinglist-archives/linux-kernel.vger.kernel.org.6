Return-Path: <linux-kernel+bounces-318612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB83596F0B9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F41B1F25287
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D615A1C8FC3;
	Fri,  6 Sep 2024 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XDtgz1LS"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04D81C8FA4
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616762; cv=none; b=Zj66fTpxKYas6jGmBNORqqDKamObZvHghlHnC2bDjqG7Pnkt6Lw8va0lT0Kp36MTNukoVQr8iuLECAFg/zGM57DKIXJFEDnXboFTS36jpAElKoW2xEHCk+D8vil4coFXREmAYBhbpxZwvRlLJyxKF3w+naSBkR994w9Uibhus5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616762; c=relaxed/simple;
	bh=jfPauIgm35Mgr0/342bdH7eavZwk4IXdaSMhtaCsJYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rtveiuj9Uj6H6hFGJGVvqOvh277uWi1Z26B9J8Y9xz/0S40Y03SgvOFYQLHKU5gA4a7AP3UBVJM6SXCgavQVVSrxAWysSyQzDzwXKxPAUpzR6696E+Inl3fAxe8sUGzvOVimSMQ+hMg5dfHFZK1/BRklZZoB60k19bmZmSlWah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XDtgz1LS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42bbd0a40faso15685275e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 02:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725616759; x=1726221559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sDY2K/Ehe621MYsmv35PXlKGXJNhtkfCPhIF93OEdss=;
        b=XDtgz1LS0KQ2EGHgy9v7AC2pTk/xNULjmXaMtfYJQaQyCq1e5jy+o0XPVnEJ0QFjwu
         XFlTUb9gr8OJpSwiJqHmrDU1G/3uhNRkR1R93VOYDtwcNlqwRqqueJZDQ/FCVGQsK7Lz
         c/JoGL5J7gT4mkJYLU34MvEELCwebQNuMWcsdCAzO4ci0nb08XXUk+U+ZZpxl9bLdTAx
         PfK5wpltUYCOawoGq0ZpJsGCZvuplRDx+wsZQMN8QDASGtcfP88jjf2oSiDATPMNyWYu
         BIPNiKbO5FURV3Ji+cqcVYIwJcBV7EmJI3iXgXM8DgEJ59au+E4+DQR81ILDEWov0aOY
         8XbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725616759; x=1726221559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDY2K/Ehe621MYsmv35PXlKGXJNhtkfCPhIF93OEdss=;
        b=hcQjrG9kpVbmwOKCLZn/dBX/jfc0RLcZg+CW71ZV/JI34HoUhq7QFlLTX9Bw4SzyDs
         H+jpZFEnuZEBS8UxVaWFubxmJxLNAL1QwibOogJUbud1Hr8K3R04ZsGNpAoWhdFWqESb
         jnIOVVInutS+BuLQEMTfLZBNUw2hDcLytd8/wKgas+tI0j4kq94XSh6S3f/QbKTj42+o
         EzLRboBU5oYMXgZV3G6WIF3prJfu4UG6LdLGlggBxsaCZI/szhwnmUsT+X+N9J541uV7
         zQleh6ipaTnxPeFRt6nFLdvgVT5ZeffTkhuS6jRum8KNytca0NLACoY1vvqoPwWkaiJp
         BWvw==
X-Forwarded-Encrypted: i=1; AJvYcCUkMJTw1UE2ysixzYAEeQgXWlkKPxcQzmpOKjAgB9VLL/2R2ZP7Ef8YXSOicKP057UHHGEsjpoCbn8kTx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKhfDyrry+8VjNtDQ64eLSRKZRkhgWZ1HbggkfZaTS2ErHhaCD
	2tzlcmkm705IQMXiNXFM1+WvCgtWqXGlwvgOssDNnPGWW7at6tcIQH9u2aYO6Gg=
X-Google-Smtp-Source: AGHT+IFUSVHytMlXKw43UNEnH/AOn/39njfMRj1Kbl++ABSRTySQtSq9qLjUgj3T5mU+sYEN30n+4g==
X-Received: by 2002:a05:600c:3ba6:b0:428:e09d:3c with SMTP id 5b1f17b1804b1-42c9f9e19demr12634525e9.33.1725616758114;
        Fri, 06 Sep 2024 02:59:18 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b9fc:a1e7:588c:1e37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca743bc15sm3972665e9.46.2024.09.06.02.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:59:17 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio fixes for v6.11-rc7
Date: Fri,  6 Sep 2024 11:59:13 +0200
Message-ID: <20240906095913.15772-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following set of GPIO driver fixes for the next RC.

Thanks,
Bartosz

The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.11-rc7

for you to fetch changes up to a5135526426df5319d5f4bcd15ae57c45a97714b:

  gpio: modepin: Enable module autoloading (2024-09-02 15:00:53 +0200)

----------------------------------------------------------------
gpio fixes for v6.11-rc7

- fix an OF node reference leak in gpio-rockchip
- add the missing module device table to gpio-modepin

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      gpio: rockchip: fix OF node leak in probe()

Liao Chen (1):
      gpio: modepin: Enable module autoloading

 drivers/gpio/gpio-rockchip.c       | 1 +
 drivers/gpio/gpio-zynqmp-modepin.c | 1 +
 2 files changed, 2 insertions(+)

