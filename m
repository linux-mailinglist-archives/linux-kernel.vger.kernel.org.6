Return-Path: <linux-kernel+bounces-343470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D73989B4C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7800F1C20404
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5CB154C00;
	Mon, 30 Sep 2024 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tl8zES5m"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359D115445B
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680864; cv=none; b=mDIkYnNggF27kZ+EouwoY3CosTNLX2FkzlWn1jynERN6hLnPSbW1ZY0+KsbplG4RtGxPO3oeeP857qbmGz5Qx6XgNpBQ56jVVThiuHNf6pCSROEO/Oi/VxCuyGhk65zMgjE0FsDKjyr6AmSrneB8V3nxiFhTcx/aOV8RONkJYgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680864; c=relaxed/simple;
	bh=uC1bGFbEyGnI6peNkcbnxCX7JCDxAYzla0brkJrjWb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwxuoXJrIBRzQrFrKPGQJRCvRCeWBIaxYrgwQ77m3/LmLToIiEnHWQTiSATRJ6fqaEBojBdc/ZH09+nVDblNfN2K78xnzOn22FMNgk0PLu4S7NSRiUeI4yRUhB49GaqcEEmdQdX7skqJ1hx5ibMbXdgY/FSSEU3m42uzQDlkm4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tl8zES5m; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5398e7dda5fso1182384e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 00:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727680860; x=1728285660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uC1bGFbEyGnI6peNkcbnxCX7JCDxAYzla0brkJrjWb4=;
        b=tl8zES5m1tUmKIF/UezgVfAqn5GotsDOH9Uwg34ZLcBHbjMmvATPnrfp5pkZanPJNy
         18JQt7uAT5nisIggVnvyEFMll7mP86RdMjeozldL0q0z1RTXBwrrGBZGeIJ7FDUTIzbY
         iHzZxjf9MSCZizIOu9MbxG9aCwMNErvDesoAgxSq7LzBGUqvx36u9nJlvvcFroJ09GSa
         uQLaicQIiAA74BOc2ZnOW8jEUa4lh6FW/RvCv7JcK2fMHbbYiuFUGvBev6UBgGnItnHq
         RdmeukKSMoaXliGCwahO/f9aAEHXYz1ZbS60/bwv1GXTkHZ8n1bS205OB8IK4uoGZMg1
         wzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727680860; x=1728285660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uC1bGFbEyGnI6peNkcbnxCX7JCDxAYzla0brkJrjWb4=;
        b=p8bqoSQUM1shY4y2a5XGyNoIPD2P8OxG9OQ6Ep04EjyD2/912krxwFTFjJtk6uh9tu
         m/CPcS5qbb5B4D1Lb0TcuT667qg3TSaVbBunwOWpEy8GlESSXhRzdyh4GwWv/aziLRt6
         LbwVFVNffRHvRRiFlnKVU5KfA+6Hk58LzhRI1j5qI+4HLwppxfzNndLKwE9a5uij14fH
         J1ejC+QqrJio7NCfcfZ1YgipNG4Av0O+G6gjJLaWi/gNbeLbfj2ttnO8WstayaYe+2n0
         Ta2OsgtvS6b26aa8K3u06K0pqJk+2EboJ+7CDMHYSAq+W+6Cn5RBjGI69FEIyypyrGLb
         1a/A==
X-Forwarded-Encrypted: i=1; AJvYcCXd5S6cfRNkVJpqyKS2wmaPaE3O9MfbHbp2JgTH0sNX1/heUMXDfBc8hzz+e0GKMCDoVy8dXkf6pYZBwJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzOGdimE/98gt6xPse/SBQPsyaihDr/a+5Q60NrlSxplw0EMm+
	8Uq0wxeMb854ja37yAp2HpLUbVjnaamw0nDJuF7mX5ht2kh0QXS6qSffoM9q/zX5y1E0aX/d05i
	Wb6K0D/83tDlF/VyWfwb2eElmTPfSSYP/8wpzwiMJWVzzwe9IjfA=
X-Google-Smtp-Source: AGHT+IFYFzyZZpqPm4CvKXnMmyZwmoxgOyu+OoTeGQ6Dn/BNHK2mrDp78kiFddScwnepG5KcZ+KBLeZop1D54hXqbns=
X-Received: by 2002:a05:6512:1155:b0:533:4820:275a with SMTP id
 2adb3069b0e04-5389fc6cb88mr5500517e87.52.1727680859993; Mon, 30 Sep 2024
 00:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927074221.9985-1-brgl@bgdev.pl> <20240930010334.GA6286@rigel>
In-Reply-To: <20240930010334.GA6286@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 30 Sep 2024 09:20:48 +0200
Message-ID: <CAMRc=Mdt8+ATGVU19E+pRrMhKZTcO49HTPdboHLLeN_Omd6LoQ@mail.gmail.com>
Subject: Re: [RFC PATCH] gpio: sysfs: make the sysfs export behavior consistent
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 3:03=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> > I decided to write a sysfs-to-libgpiod compatibility layer based on
> > FUSE. Since Rust is hard, I started prototyping the thing in python
> > first to at least have the logic nailed down before I tackle the rust
> > part.
> >
>
> Something along these lines[1]?
>
> Cheers,
> Kent.
>
> [1]https://dev.to/krjakbrjak/simulating-gpio-sysfs-interface-with-fuse-an=
d-c-30ga
>

Well, this doesn't really do anything. I'm thinking about something
consuming the libgpiod rust bindings to actually be a useful
replacement for kernel sysfs.

The master plan is: provide a drop-in user-space replacement for
sysfs, make users convert to using it instead of the real thing,
eventually remove sysfs from the kernel and then some time after
remove the compatibility layer from existence forcing everybody to now
move to pure libgpiod. :)

Bart

