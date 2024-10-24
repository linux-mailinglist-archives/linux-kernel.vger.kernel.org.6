Return-Path: <linux-kernel+bounces-379797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80909AE3E7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1ED61C22245
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDB61D0B82;
	Thu, 24 Oct 2024 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="leYyrihi"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B01F1C4A35
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729769579; cv=none; b=VVWjDBqGOZkAtYTb2PKej9JSp8I6xeH5B5QswhIFPO0/JPl8DWJD0QdNdWmxBaFIXhgkjxZJfWND6gAvt4UcEwj7k6/yahLJQSQ3DAtN1HZ15YnMBG42u3p4BiCI46A/J+6dzlREkJq9PT7IY9/YKcrrVFGTRDdxB9pk8jSBWUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729769579; c=relaxed/simple;
	bh=2ukGcetbJ073X0kVtfmH5NRy1q5c9OPJynatresKxrw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MKZvXhNBvwh6Xv8gD5MKdPearAYXHHIEZHn5H4Q9t8CnhwEF7LEFua2osKOWLmBQwOqqR/0Lv1YO0C7gxDLR4DFATH00cDFem9dXGcvelEk8MojBYDIlVw/vyYZ+bik45If4SIACDd7qMZqxo2S0F+AhImRtcqG8lyJ2EjNnGlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=leYyrihi; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so456243f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 04:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729769574; x=1730374374; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2MgD7S88uo9sxVvvM9wYy+rEyYTBG9VG2cJ5wlIWLfY=;
        b=leYyrihiCIPnCmPkzSgUZZ50mxO6FG0lbjFqMXMi8FxMqj1qUAeHOSk+bqJb/AhZGg
         jb1/8YW05xG8j+ZX2fmY7WRyib8DkS0ySIFL8XO80h69FFcYh7O21BJcQVNmsgaHrY/N
         5klBEx2S8FcDZey7tScnhPhNnS+k/8A/3Dsi4Cqp9PwEDOGIp+UGX59w1MVHeBZa9Yfo
         wX6OV7qgPTjf2NS7evtABB9KEJhyBboOdOjeHp3bnDFOV7G1FT20Alcf8O9KFwJ6ojM5
         P9GWilIDAO9+N7ikhIRgU/9TOXQ23t9wPmIIGkiXF+MdXoW7gQeH9KPhjygzuFvS6e8m
         YQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729769574; x=1730374374;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2MgD7S88uo9sxVvvM9wYy+rEyYTBG9VG2cJ5wlIWLfY=;
        b=JF+x4t1T4MavNR0M7eet7bu1JrfbBADN8qgwu6mjmjDcs2QNh3YpOPIzaG0iXgzwFT
         fqQ/P39RetYjLieSMMIXnT+OjlyBk7SXPwr2sc5lP8dZhVwzbTONNTGw6ZdyMMci/r66
         BgFSvovWE3Thjl3rc2+nkQvEpiYUMyoyINFnMGtZJOmuYuI1mYmxYwY+CtD1hnN7TUHR
         ZOtNxok0EAYhA4ZD+cUADHMB46YL9lug9+255fREd+24DOg7tRu2g45wA+T54An760UT
         VJr6jQDhyCT1rQ9FAPMdDfVJ1jA/j1wOtQUpjozjEtJZxYsM7D1P0TnzQe3pjRe13PBk
         w3RA==
X-Forwarded-Encrypted: i=1; AJvYcCVRGvR27lZx9MV30eWoCReVitVVlgo6vNJlK9PdkUZQ4Tg/kzHk3WH/tEUB7S8XNLNJfrQ7aLslIXJA7lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzapWuntwsNX4pW4rcVamPvlh3O5EK760fxZpMR2xPmkJMwZmBU
	rj9vfMFf6fwX5mFeCEtFyalze4U3tLjP3aY4aLft7zungDba2n1RBzoPP+I/gws=
