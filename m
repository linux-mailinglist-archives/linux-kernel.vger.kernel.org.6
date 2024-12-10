Return-Path: <linux-kernel+bounces-439701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FECD9EB2D0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6BD18821DE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983461AAA2F;
	Tue, 10 Dec 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POAjzOo1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2461AA1D4;
	Tue, 10 Dec 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839831; cv=none; b=EL5pGryx+QF2IF4ZwQwbNW6lFXODIWGTk8kIKKgB0PXhrZv9sez62qi4ptQw+UcgQhJsN+Mza9+3LCklmtd3pLrb9ZTLP5CCrL3scsp41hTWRvn/vkxCtrWYssN+pW/a7tCplqNuQuvAxzJM9wGZPLghXkcpgnz7UIEzJtVOLts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839831; c=relaxed/simple;
	bh=3gOWcq1zJJ5l+F+w1WdeWxVYtF0psInIaL800cDCG58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PORjMK10y0JyhrH2YuIjBwrRl6hYobPRGNeqcfd53rHTUR7qchi+5sLxruACwPcqa9Um46RUPPPvH6Gp0YsGOFZCBBpF/FQxo9fJxMgCGqZNq3q1hNlRO0V7e0O3IrS2f/GbwjadWSo/T+nNdoSo0/66YjeZrwi9ss7OF8ppAd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POAjzOo1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A2AC4CEE3;
	Tue, 10 Dec 2024 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733839830;
	bh=3gOWcq1zJJ5l+F+w1WdeWxVYtF0psInIaL800cDCG58=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=POAjzOo1QAvE9GbJt+kCa/37T9JEvrd3S5bdMljOxTyfvaMISmpvq+4SBH/JWyFDv
	 ghF07kHJQxVwvEa9MziRBvo/QTVLnPRANjN7uYj3XERHSgRHgR/ygdF3lyO0HLU3nX
	 DOp0cmVa0WRtONFTWJtH+odpBsRttzOrkbFvrTZXk9tv91UxejojtO3dmxnNP/oRfb
	 SRtCjasUWh1lgFpAwD3CoY5L3z7xBqWuvK6BboUlUL4EVa82t3kaetJkc8HXKJUYgm
	 uNf5aF8NIzeZs2l+6Fei8gMaodAkCR+Tm/KHp6JOA4evh5Phh5HTKIZihOSH4hjIfh
	 o4n2sFo1Xb13g==
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e39f43344c5so5280781276.1;
        Tue, 10 Dec 2024 06:10:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7TwXPn9qlXHZbaMfaM3FsJ92PBjefx0bsXOvNftyBJtseO2bVfJhD2DxRQdW3xcFCdqHk6lGVZ0mE@vger.kernel.org, AJvYcCXOWjIBaDOk+8XyVfY34sgw72/9P+VwlpoXudg04v0/dGjR9BNyRAFSv1qQamJ5FENmGsc3Y34lufAq16gd@vger.kernel.org
X-Gm-Message-State: AOJu0YzbGy5ub+5Sf+t4Ahor7zaRe6mfVgJGwhajkHzkb6wq2KVbqT9b
	5C08hve/Gry3rNpqinmjRvCKKVYYtw9RJw7v0DZkZkoKgTtE03u6bI+C5Zcm99MLvyo9Y5y/fOi
	fpagUCnbZbfpjJstO52wsdPtBFQ==
X-Google-Smtp-Source: AGHT+IEXFLVBqbbI8nxouFGI8kPswGmdhkBaKHRUDEu5BqBIxnvKF2faXUVn639s0o86adLeHAKWP1BbTNnHphr9F+I=
X-Received: by 2002:a05:6902:2388:b0:e33:1c9e:5cf2 with SMTP id
 3f1490d57ef6-e3a0b479173mr14535963276.39.1733839829438; Tue, 10 Dec 2024
 06:10:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
 <20241206-of_core_fix-v1-5-dc28ed56bec3@quicinc.com> <CAL_JsqL+CRmCQMzcF4-A-PRBrCsfK8nduJtOO=RrsDtCUUR7og@mail.gmail.com>
 <14fe473e-5f56-4a61-899c-bbb79e2aed3b@icloud.com>
