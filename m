Return-Path: <linux-kernel+bounces-306469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BAE963F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC4E3B2323E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA9F18CBE9;
	Thu, 29 Aug 2024 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ngNcxurT"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753F0172BDE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922253; cv=none; b=llXIjuD0WZq84mtN1Ha2vLUIndPC01zB74/oOZAKszY6oIUcVm9dtkFrP50BkOxvfWLFRav9Wvq6BiQb7PQKJkYqruiuUEDQhd8V+69A56Ge26thB2WifgDARQXc1JMuBxH7x6QNNfdRJby+aeXNy5vMYTMUi7uMXrcYEwk7SzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922253; c=relaxed/simple;
	bh=Q9bYj/5f0M7H1HvllWqBlYFk/0euewRtVGILkmAMdCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbmlODx92LCP/rtbp/JPudPzUf1+INOMxDUmV+K7FS9XkVy9zpbWDAVrgbpW4J4bMkCYiNBvpVEFb4aIthunnAoDYxwWmtOzxad8EbaXzquqTw9qy2iFbJsYaeeua6eXUQ0a9VN3zH40lo6DL40N7uxzDvAaBA59fHi8mZKR/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ngNcxurT; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f4f8742138so4800441fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724922249; x=1725527049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LQhYCSAf0lZ9zTdJ5ehTCVXsoJJBlJOqEhmha6ZTv8Y=;
        b=ngNcxurTAanOfoyum/lkCpr0aKSWmSe52c2VRy6h3aX+fPwRWGHyk7tA8asQRgKBGe
         45g5QqPPpTSd1flyyuzNG7ArdG67OVQAKdKaDgkmvC8lHDxH8ckw5rzvi+Rw4F6W+SyQ
         oQlpsD96dEHGJpA6R2A/2PT4o412UsTqBrl9c/pkT0BQxw64ppgl9V1LcsYTEKkpzJZl
         IsVxXpoTx1kTPNKZ3P+Rce9FV7K0xrTSXdz0UCczdN41K8++bI5Kguf7Q77+GGxmmcNk
         V8Iz5ENg5mqN8iDfjpDHTrY5smgkv1J9bGE/Hep7/Yr8qXMjYaNYhLhVMhKWqMCBCpwB
         Pwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724922249; x=1725527049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQhYCSAf0lZ9zTdJ5ehTCVXsoJJBlJOqEhmha6ZTv8Y=;
        b=rJGaA8zVMRDYGnD7aIj/7OGEPx/WNTq5d1zTrDozy4WtLs5AyU+8zqAdItiLGbyH8W
         cl2u33V5phI36J+6Q8ooiOKoCd8wl1r4TYK2LaXBo2n3wSv7RhttB6OgVedMAjCNUggZ
         qRP8BfAnZZiXIFPSxNWDISIAs8c7YilO/xIAPYOWUpOq36ZMRNMyDrOiHdVy0vNYRUjm
         IHslalqZn6n1rFoa29//6OEPNC9AVH2xKQ/hWK+UTS6Yd03nEn7S+POGJzEsqW0SU6Qq
         T+coavAinLAc3vjCuTiNO0UuRClt6988wUjeazvjhYvu4ik4PPO/nbdTw46UoT+d6UPs
         6z8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoX2mV/p1Cf/YV/wgIdb9oKLHfgeoNXE+qPhQGUGxN86vJDYr5I7sCGC6b/jkmaHl90/6XMl7ohx+TU/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuxfd56F1P6/suDInRalrG1L9NJOzOdyjh4dvl7hb1NjziTFcd
	JBAPWJp42AcvnKr6WBVDJSt3d5GnGvrdtvSsTNqXOKebXxdXmq2UoiuhMWm0KjM=
X-Google-Smtp-Source: AGHT+IE/qXx2q84dxT76THTRzMY5sKyc3VDj8MyI+BTpt6oDqkE11zyAxjt+tBhXkDbZgXuT7jScDg==
X-Received: by 2002:a05:6512:31d4:b0:52e:fdeb:9381 with SMTP id 2adb3069b0e04-5353e5acb08mr1393344e87.43.1724922248778;
        Thu, 29 Aug 2024 02:04:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354079b729sm100734e87.49.2024.08.29.02.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:04:08 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:04:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jens Reidel <adrian@travitia.xyz>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@mainlining.org
Subject: Re: [PATCH 1/1] ASoC: qcom: sm8250: enable primary mi2s
Message-ID: <egicpgs2l4wkthb72hp2clleh2yajhjrkmuceok5hbjnfbbqft@64aendbltnls>
References: <20240826134920.55148-1-adrian@travitia.xyz>
 <20240826134920.55148-2-adrian@travitia.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826134920.55148-2-adrian@travitia.xyz>

On Mon, Aug 26, 2024 at 03:49:20PM GMT, Jens Reidel wrote:
> When using primary mi2s on sm8250-compatible SoCs, the correct clock
> needs to get enabled to be able to use the mi2s interface.
> 
> Signed-off-by: Jens Reidel <adrian@travitia.xyz>
> ---
>  sound/soc/qcom/sm8250.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

