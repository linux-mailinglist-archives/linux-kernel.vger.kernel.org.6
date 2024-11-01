Return-Path: <linux-kernel+bounces-392120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583D79B8FEC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165F8282E3E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCD817C7BD;
	Fri,  1 Nov 2024 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xy7LavfM"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEDA15855D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730459093; cv=none; b=Tq7pYWLqWMNaAWXXCNgx6cRcBXzr8JLLy4lupFqVO1ZrED3wzw208lPQff+44BYdl4+FaVTKcuI1fn4qAtBMjcUYY1yLNSXXK9FGwXRUk+vhgDSAc4I+o2HJLRUUYUVNjn3ja+3NUHAN+I8ISjDL36yxExrMAlmVhwvWv8mYTN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730459093; c=relaxed/simple;
	bh=omwNnWjrnHsokRVJxkjx6MXugKu+P+wlf/4zL6qAxa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAM0XfEnSZERTcYgF7Shz3Pj6AYygkxb6KRn5TGFwUes0jMSx8ysCynDBs5rK+FCzm55EpKFyKU9s/hW7lJbLZ4N9juHkmG6gM8tKxpHruh5fV4LSacrpy7I8k2koNmhY5aCTl9jltJ/kP213Up+BD2937lLqIVwQu1zynzBLC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xy7LavfM; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ea07d119b7so16151297b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 04:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730459090; x=1731063890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcyVnre0jfOXE57f1aZ6yOpuSdrWU3Uetk6AKG4MKck=;
        b=xy7LavfMncSilze0ZSbiCXxNzhz8AWiqBHrzWnOrY1LE5oByfjQrNpRytDM56CG7/E
         YvV6J6sofUq5fEY9uYgWaZYqx4iJckhU6zHXJCmFGJuwRXuRrDVr3W2Efy5vUmpJSi3m
         t2ColRg2kUjLNqo2yh2Iu/SNaMcU3R7NHLyCyaWh/72/QJ0yod1zdDLiCo31Fj5QUbgy
         qShXFxjwSELHw9m2AubiS8sOOajsbFLvswz8mo/UbiWZuy5k19Sbhal9Xj++JIrQrcpJ
         WuU+Z9kTTDgJ3BzaHcO5zcsGYe+QzPkPM5qOSaxxGPte5JZ5MDM+CIhIZcwNRJB4Idlt
         kV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730459090; x=1731063890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcyVnre0jfOXE57f1aZ6yOpuSdrWU3Uetk6AKG4MKck=;
        b=uhcvh5DkeIfKG8Ypf9tAqbIppP/0TRej/uRcet6x/eOy/akexJ5CXAp1kGP7rahh9d
         107JB74DDz1c8WT9uMUrE/MqMbHhJF+YiAt1LZx4WG7wN5Ji09Yow6KDcYphIDKuzbnv
         0IQAlsA5gkhZZWOpXCl/Rk0OqsfL0n83Aokx9UTqL1mjiY8OB/E7P056WJuSEik01RFL
         P4ZWcnIsSzkPL1Xl8rxVZPQSsN1eWq3otaosR4cc6Q/oQr65YyVAiegxWq4T74oLclt8
         8DzanNSrErsibxBzpw44oPmJXcow9qC4AN4MYBUWgMi1Y1go9eoC7DhjgpvnTI9+kpcj
         MRhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjRpBm5SvkubUyE/uVsWyEhWQkY0CdZuaJlz4r1SuzGM7EAxLolPjCCA8RadxbgRpJroESX44fEC8XmKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZXQSzGtlAhCDhTv0cZaE9p10C0IUqclAIWjD1RljbKnYd0MO8
	ULYlXfmJ9vT/PLpVvSpXh78VTRAB+SfFjDro58UNTP7+fo5RKdPLgiy89gQABbeAtKvL5cIMyaK
	7fpDvBHeFH5sPPnuXY8vnxtMIwAVLaGvgFrk3nw==
