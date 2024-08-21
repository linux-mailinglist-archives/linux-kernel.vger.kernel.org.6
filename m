Return-Path: <linux-kernel+bounces-295688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E6B95A01A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAFC1C21056
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ECB1B1D50;
	Wed, 21 Aug 2024 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vmqir1xt"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B701D12F0
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251130; cv=none; b=HZRq25KZQwOiG80My7Lmt9DDh6ZKCwmL2UYu8yw+GnKB9hVMNL+vRISFWnlZOh6INSlPRc6zvVRayhjLf716pCTvs6hKe3Y5WarhdfVlDnT+BZpGwzbl6mJB3QGRLdET/Feojx7uEFDe5HAEzntjqb9j2ZZACXCybG+EyUqYJ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251130; c=relaxed/simple;
	bh=4lV3fIkh/03JECgB5hPyIKqPWEJrWmbKUtxmS1uR5uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqif+ZMqBuYRXcY+J+aJ6FhiwLKthVxlvlpsttz2ZZOGdS6r0eGbH7+J33j3PlluoP+KloRZzjIn4MUlkUz1nO1V5DPol7jWIwpDf5U3qlQsD4L2vpDoMfFkaZXfFSELVLoS5GVCUzYJqodSJ5p5Vxmheq3QYBkUBqKjCG0YfUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vmqir1xt; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a83856c6f51so379122366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724251127; x=1724855927; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JQgWnQAYjniT5wgBED6T4PKIbuG5WNhvEH3SmC7Xpck=;
        b=Vmqir1xtPqjvNLwHaTzqQjDwAd/btNJweokdSSmDwYtYHZ3xa5MrFaQo883J+v44Z7
         MXzj714P16n5fiANsoaGOvWp7RuEX+edCcnBiuSzer86NR6kIesFut6tJQgoCW4ATdZb
         OUxJFdz1Ijd4N1Qia/ZeLWhvf2WwzmaevLQuGj2CChWsfQb7JQ5RhTPRIweNSlHoI2qk
         smyqqVQ9809yLLM0O+PXPnQjPEnZ/OuR+uOVupj9CFCfV40VVkT0sUhFWcx3brh402e3
         rpugHkWRY2hdL/9r/Zl9dZcdo87T/LHxJ9P9kp43vhaJ8OfLZ024CR60Y1geMi1tPkHw
         7goA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724251127; x=1724855927;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQgWnQAYjniT5wgBED6T4PKIbuG5WNhvEH3SmC7Xpck=;
        b=ZkazLkNFLVEEmwt+M86OfAYEtUV7wZQQ2snbZKxpPlk9zPPwqiWKFP6kBEFfwTuw7M
         ljjxA1eCxrXl7SHvLBWPNa08wwkIwg6prU1Ip+hVmoUeAHFp+t1BRzpIWW40viyEIYo8
         /eVzWEsJ7eCaPbhQ2Qwq+H6TY6lNGMmrY/HhoVATMKO1m8arCu6PXK9uVaZrVHZN4825
         pwasibS05b0wZCzvFFgUeWxJfwp9Y7TMkZjvRNNRMJk/usLPm0QS1VXRkwJ0YEA134cZ
         8FkqnRbYpUfgZWTQ1i7SW1Hi0N5lMojiIU8ZEpkZYg1SKDLnKnmJc1pmfTD990yYJZAk
         nw/w==
X-Forwarded-Encrypted: i=1; AJvYcCU6qyHLZ/l8U2Fhi1cpWNzZB+CXg7s7AQ/G2fJW4/h8MWKKdljH/DeqUC7SR1kUS8ympb0mUdeDp70vcNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAvuGfR0NSAYNhhLI2ACAnWQVhUf4XPb2EssLiCLorJgiS1Xph
	+eZJ4wXglrz/1Jd/J2FZulmG3atSwWDdWqJcrn7VeE8CY03IRrAcTCEpjMntT9E=
X-Google-Smtp-Source: AGHT+IG4lRyxesxM8tRoI3XkuWa5Z+aZ3n8DkuhdFzFE0gCAJ+DEVVbVyW4YYJVacsZe2++Ozhq8Ig==
X-Received: by 2002:a05:6402:4486:b0:5a1:a08a:e08 with SMTP id 4fb4d7f45d1cf-5bf1f0daba9mr2161160a12.11.1724251126802;
        Wed, 21 Aug 2024 07:38:46 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7f80dsm8069521a12.64.2024.08.21.07.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 07:38:46 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:38:44 +0200
From: Petr Mladek <pmladek@suse.com>
To: Raul Rangel <rrangel@chromium.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kramasub@chromium.org, Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Li Zhe <lizhe.67@bytedance.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Zhou jie <zhoujie@nfschina.com>
Subject: Re: [PATCH] init: Don't proxy console= to earlycon
Message-ID: <ZsX79M3RcertYHQZ@pathway.suse.cz>
References: <6101a3bb-30eb-97fc-3a8e-6d15afc4efb5@amd.com>
 <3de1ff24-3970-6e22-a73c-70446b8de4bd@infradead.org>
 <CAHQZ30BLb13Mz5+3MCgV30eG-LiU-6-4F7AEinGQmsgiyzD-yA@mail.gmail.com>
 <ZLF5_dJyQgzNnrnO@alley>
 <CAHQZ30DjZE6Mg-KUrLQOLHh+OxNHZXRDkuZopxJb3F7G29TsXA@mail.gmail.com>
 <ZLGVYg1FAZN7VFxB@alley>
 <CAHQZ30Abpvm+__VK9oaU9eWwLKpiND+rmfjrPvF_R_09d2JqGQ@mail.gmail.com>
 <ZLZgZvE35fYCkgOq@alley>
 <CAHQZ30DQw9n=uiuz3-nqnOKVbZdp-=DfeSn2feoPL08RjYzT=A@mail.gmail.com>
 <CAHQZ30AEuwUzJs0bjsZ4eisJhmG8zkrXx4eKnfGsJ1jBt=jTUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHQZ30AEuwUzJs0bjsZ4eisJhmG8zkrXx4eKnfGsJ1jBt=jTUA@mail.gmail.com>

