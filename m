Return-Path: <linux-kernel+bounces-546228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC43A4F80D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5D1188A8E0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714861F3FF8;
	Wed,  5 Mar 2025 07:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BLnx6i7j"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258481EEA5D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741160441; cv=none; b=chSWsYFchdncUoT/82LlBk/GCKVx6DY4LvpPjYWUTfn64XtmIRHANAt2SYrjFBr3J5JE6p6AkHXledpXTQGzG+kIPjxvzbHi8Zjc6ZSD3JG1lIeB29H+cPRbm1uKiavGli1eUgMqoDlNgE8OefT+tDH4OZV9wW0vm2lwlB65UCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741160441; c=relaxed/simple;
	bh=VDTDjXL2VmXwu5SJw3B4Qg8I7zdkWtnn7A7EnShICWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmyxZ09nTNvdx3TxZnN1gT/IVUOhkfDUUkzGYMcAIRmFOE5T+oV1+bbsau2707K0R2W1SEEVyDDCOh6uPFhA0P8797xqMvswj5PONrzZMeibai8h6vJUuFQcK5LDlyNPNZrPPoZUPTN7pEPoZdF3nytS2SRpP6YCWFx7LV9eX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BLnx6i7j; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-307bc125e2eso71985451fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 23:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741160438; x=1741765238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDTDjXL2VmXwu5SJw3B4Qg8I7zdkWtnn7A7EnShICWQ=;
        b=BLnx6i7jGlmHnQuSbg0Mesv+Qbc8vu8kKur26c+UmhcRUaUE+QUMmkgjqK8DcpidNS
         HkqZFwSXw+C55RUszX46OC9J441awi6L/Q1nYtsOZyIrWrgeKirkAID34j0CNvGLfgKf
         HNDXzKSiSWM1NtbfliWcUqWpEHkobfPIOoO6f5AJ1UCv3VefQ2A/3I5wo74Dmvgz8z6c
         nMMHIAbiwX+7w0DZi/WitzGmg7Z6XRr1640lUjZFI3UkQFxRQQ8Gnf1RRF65YBb+eObP
         Ui5UZeL7982Ub01JPiX0MyohOuKLYIayN9gixaH8LQhYaWif//IkH4lfEf1SDby9Luy2
         B2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741160438; x=1741765238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDTDjXL2VmXwu5SJw3B4Qg8I7zdkWtnn7A7EnShICWQ=;
        b=aDGS+QZeRk5j8RbJV+l+hkfpwh++JIwIwtSi56mAqn2xdLi8w1xnLnGtAW4+NFBfAg
         M4D8uv7g1x3PsX8yKC6UD9gRoC/ITTcNPtA1aMNCiY24WHjnC7hz87CdP1xWISViTjTF
         8C5AKbDqtrfMCi0g21h4k9bi5FRS6SM82lx9RFZhgeaajiD/T8iAvWn71lslHhpZNnna
         k+PyfWlFGGreURND1nSfc4HKW9bwP26uky9PvQ5WdZxAgT6WBgJfSKqbVY0N6QdJgh2m
         kpxs3KCdSjFprn0YaDfjXjyO3vVWIVuvjpf7UW64ZfPj/wpgijBIXuMTDs6jKY8lZfVT
         NkNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmtQ3rYjHx2qDIP15GxrB61zJHV/ZzE6CJW9xg9qxm750m82XLXaxnvlUoZ7C97Vf+m3a53vDSiMRifKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZao/d/Cr9nNL25zJfm/BwZ0JDygavX+ExT+6zWOBR2BlNArmL
	5ejtgdNivmO01wufOiWem6KHGEXALt1VigMmFwwwPuVujn6E94LYCVPcuv1YrQa2TM3h1kGRnrJ
	1seBbQywLIahDqRT8q+BaIHvIV0cor857ZMubJg==
X-Gm-Gg: ASbGncueIYb2MatnqBH+eisbWmfRqmW6MVv4Yv6jgAvW7WkTRd9LkJ6DEWQq6UCt+OM
	f0n4w5mbRWFAQ3cOZdu3Dqgtu0cR5izSVIB2D+LiKgQzHMMo/6SkprVSd1uMOqyU6/r9y31rxEg
	/1itUI3QQL95bkeZODTs8GcYxF+A==
X-Google-Smtp-Source: AGHT+IGcwWgEry+6tzHBD+mNnxIVE6sKBlzFgi1RRA6m0uvCysoF6DsDJJB/fX8qwDEYMA9UPY6ZXQV3WzLO+Ixih90=
X-Received: by 2002:a05:651c:556:b0:30b:d44d:e76a with SMTP id
 38308e7fff4ca-30bd7acab1bmr7711201fa.25.1741160438099; Tue, 04 Mar 2025
 23:40:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303164928.1466246-1-andriy.shevchenko@linux.intel.com>
 <20250303164928.1466246-4-andriy.shevchenko@linux.intel.com>
 <CACRpkdbCfhqRGOGrCgP-e3AnK_tmHX+eUpZKjitbfemzAXCcWg@mail.gmail.com>
 <Z8YThNku95-oPPNB@surfacebook.localdomain> <CACRpkdbqYoY1vYGii1SyPL1mkULGXYX7vFwu+U9u2w9--EYAsQ@mail.gmail.com>
 <Z8bgYFUds3UU96Mo@smile.fi.intel.com>
In-Reply-To: <Z8bgYFUds3UU96Mo@smile.fi.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 5 Mar 2025 08:40:27 +0100
X-Gm-Features: AQ5f1JqBv5lkq_yKaz9gG-53y85X9EsVUbvHy0t75prGe4GI8Z-EcKjHUiR6o4k
Message-ID: <CACRpkdYCxPjF2E-jd1OkdYawYJLnFfHUDSL737sr_Zkjz9gVkQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] ieee802154: ca8210: Switch to using gpiod API
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 12:13=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Mar 04, 2025 at 01:03:41AM +0100, Linus Walleij wrote:
> > On Mon, Mar 3, 2025 at 9:39=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >
> > > > Maybe add a comment in the code that this is wrong and the
> > > > driver and DTS files should be fixed.
> > >
> > > Or maybe fix in the driver and schema and add a quirk to gpiolib-of.c=
?
> >
> > Even better!
>
> I am about to send a v3, I'm going to leave your tag despite a few change=
s as
> discussed. I hope this is okay with you.

Of course!

Linus Walleij

