Return-Path: <linux-kernel+bounces-220541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7B090E374
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5458284949
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AE76F303;
	Wed, 19 Jun 2024 06:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BKz5xUPQ"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D5155897
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718778724; cv=none; b=kTuDHLDF9LJYO7/Ha6l0Rqn6QzqB40v0vnLRarAxvetnRvo2DkqbzHdVIBTpKvfFVyz4izj8sgMWBOMwO+mWI9/cBtuRLUKCYCQACfdFX99FCAyc14g1xWv+XR1uULGVAgM9oFbCYP3+gGPXpfvfTQAItnqXonZ0DRaJ3FxTgL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718778724; c=relaxed/simple;
	bh=wFDerXuVfghJpTiIPsRtXmgYzrOV0DCn7nuFZy90qrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpKjsoAAaeqOElKViOBB0CT2ErWOSJ2t+4C/ev1P6qcxCKO/oh4DzJ5Xt9zwRgyxJti03XYDBsKUM5YXyjBLo2lm5P7zTC+m8/NJ6hJ+XZkP0VZQWeQmAzYjMDBkKM0CKl01EBWA5UbE5P/JnuLToZqCdkQqHxpeNMGcQP6t2dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BKz5xUPQ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cccd44570so216831e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718778721; x=1719383521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kWA6TxZL/MZl6HZnFwnJJBsYFPvFUHxiD6fzJli2OEU=;
        b=BKz5xUPQH5oe2m+oz6FIakh8YZgserhH9FwPYhDJIV7S3mTJ2hL6AXVPD2P3ceKBP3
         d9JdM4lEru3xVZL5maYySHMxhFQ1gccubinwgylgdTZE4qKRwq/vIA+eltXrqzsbLitM
         FGYcfMhG3ZcMv9+33hWSoBJaA3Suza9xdPjx/qxerRghj8r4Hf/tfm6C37uiiOFXBht3
         /Zu/yp1Duwm/o1OdtskCt7sJ0f6PXXaqI0NUq+DSy4EakEeKk1XWubK3H2BMmRvv8b9T
         FftwEDmm7DCTPHg5h6WBzj3hZ16MDviwmStE3cpL/sagMj+p0dpsCFRoV7zdKVUUA+El
         44LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718778721; x=1719383521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWA6TxZL/MZl6HZnFwnJJBsYFPvFUHxiD6fzJli2OEU=;
        b=UrsPROz3+49mZRbOtaBCpzlYmv3u1IIrhHMjkpry+kCvYoswOtMLHVZL0W2kkUXz6T
         UhsYYBtBx1CGaL+hB09bOwIZuQ1+r5E2qUnhymWkWmeGOfOlX1/kZ+Dl55DIoAiu7uZv
         KILlvtPAqZHKjhoBoDN6TTqvDw0WULBappFkzjpmOuevAJofGt13F1k7o/s5YGk0ZMrx
         X2dWlDNqPSC5CA5teX4Yx6WXtuL8wV6vXRfmfQsdSKNHGPpwl/NdoblxT3OUhnctG5ck
         yEIydqMpGEI1Zt1369/zIrzz840vwVZwd1/C8hNY3863BNo9DpCuaBB6QDbWlAKampR7
         VlKw==
X-Forwarded-Encrypted: i=1; AJvYcCWCaBl7hPOIvaBzC6Jy5Dj2oisU8kY6FwQv8H64acpppMfPugKUN6X7kPepWnxjFurJO6RLz8iwutCMNGf4P5+aTYgd57qB3pGbhRDX
X-Gm-Message-State: AOJu0YybN/F6zHrqv7ntoCoWy93eyJhWbaURGw9SNxUBaHF2ZmHP3LDE
	HR33TlRlisqCFGk6PavkuksIvX0TcYcHrXTq2uzvk2ID8VsDDxz3yEnC8tFYmek=
X-Google-Smtp-Source: AGHT+IEESoHV+TTf90PdN7pLxmBm3gZ0xMUk7VRL1azohO9LT1Z72CZ3oFQjtGbrIy3x/5u5Qu0uhQ==
X-Received: by 2002:a05:6512:3d04:b0:52b:c262:99b3 with SMTP id 2adb3069b0e04-52ccaa5693emr1070573e87.11.1718778719107;
        Tue, 18 Jun 2024 23:31:59 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cba181738sm920583e87.255.2024.06.18.23.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 23:31:58 -0700 (PDT)
Date: Wed, 19 Jun 2024 09:31:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>, 
	Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
	phone-devel@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 02/23] gcc-sdm845: Add rates to the GP clocks
Message-ID: <n7gvt4e6kt33lpnfivv4t2waro2t4qi4evkrfot3j2en7ubffb@gpzwolihwemr>
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
 <20240618-starqltechn_integration_upstream-v3-2-e3f6662017ac@gmail.com>
 <wnf3mfgdm4p4f5wrxdtlx4wccnizdvohc7iiyu5t22eeb67r57@xun3r73hksrg>
 <ad04e203-4244-4cd3-9c9a-fae002962990@linaro.org>
 <lwrz4rvn6ogseea5v6j7plc3yi3xnzo76dvrsl3muat3iswlkb@zmwa3xo3xgw4>
 <85e03d10-59a2-4f15-bb85-7b2c0354a5d1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85e03d10-59a2-4f15-bb85-7b2c0354a5d1@linaro.org>

On Tue, Jun 18, 2024 at 09:11:58PM GMT, Konrad Dybcio wrote:
> 
> 
> On 6/18/24 20:55, Dmitry Baryshkov wrote:
> > On Tue, Jun 18, 2024 at 08:50:52PM GMT, Konrad Dybcio wrote:
> > > 
> > > 
> > > On 6/18/24 19:50, Dmitry Baryshkov wrote:
> > > > On Tue, Jun 18, 2024 at 04:59:36PM GMT, Dzmitry Sankouski wrote:
> > > > > sdm845 has "General Purpose" clocks that can be muxed to
> > > > > SoC pins.
> > > > > 
> > > > > Those clocks may be used as e.g. PWM sources for external peripherals.
> > > > > Add more frequencies to the table for those clocks so it's possible
> > > > > for arbitrary peripherals to make use of them.
> > > > > 
> > > > > See also: bf8bb8eaccf(clk: qcom: gcc-msm8916: Add rates to the GP clocks)
> > > > 
> > > > Each time I look at the table attached to the GP CLK, I feel that it's
> > > > plain wrong. In the end the GPCLK can in theory have arbitrary value
> > > > depending on the usecase.
> > > > 
> > > > Bjorn, Konrad, maybe we should add special clk_ops for GP CLK which
> > > > allow more flexibility than a default clk_rcg2_ops?
> > > 
> > > If we can somehow get max m/n/d values for all possible parents, sure
> > 
> > Calculate them at runtime?
> 
> We'd be calculating the mnd values for a frequency that's either equal or
> reasonably close to the one requested. My worry is that we somehow need
> to get the maximum values they can take (unless they're well-known)

One of the options might be to force devices to use
assigned-clock-parent to set GP CLK sorource and pwm-clk as an actual
device using the clock.

-- 
With best wishes
Dmitry

