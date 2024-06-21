Return-Path: <linux-kernel+bounces-224485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DD4912301
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C2F284933
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73CD172798;
	Fri, 21 Jun 2024 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJIZdO/g"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F2882D72
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968056; cv=none; b=achHlZazcSbbC/PaZ5yBPtO3o878I6R904Z8PeGcLXZBoDoE/i7uA0BKWsXPerhPMA3bOdT9u5nWqdEbN08fDIN8U+9fGqn82yY2BkLfL3bOHQSmbduxrdi1v9hx3IwGUJ5XPplhUOzQnWYWumBcvaAzK9k0nyBvdCviTM2jtDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968056; c=relaxed/simple;
	bh=JFIWThXRcCJO1QiagK/QQpV1+BQngNBwaZtk/4J3J64=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mwfsKUG1OJiryJQWm6uyv28DPgbrotelG4tef4LE4gXBz+muEPI2wpnLhVHLXPvbhsF0eWwe0t/XyyCz6XNhdH8kf7vpZ5/dVSQXSFUdlk8fTPgi4be2CxbX3BjdGfjs7JfLZdDZJ+WH7hzqFUaX071bfwitEHtfdCwbPn6Qpx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJIZdO/g; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42138eadf64so16711975e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718968053; x=1719572853; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+E55Bqa88vXpyC7KNeYzEgmKWlWtFJt5B+iA497prM=;
        b=RJIZdO/gosPVBfOeaERvdvSEDgpe4h/cSEua9PzPeEMqqkCbH0qivv+z/2kGClinZg
         SwZTpM1Sww+SuL83EOX1BtBRooQ+Z0bTrkRuWH1Jvg1Faref6CKZAuPf/S/UBXVQJV5q
         g0xK0MO6CGWCaZ9Rl9ToEXxoR0U26FFntFBY5FcCd2e+6k4r9C+Nj5fafWtCW8LNydd2
         5lCVCkVhSImNM5hjeTBQynpSkqv4wMKGzqFoJY1YcINxL8FQ9DQyJs4sMAGPBe+pK3oT
         8RZc/nGmESvG8J4WC8zxrp3shO+ssBEY+N20pfkjuiEYAcReKtGtsM3h2gZcy8SKXPHX
         1hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718968053; x=1719572853;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+E55Bqa88vXpyC7KNeYzEgmKWlWtFJt5B+iA497prM=;
        b=n/PatUHHSjwgvpbAYEhKwt85Lbo5dwm2V37kOlC3Hz/VSud4lKSvQe2IDzH74wuH4H
         mP9NOQrSyXuw6kjj4BrXRJvqonDy8QmskJCHS9X+b5MCiUUSZ3myG7rRGuzqzCkvwLkx
         Rncjv/kVNQk7GAUhl4pAh0oxop3SBjc1kqaHyPsIeFl9G2+c/tJPX1eNAE00ULpViDjx
         0ZRLM96D743ccuywiLnEadAslHsVI438De+C10VfkiHY3iMqVwoIbswxFukmqx7OFrPG
         guFunumxvJsTkd15xopomhw7rsEt1ZNSGcPdER2phAFXHrYcuDnkk0bl2hVabX1dgsAr
         iM/w==
X-Forwarded-Encrypted: i=1; AJvYcCWpmBlUvw8hhAkUyJgeFU4TUFfajqPclOOZzqqcH0orExfpJVAZkKTLnw07TW0xi30XYxQTxCUYbzEUdo1OA6QwWoYOw/D6tT5IE+Ao
X-Gm-Message-State: AOJu0Yy2D8UwP9yem8JGSOYHirBecKdZDiM/Gkn0qtPURf9kqrPvqS89
	xeSk/ScSyPQ22yDZXqh8p77n12aEc8lThN/ZgPm60mL9ALRwxeE9
X-Google-Smtp-Source: AGHT+IHscR9SP+ppu4ASqW5YmQmsS4APVFI/ixPfCUhAEhzSa9AwpZSAeYzXrKxdXcxqdTpqdzUPLg==
X-Received: by 2002:a05:600c:6a09:b0:421:eecc:2404 with SMTP id 5b1f17b1804b1-424751809e3mr61337675e9.24.1718968052436;
        Fri, 21 Jun 2024 04:07:32 -0700 (PDT)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f694asm1415656f8f.77.2024.06.21.04.07.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2024 04:07:32 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH 0/8] drm: bridge: dw_hdmi: Misc enable/disable, CEC and
 EDID cleanup
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20240611155108.1436502-1-jonas@kwiboo.se>
Date: Fri, 21 Jun 2024 15:07:17 +0400
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1599BFE-FE99-453B-BE99-B22C79562960@gmail.com>
References: <20240611155108.1436502-1-jonas@kwiboo.se>
To: Jonas Karlman <jonas@kwiboo.se>
X-Mailer: Apple Mail (2.3774.600.62)

> On 11 Jun 2024, at 7:50=E2=80=AFPM, Jonas Karlman <jonas@kwiboo.se> =
wrote:
>=20
> This series ensure poweron/poweroff and CEC phys addr invalidation is
> happening under drm mode_config mutex lock, and also ensure EDID is
> updated (when the dw-hdmi connector is used) after a hotplug pulse.
>=20
> These changes has mainly been tested on Rockchip devices together with =
a
> forthcoming series that add HDMI 2.0 4K@60Hz support to RK3228, =
RK3328,
> RK3399 and RK3568.
>=20
> Rockchip use the dw-hdmi connector so this should also be validated =
with
> a driver that use the bridge connector.

I=E2=80=99m not sure my level of kernel fiddling counts as proper =
validation
(Neil would be a more authoritative tester) but FWIW, I picked the
series to my 6.10-rc4 dev branch (for Amlogic devices supported by the
LibreELEC distro) and AFAICT everything is still working. Tested with
Amlogic GXBB, GXL and G12B boards.

Tested-by: Christian Hewitt <christianshewitt@gmail.com>

> Jonas Karlman (8):
>  drm: bridge: dw_hdmi: Call poweron/poweroff from atomic =
enable/disable
>  drm: bridge: dw_hdmi: Use passed mode instead of stored previous_mode
>  drm: bridge: dw_hdmi: Fold poweron and setup functions
>  drm: bridge: dw_hdmi: Remove previous_mode and mode_set
>  drm: bridge: dw_hdmi: Invalidate CEC phys addr from connector detect
>  drm: bridge: dw_hdmi: Remove cec_notifier_mutex
>  drm: bridge: dw_hdmi: Update EDID during hotplug processing
>  drm: bridge: dw_hdmi: Use display_info is_hdmi and has_audio
>=20
> drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 145 ++++++----------------
> 1 file changed, 39 insertions(+), 106 deletions(-)


