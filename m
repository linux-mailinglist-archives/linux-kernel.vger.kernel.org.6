Return-Path: <linux-kernel+bounces-258124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 307BB938415
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 10:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547FD1C20AB4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 08:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0F6C153;
	Sun, 21 Jul 2024 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EEOgTCar"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680198F40
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721552250; cv=none; b=CrhRi1Br6SvDJyZDRgnN4Qc/CsN/IGAJfAs7kljgyunUjUpASOBKhw8avS62VWqDg7bufQjbEWKo/4i5q4Sgxr1lzSa+YYe/u6gF4SCQ3Qs0DKEMj3lCQo4f6kkuvGNFCwK++TWFun/x/54Z/mGL5Cmvp18ryc6Q17lieiFPaY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721552250; c=relaxed/simple;
	bh=J3Qm7U9iWW3lCoBGlQA+CYXsXYPYRnz1OB3chKLRchw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DW9Yp9HuNzyxzCHFImmp4LyrK1PoPc3ajESjvOrpWp8D8oKCgewxzm7fBYsojvSchBYNrzJGxurzqBEL+4u8kTV7D5Cy3/flSYkkqlxCiVPZ/ftZS11Fzsq9KFwhZlXOgT/bEA9+g0aa+ZWf8GsYugLZoyWvzgFlj5AvOoEchd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EEOgTCar; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39641271f2aso12454845ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 01:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721552247; x=1722157047; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FDb31VIAAZnMZQZyGzdpC/AMxekr4nZrMgLoDm9Xh0w=;
        b=EEOgTCarzsqe22feg34eYLIraoVb5iv+w5NGu3tk/JsgQqZWzJCgeLhZcwTqbakiDJ
         sLqTT1y7mP4/mm/6TobPO+kHXqOyQ/N35D8BrnCXezrrm9K1K5tx6TXzwUMCLB1UeXYg
         hy4LcaFPq25G6bYreEmmXKFnwzoBCFKBJ3rQw7BbEot3TFA6SgddrXOriwokhntb1c7D
         +ZtnAAEnjFAOneYh5tgGAr771m+ySvGc5LAVOHkSmTZbpuXsBgOfhpLdy3oSg91Mx7cV
         0UDQJ9t75PJbzECuts26j3ZF1oI4f7Xrdekd/OodEqAfbUY18dqE92g5Lk5oCh8KqhCQ
         IkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721552247; x=1722157047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDb31VIAAZnMZQZyGzdpC/AMxekr4nZrMgLoDm9Xh0w=;
        b=CL2DgGLhpPVfNAxkY5XRwnbkjqyc1ngj1JPNpa6tyHPWUDtCUBJ+HG8nXazIy9ZjWG
         XW/4hXaqbgMSQBHliQi0Scj6fkxojicvI9DQ1mGKJPrdLXvQKxDHN4upUNo/dA85X8H4
         nwvZ4pL+3W8M+k9yYDETTbKDDn/yiD04QjF49cxZalbLgs8lbIr52GhVNQH4Qw/4R0al
         POPaxHXjxQ1+nkcsZid6DDAj3mgPTlk3EhvcKC9yr40exibJt4g1XcCTZkayX1gv9DuO
         nQNlo+eIndhzK6fmRXUYMMOtIUK+HTIit/Xm9c1+B94xkPW7DgIveZB/OJzXlTx106y2
         Cn+g==
X-Forwarded-Encrypted: i=1; AJvYcCXYQ64mBpaC6SMfik2Ft+SOLH6AVD0xVug56cJk7ECYH9O5gjURhcbkOgqQIL0+SZz7SkxrcuDsx3bdrmMZRYOGC8wRVpUzdNmNP8ek
X-Gm-Message-State: AOJu0YxbLOpBbgkNI8JRRcnvAqb6yaeZVVJjujkgpZ9EUJmiKBxt18Za
	iPzB/lP4nONWBg3n0+InoRVEGrFAsho76V+Ev29XEvdmyjfG0xz144cGmVH5FA==
X-Google-Smtp-Source: AGHT+IFG19OdyHP4d6XceobkYzegzSAkNQp0BCqiwoPMi57fvEKNHMsJRAIJIqrDHCHN1uU0CnaU4A==
X-Received: by 2002:a05:6e02:1d15:b0:38b:48c9:55be with SMTP id e9e14a558f8ab-3993fdc748bmr48900565ab.0.1721552247590;
        Sun, 21 Jul 2024 01:57:27 -0700 (PDT)
Received: from thinkpad ([120.56.206.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d23966e35sm446548b3a.108.2024.07.21.01.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 01:57:27 -0700 (PDT)
Date: Sun, 21 Jul 2024 14:27:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: dongxiong zheng <zhengdongxiong@gxmicro.cn>
Cc: dmaengine@vger.kernel.org, fancer.lancer@gmail.com,
	linux-kernel@vger.kernel.org, vkoul@kernel.org
Subject: Re: [PATCH RESEND 1/2] dmaengine: dw-edma: Move "Set consumer cycle"
 into first condition in dw_hdma_v0_core_start()
Message-ID: <20240721085723.GN1908@thinkpad>
References: <20240705141241.GB57780@thinkpad>
 <20240706084010.2094-1-zhengdongxiong@gxmicro.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240706084010.2094-1-zhengdongxiong@gxmicro.cn>

On Sat, Jul 06, 2024 at 04:40:10PM +0800, dongxiong zheng wrote:
> Hi, Manivannan Sadhasivam:
> 	Thank you for your reply!
> 
> On Fri, Jul 05, 2024 at 19:42:41 +0530, Manivannan Sadhasivam wrote:
> > On Fri, Jul 05, 2024 at 06:57:34PM +0800, zheng.dongxiong wrote:
> > > Two or more chunks are used in a transfer,
> > > Consumer cycle only needs to be set on the first transfer.
> > >
> >
> > Can you please reference the section of the spec that mentions this behavior?
> >
> > - Mani
> >
> 
> Reference:
> 	Chapter 6.4.9.1 LL Operation Overview:
> 	"Figure 6-23 Linked List Flow for Producer and Consumer" in
> 	DesignWare Cores PCI Express Controller Databook (Version 6.00a June 2022)
> 
> The CCS must be set when L1 is executed for the first time, After an interruption is
> triggered, CCS does not need to be configured again when L3 is executed.
> 

Okay, please include this reference in commit message and send v2.

- Mani

> > > Signed-off-by: zheng.dongxiong <zheng.dongxiong@outlook.com>
> > > ---
> > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > index 10e8f0715..d77051d1e 100644
> > > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > @@ -262,10 +262,10 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > >  			  lower_32_bits(chunk->ll_region.paddr));
> > >  		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
> > >  			  upper_32_bits(chunk->ll_region.paddr));
> > > +		/* Set consumer cycle */
> > > +		SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
> > > +			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
> > >  	}
> > > -	/* Set consumer cycle */
> > > -	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
> > > -		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
> > >
> > >  	dw_hdma_v0_sync_ll_data(chunk);
> > >
> > > --
> > > 2.34.1
> > >
> >
> 
> Test brief: hdma set chan->ll_max == 1,
> then user alloc two or more scatterlist, start transfer.
> 
> --
> Regards,
> dongxiong zheng
> 

-- 
மணிவண்ணன் சதாசிவம்