X-Google-Smtp-Source: AGHT+IGGbwM/wC/uvUgJAQYmtUs21huVciYy7jFw7cYJ95pfBma3Y0EzjxjA95ATZvJ/Szy1slJRog==
X-Received: by 2002:a05:6000:1210:b0:374:b6f4:d8d1 with SMTP id ffacd0b85a97d-37efcf0b548mr3779635f8f.13.1729769574441;
        Thu, 24 Oct 2024 04:32:54 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:17a2:e679:56a4:a25a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f484sm14592705e9.13.2024.10.24.04.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 04:32:54 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/5] gpio: sysfs: send character device notifications for
 sysfs class events
Date: Thu, 24 Oct 2024 13:32:43 +0200
Message-Id: <20241024-gpio-notify-sysfs-v1-0-981f2773e785@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFswGmcC/x3MMQqAMAxA0atIZgO1utSriIO2iWZppRFRpHe3O
 L7h/xeUspDC2LyQ6RKVFCu6tgG/L3EjlFAN1tihM9bidkjCmE7hB/VRVuzXENiR94tjqN2RieX
 +n9Ncygf0liMyYwAAAA==
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1440;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=2ukGcetbJ073X0kVtfmH5NRy1q5c9OPJynatresKxrw=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnGjBkSTkm2puOnNpzhe6QEjw1a37sxckcPMdRA
 TJj4dmLOTaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZxowZAAKCRARpy6gFHHX
 csmFD/4mt3GUCKb0pbe/hBugOPx7qAbeAVjQt3ke4froV5sa5pmiv7XNHKMaBrGlAtS/wehzMYs
 bNdQNXC27nK5OSbFml7LTl9VmnPSYyIklgux8XtXIsT7Nmqu1A5IfLD91uU56yuFOEqaTn/BCyL
 Kh0e8SMaJdmAp41Bg1/XpCJ/SbG+hSASFrq6OiezeghjF4GMgMQDj4XWulufqiG+lfkEudgaQTu
 xRLvg8UgP7ez1FZhovxmd2fzfYZOORlyiIuLd4KkSlAgZQnz5wl3pT12z0VmHU5iBIOrghx84q1
 VGbNBg0As14O88OOqeSo4p8kzlcQOt0UR6Ip0wztnJHmyE/WY9+JR1Q8eHjwm1QyQUDBRf4Yn1g
 ZrwOqPi4Mj/Z8nF0SIWAxB16oqkPfso2X70vUPe2/EHQmMTqItUj1xve+n2gcYrZ+s1XqHPEm5+
 9nPb8s4k0d3dshrb6k59GXAFxDYDeGNBfQn10bbR0P+/Zv/jKqrRjpSfS7jug2LzAsgZNpItzgq
 sMOVoW97I6OawIZx2rX9UnByUejv9pWzRv1eGm80Jh35Y82+xaYqU31GqoOfr2SO6bpgtfKVd8b
 OvvnGQ4mbM6Bj94yH0uHy8ryhpTYWwsyLcIH/krmZdgY5T14dBEyniuUwbwzV+ffrw7WtUTfixW
 Dvu30HRZfFbsdwA==
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
Bartosz Golaszewski (5):
      gpio: sysfs: use cleanup guards for gpiod_data::mutex
      gpio: sysfs: use cleanup guards for the sysfs_lock mutex
      gpio: sysfs: emit chardev line-state events on GPIO export
      gpio: sysfs: emit chardev line-state events on active-low changes
      gpio: sysfs: emit chardev line-state events on edge store

 drivers/gpio/gpiolib-sysfs.c | 143 +++++++++++++++++++------------------------
 1 file changed, 62 insertions(+), 81 deletions(-)
---
base-commit: fd21fa4a912ebbf8a6a341c31d8456f61e7d4170
change-id: 20241022-gpio-notify-sysfs-3bddf9ecca9f

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


