Return-Path: <linux-kernel+bounces-308585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC99965F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E575028F074
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DCF18FC68;
	Fri, 30 Aug 2024 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q9WYMPUR"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597FF18E379
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013682; cv=none; b=qUiKA9Zaup/CF/xPDYoxIizIyw5LRjSrn9QiHlzkXP2QjXEI8V1bw7sw5wKL8/WpHNbTvqEz6BAILVNLbAXHacHxG50r6IcbhCniKKQK2cB9XeDUXgWXfxj4ZhFd/p3GF+ZR0cFp4UTzPCzPdfFzY/isLzSEpyNOLmoGW9gBLy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013682; c=relaxed/simple;
	bh=pMI90KbqudBvHNSXSKjN0yDaohkTey7HoNjDb2rpmqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0ExZkqcVLDzp0E8B5WAKAtO9/nrRDu+9j0WyUwFsaSdp/sZLR0Mx9ibWv+wKH2pCMMlyqvA2jHrvibbnix/jzRB0GZG3quw/iNsv85kZnGgAAAkWTg6G1SF7IhTcMFiHraMrA0nIJQ6vx2Pqs1xj5i8nKQFo7AoKwslhIiIrdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q9WYMPUR; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e1a7c25e350so492059276.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725013679; x=1725618479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaANdRMqGTHrITO34e72PLfanbHHgulA2aOEsmQ72uE=;
        b=Q9WYMPURyM8Ubb9lD8vs2Jav/ZAp9c+7ozzBICLaS008jTIXxvcG/UBUbAc50gA8jK
         5CAu8zDktm1XPSUS+Xr0lf85OWtnD6Rutq6qlmNxaFRnmlfcWJk8DQA19BAvSvkJn8wW
         dUdpydn081mPKLdVdGp4YZpl2KbLZ28sQQcWslzWQcSM0vSFqNvj/vrnub2fRrrFdqeY
         vt8+PwwQSY21ZekMMjgmzqw0+h8mzuo15VTNmICSkcLcvtc/2W+ZEGzuee7ReFutCdGh
         apQ9LSzP5QhhpBR0kA2HjXexKfwAC1wWTK7i1sOypVpDNiYUeiZ3Csaxzt4iPkMw9k4G
         +fTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725013679; x=1725618479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RaANdRMqGTHrITO34e72PLfanbHHgulA2aOEsmQ72uE=;
        b=Qu65/GKJXxj1g/j0aD4a/na9hVXvQOEDbitwdmH1weSi4fjPWcXfJ+HCZYgqmAKr5E
         n136YyOWZTX0UJF3acm46wsv+kXumwoVTzxRYnA0eNUkXIhDIyScBcKMYdm2w0ZpO/+4
         MwvUawh1h0ZsREAry2BkMy1M1g1RC4QzVzuOJI49za6dq3dumG0DEc59kUBJNc10unO1
         jtJj2tjzNpDIkWvUDyup88snb9oHcvRLn/N0DV6hJ15/TcdQeWqSc2Od74jT4rvlSPs4
         mEnbz5oxqYjTZUumEoST5fuAddshTbBliBps5StEN+HBrLeyDQ+WziUDnW9vBJkHPE04
         cTaQ==
X-Forwarded-Encrypted: i=1; AJvYcCULrF3+O8dEDE8Me8y5dea7tYbnNL7c/uhfuuoK+YMOf9ENfWZ0aY4PJiUsrxlF6astCxLfsrGpHGt7O5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhxSnjVYek4W0/u/04UIJRH+hAblbsYPbNNDA3naWskngmV+ds
	JQmiV2rlSMgDNwvWZUQXW7wIRKgS0mbRdAhQOC/KbbRcMZWImZrB3sbxhtzNTSae4f39Uy0Z/vT
	rrCeE4tgl1JvYk21SNFKfO6BhknfkBk+XAWrxCg==
X-Google-Smtp-Source: AGHT+IHD0Ca1b20qhfzhusSSGfDPMwq7sv7n4QQ2HQLit3WnJLdBel3AT0b+UM+MqPCx/P4KLADReUQAYSd3jSFYE1k=
X-Received: by 2002:a05:6902:2b09:b0:e0e:877b:2792 with SMTP id
 3f1490d57ef6-e1a7a0091d2mr1858033276.17.1725013679204; Fri, 30 Aug 2024
 03:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPDyKFrN9L+u_X7Ur+j--i-tewd31EXzwCojOP+Sxuyxpk4Phg@mail.gmail.com>
 <20240830024750.2908738-1-xirui.zhang@vivo.com>
