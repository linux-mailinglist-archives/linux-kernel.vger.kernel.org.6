Return-Path: <linux-kernel+bounces-253675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E271A9324CC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F87EB24591
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83811993B7;
	Tue, 16 Jul 2024 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hd8nUhB/"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7EE1991D0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128467; cv=none; b=juJPj1OSFUxIe/CZveR9jMbcOXd0r3AhwS1escY/iKhT0nJXhcgw23WysKYUc0AfqWMYCX9M7Mczgo9o849hRm1yIL4uCywkFlWBU9WCyMmpVvz1e6IuU9mwH7tZ7fwwQwAc1ZuwjUaFw1r91OelYsD1oye4kESrjT8qArs3reY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128467; c=relaxed/simple;
	bh=uSU/7FRcOsd+KxgKnvrUWf7fdIpaa2zZXRFytICH0Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGCs/atlzaybomWRG156KmnK6fJAS2ohF7fMqrh7nn2980dhgA2B+TsuIPC76bg6TBqoU4ztoXa7bi0I+VoJnZM/S1kO22X4ijmvjWa+WkoQlkcFH1Mi+6QU0wassqDwLTZZvGu52c0/0p4BU2yWWAEzwUZrYRqcPzZQYSdvYyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hd8nUhB/; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e9944764fso6201720e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 04:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721128463; x=1721733263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=85f26GaihuywFHrHhUzvUmoac6GcFjyo3+D5MhFAkAc=;
        b=hd8nUhB/0HGZer+abo8vixfwv9BmdT3srf1gn+cnizp13kZ54Du4KqZ9OIsr14URnr
         IP8rMYhFxf/1kJN055OUn+y3Ogw4K2Xo2H4Q400+rRW/hpPCW9+6YKqjls6WrTzTnARH
         4/mlsyAiPvhV5RvWaZNS2hLfc93AkNPsLrVLtIJ5Pu/Fw8R0QumLEltQLzUWPHh9PvCR
         FxXKX4H+QZi89EHJE75yk/IyYtNATqPyT/sDnsWtyrUPA3JCxt+DuOJxmi6bL90vdEPR
         v5RQYlLyEv41c/fKizVy9Yorb7v9RAmd+D7RKKfJx0TsgR9Xci7oSbeibC4hCGaVCByR
         ruLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721128463; x=1721733263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85f26GaihuywFHrHhUzvUmoac6GcFjyo3+D5MhFAkAc=;
        b=C5M3P33it5LYurL4hoO+GKm45DZ11Im1r2uRG3S3FTHvD/dLB70fYKc2HerWNEEqoN
         iuOHnHgpRzy1n+QkYDkpza+fQgMhv+gmd/f53nnZaVjlGpHGWIroSHrECBvd8Z3rlN5M
         nROWXIV1TEcatL1tP+arCQxWehDP2gGK+IrTuXqvGz0iiodqtvDfhGzXTQCLOt11g6X4
         vh6nGBFwnP5oyktHej5CNH57z2kK50JJU9GjJYHKUroVjtFs2DIri+FidTZW28WYht61
         zisUZY7dAbUlTzzuNCm1uW2CwD00RLtWZKDjkx84RA0CUiDFw/124ox2q0DpWWY+GFR5
         kVHw==
X-Forwarded-Encrypted: i=1; AJvYcCWsqn4/unLkMoxbAu8ZU6H+cdAbBl0N27TDPqhtSpfwSFH5K7G0kD9xDwswObqACOAuP2MiBNAnPtZ583uePQioWcPRZ3efLQK22sDb
X-Gm-Message-State: AOJu0Yz/v/nwgrcj6n22MghOvz90xLkaFz7xlGWEm5mm6vBZ3Q+GoQTs
	9vyowi8Db9os9oDf3cESwwBy4M+AX8i0IiFPJ12Mi5htvi9OM8v38zAmG78AXPA=
X-Google-Smtp-Source: AGHT+IFQIqSG9+GMvlee2xBU5TyMBzdPzC8eUN9VYPN9K9+xtbawhMMv+6NZ61ZiZWul45/PpPGmEw==
X-Received: by 2002:a05:6512:39d4:b0:52c:d8c7:49ce with SMTP id 2adb3069b0e04-52edef1df2cmr1238456e87.22.1721128463615;
        Tue, 16 Jul 2024 04:14:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed24f32a6sm1132866e87.67.2024.07.16.04.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 04:14:23 -0700 (PDT)
Date: Tue, 16 Jul 2024 14:14:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8650-hdk: use the PMU to power
 up bluetooth
Message-ID: <vpwioxy6aw4xp6d45stftprsqo7rwqe3c66qs3h6ecrzi5sutv@kacd47ux2ozk>
References: <20240716-topic-sm8x50-upstream-use-pmu-to-power-up-bt-v1-0-67b3755edf6a@linaro.org>
 <20240716-topic-sm8x50-upstream-use-pmu-to-power-up-bt-v1-1-67b3755edf6a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716-topic-sm8x50-upstream-use-pmu-to-power-up-bt-v1-1-67b3755edf6a@linaro.org>

On Tue, Jul 16, 2024 at 11:45:10AM GMT, Neil Armstrong wrote:
> Change the HW model in sm8650-hdk.dts to a one closer to reality - where
> the WLAN and Bluetooth modules of the WCN7850 are powered by the PMU
> inside the package.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650-hdk.dts | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