On Thu 2024-08-08 11:30:53, Raul Rangel wrote:
> On Fri, Jul 28, 2023 at 11:57 AM Raul Rangel <rrangel@chromium.org> wrote:
> > > Your patch is good then. Well, would you mind to add a comment into
> > > the code and make the commit message more clear even for dummies like
> > > me?
> > >
> > > Something like the patch below. It would be better to split it into
> > > two:
> > >
> > >    + 1st shuffling the check and adding the first part of the comment
> > >    + 2nd fixing the case with empty console= options.
> > >
> > > I could prepare the patchset. I would keep your SOB for the 2nd patch
> > > if you agreed.
> >
> > Yes, feel free. Thanks!
> >
> 
> Hey Petr,
> I was just following up on this. Were you going to prepare the two patches?

I have been quite overloaded last two years. It would help me a lot if
you could prepare the two patches and send them for review.

Thanks for re-opening this. It has already fallen through cracks on my
side /o\.

Best Regards,
Petr

> > > Here is the proposal:
> > >
> > > From d2fb7c54bed4c67df229c56fcc1b0af83ada5227 Mon Sep 17 00:00:00 2001
> > > From: Raul E Rangel <rrangel@chromium.org>
> > > Date: Fri, 7 Jul 2023 19:17:25 -0600
> > > Subject: [PATCH] init: Don't proxy the empty console= options to earlycon
> > >
> > > Right now we are proxying the `console=XXX` command line args to the
> > > param_setup_earlycon. This is done because the early consoles used to
> > > be enabled via the `console` parameter.
> > >
> > > The `earlycon` parameter was added later by the commit 18a8bd949d6adb311
> > > ("serial: convert early_uart to earlycon for 8250"). It allowed to
> > > setup the early consoles using another callback. And it was indeed
> > > more self-explanatory and cleaner approach.
> > >
> > > As a result, for example, the following parameters have the same effect:
> > >
> > >     console=uart[8250],mmio,<addr>[,options]
> > >     earlycon=uart[8250],mmio,<addr>[,options]
> > >
> > > Nevertheless, `console` and `earlycon` parameters behave different when
> > > the options do not match an early console. setup_earlycon() accepts only
> > > console names in __earlycon_table. Also the empty options are handled
> > > differently:
> > >
> > >   + When `earlycon=` or just `earlycon` is specified on the command line,
> > >     param_setup_earlycon() tries to enable an early console via the SPCR
> > >     table or the device tree.
> > >
> > >   + When `console=` is specified on the command line, it's intention is to
> > >     disable the console.
> > >
> > > Here comes the problem. The current code calls param_setup_earlycon()
> > > even when `console=` is used with no options. As a result, it might
> > > enable the early console when it is defined in the SPCR table or
> > > a device tree. This is obviously not what users want.
> > >
> > > The early console should be enabled via SPCR or DT only when `earlycon`
> > > is used explicitly with no options.
> > >
> > > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > > [pmladek@suse.com: Add comments and more details into the commit message]
> > > ---
> > >  init/main.c | 20 ++++++++++++++++----
> > >  1 file changed, 16 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/init/main.c b/init/main.c
> > > index ad920fac325c..3b059e316e62 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -733,13 +733,25 @@ static int __init do_early_param(char *param, char *val,
> > >         const struct obs_kernel_param *p;
> > >
> > >         for (p = __setup_start; p < __setup_end; p++) {
> > > -               if ((p->early && parameq(param, p->str)) ||
> > > -                   (strcmp(param, "console") == 0 &&
> > > -                    strcmp(p->str, "earlycon") == 0)
> > > -               ) {
> > > +               if (p->early && parameq(param, p->str)) {
> > >                         if (p->setup_func(val) != 0)
> > >                                 pr_warn("Malformed early option '%s'\n", param);
> > >                 }
> > > +
> > > +               /*
> > > +                * Early consoles can be historically enabled also when earlycon
> > > +                * specific options are passed via console=[earlycon options]
> > > +                * parameter.
> > > +                *
> > > +                * Do not try it with an empty value. "console=" is used to
> > > +                * disable real normal consoles. While "earlycon" is used to
> > > +                * enable an early console via SPCR or DT.
> > > +                */
> > > +               if (strcmp(param, "console") == 0 && val && val[0] &&
> > > +                   strcmp(p->str, "earlycon") == 0) {
> > > +                       if (p->setup_func(val) != 0)
> > > +                               pr_warn("Failed to setup earlycon via console=%s\n", val);
> > > +               }
> > >         }
> > >         /* We accept everything at this stage. */
> > >         return 0;
> > > --
> > > 2.35.3
> > >
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> 
> Thanks,
> Raul

