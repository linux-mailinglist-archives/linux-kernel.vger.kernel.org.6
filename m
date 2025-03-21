Return-Path: <linux-kernel+bounces-571144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA6EA6B9BD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BAA3B9808
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE73C2206A3;
	Fri, 21 Mar 2025 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HclqFgiu"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5121F03CA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555897; cv=none; b=CGm64fzZIwNBlL8oaxAC6FB50UzjC01JBv2FEeSqFm4zxq+F8K4OEjiUKYoT6uoM68uCALLe9PCaojeNmj9IZ0Sx00SIT63xTXjfexiQDUEuNDo3kZnn7AKlOD+9BHqxBwi7FTgyZgEXQZ2sL9MineGKMhwPe3z+ElbyolHSM9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555897; c=relaxed/simple;
	bh=0Re9nYIVG+3b6VsBXMUbI1ZtB6rKosaiajqm/7/xC+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2mu/jrxOff6gp7oCQT3cFf9gg6zcHIzSg9ut7AyaxSaMogS/Cp46qRbIk1uUX5XA98dKC7ifpzjvxhYK94Ut6t7anL6oroqb0t/XziH53rRUa1Yh+VcERyGUQppYxET5dfIW3kaSSQPYSPXwnA9xY85R4jyHBDMqTEyW8pJgv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HclqFgiu; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bfb6ab47cso17160751fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1742555894; x=1743160694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCtKZJvKkPXJJY2Ss4/q9tNkLTXS6Y7jlq2lUla77Co=;
        b=HclqFgiulinnxF3RXgiZ+VT22RJj+reM+oTv0anHVKETygpACteo83YHXi6qYEz2Xd
         dsOe4zcnbAab92if5AjYS24bYhx+ngjJ2KFnIACMi5KnMn1lXPda7P3sofwNvDusBuAu
         cRWNk4IlimrX5t756v+PkV8oTjPNLoalVARxeWIbS2d9sjPjVLOAXXSX6oLZxqijclGm
         s++BVoG5kXk6w9TZ78cq4en0ctxRQmx3Q9Kmr1EiukIiIYQZdqr1PE7n1iMwWK2PwtGs
         bBxiFIlW1UNCNwdHHxO9SNdxMFrEKJe23+eA2L4zw7UXcdbgs8l/4I1QqZM3p9nVAIUV
         gQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742555894; x=1743160694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCtKZJvKkPXJJY2Ss4/q9tNkLTXS6Y7jlq2lUla77Co=;
        b=Rp9qFsbmIP6sdyq5W+iDglwYZixl26LTfFpLV7XlTi/oBCGU3n0sWTs78D5eFvsSSw
         fzPBMYkLRD+WUVjCys2SS3AzKe5r251eVuDWSVCJtzwqb/FccpU8d0gIcYtSSHJQQpF+
         EGDEIQ/F+hFuzn3bd+Tvfy1X1EwWDDW54tGVnJBYUbCv+SXFKTvwy10CQJLQn+8ykY2k
         iewMsCSQCyOMAlymNHnf994vvpq2mx3gsKIFhCnzGoa4Nrulqk2h2xN9c0j8ecj/Yo+Z
         pLwMdRazt79kLjI1CT+x5+MPrcrMm9Wuvl90u/L3l1r5TAMoj7ar2uTFQAe79yPxETwz
         4FCA==
X-Forwarded-Encrypted: i=1; AJvYcCVTbcPMmrimib4v3AQME+G3zAe9X5WXPK5jiF/JUt4FKjVlL9Pd9NUYfF/H5Hi6NlEZn0bn1fP3AKW6p1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtCriFpMkdpO/kT62RsT17bfR6sPIlu58thaqEeruXBjyipS3P
	EcrRhUDyZrALrF5YJ3UD/fndWwyzarmyT1uUvVgXPTxTJyzL/MS73qa9n7DTfbaBT9y8bAkrFLe
	I6xvQqOoMgVNoD7V8Jm0wXNdYWLFxeicToloNQA==
