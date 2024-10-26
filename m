Return-Path: <linux-kernel+bounces-383193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50599B1853
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18F60B22222
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DCF1D6DA4;
	Sat, 26 Oct 2024 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LgdARNLy"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7880C17C7C6
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729947521; cv=none; b=GHvnLGqyFpzj92jISP61yx2gDPlvuXt7/4R/4tPxU9n+KPdHqe2SoGnuuf0nIE6I0bAtI8G0AoyKeCKtmQ0qGiI7ZizRd63jSkaTiPNbREUQ7qugDsH3NaKOCJ7I4Fd9/PdjegG2fbXhgsD/oukKhyFI0/TBjqhLAhydYOK1Ee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729947521; c=relaxed/simple;
	bh=LN3ztd1AdBfZmL5Es/y83++2ekRYr42bJFDWQaySwmU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VInj411QJRy+SjAWEm7Z2TH+TALCVRFLgiycbH+/pWIGBfVxNpuOukeZkSR0m2P3qxFxIHXe54yD2PRqBu3DUBTFVAV/NasrqVQ8bXm0VAYeB37qI8Cgvj5Tfxd2JPURWqMjtZTWlATBVBUEDj9T7PWIgFk/C4G81GRCUCgAbKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LgdARNLy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43155afca99so26583265e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 05:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729947517; x=1730552317; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fV7GHtiMbguKbqgTn7VM6KISPuTz2G39nKTBY6jvHcA=;
        b=LgdARNLyKhgzLm4mH1suNE6VU6vetj/kj51KNcDxXXXs/XMuAxu/mf7QIHjhaCkNDB
         wU9Ca9uDys1DTko9RWCxRDTwBPKtfe/j1iBQlRvVKSVFtOcDx3C2kdqP8cGypIRjepCW
         vrs6yJGPS1h9TfIBG5Ixcza66HC4WHv6z/q300g1/LiIMFPBL3euh9ULPCjUV8glElug
         6u0L2+O4RLyuZLLPyy/IecarU8P1MjmgTKRfNeLNiWB1Xh2ErJXEUV6k+oZoFKjJXXAm
         txkpYjIpdQiA9Fm8nwzMfcyxY/zMZRjqk7ccSnSXjKehmyKHv6N0FmriCNj6+NgMcvFa
         C1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729947517; x=1730552317;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fV7GHtiMbguKbqgTn7VM6KISPuTz2G39nKTBY6jvHcA=;
        b=GRx65ok0GT8Ir+VDM2AuRPwrcNMGMsJk7o7LPySi7r63bw3lJ1UqLu7V/Rf+Za5CzU
         vDmsp17Cr8pz4aJ4wVQslM7oanvXiAvGoeKZtqXto99oqNsGq3sJHL9FYc1yHxCVSRuL
         NfABzv5PCqu+E5qE4lcO9uNbhFApi+vON1UEDrwT9J75VyhUVRz/F27l82nHbRkrbytU
         OMekk3JZWdXxIkaa/ULiwaxzwx622xgMankVA1ErEYJfcvLO3HE/qEjWBB06X6XUkHkn
         3vHpfdxJh4t0tw8TCdp5UL+8QiPTOnBJryfj0T/pb/mC1wo/YUMyXW2QnogZL1MWP9LD
         x96w==
X-Forwarded-Encrypted: i=1; AJvYcCVnUFcuzlRTr8tDmrqQHOqVzSej329JJCr1jj+AGVaAihv0kT1TWccM+2u3CqCc0qkdYnHNI3gFc3fWZlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZxa42ADZqQUBvc2r0dHLNFUKxvswUX+DmS5qmq9CwzhxR0woE
	zeJSKOToC1eY4ldmc6VnmLXxffINdAjpwTh80T815EbzGeXLUurNzQ/MdbOWTdM=
X-Google-Smtp-Source: AGHT+IFiz4g50uD4V/P8EpBdgSxIHN3P97CCyHae2ZCzG5QWxTHtDQqU019ZcLz9N4L/3LZYy5kD7A==
X-Received: by 2002:a05:600c:45c3:b0:431:55af:a220 with SMTP id 5b1f17b1804b1-4319a5bbffemr20887505e9.12.1729947516483;
        Sat, 26 Oct 2024 05:58:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:617b:5770:df34:27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935a3edasm47498535e9.22.2024.10.26.05.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 05:58:36 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 0/5] gpio: sysfs: send character device notifications
 for sysfs class events
