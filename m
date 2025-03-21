Return-Path: <linux-kernel+bounces-571546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535F5A6BEAF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBAB9482A39
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6961F12F8;
	Fri, 21 Mar 2025 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NF+vJLTI"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A5D78F51
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572190; cv=none; b=OaLXZ+FGEAb4NbF7XuD+BqSakLxslHq9LPfKKRJHOBuGWBo4cH94BOP3FAZY+pCMiou6MKY1JRk6nyiWTtmFVJ40D+yOY3I3n4gEr8nFPIQ4QYsyiqMdc207G/ceBO+ADRwGXtDS/gwbu9wOHxYNltJjzMnoGkxzcY/mG07lC7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572190; c=relaxed/simple;
	bh=HR4MOYYeEi4/YtAUlDN+xlXtMWKtoiz1VBuYe7LhgoE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bwNes2MVePFUzHPAIQlfpE3Ash34wm1ZAeJJXt8XREVzQ/DiERh3yPThTHHGu6aaA8AwxQ/RDH9A4CusAJC5KTodaTeWXw6DUHTjhAGbTUG/n875RwRUMxZY5MiyEUuvT1UK2Rg6AmAaknZw1BVzDPwkjnpkt8+MYJpX8S3gLRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NF+vJLTI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3913cf69784so1756761f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1742572187; x=1743176987; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ecrDTLYDxGgNhNzRTNm3evCjq50/ZrIXNStDXAwPg6M=;
        b=NF+vJLTIItFdmriITSc1+gi5aVo05aExGTzbuq9485OK4aSlAGL9TnAShH1z9d4hwm
         lXkFfw37hoSLC+JNfXo/7LwfTK3sWADmZAuRRO2Z7pqZ4pHgsr5BnIXvM4l2dKIDwz72
         qUJSm6PmheRb2xFY2tjiWkvjW48bFIVIBlYraf37D6+uJVy+U8PMT/WZgnmLKvAsLeNs
         7Qdyh9plwfnSIVSTlOjBUHgyLoV1LG99rjRNsJi8yRb5Ww9BoFn03a9SBpi9BwnkdfnM
         Udue9jJkAyeCkibnfOrLASc2jRCpQF7JkkbuhSnZdous/GbuGfNg4TxrnruskhbbMJEm
         4gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742572187; x=1743176987;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecrDTLYDxGgNhNzRTNm3evCjq50/ZrIXNStDXAwPg6M=;
        b=jYR/lb6cHf+3TscAohIQMMiQKKNC1eRC1WzlG2DySBEreHL0n9bm1FV0bWfMIu6T97
         cXEt7Q8rnLxCLpN+ptCF6S/B9HeYv2h9JjAQuFV7XTbi55qFWDzZO/riKjUYaPzpwHsw
         w62cSDjmMzRpNZHUAsAgA/nGXxRyYWO+0n+j1w1VhbxtVp+UYsLvG93i7af29/t/kJ4x
         t3RLxUtPAiOBD7dTxqLFYp7dsbGlh76yONSJ9vPONDRoLymE19bDXcSMVFYmOI/sK4OW
         urvHUxo5Q0r08KPhZGF81QcQ2zruYZCIyIBg53GQOnP4fSXtHo8FvbYWaZnVwznyl3qM
         Zv+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGTHlkFvzyHfp/ir9aQaDUCLfCC8rs15GDFlL2eTT6cRHEXeobljOOXYdNKCm8C084aJYzZKU0ttYM7+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpCy0r7xGa2l0onGgeoV2HFb75759Sn4Ugbe4uyAVXZoZnjYf1
	aZJcy3xr331JGUl/PgrvdnpgnYsOviDO2tPBeMq79Hqvur8zMcbJmFsUKV0sJ8+WAtJcUpRzUN4
	X
X-Gm-Gg: ASbGncsOk2rEWXJKmuciThbijWxiobZaZzKSTnzjTZphDfmAQ5ugKFTLU+glWxe2lSE
	aaY01I1GlgQ4jZ3qYjVmxhZLJnTOv2cyJz5fcKbVS+jmiMKTHn4El8vng/UhGwrXFp6XnNDD5p6
	rxNEiJ0emOs5x+EX0KpW4NBzyfWkx8YZDSvIOWlOOJo7OXxda6bb+Wy7av9kzFFbKjFS/ky/0N0
	a/rJVHNNztpzWUV/ENT7Sw7SrzuGcqSKoz37/mJR1PBNGW8LDCDXEYMCrmsqIB2lvnTw6M/lzi8
	8vYM7axJlPeiB284hH9+FonSNrVw9hYZcQTlEg==