X-Gm-Gg: ASbGncuLjqk+wE+2DfPd6Z/aWpWID5dbczgMC0u2P/AyaHWnw1gRPOqV00iJtX8pgv2
	JlnSrxZtWuVBHKP+KFP9xjinGTJFowQzilaM5HekdZHtgg4u6RpweMkcnRkFWdMyJA+hQMYe81p
	lULV0o2SQ76AJkobIdVZMR4KxaPpiSog93WnXhljGN//CHfFVxcnSkq1nEypDAxHLU+JfW
X-Google-Smtp-Source: AGHT+IERJm75s5rZciBb0RBn6fFVTeQTNfsC0eQdgKqDYyHMqznGKgeQzvEvo63JtZR1Ek4d8tCFdpoVi9klTzrD4OE=
X-Received: by 2002:a05:6512:1149:b0:549:7145:5d24 with SMTP id
 2adb3069b0e04-54ad6500471mr962726e87.46.1742555893632; Fri, 21 Mar 2025
 04:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315164123.1855142-1-koichiro.den@canonical.com>
 <20250315164123.1855142-5-koichiro.den@canonical.com> <CAMRc=MdOSsakJm4H5=cqVzdKDrrMFO2t-wKVWRCU83saozepxQ@mail.gmail.com>
 <6mcl34zdx37gjh3a3y4lc5kgb2vv5notvs355oewiwogpgg5g7@jcuukymbifnm>
In-Reply-To: <6mcl34zdx37gjh3a3y4lc5kgb2vv5notvs355oewiwogpgg5g7@jcuukymbifnm>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 21 Mar 2025 12:18:02 +0100
X-Gm-Features: AQ5f1JrplLiIs2CXFFDFsH3QT7byGbN_uqzclHZ1yTE_iRMbvq9HpcR-A6D5uNs
Message-ID: <CAMRc=McpqUsEsMSfwo+WrzWdaW6YnMbptpj3fAoS-JfVhSm9mQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/9] gpio: aggregator: introduce basic configfs interface
To: Koichiro Den <koichiro.den@canonical.com>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 3:35=E2=80=AFAM Koichiro Den <koichiro.den@canonica=
l.com> wrote:
>
> On Thu, Mar 20, 2025 at 04:54:26PM GMT, Bartosz Golaszewski wrote:
> > On Sat, Mar 15, 2025 at 5:41=E2=80=AFPM Koichiro Den <koichiro.den@cano=
nical.com> wrote:
> > >
> > > ---(snip)---
> > >
> > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > > ---
> > >
> > > @@ -90,6 +124,70 @@ static int aggr_add_gpio(struct gpio_aggregator *=
aggr, const char *key,
> > >         return 0;
> > >  }
> > >
> > > +static bool aggr_is_active(struct gpio_aggregator *aggr)
> >
> > Series-wide: I would prefer a different prefix: why not
> > gpio_aggregator or at least gpio_aggr?
>
> Actually, that naming was intentional, but perhaps I could say this is ju=
st my
> personal preference. Here is a breakdown of the function name prefixes:
>
>   Before this patch series:
>   * forwarder:        gpiochip_fwd_* + gpio_fwd_*
>   * sysfs interface:  new_device/delete_device + aggr_*
>   * platform device:  gpio_aggregator_*
>   * module init/exit: gpio_aggregator_*

Yeah, it could use some more consistency. First: there's ongoing
work[1] on moving the forwarder code into its own library which is a
chance to change its prefix to gpio_forwarder_. You could add a patch
renaming the sysfs interfaces while sending v7.

>
>   After this patch series:
>   * common utils:     aggr_*

I'd prefer to keep gpio_aggregator_ here...

>   * forwarder:        gpiochip_fwd_* + gpio_fwd_*  <-- _Unchanged_
>   * configfs:         gpio_aggr_*

and here.

>   * sysfs interface:  new_device/delete_device     <-- _Unchanged_
>   * platform device:  gpio_aggregator_*            <-- _Unchanged_
>   * module init/exit: gpio_aggregator_*            <-- _Unchanged_
>

Bartosz

[1] https://lore.kernel.org/all/20250317-aaeon-up-board-pinctrl-support-v2-=
0-36126e30aa62@bootlin.com/

