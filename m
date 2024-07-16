Return-Path: <linux-kernel+bounces-254050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6EA932C37
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0601C1C2318B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6798419E7C6;
	Tue, 16 Jul 2024 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oDE+5Xuh"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDD71DDCE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145177; cv=none; b=mzuiw8bOPoO43eSMtKJfC94nquQifX2KeY9ydgMFUSy/s1RPSAfb7oeHlCpbfnjdCL+kq+hH//uRxzrkS/clSBlCgEgsNesUuapcCY3Zq02xMEswjtcemMwqBw/QYQWUM8QwpaT/ixL9semYKsEJoorQKqygwpg18dXyUybyZbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145177; c=relaxed/simple;
	bh=lIBfZqWcjvbVJBQ9/TDHNqVDKQMTdt2Y1/qmLghrBj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y455rAvKPdTlIbhKWiRYoqC2yNYCm2bQApRpYSJq0WkQTS4yp0nJI6vyKKTiWpfOyVweuZ+M0opI3E+lkLJpn4I0B4BlLp7Atf9FQxaHXOtqGQ9YW+mt6T1mvwP6IbUGuZHmGVVkhYrGoVURocHEeO25941Cew/uWpxaJZhj8qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oDE+5Xuh; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25dfb580d1fso3045830fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721145175; x=1721749975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JKBILTe7q/CPySmaWkq9DzQOt5Q1y7jNxqFaGU3vksE=;
        b=oDE+5XuhREzpjimQTY1SS8gq4pfqk2FMFB66CWJTVbuuVSnEAHrhftrsAglK+DUvQ3
         /fJVuhztAhXl3yjnLlGif379JEuxCn8qBn8UhRDkyxnmFVEmWUxoUH9qx/rvAatHX/w8
         5aZmsVkoRJwToOiitTm7tcIeXAQlz7jw27lA5Xf3R4W0ni/ql+PFaUV0WwquiYG1RbI1
         qJYQPU8ZL9uqMvtiVp1OueyT/awtvUT1k6LunDOBHmzrqBmWtp1+60pJ2OZyq14JXgoA
         j1z7rjqjiAJ2DqdKX8ynvWSOwniGXbeH7xd7/nZhXgdq1AVArbk2k5/dE5oKy8Qw96v0
         DqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721145175; x=1721749975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKBILTe7q/CPySmaWkq9DzQOt5Q1y7jNxqFaGU3vksE=;
        b=B6zOhMu3Jbur5boZs28OcIiOTv7n3NNNwk3iPrYd3IEz9cQz7eW4OK1n7JCMFvL5nE
         0jdgpU9g+NbRVTCIAaBbzlazfMgDD+v2dnu5r5po5k38ZvjRxbrIHjzTr9pu0qITixG0
         q2yh2vH7H2Gw3yDCQtbJ5ykUb+fKhMwCayyPZHiEK6qdsG0TzKkcTPfBqWkwJTChzE5D
         gcL0epMI9UycwqSCyNLHtfv8SVwSh3mwklcnH9pjKS2zJRfYdOnesSwmv9aEexyK30sz
         Un9oH0zVWZrv+0UYkKj3Q5852TLfm+xKM7iJNoKCPveh9cNb0KQDWCxEdg/ZncktB/Nm
         gNyA==
X-Forwarded-Encrypted: i=1; AJvYcCXeToKxOdZT29vjkBm/GQWKL2dLaXm5XJyMaFobn++QD+TQehK19LMWVOk8mVeqjDCciOasIoLGGfO/cibgtLzmiK/xI4U51qyBXaNB
X-Gm-Message-State: AOJu0Yzv8acMPRHRB7smBYMcXUX6/LKRx/3VEu0kkELSVLKMcU2qCjcy
	63S6H3oiIuhgZ4AZfFLtq2lS6avl2aaPHNw6SdDN8SHcMUskVCWpobqiDXVRl0o=
