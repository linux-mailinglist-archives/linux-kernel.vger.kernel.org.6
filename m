Return-Path: <linux-kernel+bounces-350521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFCC990672
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F211C21BD8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E032621B43A;
	Fri,  4 Oct 2024 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GSD1HQOf"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A4F2194BA
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728053018; cv=none; b=U46vVPlkmWYtR/PiQyGHF+XwRl3AD0xlfYWdYVYPfEbDsRtmSe5zlssqwyo34vp1dM96Rhm6LEp06ITBoVK0Evt86csAhUG8/6qGxNttqQV542uWf2MwmkviQSZMN/L3ESyPleFGjz9ocJhavgeesDMnfwtEytLd6AqOyES6TJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728053018; c=relaxed/simple;
	bh=fYsf85z9/mT3KGR9AwvtVtnuqtHgvSbEW0PHiTli0hc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GmF7ArOqg9KqxCwihQFVBr4T70B5ADBs+03lcXsoDFzARjYCC1cuQpZD9BxjVbsN1D4f1at//LU+vgRiDb8ircGnFeH3ukS1LqhSdC9h9xFtERG2vojpQCwA/EA9X8YxtkRfCHahLNPuubfd6vtyaFtUdED+SRNxFHWE4EozGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GSD1HQOf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so22440185e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728053015; x=1728657815; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nt6lZ01Kn9Dk+8HdC9sid8nZZfFPFDlnP2qBWPSrg6Y=;
        b=GSD1HQOf/S4s6qx5i22/22ThjFqyRgRLf3Y8v2G0J/Yv9lprQIm7QX/MiXHVtEWAwu
         Xb2BSxFwl6qkQFScP0r3K93AM463+N/aSjjsP4TVn1NIBA7MOQRNIsANoWtBD/VbKl+T
         /8uXqCIklVOAhCP2AZjbPtBaH0CHWsgHvKyOazp0z1C0rGAEXAjSHjs1KSPSmQkFqcO/
         T/PoVLl0imtT29fYvyWIK9Y75eKNVXQBRvYDRxZHTc5hfvFHslpe7vCwIF9FLQjEobO/
         Xsaq6YUnftGmnlmUza7zzCUQ+TUaSzhUvhzEQ5lUX7OxQVVDkWFkYziFtm6F3KtQBWkD
         Jv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728053015; x=1728657815;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nt6lZ01Kn9Dk+8HdC9sid8nZZfFPFDlnP2qBWPSrg6Y=;
        b=j+S62oluWI0N5geXopVa8cZuA61OcXqoJuEhHeoRCTJScfbLYv/4IOp8Q6a0BvLAPu
         NwAkbS4B/yt/GbESPbDEb1FYSchnXa41TfOjm45oBQQzDu0NxzuN0g/nuuh5b7mcU3TL
         ERTltVayJOh9leg6z/jbQprj1daqYx5ZCLx3GA+a6BNpFW3JNdT/cKQeMpuKYYAuwcQd
         BKMbjOs+fcFzuRHtUk1nGl/ydjXtwbNi6N8FaMDnTMWueifpLKSHWCHqiWL/IXP1qd29
         fQLNdwr+cgZZ08x05ExbmyuH6YSLSz2iX4NYAN8Z5PVB+sqFK1bxc5MZeT3d2BLW1iww
         WgaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR+UEgrixxf6AUBrJcmwa+EXpZEAOAj26q58DCywhPyy089zacG0xbqfiO33tMa16PfBpofv7JAV2vUOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFAnzOa/9Csf0b4tt9bUIID8mmZilhJ4OwkgAVVRiIP6Of3PI7
	lZSrsVCD+aVlqTcn/Flrs6iBtfdymUT94FsvziXJzDiY7MDUC6MYo7KmjifBJVg=
