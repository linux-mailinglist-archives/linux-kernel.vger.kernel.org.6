Return-Path: <linux-kernel+bounces-533503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08718A45B65
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6093188D2AE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CF42459D4;
	Wed, 26 Feb 2025 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XgqEY3wr"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE052459C0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564758; cv=none; b=MZu8PdDZs9CPHgOGcE+yXvGLATFAsDc9icjDh7eewUHyLiD6jItEx2OK18qU8BjUcIDZGm0VYjRr+hKuRTfYqzEmheUhOQZnvy5fORVIFsapgTHyO613Xh2Uysl/0yhKM0PcFCpmdMdwoG+NrrR2ZhGlMjcF3Jcc2XYlk9rjHzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564758; c=relaxed/simple;
	bh=VxKpfliG9vLDZJxpO/sed0hj5Bn5EAr6JHwX003RlX8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WSfXsMtOLnyGmHStcJKXtyTxtCy6AbQuYGwLqv5AZVd0D8C1gOe4kYWIgARB7PYcmXJIgqctjXSF9xe9t6mbZfk11GwgzDTqOJhAnt8SoO/9Gdt0XqLSaK2UBiNmQGcQukn7eUzJj/xhubG538rUpsn9Z9SCawKCsfkGoi6g2t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XgqEY3wr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43690d4605dso41556275e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740564755; x=1741169555; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KIB2ha813d36LF5F7eRTUAAyixj9sbfb77BwfH3ridc=;
        b=XgqEY3wryXRS5JSodHiGfqK0QtrmLJVLZ+hKmzWwXFk+xjN+QEM6IVCV0FFS0Ej4x5
         0wO4GFWWI5JaDiqbFHETljLwz2RvK28bHSu18qsqG+29ZBRhIfvZevprbkmmeLToWYUS
         R3Q/dw4rX06FLJ3s8df4rpkxXWITgvkWwZ6mKyf2TOs4j+PvvhPjtz0EMpIkxOyyp0Fo
         qERxlWGnj0h13pd+UJWj8yDg9lqHURpsNs+zz5ga36fDUHY3TCMy/QIWmx3p93KHk5tP
         BlX2C8yF5f7vHwBrgsWTKnZoYFkSk7EmP7BIicWKyWpwpAeDaa0NgSHf1HQvutk0nUxz
         KsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740564755; x=1741169555;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIB2ha813d36LF5F7eRTUAAyixj9sbfb77BwfH3ridc=;
        b=QosQXgjmyBBb19Hx4fvjCSydt8u5kBEk6tEtA+62wJaVfwciz8X114IoQSK6K/GkJj
         xlo1yzbjdrjTPVz3RYbOQ8a3+qz1E0WsMLevAz+lUdr8UJAcAB01AFDWqrzU4LN+QGPB
         GohRdSSl9R998RcnEUNSNzWPfFJz3jNvyCcMmofwPm5EmU04lDP/TeAoHPvyXVmF3dl0
         INZ6XC3pw94uwq2sA0NM2bmd9PvZoBg3m15UF0IPYX5u2ieRvivY/IcmfCMaw4EyGEGe
         ewDArzru39vCgEuGMMi2AWc0ClRP4lRAW7RdVhFZ4UwbLmR0mL82kNPFe0N76Rovb8f3
         417g==
X-Forwarded-Encrypted: i=1; AJvYcCV/jpNv0M1YYbO0q9xhSg89hEv06NGgj01LJ74AYP8M+h2eNSpcPCmyy9jFV/WGjnWnktqToVvPuGYUlhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhhlPN/S1feNVnX/P7NIGFcUeTZsnu3gKhjhUA6bWDxC9ZlY7X
	ez37F/2U2+id4WZAREJ50CcGGGJiyM8bvz9jRd4dehDojMN9qVaj7H7tMt+AsgVjS/ZlpX8mMXN
	srgA=
X-Gm-Gg: ASbGncso+G671IXmC0ejFRiORiFTWcxuR3epU7q724QxTyWHhPM0E0Tzx/7h2f3hUiJ
	fzjC6jOCN4nqXN+mEhfE90sYvT5MsCypKiIyIVpY0FKyNtqaP0oOlOp6RVeiZuhGFotHO8Pg3uZ
	K01F2liMWhsXBKA6CrHeGeA7qtAyueL/v+LgpWYEmPSShKZMnL2joI8dcVDQliKBNcSMTnDaguP
	qm7RxucE9OAhv5INf1TD2u8QguMGkqm4hmLMMldMHbBSqWFiXdzpj3LR8vpuO0fXn13VEFlpScM
	Y9L0qUYlbKhIwvoa
