Return-Path: <linux-kernel+bounces-431206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5129E3A64
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2582814E9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526601B85CA;
	Wed,  4 Dec 2024 12:53:15 +0000 (UTC)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50532500CE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316794; cv=none; b=atvE0VzqZ0JqnXo1cebNJh9i3N0cd3moY3HmsEcLZauRSopL8mP+9He/qGdWl/OHY+TGqRzVi6nA6ONdo8TMfg3fKicp5IxNRj+wnKZfzdqySxlmAITsr+ZsxTwtiS2n97vH5ycYKe6seqe/rv2cjE9vLX1P84GvR+oAyy4RbcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316794; c=relaxed/simple;
	bh=KFnSN5N8HT29+qUewHC1kbuEyY4uCVZnC1sN8PKA5zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJ+bAD85/QM7gqg+zhd98HDLEwM/jw8dGO5VOIBVg3mObgCDSoDu1VDkhh09Ns/X8Cctes9U2t4i1ihNxXPYvNRJgExIfnQGaP6vl8EU+bQwvfDlavyhR/3nHhTv1+ndN/LhnGhzWjsgyzQf+Ivi0JmxNoviQx/3qZG4l7SA49M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-85b9c456f46so1017662241.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 04:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316790; x=1733921590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzDCGD4SLdUjf2dbvX16BAtOOUIglWd8GVPh8bfgqNw=;
        b=CdU/tdl89oTSYN+eA3Ldt+X27gAM5GLt5P264NL80AeJrb6ailbAL2uWNi7g4+CXAy
         XNHXCuM85Ol+f5ihiAkuK+ei4T32f3Okylpp9x1xQOheGIBoQRrEz8Q5Z/gMTRHa3SM5
         6CJRe3Uh/8Rbo/mK5ICwe74OZ+9EoSDr7bfxeg34iWDGU50PWAUz5SoLXFgDtLw3aslH
         AZhNI+PM4LMFkGPOdx4TSLEIJWcT09//0WyZ6/m8TzLqID4Zx32N52F4MO6W7F5LPL5r
         W/6FqhAlSt452r7DnvPkoJlk3U+YEdQOJ2Mk2NY1Lc4U8vwuJIHfuliuznUftAesvQ7R
         D2dw==
X-Forwarded-Encrypted: i=1; AJvYcCUvfXlObu3rb2IHvPFBz4ZDDyFQSrKG28hhnnJmKQIcDQ6EzORjnZzz625eqJayX19Hf8U9OSZjf5N7D1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg8LeRUOxEj5OyS1LwLxkUvkVo8y1/CgEG4ugkVXH9bD+ozdbj
	ogA7AIQqfkMB2nKMktLTl6w+Ee7XqZw6ClIINtPDwxZwCAMKa5KWz31NjRsQ
X-Gm-Gg: ASbGncunweMA7JQiUtq+FiRckhBYK95zwYih9xs9HuEXpS/EKdsTAHimqsNtDC2BYW6
	MPcQehxhKkc63y0QkhDfoBBGKnfNa9OUsbt2211fFxrVp7SyxnkasVvm1nkhliW4ocKykaCcA8P
	sgYH9I+pGCH28r2yA4ziALjPExH8zvOiTWILDwO4ThP0ud/zcJKxGwH6NKEcGOY8jsmzSdofd83
	X7HpBCGBcNjeifZqLZD8jN/jiznNP8N8AcvS8oOST4LuG9ch5W4lnNOzwkscoYr2q0UZG6PNgKe
	cJIXOcs+VPFF
X-Google-Smtp-Source: AGHT+IHZOgPjWwgnMRxL7mLzeqJHH1wBhAsGVYxtlpzY0gQMXOmVUw0xxgKBdVgCr62kR7/L2HDTBQ==
X-Received: by 2002:a05:6102:e09:b0:4af:4a0b:44f0 with SMTP id ada2fe7eead31-4af9735eb34mr8143121137.18.1733316789776;
        Wed, 04 Dec 2024 04:53:09 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4afb243e774sm76145137.23.2024.12.04.04.53.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:53:08 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-85bd102cd98so794214241.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 04:53:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXK0UdjHsMpNahgauaxT6CU78Gc1fwao23CD5wrNf9MUDFxYUOvSH0hl5YBVpPFY8Rat8mzHm//1/qpsd8=@vger.kernel.org
