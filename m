Return-Path: <linux-kernel+bounces-267530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C09B894128A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7727B1F24C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1120C19FA9F;
	Tue, 30 Jul 2024 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sr2eizxG"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B55818EFE3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343839; cv=none; b=sX/erwMdmJlnE1Q7TpkNGo+MfT6Z8AWUf8EL5FPr+V5xQxh/fgPi9nrlYyJPLGsUTv1DNen9tQ/57HCYhhJOYAqbicmMmtGK4q7aw91UVp6BEtIk0l21LAJS3b0NS2whR+J5ZuDLYDKoSaCp9rLStdIkOOTFt9jacJCGwt5/4V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343839; c=relaxed/simple;
	bh=DLkB9bQ5aPH7nsxbQIO5gMdMf/fwNN9bycB/b8ZNUUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aVb18AO9knz497334AwK6d7igb4GVsf+9+N7TH1SFevuxD2arbdgY253YGerjkbMDMOP0X03zpqtbjSjYOLeSOxaiSiWfG05hXGBxPDn0CM77Qdad/w9GorbZC0pKk1miSqRwg72KBF4yQwvibWGsAzOpWF81QNP8JYw5dTL5L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sr2eizxG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428101fa30aso26684915e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722343834; x=1722948634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4fILNbTnV4ZUaEZHGGwWYZeuafakFEBk9A0Y4htmCY=;
        b=sr2eizxGXnKglzrTlc0ReDz1/1d30qSbtvWSSipAYnY3z/mILwH1DF8ChYnA+XeX5h
         fRDXDuXZZ2uGgjd4E8xVv13n67FQ7fKeZMpK9N4szw5SkQvnnR7T6z2kQ/b/dBS3s3SD
         gfcCx+IAtIQnSnZ5vxaGIQIOSWll/ntgVA7bPGvW8AWj9Qnd9VbGJ56c96tBaqRfAwRb
         s/iPGqXSe/rq9uHAYGCz8y4D+fgBZAGhpAePKEiwGcZym61DLt/XcxdmNsWPlF6yKr2F
         YO1UG04AD1O+lagsLqY6WXTqVwUqIgRbR7eK+QV9QZMBQeoy9c9ylfQNXTrwI26CRQDb
         aI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722343834; x=1722948634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4fILNbTnV4ZUaEZHGGwWYZeuafakFEBk9A0Y4htmCY=;
        b=tLDeIzKI2h0/VrGwmfXgwVoL1480YsiHmOk7Ysw3pVCeNWb/PRHpBFH0uqCTo0YbNq
         aRf18VKlscRhHC3ebJE4UIzZLcL6rL9eoy6dP++kShUN7yO5IhUhMPsYdo4rsHEyYvS7
         OHO1lmi9vaAGAwpijNWcNLjvWMiA1Rp0O21Z995exoGyTtqVqfJPcj4McmIlW7k+Eug7
         5HnkaOHVTepy9dsDsFkx61jJmM/eDGJumvgM82Q0RTSkSR/Tr2sBMY4rfXJtXEbiO57V
         CeCBjALdXtFgpm6isNiarRplsQq80Iy/Spzy6yeI3vw48BYQQVdPv5sNqojlmlAjK3to
         F8FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA6GectZhhaTzk7oGH1lHl+iOnXO1NmdxqGrh58TGf/6Viye5ePBEe1gNzPynW9Ek33WSjP18Pyw2JBZcnAzyNjTKSlrUUk2l8uSoB
X-Gm-Message-State: AOJu0Ywbx7xQ09Xdqj/cCNxkRjurax/0a23SiORUD1l9NqD3SbFCJAmW
	COUNH1b/uAkbzlPIOt663iQ/bCKA/QBi+OcSntqa8buoHBDUpYFQhEuR3hRLFVQ=
X-Google-Smtp-Source: AGHT+IGPWSWAb+fvyUmPtwRvrlH6PC4ifMEhNzFkX9yIiubcqRcDAdw6bR9TYsXHuvl/XIZUdNlSDw==
X-Received: by 2002:a05:600c:3547:b0:426:6773:17 with SMTP id 5b1f17b1804b1-42811e12d26mr72308275e9.30.1722343834506;
        Tue, 30 Jul 2024 05:50:34 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:291e:4a48:358e:6f49])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42805730e68sm216521405e9.9.2024.07.30.05.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:50:34 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	dri-devel@lists.freedesktop.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] drm/meson: dw-hdmi: clean-up
Date: Tue, 30 Jul 2024 14:50:10 +0200
Message-ID: <20240730125023.710237-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

This patchset is a clean up of the Amlogic HDMI phy driver.

It is part of an effort to remove the use HHI syscon from the driver
and properly use frameworks, such as PD and clocks, instead of going
for an incorrectly global register region.

When this is done, it should be easier to remove the usage of the
component API from the Amlogic display drivers.

To be clear, this patchset does not go this far yet. It stops
short of making any controversial DT changes. To decouple the HDMI
phy driver and main DRM driver, allowing the PHY to get hold of its
registers, I believe a DT ABI break is inevitable. Ideally the
register region of the PHY within the HHI should provided, not the
whole HHI. That's pain for another day ...

The last 2 patches should not be applied yet. They depend on DT
changes which recently got applied. Time is needed for the DT changes
to sink in u-boot and distros, to avoid breaking platforms which don't
take DT from the kernel. These 2 patches are provided as a note that
this should happen eventually.

Jerome Brunet (9):
  drm/meson: hdmi: move encoder settings out of phy driver
  drm/meson: vclk: drop hdmi system clock setup
  drm/meson: dw-hdmi: use generic clock helpers
  drm/meson: dw-hdmi: fix incorrect comment in suspend
  drm/meson: dw-hdmi: split resets out of hw init.
  drm/meson: dw-hdmi: convert to regmap
  drm/meson: dw-hdmi: use matched data
  drm/meson: dw-hdmi: don't write power controller registers
  drm/meson: dw-hdmi: drop hdmi system clock setup

 drivers/gpu/drm/meson/meson_dw_hdmi.c      | 746 ++++++++++-----------
 drivers/gpu/drm/meson/meson_dw_hdmi.h      |  49 +-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c |  16 +
 drivers/gpu/drm/meson/meson_vclk.c         |   8 -
 4 files changed, 389 insertions(+), 430 deletions(-)

-- 
2.43.0


