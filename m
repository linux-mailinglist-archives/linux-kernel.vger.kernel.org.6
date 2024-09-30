Return-Path: <linux-kernel+bounces-344747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D0D98ADBC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1891F21464
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0082E1A0B0C;
	Mon, 30 Sep 2024 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="adH4EL2x"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EE1131E2D;
	Mon, 30 Sep 2024 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726914; cv=none; b=Gnj+gi4tKBS8iYLPoyEN29ZlcOQO6pace3lPVDkSYQ3jmNVp/vdVXfrgsbfIXXel5UDKlkSjXkQYNMKtre7/KzfsdcbW61H8TppkTfpBB/yW6SQxafd3891s9bqMXCwb37M0SLDK/MY7kp7S7Lv6ZwAIrffQuQe4ST50RfBA9yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726914; c=relaxed/simple;
	bh=pT1dL8lysN8vggO0eK3mScXgfCxlzNq4RmSSqIJ9kKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUh7N0L4HbngApe/+NKuJ32DFxkiZKOP8AnmWuJWG/DjmVgh3PhxcsrvHim1R4WJVb5K7fuWNTwj5HNn0DEG7pCyaAV+Ni8s86pjVZhF+b/9K6vOgHiGyYA96p1St/6i40EJU7GrsR/sw/+yxk00aJTZVTE306FT6rTxduOcxN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=adH4EL2x; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b95359440so10425345ad.0;
        Mon, 30 Sep 2024 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1727726912; x=1728331712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pT1dL8lysN8vggO0eK3mScXgfCxlzNq4RmSSqIJ9kKA=;
        b=adH4EL2x+P1e1QGueyCXcWECeIgdbW96hoh+pnY5GrF/TWuV2phtyz1k/PgmGJP+Xk
         /HvgdV3A6cn079/b5Ony960OxmdrIjBx0y/wPwCzUpQAd+fgiqYPHfV+sFveEuYrUQpL
         SorpcJyn1eEorsc7Uui2Q3efjbqXyLKTjG+fUW0XGh4KD+t1OFj6uz7zPLw7dApb9DgY
         0CjQ5z7R2qSA10Hm8vFkqD6HeehmT8rBfUhbU64jwo4DKg2JLqVB56m5o0Ip6XkL0FJR
         H2wsu0OxNrqdYp5Ax32uRulz+y3IiMvCmPiBVbtMp/EaTISTe3Oox7bE63aXJE78YDDA
         qszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727726912; x=1728331712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pT1dL8lysN8vggO0eK3mScXgfCxlzNq4RmSSqIJ9kKA=;
        b=BENLg3TSCRA+R4zmRuGvu13zJlwgLRASmv7/OfXALNWtVlZ0KFCt6PTfg6RCGJzdtp
         p+tIm2/veb4zIMb3P5LbQuxQQLmGzOEGIPwVWJmwDi4WUQeL/rIRw2vpiMifqxYXLsHI
         B33PQKKa8yPputUhm8wm5PUigLSZT4IBWA0vxfNukhqyEwpiSZAoWqg4DJ2ZXdBKMrxl
         qtpCNZLu4xQ1BgfnlLY/wHDz1qIljjCjEE6gUNbXY7+/QfJRNiVmgvTJulGvukrcQguh
         ssYphCM2SisIHvayMJLu8Hk2PFB42OW0gRkwF34EUUyMQijZ9XAap7bqnI85K2ql9naz
         UONg==
X-Forwarded-Encrypted: i=1; AJvYcCUG77TmCXfPpIoJ9j//SjN4l7hYpcDVSr72ijo+Il/Mlh4q17+WYccf3UzpQw+Jn0BaIpU8xOmFWD3FCM9g@vger.kernel.org, AJvYcCWndmPMQTMV8QAgGdnjWS/PTWqh6nsikrKdf4wneWcFuZ5/UdsRLrmY3oHd2xRBbaM2LY3S+l/TyVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyf7OZUnsl2AGYEY2pQA1SS4pdvMzui2LISgOes94YfpYB9M3V
	W6iS/AdnGuI/91sxH7bBmll69a/+ryU6He8LszR97gb/BCo1dtysvVXr/lDX3MxEbhvvuNDPRC2
	oGeidNvUNmIzedUuqRYggx/OuPMc=
