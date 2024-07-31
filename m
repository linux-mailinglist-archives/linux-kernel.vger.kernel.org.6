Return-Path: <linux-kernel+bounces-269487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81741943358
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33AA1C24358
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B57179A7;
	Wed, 31 Jul 2024 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uklcBgCK"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32D717579
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722439779; cv=none; b=P803hLGwVPl3j0prg/y6idJY3BHkJoybZvNYBOdNF3sUC3V1X/S98KnWSAvIO6fbuvypQ/C4QkXd4OevUpxEm7r2ih5yNNs1KyZm+ZyMzjmH9woIXRzbPhyu2Gwf9V3OZfBji7Aw+nZZgvZnb1bRqK7hT76DZP8QxlKhZZXQYk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722439779; c=relaxed/simple;
	bh=NZCQjk6qu5JDjBajzKBkR4b+8Bvfj170BGd69g2rUBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkeOFWDI70Wk1vgGH6byn5i4KQ0aedoRkc1WM371sLmAPy3xfeYOYN2Mw0ykLFP5Rqo0eaABVRje9xfiunCg1lukTWyqUtA080SeH6wlEgCbS/Hua1hhwxBnGmZQGC/gKAUJqh9FQ8h53xlM1DZB1xdUS8TroeTFa6npVaVqSXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uklcBgCK; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70ea2f25bfaso4222703b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722439777; x=1723044577; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mCJpeaoOc2bazfPbXFaOP8MpVPnQ8mFYIONeim+kxB4=;
        b=uklcBgCK+2PHBGlzB1Yv9ywglXT0WO1cGKWhRy60ycm0AQvBCFwTtN6xvCy5WJte/c
         TcDH4bcYT0URQllM2Xbf7drHaHSW23GMsDIo2aIP3urX5dk84NGhQ1xXPFI1HVyoQP6l
         HB9rrfc15NARJCuLO7Biok0mg8kRfevznKb+2gYaYfyXbtEkrdqbvmtIzUhqPl93Rn7s
         z2goQtfK8beha6HXlGf8RFVsgRjU4ESLVhdq4SHFM6j+HlCnCvrry0oDbMwv4ZMr92ll
         K28x6DaWQ/aIgpLIiuzrKIH1RLr7XR168NaKRyg56LMkruN82IY0It33W2r9ReBsF18P
         RuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722439777; x=1723044577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCJpeaoOc2bazfPbXFaOP8MpVPnQ8mFYIONeim+kxB4=;
        b=sEMxL1rKLExJuKQ8Vr/fvNE4jiQeU1+qtG3VD/hmEnkcTkVIf6NkyVTsObKn5Zzqmi
         dfjsmkYIurlwUhAyvnzyfikdg8jO4Oc+KyocXoB5UDh3yb1uGMMIP+DPQWC+XJbXgis6
         zPpNn1xhkxOKE+MEew2XX4EvbwawhxRv7dXwns0khCZKJxp3NrRmnmZl/xfC0sdQM2RY
         f4LrZYQgbXgKhoklJJ7x6SYrJ3PRTRjGR6rwwBS0MlLOzHhzeIaJhMWfnfke4Pd+rc7k
         9pTsHuEJTOpE7FdRBc4B0L2GqJJSXUmEphcUFRIJj9p+/gZIW8G58PNmJ48uwthvP0oN
         8ceA==
X-Forwarded-Encrypted: i=1; AJvYcCUkVa/x6jhw6bqLOgYmKZ7aH0/Oi1fEvMWw24R0uf9A3S4OZkDHzJOeKouAVmcKKK7++/V0t+NtgWQBaWqs7+QRJ3IpgwLqbuMifPBs
X-Gm-Message-State: AOJu0YwhR/KkIP0i/sqiovXL6NQS0oa+yOWwmEQQiOF5XlTPkmeYTrsF
	wR/7QO+wwLmZwArKWTDyyCmQd63dbThgN2B5bMa9trprPmm7GfE42jzs0oeVOiStjDIBuo1wifo
	=
