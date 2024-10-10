Return-Path: <linux-kernel+bounces-358863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D98E9984DB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C6C2853B4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BA21C2452;
	Thu, 10 Oct 2024 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajISk5eU"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0AA1C2DA1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559353; cv=none; b=Ea2bYGOxJklFS01vbDTXo7bo6Vmg1ghKnRTRtM6N5bftjqYeslIjUd65KjM6hXAq5LwdrCL/27EYX+XRGBgEhBOapehUO1f9AqRN43HsWYh+s+l/sZkcf1mXMJbfIUUn7ycVQK1zuLN9YZs7XDvGFrQoe17WtCZM4GJGGyTMBcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559353; c=relaxed/simple;
	bh=Y+Hc+ZWBOz2/aG+Bofr74fDrP5zo529TaNwbqre/62k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kjfn8dksryhPvfgSOQvDqicC31sACljSTq8yIoMpNsTY02aIXzbE3u5zQocnQEyhJUerqTp0V19+/T1JZtj5MufBfIe7QlZVNWj0Uvvm87B21LcyXUfwO7Pc2pFN58I4k6+r1WfCY0ZsoVE0wkvbhjbbTjc4EwbjXrlk21+WqXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ajISk5eU; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso792041276.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728559350; x=1729164150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nLx+rERdJDl4IU0VN9dgmu8DY3d7fHIrreLdsnM/QYI=;
        b=ajISk5eU+bHg2ovM0ND/Vjv0IMgJFnfP4zs+GxjwbscIpQDF6H7U9zj4R6y3yLoZaL
         zUQYTnuj6wc3iJOvmmiyxwN8JSwD7EPAi7CRvsrfGP3aV0SjsN9zgCVNfR/skT9/jnVP
         Jccg0mN6YfjZidSq9M+2ipLwr9GVBAhwX3an12o2vdgSGV4YjSV7kkcmxNmr0m/faRV7
         oJ61456gZmriKLY1T78VBW7Da0c9GU1QgSyY6M/ZsSrl4s5JGIbY4lzQHFrVOzFNdTUm
         8SLtv9VXto1SHpkhKFhANd50lD3cZ63+8L7E2Wh5E6tA3d3YXt04U/gdg0faT2lOC49a
         jn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728559350; x=1729164150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLx+rERdJDl4IU0VN9dgmu8DY3d7fHIrreLdsnM/QYI=;
        b=ZsqCQUXCrT1+LHW4JixN7HHwjFkFsIosctqMwCRgzhItRYBeZ7dXPvm3FrR6s/2ECd
         YaeofkFVixq4LztqhVPxlTnLA/30nb2m2x/a9SGU8CYnE0at54Ps9X4cZXqlqjPFsomi
         /gGlIwBThaxzbr/6XWlM7p4mg9kiIIMDmZsNeK0ukgpR6ePm4AV0YRjVF+gVcko/Ql5j
         jM8rF+eYqqj2OazfDqatdrOCdkF8sJ6hT2gqMqk4LbJQ+VeCwZ3roCSGbTGVC0ydlFpu
         YRy7Y9+cu/M0Vmho9WZawmi8dD4n2NvyVT/WuhjTKDCEbwXxwqekjFUpHfs4iWy3wRN7
         f6kg==
X-Forwarded-Encrypted: i=1; AJvYcCVgV8ymMO7lNtss8/NTWFtS5e1ldI61xcUfrAwx4mNEUZTVeqSIkJHpOxU9eC8NngcpNHs6Z6oS71fBxPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaqc7JhkwKnCFwIETb+WH2/mnu0cHEAYQqDSWMnzn8HfA+dT9n
	pptV4JcHAeh9+0VXrpoWQEkNMC5+3Wrg75G8P3yaRKTGYaEkeeE8YMwcZFmRqPWvkKHV8jhq/Df
	vmya7o4JfKGp7kizKsF6TC6stwoz0ZFFpMFxfBg==
X-Google-Smtp-Source: AGHT+IEn9AYzbWx83wuvr4kMycaOrv54Vxz9NQ0aUIHG5PldBfbqBk8c1R1lTibs7vN5ovyALWCZcyq0+AHYnMkCmtE=
X-Received: by 2002:a05:6902:722:b0:e28:f696:f611 with SMTP id
 3f1490d57ef6-e28fe4338bbmr6548879276.4.1728559350534; Thu, 10 Oct 2024
 04:22:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913102836.6144-1-victorshihgli@gmail.com>
 <20240913102836.6144-8-victorshihgli@gmail.com> <CAPDyKFrbVY3OGmCn0wx8yv2n61ALAa54-vkUVqU8+bLo_=y=6w@mail.gmail.com>
 <CAK00qKDC6yciJS9JEjGjmqwEe4FRYGmppkYyFG72b3SFxzu1Zg@mail.gmail.com>
In-Reply-To: <CAK00qKDC6yciJS9JEjGjmqwEe4FRYGmppkYyFG72b3SFxzu1Zg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 10 Oct 2024 13:21:54 +0200
Message-ID: <CAPDyKFp8jCf9dq2WyC_4ss4KvQXx6TFv9f-6fkQFQDjKHnA55Q@mail.gmail.com>
Subject: Re: [PATCH V22 07/22] mmc: core: Support UHS-II card control and access
To: Victor Shih <victorshihgli@gmail.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Jason Lai <jason.lai@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"

[...]

> > > +
> > > +       /*
> > > +        * NOTE:
> > > +        * Should we read Externsion Register to check power notification feature here?
> > > +        */
> >
> > Yes, this is needed too.
> >
>
> Hi, Ulf
>
> We have the call sd_can_poweroff_notify() in the _mmc_sd_suspend() and
> _sd_uhs2_suspend.
> If we need to check the power notification feature here,
> do you have any suggestions for the type of power notification that
> needs to be confirmed?

Right, I see what you mean! It's been a while since I read these parts
of the SD spec, apologize for my ignorance.

In UHS-II mode, the power-off-notification is *not* supported. This
means that we should not use it from _sd_uhs2_suspend().

In UHS-II mode we should instead use the so-called "hibernate" mode
(hbr bit in the GO_DORMANT command), which allows us to turn off
clocks and VDD1 (corresponds to the vmmc regulator). Note that the
support for hibernate mode is optional for an UHS-II SD card. Thus,
the support must be checked via the corresponding field in the PHY
capabilities, before we try to use it.

That said, to not make it more complicated for you to get the basic
UHS-II support landed upstream, I am fine if you decide to defer the
support for hibernate mode to later. Instead, it seems like we should
just do a regular power-off in _sd_uhs2_suspend(). In other words,
just call sd_uhs2_power_off() from there.

Moreover, reading the SD Extension Registers would still be valuable
during the UHS-II card initialization (even if hibernate isn't
supported), as it allows us to support the "cache maintenance"
feature, for example. However, the support for these features are
optional too for SD cards, so I am fine if you decide to defer this to
a later improvement too.

Does this make sense to you?

[...]

Kind regards
Uffe

