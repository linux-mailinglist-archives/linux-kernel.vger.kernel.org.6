Return-Path: <linux-kernel+bounces-254084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23484932E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C841C21F86
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A736519AA66;
	Tue, 16 Jul 2024 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="saqgYE8M"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2251DFD1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721148395; cv=none; b=bn7EOlg9JZvyouCt1bkwF90cdyEu97ZVUvRmXNBVWZAwMNfIFG2TQSxoWx5VdTao8WuJ75X84FDhOQbLbZ4fcKThk0lPwZvzLijeEw0rSF1l/DAFwEH0pnWgucRqcSuWsTywSKHX9bo8TPY48ImwctV9VLZ5xYJACjzQCLXTMkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721148395; c=relaxed/simple;
	bh=/uO28JIzVjT3o+pteNKJcM0A5ixMT0fdtKUaIBjY+XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wzk7dHFOoKa8uu9m0jTFzPs4pe/JJgrbC6OaiTWNmw04YdSh9CX7xZiVIMkE4qWMEBi8S3RBq5lYu2J1ApAPi88tncGqXR/idI3cLdnzLZNlgV+mPv/HHQ+mAE1rZLM8fbmX8RKVd6LznVJ9EPoCSfry753wsSE0LF1Ke9L+byM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=saqgYE8M; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ea5765e75so6988087e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721148390; x=1721753190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UdlcGvPV4rMkeD613/ZfNJun3YfIW1JB7Y540EAzI4A=;
        b=saqgYE8M0ftR2nbP5DxHECYBBnLZaf4K3mgxJwXRQWPIohsd5GZ7gFu2w+AbdivJBI
         T6PxtFRY0zshmzfSobXiOV/IHV2ILKu2g0awIbxv4VekTuE+4F9cWNTDCYSEsdutbCo0
         9M67xcWKOZShoEPxq/wd1gCEE/LStzL1V01c3uT/CJFOA9watrRtMPEHZBpVxPQGvm02
         vPVYLDHfVDsJAqsRq6x8dYZlbpzNbeW/Re6AzfS2Qqc+cXPw2lU7fiQxxiVDe29bzzfJ
         9EdYBkccpH9JT/xrscrs8JRjgA3o+zCH4t37ldGA+3U2PYd9AQ9oF2Z9S//dSGIqTh3I
         B3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721148390; x=1721753190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdlcGvPV4rMkeD613/ZfNJun3YfIW1JB7Y540EAzI4A=;
        b=VSQoKWDEni9pOi2p6Th/3FeEfPWLJgpcJ2QQixtSLosoAeHko5V5hWL+bnfL4VO+Ba
         XhKvDpbHmZ9J2layb4LRHgRH/XWET4bFIBBFrLAU6pV9qNoqlpw5NY5o3lLIiDSDvPZK
         4p4BXN0dBBIsjcnrPWIy0cK3zBcECFjFb94ovlTIS4sl12eaPgd5nIABV0D8u9tRkipg
         yxvLj6qJGd/z6zP7gnEtOl0MKQUGNyzezOEoUDRIayPOMwX9BSnh9XHd9a7kzSXGNGX1
         4MiWZ4aB4L/FXUcAb49WwAvIsa4bK8OLxcukfndR6wH8XYRjo52eU/Lee7L+UuYg7+7N
         bq/A==
X-Forwarded-Encrypted: i=1; AJvYcCUDKcY7qv2GxVlsfuvHSpnurtzX1A+CWGJeFHqkzYH+b/O1nTlItKIIVOk+rbjUGDyF90e5d3LUwJKk1y+267G8o5jZZElDkA0V1H7u
X-Gm-Message-State: AOJu0YywYzR8BxYZejomvNVMD9s853AeDD3TG+8mE4b90LPjB3+i4+R5
	XL0G+t1ccDik939EJGnbTfUq4ElO6m9+BjFemJbyeU3jy1vhJAOZ4eF+/c6/unnLHT6y6PKjjIT
	2
X-Google-Smtp-Source: AGHT+IH1Umt4AGKUi97EA/xp39tZETdjijAkzPUgbnJvzG0aE8B3zUOXJakTJA6Nzb4q5X83AOT3QQ==
X-Received: by 2002:a05:6512:3f29:b0:52e:9d6c:4462 with SMTP id 2adb3069b0e04-52edf01c462mr1777240e87.23.1721148390000;
        Tue, 16 Jul 2024 09:46:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed24e2b66sm1202263e87.59.2024.07.16.09.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 09:46:29 -0700 (PDT)
Date: Tue, 16 Jul 2024 19:46:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: neil.armstrong@linaro.org
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Taniya Das <quic_tdas@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] clk: qcom: dispcc-sm8650: add missing
 CLK_SET_RATE_PARENT flag
Message-ID: <kxrhhb3vdojbnqfbwks2qmob55fwm3onleood73qfk6esl7g2c@q66kw5am4emc>
References: <20240716-topic-sm8650-upstream-fix-dispcc-v3-0-5bfd56c899da@linaro.org>
 <20240716-topic-sm8650-upstream-fix-dispcc-v3-2-5bfd56c899da@linaro.org>
 <dccttz5b44bl3lwmcaqz6wjx3n4sv3eq4yh6276vzwrtkcvqcw@qxhbo7bylnsg>
 <9ad10d92-d755-4fae-b206-6e8648be6d48@linaro.org>
 <CAA8EJpr9L+AKDhuHfQa=Nco7fvG9vLH3a+gxVhENrhz12b3n=Q@mail.gmail.com>
 <278354ec-532b-48de-8ee1-5477ddb4a285@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <278354ec-532b-48de-8ee1-5477ddb4a285@linaro.org>

On Tue, Jul 16, 2024 at 03:46:24PM GMT, neil.armstrong@linaro.org wrote:
> On 16/07/2024 15:44, Dmitry Baryshkov wrote:
> > On Tue, 16 Jul 2024 at 15:32, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> > > 
> > > On 16/07/2024 13:20, Dmitry Baryshkov wrote:
> > > > On Tue, Jul 16, 2024 at 11:05:22AM GMT, Neil Armstrong wrote:
> > > > > Add the missing CLK_SET_RATE_PARENT for the byte0_div_clk_src
> > > > > and byte1_div_clk_src, the clock rate should propagate to
> > > > > the corresponding _clk_src.
> > > > > 
> > > > > Fixes: 9e939f008338 ("clk: qcom: add the SM8650 Display Clock Controller driver")
> > > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > > > ---
> > > > >    drivers/clk/qcom/dispcc-sm8650.c | 2 ++
> > > > >    1 file changed, 2 insertions(+)
> > > > 
> > > > This doesn't seem correct, the byte1_div_clk_src is a divisor, so the
> > > > rate should not be propagated. Other platforms don't set this flag.
> > > > 
> > > 
> > > Why not ? the disp_cc_mdss_byte1_clk_src has CLK_SET_RATE_PARENT and a div_table,
> > > and we only pass DISP_CC_MDSS_BYTE1_CLK to the dsi controller.
> > 
> > Yes, the driver sets byte_clk with the proper rate, then it sets
> > byte_intf_clk, which results in a proper divisor.
> > If we have CLK_SET_RATE_PARENT for byte1_div_clk_src, then setting
> > byte_intf_clk rate will also result in a rate change for the byte_clk
> > rate.
> > 
> > Note, all other platforms don't set that flag for this reason (I think
> > I had to remove it during sm8450 development for this reason).
> > 
> 
> Ack, I think this deserves a comment explaining this, I'll add it.

But where to place it? This applies to _all_ dispcc controllers.

-- 
With best wishes
Dmitry