In-Reply-To: <20240830024750.2908738-1-xirui.zhang@vivo.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 30 Aug 2024 12:27:23 +0200
Message-ID: <CAPDyKFrBSOwzn--m321VhRKM-J-9x9BkoPw7+TBWcOE5LpS4HQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] mmc: convert to devm_clk_get_enabled() API
To: zhangxirui <xirui.zhang@vivo.com>, Stephen Boyd <sboyd@kernel.org>
Cc: adrian.hunter@intel.com, bastien.curutchet@bootlin.com, festevam@gmail.com, 
	imx@lists.linux.dev, jh80.chung@samsung.com, kernel@pengutronix.de, 
	linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, michal.simek@amd.com, 
	nico@fluxnic.net, orito.takao@socionext.com, rric@kernel.org, 
	s.hauer@pengutronix.de, shawnguo@kernel.org, sugaya.taichi@socionext.com, 
	u.kleine-koenig@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Stephen

On Fri, 30 Aug 2024 at 04:32, zhangxirui <xirui.zhang@vivo.com> wrote:
>
> On Wed, 28 Aug 2024 at 17:11, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > On Tue, 27 Aug 2024 at 09:34, zhangxirui <xirui.zhang@vivo.com> wrote:
> > >
> > > This series use devm_clk_get_enabled() to simplify code
> > > and avoids the calls to clk_disable_unprepare()
> >
> > I agree that it simplifies code - but it also changes the behaviour,
> > in which order clocks are getting unprepared/disabled during the
> > ->remove() phase. In other words, this needs to be thoroughly tested
> > and not just considered as a trivial cleanup series.
> >
> > For example, if there is a PM domain attached to the mmc host device,
> > is it really okay to allow powering-off the PM domain before the
> > clocks are being gated? This could potentially happen if we apply the
> > $subject series.
>
> Thanks for the reply, are you saying that merging the above patch will
> lead to the following issue?
>
> before=EF=BC=9A
> bus_remove -> driver_remove -> clk unprepare
>            -> dev_pm_domain_detach
>            -> device_unbind_cleanup
> after=EF=BC=9A
> bus_remove -> driver_remove (delete clk unprepare)
>            -> dev_pm_domain_detach
>            -> device_unbind_cleanup (devm_clk_get_enbaled ->relase(clk un=
prepare))

Correct!

>
> But I think this issue is not only specific to the MMC host, it will also
> occur with other devices, if there is a PM domain attachded an use devm_c=
lk_get_enbaled API.

Right. Which kind of questions whether the API is really that useful,
from a cleanup point of view.

>
> So, can we solve this problem by swap device_ubind_cleanup and dev_pm_dom=
ain_detach ?
> clk unprepare -> power off not power off -> clk unprepare

That may work, I don't know.

Another option is simply to avoid using devm_clk_get_enabled(), unless
you know that the HW can cope with the potentially changed behaviour.

I have looped in Stephen to allow him to provide us his thoughts
around this too.

>
> bus_remove -> driver_remove
>            -> device_unbind_cleanup
>            -> dev_pm_domain_detach
>
> Thanks.
>
> > >
> > > zhangxirui (9):
> > >   mmc: cavium-thunderx: Use devm_clk_get_enabled() helpers
> > >   mmc: davinci_mmc: Use devm_clk_get_enabled() helpers
> > >   mmc: dw_mmc-hi3798cv200: Use devm_clk_get_enabled() helpers
> > >   mmc: mvsdio: Use devm_clk_get_enabled() helpers
> > >   mmc: mxcmmc: Use devm_clk_get_enabled() helpers
> > >   mmc: mxs-mmc: Use devm_clk_get_enabled() helpers
> > >   mmc: sdhci: milbeaut: Use devm_clk_get_enabled() helpers
> > >   mmc: sdhci-of-arasan: Use devm_clk_get_enabled() helpers
> > >   mmc: sdhci_f_sdh30: Use devm_clk_get_enabled() helpers

Kind regards
Uffe