X-Received: by 2002:a05:6102:5088:b0:4af:49cc:7515 with SMTP id
 ada2fe7eead31-4af97234bf6mr8656420137.7.1733316788625; Wed, 04 Dec 2024
 04:53:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030171009.1853340-1-saravanak@google.com> <20241204124826.2e055091@booty>
In-Reply-To: <20241204124826.2e055091@booty>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Dec 2024 13:52:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWaBn9PuEqiH2dekDzOLXeqn1KTT_x3qq7Zk_KUxg2qeQ@mail.gmail.com>
Message-ID: <CAMuHMdWaBn9PuEqiH2dekDzOLXeqn1KTT_x3qq7Zk_KUxg2qeQ@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: fw_devlink: Stop trying to optimize cycle
 detection logic
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Francesco <francesco.dolcini@toradex.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Conor Dooley <conor@kernel.org>, 
	=?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luca,

On Wed, Dec 4, 2024 at 12:48=E2=80=AFPM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
> On Wed, 30 Oct 2024 10:10:07 -0700
> Saravana Kannan <saravanak@google.com> wrote:
>
> > In attempting to optimize fw_devlink runtime, I introduced numerous cyc=
le
> > detection bugs by foregoing cycle detection logic under specific
> > conditions. Each fix has further narrowed the conditions for optimizati=
on.
> >
> > It's time to give up on these optimization attempts and just run the cy=
cle
> > detection logic every time fw_devlink tries to create a device link.
> >
> > The specific bug report that triggered this fix involved a supplier fwn=
ode
> > that never gets a device created for it. Instead, the supplier fwnode i=
s
> > represented by the device that corresponds to an ancestor fwnode.
> >
> > In this case, fw_devlink didn't do any cycle detection because the cycl=
e
> > detection logic is only run when a device link is created between the
> > devices that correspond to the actual consumer and supplier fwnodes.
> >
> > With this change, fw_devlink will run cycle detection logic even when
> > creating SYNC_STATE_ONLY proxy device links from a device that is an
> > ancestor of a consumer fwnode.
> >
> > Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > Closes: https://lore.kernel.org/all/1a1ab663-d068-40fb-8c94-f0715403d27=
6@ideasonboard.com/
> > Fixes: 6442d79d880c ("driver core: fw_devlink: Improve detection of ove=
rlapping cycles")
> > Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> After rebasing my work for the hotplug connector driver using device
> tree overlays [0] on v6.13-rc1 I started getting these OF errors on
> overlay removal:
>
> OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/o=
f_node_put() unbalanced - destroy cset entry: attach overlay node /addon-co=
nnector/devices/panel-dsi-lvds
> OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/o=
f_node_put() unbalanced - destroy cset entry: attach overlay node /addon-co=
nnector/devices/backlight-addon
> OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/o=
f_node_put() unbalanced - destroy cset entry: attach overlay node /addon-co=
nnector/devices/battery-charger
> OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/o=
f_node_put() unbalanced - destroy cset entry: attach overlay node /addon-co=
nnector/devices/regulator-addon-5v0-sys
> OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/o=
f_node_put() unbalanced - destroy cset entry: attach overlay node /addon-co=
nnector/devices/regulator-addon-3v3-sys
>
> ...and many more. Exactly one per each device in the overlay 'devices'
> node, each implemented by a platform driver.

FTR, I am not seeing that when loading/removing
r8a77990-ebisu-cn41-msiof0-25lc040.dtso
https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/c=
ommit/?h=3Dtopic/renesas-overlays&id=3Ddd998e8db58b67744eb91f11f13544401c97=
5470

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

