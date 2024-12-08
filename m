Return-Path: <linux-kernel+bounces-436355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3E19E84DF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 12:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410291884B85
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 11:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FF11474B8;
	Sun,  8 Dec 2024 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rcPkmu+x"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E69B14659D
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733659119; cv=none; b=qw1jdzT5iCuqpLX+KUrJKd0CITIkEAHdFVpboFAodYs2C6bYn1bIO1F5uIdSSfMeuxt222Yt+JoIRNu0VNZxrNeN2rgOha3xHer3UshYzi91xQp7pIgZSupYz/guPvC/0wgmMl1HdzNvbfAuFGq5R6apbvHEV9gYGwS2Zo9UUGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733659119; c=relaxed/simple;
	bh=rnrobeummKXtlx5e1Mp8vjRMRR3hpHjznnrPkWV9jqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSjX951WpgcyEHBs5Xor737/vxT4DDmxaP140mhAt4bNtECJ7Xwz/LT7HrIl6y81ePJWWb63DIZRNynnStXf8b8QO1F71WAtDvqoS4j//GespQY0vF9TWLcMwByJ7QjtKMKzH7vPqC1MlSsB20po0yr5GAe1L4EYMe24Y5i9bQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rcPkmu+x; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53e3a37ae07so1232961e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 03:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733659115; x=1734263915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CysgqJSoA6The5y4gGxS6RuFPaDLlk4I3KIup58ZBcs=;
        b=rcPkmu+x17qESYbWHj6lCGcqLOsCQq8Uo2bgX9yfcZZBLEBMq0EKW/E04qbKko9K93
         oX8uOhL12WPfqJiVGE6In9ZPiWlupNR2rRDCIl0qivzxGvnGMKwwajXFx64t3EKR6z2N
         5X3Ixo0boz42hvSfJV66i4QvAoWT2O27Q46UWrZW8L+rGnHaMjIsdUK9NtoYttHywfHv
         5BakHRX3DdnSKS/V9ByuGNtt8zQNPeEf3Cy1jKLIXpXO12AmVSMQ7eJsl113mnyrMB3E
         YKa2MEc6L51R136ZyLXadps521qwDNOvYn3fTWd5rPorPIbN97aVhrPGfYmFFg4XJE8o
         owsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733659115; x=1734263915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CysgqJSoA6The5y4gGxS6RuFPaDLlk4I3KIup58ZBcs=;
        b=IPTr2ggHPOzxy4tsA+yYpSw0TDBgZrMVp9JY4oO1LbAYxrSzmtOEx/OuhHY0dnf5PI
         KZd0a7ZAjM4IyoPzI5kdhMhGMZ0w9ABEoeDn81tJBc1b0sxNEcxkkDzsGjdlcuWRtU5o
         XALOamW4gJGZJWU9HHlb5AOTHYCy+u77oPD1NW7lefBW1fOCd53L/oTr6OmmclTWZzg3
         e9Gws4q45x0getjt22w4Hr3zGGDc4QGd/JsbaEkV+ya8OD8dz7lVGKapz68gfnC6GI+B
         KXfvzqnJZIZywoFS0BHNuLxM/OEGgQIlirg+rBxLYhC/ZHqGgTRXjQBJZg4l+290ntXG
         4saA==
X-Forwarded-Encrypted: i=1; AJvYcCU6fZt4rc3gsOTsc7SVCCWAhHiarA2TQQW/Qk/AjxbjGdIoimhXn1juAeaQ+MC3i5zBF2mLir8HbW+ja3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6aho7r5cYj2s97AdjVFXKvGH6hWhh+xedrJ8Dn4I/BkJFqNNX
	W6Dn6B8P2Bim86WFKOsPB41eojC0HkpH5xE+xxj5idlWYNLgBfpo9+2nNOWSWXA=
X-Gm-Gg: ASbGncv+XHs55udOhP1SXSgEFP6kx1ZaHcmarMYY4Fb+NG/OYgg+wlbjklGjXQaruGX
	4FcWsGYDF68LJVi56Rv/bCSfkPMBR4W8TXUNGgDvYITJfMVtHBpLaK5B8qxzYOwthXVcDCVcq2b
	bHBCROgmj3pfX9LncSi63C7o/1T/eUuJZ10pLuwiv1vNpGbH0ShAMoBjSzUh32Z96+MlTnmbeEX
	L8mBlkZeOo5Qd3UB9E0dFNqpDV85Cmn/W5rsVsYFBiURhefT2nTzp8YvJAe6dy8L6V/TpCVDzBa
	sE9AOHUXGAVbtitrQMJrH9XLRNgwOQ==
X-Google-Smtp-Source: AGHT+IFMxzujaEusISBpEqUr26OQV2IrA+gNY14wgz09Z76uRnfMuKHilK9vldlA5zCo+wLBFIB44w==
X-Received: by 2002:a05:6512:3d07:b0:53e:3a7d:a1df with SMTP id 2adb3069b0e04-53e3a7da2cdmr1577018e87.45.1733659115464;
        Sun, 08 Dec 2024 03:58:35 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e94f77f3fsm424275e87.217.2024.12.08.03.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 03:58:35 -0800 (PST)
Date: Sun, 8 Dec 2024 13:58:32 +0200
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
Subject: Re: [PATCH 42/45] drm/msm/dp: mark ST_DISCONNECTED only if all
 streams are disabled
Message-ID: <blxp4p56inbzlwmnsj2mw3pllioemgwmyxmu6eqo2oicl5dbth@exdch2z3kk6a>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-42-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-42-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:32:13PM -0800, Abhinav Kumar wrote:
> HPD state machine assumes only one active stream. Fix it to account
> for both while marking the state of the hpd as disconnected.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

