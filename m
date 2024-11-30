Return-Path: <linux-kernel+bounces-426137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B61F9DEF65
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 09:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6B0163862
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 08:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1505814A62A;
	Sat, 30 Nov 2024 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S6U/Rghc"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B150733F9
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732956062; cv=none; b=G6m+IiE8sm98+RQ4R6L1PqoCDN+aQFzs5SxyN2i4OPTQwsLgiWn2krpe4mEcYCeAwpDidSzDXUj0qGv/GqwHyuNpRTQeClTMZpqqd1cl3LHvagdpgVuIr7z7hBetydw/fvj4Rqhdu3TuUyMkMFLrCPPkzSoZLa2prug4urPlVn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732956062; c=relaxed/simple;
	bh=I5XCnhHMvRMw3Drm87Ger0wbHQSsWq+8sU5mGVmSyv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxWfG0iZt589S+1KLXgUmPxDTZey5xDqo47+reU8+bIIKghYYa8ZM/s2FD+FEM7ktFw6p83TSkfyyQGNBAInknGOy/7KfmbIAeFt3+eRUPpwn00s4+MRbXXbS3YrW1Fn70VPI07KqcbhFGSsgjEB414lSEmyjh6MIGmQGLPtsyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S6U/Rghc; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53de92be287so3992620e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 00:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732956059; x=1733560859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=baSKiqmiyUBLUvWuYCpPjjRWJYCxLBQMcRAYfb+5olo=;
        b=S6U/RghcS1AOO8E6wj1krLYzCv5t87E/jcutp7evwyC+A/+riOGYm9aqIkShlBVd7Z
         fe0aR2p+7tzJc/7AhUA8jsxsQhjAr5UDDbxhQJ/PwXl9kNwOlvz3Lf4gNVlp261xHXDi
         wWeb41KKaQWNM6ORCEpCYPKKhA/oBM58eanip4GSjtWenYbkU1fzQxvS3FzNcQXPZmaW
         GfgGABFys4Op9QpwGBSe3Rlj0IRocKeUmCZgJPXrP/dqoKwTeL7MjBS84YV+tEIfZ6UR
         1mRgghnEJ1IUQ97TRoIpaLuyFUOpkfQ0R3So3fM9WGcun21ILtIsZaQt8Q2ghHmSgGmK
         ZsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732956059; x=1733560859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baSKiqmiyUBLUvWuYCpPjjRWJYCxLBQMcRAYfb+5olo=;
        b=h4HtLQyo12XMPoCrBLrYmR3EuKw9EH7Pdn15nGXE8fovECx4uveyeXhlT5Y2wmX3UP
         P1amZ3ltnv03lM43Ql12D+l8hcuvjLgMTcVUeK1dizMi0WfiKqdLyWBAUq+P4bsxyOpp
         WeOqkWzEc7wWLBAMMQaMbOUwMJl62kLAFCCpH8lnW0vSmSfY1rQ4bdNP/JsnvOj8QKeR
         XtK3EX6vmtziasnfyf2C1YzDEOO2LelH5Zb+l18JgnWQZLi8oMf5bzw762W+jW4oGVLW
         nPGWbEzGMwF3Fo92QHFw59yJXwq4U7RsGMZMTyQT07VbOedcQdw2rmIA+bqPSfad5Lkg
         Rnxw==
X-Forwarded-Encrypted: i=1; AJvYcCXlZepTIXJxRUUrhxQ6vB37gnpic6Ed0NYiUJQv1M+rIeEzNro1AX0peQhdIYTUGrvJ3H5o4y4FfkBEPJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGbJH145p0DulhNOmXd6pHBkiTy++CqB86MuK+hqpeLe2h5BZ2
	8sAUP8xmdljQ0T8OH6BBZhKKJ3VQrOBai7UFI/3rq7RzdicAN63GkTSik2klHSY=
X-Gm-Gg: ASbGncvCCdYYfN4ub/TuUOjA7GvMrpEag/KJh6+hYrY/868n9+LfuEAu8zyyps0kXEH
	cQ79erhQkXV6uKkpCDi6mpTmtytee7uwMpcvEjcfRsUuphz5dFoNbfuYs7du/i+0VXsWnAZGFzI
	S9Ewd3LFRD+8c9ETc3gInUHMVKoe//Qwoe8HKBYflcXJ+wEafniFLHHxLHP9sxJmnaybof23pK4
	iHILMJpfnkPp3irFlyq4ucD2MaoPkUGEXZvNrcaDpUaVNiSpRx/hmw9BmtTt1fMgspwmDNwfo/v
	lMFIp3R6VQaINiClkaAkXsq51Cn6Hw==
X-Google-Smtp-Source: AGHT+IFBylZknNJ1o0HHBiqqvQUAQGaFj35b9oCZT+43x1VzxUT6UhVfLErgQC05RzQ8a1Hc2haFJA==
X-Received: by 2002:ac2:4c45:0:b0:53b:4a6c:1849 with SMTP id 2adb3069b0e04-53df010b1b4mr13034366e87.35.1732956058823;
        Sat, 30 Nov 2024 00:40:58 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6497200sm704170e87.223.2024.11.30.00.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 00:40:58 -0800 (PST)
Date: Sat, 30 Nov 2024 10:40:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/connector: hdmi: Add support for YUV420 format
 verification
Message-ID: <4eclfesrec6yv6fsleqmjxuvmefppflqyzacpr2gnng4bopqeb@zk4srnfucxnf>
References: <20241130-hdmi-conn-yuv-v1-0-254279a08671@collabora.com>
 <20241130-hdmi-conn-yuv-v1-2-254279a08671@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130-hdmi-conn-yuv-v1-2-254279a08671@collabora.com>

On Sat, Nov 30, 2024 at 01:56:33AM +0200, Cristian Ciocaltea wrote:
> Provide the necessary constraints verification in
> sink_supports_format_bpc() in order to support handling of YUV420
> output format.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 40 +++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 3 deletions(-)

LGTM, please add KUnit tests.

-- 
With best wishes
Dmitry