X-Google-Smtp-Source: AGHT+IGH6ZKwNcpITCBiSLzXtugAEPFVOciGhSh9sNS1/35g9a9+BEGmAmqFmL5Y4P5U+f0AZD+88Q==
X-Received: by 2002:a05:6870:ac0f:b0:25e:26b6:d028 with SMTP id 586e51a60fabf-260bd780fc9mr2192578fac.32.1721145175234;
        Tue, 16 Jul 2024 08:52:55 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:5d01:167d:9cf4:148e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ebb6aacsm6475011b3a.64.2024.07.16.08.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:52:54 -0700 (PDT)
Date: Tue, 16 Jul 2024 09:52:51 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, marex@denx.de,
	daniel.baluta@nxp.com, Bjorn Andersson <andersson@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, Terry Lv <terry.lv@nxp.com>
Subject: Re: [PATCH 1/6] remoteproc: imx_rproc: correct ddr alias for i.MX8M
Message-ID: <ZpaXU8TJbnE/yrBt@p14s>
References: <20240712-imx_rproc-v1-0-7bcf6732d328@nxp.com>
 <20240712-imx_rproc-v1-1-7bcf6732d328@nxp.com>
 <ZpaO4FDEYoA0cpae@p14s>
 <4819651d-b9f7-4fa4-81b9-614b6d4d5a80@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4819651d-b9f7-4fa4-81b9-614b6d4d5a80@nxp.com>

On Tue, Jul 16, 2024 at 06:49:39PM +0300, Iuliana Prodan wrote:
> Hi Mathieu,
> 
> On 7/16/2024 6:16 PM, Mathieu Poirier wrote:
> > Good morning,
> > 
> > On Fri, Jul 12, 2024 at 04:34:54PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan<peng.fan@nxp.com>
> > > 
> > > The DDR Alias address should be 0x40000000 according to RM, so correct
> > > it.
> > > 
> > > Fixes: 4ab8f9607aad ("remoteproc: imx_rproc: support i.MX8MQ/M")
> > This commit was merged more than 3 years ago...  I don't see how such a blatant
> > mistake could have survived this long without causing problems or being noticed.
> 
> Most probably whoever used imx_rproc and ran into this issue checked NXP
> tree where this is fixed - see here https://github.com/nxp-imx/linux-imx/blob/lf-6.6.y/drivers/remoteproc/imx_rproc.c#L232
> > On top of things checkpatch gives me a warning.
> > 
> > > Reported-by: Terry Lv<terry.lv@nxp.com>
> > > Signed-off-by: Peng Fan<peng.fan@nxp.com>
> > > ---
> > >   drivers/remoteproc/imx_rproc.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> > > index 144c8e9a642e..3c8b64db8823 100644
> > > --- a/drivers/remoteproc/imx_rproc.c
> > > +++ b/drivers/remoteproc/imx_rproc.c
> > > @@ -210,7 +210,7 @@ static const struct imx_rproc_att imx_rproc_att_imx8mq[] = {
> > >   	/* QSPI Code - alias */
> > >   	{ 0x08000000, 0x08000000, 0x08000000, 0 },
> > >   	/* DDR (Code) - alias */
> > > -	{ 0x10000000, 0x80000000, 0x0FFE0000, 0 },
> > > +	{ 0x10000000, 0x40000000, 0x0FFE0000, 0 },
> > Without access to HW or the documentation there is no way for me to assess the
> > validity of this patch.  Marek, Iuliana and Daniel - please review and test this
> > patch.
> 
> HW documentation can be downloaded from
> https://www.nxp.com/webapp/Download?colCode=IMX8MDQLQRM (one needs to create
> an account)
> So,
> Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>

The very quick reply is much appreciated. I will merge this at the beginning of
the 6.11 cycle.

> Thanks,
> Iulia
> 
> > Thanks,
> > Mathieu
> > 
> > >   	/* TCML */
> > >   	{ 0x1FFE0000, 0x007E0000, 0x00020000, ATT_OWN  | ATT_IOMEM},
> > >   	/* TCMU */
> > > 
> > > -- 
> > > 2.37.1
> > > 

