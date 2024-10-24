Return-Path: <linux-kernel+bounces-379314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D44F9ADCFA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE6E1F22955
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973BE187856;
	Thu, 24 Oct 2024 07:01:32 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B328E6F305
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753292; cv=none; b=un2sTrDvdOcz8Oa3UZjH5KympV1mlX5jFUdY4Hv2DRTXW3+xaDjtF0PnZfuym0UrB3ai/nee7h993ZM6ozkn20QD9I7ZkrhvQhG+nE1HlwU+LNLd5GCjEQGFSEmd56csxgLVAqbX0lXQ/MkSSLhJ0N00cNZz2t3ptxqjuN5fHNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753292; c=relaxed/simple;
	bh=Dfj5Sbt9RkJvswJTvAUKrfpiSeeG8BctHTGwblcSLjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHfJjAugwdeI68/W3e6Qzs2u5awbTmp0MDAIXJTRPJaVTTf40gOUXfOjlfS1dZAuSAauRttJuzY93P49sXBmwk05Tgmqbw7123WqzG/FqquYc8ctjwHMHFN8C4yyE+oL89cnIIyi27HASTPQlZrFiJeWga0ZUtJE5gZ+gsN6wXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e2e32bc454fso642981276.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729753288; x=1730358088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53MA+Hqr0gkDrAv9I+Ueg9wmlWZM6CD+GlKPa+fEHao=;
        b=L2cjx4KxASWdZOkqT0ihoKG36InLAATesrElLxnbhTARgdZMVvs2Vj0LpOWuiNtKJI
         feX64iHli8NYsEb2GD/J3ztfY/jcbluG0zn4FWwvuUTl30e2vAYOPPHUF7mgx+MyENUQ
         N60d/RKhNSmmEZHrTAiWViRXpNzwcuAYqhRfjM/0O8IQ0wFOVrASg2z/Sgwdoyvvmy2L
         Dy7cFAPTBK3MK5qEi8qt0NJBqDQuYLNyypRbb2QB48L61pUY+TWNs+oCrxTBM+MkBT3+
         NmWsYZ1UaL1zm1E4tQ9PeRp4FrhPEbOyriDNi2QsXiJPC++KRaL8AsBNUq2zd18qQdOm
         vDwA==
X-Forwarded-Encrypted: i=1; AJvYcCUXtt6uMzek2n7ZXxBxN4LIx1wd/CYOS/WwDXaGE7m8CfYqt6Mx2Qspoa6XBu/Q30AYdahIS9tO2qopVrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr4/k2KGW0FzBNvP8sSmSGfUEFJVHowCT2rvuzpc+KULXKB5el
	ICs7DEEdtTeCymSfkKCiHmLYu9yN60Fq/q8h6iIlbxpltpwN+85pVIiNSmL2
X-Google-Smtp-Source: AGHT+IHCb5ynMAiB/31w71gRBMKLKUslkoaHFNjiKjrTQtOzXg4nFR61Fcu9vXRSV+KZt4NodBsYdQ==
X-Received: by 2002:a05:690c:d8f:b0:6e7:e009:183e with SMTP id 00721157ae682-6e85814d515mr12062597b3.8.1729753287977;
        Thu, 24 Oct 2024 00:01:27 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d2e7easm18831407b3.131.2024.10.24.00.01.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 00:01:27 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e35f08e23eso5325127b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:01:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXawpUDTkLlqlVsFEIYy44rLr1LnaF5zb0v+819ZcB2BKL8Lm56kdZLeA6HU09ktokJO2sRlCN3kXYo2BQ=@vger.kernel.org
X-Received: by 2002:a05:690c:9b09:b0:6dd:ba22:d946 with SMTP id
 00721157ae682-6e858165118mr10839537b3.13.1729753286965; Thu, 24 Oct 2024
 00:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxZ8MStt4e8JXeJb@sashalap> <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org> <20241022041243.7f2e53ad@rorschach.local.home>
 <ZxiN3aINYI4u8pRx@infradead.org> <20241023042004.405056f5@rorschach.local.home>
 <CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
 <20241023051914.7f8cf758@rorschach.local.home> <8734km2lt7.fsf@mail.lhotse>
 <20241024010103.238ef40b@rorschach.local.home> <07422710-19b2-412b-b8d5-7ec51b708693@roeck-us.net>
 <20241024024928.6fb9d892@rorschach.local.home>
In-Reply-To: <20241024024928.6fb9d892@rorschach.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 24 Oct 2024 09:01:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVLsLA97u4AVTA6=YKyfyWNrJOQk7S02s36AFTrFoUM3A@mail.gmail.com>
Message-ID: <CAMuHMdVLsLA97u4AVTA6=YKyfyWNrJOQk7S02s36AFTrFoUM3A@mail.gmail.com>
Subject: Re: linus-next: improving functional testing for to-be-merged pull requests
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Michael Ellerman <mpe@ellerman.id.au>, 
	Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>, Sasha Levin <sashal@kernel.org>, 
	torvalds@linux-foundation.org, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

On Thu, Oct 24, 2024 at 8:49=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
> On Wed, 23 Oct 2024 22:16:31 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> > I do get notifications, so it is still running.
> > Its configuration is (still) at https://github.com/intel/lkp-tests.git,
> > so you can check yourself if your current repositories and branches are
> > listed (and send a pull request to update it if needed). I see
> >
> > repo/linux/rostedt-kconfig:owner: Steven Rostedt <rostedt@goodmis.org>
> > repo/linux/rostedt-ktest:owner: Steven Rostedt <rostedt@goodmis.org>
> > repo/linux/rostedt-trace:owner: Steven Rostedt <rostedt@goodmis.org>
> >
> > so at least some testing should still happen. I did notice though
> > that "notify_build_success_branch:" is only set in one of the files,
> > so you might not get notified if a build was successful in the other
> > two.
>
> Thanks for the update!
>
> Yeah, I started using topic branches (requested by Linus) and I didn't
> update the success notifications. That explains why I don't receive
> them anymore.
>
> Now I have to ask. What's the benefit of pushing to linux-next over
> waiting for the zero-day bot?

On Thu, Oct 24, 2024 at 5:59=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
> Several thousand build tests, across pretty much every architecture.
>
> And a few hundred boot tests, lots virtualised, but some on real HW.
>
> A single character typo in an #ifdef your testing doesn't cover can
> break the build for lots of people ...

Or a missing "static" for a dummy function.
Or a plain 64-bit division.
Or ...

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