X-Google-Smtp-Source: AGHT+IEm0w4Bc6bpa9fFzIh7gFznHA6TyOg1AJUMCvNz0eEXmCXuB9jRIMZyo30oCm1/Jxs53bamqXzVvH4THAHgov4=
X-Received: by 2002:a05:690c:7289:b0:6e5:a78c:5795 with SMTP id
 00721157ae682-6ea3b9a5f4dmr86832957b3.43.1730459089626; Fri, 01 Nov 2024
 04:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912152538.1.I858c2a0bf83606c8b59ba1ab6944978a398d2ac5@changeid>
 <4920950.GXAFRqVoOG@diego> <CAPDyKFosf_+m9j8YgHa-PsC2SV8+Aou2O6bTbMfzGBpQ2sY8YA@mail.gmail.com>
 <69d06c04-cc8c-4435-a622-33d5dcd1fa24@arm.com> <CAPDyKFoU=AoQqXov_-qFo8xjEbiDAk9mtTtCR9HAYz_gg-bnzQ@mail.gmail.com>
 <eb96b240-f3ee-4057-b016-c746d48cc1b4@rock-chips.com>
In-Reply-To: <eb96b240-f3ee-4057-b016-c746d48cc1b4@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 1 Nov 2024 12:04:13 +0100
Message-ID: <CAPDyKFonhL3JwN1TDrXW-0=VgZowBqTpHsi99GSRmW+aN+4ELQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: rockchip: Keep controller working for card detect
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Robin Murphy <robin.murphy@arm.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	linux-rockchip@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Nov 2024 at 08:59, Kever Yang <kever.yang@rock-chips.com> wrote:
>
> Hi Ulf, Robin, Heiko,
>
> On 2024/10/7 17:49, Ulf Hansson wrote:
> > On Fri, 4 Oct 2024 at 19:34, Robin Murphy <robin.murphy@arm.com> wrote:
> >> On 02/10/2024 10:55 pm, Ulf Hansson wrote:
> >>> On Sat, 14 Sept 2024 at 13:52, Heiko St=C3=BCbner <heiko@sntech.de> w=
rote:
> >>>> Am Donnerstag, 12. September 2024, 09:26:14 CEST schrieb Kever Yang:
> >>>>> In order to make the SD card hotplug working we need the card detec=
t
> >>>>> function logic inside the controller always working. The runtime PM=
 will
> >>>>> gate the clock and the power domain, which stops controller working=
 when
> >>>>> no data transfer happen.
> >>>>>
> >>>>> So lets skip enable runtime PM when the card needs to detected by t=
he
> >>>>> controller and the card is removable.
> >>>>>
> >>>>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> >>>> So for the change itself this looks good, i.e. it fixes an issue for=
 baords relying
> >>>> on the on-chip-card-detect.
> >>>>
> >>>>
> >>>> But for boards doing that, the controller will be running _all the t=
ime_
> >>>> even if there is never any card inserted.
> >>>>
> >>>> So relying on the on-soc card-detect will effectively increase the p=
ower-
> >>>> consumption of the board - even it it'll never use any sd-card?
> Yes, this is how the controller works, the controller needs the clock to
> make the detect logic work.
> If we use gpio to implement this card-detect, it works because the GPIO
> controller/clock keeps working.

Right. On embedded battery driven platforms it's quite common that
there is some always-on logic (maybe via a PMIC) that helps to take
care of these GPIO irqs.

> For the dw_mmc driver support, we should support both kind of implement
> due to the controller has this function,
> so this patch is for the card-detect implement by the dwmmc controller,
> the controller need to keep working
> - only for sd-card (so not include the "non-removable " device)
> - also not disable rpm when "cd-gpios" is used.
>
> For the power consumption, I believe it will increase, but very very
> small, we can't even monitor the change

Right, that may be perfectly correct on the platform you are using. On
others it may not.

In general, it's a bad idea to keep devices runtime resumed, unless we
really have too. In particular when the are shared power-rails being
managed by a power-domain, for example.

> if we use the normal equipment. The driver should make function works
> first, and then consider the power.
>
> This patch is to make the dwmmc function works without gpio's help in
> dwmmc driver,
>   and has no affect to the gpio option, people still able to use gpio to
> do the cd.
>

I understand and you certainly have a point.

However, it sounds like you think there is a drawback involved to use
MMC_CAP_NEEDS_POLL in this case? In that case, can you please
elaborate why preventing runtime suspend would be better?

[...]

Kind regards
Uffe

