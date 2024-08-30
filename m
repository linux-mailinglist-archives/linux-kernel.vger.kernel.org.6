Return-Path: <linux-kernel+bounces-308319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C36EC965A46
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B7728D124
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE75A16D327;
	Fri, 30 Aug 2024 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VSVMf61I"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1698916C685
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006382; cv=none; b=kmHbT3jtc5+IupB7ybYy96maUvbeXnzFuliX8F5Z25NS4p89lwx1FTx1BPQ0kGVkH9MQePWil41qVFpzwGZd5L2dU10kTJk7HXP8egiqtlLIobeGv34AtOgNe5dGM6k/UIPy6Q5fEnvQZVgTftkYRtgI/kL91NqIl3lhQr+YY08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006382; c=relaxed/simple;
	bh=e6UmKK1uv4GE4oEQ3Qw87ejtvJIm9dvgZYCtxPS7nHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKdOpwBY3jQMdXBfPBgUzPeA8rLLfojaDz6lQ4rpUHATRw5oP3GZiWGmnUYHDb33SR1jKmEox7tfppW03WFKzC4nsmstPUstb5eueUEJ2sbNv6y9suR5vrVTV2AC4ooD/xhfoJUeZbUXKAoyNciu44XqZJFYby5naScveebj0gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VSVMf61I; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a867a564911so187100666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725006379; x=1725611179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uDSO4akp2KhRfSSRiJYvlvkWluMAutHA5r9aDvMGObY=;
        b=VSVMf61IFmJzTyq/NKbr+n/WIrJ72qCjuQWvF1HHZd6Ij3qdhr1J0q/NMafM6aaG7u
         uKHR0eWhlW6Q4+oFmgkKjBiq5/PKcoabp+14AkEqtelber5GHIov1p4kJWgqDPZzhj0R
         dEWkOSOfAH3k+ALE//zFU9ltqVfe9uX1wv11SxIUf8UyTqX8l0qnQbFp5X6JPXURgjic
         m1jSoTdQm8IT9XiJv2K2Vcqs2JT0rxK8ttez2E7xHCHe9L/PgCI9U/enjwsBefo/xUe6
         gS8rr/CEET8rTBsR1Wa9IuoJlxqVfbN013/mbcu3Rf+JMsfysM0meBzSBmA3lpqxQWRj
         PQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725006379; x=1725611179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDSO4akp2KhRfSSRiJYvlvkWluMAutHA5r9aDvMGObY=;
        b=U6RkSGHSu0VwtqNVt2RGZNd9VjXugxcZC54py3Ztnl1UZkUzP4I+OU/Mh3BEU4iD0d
         Q3tltPOQxpvwyK8ValmPGYOllHBC08SgjR35+agRJPgZJTIn3bM2FIlcBelc5nHdaD29
         VzchGrI9DuR3VSIGsXJE3PRHHiEGzhqS7GqVGxvrW+YeM3OneXDPIKzd1L4dT0rW9J2m
         ctRE/X5lkE7AnGYFOgC0R2e69L0BSNvhBNhemL2N6lxghJNEyBt+EZS7ByWz22y4b/4n
         M4C62VHgVTbOoI/cuKbLxB0wwTZXAG/VTJQpHdCloKUIX882Indv24CyEoSbGFAE4N3P
         Mdfw==
X-Forwarded-Encrypted: i=1; AJvYcCVKBvY4GGxR4w9jgYMv4LI60Wr79VL2I3qj7E/rZKAwkVPZlRd1XNlJMPbv4D57S5Fv5gEg1NMEEV2Pqqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuDkudgyN74aC0zGeJBsO7zWuIo7NJwunkkMXr5G/wcRVzyusw
	QmZCJRY3lGlTchNY6BW1AYlTg3sGODnAyQBHR6nSaQBzJa5dYsso3kVMCSMr1eQ=
X-Google-Smtp-Source: AGHT+IHMd2a7oX2CNchv5nPzpcimaPtAh2+17ZJkKEC5K6QZXNRoCN7DgkRBQORt2wViPlTE8ZcuJg==
X-Received: by 2002:a17:906:794b:b0:a80:f79a:eb6f with SMTP id a640c23a62f3a-a897f77fdbbmr448369466b.8.1725006379328;
        Fri, 30 Aug 2024 01:26:19 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff1f:b280:290:d5b:6ddc:fbdb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89892164f5sm185254466b.192.2024.08.30.01.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 01:26:19 -0700 (PDT)
Date: Fri, 30 Aug 2024 10:26:14 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Danila Tikhonov <danila@jiaxyga.com>, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, cros-qcom-dts-watchers@chromium.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@mainlining.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280.dtsi: Fix PMU nodes for Cortex
 A55 and A78
Message-ID: <ZtGCJincjO7z-WFm@linaro.org>
References: <20240818192905.120477-1-danila@jiaxyga.com>
 <5gmsbbnuc7sbkpptomvpl6aarw5poutvjfav5rilgogb7727vi@nhtr5m24tkmt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5gmsbbnuc7sbkpptomvpl6aarw5poutvjfav5rilgogb7727vi@nhtr5m24tkmt>

On Fri, Aug 30, 2024 at 11:13:28AM +0300, Dmitry Baryshkov wrote:
> On Sun, Aug 18, 2024 at 10:29:05PM GMT, Danila Tikhonov wrote:
> > The SC7280, SM7325, and QCM6490 platforms feature an 8-core setup
> > consisting of:
> > - 1x Kryo 670 Prime (Cortex-A78) / Kryo 670 Gold Plus (Cortex-A78)
> > - 3x Kryo 670 Gold (Cortex-A78)
> > - 4x Kryo 670 Silver (Cortex-A55)
> > (The CPU cores in the SC7280 are simply called Kryo, but are
> > nevertheless based on the same Cortex A78 and A55).
> > 
> > Use the correct compatibility.
> > 
> > Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > index 91cc5e74d8f5..ab024a3c3653 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > @@ -845,8 +845,13 @@ wlan_smp2p_in: wlan-wpss-to-ap {
> >  		};
> >  	};
> >  
> > -	pmu {
> > -		compatible = "arm,armv8-pmuv3";
> > +	pmu-a55 {
> > +		compatible = "arm,cortex-a55-pmu";
> > +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> > +	};
> > +
> > +	pmu-a78 {
> > +		compatible = "arm,cortex-a78-pmu";
> >  		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> 
> Shouldn't these two entries have GIC_CPU_MASK_RAW(), limiting interrupts
> to the corresponding cores? I see that in [1] Rob used masks for older
> SoCs, but skipped them for newer ones.
> 
> [1] https://lore.kernel.org/all/20240417204247.3216703-1-robh@kernel.org/
> 

According to the bindings, the cpu mask bits apply only to gic-v2, but
not gic-v3. It looks correct in Rob's changes. And here too, since
SC7280 uses gic-v3.

Thanks,
Stephan

