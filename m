Return-Path: <linux-kernel+bounces-436351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 969829E84CC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 12:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5607C281292
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 11:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF5E14659D;
	Sun,  8 Dec 2024 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Om4S5805"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6225213C9C7
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733658650; cv=none; b=jSyiS5p59+X8Kr6sEYVhYjFnEZfjySz4IM+aaCqajUz7cw6YOlMzxR7vJeOxL+2ZYyTRQwL1VhnVMnDaZslNggcRmCF3zm4WVic7p+XGsWQdb5OTaMQCz/qGqe54mGI1flN7xX0cKrAAsAUL7HzhCuOTDSGoxY6OWupMbldjwvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733658650; c=relaxed/simple;
	bh=x6oYuo+yS8kOPNSc4ML/rCheQeCfgbmNJ343ipQn7Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMTMCphFBjg6geQ/mEUfdDRh8ku1v3CJppS1fP6k5qdKRuX8sECFR1oxm09qVADf8KBtTdGPjlnC74vl/GhY73kRD9/amiDZXu0DHwLcMiUO26EbI55aALptfTT9JCCLp+5p6LPBbdgbKaMJv4+bq9bi3Kibko+Xqsxr7ZvI79o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Om4S5805; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53f22fd6832so866356e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 03:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733658646; x=1734263446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oun+K+EMFqetiro2F/rNjcDe33esgYQxsDbhRp+6WB4=;
        b=Om4S5805rKJ7c0ouEA8I2tzQbrrxzkz0SBxbVIYYmkKyn/Lj7ObS7vkKal6E/0fXJ0
         nRUtKaOI/Teqa+vnsXJkU+WcrdCGPlg9kVeE0D3zstsFlT/NcxwcsO45z+id48pYTwtX
         mQEP0+l1SxPib/SEIB5GYCOiIXM0Qgvtsln61xMIXJjv3DhD5nH2VULM63T9Okpzd34d
         CQqBBlLlDAW4wLBSPUqWvO24vpUI5uMihtwUColuPPsw0WeKlgHtGAz/Em7Vuj2JOR9T
         gMGgvsJtKiwl7pJDEJazky5qzQgCg/OBHrHhQgkHNwYYWito3pg5eJ3nxycaODuUAjcO
         yjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733658646; x=1734263446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oun+K+EMFqetiro2F/rNjcDe33esgYQxsDbhRp+6WB4=;
        b=KKyI/vO3Zn+5A4Y2Oqb9lEUCITKlvtssG836aVZ5BNvOFv2W58L9JqAhvJ12Sc32B1
         ijM8xw3Otgn23Z9qKatORH2HEWy2yuUX374CDZ40QJh4Keh3evFqE3JFqqSMXG0I3ljn
         SXxsEltRtSg65q8q4dPbr2P9FbIJxv8psxoLLpHnSFU1NVASaSqVsHnbxIMZ2VHoOk0a
         O8P0V52mbfGYbLKkCwKKwL9+G4HSPMt+HHmwkDVxktRSwTTxBlVZ2KEWwfLlhzb/eWbl
         pTHuV/Ymen6MqXKlmPWx4VlBEovs8Sq8YmFzMOdXG2AeGmIJd9V/9vBlVENL94PoAEY6
         /m4w==
X-Forwarded-Encrypted: i=1; AJvYcCU/0gtgsgtqKHbiUr7UKTHbve5Jg6QaA6L/ZF5HS3yDPAQED+g4l6PKP+Tw0XKa6qFR89Q2oQ5DsjeFcpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCHMsw8scl59KOQnc2bi9CgI0nyvoWng8a3X5323nwybmOp+XK
	BdbDtMMm+AsGi7RJOJ1XfI/4snSyFhrh5o72ikqiw+61hjVlJe5oKh6skYvQdqU=
X-Gm-Gg: ASbGncvxBVpPL6ASUEQwnXM7nwzKDXazGISrLXbo1W0kUqeM5h6jwZybhrFcyCKB4QW
	RLt6LxJR6qnnX+xprKdghVQrciJdNnE0u+vQ3yavbi/sIsqM+mqeITi4d0PfKC4WX4OPx/k9M0E
	4AYwGCS3KTTT+gFw/ivAgQwRUHynt2Q11y/37Y1092xsz5ULG8WIRZgJE8VeHUQw9oqqpsrU2FM
	fbDgIaOd9wU0fBc16JvpB2XNVUD/tDvzvYUFRuUsdoi4hWqeVh7NqQhRpMu4GyGVrAZYFu11vHE
	n/mS7L6TJqRm9f9Ywn5J9ow/005ScA==
X-Google-Smtp-Source: AGHT+IFON8ulrpLU68pOJOmwTjUY9DTeD7p4bAWPDsvZgnewDN7qknWszAcJ9yPWcxocxPPFC1T4OQ==
X-Received: by 2002:a05:6512:2245:b0:53e:389d:8ce6 with SMTP id 2adb3069b0e04-53e389d8e61mr2465693e87.28.1733658646469;
        Sun, 08 Dec 2024 03:50:46 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401b8f5842sm211406e87.130.2024.12.08.03.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 03:50:45 -0800 (PST)
Date: Sun, 8 Dec 2024 13:50:42 +0200
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
Subject: Re: [PATCH 26/45] drm/msm/dp: replace power_on with
 active_stream_cnt for dp_display
Message-ID: <7kok44t3q4dv7jsapvdq45t4lpoaxwkxe3f345ewpfyq3ndgoh@t532yskl2wys>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-26-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-26-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:31:57PM -0800, Abhinav Kumar wrote:
> For DP MST, the link clock and power domain resources stay on until
> both streams have been disabled OR we receive hotplug. Introduce an
> active_stream_cnt to track the number of active streams and necessary
> state handling. Replace the power_on variable with active_stream_cnt
> as power_on boolean works only for a single stream.

Okay, this answers one of my previous questions. Swapping these two
patches might be beneficial.

For this patch: 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_audio.c   |  2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c | 42 ++++++++++++++++++++++++-------------
>  drivers/gpu/drm/msm/dp/dp_display.h |  3 ++-
>  3 files changed, 31 insertions(+), 16 deletions(-)
> 

-- 
With best wishes
Dmitry

