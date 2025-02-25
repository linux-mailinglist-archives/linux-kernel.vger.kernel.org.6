Return-Path: <linux-kernel+bounces-532474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A40A44E45
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B43919C443C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1892135A6;
	Tue, 25 Feb 2025 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ElTrfANK"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F751A7044
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517255; cv=none; b=HwR575fzdoyNhtBMf0XeP1qAIXhlurW5IjNHT58AVA0XhqAEU+sqid7XZPKEEQahV1Mr6U/HA1kHgf0Db8rTR9LDCO5qKBq+oIkMq3v9nlLW+M2DhXmCDjUVDIYTF6u+CApdpDkxuCAs90vwC3Sj5a8gamL6KnkUj9UyuZpcCLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517255; c=relaxed/simple;
	bh=IdZf9OirHo3w8TLk9FbgVZ1A1snETQ0MVXnUxcN2tAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSwbxg32O4FxSDhnvF7lgalmVzp3ir8sVosDC7wHz7OGbFYLvLs+b/w4nkADlV9TtQXr5EAKeb1UqaiGHaRxtieDJEERS5cbgXXLHiTfr2EmiqREK5eiuIrbARik6p4/iV7gewTeN8R0Q+RWSpuXy+5qJSHpxVzoOR88Fnq4ETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ElTrfANK; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6fd2587d059so743927b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740517252; x=1741122052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aTECS3SKQyqLPvpHn3SdLnl7nJuW0BjxdhYYx7X/Yrs=;
        b=ElTrfANKdzwE6kugjqiepiWfx2lxbwzHt836PI0NZF2v9Z5mg6i0bUAP+0qeRggRF1
         S4v1OX2jL9kj8xUjWNtCrrm7zwldMyhIpDNl85EvD+P9gZVVd8FxzdtjMDNuI7m0Nb0c
         qoZk74a96/5aOUzCnyGFqi1Iyveka+L3UxfgswQSUXraHDymdDvM6Qv7ntNqdF3GUhAr
         +1TQqdPEQVn8zDfB/hbyCirS0+RCdj3Atzam1jSGjuS5Vjddstt2izxR1Zyoo2HmjviK
         JC85I7TDbCIdaSbYgP7ZapByyJBR4vYTKniT21hTPYgRM+vBzjK4xR4r/ZugyMnq9KrH
         iwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740517252; x=1741122052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTECS3SKQyqLPvpHn3SdLnl7nJuW0BjxdhYYx7X/Yrs=;
        b=irjUKia1onScql40ddY+g/DdoTIgnqnyuL56BsSd1DQOgQfi+l/JuBegV268/oszlO
         lj4UY6HpX1CA4Aywc/oRjmw7ui0LRgfI+bXUC9IrzlKMFwtda88fYt+KF9dVpYJGdBAn
         6ZNiAfzSMb95xC5Yx89MliTKajaZpGHju5ro7kDQLFXpToXScxBdjjzZ9toFX76Co1Fm
         04/bCNqurrwZhPVIfedt+va7u1ZWETZxE4uBZAH1V4uKNlwQ3ZziYiF1pYNjEDNHkkF/
         zIKEtsW0PMo6FI26xM9mD9GQT7dlFXvSi3cNiFMADPP1jnUx3zGkNWpjMGuizXAcwJco
         2Ang==
X-Forwarded-Encrypted: i=1; AJvYcCUSszG9JUKVVbYt7PL+Tu0L37c/AtTFTpt3UNz3IPg7K7N3sxy1MBC4JGIQuD5MQyedHhYQDpZeThycgnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjicybKZL7RWLE+kKOMiDJxbFk7yAa37VghVKfjCZkCZGH33Jq
	0C0qqGCVbh6C+ALOnLPlBIAa9T7GSzxj/QmT81MDdrxwEabIx3m+uZ2zgKM/9uWuE3eMP+ps9yJ
	CdFwHsUInck3HkyyYUFZxyjZ8/lvGJ429uQMwLA==
X-Gm-Gg: ASbGncvvt3I73awze27gQKDorRqoNlTON6q0Lv4K3tOZdFwMhNW1xz8WANT3hJLBB80
	3kTe8rvJnNAmtoQipqvqZ6oGO6hAHXbmItpJWq/Nr2SCt82stdClnpiEF7t5hCABlmsGHdEJHf6
	c2K2TzHJBI4I4/e0P9DTEMYgsia7Yy3b7fL3yds7M=
X-Google-Smtp-Source: AGHT+IHVNAF9M985zwQc8ti2DtEeKOd6IPqcLWmaevOapLPMkqXyG9p9oh+HENqNXQGjtwqlmhkaD1MmqhA217I8byY=
X-Received: by 2002:a05:690c:888:b0:6f7:50b7:8fe0 with SMTP id
 00721157ae682-6fd21dc678cmr11826067b3.1.1740517252440; Tue, 25 Feb 2025
 13:00:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-adpdrm-v7-0-ca2e44b3c7d8@gmail.com> <174047913824.2131221.6545389561298332217.b4-ty@linaro.org>
 <CAA8EJpqM8ZQ-ScEtEBXaUF2Nargtp_TBAyMYvbJ49PGbwPWjaQ@mail.gmail.com> <2d51cb9e-b8c5-4cf1-bd7a-751fb633275c@linaro.org>
In-Reply-To: <2d51cb9e-b8c5-4cf1-bd7a-751fb633275c@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Feb 2025 23:00:40 +0200
X-Gm-Features: AWEUYZnjLNgOW9D81B_b4Ug4M1LEmwU_chC0K6f10jOh7vvlfER0M0Paj99xQ-A
Message-ID: <CAA8EJpqu269ttsUcEsJpBOexRUS+pKSaMESLosC9iNCoUCtroQ@mail.gmail.com>
Subject: Re: (subset) [PATCH v7 0/5] Driver for pre-DCP apple display controller.
To: neil.armstrong@linaro.org
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev, 
	Janne Grunau <j@jannau.net>, Sasha Finkelstein <fnkl.kernel@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alyssa Ross <hi@alyssa.is>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Neal Gompa <neal@gompa.dev>, Nick Chan <towinchenmi@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 19:59, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 25/02/2025 12:37, Dmitry Baryshkov wrote:
> > On Tue, 25 Feb 2025 at 12:25, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >>
> >> Hi,
> >>
> >> On Mon, 17 Feb 2025 12:39:30 +0100, Sasha Finkelstein wrote:
> >>> This patch series adds support for a secondary display controller
> >>> present on Apple M1/M2 chips and used to drive the display of the
> >>> "touchbar" touch panel present on those.
> >>>
> >>>
> >>
> >> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)
> >>
> >> [3/5] drm: panel: Add a panel driver for the Summit display
> >>        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/40115947b59f2ca361a47615304dff0a2b69a2b4
> >
> > Without the bindings?!
> >
>
> Bindings will be funneled with the rest of the ADP driver, the panel driver can be applied individually.

Okay.....



-- 
With best wishes
Dmitry

