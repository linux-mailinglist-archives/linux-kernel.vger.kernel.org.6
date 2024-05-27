Return-Path: <linux-kernel+bounces-190183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D531F8CFACD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732221F23348
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5932EAF7;
	Mon, 27 May 2024 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZGFnL1n"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2B5210E9
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796877; cv=none; b=DwOqgvAE2GS2vNQvvVZHkbnXVQSukfHfGcg2+IHiGa3xpq6kX7avLfROR3GeZCFwCqR+W8gXAA9RlLaIik3yzur6FAxwfMgHXt/PhopqJs3AmPLT+nrDPayuTUamtMltahGpa0e2bo+PKnTm4w7gMxvr9BdSDaMeJmVUJ0qEDhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796877; c=relaxed/simple;
	bh=KGYzo0d4ydTiDRoHwUaveUva4TGHCiqn07mQdn+93U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mia0AYPrC9jYQsd5pGX1/qBCJmQqUkR3k1f4VvvRaTfoYTs1Km+yNVoBPyXUuBbXJXFsoHwAQKZ3bzm7JOhzY095dpDcpLtd7y+eoH7JKG5esJAWlxbci3GeJR716zCuZaasGrYhPHgKdOuiTZnuVQnJCPE3ZzNOt3Z/NQFyG64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VZGFnL1n; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-578517cab9eso3369446a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716796874; x=1717401674; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JVF2aDiAwuR8zQRgdtvjMogqVM3XbukgpjZURs9F6bg=;
        b=VZGFnL1nRoZOHkGqlMC5Cq295VlfVXIKQwieBkvr8Jrx/6OdVmn/sXBIyqOFQDElu2
         t4LL1pXLg4Zc00coi0ct4iOolMU0xKEOGYqHDng7o/0M7iozNK32kDT1I58xYTdLFxfN
         UEBstTxBAPIoU9vkgLbvbItBIY1JQ4+ajqj95Vy3V5eYN6fkCUrGYhe8o0vGWN9dRjqw
         /gk6jrXeH2FZ+vYHj5fY09Hopcm+zxs95Qgxb2w7S2HXsqPZgPwkGbdCuLaMlK4jiqb9
         ZMGn12lSJPT4/LJHBvQerCH+FLxLO0Z3VIpC7vuHbum0o6pudGhjtMvh0NRF7VA/uvNp
         jhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716796874; x=1717401674;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVF2aDiAwuR8zQRgdtvjMogqVM3XbukgpjZURs9F6bg=;
        b=qcOZXpwQzF1vpJVDWQmgMbEJSfsnUYTm4fna1ENSQv7bEL+4XOfwaNIEUrhHBr0SR1
         doXKIH6Oxg0HhSXS8vwgfOGBVDGQwI6v7ouo8CYzXW+TofqR0yrx8o+xOg6WeernWcRv
         M3IV0Y5/TqCOLrPjO9QEzm+4BCLaT+ojzrEav77VGeWAe8Txf0Z+gvE81ECdGctE6Ygx
         0K7Y2SRLaoM5gVYDZUkzU/Iqco5mL8tvvFj1chiT2wNgJhwfdG98Kn4m4CERWOnhso/b
         +XdNJrLzroqxAFBsVfAf3h9ITlrSpi23+jFOcDVEylJRnlL4Dw4PcdeeBMCXfBZZtH5W
         MskA==
X-Forwarded-Encrypted: i=1; AJvYcCUP+ONCnbhO4sJzUUv0aoQmtjbx4294hdH8JOrGLbOF21Fy3kwGoG9EFVjBuwExxrOr1rRMLVsFiBLXCMZPFYeBOOKi9wEU1XVkAVw0
X-Gm-Message-State: AOJu0YydPUhGFqJJiuuXbT5bUCMEZmjV0Fd/Uq4nAc8jBkMYuveU8D4k
	mCXsMi9yy/RBaQKpmQt/MoKMr0B0wHfJ4CsPKDuWgrd2WvOIWFFBnkz2uc2m29s=
X-Google-Smtp-Source: AGHT+IFQsIh5kK+9ePczG/hmYzE323NUpoIVFMaCMZbZuQdBUucEYG/RX82tMtIPJFmuC6hg8bvxxw==
X-Received: by 2002:a50:a417:0:b0:579:c442:3684 with SMTP id 4fb4d7f45d1cf-579c44238e4mr2204315a12.24.1716796873691;
        Mon, 27 May 2024 01:01:13 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578523d2507sm5443603a12.40.2024.05.27.01.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 01:01:13 -0700 (PDT)
Date: Mon, 27 May 2024 11:01:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Frank Li <Frank.li@nxp.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
	abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, marex@denx.de,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Subject: Re: [PATCH v5 2/5] clk: imx: clk-audiomix: Add reset controller
Message-ID: <7ee00c15-ed39-4092-be79-d4683d1c3ee2@moroto.mountain>
References: <1716458390-20120-1-git-send-email-shengjiu.wang@nxp.com>
 <1716458390-20120-3-git-send-email-shengjiu.wang@nxp.com>
 <Zk+oxAh9+c0RIQ/t@lizhi-Precision-Tower-5810>
 <CAA+D8ANOQ8Pgt8QZWduZoVKCcb8Mdc=Xzotu4zAqakTjHO8pBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8ANOQ8Pgt8QZWduZoVKCcb8Mdc=Xzotu4zAqakTjHO8pBQ@mail.gmail.com>

On Fri, May 24, 2024 at 09:49:08AM +0800, Shengjiu Wang wrote:
> On Fri, May 24, 2024 at 4:36 AM Frank Li <Frank.li@nxp.com> wrote:
> > > +static int clk_imx8mp_audiomix_reset_controller_register(struct device *dev,
> > > +                                                      struct clk_imx8mp_audiomix_priv *priv)
> > > +{
> > > +     struct auxiliary_device __free(kfree) * adev = NULL;
> >
> > nit:  *adev = NULL;
> 
> Actually,  the checkpatch.pl told me need to have space after '*'...

Someone should fix checkpatch so that it knows that __free() is an
attribute, not a function call.  (The cleanup.h stuff is quite new).

regards,
dan carpenter


