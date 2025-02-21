Return-Path: <linux-kernel+bounces-526158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918C3A3FAEE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51B744324F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AA3211489;
	Fri, 21 Feb 2025 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/L7sqsO"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C93521148F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154295; cv=none; b=BREO7+LS2OPdqjtcuvCRNvKAsdWzx7hfXT2ygOtyVzvCakmvsP92A5lF1yWZRZe9nSMhTouwnRA92PkFdtvrtSad48UWtFKB7OS7rn/3pZH+qvRJRrxVvozES5k4PSX50FTT1cS9g98Ac2UeT++/Oqa+ATWb3HIaWlsp+t870xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154295; c=relaxed/simple;
	bh=o88rw/tjy3HDPJmDRmZM9kcyWyrDf9JHvuhC10NjrKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyi/kTmX7CoteTwn4U5pxv1Q6U3EY3l5KVDEN9i4lmgzuWQvru2BNBIsv5wcNeunR0yMjPYB2aHtiMxpbULDFP3irm44wIJAJGdpNvRBIKR1jL3ZRdTJdN0tGYj30dKx/WMGuHbid5TyFdXb+ZM4Izy96TTAdkr1cf1D4eSSP94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B/L7sqsO; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54298ec925bso3327327e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740154291; x=1740759091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hr3XzvE9aqClELabiY59euwbUIuS5g53m16CEDx+PQs=;
        b=B/L7sqsOMExoXjLPPriEqiguh05/7Wx6VdyzE/E1EpXGKIqIFMPtV+gg8V7XYIs1ek
         C6+3WUhg88pXBBBIPuqFQzGBfNOLsgqtnwwEXIriHVmOhJYcRtb+DdJxmEGv5O9VsDC6
         eDWqC1IQUlns2gXf2RwwF6OM0LCjozVNdUBGA8LF7Q8c4DNiM1XRDiWNrthZITRprodC
         ulJXmGZbclPZ8DO3OLY7oNzsqzk6qiZ5NiQ/GYb9KLx8xY9UGhCq5ed+Li1KuYr8sFwn
         ljxFjlVC3NgdoZzslanC2OihQjdu+ybsvZbogzc9yoMwpHkjdSiZTLm80e43T81vyoTu
         GMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740154291; x=1740759091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr3XzvE9aqClELabiY59euwbUIuS5g53m16CEDx+PQs=;
        b=av8l61ggnIAVmGRMYzvOn/j7QTyZiT/JFOcpztM3qTitEX7RwHPr5SFJWkYlv6RVvu
         RmEjD0Ikbz5g5YB4nGudZyo9tFfcTzypYf+fqgD0Oa1G6u2+rsscI5JE0SSBfb3kkbFZ
         6aOVBmRwC/e1TseId1NWHhdj4/b81zc+OADVxqDYPU5dpX9ViUt0KPNsJrLr8O+Jtnx8
         3dODcW7ySulVcAuy8qUXvC7rQSj4PVIe28Mu3Et/hfkOM/+N7uVNp8SXFaXvavojsfnP
         U5nUBg9Sm+WqS5hs4zq2BgA2wU+ryEohKQaKbP5SMvSZveS3+tn6qJnH2gLRIYPZWJmg
         lQMw==
X-Forwarded-Encrypted: i=1; AJvYcCUVb51Vf9BdjxuDeDNWLrVL99KPKveV/IIJH+F31trl6KTE0Df3n5um6K7MDOza3gdRhDDzeJ5I7+syIpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQXysefceBCX0cH3naikJ6/kyxwiArDtvjV1fBNj/NjA+42kh7
	tPJK3FiuGYgyaprhJr2Q+Wr6/suC60TdzXXTzUnMigQq95mNyO/7Gx6bExDpZ2I=
X-Gm-Gg: ASbGncuo9X7pdoY5LkWYa49Ri+pKeuUkcK/v7LR/1CDWI+2ffY1JSSH0sb30VruOhrn
	9mtVIDy+ITAqavmbl2Jv5lg6MnewSpR/8p7vS3Qv68tQzDqyJ4vrGoXXiZM9r24OxmztM7CbiwS
	J7vAbMoQTM+rr+1eyaN7208Rk/rd7k5NvrOkMK4X8hOluUW9o8xEDOoz+9JLf6ui1UMgmP2fESC
	e3YqRw2KzrgbsJnps15S4TDWImlalb+zjE1TgVWBiO1kvDOI5UxmQ+GeK/XYpiDypkDsTJo8NDz
	7ubmYxKrxgZNuuUyobY6Wgt/IHOP1W9ehp9OvbfTZ3A61UydAzM//gMKIAbfOC/+hRIt4hbbHZf
	syQuv7Q==
X-Google-Smtp-Source: AGHT+IGfxPa9wWy0xBwDTcpNaXXhV+ontjmSCYJHc06VMOigSb61bjng4QxI7OTQ69hRP9FYbbAr5A==
X-Received: by 2002:a05:6512:33cc:b0:547:6733:b5a3 with SMTP id 2adb3069b0e04-54838ef5b91mr1459696e87.28.1740154291461;
        Fri, 21 Feb 2025 08:11:31 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54531815e02sm1986700e87.228.2025.02.21.08.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:11:31 -0800 (PST)
Date: Fri, 21 Feb 2025 18:11:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH v3 09/21] drm/msm/dpu: Clear CTL_FETCH_PIPE_ACTIVE on
 mixer reset
Message-ID: <tggda55h5mbhqekdmkkk2xpww2mblmtnqz6l64uv23eoh3rfcj@reirdm445sw3>
References: <20250221-b4-sm8750-display-v3-0-3ea95b1630ea@linaro.org>
 <20250221-b4-sm8750-display-v3-9-3ea95b1630ea@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-b4-sm8750-display-v3-9-3ea95b1630ea@linaro.org>

On Fri, Feb 21, 2025 at 04:24:19PM +0100, Krzysztof Kozlowski wrote:
> Resetting mixers should also include resetting active fetch pipes.
> 
> Fixes: ae4d721ce100 ("drm/msm/dpu: add an API to reset the encoder related hw blocks")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

