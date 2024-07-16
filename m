Return-Path: <linux-kernel+bounces-254427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C7893330F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28E81C22645
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7222954673;
	Tue, 16 Jul 2024 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xOBvR/+X"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EF83224
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721162979; cv=none; b=a5DILD9YefrO1nsL3xi7cYeajR7nbT2vD5IxWKBQE4obSraICq9PVEV6FgodKrkU2XoImUDqZAZScriRr0KndivGq8xi8siu6eMTt2UDeZq/F8pb3y8Xl/MvsAn23IgRTW1wExxX+OA9IfLFBiDPbV0sGFDYm5EjGKvwAlyoiAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721162979; c=relaxed/simple;
	bh=dxp0t3vJgiLFqmSLWZlK/crYaig8KsnINMJ5oKGO/dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSIn183lCiNFAd9Q8qLbulFFZD293byr+T7SZjDr1r12iwu0JgAl1qGAV6c+4N0r0WohMEdtlf3w3rdAhFaTTkksC18KatHQMOzCfxmxLkQwHrUivKwoV76UNum7hNGclMdvHV7RfvO8+mp+NAI2GKbg0bBlAmK04UB4Kw9ZpXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xOBvR/+X; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6510c0c8e29so56133517b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721162977; x=1721767777; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rew4uRo6G7ZD84SpgNe5tx363g5l3xHU+5cSV4Szuu4=;
        b=xOBvR/+XoH7zWshqoE8xBVy8MWDyCMYbdz1srxsbZ60S2IBa5iZPdp7F1AWKHBpj+A
         QNMCgtU3y9AiutL7/y7IE0sy13Il06BNNyv9LTbvOE2s9ysaHBy+hTwAZv1xf2lIHBy/
         SAXMFoF4+NhvLsHFwP2pr2TjNo0dx3VYsl2y/6wXdjGvR+JGRu8DI5bX2lDPr6AJdLMq
         t5VSKZYdg7g7Ks5yYZsFzZsR5AIvplf/6RK7jskENTwGuI6SOrOiRVoko4ihs5oHCGEm
         UIat5rqghKGMOUEr+lded3OoFZlmrdjQOecl7sJbEcINuBIUaHCPRKpQU4I8W4hBNF1K
         pfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721162977; x=1721767777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rew4uRo6G7ZD84SpgNe5tx363g5l3xHU+5cSV4Szuu4=;
        b=NB2eql4oseOO4d5POlZCY0kc/cWh1VgSn3Dw4JT/A5TfE1wjbLsdOcgbEga+SAGxAb
         fJruVUeEI5sgz1Aps4INyL88b2caSCp0y26KzVcw4h+AZ8rq/U58UZRFFHHCwo7snBVm
         B0KFEFbRPOmkKfjv/2MOTExz2i8JCB+Qa0Y32HjKd78DYW4yrLSqkUmA44UV9vTz8aTh
         gxe06+J5LUlffYZu4xINNlQGm4l06GjQYhXQaD6pxMeXZIw5VwdiWDa8lZpGDMAUl7eV
         M++vG99uA3Zr/w1r3sEE5Hs7l8Ml8Dd0exEWP0olnFWUI1P7XZ2Zu6Fj+FwOOVR751Z+
         Ok/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhaivRudVe899hRylXyZYJ+3sm6ddzuDMWWecDQiSJ1NJKjNuQJuV58zrfZ8svlhpEECV8031Hl21ddUKbzBhhguxBdlge9gvxgKCT
X-Gm-Message-State: AOJu0YxyU9AWtdb1v/n+DvPi7ZeWHG7buCIssVfnRmD3D2GMAqnaVRi1
	poyAbhDdb/4uAV34Q9Ei1JaxLDYRmPRSmMpPrhzlZ1BZucV//jhvUcGxluaBkQa9SwvXbyihsz3
	NGOLEkpB9bR7OkluWpDe3c6to+oUS4flxWgkOOQ==
X-Google-Smtp-Source: AGHT+IEUdX2s17r2WHHg8RHUXPpMb2z72KIH+6Dg/67NFjaJeEnCa6Gr4j1apj2MOlPcupIWrwA/mK6t6st6WMBqhb4=
X-Received: by 2002:a81:5b44:0:b0:62a:2a7d:b512 with SMTP id
 00721157ae682-6637f0c9724mr40158917b3.10.1721162977202; Tue, 16 Jul 2024
 13:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fe3126a0-7c32-426a-9997-77d76ade5179@app.fastmail.com>
 <1df9dda1-1f40-4e13-b79b-350690295ab5@app.fastmail.com> <CAHk-=wg+38EHPKGou1MqXwAAXC30cM8sMgZAGnZ7TcFO4L9J2w@mail.gmail.com>
 <CACMJSetbuZ4u64fksB26AxMxYpiB2_i5=NJefDW_aN_-aHd62g@mail.gmail.com> <CAHk-=wiqETvfxW_mG6++9uX4tY5gYbqqXsMURDw1nQy0q0qohw@mail.gmail.com>
In-Reply-To: <CAHk-=wiqETvfxW_mG6++9uX4tY5gYbqqXsMURDw1nQy0q0qohw@mail.gmail.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 16 Jul 2024 22:49:26 +0200
Message-ID: <CACMJSeteKVXEsasmXiqZhUQ_9bGCvxJLxTFGj6=WctBCkGXn0w@mail.gmail.com>
Subject: Re: [GIT PULL 1/4] soc: driver updates for 6.11
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, soc@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 22:34, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 16 Jul 2024 at 13:16, Bartosz Golaszewski
> <bartosz.golaszewski@linaro.org> wrote:
> >
> > TBH it never occurred to me to test pure `make config`. I use `make
> > menuconfig` almost exclusively and never noticed this issue for that
> > reason.
>
> I use "make oldconfig" for every single machine I boot, because why wouldn't I?
>
> Isn't that what everybody does?
>

I just do `make olddefconfig` hoping that the defaults are sane. Or
build the arm64 defconfig.

> I'm surprised that anybody would re-make their config from scratch
> every time, or use some GUI tool.
>

Nah, not from scratch. I just take the defaults and reuse them.

> But yes, I'm also perhaps a bit odd in that I do a *lot* of rebooting
> on several machines, and I do it with all these things that come from
> outside.
>

Yep, that's a totally different workflow from most developers I imagine.

> So I see all those cases where random developers added new Kconfig
> options, and then I have to go look at *why* it's asking me for some
> new driver or whatever, when my hardware hasn't changed.
>
> If I see anything that doesn't default to "n", it immediately raises
> my hackles. Why is somebody trying to push new code on my machine that
> worked just fine without it?
>
> And if I see the same question repeated multiple times (in just
> slightly different guises) for a new feature, I get annoyed.
>
>               Linus

I will pay attention to new config options in the future. Thanks for
bringing this to my attention.

Bartosz

