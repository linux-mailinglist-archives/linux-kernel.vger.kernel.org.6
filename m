Return-Path: <linux-kernel+bounces-522366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D611DA3C934
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952C83AD400
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6173022CBCC;
	Wed, 19 Feb 2025 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrZ56eJy"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9B41ADC86
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739994878; cv=none; b=UDy5pqo4a803SgBM8xceR41xTsnWKLvwguPJAcX+WQ/EVAIYAex+94VC0OqUdZYRwv7d8g6fNDALO8IbnS0tomMP7p2WwWKh2jINWNhDAvLLs0QIYPs3DINP57kSQ8mSHHjo4hOdnCnwpqABW1oJVxB4hWgOEtYpX0VQ9SQBTnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739994878; c=relaxed/simple;
	bh=Wz0U3ZtBYTySNwP+IIvNVqpwR4ulbgIVF5PMZCS0CO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcbJTqLfEnc3sBoUJsvDnTxv03VXVpU6WZOPZ6HlaawV36jToDOAZJ+T9QStewcF/NJa4ya75koGQBd0cWSUrD3AXvIUhmmcTiRwfWtTk3WuFtf8CGCT1eeDFt2XzhhJf6Y9GM3ZKwKW3otu9GDATvmO2ol7E5o5cZqPoU3/j+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrZ56eJy; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaeec07b705so32862366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739994875; x=1740599675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0piozqjKNmwX95ZiHGkWqHZE7eTFjlTdELGu/nNTkY=;
        b=mrZ56eJyinrTgYsV9Gq7R10Pt8b7+WsJ9I5arxYOimDOTPwOFOdsqKLOwQDSxX4Zpt
         t/VLBgqarQuYy537oXMQkZyHNo/j6MJ85mwS7DN8HBBp2Dv+fpyrzjJUKKbUF6HhqdW3
         wBHQiCaFhf1ccIea+rn+iIp4EsmqwgR5dnm/2Z8Z9CVLvK9Pt4r16UiX5c3A8+YquqLO
         Cx0riAR1hRZmG8W/CGB6LU86ZJ2gtegn/DewrjVbxa6IS8+ZlIRMI8GVCdyVIDdH+sjm
         LVLYbER19gPNwmWvot30nXXOLWzrG45tRC+Ca8BW1kgcroyzaemjTcMkLq2Ns8yHZa/X
         lVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739994875; x=1740599675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0piozqjKNmwX95ZiHGkWqHZE7eTFjlTdELGu/nNTkY=;
        b=EAo/nCvEj/jmhuoSnmuOWL0fAfhFmekRMdu2qTwvOnn8qfjS7YcoK/uMwzI10bYujH
         RtoxWDxaM+yL4H0hywo9C+1GJTdfNPyu8FuzaMnr+HoXtmDIJgvaZqJMCpEF4IFIP7HE
         uMQoRFggUjBmMQkJTDO6E02AqU2dF/XPWd3XecCwUrrYMaXFAG69AlZcAU9xZcdMAFa8
         P5gqPCnGGV5e0QUPhZLhy92pbSeezTRPtVAgEOvJlE8hNdVo5VANiKo9GXxJoMWlAz6i
         heryPqRb5xruWIbB+qsmsoLKKaLh9lBkjHH28XmMQ737g+UbxQadv5rrwhC1ndq9Hd6E
         xFBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/IUn1MV9gawAeRSEXUYvEbRWi5rXn3b5dbMklXozm6EaBb/vlk2ADPnyEnoXyLkoPj0zyz+Q4CSsQV9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9zc+1YrMrqKRdngh5QucG9JRS9ZyuMl5TnvLU3NSMiS8QR+L4
	ycWLmUcZhxSL2FXux2LG53na8tiKp1rzklGSMa9OFwMTaOyfmROjmtzl+01+NQjfZoviuX9KMTY
	/xImQJXekCZkY8zNmoEuC+pWGLIJ+33qu
X-Gm-Gg: ASbGncv2IqBTsTSkhd30Z99SyTl+FbSSxhzvqThmQB5uaW+jXglVHF+djZsVieJZpV3
	JJ/PtaW1AghlmMCjrchLEIi/tAczGnFqNo3WT5NXvkw4vs861ZHKtkuQeQ8tFB+VMAEEpHqWk
X-Google-Smtp-Source: AGHT+IGqJA7F1gVwPLyvrA73gx7KdY7bnF/veusX5P/zOTDYffEaC5SPqk1rFYNp2kBgrvnA9O63LcpbjjAb51wO2bc=
X-Received: by 2002:a17:906:f5a8:b0:abb:b322:2b37 with SMTP id
 a640c23a62f3a-abbb3222d4cmr926623466b.7.1739994875058; Wed, 19 Feb 2025
 11:54:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cfc1b534f7f8953351614e6120103a866f732f3f.1739984661.git.geert@linux-m68k.org>
In-Reply-To: <cfc1b534f7f8953351614e6120103a866f732f3f.1739984661.git.geert@linux-m68k.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 19 Feb 2025 21:53:58 +0200
X-Gm-Features: AWEUYZm6GhbGL98exJ6Skr7PdpbpMTailI3S4xJYjcHNzuV8fv5_07H0kV_OiWg
Message-ID: <CAHp75VdYRKacUyCWXooXbiKUraA8iXtoqj-TqKzGCFRe0jv9wQ@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: MAX6959 should select BITREVERSE
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 7:06=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> If CONFIG_BITREVERSE is not enabled:
>
>     max6959.c:(.text+0x92): undefined reference to `byte_rev_table'

Thanks for the fix patch!

> While at it, sort the existing selects alphabetically

In general it seems okay when headers are all generic, but...

...

>  config MAX6959
>         tristate "Maxim MAX6958/6959 7-segment LED controller"
>         depends on I2C
> -       select REGMAP_I2C
> +       select BITREVERSE
>         select LINEDISP
> +       select REGMAP_I2C

...

In this case I prefer to have them kinda grouped, so generic go first
and the subsystem related follows, something like just putting the
BITREVERSE selection before the REGMAP_I2C. With this you don't even
need to add a paragraph to the commit message.

--=20
With Best Regards,
Andy Shevchenko

