Return-Path: <linux-kernel+bounces-270870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFCB944674
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77175281768
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E5C16F0C6;
	Thu,  1 Aug 2024 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iz3D/2C/"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7020916E863
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500533; cv=none; b=lOwGNV46WdUrORHbh55296BK8E/yhmlYafowg7n/frqWBh+ERvIyN2tCdI6828RwsnWkwBBsYulLtYbk8KfMaULoG+3Pu5sGFK7LI+sHv/4lQ+4fLXccwQAO4sbOxN11EXiOPlDZRsypWmdpC+bGAi6FIQkEMm828eg29oBFaZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500533; c=relaxed/simple;
	bh=Lj5WaqXJuWUxej3bN+cB67l8CzP+0YvJ2jfDGim+ar0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXjBTWTxz7p5kyr8WKlA4a85VWOzC0injI5mmr4PUvIK/nQGFfzAYKPdmnNiKQvV7zbEUOaVla3DHtZO1CxgWfT25Sn7Ms9S5tdxkvwSFkseeOiJ5E95hXSW3WfX0M2BUzSlcOPAB2H4xj9tYa05bUw3zklOXX7RoSMEdsj0luk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iz3D/2C/; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52f00ad303aso10383718e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722500528; x=1723105328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ic688ABnHK9dnIqd8IRXkp3C2Ibaz6wM4ecnZGzWKWI=;
        b=iz3D/2C/ql2jVaCgeOW+/X5d87DpsYVXgu3oMTxww3eormpalR+XAPjPpTUlo7EqFo
         8uKiZ2/NKjxuL+4d0iSg0MIlQPvYZbqvK/YvZm9RqSUyF0VPV2veS5QWJIwMUuWiN1Ls
         aEAbMVimNU2GIwrLfOFHcS1bgnehSCSGxb62vwmEHG5vlO5Riw7jW9AKTBEwvKpYyBw5
         zhpDLOgyPZLO47bMwdSaLsTOx9aLFy0gy3xcDDCwf1fQ0s1a+2EHC5WXytInS37OsdJL
         ptJ4kKKHFo6/0ON8sPWJS1GP0PUlj9DuZ6i8WWLJ76F+YLKdtGhS9Xs6LOkTl35rs/AL
         M7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722500528; x=1723105328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ic688ABnHK9dnIqd8IRXkp3C2Ibaz6wM4ecnZGzWKWI=;
        b=AL7zB9Jaiec4Jt6DqtigSOyBoNtz+LtIHr8DmyX4DFxboZUXCUAFL41AC7w73q9AoQ
         IuvNvoM3Y5Z9l6CT6weXZIyxx+VDDW6j6S+xNFHMw0xk5406YCj7i6kHIiowOmLa65Lx
         +DGFbsGMl3LHVkZlfNNGvbFbTDoczxEtIWfJrPViV26c+YT96JCsA8GmFv34vYd1Yj7+
         Irlq1uieMU6NJNYueOPkilvoHTghh9l7B4huJht17c5BLrDN9yg3QEo7UZlgXL1RuweO
         MaCMHZW5XCr9KG390j+151ngERzibSW+h+BYxgv9TxQvjCsyf6x6cgJapoCCqkq6yxis
         t9Zg==
X-Forwarded-Encrypted: i=1; AJvYcCW5afKPLCrqh0Z77q9OeFzCfF+sq0WYBL8DiZPBTj9J3FgCPsp6aHcIF3Nbrnsry9NNnupYNNhv3Rn24PZdWYBBmdKgvMizP+1mWdzx
X-Gm-Message-State: AOJu0Ywq44jZJZb1J2eaIYUjTLUSWhLTUBIKigxls+ccwqtNOfPGKHk4
	Tu4hSQeR1c8bS9mYlUWa2/LU0k9YrQIWOLaXpAdGuSZl72I8xtPTAzUmEUFMJI4=
X-Google-Smtp-Source: AGHT+IEU2gTkSFpjUy+X02aBFyJl+k2zkHtPytqIxDlmqXYA2ry04XeQb52Cb9OMoFr+jb7GRVU9rg==
X-Received: by 2002:ac2:554d:0:b0:52e:7ef1:7c6e with SMTP id 2adb3069b0e04-530b61f7cc3mr844180e87.51.1722500528283;
        Thu, 01 Aug 2024 01:22:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08ec2sm2528097e87.127.2024.08.01.01.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 01:22:07 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:22:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Stephan Gerhold <stephan@gerhold.net>, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Vladimir Lypak <vladimir.lypak@gmail.com>
Subject: Re: [PATCH v3 4/8] ASoC: msm8916-wcd-analog: add pm8953 codec
Message-ID: <yhkpd35ovohca4gsd5hqxdxskoepwtkxdbdtkwafxnercxploh@4sffdl6mh3kj>
References: <20240731-msm8953-msm8976-asoc-v3-0-163f23c3a28d@gmail.com>
 <20240731-msm8953-msm8976-asoc-v3-4-163f23c3a28d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-msm8953-msm8976-asoc-v3-4-163f23c3a28d@gmail.com>

On Wed, Jul 31, 2024 at 05:25:28PM GMT, Adam Skladowski wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> Add regs overrides for PM8953 codec.
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> [Adam: rename codec]
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  sound/soc/codecs/msm8916-wcd-analog.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

