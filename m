Return-Path: <linux-kernel+bounces-253552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818749322D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41334284502
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996A3196D98;
	Tue, 16 Jul 2024 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3oAlN5V"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396C9196C6C;
	Tue, 16 Jul 2024 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721122057; cv=none; b=Ni8KrnTcy9+KnZXvF76ebp/Fpg5b+mZDB21tEZDbjgz/XTEqDfi5BctmXlcBvkS9Y+bmgJryzk88WfgXqc51eFxfeIEAtS6SzsW0t+pjOqrB7zY92qyVo2AfFh28VgG66NCZzOnFgJb7Bf3KGOZc65RR1A+6b3Q6E2IReeqaDgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721122057; c=relaxed/simple;
	bh=0AvImW20JI33GnYfDuA9xlRzQVQN5eOuU1t4kmhQGTI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hYgpxhZ8HdYeBfnNHvp2g+Xi+h5X97OrytYii6ZhRc533Wgm0yTYg4J8EWTtxhMPJQ+WQGHq3EB+zTYtufDFgXG61qNShf0KscxBkyJJqf+G3AOXVLdGM8MOI7RNNd9vjWT8HMTwYnajWkPKHUWqhzRxOpbHS0AE7Irm2K1Ktag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3oAlN5V; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4266b1f1b21so35725405e9.1;
        Tue, 16 Jul 2024 02:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721122054; x=1721726854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PEU4qwN7WxP6VJDTGvYtCPzC+v0lV1/cj8lPv93ylU=;
        b=f3oAlN5V66SN+S4/9s7HkVZiyBc7MYesEfRVBaWbQdgu40FVbCFQSs5WzcACvdxG0t
         o2oUJ2mr5k/6Uzc8UBSijyRDisLps5AJeKzTwE4k2QaP6z2JKvgQ3ub+n7n7OPNZ43eB
         u9wQXqQzXfD4DqNEfxJXugiu5ixyW1jSGSlAx+SUwmvfEuOtHEGLYtdpvWGYXy+YwHgt
         vio19/9ws8FBJp3Ujtk/Q2P1YKJ8nRy0Oo/qAY771vWMRjK3H+QNexD4UnYFMwMAaAWu
         M+KwPWlMIqqx++wQzgrZVSw/hQK3gCOcl8VPnN1I6cXK3+wUlbQgalDOcVgTH+Vua3HC
         aX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721122054; x=1721726854;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2PEU4qwN7WxP6VJDTGvYtCPzC+v0lV1/cj8lPv93ylU=;
        b=Hz/6Diah459pkprvEdA23+4mZ7rQQkdTuPZBVbIsbaJ/4lInnCg0rc7EMBjl9HKc3r
         vBfvToEBUBDs4Uo9korg2M5bRwwEeoM4xwG2KFVgJTzGXwrV/VX0Jc+KgeFpknfGA84X
         LFjpfii4hhPR4qYzfof8ENRBV7KfGPqD86nje3NNZH5q0l7XGhmWVZbIdTtUb1DBxCq8
         7NN3JfEnryn67ReqZjE6DH8IATp70Gz7dm7GDFf/+9wQxJDTM5ecBY9qnYNNtzDtvtm6
         9ZG5hMBIupcTusN2VAuu7tFJDyyyCMCBVGJwhjRYT4QqVdnQ/aX/Js0FqPTcykjcFEAy
         VPWA==
X-Forwarded-Encrypted: i=1; AJvYcCXWJTquTqdF9QREHUF4azdDx1PUfO/sZXxaBMciHNtY6miIiCZhyiY3yTpwuYXhW420KuEN8tywufu0PqGNqrfsM7/tiaaFXEWN03oEiXWdD9/mAy/b8jRNdG+tN0zAJ/xc/+nntklT8EQ=
X-Gm-Message-State: AOJu0YwAgtLqZhBu7kTu7E73AOU97UckGu14iwLnM9pNuc0rfdZXj8LV
	q18VzskG5qD4Nx0Ye9oSdLuX3BlJKAgpp5yW2U35tZJEV9Ehbwbr
