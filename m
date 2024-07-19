Return-Path: <linux-kernel+bounces-257179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E0F937649
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0621C2211C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCE182D72;
	Fri, 19 Jul 2024 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kT+rvts6"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEA457CBC;
	Fri, 19 Jul 2024 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721383224; cv=none; b=L+ZZCfSiC68fz9lIFRcFsSle8p3ZuBX6VYd7WS5AZczwxHBizy5jUuFgymhl/xd2LI80/jOnWofP4bx2C7FgQxx/GplyuKfYaJPOJDtBX02lCVY6qvShFUL6w1y3OTrIytVLnBuknZTVFk/A+0qFTW0OjtYdY/zB/FxaXjNLuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721383224; c=relaxed/simple;
	bh=VqRlmTYZVPC9UeUNogKrTilbK00O9KW5Y9AJenvvV1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qmbIwZXRhjcQSL/os7QaS14uvqchpRZjb2gV7oqzXuA05Th6NMvWqmJhN2iSF1ao5GaQB1KlD/HRxGIUBVbRdW9qKl3TEr4mxj0+CzScOWO+hCMp8wC/cgzdKf2KYc0j7GPa51k/dtO2074lggy5QI8XS+YKZTogl7ak3CU8cwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kT+rvts6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-368712acb8dso405028f8f.2;
        Fri, 19 Jul 2024 03:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721383221; x=1721988021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4u/U5n2E9VcbdWmzwrXwzoL4/4UPDPNcltFcW2ksIoA=;
        b=kT+rvts64z/CnMtv1EDWWJe40P91HuhEsFg47flRmOvpWcN5KmLYjwBAApk/6V3RzL
         NBFvd/sm0X51/Fxx3Y//D4FmjqaUvqUMYp08BMmcwOh2ahC6xmhtqzwmVB5BvE0TjNWu
         R5m+x8PAoOUoDI6BMk2vID0A2kr0d00vQ8jA0udsM8M17iD+WfJAwc8AaSftNC5XTJip
         I56n++2Ve00BDxhdIkLgLr/ecu88NomGtak6dHSOvS7w8OCX+oCOWnK/QMkhKGxpjasM
         P6+epb9Fwgy7mErDAFQkQr4h4toMewV/z1wU5XVLZppHDVw1afEELAJr4J1NQaf08aQ0
         NnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721383221; x=1721988021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4u/U5n2E9VcbdWmzwrXwzoL4/4UPDPNcltFcW2ksIoA=;
        b=BcXVaKCqM5PGeoxf55ZPMwIZuehvPFdqK9m3UVEeLY7RUuWUarAbVCsqbi1q8XW2Re
         QjwmLaiWoRd6HomD4cElg3eZhutbOJGRYmOEIpmAdgMdYHpTUdEd6x5ysbT305d2bWUT
         2RA8IdrYEBIYPeTKns7XgRCPglUUCOMzkgHgA//TLUaISzu95hd9VQAUKcKPJPZ1EKXg
         7iv4KUa6ikSByK4GRR346iNgZnO6rL8DBYV2JLiAbN29NAe42zQCv9uTtOAujZN3o/+b
         mmzmDvuCYcxtqlqMN3vrjsDTWUAVXmDH3bLBqEC3i7v9qA2J9cdCb7dxENlHgTK6vWRf
         V+aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhhtLo98aACa8jxbup/uWqlkI59QQHd/Ns83AQuWLKqjzq0ZaNr5Zv+UNB0VpvQgGJW5uXrFA85yTEPmacrMze/rdkWBnXTT+KXQ4eNSB4OAyIZ/KBiWz18y68yUnPSu0fQQMhNiGyfZQ9kphSdIwdpw==
X-Gm-Message-State: AOJu0YwoFta27vzO466UxB9NZqvRC8VWgQoJWx5VcRqF8E2jn7joTqkL
	nzheYHytg6hXI1azY/31zjUeuevxeD0K/uQbXH09H2XMH6+oBj+u
X-Google-Smtp-Source: AGHT+IH0/q4okQNF2H3wptKu8W1GUgPKNgT6vh+QA3Wv8C4/QXO+zo9D7YPylUg3sqdt++3yRsFNTQ==
X-Received: by 2002:a5d:540d:0:b0:360:7c4b:58c3 with SMTP id ffacd0b85a97d-3683171fa0amr4350259f8f.54.1721383221164;
        Fri, 19 Jul 2024 03:00:21 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:ed72:2800:17de:b512:9f9e:464b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ec979sm1134359f8f.94.2024.07.19.03.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 03:00:20 -0700 (PDT)
From: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: mustafa.eskieksi@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
Subject: [PATCH v4 0/2] HP: wmi: added support for 4 zone keyboard rgb
Date: Fri, 19 Jul 2024 10:59:44 +0100
Message-ID: <20240719100011.16656-1-carlosmiguelferreira.2003@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
This driver now supports brightness control and an initial version of mode
control (all brightness values to 0 means off and otherwise its on).

About this mode control, it presents some limitations and problems.
The first problems i noticed happens when setting the keyboard to
off mode with software and on with hardware.

Example: If i have 2 zones with brightness != 0 and use sw to turn the
keyboard off, when turning it back on with the Fn + key combo, only the
last zone that received brightness 0 will be back and not both of them
as i would expect given that was effectively the state before the user
decided to turn it off (this is what happens on Win).

The other problem is a bit worse, and it happens because of the small time
frame in between me pressing the Fn + Key combo and fourzone_set_state()
actually running. If a userspace program sets a brightness/color value
to a zone in this interval, the driver will reach an inconsistent state,
making it pretty much useless as it happens frequently. According to my
tests, setting a color every 0.2s or even slower is enough to trigger this.
It could easily happen with software generated effects.

Both of this problems would be solved using a proper system to control
modes instead of trying to encode them in brightness values.

As far as i know, the multicolor LED API does not have this (maybe it should).
If it really doesn't have mode support, then creating a sysfs entry/attribute
in "/sys/devices/platform/hp-wmi/leds" would allow for proper mode control
and the mc LED API would also function as expected.

About the Kconfig file, i had to use "select" instead of "depends"
because i was running into a dependency cycle issue.

Changes in v4:
 - Added support for brightness control
 - Added initial support for on/off mode control
 - Changed from KEY_KBDILLUMTOGGLE to led_classdev_notify_brightness_hw_changed()
 - Changed from a single rgb subled to 3 subleds (R, G, B)
 - Added the LED_RETAIN_AT_SHUTDOWN flag to better mimic the Windows behaviour
 - Added the dependency on LEDS_CLASS_MULTICOLOR
 - Included some documentation for the LED API
Changes in v3:
 - Moved to the multicolor led api
 - Mapped the wmi backlight toggle event to KEY_KBDILLUMTOGGLE
 - Some other minor changes
Changes in v2:
 - Rearranged code to remove forward declarations
 - Changed from sprintf() to sysfs_emit()
 - Fixed some identation and coding style problems
 - Switched from manual bit manipulation to GENMASK(x, y) + FIELD_PREP(XX, )
 - #define'ed magic constants

Carlos Ferreira (2):
  HP: wmi: added support for 4 zone keyboard rgb
  HP: wmi: Add documentation for the LED API naming scheme

 Documentation/leds/leds-class.rst |  40 +++++
 drivers/platform/x86/hp/Kconfig   |   1 +
 drivers/platform/x86/hp/hp-wmi.c  | 282 +++++++++++++++++++++++++++++-
 3 files changed, 314 insertions(+), 9 deletions(-)

-- 
2.45.2


