Return-Path: <linux-kernel+bounces-510251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5AFA31A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9233A2914
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4014A4A3C;
	Wed, 12 Feb 2025 00:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQfYLtYd"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DFA79FD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319374; cv=none; b=UJ4C1T4u+s8tfxS8uSHM+vxMac6mXYfAaeB/iJ5E5nYyTFKp6ajyQJfTOqjtPWLkZDM3oVzSI5vxQA8DUDaW691esD9Z3g1pVpMQrsgfmb/FHMKj5K+G23KGV3PMf8Gl7dJ7BGsxoqGqMcGhU7VdJ6t43a7I2VPbd6wLahF4gRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319374; c=relaxed/simple;
	bh=Fnjc85tFo+DRqushjTLDrAr2YQG02n0rclwpTAv2Swo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsq8yiCRk/jIuO5i/B0T616Tn8ZUdFn9TZzq6FzzL3ZNWfHL9Eie0A1mzw+rQO2A0vcAi3lA8soXeS13fhgo9CX4lB7+DJHzoYRxa/uPsqYFFLjOR/s5fpWjfNoF3l0dWcYcwBVNByYY3skygGAma/5ssN0P/smI6qaWWxSM1iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RQfYLtYd; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54508b026d1so2872660e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739319371; x=1739924171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xdffwztOvMIrK2jjolf4o8Wr6ci4Bs53P61Nbn3lItg=;
        b=RQfYLtYdxr2g0RDE37LwdJH2jRiDZmakJ7p8zlyRwxTyxL7SDEFyHjuCVtFOp+Hl65
         V6TU1Wo9MkNMDs0Wuife11Nwv3jL29vGCcmRNk/VjvznIWKU04vSWzCE4bbidN9IK7Sr
         /oR40yfveV5qNYhWMXbjiTi1782y3o3C03i+8xk1iJCoqLvKuaKq2Yk5K0Gk6QvwH8YD
         TwMm1uXfyiB2kPGeFf8QC6d8zlfN91SQJFVGL1Q4oP70UW5wPuhKiLa/DcPWT26a3PgQ
         xyxcNVkrF+rmlnUwey09ZGmdaCo7W+07gW/s0fAi9B6yVqAXTAz3YGk7ihX5KACSoSDv
         Oslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739319371; x=1739924171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdffwztOvMIrK2jjolf4o8Wr6ci4Bs53P61Nbn3lItg=;
        b=a6CeZ5hf4EpjxY5yL8i8HTBF+fI/K3MnuFPrHDdbJwt6D7+IU7jumIY0IPTWpKG0Mu
         sSbxYv6hrW4pvc4njaMJnAdbDBAP/pqlPHZQv/BlbbKGiD4fwtcyVA8oevhI8eR8ixP6
         xatZmYSi2lBc2CJ0bNur4Gj4jfp7swdBKmMPOTySatQN7k1J9T3+OGJ4HhkW5z+yDDvo
         UrH5q5DuR1hhZ04TLe0gCGHyuQg6bFO8zihm7o7YUGcKWj36TZOUY769fo2OS5IClqw+
         3rdcdq3k5nnRqmogtuGS+mYDUGs0f6NAYgC1brbLJnC0cCULD1W8QkAHzZ0huQTR88HN
         7HVw==
X-Forwarded-Encrypted: i=1; AJvYcCWOzfEoStr5+knbRf51YTAsAfj060D7zl6MZzga6uhqU2VDEfQmFFmaBhXDdPm+BEfw03+qGrsvDcRXB9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNBJ8zNcxIwzbbq7BsRU622BgKj41djKg4u/1W6zgrhPAfzwvc
	SWDpjZa3uwjUxsNw+69G2LESTvxNHkJnl0/M7BBgUPc8w3zbxBQmg/iwQwxGuxo=
X-Gm-Gg: ASbGnctAoXDk/IbArNCDO9D3A/VM+1B2eBZ5tg5pfbQRXOKF91XOtb5fupgay7IEQsU
	5vF80W8sM43XF17e/cY9eWxEh27Cgwl0YPw3pNIsmJ8EZZDv9THVLnoF+HXPOJ1b8gmFzOgTH0+
	z9+hjHGHzmuu9fWcScBo1+bAsHlFxDfNMcYqDGJxWVGxhwjMgz39FyH54BGrNM5KJ+LxH8ZbzjM
	F4QHNvYBzPKxVJV2iYeIZ8DgkGOHrwJ7ePkjuQqTNzKK07rxOy36s/DsrTebqSH06x6DofdGcHr
	+/KFrT97Jf/iDz/cGLAbTaSm+0dvbliYuFRBUAcuJ4hrM9LeaErOm8hxRJtw14yxNJ42V7k=
X-Google-Smtp-Source: AGHT+IHy0V/tdcXjGNazvy2Zt+CkmxrEZA7UjXkUXMZVFafXjdfWax/sQBr8F95GBvsvHUv1FZm7oQ==
X-Received: by 2002:a05:6512:3e1e:b0:545:c89:2bc3 with SMTP id 2adb3069b0e04-54518178d4cmr243784e87.33.1739319370883;
        Tue, 11 Feb 2025 16:16:10 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54506ef1733sm1053658e87.1.2025.02.11.16.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:16:09 -0800 (PST)
Date: Wed, 12 Feb 2025 02:16:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 02/16] dt-bindings: display/msm: hdmi: drop hpd-gpios
Message-ID: <ma7ur32qudbxaqt7fejgxiqf4vqvsd2o2oki6cz5enwchdli4n@xk5dptvjbkw2>
References: <20250209-fd-hdmi-hpd-v4-0-6224568ed87f@linaro.org>
 <20250209-fd-hdmi-hpd-v4-2-6224568ed87f@linaro.org>
 <20250211-fuzzy-piculet-from-eldorado-6dce4e@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-fuzzy-piculet-from-eldorado-6dce4e@krzk-bin>

On Tue, Feb 11, 2025 at 09:26:31AM +0100, Krzysztof Kozlowski wrote:
> On Sun, Feb 09, 2025 at 07:04:46AM +0200, Dmitry Baryshkov wrote:
> > Supporting simultaneous check of native HPD and the external GPIO proved
> > to be less stable than just native HPD. Drop the hpd-gpios from the
> > bindings. This is not a breaking change, since the HDMI block has been
> > using both GPIO _and_ internal HPD anyway. In case the native HPD
> > doesn't work users are urged to switch to specifying the hpd-gpios
> > property to the hdmi-connector device.
> 
> In that case users would need to update their DTS/DTB, so that's an ABI
> break.
> 
> Please deprecate the property here (deprecated: true) and keep support
> in the driver.

I will expand the explanation for the need of the ABI break. Yes, it's a
bad idea. No, it doesn't prevent the board from working. Yes, it needs
to be done.

-- 
With best wishes
Dmitry