X-Google-Smtp-Source: AGHT+IHFyeBiXdbYsbZ7/FlJ8q8tqZhxlyBL4+swbA8trmwvM3grI2Jm5FnG3kWSEVA0xFqgFJIBvw==
X-Received: by 2002:adf:ffc8:0:b0:38f:4d91:c123 with SMTP id ffacd0b85a97d-390cc60cf53mr4259931f8f.32.1740564754802;
        Wed, 26 Feb 2025 02:12:34 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:7d02:26:5770:658c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390d649cd17sm1483971f8f.79.2025.02.26.02.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 02:12:34 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 0/3] gpiolib: fix bugs in retval sanitization
Date: Wed, 26 Feb 2025 11:12:28 +0100
Message-Id: <20250226-retval-fixes-v2-0-c8dc57182441@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA3pvmcC/3WMQQrCMBBFr1JmbSSJhqaueg/pYohjO1ASmZSgl
 Nzd2L3L9z/v7ZBJmDLcuh2ECmdOsYE9dRAWjDMpfjQGq63T1joltBVc1ZPflBUa1AMauqD20JS
 X0HE04z41XjhvST5HvZjf+idUjNJK9z5cw+Cd6XFcOaKkc5IZplrrF4dZVrKpAAAA
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=945;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=VxKpfliG9vLDZJxpO/sed0hj5Bn5EAr6JHwX003RlX8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnvukQ82tgd7xM5Fo6Wlv7G2NOI6bghCS23K8E4
 wavNKKLPouJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ77pEAAKCRARpy6gFHHX
 cttRD/4oEnxssYx/uLckWtzsG97i+z9axzsrNrWYVJIt8saFL1oQL7BQkoMq9uZd1LLskU/wnv1
 O+7x4LKjSr6DfPkCl2BX/XIyRj/CYzk1Tqte2hxfJFbZ2z84W7HLApvzJepindMzPYuSHDZK2v+
 mqKXFKPpuyyRsxI3KKgDp+VyHoySMP3zSRSCQs3zwmOf5QcbLQWsGfUhcZ05CAIZHdIjIvLOTAh
 tI5n7v31ITSGhs760J5/xJOEvY63SegLCnowxp8S0rIACOxXgZkYaWmP/HIhoZKvH3z86c8jUVt
 C2wJxANbFYhFmhpIWTdctttpwDYGqScYt+OO0Yx3y0cTxrCrt8zTYg+7/qogXu7z1H3DrzcsQn8
 X+0Tp6aEHMl9BoDgEhnrRyAMdvTmPjJ3qTKBqUHwy4E5+ZLB3jXeG9geBGyQo4KYYYNx7KzjoTH
 mzfQAqxPz0/hqjoxPKQ0nXggjQFENvUuD9p3ueUzob9dSvyDuv+FEKQOnD/2xdNoQaJ+ONXN7Vv
 An7yzEpbqCKMe7wtNCGDc6/nph4Gdp98N116OSSV5w6f3+qG2yqOya+F8Lt8/lJMdGgqCyVTyW8
 LdEuclO1TBbGyNNw9PYaJziGOfJs4UM5GiYCHkHhrqJUqZzG2gn83/AcTMNYDO1sSGsVXYdDyfZ
 kOrcam0BxtF9XKg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Here's a set of fixes to issues spotted in next after queuing the series
adding return value sanitization to GPIO core.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v2:
- add a comment to patch 1/3
- rework the retval logic even more in patch 2/3
- Link to v1: https://lore.kernel.org/r/20250225-retval-fixes-v1-0-078c4c98517a@linaro.org

---
Bartosz Golaszewski (3):
      gpiolib: don't use gpiochip_get_direction() when registering a chip
      gpiolib: use a more explicit retval logic in gpiochip_get_direction()
      gpiolib: don't double-check the gc->get callback's existence

 drivers/gpio/gpiolib.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)
---
base-commit: 0226d0ce98a477937ed295fb7df4cc30b46fc304
change-id: 20250225-retval-fixes-a1a09a1e3a08

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


