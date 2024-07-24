Return-Path: <linux-kernel+bounces-260747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DF593ADA8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724721C21D17
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 08:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A0F13C67E;
	Wed, 24 Jul 2024 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHtPIuJV"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E27C0B7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721808005; cv=none; b=cw+79Ab6OTidk4kTz8qXstMsfRP833qBMKfCgNeWgmB00b7osnLIxCKNw/mmd7xT24C0upS9SxDe8fK7FjMyw86Mq4j9AHMWkjjLt0iQ4IdXxyMDAqOfzYodCydp8u9CrW+HiuY6CUBdV9e4Qq29rh4nuSZRUW2XjPm0g1CPJ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721808005; c=relaxed/simple;
	bh=KfJHWW8rPX9BqxLu9xFAETVxp9PuX5ktMrit6g/vK9k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Th4p24P89gMN925QMubfz7qymExX6ErDhNbz2h3zhw5fd/ECApoW9hu8M/fvFYHaeCGGgEJ0Q2m7bdUIzNh6avbtdHK9h1on00JluLNZv7g2jV+xxIPxOVryrEpPTnlIy61GyGw9RjunbSFgOf0ML4yKnqnTYYWUvVviVjs2liQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cHtPIuJV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4266182a9d7so43367875e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721808002; x=1722412802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVS63w01WpSMud20iAQLpb49vEgN8TqlZNBMv50zLlo=;
        b=cHtPIuJVKRo+YnbruwMKRNIUpB6FPt0CgUK6b4HwYvJ7GcsU+s1VmmWizW1o/fdEEh
         48tMwqjSh7OfNPmAqbRkEavLezTCPGUB8C530a2FfnDTRz+3BZ5mqfbxRXJQv99pAbOT
         NwHMHX1ObiUBtpyd20KZBZPgllUM000QSx04Gacird0AsVNJfFMUgtaHQAcB+yuGO0tE
         CapwCBMJrln6q6j3hl2yPR2cXBoGdnUe8isbnrCFBUviAsOvUh8iX45WPhNxBj2y3IcR
         E0rhdlwD4HASl5q6SNWMB4mxwqlmp9oQVMAgcTtQqJor+x4pgu1jceT/CiwE0Tf8qcmI
         Lz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721808002; x=1722412802;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVS63w01WpSMud20iAQLpb49vEgN8TqlZNBMv50zLlo=;
        b=omYyb9ez5vSMJTFC3mewV/+NQ+5VGGFlu4unv9fvzPnT/vfL5DHoZw1k578/I3a2r3
         ob9FHuBYGlstD04+F078pHTzh9uSa7nKgEaLt8ic8V3KI8Tu0jxKZs6QootxZTeFCBrz
         ftBEYqmoOGyVtel6DodMd0cambJfMifza+sKlv8dp6P6KgBoGqCrLnAgU8L/tGyQrXEr
         +ZJaMXWpv4B7y1z9uaxsNA6PDePh4R5gaxifIicLL5M1oIhyx08i+asIuHY6j4YXp1Az
         X87FsgipTw0Eb5f1Mia0TyOpBadxEyJ8RwiMxbb0dziFBi+xP1Cbg8KXDZ3oyQdPn+H4
         zv4w==
X-Forwarded-Encrypted: i=1; AJvYcCVbVwccnsJ4IndhP/PvlWxft9ulqDaAcT8o0mympKYytPitL9TXm4BYYxX337dPvepVYBuJrElOrAmFSX9BD/N5GlJ6jSBfZ1X3j5Pn
X-Gm-Message-State: AOJu0YxTzlHh8O6n+9ZPl8d/2xGhkkieNsVhFW/bY5Ta0mto4LCxOeAF
	drBBD1v7HIykDzIHLlaYhqDin6N52nT7E21tcjvkKVh5dFqq2BF0Ee8XCVh8uNT6OSPXCsgOz+N
	+
X-Google-Smtp-Source: AGHT+IGfvxFZZ2oIYZG+zvMY7HF3H5YwnYk9X5ZGtapXxEl9G+IdNM44EBKe1XDrOU7QfMBIc6isSg==
X-Received: by 2002:a05:600c:1392:b0:426:549b:dd7a with SMTP id 5b1f17b1804b1-427f95b7114mr7693205e9.36.1721808002176;
        Wed, 24 Jul 2024 01:00:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f1f52b8dsm33884015e9.1.2024.07.24.01.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 01:00:01 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Dang Huynh <danct12@riseup.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Marijn Suijten <marijn.suijten@somainline.org>
In-Reply-To: <20240722-bf060y8m-aj0-prepare-prev-v1-1-0e51c0f59d22@riseup.net>
References: <20240722-bf060y8m-aj0-prepare-prev-v1-1-0e51c0f59d22@riseup.net>
Subject: Re: [PATCH] drm: panel: boe-bf060y8m-aj0: Enable
 prepare_prev_first
Message-Id: <172180800135.4044086.14410654931478302593.b4-ty@linaro.org>
Date: Wed, 24 Jul 2024 10:00:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

Hi,

On Mon, 22 Jul 2024 14:07:15 +0700, Dang Huynh wrote:
> Enable prepare_prev_first flag for BF060Y8M-AJ0 panel so that the
> previous controller should be prepared first before the prepare for
> the panel is called.
> 
> This makes sure that the previous controller, likely to be a DSI host
> controller should be initialized to LP-11 before the panel is powered up.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm: panel: boe-bf060y8m-aj0: Enable prepare_prev_first
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/61eec998c9399d1cce91c7a2f51a4d0cfbab97bb

-- 
Neil


