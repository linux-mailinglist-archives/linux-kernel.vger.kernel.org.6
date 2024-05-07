Return-Path: <linux-kernel+bounces-172118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAF48BEDCA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07299281893
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B334716F8F0;
	Tue,  7 May 2024 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ux55KAKb"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7440C21373
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715112041; cv=none; b=pyeIPfB483vQAcndCwiiTH0KuEWX8SZLY+py0rT0nTLXf3J7iy2UORZgQ0IGYcuz/9+42VyOWmnFMb75CuPZWE4JN11hhLsXwutj2NGHmXqUpNVtGdttmBRWgWGQ+fzBlfOxwAOK9e4myNWu9t1aHjmf46ssrOlIsbPjWccyiMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715112041; c=relaxed/simple;
	bh=X+Xadyc7sdCFiVHFD+t7jMRpxudrW1hnI3AG8/xjqPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zk7BpY7VbmZwaLrWCeVe24Ih/rcGocP3n8yOAvJoAezVo2dEUox1cpsMz+fZdx6mnBWW7JIPFw4rLIIrauMfiOQZWZ5dozG0mutB6eh65Y7Hi/EgnrBmci8+xYF/ZRJAYoiIrqiTZqxvSMpPMhh1Vs5pihONSjnq7lt9Pllavns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ux55KAKb; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-deb99fa47c3so2049807276.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 13:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715112038; x=1715716838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6TCN9feXfNh1jAxhagWihzVe8ZvEfnj2X4SFV0NO20=;
        b=Ux55KAKbWZ81kDEnyZ610y9+/YYIP1alVvWbk1m16otzzW/+0akVJDHScN6gdhKWp1
         PADrPwjIlKZ1ToY42+be6QtzyB//2T7MrjJuL69bIZmPp4tGE4vvDvrBwJbPaVpHTWul
         KdMl81iU6jVfyPm8wIlFWOvBl1Bkm/JPEwDN1Pi5dVJe3SRAT9wrKoB5Fz8+h+P+ZeoD
         RGOTNG9cuYHPWAmADbGm56NotC1ye2JrzCchJD6zXY5luo0pPVp9/0RcwDFcPRmEHuz3
         MYJ7pfMSfImvORBDPbvu+FYesevIVlu2fNR45+QEgZ93s2vYtylvRmlmruK8MLfJ+H3+
         QS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715112038; x=1715716838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6TCN9feXfNh1jAxhagWihzVe8ZvEfnj2X4SFV0NO20=;
        b=eLynN9jTBprzT5yTt7JUf7b0TkPvaEABXUlyt2pc39BJtDZdb7DrMW3M2rgK8GmSWV
         8vwFng07MJEznmf0ES5QtAvcjP4THEK+gX8XZcTd2EUGrUkTXdcJZfWMBkiTbQjX6A9t
         8PcnJX//Gk50fD7A8C/6hMXtXjS+fjPWL0phHCopnSiNboeNOP0jVGzfntkLTYWWuiZX
         X5qsTyUk0fjBf2WCZV11qffl5FAsAZzB1131+fFydCe9Z/wWgE7+KKYrw3A+AlCxsdtL
         JZdnMWfMB/oA55X0Riu7jTCoLLKeAzKVvZXCQIJ1MR6bwbQmjo9VZgI8zmyw0miCtE1R
         hsrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyg77UJPacMx3SbYKF56jO4b89exiVbSXK5oiQp4K1O/XA1GDj333Na8HiEmpVHiq2mlqz4NBIAxUvJn3eegS4tFkdf0VGrA9d1D00
X-Gm-Message-State: AOJu0YxwzbosPSb6VJ9vDb2Skeo6AETC03zGgpcXczX95NOXz8dzRE0t
	cXY86AzOL0Uizu2BUG5A6PTgPpIRVt267TfdZUYXVb1pV+l9YSg1qtCuxH2Gv0XGhWYpALMizRW
	BwaOx/hQKkjgI2tKYdYPNBt+G1YLXsd4YISDj2A==
