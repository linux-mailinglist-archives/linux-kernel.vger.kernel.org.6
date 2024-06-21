Return-Path: <linux-kernel+bounces-224176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6196E911E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EDD1F22709
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EA216DEA3;
	Fri, 21 Jun 2024 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dq4FFZtm"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35FB16D304;
	Fri, 21 Jun 2024 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718957354; cv=none; b=Txe95Xt1eXB05kVpc7emGGPoyO3hdmQtQa3lH3YaL8KFOVv6S1TOHkwVMrfMy7U/j41c89X/iFkW+gDAe4k4jUe1sTRPXOyHnHUzDwSrsh2mCvB+Epkr/U2P4Oi18UhJxv61UCYh7ioHaKdWX73nhornbiv4mj5dHvxXZkHvPCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718957354; c=relaxed/simple;
	bh=JO8jBgL5VicYON4ggakHf8zSEa0qmLKYKjl67css/90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o108NMVy1RPY5A4uvCYjqXcp7I1jRFw1DYOBcaphorkEmmz9FNt1KTR9Yjd2kx5WY+RDjCyFA/b7PJzapiZaok147sToPamaHugr0hIlLNXRRqclRSbme1wCpAb3DeRScPGNSTlkFVW9w08Dl7UbkW8toSLmSjzlvI5YzrVL/28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dq4FFZtm; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3762ef0c477so1095015ab.3;
        Fri, 21 Jun 2024 01:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718957352; x=1719562152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwClo4datysb7tCRM4Yh2KXHFdvHWi27Cv7/oywYAaE=;
        b=dq4FFZtmX/C4HHx/KPpSFhMZ7hc26tpA2ycgB2/AT46ULNcIccaM9m+b1gAbllgPEn
         PKwSngTLSkJ4qmx41tdcvn3guG58PODBNKdBpRlYOeMqnM9UdYHFBP9Lm/gr5YIFzC9r
         nWCug4qS+hoP67OxolpstpTjRSlM2IOVR3sMWh3+mR9zl1C5EeTE3kfCEAV6wgsKKOA1
         l4lVrMtNaq294oAGaqOeyIqT6HEn1ogSH/C424Qz1/N86C9OxFUNuLv5vX7w0WIHDCNw
         qy+4T9uoFQLpmMQfSC9AUXNqpUdyAY6eagobjEocj5pF9X2TMlDIU7YgwEfbOMCRfhcS
         NhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718957352; x=1719562152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwClo4datysb7tCRM4Yh2KXHFdvHWi27Cv7/oywYAaE=;
        b=TIkcpc5yT3601w0rkZ44OWsh+huk5077NubGNhlQGP2Mh1s5+ynvWk98THR07ea4Xd
         bDVZ1CfCt0g0raOpJcqhrGJq5vSy4GpnzWDljz+msWWPXWpOJ6rRS36UG23qfHEDE5lV
         maaa39di2EhxxJM8pijRuFiZQrikbTgaxy1LV7bjP+ebPT2t7a9TB41jhmQA6m4ChBQ0
         CtSlP9zaFtu+U/d/ZEi/buxBKNNkknVSqXz0D59HHBQ6PsLBIwvIyaE0+0TIV/ZQWerl
         MQRwGzIuFzeW3fq2NHSdGG04pYh7MIvBiWRfavideunKAnxWNd1fUFGkoWIhNexWqmFa
         n2nA==
X-Forwarded-Encrypted: i=1; AJvYcCVZKG6pn2HaDyDzFFwH3EEo8SoiRYMowKZZype/mMFsZj4vUMVrCHcNTOCrMUyKk4KtHcDr/YqfeBzGkv8YSufAhFrswYEhZ9k2S/MKkXh73omtdVvo1klL8PjewD6VvGosjZy6y5wVNbhZ9f8RculwcIj/oblsSWebJ5NKXZ1AdSI/7w==
X-Gm-Message-State: AOJu0Yz1KyilRGeSFgqvwfsxueS+Kvu5tpblufLxyaS0tnwck7+RT4/D
	g5b+3XNOHDxh0/QvwFIaasXN1QBUTceUmKbDmqCc5L/0PadILj07/10DIefx4Y1R1Pv5UHU9YSP
	2GgK4O8bvKQEMK/6F6Lrdn5DZF1ESkD08yws=
X-Google-Smtp-Source: AGHT+IFwSrtGzSeEPK5TgC+oT8UOSi4rybKlq0dBAqLPHDSohAbLAOfIvFh4wZQl+7YbkvIbecRy6ybHuZFNV6WdVXA=
X-Received: by 2002:a05:6e02:1849:b0:375:a3d8:97be with SMTP id
 e9e14a558f8ab-3761d66d1admr86716815ab.9.1718957351600; Fri, 21 Jun 2024
 01:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1718350923-21392-1-git-send-email-shengjiu.wang@nxp.com>
 <171895121238.3616871.12573343188535489268.b4-ty@linaro.org> <ZnUfbEBDaKqIJU0r@linaro.org>
In-Reply-To: <ZnUfbEBDaKqIJU0r@linaro.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 21 Jun 2024 16:09:00 +0800
Message-ID: <CAA+D8APggO9q1bC7LnEBLj4JqF_q=Arax=iO6VeO5wZsm=d12g@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] clk: imx: clk-audiomix: Improvement for audiomix
To: Abel Vesa <abel.vesa@linaro.org>
Cc: p.zabel@pengutronix.de, abelvesa@kernel.org, peng.fan@nxp.com, 
	mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	marex@denx.de, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philipp Zabel

On Fri, Jun 21, 2024 at 2:36=E2=80=AFPM Abel Vesa <abel.vesa@linaro.org> wr=
ote:
>
> On 24-06-21 09:26:52, Abel Vesa wrote:
> >
> > On Fri, 14 Jun 2024 15:41:58 +0800, Shengjiu Wang wrote:
> > > Some improvement for audiomix driver:
> > > Add CLK_SET_RATE_PARENT flags for clocks
> > > Correct parent clock for earc_phy and audpll clocks.
> > > Add reset controller for EARC function, use the auxiliary device
> > > framework:
> > > https://lore.kernel.org/lkml/b86c83a520f0c45a60249468fa92b1de.sboyd@k=
ernel.org/
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/5] dt-bindings: clock: imx8mp: Add #reset-cells property
> >       commit: d7d9ef1f40dc0639ba0901097139fcdc4bedb32e
> > [2/5] clk: imx: clk-audiomix: Add reset controller
> >       commit: 6f0e817175c5b2e453f7ad6a4e9a8a7fd904ee4a
> > [3/5] reset: imx8mp-audiomix: Add AudioMix Block Control reset driver
> >       commit: b7604e8b805a6e52161ff98728122005e6975a46
>
> Dropped the this one. Needs to go through different tree.

In case that you may miss this commit which is in a clock driver patch set.
Could you please have a review?  Thanks.

https://lore.kernel.org/linux-arm-kernel/20240614101727.zkh32bqe5nurnmbx@pe=
ngutronix.de/T/#m4bd8091438d9fbe0bd1400005d681483c59607c7

Best regards
Shengjiu Wang

>
> > [4/5] clk: imx: clk-audiomix: Add CLK_SET_RATE_PARENT flags for clocks
> >       commit: 163e678c0b24d0e45f617f4496c4ae9b1afd8d63
> > [5/5] clk: imx: clk-audiomix: Correct parent clock for earc_phy and aud=
pll
> >       commit: 22fb849ead1b109f868e83b309223d906e4b7d96
> >
> > Best regards,
> > --
> > Abel Vesa <abel.vesa@linaro.org>
> >