X-Google-Smtp-Source: AGHT+IHfVICQSIk+2qxMF3q7f0wasVaKs1IsmnXkT5plb9rruztXXnqrBZmpl3t3HU2ILl+mtUcuHQ==
X-Received: by 2002:a5d:4e43:0:b0:37c:c4bc:181c with SMTP id ffacd0b85a97d-37d0e6d89b4mr2058726f8f.11.1728053014578;
        Fri, 04 Oct 2024 07:43:34 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:80ea:d045:eb77:2d3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d20bcsm3361370f8f.100.2024.10.04.07.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 07:43:34 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/5] gpio: notify user-space about config changes in the
 kernel
Date: Fri, 04 Oct 2024 16:43:21 +0200
Message-Id: <20241004-gpio-notify-in-kernel-events-v1-0-8ac29e1df4fe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAn//2YC/x3MQQqEMAwF0KtI1gbaqqhzFZmF6FeDQyqtyIh4d
 4vLt3kXRQRBpE92UcAhUbwm2DyjYel1BsuYTM640rSu5HkTz+p3mU4W5RVB8WMc0D2yqYextc5
 WBRpKxRYwyf/tu+99P73aWVVuAAAA
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=fYsf85z9/mT3KGR9AwvtVtnuqtHgvSbEW0PHiTli0hc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBm//8Ri7EhU0pSesBJwArJwLLanAztBiUrnFKR5
 enD2ZVatA+JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZv//EQAKCRARpy6gFHHX
 ckDID/9haoDXXtBGcpw35crfIWjRuv+lLxVRdvHxRs2pcEfQFxYITx3bdskWgrJEun47IsyM0V8
 gAY1U7SFMEAR2JPaRe+5UOSBQJUBItqNXdAUK886CBaK2HG7u7hwl873K6wXyIRepbsbT/LMBxx
 YIbGfrXp2TqbB9kNVD8kl+F/8/YdI3urLYaVlRT5H/6ivmL/2e0sp+8jXv8lArWFXufI6zAgw4f
 INOS1oQgPPRpALK9nVHzbe7ap4aTOCeiKTR5xTfS1lV00CpzftAC8hTUiOx9j47mA4nP1+qwEzd
 /2x5zM5x77ecp+gKaYJsrSqlmBeqKC0Ul2c+F3pYA+TSGgRvUpsZSLZldkgUUHipsuZRBTIS+T4
 Uni8lR5e30zE3kdbv67AOeH91evlVE9nZkIloiitDtFREcIgZnc+3VqZo2U4wqT4tGMoUtwf4h6
 RubScWJqMGU544QFJuiIrE8C+X+ZRq08okdU3/qxi3I6NS4LnHKo3EhZj4ju+/O8pB22nURBwbt
 b5QjgQkHeOPhU7tPBSbEnuakTeTyyhgIktT2J4WE9Z86RCsHZOQM7eEJe8PBCQ1+mb1fag3QHIR
 tIaONK7nT4ULiUm4dAF+H1IubrW45FdvUwjBw7mcdXM9nFjxxsWNRBUnTVMoa1cK6OdUybZa9Dj
 KGfwrwj/fXzjuqA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

We currently only emit events on changed line config to user-space on
changes made from user-space. Users have no way of getting notified
about in-kernel changes. This series improves the situation and also
contains a couple other related improvements.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (5):
      gpiolib: use v2 defines for line state change events
      gpiolib: unify two loops initializing GPIO descriptors
      gpio: cdev: update flags at once when reconfiguring from user-space
      gpiolib: simplify notifying user-space about line requests
      gpiolib: notify user-space about in-kernel line state changes

 drivers/gpio/gpiolib-cdev.c |  88 +++++++++++++++++------------------
 drivers/gpio/gpiolib.c      | 110 ++++++++++++++++++++++++++++++++++++--------
 drivers/gpio/gpiolib.h      |   9 +++-
 3 files changed, 141 insertions(+), 66 deletions(-)
---
base-commit: 58ca61c1a866bfdaa5e19fb19a2416764f847d75
change-id: 20240924-gpio-notify-in-kernel-events-07cd912153e8

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