In-Reply-To: <14fe473e-5f56-4a61-899c-bbb79e2aed3b@icloud.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 10 Dec 2024 08:10:18 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Aap9Kjzcd5H5m9ArcXMWRogoT0CdPnz4-d8OeRgadUA@mail.gmail.com>
Message-ID: <CAL_Jsq+Aap9Kjzcd5H5m9ArcXMWRogoT0CdPnz4-d8OeRgadUA@mail.gmail.com>
Subject: Re: [PATCH 05/10] of: Fix available buffer size calculating error in
 API of_device_uevent_modalias()
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Saravana Kannan <saravanak@google.com>, Leif Lindholm <leif.lindholm@linaro.org>, 
	Stephen Boyd <stephen.boyd@linaro.org>, Maxime Ripard <mripard@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Grant Likely <grant.likely@secretlab.ca>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 6:39=E2=80=AFAM Zijun Hu <zijun_hu@icloud.com> wrot=
e:
>
> On 2024/12/10 04:34, Rob Herring wrote:
> > On Thu, Dec 5, 2024 at 6:53=E2=80=AFPM Zijun Hu <zijun_hu@icloud.com> w=
rote:
> >>
> >> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>
> >> of_device_uevent_modalias() saves MODALIAS value from offset
> >> (@env->buflen - 1), so the available buffer size should be
> >> (sizeof(@env->buf) - @env->buflen + 1), but it uses the wrong
> >> size (sizeof(@env->buf) - @env->buflen).
> >>
> >> Fix by using right size (sizeof(@env->buf) - @env->buflen + 1).
> >
> > Just writing what the diff says already is not that useful. The key
> > part you need to know is why we back up by 1 character to begin with.
> >
>
> will correct commit message in v2.
>
> >>
> >> Fixes: dd27dcda37f0 ("of/device: merge of_device_uevent")
> >> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >> ---
> >>  drivers/of/device.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/of/device.c b/drivers/of/device.c
> >> index edf3be1972658f6dc165f577da53b10c7eebc116..ee29c07c83b9e6abd9b1c7=
747dd341026bc79eb0 100644
> >> --- a/drivers/of/device.c
> >> +++ b/drivers/of/device.c
> >> @@ -266,10 +266,10 @@ int of_device_uevent_modalias(const struct devic=
e *dev, struct kobj_uevent_env *
> >>                 return -ENOMEM;
> >>
> >>         sl =3D of_modalias(dev->of_node, &env->buf[env->buflen-1],
> >
> > This could use a comment why we back up by 1. Better to put it in a
> > variable than add/subtract 1 everywhere:
> >
> > /* After add_uevent_event(), buflen is at character after the nul char
> > which needs to be overwritten */
> > buflen =3D env->buflen - 1;
> >
> > And then use 'buflen' throughout.
> >
>
> good proposal. may use it for v2 after discussion done.
>
> >> -                        sizeof(env->buf) - env->buflen);
> >> +                        sizeof(env->buf) - env->buflen + 1);
> >>         if (sl < 0)
> >>                 return sl;
> >> -       if (sl >=3D (sizeof(env->buf) - env->buflen))
> >> +       if (sl >=3D (sizeof(env->buf) - env->buflen + 1))
> >>                 return -ENOMEM;
> >
> > There's another potential problem. If we return before here, we end up
> > with "OF_MODALIAS=3D\0" or "OF_MODALIAS=3Dsome-non-nul-terminated-str".
> > Maybe that doesn't matter? I haven't looked at the caller.
> >
>
> that does not matter since current logic follows below 2 rules
>
> 1) all strings in @env->buf always terminated with '\0'.

Ah, right. However, we still end up with a truncated value though it
is nul terminated.

> 2) both env->buflen and env->envp_idx are not updated once @env->buf
> does not enough spaces then failed.
>
> current logic has no difference with normal add_uevent_var() usage.

There is one major difference. add_uevent_var() will not output
anything if the whole string doesn't fit. Whereas we might output a
truncated value because the add_uevent_var() call updated env->buflen
and env->envp_idx. We could unwind that I suppose, but that involves
even more mucking with the internals of the env struct.

> > I think a better solution to all this would be making add_uevent_var
> > work to construct the full value. We could add "%pOFm" format that
> > calls of_mod_alias(). Then this function becomes just:
> >
> of_modalias() ?

Yes.

>
> agree with you.
> for good practice, users should only use uevent APIs and should not
> depend on  uevent's internal implementation.
>
> > return add_uevent_var(env, "MODALIAS=3D%pOFm");
> >
> > And of_device_modalias() can be:
> >
> > sl =3D snprintf(str, len, "%pOFm\n", dev->of_node);
> > if (sl >=3D len)
> >   return -ENOMEM;
> > return sl;
> >
>
> looks good.
>
> of_request_module() provides another solution.

Yes, that can be simplified to just a kasnprintf() call.

Rob

