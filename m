Return-Path: <linux-kernel+bounces-361077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 172B499A319
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89AA2B23755
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1786A216A1E;
	Fri, 11 Oct 2024 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qq9eJO8A"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B773D216A19
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728647987; cv=none; b=TIsszsf8V/Qa7Fa42OlgqkB+9Wqv13iOiAojINxVp88bzEx0xbXZZEW//I3objmK60Rt9zklaSo3uNYi6/xNuIb/lvlflpXoKPWC+aDfpYWB/mBA96Z29lfl+7eKeOqdIFGEPwMfuQVL9pbuYK0UPQ5hef17PWEBQF7pFoMnDHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728647987; c=relaxed/simple;
	bh=qwkfN3BYVuFC3vV5WXVA5uPjtP4Ato8LY3RZUkQYAQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u77pCEmfHNfaK1MPuLLLdE5HlPk0wPAadVmNP1iSgehfR61mW+w6Jz423JBrw/JRp0Vhu1ga1uD0hpc/CHYTEMogMYJRlpGEUcYdeRjMjwfaWeg7VIXtXE40DeJQ7tjnuLd839bN6iUlw37mzeCAt2iyzeSnRT2JVysXHdT7RIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qq9eJO8A; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fac3f1287bso20042781fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728647984; x=1729252784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njzE6A9fTG2Af8PfGYInqB11elVdfbVGxTHn5Ly67GQ=;
        b=Qq9eJO8AfCjtABn+tlUTWlpK2n2viaCbC9UnOuG9YU0eyKRWLmoNd/a8Q3uv/yt+2k
         P/HAGliSoY60/hbWhJvce+kCNaH1d+5dGFVVZMaVMUSGFMW/qXjbLdirYjdskCdQ/vgG
         gSKWx/ZS2nz3canMjhrr8uNlzrFI6cRe/h7DXdkwsupuzSVAPxvgzWSDS+8u7mcC9s8J
         Gki6BGtOezqERzIKdb0UxCuXr3EV8ocpMYQShoBdZSeh5gjXYrEu5D0lvXF+iAFSw26h
         A27hPrjR38cNNekboeWQ7ASEAGmLkKG0/BA1vziJq5BNdwgu84tyRkJNva3vNEAy2Oe3
         cf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728647984; x=1729252784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njzE6A9fTG2Af8PfGYInqB11elVdfbVGxTHn5Ly67GQ=;
        b=xGSystS6IRHQdQ+Tkmm6DuxrZJ0BRLq6b6ntcTXv1Mhp+iUjSIi66GpSpjyzRjpAcn
         89tgRYPEGnTv9zb7GN3tp2hZwXLKrvsDKqlpwlttTl7YnwZ2AnlAiRzcifz8y+6BrLd4
         DG9eZAibCnQBZeDsPPiSNqMr4WHeBskugtOkkdXAzy2SgbuQv1e2eOI8K+/hkVqpbKDo
         pqCoIEnBnpdO1LkP8cs3Co4WfSSVexVC8FI4tt6MHsK5cbpIPRzX/WTHFw2/DQt8MKCs
         +KEO8b5pVVWNxYaH8gVz40nE8XCXoz4tMje2bx/cUIOQ9i/ySZ4erzoJCGAtlm2AbkuS
         7fyw==
X-Forwarded-Encrypted: i=1; AJvYcCUO2IIXR4DKnUHuxT2LXlRnWDnykLAv2A/tMQk7cxhIl2TGgXuO0GaKF6UpSOHSrMIBF5vz+RDiNQWK4c0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+AXEwzDdSy/TakTtYAyV8AIAg4vFfLAqQ9IGJAIu8d2Lc34bw
	qvCaNYfiGNkPVS0TdEVinhTgjrz7xrbw7TY1QrfZ6l4iJxRkvAwYaPL4G9ieUAiF5x9sk8nw9bQ
	NnfsQTFu3kL0fPaqLzY6JzqMtHwT/FQozE11Ffw==
X-Google-Smtp-Source: AGHT+IF2uwnddZOhUv8020GA5bGNYsxzQcUFUfF5txhmT/zSEkDJwCMxtcbglbu/a7PEyoeP9SV8a84Bb0Q+06OzagQ=
X-Received: by 2002:a05:651c:512:b0:2fb:30fd:b0e with SMTP id
 38308e7fff4ca-2fb329b53camr13620521fa.40.1728647983637; Fri, 11 Oct 2024
 04:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814191509.1577661-1-mstrodl@csh.rit.edu> <CACRpkdYyo9MD6zfiPde+3vSdpH96r+ZO12bdmMAfjw5PCNJ1BQ@mail.gmail.com>
 <ZtCBgWrdFI6h3zbo@freedom.csh.rit.edu> <ZtnLtgLRq68usPgf@freedom.csh.rit.edu>
In-Reply-To: <ZtnLtgLRq68usPgf@freedom.csh.rit.edu>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 13:59:31 +0200
Message-ID: <CACRpkdac2=wXA5OWpHku2ZoqiqPPo-pscGxTit-Jm-PicPwAMA@mail.gmail.com>
Subject: Re: [PATCH] gpio: add support for FTDI's MPSSE as GPIO
To: Mary Strodl <mstrodl@freedom.csh.rit.edu>
Cc: Mary Strodl <mstrodl@csh.rit.edu>, linux-kernel@vger.kernel.org, brgl@bgdev.pl, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 5:18=E2=80=AFPM Mary Strodl <mstrodl@freedom.csh.rit=
.edu> wrote:
> On Thu, Aug 29, 2024 at 10:11:13AM -0400, Mary Strodl wrote:

> > > > +       u8 gpio_outputs[2];          /* Output states for GPIOs [L,=
 H] */
> > > > +       u8 gpio_dir[2];              /* Directions for GPIOs [L, H]=
 */
> > >
> > > Caching states of lines is a bit regmap territory. Have you looked in=
to
> > > just using regmap?
> >
> > Do you mean gpio_regmap or using regmap directly? I'm not sure that gpi=
o_regmap
> > will do what I want because I need to provide an irq_chip (and I don't =
see a way
> > to "break the glass" and access the gpio_chip directly)
>
> I realize you're busy, but wanted to make sure you saw this question in m=
y previous
> email. I've got a patch ready to go that addresses all your feedback exce=
pt this point.

Actually the mail was caught in the spam folder, I don't know why.

I'll whitelist your mail address so it doesn't happen again.

Yours,
Linus Walleij

