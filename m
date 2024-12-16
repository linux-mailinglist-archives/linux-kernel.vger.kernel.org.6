Return-Path: <linux-kernel+bounces-447050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534AA9F2C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F15C161D32
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5884C200120;
	Mon, 16 Dec 2024 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Gv6KZ5Iq"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E520011D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340146; cv=none; b=U3h8mTFyAELX8NcjlxAxTOgIjW7pD3AFyZJdssxz1ThjwgGuk77ouTQpKiY5irKG3RjeOdeR5ocWNZzmlUBpUB+y4Cd4RKR8/SEppKAfjSZH7sMP6SU6JTc5ijd7jwL40dsV+hn/7dwhHrINl4tvQR1VbdFsq1avVjlZ9g7GvQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340146; c=relaxed/simple;
	bh=M19509IjZMcFyL8kbGcmsLxqS7khHdG+4BTdiY+Cn3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIX2FTdPUZiaS3naOsrWj+qStTuq4+z/p4MTFPjvZBXUu3rG1UBM0EDJLtXk8lGPGpN8D3uSnByJ1oKHcTrNkP4zRGGUrN+hwKSUWUDD4H0Wh26oej4lYD/Iqn2InZBf7upP0Y0IseefdDLGHVz2IVJbJug4W4YWVNn/n4gXsJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Gv6KZ5Iq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361d5dcf5bso42274515e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1734340143; x=1734944943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGBHS4QHf1CsUcSFjaZXRI9YWCCVYzt2h/iHstQ0laA=;
        b=Gv6KZ5Iqx6fzNhZAU09D/gQSVlFTqh9G8v4OVdBKVEPO4vcVXbBYkJBRG1PecZ3DAg
         R9cbNo+FTpS6IJvrIjPyPf27QfuykBmjyQX4X17Ra4FzSHrf+6gPQJUSwvtia91rf+Fi
         4wnGPAmPVX6SMLGhwjBG4GsfuMfTN9FDbQdalQO115lzwl+IUZujiU8+UsJ5B04MXzKX
         /nw4keWIdfH7xVURQf83yx+eQl6I127uRb7iGTAqX45V6kmtjxEJ7489mD8+c8DSZa12
         m0JunSnVSkD+A9BsH2k31VqBSIIO0QibCvPscO3IQkbe8DDwuHaxie6pePXC2Vbf6BWM
         r28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734340143; x=1734944943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGBHS4QHf1CsUcSFjaZXRI9YWCCVYzt2h/iHstQ0laA=;
        b=D+CXFJ5dDx7szImDSNKuJoeyWkJsKI7s+dpQb9A+ddbZYV/EEXNOm1QwH0E/K0upeh
         q6eCeKPdDeVPXY/rK+jDcXYZjb5OtizE0iN3+dMiiwE1nzadw7VEN49N5fqi0T/Hz+ri
         1Vf9z2SIMNsmkW5VJTjCuZrqjRLEqJlpWQvLr4QSXOvEtPmrfh+MNTyLKdMk9IkyF3vq
         1JilCUX/m6ZDQRUf8sEfzPAUlYgRvf1vTWozEjlEfCVNgEsmVFmlPcbM2Ogqwhn4Pvar
         3MCZiWr4fsAGeZr1hK8Ldc0xGJFwu06iHGut0Voi/MTwve3DmKbbREv6u8+Lq8Ehd+pe
         nL7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwczOQGUUxc3D7M4/eru26EBeMnIwAuzdQinYx6+1AIqoTRIKASrQf2JFmWbN2+QzsXA9lUmeXVuKTqIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+YTazETcvjKXR2rzDkcpVvxC9OnP2nUqVxRChEANqwxN06pbU
	V2NoNUAj2Zher7LmI/+o7rmrbYJU/driZhONx3jRp0BYRknXmzF3UGNiGfi/2c4=
X-Gm-Gg: ASbGncujQPwBve3qmofuqq8Fzg1fp4eVYEIBRN90EUsuz8MZ7J/u01wsEip7qMbuTHK
	03r8aAlUwIX09E4SCr3hjJ5/6g91thn/IO44G+8fBlFYCzx69MsAkXPZFd/AJhTf4ptB6mlKJeM
	MwDRuJ76MJfFoF/AlQN/fAPTFhAj2ryq6jlOhEgcjXBGypotJtwO6sLdXtcZFlqqn4PFQwqqPo5
	8t6qnwQFMliB2mpoJRqIhRAi+wxODGqctdn4gF0eVxm7DQX83VUACtF
X-Google-Smtp-Source: AGHT+IH72Dfr5eQ52hfcPTD2JDNeTzGbEvM+MfJLbWyJGQJuX1wyKsEB2Yp2W1KGB/T0MXX4Wu47cg==
X-Received: by 2002:a05:600c:871b:b0:434:e9ee:c3d with SMTP id 5b1f17b1804b1-4362aa93cb0mr85374005e9.20.1734340143532;
        Mon, 16 Dec 2024 01:09:03 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ddd7:943f:c7de:9971])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559ef45sm133677185e9.26.2024.12.16.01.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 01:09:03 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Eric Anholt <eric@anholt.net>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stefan Wahren <wahrenst@gmx.net>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-gpio@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/7] drm/vc4: Fixup DT and DT binding issues from recent patchset
Date: Mon, 16 Dec 2024 10:09:01 +0100
Message-ID: <173434013318.38429.808413721248542013.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212-dt-bcm2712-fixes-v3-0-44a7f3390331@raspberrypi.com>
References: <20241212-dt-bcm2712-fixes-v3-0-44a7f3390331@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 12 Dec 2024 18:36:27 +0000, Dave Stevenson wrote:
> I missed the DT errors from the recent patchset[1] (DT patches
> in linux-next via Florian, DRM bindings patches on dri-misc-next)
> as Rob's bot report got spam filtered, so this is a fixup set.
> 
> Largely it was changes to number of interrupts or clocks in the
> bindings, so those are now covered.
> 
> [...]

Applied, thanks!

[3/7] dt-bindings: gpio: brcmstb: permit gpio-line-names property
      commit: 83a9752729c455a6bd9b7cf62198506180691931

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

