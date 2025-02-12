Return-Path: <linux-kernel+bounces-510928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD34A323BA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3EA3163968
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9B7209F55;
	Wed, 12 Feb 2025 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvMRwah7"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA028209F3C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356954; cv=none; b=DxqCDWOwwgRleLnV0Zwifvf+BCLJhU3/qzWPzvMH8/meP8yQ+QAbBilSy9Qzyb2GSUDz+Pyy2M76uXHWCxLB1oyZG70iyqqMn6cxuOfQQsa6+d3mXZLNluAjgz46sqZMIoLJTIOkbP/YpMCLXkGYLUtIq8RSAb+ITHkRTITCzN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356954; c=relaxed/simple;
	bh=zKemnO3M4vvKr/b+LEy5t/9tGLoJbtiRSG+p5f9+Kws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTBhz5Z4So3FwBihPuCK7W3its577P0fXFHi6PlCldgLTXIsq/RGWsIETCz5GmrJ3ADBK9u+SD4X1bLCMlLq68xHWqoPoIqwRxdBhe87foaiTn2prD9AVBGmZoSh6URiT/4ryCIG/6gnLC+R5RyTrelEFejpSR6MyDhJRB+LW/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UvMRwah7; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5450681b606so3970832e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739356951; x=1739961751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ld1TfC5Cdjw/PoVC0iP097r1SbIYfGgfFoLiWX4Zz3g=;
        b=UvMRwah7YSQfTrvxsptY1ehUFhktfrovYmj0W1SWPW95ehDdJPtGEmZsPk6zj04XCV
         smPSGuigSJlCGwwM8YDg2dvDdSipSMD1yAA3+4obCI1cAeR82bWcvTRHjE4jNns2OOBm
         D+DCSO56POEUuVhoQrlAxricsU1YQtfBJFhR/VsYvzbKmwZ+vEx34CqiqNwCZhBGfFBj
         6KTDOwcn0q8qDaJKQuywUl4nkzLvkG6Qy1nFyE8iRFnO5jEv9FjE5/ChbnmDwanVCL6R
         xi9TOGN9sHj7SidZbm4zsi3bootmzuTB/PYUxVBa79yDVVkLlx9tSLSOE6uKfww1koqJ
         Jd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739356951; x=1739961751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ld1TfC5Cdjw/PoVC0iP097r1SbIYfGgfFoLiWX4Zz3g=;
        b=m/5lNMKeC6ipKwEk471WuJ1bgnuRX1qsu7bYMVk/wOW+Je9PWwORcrrO47eVmULUr4
         D377Ad8vCmOtyCjQsHsZzsdoEWaaZyI01C4OzrEXINOE8Ugc/bk9CXbJn/x8QI+Jh5R0
         zgJT1CPLUQKS/39IivJhMU4n+ZBQtaSlhLZsr50eeDGbH2UHszUKp97M7ONqtLJe9BIk
         T7U/xwuDpIebSWK4Ho6Is/f+yXLKPhE+6urO4vN1ObYOGF5YHoGgf0jZNnHYEPDCShoy
         fUwb01dXz6iahsJ6nQbXmGQUSOvNIqXAXkgHbN+JmYzPOObtO6arZpfhlBNER4ewi9QG
         e7hw==
X-Forwarded-Encrypted: i=1; AJvYcCU1f1m7AXyqVDckpAKG9J0bSRIsxXH8sZHAIjZUFt7qPWJUwHsRLx2U5o8lh8joDoD/i9f+1DFZLQxUkfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7yJiqDz0rFrFN51NfwifOuyMQ4hHaFnCcBFjzoM+jqDuRPx5x
	23dEOB8p8n7wB7X9m1z6YALzV7p3yj+JXOnZT4lE0cSHI0WFZhpx9Wb7wQB7NeE=
X-Gm-Gg: ASbGncsGY6S1eRbiJQNdtC6RZUea+PWjT/RWtWsxDnRW1jAvmmk7xBBITPJbGo+KuBj
	rihzGtNNTRcbtDh68KaHFo615lFasyuaGWPhUq00z020X82ae9S6nOHv3vxGginx07NP+SMLk8a
	wWhCGystD0UC3Rv9TVdzFPvWuO+WBKjXXgxKCvEjoG3RXCNZD4fn15BoqcVw2ypPWbUNYF9LT9H
	UAZCPf/aaBPwoD5Dm5nCCYWmzW26b3Pij4MPgZYOLo1VcUfdEiIZn7Bucg6J0b6r+obQd/348Lv
	stPoIZ6pfJvdeUqISgN1e5totvfdQmVjWz/3fM0DaX0kdKdWwTrcCozjRYLA5v0BvYuDq1M=
X-Google-Smtp-Source: AGHT+IF+1GUoRD9HhqBh1RL9sJOAG4t7Xk0SYLrZn9lbwf1SpooHUxeWe02/GIT06t3TK4EotARjyA==
X-Received: by 2002:a05:6512:39cf:b0:545:17d:f96b with SMTP id 2adb3069b0e04-545180eb5f9mr737259e87.14.1739356950858;
        Wed, 12 Feb 2025 02:42:30 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54504e344a7sm1328754e87.5.2025.02.12.02.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:42:30 -0800 (PST)
Date: Wed, 12 Feb 2025 12:42:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongxing Mou <quic_yongmou@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: display/msm: Redocument the
 dp-controller for QCS8300
Message-ID: <brm43v5kzsum6hc6ahs3lqzgww55kczjzwzxsmx5a6alw3xxvh@3mdqqjvo2b5k>
References: <20250212-mst_qcs8300-v1-0-38a8aa08394b@quicinc.com>
 <20250212-mst_qcs8300-v1-1-38a8aa08394b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-mst_qcs8300-v1-1-38a8aa08394b@quicinc.com>

On Wed, Feb 12, 2025 at 03:12:24PM +0800, Yongxing Mou wrote:
> We need to enable mst for qcs8300, dp0 controller will support 2 streams
> output. So not reuse sm8650 dp controller driver and will add a new driver
> patch for qcs8300 mst feature. Modify the corresponding dt-bingding file
> to compatible with the qcs8300-dp.

Forgot to mention that in the quick response: please fix usage of
capital or lowercase letters in the commit message. If you are unusure,
'git log' will help you.

> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 

-- 
With best wishes
Dmitry

