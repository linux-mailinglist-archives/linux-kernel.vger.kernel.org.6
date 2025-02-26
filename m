Return-Path: <linux-kernel+bounces-533532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E791A45BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F4F37A334F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AFF2459E7;
	Wed, 26 Feb 2025 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yBridAji"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A7019CC11
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565747; cv=none; b=XStxTgUgRsQeRiTh+Dt0Sxu5oZ1ksSYXes1ZgcPJZgPfOJmKkDWW5TIgdQeyTy/Jq7GK1zQ8j8ppTWX4xLNp2ELpEfIqpdIatMfm/EjUaTk+GyW5ta7jMP0HPnEbrEFsrbT54iXKC28Na25ze3Iu9fErdEH+zDeZYFC3bZjTlWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565747; c=relaxed/simple;
	bh=jd6d/YrQJp7u3Y35vAF2ccKmJq+B0QJtfHp4EK5whA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffMCu3AXzfqoTWgQTxGT8z1qgasXhSR9Soz/tlceIWbvvv/xWkvR7innImxJZVqFur09jpR91fJaVD/8urCBMbXTTwT4vfAnUI0sW3Ttzhr+IhiYrckSdO2/648VBgM2FvN3DN685LLHpt4uetuJZ7MRD39etXke2q9Uhvu3cBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yBridAji; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30a303a656aso69385551fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740565744; x=1741170544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jd6d/YrQJp7u3Y35vAF2ccKmJq+B0QJtfHp4EK5whA8=;
        b=yBridAjiaILeMGd5v9MnMGozwOkxf3NcMPkpgosgBDi7C/oU3htIPLR4LXK2C9OLjh
         WOODerMRvsC5QmvKhUbDLBQGmLQ+OMPpL930iZg/DdLAxiSh8koQT/Vcz5Qn2WYZ1SWs
         d/7Dc/aECZIvNk2ZHIDCHoIMUtINilP22BKVqDbTtFDn4RCg4RvMV38olNUu2Xw6mA69
         Msuh6boaw80Rtsqw2yex/z2hlrUFyiJtBdJgUMevSbWlYHOfBF9Mni4ujNB85S8duX87
         GnLnMJ49wy3/TRUAdKOJvSVDc9AN/bxb0N9Uzx+XorfZUTTGjbA8tsvmYYHaTqTkwUmw
         0xYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740565744; x=1741170544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jd6d/YrQJp7u3Y35vAF2ccKmJq+B0QJtfHp4EK5whA8=;
        b=mDC8gqSnqjYkdes43DoCvUk1pPR1wbuSFG+8UpNbS4kVJGKxClKJl55Q7PZrW+FDyz
         yajo8pDqvMWlEL7d15LKMryjGn1aoHq29eV2GK+lpGS6abGnGJXrR8aj5bkUE3b32/D/
         6GbdZLv9UztcoGA6ZoxPM4qpd8H3SvoaBN4BUysu3DrflNx/pQi9x0M+5l9Tl0Hz7nmD
         dQvoT8fxLh14Sxm739TEACz4z5A4rh2I1BgXSVW2YFrOVXtCzHNzhrFI6s0IZTRy7A+P
         i3DFmgLyyuxcAOB3+BJgsRCfkV5tQ5RijKUHruOpXhnrUmDEckd2vhxjvc9scCJEabHF
         Imhw==
X-Forwarded-Encrypted: i=1; AJvYcCWLcgZxPNnV1EThgvr64iMUTqBgQrgxFACw4EOwMdClZ1/zTDiATcbwgzUApcERmJHaYMa0g9eNWn9ZHrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YylNKjyIuxGTnImK4K+jbTfeew57I0HN+EOI441ezSjTVtESw3b
	/HPRXsEMDzRzGDqtjezNQNoKfZTzEH5rIYXwK1DfXmOXTHlejnkU1+yPobVDw1fOIACVhDpGOjV
	MK4Db5fiAbmOmMzoNRdhiZzlHs/g2xVRthIUfqmaB/vq4Y20Q6pI=
X-Gm-Gg: ASbGncs5eOxI7fQW95MeKidJOJk6p/epGCCbYfvlBcwZYsxVyHCF3YPWnJ/JwwfTR7N
	/MArosXfYU3vZwzQQRRVJKNlIovlu1q83czNuhWIX0AvnUBIQ0PE8hflPTqjs5XbAn+Edq9y3J/
	N04IXUUhepS4+bp9pVhS8sLyisdvsnI5zWMv5P
X-Google-Smtp-Source: AGHT+IHHpGE08k0eF3GlP5E4RiiF0DoICSftFLqWpeYwYEYJllw2uhxtszoAU4mx0vs+6OEdCixULAjPR4Rd+B9jS3o=
X-Received: by 2002:a2e:98cb:0:b0:308:e803:118e with SMTP id
 38308e7fff4ca-30a5af477d0mr82028861fa.0.1740565744057; Wed, 26 Feb 2025
 02:29:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223121931.579031-1-salah.triki@gmail.com>
In-Reply-To: <20250223121931.579031-1-salah.triki@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 26 Feb 2025 11:28:52 +0100
X-Gm-Features: AQ5f1Jo2WoZUN5CqFOCb6NBQfPETkTmOZejfsXHK-3TG35mQ7MQv0u6erKTTILU
Message-ID: <CAMRc=Mdn1NNKz+2-aA6qCcu=TMDvD8KcbWYgryhi6XDk72Zd1g@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-stmpe: Use str_hi_lo() helper in stmpe_dbg_show_one()
To: Salah Triki <salah.triki@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-gpio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 1:35=E2=80=AFPM Salah Triki <salah.triki@gmail.com>=
 wrote:
>
> Remove hard-coded strings by using str_hi_lo() helper function.
>
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---

This no longer applies, can you resend it rebased on top of current
gpio/for-next?

Bart