X-Google-Smtp-Source: AGHT+IGohm1cBq/5zPvLuLsEzQNZ6TosNInwk8VMcHMzDiwyENOeXQOhAAUH2+CrOsko17rLYuRl0A==
X-Received: by 2002:a05:6a21:3483:b0:1be:ffe4:b2a2 with SMTP id adf61e73a8af0-1c4a11796a5mr13080164637.7.1722439777291;
        Wed, 31 Jul 2024 08:29:37 -0700 (PDT)
Received: from thinkpad ([120.60.66.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e333asm10071047b3a.8.2024.07.31.08.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:29:36 -0700 (PDT)
Date: Wed, 31 Jul 2024 20:59:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, kishon@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: qcom: qmp: Add debug prints for register writes
Message-ID: <20240731152928.GA2983@thinkpad>
References: <20240730100351.51454-1-manivannan.sadhasivam@linaro.org>
 <ZqoY5kFLDEmkb495@matsya>
 <knjl4q5zyqz3wrqp5aawgpxk6aqggvteb72enpsgweulgrxmnu@ol42qtug4xvi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <knjl4q5zyqz3wrqp5aawgpxk6aqggvteb72enpsgweulgrxmnu@ol42qtug4xvi>

On Wed, Jul 31, 2024 at 03:18:31PM +0300, Dmitry Baryshkov wrote:
> On Wed, Jul 31, 2024 at 04:28:46PM GMT, Vinod Koul wrote:
> > On 30-07-24, 15:33, Manivannan Sadhasivam wrote:
> > > These register prints are useful to validate the init sequence against the
> > > Qcom internal documentation and also to share with the Qcom hw engineers to
> > > debug issues related to PHY.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/phy/qualcomm/phy-qcom-qmp-common.h | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-common.h b/drivers/phy/qualcomm/phy-qcom-qmp-common.h
> > > index 799384210509..e6a6bcfcac28 100644
> > > --- a/drivers/phy/qualcomm/phy-qcom-qmp-common.h
> > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-common.h
> > > @@ -9,6 +9,7 @@
> > >  struct qmp_phy_init_tbl {
> > >  	unsigned int offset;
> > >  	unsigned int val;
> > > +	char *name;
> > >  	/*
> > >  	 * mask of lanes for which this register is written
> > >  	 * for cases when second lane needs different values
> > > @@ -20,6 +21,7 @@ struct qmp_phy_init_tbl {
> > >  	{				\
> > >  		.offset = o,		\
> > >  		.val = v,		\
> > > +		.name = #o,		\
> > >  		.lane_mask = 0xff,	\
> > >  	}
> > >  
> > > @@ -27,6 +29,7 @@ struct qmp_phy_init_tbl {
> > >  	{				\
> > >  		.offset = o,		\
> > >  		.val = v,		\
> > > +		.name = #o,		\
> > >  		.lane_mask = l,		\
> > >  	}
> > >  
> > > @@ -45,6 +48,7 @@ static inline void qmp_configure_lane(void __iomem *base,
> > >  		if (!(t->lane_mask & lane_mask))
> > >  			continue;
> > >  
> > > +		pr_debug("QMP PHY: Writing: %s --> 0x%02x\n", t->name, t->val);
> > 
> > This lgtm, but fails to help when offset _might_ be incorrect, including
> > the offset value as well (not just the name) would be better imo... 
> 
> Can we please use dev_vdbg instead? Having dev_ part makes sure that we
> can not mismatch PHYs and the sequences. _vdbg is less important, but
> I don't think we want this in the log messages unless absolutely
> required.
> 

I'm not a big fan of _vdbg(). IMO, all debug messages are verbose and if
enabled, user intend to see it. So I don't like one more level of
comparmentalization. Also it requires us to feed -DVERBOSE_DEBUG...

But I agree with dev_dbg(). Initially, I thought about it but forgot the fact
that we now have async probe, so there is no guaranteee that these debug prints
will get printed in order.

Sent v3 with dev_dbg(), thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

