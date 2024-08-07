Return-Path: <linux-kernel+bounces-277499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA4394A241
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276392886A0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C818B1C8242;
	Wed,  7 Aug 2024 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oGLoPOsY"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D0122EE5
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017558; cv=none; b=CYi8eVTXrAjiLQsGlhDOnmmcIrdoe/FipCYPUnOE/CXG2OqOhxh8woQfzhenLq3ghWt9jfloLhZptq0oAuZdBdQa1UagvccH9x623nK/NjRcJy1zmXOma8GPMsn1/aeIX+99pHKdbVWpM2v+FptnRY4AQKy0pFqyG3yY0ch7+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017558; c=relaxed/simple;
	bh=7ZRyH1wZ8UABMYeIFk4r7hWP8ATe10mkdDCBs15OCtE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F0ta1zIl5qrG0TI6GuZpchMsyAfvVIPC2mHz9tcGFgQQM1APHpyvqL49VUA5ynUPt2+17ZT+/PzeQVW0+EUgsWwBbBSrRxPTgvmdkZ77J0bI1u68sIxLtPIquqiU31ZrKWJXeCVh6un9jSJPI3GnXli3/V/mjXE8Qvj2elNfy0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oGLoPOsY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso9729835e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 00:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723017555; x=1723622355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ZRyH1wZ8UABMYeIFk4r7hWP8ATe10mkdDCBs15OCtE=;
        b=oGLoPOsYLsSCvA+sloyzyAXwsxqB7Nq/QdsDZiLECK4gcYVcg0K8vjwfvsYtYh1QJB
         QmqJNvM6KsHF83gcct1N4hFdYDcEZvhRCaPeLyTj4u++3FHnJ7fnPr69jZdwbvPGVG7J
         6ZM2pvo2JlPaaAFpKCk7qDn+pTtakKhIt01pc5jKLRgMbWNRrlny0HERQTwXh8TmFeSf
         NGVecqC2SqGcWCI0ib+iTR5HApCMng19LHurhN1w6nbOSVf78t93hqCJZ9DfY1sFMTuu
         Q/58CZzFKlK/c1HGfoIz39XoPX8slkhbOv1kqsnBoxLCj2XqpKm3A09EWtHz9DuikT0K
         /7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723017555; x=1723622355;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZRyH1wZ8UABMYeIFk4r7hWP8ATe10mkdDCBs15OCtE=;
        b=mCwnksYAEZw6looNH12kh3Fbpe/L2d6cVkVv5ndCoJXiHP7051kWBAXMt501lS/077
         R4WRnmwKqAXDBtVPL5uKNrvFWJEHZFlEFOfPENevUfxMJ4a3sDnV/T3DXqqC6GLvCBQE
         1w2ZpUzXbFX2eehhfiLiFtkQvh7krn5AYsbeEs6xwJcji8LZWNUgTLR+IThFNRgsFzu6
         DCbF6/vdErjlpYG6o0fOB/33bwl5ws5sfj+pByI0cbJEi3mmUOgO9sXJdkmEexj0so4t
         l9z9IosS03HOYFd323MzTn25wfHp46AYtP/1TGebmwxp8GntpilV+Au3uXPaULXKTHCb
         YcSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhsstXVoS4Yfa57OuA9A6QKhBTAllTrxp1wL7T9j9ojmsS6qYxIdkIhP6Y/rLRemfc/WSPkbETKDXrAsMea7lEKv8geEctywgYWCKc
X-Gm-Message-State: AOJu0Yxe1bs6bDxb/KNzqDm0xRXARYp2On5KoOEn0FatiTrYDlsY0Yq3
	s6rm6lN6OOfJzzovwL9Ni1MAE0+0OlXuU92YwoKB+9Gc47boujwFVrtkaX4Aoqs=
X-Google-Smtp-Source: AGHT+IEWEBDIMErakCRpWAkvv/5YGsQlzUNSq19w3HIbKjzjEPjUi7r2MOgifYzImGGtUTOKZi13Ag==
X-Received: by 2002:a05:600c:4ed1:b0:427:ff7a:794 with SMTP id 5b1f17b1804b1-428e6af1d48mr117202915e9.4.1723017554278;
        Wed, 07 Aug 2024 00:59:14 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:90f1:3c4c:261c:b0f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057966ffsm17007505e9.3.2024.08.07.00.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 00:59:13 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
  Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
 <airlied@gmail.com>,  Daniel Vetter <daniel@ffwll.ch>,  Kevin Hilman
 <khilman@baylibre.com>,  dri-devel@lists.freedesktop.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] drm/meson: dw-hdmi: use generic clock helpers
In-Reply-To: <CAFBinCCW9bNtHLRaJNBvqLXN_vCm4mFSVhhV6OcrUb+j-0x3kg@mail.gmail.com>
	(Martin Blumenstingl's message of "Tue, 6 Aug 2024 22:28:10 +0200")
References: <20240730125023.710237-1-jbrunet@baylibre.com>
	<20240730125023.710237-4-jbrunet@baylibre.com>
	<CAFBinCCW9bNtHLRaJNBvqLXN_vCm4mFSVhhV6OcrUb+j-0x3kg@mail.gmail.com>
Date: Wed, 07 Aug 2024 09:59:13 +0200
Message-ID: <1jed70zru6.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue 06 Aug 2024 at 22:28, Martin Blumenstingl <martin.blumenstingl@googl=
email.com> wrote:

> On Tue, Jul 30, 2024 at 2:50=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.c=
om> wrote:
>>
>> The Amlogic HDMI phy driver is not doing anything with the clocks
>> besides enabling on probe. CCF provides generic helpers to do that.
>>
>> Use the generic clock helpers rather than using a custom one to get and
>> enable clocks.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> note to self: even if we need to manage one of the clocks specifically
> we can do it with clk_bulk_data

Honestly I've gone for bulk variant only because calling
devm_clk_get_enabled() 3 times in row and do nothing with the clocks
looks odd.

In I had to do something specific with a clock later on, personnaly I
would back to plain 'struct clk' and use devm_clk_get_enabled()

--=20
Jerome

