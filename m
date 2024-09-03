Return-Path: <linux-kernel+bounces-313136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5057196A0B9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8300B1C23366
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1712680C02;
	Tue,  3 Sep 2024 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dc89M94v"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232D78C60
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373972; cv=none; b=aVh/JoRggYykHWe27a7kNYQ4bIGDNMqbQyWn52KFrbl3j31dthbvxbcL72qPOuq8FT4OqhnmmsGGgw5CrrFMdo9ZkJSCo0Gxi0daei35GecE6ohdi0AQX9eVaCzkEQtxHysju0Hc4DlGp6ttsb8suSDVWc8SwOa/8o43ULAZrAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373972; c=relaxed/simple;
	bh=3NYB37O3R9YiG6QSPIMVcXeGErTw9KUagPZ6nHR8UiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEBt9DaYAyAbOehp5XHODFYdQNcRyu3xioW+X11PJ70SEklq8LDcHytD1sReXsllTiRWObfG7L+e5fB7OSsaTk0ZAtQRUwYqKn+/Z67sBZLHyC/Mbcom+8WpSEtENTz71PeEzwX2VYjCZwSD8mlaquffhjzvs8SndWy2ttVEpbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dc89M94v; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c0aa376e15so3022109a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725373969; x=1725978769; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=55Opw2LoBYgIb7dsZXRiPDb5CcbeKPiDbF6ZSpw6/ho=;
        b=dc89M94vzwsU3xOJdCrICzdBF8yL/39GkHOjCnbPGh4nXeYuouTMC66AHLtVTwz0Fd
         q97qEzDdKDFEamgw/oDI8GAeSVbQ/Vu4KJt/pyarimblDusNrXTnwY9uYBSc3o0Ypd88
         h5wE4989lU+UXFG/XYrMKIuJLTToSJ3QH9P9NuL8k0/02jVb7s3oMmoUuqVxVbrBwUJS
         kXeeYGms66CPYs7o8srYLCdhZcqrA5LvwErl5p0cSemBHybCBrOcTncSD4GTwldScsLr
         go8WUD7QKW1l2th69B9NiIU3+Jt9CEvoV984mHGVyuR2pjH/VMjb4qHQRuDSOd0IQuvq
         glHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725373969; x=1725978769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55Opw2LoBYgIb7dsZXRiPDb5CcbeKPiDbF6ZSpw6/ho=;
        b=csYrWVm5PMrat/ap7uoYnNkkhMgyz0ImxNlqIwdmNippYd7mscJQkQBwKi8W3WmHBH
         VF1c8cIaDVqDo3TSq42AyprYLMYzVYbbjVSJXxgCJzZwbI4h19RMcsbDWu4MApH/abBi
         iHIuWvu1vQ/RBTCvcAVUQ9TId0ATczqDSYvIgs+xLh5lDeA5P7w+ZOiZWlmQjT9VmEmY
         bjY6DKRhO/t9eSsJL1ldb16gxqZamvKdjVAn9wVr2LIy20cbEyoxFluoWjBMJhwEIuNo
         38kItEv8H4jseZFbHl1/9HGkuzMrrp3h+K1eLl8soXnSme/qF4nQu5tj8u4n1VRHBOYM
         0Ljg==
X-Forwarded-Encrypted: i=1; AJvYcCWCmncxY0clpF0VbEVj2zhMTy31rPfhpwGMHDz+7ytuKSP8QiUTrjfdE5w578l+27DX5d3fm8u7gG6Yq/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFlUCnddHPNb/cbuskOPxpQq6h74wIDhcjuHyLykxqDWekRvt0
	PxwQyJUp49JMWG800vlkG3vepLvfzERyVWvXJJQmfqs23RE6/LjSy4dyI+FubkXVXIsgdWHIhIk
	rReYZUR7yv6RwYjFvfWydP33fkK2HJgkMlq63Tg==
X-Google-Smtp-Source: AGHT+IGedt9kw2KGALBV+62OSvR+nilmJxqwNYVWOjk8DXOtccnyl0Je1vILxyNdMm+W++xzApGTs5bdjpJmA/nBUgA=
X-Received: by 2002:a05:6402:27c7:b0:5c2:5620:f72 with SMTP id
 4fb4d7f45d1cf-5c2562011e0mr5909505a12.0.1725373968445; Tue, 03 Sep 2024
 07:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820105004.2788327-1-b-padhi@ti.com> <522affaa-47ad-4834-be3c-acdd04902821@ti.com>
In-Reply-To: <522affaa-47ad-4834-be3c-acdd04902821@ti.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 3 Sep 2024 08:32:37 -0600
Message-ID: <CANLsYkzfpO4dcF=xkfZRo8ekCOzyNwvjHkwu8t5T58B2hV8-AQ@mail.gmail.com>
Subject: Re: [PATCH v2] remoteproc: k3-r5: Delay notification of wakeup event
To: Beleswar Prasad Padhi <b-padhi@ti.com>
Cc: andersson@kernel.org, afd@ti.com, hnagalla@ti.com, u-kumar1@ti.com, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Sept 2024 at 04:15, Beleswar Prasad Padhi <b-padhi@ti.com> wrote:
>
> Hi Mathieu,
>
> On 20-08-2024 16:20, Beleswar Padhi wrote:
> > From: Udit Kumar <u-kumar1@ti.com>
> >
> > Few times, core1 was scheduled to boot first before core0, which leads
> > to error:
> >
> > 'k3_r5_rproc_start: can not start core 1 before core 0'.
> >
> > This was happening due to some scheduling between prepare and start
> > callback. The probe function waits for event, which is getting
> > triggered by prepare callback. To avoid above condition move event
> > trigger to start instead of prepare callback.
> >
> > Fixes: 61f6f68447ab ("remoteproc: k3-r5: Wait for core0 power-up before powering up core1")
>
>
> Please put this patch on hold. I have some additional changelog that
> should go in v3.
>

I applied this patch a couple of weeks ago - are those changes to the
code?  If so please send another patch on top of rproc-next.

> Thanks,
> Beleswar
>
> > Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> > [ Applied wakeup event trigger only for Split-Mode booted rprocs ]
> > Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> > ---
> > v2: Changelog:
> > * Mathieu
> > 1) Rebased changes on top of -next-20240820 tag.
> >
> > Link to v1:
> > https://lore.kernel.org/all/20240809060132.308642-1-b-padhi@ti.com/
> >
> >   drivers/remoteproc/ti_k3_r5_remoteproc.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > index 8a63a9360c0f..e61e53381abc 100644
> > --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > @@ -469,8 +469,6 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
> >                       ret);
> >               return ret;
> >       }
> > -     core->released_from_reset = true;
> > -     wake_up_interruptible(&cluster->core_transition);
> >
> >       /*
> >        * Newer IP revisions like on J7200 SoCs support h/w auto-initialization
> > @@ -587,6 +585,9 @@ static int k3_r5_rproc_start(struct rproc *rproc)
> >               ret = k3_r5_core_run(core);
> >               if (ret)
> >                       return ret;
> > +
> > +             core->released_from_reset = true;
> > +             wake_up_interruptible(&cluster->core_transition);
> >       }
> >
> >       return 0;