X-Google-Smtp-Source: AGHT+IF60hyBbjrnBKrhZePsOuZiXssFt8q1j+2GeW5Nikua4rfikn2nZlySLqvaFitVitDqb6f/6c7TSTgAxbIfE+0=
X-Received: by 2002:a25:8f88:0:b0:dd1:48c9:53f3 with SMTP id
 3f1490d57ef6-debb9e4f729mr646274276.60.1715112038171; Tue, 07 May 2024
 13:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYs1ZN2K=UHOjrwRR2JNE-M0nf9iW_Q-YPzVgmW+9daU4Q@mail.gmail.com>
 <CA+G9fYs1F=kO11-+DtAOsNwZGEd8mmojXEfXfg431JG=Spubcg@mail.gmail.com>
 <CAA8EJpoMwy2w3a9VF3ejGkcxFK905DCczZOdD4k-cd7ouKHYcA@mail.gmail.com>
 <CA+G9fYuGLz76C9F=onq6u2hk9_YYHhyjT+bvwXmeN8U6bhejNQ@mail.gmail.com>
 <CAA8EJpp5TO9CkwWCUy_OL5T4px9gTjmB-pKPr1dNPgudVc78Tg@mail.gmail.com> <c3013f57-0d0b-4e3c-9658-7cc989b77c73@app.fastmail.com>
In-Reply-To: <c3013f57-0d0b-4e3c-9658-7cc989b77c73@app.fastmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 7 May 2024 23:00:26 +0300
Message-ID: <CAA8EJpqqYrSLoLmhBLTG=dH2dxk=8Ab4PW35nt6b_Vfe5722Fg@mail.gmail.com>
Subject: Re: arm64: defconfig: gcc-8: failed: AttributeError: module
 'argparse' has no attribute 'BooleanOptionalAction'
To: Arnd Bergmann <arnd@arndb.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, lkft-triage@lists.linaro.org, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 22:18, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, May 7, 2024, at 20:19, Dmitry Baryshkov wrote:
> > On Tue, 7 May 2024 at 21:06, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >> On Tue, 7 May 2024 at 20:58, Dmitry Baryshkov
> >> <dmitry.baryshkov@linaro.org> wrote:
> >> >
> >> > On Tue, 7 May 2024 at 16:13, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >> > >
> >> > > On Tue, 7 May 2024 at 17:13, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >> > > >
> >> > > > The arm and arm64 with gcc-8 builds failed on Linux next-20240507 tag
> >> > > > with gcc-8 due to following warnings / errors.
> >> > > >
> >> > > > arm64 and arm:
> >> > > >   defconfig - gcc-8 - failed
> >> > >
> >> > > Anders bisected this build problem and found the first bad commit:
> >> > >
> >> > > 07a2f8716c41 drm/msm/gen_header: allow skipping the validation
> >> > >
> >> > > Steps to reproduce:
> >> > > -----
> >> > > # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
> >> > > --kconfig defconfig
> >> >
> >> > What is the python version on that platform / system?
> >>
> >> # python --version
> >>  Python 3.7.3
> >
> > EOL.
> > I'll check what we can do, but please consider updating the platform.
>
> I don't think we can rely on everyone to have 3.9, 3.8
> is not EOL yet, and we do want to still test in distros with
> older compilers that may also come with old python.
>
> It should just work with a regular optional argument instead
> of the BooleanOptionalAction (without the --no-validate flag):
>
> https://docs.python.org/3/howto/argparse.html#introducing-optional-arguments
>
> > @@ -538,6 +538,9 @@ class Parser(object):
> >               self.variants.add(reg.domain)
> >
> >       def do_validate(self, schemafile):
> > +             if self.validate == False:
> > +                     return
> > +
> >               try:
> >                       from lxml import etree
>
> This bit may have to become 'if not self.validate',
> since the flag in this case is None rather than equal
> to False. This also improves readability.

Could you please send a patch?

-- 
With best wishes
Dmitry

