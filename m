Return-Path: <linux-kernel+bounces-402376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B929C26DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C2B3B22853
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1561DF732;
	Fri,  8 Nov 2024 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzDga9rI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8025B12D1F1;
	Fri,  8 Nov 2024 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731099398; cv=none; b=Ed7jqtUmBQ+cLc0gbVWC3Q5qD4PsGVOptuJrxM/pNq7vY8/3E1xdlRPXRBVCjLlcOVRdjRvx+CXYnJLgMRxSo060b9E3e55E/kqxztz2pjQtdMV/gNQA1UHaxGE0+ZbLMeS10f5mydUs31Uh2HkzlgudiJdzZdtiIVlkvnJTKo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731099398; c=relaxed/simple;
	bh=Xd+Iv39wDLiv1W/W6pMdvFYFk4KIRUOY6oJ6YP9dP5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfbiE+BEuiJClPYXmeZljeEcVkrvuVHVMCAr7lxXDW8OO9ukefaclAyZ264AhvpG+AxPqaLgAbbyL6vqlf/YtM308O+q0KiPcnsCjWqL83CzGLTj3uSozTTBRFAveMToNUm+fM1lD/3oc23mTZSa3WLGhV31WR8XDK/1VMy8ytM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzDga9rI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C144C4CECD;
	Fri,  8 Nov 2024 20:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731099397;
	bh=Xd+Iv39wDLiv1W/W6pMdvFYFk4KIRUOY6oJ6YP9dP5E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mzDga9rIZXYrJM30wctgArOOLT5gPx9yU7d7Z0xRanvD7SZ5JW+T5s2/BG9jXr770
	 rFs3cm731aajOthU2H5euH5ys7fxVIsjbCvAYofafu90gzNVpR7HbGDYbjnRmQ+lqG
	 TSZ6306R6uj7hahsRihVu/2qO0jR671onJlwTMjRPPQcwJgLD9u7XRL0zL5kmsMKcc
	 NlCJ/WdXojx3LqvSr16ARccUxsUtqgc+nBxVt7V8Eykgee4O9xs7N2O0HpEFhMnMQx
	 G3UkYM+k7Y25aw1UJNdMZbRHUpr01Ito+oHBltuhPIed9eE6EhRNEPI0yC9TrH1v0X
	 0oIeW6243PUQA==
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso3482809276.1;
        Fri, 08 Nov 2024 12:56:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDwemKQAePVAaxsZUa7DCnX6HrYYS8v4QVWmMM4CQSHoDDBIybNgKWyE83ppj6iTPRlJ+YQpbixupN@vger.kernel.org, AJvYcCWw0gW5qQM3FLZA9UsulBniA1itekXKGkvV548wa2O3IF7b08LRbkNRhu5pRpL5PMIbyrrP8fMzUjg810eS@vger.kernel.org, AJvYcCXlHcs2n3JMwZNcd9LN39NNnwwdkkp+EvC1nQXuygMiZvLe7mxBzCjeJc/O7Q4yOGWXAn8MSY+QEnFw@vger.kernel.org
X-Gm-Message-State: AOJu0YyxWC9Am3TARxmdoNhR5ZxizzBS3LO1uvbCikovKgT4EQfbjcYb
	ZJcAHWdKvPx/uC5JWvj9+u13XutRMZ4kvinMmgMVDuOTWQTj1OI9Em60iYWbexMmqzd/bzPY04m
	zYrclqohf5SndO2TOZSAKGCYBeQ==
X-Google-Smtp-Source: AGHT+IGdQ2O/mqrpY+fuNbbmYE2hRSmFJSoBJIRulk6FCq1WPwcawEytFzQE5FWTqqfO81SCd4jqFZOV7jmSgFS088g=
X-Received: by 2002:a05:6902:1101:b0:e2e:3701:7824 with SMTP id
 3f1490d57ef6-e337f8440d2mr5033272276.2.1731099396361; Fri, 08 Nov 2024
 12:56:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107143431.728669-1-ivo.ivanov.ivanov1@gmail.com>
 <a4begcrmbtotl2imd3eaxpdveagvwridy6ev5zmwzvjqt3ovfq@wyj2dj73xe3e> <d5d3f934-4f1c-43d9-aaf9-8de194d1f3b7@gmail.com>
In-Reply-To: <d5d3f934-4f1c-43d9-aaf9-8de194d1f3b7@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 8 Nov 2024 14:56:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLkdXKGve5tB_cdO9bG9ge923Hbmkz+1BghLc+KkkDo+Q@mail.gmail.com>
Message-ID: <CAL_JsqLkdXKGve5tB_cdO9bG9ge923Hbmkz+1BghLc+KkkDo+Q@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: clock: actions,owl-cmu: convert to YAML
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 2:31=E2=80=AFPM Ivaylo Ivanov
<ivo.ivanov.ivanov1@gmail.com> wrote:
>
>
>
>
> On 11/8/24 14:16, Krzysztof Kozlowski wrote:
> > On Thu, Nov 07, 2024 at 04:34:31PM +0200, Ivaylo Ivanov wrote:
> >> Convert the Actions Semi Owl CMU bindings to DT schema.
> >>
> >> Changes during conversion:
> >>  - Since all Actions Semi Owl SoCs utilize the internal low frequency
> >>    oscillator as a parent for some clocks, require it.
> >>
> >> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> > <form letter>
> > This is a friendly reminder during the review process.
> >
> > It looks like you received a tag and forgot to add it.
> >
> > If you do not know the process, here is a short explanation: Please add
> > Acked-by/Reviewed-by/Tested-by tags when posting new versions, under
> > or above your Signed-off-by tag. Tag is "received", when provided
> > in a message replied to you on the mailing list. Tools like b4 can help
> > here. However, there's no need to repost patches *only* to add the tags=
.
> > The upstream maintainer will do that for tags received on the version
> > they apply.
> >
> > https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/=
submitting-patches.rst#L577
> >
> > If a tag was not added on purpose, please state why and what changed.
> > </form letter>
> >
> > I cannot add other people's tags - toolsets ignore it.
> >
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > ...
> >
> >> +maintainers:
> >> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >> +
> >> +description: |
> >> +  The Actions Semi Owl Clock Management Unit generates and supplies c=
lock
> >> +  to various controllers within the SoC.
> >> +
> >> +  See also::
> > Single ':'.
>
> $ rg --files-with-matches "See also:" | wc -l
> 110
>
> $ rg --files-with-matches "See also::" | wc -l
> 94
>
> Having 94 matches of that out of all 110 definitely leads me to
> think that this has been done on purpose, and is still being done.

91 are QCom and 82 are QCom clock bindings... They tend to be
annoyingly consistent sometimes with whatever was their downstream
coding standards.

The double colon is needed in rSt documents to escape a colon. We
don't need that in YAML though. There were some thoughts on embedding
rSt into the bindings for generating documentation from the bindings,
but that's never been more than some experiments. This just looks like
the first QCom clock binding did this and all the others just
copy-n-pasted it.

> Could you elaborate a bit more? If it's wrong, then shouldn't we
> clean all the other bindings from that mistake?

Patches welcome...

Rob

