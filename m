Return-Path: <linux-kernel+bounces-516646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6547DA3754A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 16:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351243AB356
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 15:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2841925BA;
	Sun, 16 Feb 2025 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mYi0VXNU"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBE222094
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739721433; cv=none; b=SMNfNliCuNLEekASOcSVY+g2PW+k0BSl9C4pB9Aw5tVVxMcs37SlsbBlGZjVX4v3puyXRyDARFGRSBWRnOJRDOOElYwLxoKXlb2zwAGnjHDzigcNsRPVahIPfrMNDwVYGdqdPR85fiK1hpZ+3CbLIEjv7U99KVwn1Mvv2XkVZzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739721433; c=relaxed/simple;
	bh=PQOSe48l5H3052IuhYqloS2l0/kiRrTSYlXbYZPCLi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIa01im2oJ89Mda50WIcbOZ49QxslGagXyn66LLUJZFclp0MTsVDSnYP/EVHdx/ldzljvH+tp8HkQnQUb5wfcxHafMdYqxJAER3jFIyKpb5P7aY45WFSZ2SCXlfnPxDStT+Cwu6IIceJClop4QC7otUQRFNYh9wlguhCbjCmKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mYi0VXNU; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30737db1ab1so33296411fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 07:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739721430; x=1740326230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uON2OJ+BM51lgivoMfk6BEzdZTXpCqG8oP8y5MgbvY=;
        b=mYi0VXNUUT2yyERqo2ievXsdOyEkcZrUi3oZQuaoYptbaNk8kz0G4ot940sLMub6It
         tkqzXGoxyKo+7cyB15sF2PzuXFnVpAKBCynur2a8wrMS8SPsS9Na3z5D6T36iPApT5Aw
         ud6xW+cQPpDdJV3ApZWbZzhVL+xQuTemlZvzc0FC9qfEU0Oqu9Au5FwoGITOnQnKSunZ
         ZN1qyT/edQcbK+AQh4BdVQIHSWf2gVvCkD85VMzAQJ+OZkAQZnAai7MUZAJfeuRIKXjN
         IoPlC+v1IZKpQ1gsY+al4yXUhxUKWcnEdV/F4XPUf1ltg08uyxEwdrT102LbfH7l+rr1
         Sazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739721430; x=1740326230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uON2OJ+BM51lgivoMfk6BEzdZTXpCqG8oP8y5MgbvY=;
        b=DuNfMKAqk3SohkWAhe4Xh+GtkRWKF+W717av8J6aLhW+MYDaqlFY8msty1rMASMXmG
         lBmFXdTaLKucJeD0s8ELN3w0jV/h3nRHBsBdRVyniUvhkRhMlZOy8u7ODtYOmEp/P+sX
         1iz/tk0WOLnMqvrLbooee9NV9Flc3W51hT451yPX1WsMGk4Ivn6auvAIf/AHRBt6gI+L
         cFepBAmIOyObjnwc+eyTFNRBPBgZvy6/9WwlNewi7+Zi6TgKJkawli/MMipUonzw5Ol9
         sxh5247DGJDeYPoEFXVrUgPEzv+8R8reW+6ndHymLj/98NZU0lxINkSu99gcxixi27At
         xdbw==
X-Forwarded-Encrypted: i=1; AJvYcCWpDKFB8rzNda0NscPghq9lehm8oqe1KxrRbUqR2h/wbfsPgAgL2ah2xminw4SMmjJsxRtUYJg4IfyrHa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqjNlPet4+gNB8qGGpVJELNsLDHQKlnTMMeUJW4WypoUopr/Se
	nAjZMkHUNbibyXoxbJhFRRHfbdiWOKKDIF/73GjHq4pv7f7Y5THSVUhESRBBfZcFVgq/P1pGMWz
	BAHfyAe26pabXFOUxG7vi0VZqenIDglEBi7Ss7QZxK0bhSeDtOsM=
X-Gm-Gg: ASbGncuexWnj5NMTUhQTg5Vk+eHMc8wCUT8TW5wMY1Zwamg3zrK/2rGf3uK9mlf38Cg
	TvhrYGN2fuTlrUoHEeQ/pZhgoeR41LeMnSc+XM2N8MVBCXEjOfbAVsNy5Dqua6ANI4UNGvizY/U
	9YQ+OJ5TPI6bSppjHvCy7cHnMtEr7d
X-Google-Smtp-Source: AGHT+IFnLYCD9csXnL9Y/rkrv113y+IUlVb8uCQiU0GVnVKQINrFh9e8xERSxJoDVXjG8qI9A/OMS6PHaDmzWreXz9Y=
X-Received: by 2002:a2e:9209:0:b0:308:eb34:101f with SMTP id
 38308e7fff4ca-30927a59cfbmr15214491fa.8.1739721430120; Sun, 16 Feb 2025
 07:57:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216125816.14430-1-koichiro.den@canonical.com>
In-Reply-To: <20250216125816.14430-1-koichiro.den@canonical.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sun, 16 Feb 2025 16:56:59 +0100
X-Gm-Features: AWEUYZml4BGUjHbzJW87WYTjgi7p1q0pUmUHCj6hJQULWzvmzQJKgFqCjeyjVlc
Message-ID: <CAMRc=Mef-cg_xt_+mEAyxY_9RfK4=qWEbt_GebeT2mu_8GWVxw@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] Introduce configfs-based interface for gpio-aggregator
To: Koichiro Den <koichiro.den@canonical.com>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 1:58=E2=80=AFPM Koichiro Den <koichiro.den@canonica=
l.com> wrote:
>
> This patch series introduces a configfs-based interface to gpio-aggregato=
r
> to address limitations in the existing 'new_device' interface.
>
> The existing 'new_device' interface has several limitations:
>
>   Issue#1. No way to determine when GPIO aggregator creation is complete.
>   Issue#2. No way to retrieve errors when creating a GPIO aggregator.
>   Issue#3. No way to trace a GPIO line of an aggregator back to its
>            corresponding physical device.
>   Issue#4. The 'new_device' echo does not indicate which virtual
>            gpiochip<N> was created.
>   Issue#5. No way to assign names to GPIO lines exported through an
>            aggregator.
>
> Although Issue#1 to #3 could technically be resolved easily without
> configfs, using configfs offers a streamlined, modern, and extensible
> approach, especially since gpio-sim and gpio-virtuser already utilize
> configfs.
>
> This v3 patch series includes 13 patches:
>
>   Patch#1-7: Prepare for Patch#8
>              * #1: Prepare for the following patches.
>              * #2: Fix an issue that was spotted during v3 preparation.
>              * #3: Add gpio-pseudo.[ch] to reduce code duplications.
>              * #4: Update gpio-sim to use gpio-pseudo.[ch].
>              * #5: Update gpio-virtuser to use gpio-pseudo.[ch].
>              * #6: Update gpio-aggregator to use gpio-pseudo.[ch].
>              * #7: Add aggr_alloc() to reduce code duplication.

Please don't ram this new functionality into an unrelated series.
Split it into the gpio-pseudo code, factoring out common parts and
converting existing drivers, then send the aggregator series saying it
depends on the former. Otherwise it gets way too complex to review.

Bartosz