X-Google-Smtp-Source: AGHT+IEGHl0l97n2oZGPosdV8rJBmnt5GWQ20KKOkfy2e9pjEUSSh+vmDhtfqRS+c9+nFRYnAae6Rw==
X-Received: by 2002:a05:600c:3152:b0:426:6eb9:db07 with SMTP id 5b1f17b1804b1-427ba684a4fmr10488545e9.13.1721122054395;
        Tue, 16 Jul 2024 02:27:34 -0700 (PDT)
Received: from localhost (host-79-55-57-217.retail.telecomitalia.it. [79.55.57.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427bb9976casm9090835e9.1.2024.07.16.02.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 02:27:33 -0700 (PDT)
Date: Tue, 16 Jul 2024 11:27:33 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Matteo Martelli <matteomartelli3@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Marcus Cooper <codekipper@gmail.com>, 
 =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>, 
 linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Message-ID: <66963d0531f17_7063708a@njaxe.notmuch>
In-Reply-To: <20240715-rigorous-bipedal-sloth-c8df1b@houat>
References: <20240529140658.180966-2-matteomartelli3@gmail.com>
 <20240529140658.180966-3-matteomartelli3@gmail.com>
 <20240606-savvy-wallaby-of-champagne-d4a50e@houat>
 <6662bf1b61bbc_2f51737023@njaxe.notmuch>
 <20240702-copperhead-of-unusual-intensity-7f43a8@houat>
 <668419fb8ef9f_2a76d370f1@njaxe.notmuch>
 <20240715-rigorous-bipedal-sloth-c8df1b@houat>
Subject: Re: [PATCH 1/1] ASoC: sunxi: sun4i-i2s: fix LRCLK polarity in i2s
 mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Maxime Ripard wrote:
> On Tue, Jul 02, 2024 at 05:17:15PM GMT, Matteo Martelli wrote:
> > Maxime Ripard wrote:
> > > On Fri, Jun 07, 2024 at 10:04:43AM GMT, Matteo Martelli wrote:
> > > > Maxime Ripard wrote:
> > > > > > -	/*
> > > > > > -	 * DAI clock polarity
> > > > > > -	 *
> > > > > > -	 * The setup for LRCK contradicts the datasheet, but under a
> > > > > > -	 * scope it's clear that the LRCK polarity is reversed
> > > > > > -	 * compared to the expected polarity on the bus.
> > > > > > -	 */
> > > > > 
> > > > > I think we should keep that comment somewhere.
> > > > 
> > > > I think that keeping that comment would be very misleading since the LRCLK
> > > > setup would not contradict the datasheet anymore [1][2].
> > > >
> > > > Also, do you recall any details about the mentioned scope test setup? Was i2s
> > > > mode tested in that occasion? It would help clarify the situation.
> > > 
> > > I can't remember if I tested i2s, I think I did though. But most of the
> > > work was done on either TDM or DSP modes, and I remember very clearly
> > > that the LRCK polarity was inverted compared to what Allwinner documents.
> > > 
> > > So the doc was, at best, misleading for these formats and we should keep
> > > the comments.
> > 
> > Thanks for the reply Maxime, would you be able to point out the Allwinner
> > document part that is (or was) misleading? The current datasheets (see links
> > [1][2]) look correct, the current driver setup for TDM and DSP modes respects
> > those datasheets and it's not "reversed compared to the expected polarity on
> > the bus" as the comment states. 
> 
> I clearly remember having to debug something there, but I don't remember
> much more, sorry.
> 
> I guess if you have tested on the H3 I2S, TDM and DSP and it all works
> as expected with your changes, go ahead and ignore my comment then.

I did test it on the A64 SoC only (all modes I2S, TDM and DSP working).

Best reguards,
Matteo

