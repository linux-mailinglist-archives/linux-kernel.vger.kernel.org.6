Return-Path: <linux-kernel+bounces-436339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9759E8499
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 12:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5692F18845E8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 11:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0002C130499;
	Sun,  8 Dec 2024 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rx1Ol5DO"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADF4BA4B
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733656086; cv=none; b=aYwtD/2L0NZJhelE7gatDEeqDkChpahdDb8bOG4/SfyObVDg5wy3sa753cvnHSpMFuWJe72ylQh5ypuAmRlofMjzHOKX+7AdjziGytTWKamcXOAViVU/JBdODpLWLPMg3nE/YHjYZpMalQ30mep5C8e7xxpWCjWKFZDIs8pyAdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733656086; c=relaxed/simple;
	bh=i2I5xFr43h6c0sjShesFHRb7pIhIwWji843MsGj7wy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apkRKMCNsOuV+XO4Qs8GBE2nQXdKnn9OuUh7qfXarrNTl86kFN6TLtvFMk208kWIaBuiYZ9Y0J3q+fzECMFxFdFN+DBkeJfSmzttqX5p+rOcCw7R28ClCYzm0f0hFprDuLukkfRCUajPq+nKnkRgtI2PGAtPU2e+nZHzcksccF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rx1Ol5DO; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53df19bf6a9so4010859e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 03:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733656083; x=1734260883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VB2+beIqVz9NLf8laV1xplvCTzTAKoRYTCewp8eMyUg=;
        b=rx1Ol5DO8Vc9OEDr5V6nr0mRLVcWR7+/czbCP0fAYifjE9rjlbLptmgBqdNEITPuPw
         91hv1S4bsKL6+sla/JRiHQbyl1lRSpxstD7hYZmq2F5OFKz6utPAd/HjoDP5CuTmo+RV
         nA/p3NH/vrz6QyQCVR6XhPhteaf9MF1UpKnqbhtiJWtX1dKQ0Lk0DtuKjvoB71q5DP8a
         Fn8nl0iv9bZA3lhqylYjrt2APDImDKrzGKGhn3cS4NKc5la53Mw9aMCjckj23agIn8T0
         ePFoBkVGEvuJPAGVDWzD8o4fsiBODcAgL+70B5HqPGv2ioxvqncbNKDwiUbBH+aXFu+M
         5aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733656083; x=1734260883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VB2+beIqVz9NLf8laV1xplvCTzTAKoRYTCewp8eMyUg=;
        b=JrYpvDesoywYnJoA6mhHhrUex9FS3ipdFcDM1fuBBdPUuh1pIX1Xdhf/w/cdWjRxUM
         iaZDC3RXnmzEbEHRmF+Ar9p7s8iadweymr0KrSk47fSeZXWV7258OZNrDNlsrHB4T3SL
         i0QFnGURZcxkZwduWQuTSKyX+99N4akv7JA2bigfxTV55PS8eLKOVUxmIb+ZBnUDXgto
         coCbRrozW3RTd3sSyK3jDZb4vIPsM8jBzPU1wCQV8K/8reL0Fpajil6vKuflaQoS/xbP
         ppd2wJ4B5R7m/v590AK4fnH9lE9UzlJeR+RpwSo7P30psXwOxzvKIbSrqPL6Z3oUKVVQ
         CDZA==
X-Forwarded-Encrypted: i=1; AJvYcCXP7lG7O5WmmYygNrQpPGivggCCIf3V/wy9IoFpJgpVvouTjFbS/1eyiCh6Wjbv1JkoPuKPviMtoTB4kSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+G8MfU0HSj+wCBhp4wbIEO9A+x131VPqJo8MlJEf8X+75EAte
	XWQ3bg4qjl5y4ojsdm4ueygPEd1WNY2S8jvxKBOdh/2mAitI+TGN7eS3HwLJiTM=
X-Gm-Gg: ASbGncvp+wmzWTJQ4kNNl+McHVeZLBC4fz4xSJpHOuJOWQ2gDp81F1n/XBIqynHDhdd
	Oa0BFNKOpzF5wdnmgNrD5b/1Z5sE2zQExHktnYE0vfF7usvGQ3oG3OOCtsn2FSjjMP6PlTR11NB
	v6R08mEtRrrMlRVG2/2qIpb6D4ExSLz8L+HdFPGeY4Pa/VrH1Rw6Ry7KoTz+79NkrjYfcJp85oQ
	icwG2Kveo2+LqqYkfajmusFENZtqA4/+MunQP5WmRAz2y5ZhNHH8etnJav5CDaqxl+qEbLMhW7V
	o5HTKsjRwg9A0VZ7lQLy9g51yfD0jA==
X-Google-Smtp-Source: AGHT+IEPwz/DlmKiUGnz4YB99+xhYKrQeR262SJLPjLUw84SmBKtXiKNCszuVXMjeWuRzdQf1Pt2pg==
X-Received: by 2002:a05:6512:398f:b0:53d:e4d2:bb3 with SMTP id 2adb3069b0e04-53e2c2efb94mr3986572e87.50.1733656082939;
        Sun, 08 Dec 2024 03:08:02 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e377f3ba3sm648212e87.187.2024.12.08.03.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 03:08:00 -0800 (PST)
Date: Sun, 8 Dec 2024 13:07:57 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, Guenter Roeck <groeck@chromium.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vara Reddy <quic_varar@quicinc.com>, Rob Clark <robdclark@chromium.org>, 
	Tanmay Shah <tanmay@codeaurora.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 12/45] drm/msm/dp: make bridge helpers use dp_display to
 allow re-use
Message-ID: <zdod6f2a6c33wbjxcw2kqg5mb3lkedmfxq47lgjxzxuul3lcsb@elka24uhxyw4>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-12-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-12-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:31:43PM -0800, Abhinav Kumar wrote:
> dp_bridge helpers take drm_bridge as an input and extract the
> dp_display object to be used in the dp_display module. Rather than
> doing it in a roundabout way, directly pass the dp_display object
> to these helpers so that the MST bridge can also re-use the same
> helpers.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 34 ++++++++-----------------
>  drivers/gpu/drm/msm/dp/dp_display.h |  9 +++++++
>  drivers/gpu/drm/msm/dp/dp_drm.c     | 49 ++++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/dp/dp_drm.h     | 12 ---------
>  4 files changed, 67 insertions(+), 37 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