X-Google-Smtp-Source: AGHT+IEs2DmofWhzUH0ql6mNKV1LnAfUh+w0gmpzifWQCksoK4G24DGc3LF4HeEZB6BMBG7TMZ9Aw+33F5R9xGMlPBc=
X-Received: by 2002:a17:903:2307:b0:20b:5046:35b with SMTP id
 d9443c01a7336-20b5046080bmr160097295ad.57.1727726912048; Mon, 30 Sep 2024
 13:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com> <20240929-fix_glitch_free-v1-2-22f9c36b7edf@amlogic.com>
In-Reply-To: <20240929-fix_glitch_free-v1-2-22f9c36b7edf@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 30 Sep 2024 22:08:21 +0200
Message-ID: <CAFBinCBd5-s6vaBoJNerXavQiHgsv4Fm3v0svUX7geL=kJvVYg@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: meson: Fix glitch free mux related issues
To: chuan.liu@amlogic.com
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, 
	Kevin Hilman <khilman@baylibre.com>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Sep 29, 2024 at 8:10=E2=80=AFAM Chuan Liu via B4 Relay
<devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>
> From: Chuan Liu <chuan.liu@amlogic.com>
>
> glitch free mux has two clock channels (channel 0 and channel 1) with
> the same configuration. When the frequency needs to be changed, the two
> channels ping-pong to ensure clock continuity and suppress glitch.
You describe the solution to this below:
> Add flag CLK_SET_RATE_GATE to channels 0 and 1 to implement Ping-Pong
> switchover to suppress glitch.
It would be great to have this change in a separate patch.
The clocks to which you're adding CLK_SET_RATE_GATE aren't switched at
runtime in mainline kernels (at least I think so).

> Channel 0 of glitch free mux is not only the clock source for the mux,
> but also the working clock for glitch free mux. Therefore, when glitch
> free mux switches, it is necessary to ensure that channel 0 has a clock
> input, otherwise glitch free mux will not work and cannot switch to the
> target channel.
[...]
> glitch free mux Add flag CLK_OPS_PARENT_ENABLE to ensure that channel 0
> has clock input when switching channels.
This describes a second problem. I think it's best to have this in a
separate commit/patch.
Also you're updating some mali clocks (e.g. on G12 and GX) but not all
of them (Meson8b for example is missing).

I still have some questions to the CLK_OPS_PARENT_ENABLE approach -
please share your findings on this.

There's multiple clocks involved in a glitch-free mux hierarchy:
- a number of clock inputs (e.g. fclk, xtal, ...)
- two muxes (one for every channel of the glitch-free mux)
- two dividers (one for every channel of the glitch-free mux)
- two gates (one for every channel of the glitch-free mux)
- the glitch-free mux

When switching from channel 0 (which is active and enabled) CCF
(common clock framework) will:
a) on channel 1:
- find the best input clock
- choose the best input clock in the mux
- set the divider
- enable the gate
b) switch the glitch-free mux
c) on channel 2:
- disable the gate

To me it's not clear at which level the problem occurs (glitch-free
mux, gate, divider, mux, input clock).
Also I don't understand why enabling the clocks with
CLK_OPS_PARENT_ENABLE solves any problem since CCF is doing things
automatically for us.
Can you please explain (preferably with an example) what problem is
solved with this approach?

Last but not least: if we're running into bugs when
CLK_OPS_PARENT_ENABLE is missing then that patch should carry a Fixes
tag.


Best regards,
Martin