Date: Sat, 26 Oct 2024 14:58:28 +0200
Message-Id: <20241026-gpio-notify-sysfs-v3-0-ad8f127d12f5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHTnHGcC/23NTQqDMBCG4auUrJuSH63aVe9RujBmogMlkYyEi
 nj3RqHQgsv3g3lmYQQRgdjttLAICQmDz6HPJ9YNre+Bo83NlFCFFErxfsTAfZjQzZxmcsS1sdY
 10HVt41i+GyM4fO/m45l7QJpCnPcXSW7rVysOtCS54E0tnaoqDVVd3l/o2xguIfZs45L6JcojQ
 mWiNFYaaYTRcP0j1nX9AOq4JA72AAAA
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1868;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=LN3ztd1AdBfZmL5Es/y83++2ekRYr42bJFDWQaySwmU=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnHOd5Nb2Tua7BbUnN339ltfzLoBCRAhEm0aUTJ
 XoWfWCCYNWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZxzneQAKCRARpy6gFHHX
 cl7aD/91DzZ9+M9BQxV3SJknF9bSeZuDhP7jhA4RvVZsHYbWT2Q+RChubU2L3UFWNFQ9XiqW97A
 TnDc2sudmZB4n+0GdMgIczyyz+0mViW4aqwZWGDJTWALcOUId5yhbyDe0Ks+Rv+kQGxFWtQY8/d
 7PuWzkPrU5EdfMDepuYNlUXhVUPHR2GIcI0z20HGllrEPEHTcCfXe8g2jfyK2AYmi7D6miwjVfz
 fa8qUvQ8Q1CoMog6hifWLtjrtpLy3crDbcvI1noHHhiEVNx+qNmDVjWXuYhABBt/wzUdJXlmjBR
 7ANLcB89RcIjMOIUlfuKhFEgiEvC3p8RLfMRIbLWQaTk1MkmyEIpNvglk87oZYFuGAqENstr6CV
 +kTgoW1sbPfbFdBWBnunTZnf1ZDDYVU9ep3Q4EV7qKKO2YzFPzEfHU9lFW4WLiA8d50U4KqbVW6
 y+3Ed6rKXshAmVnzDxarW6lYPmM70ZKTfsQZ6tHPgJMF8BulUpgjw2Bli7BIdhDodP9BnOZInHK
 2QkkSmHnNO+z0SHvj1nFbvBFrttDbeDtlghkUGTSeGAY5G8qCFBW9eAGXbfoM5hotZOBd5bJWH+
 XvPQuwq/5z4sbBNZTlfpVdiNTxHnCOEVTAZf8po73/TwpNvX8MARuZ9+kSEyETl10SDYSuTGQn+
 ca62xa9k1ZQGDEA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

This may be a total corner-case but for consistency and completeness I
think it makes sense to also send out line state change events on actions
triggered from the GPIO sysfs class.

The first two patches use cleanup helpers in sysfs code. The next three
change the code to emit notifications on line export (unexport is
already handled) and active_low & edge changes.

One last thing I considered was also notifying user-space whenever
gpiochip_un/lock_as_irq() is called but that doesn't make much sense as
it's largely independent from the GPIO core and can be called for both
requested and available lines whenever someone requests an interrupt
from a GPIO controller.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v3:
- Keep the unusual order of operations in value_store()
- Link to v2: https://lore.kernel.org/r/20241025-gpio-notify-sysfs-v2-0-5bd1b1b0b3e6@linaro.org

Changes in v2:
- Streamline the code even more by dropping unnecessary return code
  assignments
- use normal guards where scoped ones are overkill
- Link to v1: https://lore.kernel.org/r/20241024-gpio-notify-sysfs-v1-0-981f2773e785@linaro.org

---
Bartosz Golaszewski (5):
      gpio: sysfs: use cleanup guards for gpiod_data::mutex
      gpio: sysfs: use cleanup guards for the sysfs_lock mutex
      gpio: sysfs: emit chardev line-state events on GPIO export
      gpio: sysfs: emit chardev line-state events on active-low changes
      gpio: sysfs: emit chardev line-state events on edge store

 drivers/gpio/gpiolib-sysfs.c | 170 +++++++++++++++++++------------------------
 1 file changed, 76 insertions(+), 94 deletions(-)
---
base-commit: a39230ecf6b3057f5897bc4744a790070cfbe7a8
change-id: 20241022-gpio-notify-sysfs-3bddf9ecca9f

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