X-Google-Smtp-Source: AGHT+IEiBDLKuJPqm3653bNhiZEd8FfHn9OjwciSqLyeyuoAQ239gy/UgKfYCMoxrL2j4dDK2e/q7g==
X-Received: by 2002:a05:6000:2a6:b0:391:2c67:7999 with SMTP id ffacd0b85a97d-3997f9404aemr4348746f8f.48.1742572186779;
        Fri, 21 Mar 2025 08:49:46 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:1aa4:f3ec:847a:32d1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3b4bsm2664406f8f.25.2025.03.21.08.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:49:46 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/6] gpio: update the TODO list
Date: Fri, 21 Mar 2025 16:49:32 +0100
Message-Id: <20250321-gpio-todo-updates-v1-0-7b38f07110ee@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIyK3WcC/x3MMQqAMAxA0atIZgNt1A5eRRyKiZqlLa2KIN7d4
 viG/x8oklUKjM0DWS4tGkOFbRtYdh82QeVqIEOD6cjiljTiETnimdgfUpB7v7qO2FlyULuUZdX
 7f07z+35eTlDLYwAAAA==
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=889;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=HR4MOYYeEi4/YtAUlDN+xlXtMWKtoiz1VBuYe7LhgoE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn3YqV5R1Yax9J6jI06F6hn74zcE+qdNhcjL+6C
 ypmE0EqvRiJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ92KlQAKCRARpy6gFHHX
 cqQCD/9q70My7TckdtfgVNjjvKeL1DiMvfT1Giq49GvUWwaQL7vM7F45ZMl3mLW8L0Z1LAnDYJT
 7fNs1lJR0rffZDJwo4fZdoOvblQpUH/BHd7b32UWPi/OcQRfteS2Fx9/kXCZ0v6ooP3bpCvX10x
 0+vthgfH7yTxYUyW2OrKl1ntrnZilJXBU+b/vclHZYkSKx1FUnEFMumocX8cwoEpqFtcOQAQUax
 r5xHWR6anSsf0qwRWG1axHOg2evxld7Vjv2ZGs+xBwtmszmxBpO3N6faVK1StRTJF3B4DrDItuv
 vqhO+UlpSnjY6pgOTLgDeWAvtdL4EhJb2l/YSXg32g7doxSvIBe3lmajkV7Uh4+rS7ih+p1Z9ex
 p8Rpy20xd0DXt5QssNhd9eCucgMjn69dD8eYQyi4F5xgB4ya/47mAip7dMrvMOUA0hL1ovOgpi9
 Rp8bbe7jQ60ZpV04/o1slP7Rolo9m0rDN62X6c3TPGMiVBSFrdrbQx7R5QMG+HcYqdqpGvlWlNf
 VexUUepSncV1jH5b23xCpbjMLjaCaioMM4ZXQtT7+uMZgxcj/kPr+A+EDMz5EArWHL8r1HgzLYY
 mPpsCCngRS0cj5sKAO9a8mUbSMdEfOrHDDDIqA3ID/VvdV9y33lIfQgQHRP2268w92D6nCwe+7L
 /cIm0GBYJx9vBMA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Here are a couple proposed updates to the TODO file for your
consideration.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (6):
      gpio: TODO: remove the item about the new debugfs interface
      gpio: TODO: remove task duplication
      gpio: TODO: remove the pinctrl integration task
      gpio: TODO: add delimiters between tasks for better readability
      gpio: TODO: add an item to track the conversion to the new value setters
      gpio: TODO: add an item to track reworking the sysfs interface

 drivers/gpio/TODO | 89 +++++++++++++++++++++----------------------------------
 1 file changed, 33 insertions(+), 56 deletions(-)
---
base-commit: 9388ec571cb1adba59d1cded2300eeb11827679c
change-id: 20250321-gpio-todo-updates-d4af632d6126

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


