Return-Path: <linux-kernel+bounces-310797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC4696815E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4354B1F21151
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41CA17F4EC;
	Mon,  2 Sep 2024 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ddCwHkzE"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822B517D378
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264417; cv=none; b=Ek3mKTccwfLAjoqxIzb4PiFMdc/agvNqoCIKJ94x61C76t7o43VysfuGJDywT0eqAJx/4IvZqdfNR53qvoqXtWT/vaHgKfJjOaynt0Bv+dFnZyEsObFxN6vGpSVKO9hv3W8mRrS0xrbE/YI4i+XvF89HpTQgpdDErQ+NAJ8pYOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264417; c=relaxed/simple;
	bh=Fp5/zQsmrQg7TztOZKRctcf+AhTIOoBVPb+GN7ko8AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJ8Wg+q2fv6ggGXCPJpAAKL2EMRee3boNSX7Wz9w4BKx5dQ3N0FilQJ+lv6mZyzTKPS/AFyitcJNAHOJQzXUzUn5BdJvdHBaKF1O+rCquM0ohBQrHekNu0SZYFq8CzEjhwqUffoRyPgQbZgJHc/HP9UbAYPHEV7GsN9+KrSI7I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ddCwHkzE; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f3f0a31ab2so44063511fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725264414; x=1725869214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fp5/zQsmrQg7TztOZKRctcf+AhTIOoBVPb+GN7ko8AY=;
        b=ddCwHkzEL9TjEYRTX67i7iNpit3Jg8ft5mSV3pcgWRM6PiDtGnSQ9oSxnATnP+19fe
         FpyWJBhH4jAJ1rAOm2Mo17XnLVaoeosTdulsHFdBSBiosC7pQjIjpTDEiYaaGk3Vozvf
         brvr7wxtVAXq0l+tmdl/sX1gvRmKhz0+eTpTwUycsUrMLyHZWABMmT+BtjbdhbQydmdl
         BYR1D1ha1nycgdixttCPj1hhF9OhOInxO1LZKqTWfS6KTWdzLNcUn2Wu4QWJ5FZ5CW1W
         yKhQCQOsGSgYQtxoXZi+XmvLtjUtpmUN9u2H9QYiRqpLNCWs17JBRDLfzd/lPrPqXBcA
         CYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725264414; x=1725869214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fp5/zQsmrQg7TztOZKRctcf+AhTIOoBVPb+GN7ko8AY=;
        b=ACYzzwc88R1/WcZnVsYZbLF92Ftu6DGwHh19EkMWKJ9+pRjY2FuEXMiKZ0yeoW39XJ
         H2P2Di5bZaoHiqYPnfi413EP7iHmj/SfAsObio73HzlTha/fTOMCQcJx5gF7a+hdTILy
         m1VUm3yZm1JuN90me4fhKuYrUVW5GTpbRhsCGkEwBIU1y6DL7xijDs48IiKjqEz9cdN4
         W8/m3L13rRbrQmRseeaQbtVD2s6N2eAyk+GlBtE/JqFXQyMcMtFhy7QNt40IFuSJQA/x
         QNbBI/Io4MIJ4V9EQ1InTgylCv2Sn8CsiPdtxOFPNJE5qvmT4IVIqJTFxlcgRkMBTmqN
         bm6A==
X-Forwarded-Encrypted: i=1; AJvYcCUYz7xEjdwmOOt31iaKhcMdLwlA6xbjdFwc33x9FLARlu9Ymtr9/ovWOr9nYzgjpFt8DwbUPrMg0J703FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfsnI3cVY0+zsuVTlY55X1eP6OHwZIwBPWvJG7r+Iu8G1Jn16R
	bJf37O6zcOgK46CrMy4+YYdVR+CUUtrrliCVEzGvPSH5/5xY7KTnUfXCxWczus8GbyYD5BJG42H
	ISa4HG94fl0dSrJaMC/BuWuWTQjMwuii/GyjPiCbEtrpmXuve
X-Google-Smtp-Source: AGHT+IF4P8ui/j6LwDmVgLebzGM0J9kbwtfhbveDHdpWZlQv2O/gT+1IzNGgnwXiG1DtBB1NINJJMQUuzvVqS4VTZaA=
X-Received: by 2002:a2e:be8a:0:b0:2f1:599e:bdd6 with SMTP id
 38308e7fff4ca-2f6103a0b89mr93767261fa.12.1725264412924; Mon, 02 Sep 2024
 01:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829064737.16169-1-wangjianzheng@vivo.com>
In-Reply-To: <20240829064737.16169-1-wangjianzheng@vivo.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 2 Sep 2024 10:06:41 +0200
Message-ID: <CACRpkdao3pSp4H0Nrr3rBbF4NbBw=ePxrgBYwNOTecpxSqhNhA@mail.gmail.com>
Subject: Re: [PATCH 1/5] pinctrl: sunxi: Use devm_clk_get_enabled() helpers
To: Wang Jianzheng <wangjianzheng@vivo.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, 
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, 
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 8:48=E2=80=AFAM Wang Jianzheng <wangjianzheng@vivo.=
com> wrote:

> sunxi sunxi_pinctrl_init_with_variant get, enable clk and
> deinit_device disable and unprepare it.
>
> This simplifes the code and avoids the calls to
> clk_disable_unprepare().
>
> Signed-off-by: Wang Jianzheng <wangjianzheng@vivo.com>

Patch applied.

Yours,
Linus Walleij

