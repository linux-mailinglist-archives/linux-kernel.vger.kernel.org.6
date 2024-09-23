Return-Path: <linux-kernel+bounces-335691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5E997E92C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BEA1F22039
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5293194C78;
	Mon, 23 Sep 2024 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdYzs2V8"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866A5EEB5
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085514; cv=none; b=L+FWBg69IpuQ3L/uNeZ569uS11D4ya/YaRfeGWg0FGrjqLaCnz2DKzH+uU+w8E3GpizONobeGtm0AB9Br3Y7d4Us03Xep4rFH6NFqFQVG0K9lqmsNpJo5ZRAZFW5PtW4m0zvma/lymq+gQ/6AhWH96SN8jqC63Liwvtdt7xJfUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085514; c=relaxed/simple;
	bh=diVA6mkav7S1q4H7HLbHC6FC3Js5JaiEdmc0yq5VF+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fT4OMNsdydALhBncGugMkyqz7eeaOZj3ay+/ZG5c0ReoR1DAoQNPbgIigIXwC2bEjqUSLf1LVW2vNaHGwPPFRYxfws3HhlYRkCyEzomKHqipwolaGl96mRU2Ul20UldRQVP9kFo+Kjm17WgW3jh9qXwMFK0zEAzqfDnr3sDtn1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KdYzs2V8; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f758f84dfbso31558411fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727085511; x=1727690311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ub4XgTiDaTnG37jRiFm9Y2Fc+WlrLGpXlCWkejMfFT4=;
        b=KdYzs2V8cPmZGiTioQuulWsItpbVe7u+OgAqbehfd2VNtE+p9gJfiluSP6KEE7PsAc
         nl1Z7Lfw/DNfosQnkch4yhvD+PyEdHI1z6V+9nAzfh6PtDCQ4sqWhAQNHlO2lBQaILqX
         4FJxpn/Ca2tP/Cm61x8RD8GYH3KqtZanQnX2tWEUVdFjCGH+UZwjupeBV1WGqsl5+qQE
         E17Q0UQiUXgDz1HWchFRliPhsEg1CvpBWRU2tP23YI6ypCOd2tCW2pMER1T+wV7Av+Qo
         p/zSTbYcKNfzgZQ68kJjMKOdV84TMkrm06yV1O6RQ8m7KLOEHfNCYLWXEfKyWqg3M09X
         sgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727085511; x=1727690311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ub4XgTiDaTnG37jRiFm9Y2Fc+WlrLGpXlCWkejMfFT4=;
        b=qIn6wk9ZAGmyoZsrS0bCsBq5IM2yMz2lmMTtdsmHGRsd7EmD/2SDiT/5Rs4SK5Ende
         K+0Sf90Lrwn4QASN8lmNDL0TtMa2NWBT0MO4/apgYK/miIyEpfDmSEj9F0iAuz+eYdBh
         RawTG0wCMfs+MxV+FLe6OLn8RIxrIYLUn3vWHoy/yFlca5lzyenjtKBQzN4OyHtuENoo
         RqLxc2n6A9l4Ak9Z2k08I9kh5BezfsaIQxiGhW82+x2BnS5NK6pIUxG0mYh9lIOVQgZe
         F5nlSxFrC1KcP3zkOs7mPvf6KUMISstTMGohrMEFT9yw/3TfNidEytgGiDkT5+7CwUrn
         wwPw==
X-Forwarded-Encrypted: i=1; AJvYcCW5PQ84L8Zsp54iVYhnyVankH+MQKkhjybjw8IBcRx2+Z3uoOeZfYpEMqTKycBBLM2GIEZH2pWcc7rWcD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5vfEUrsz6XqWRsE1qvr2FD+YTmbuRcHIfaITNYYxXUUuRnVn3
	XoOHm936GGSKMbquLcSNeUBJJb+eEYN8vQSZclW+ihEyE5FEEA2P+qC55Eg5Ing=
X-Google-Smtp-Source: AGHT+IF70YCd6NPOg2g1uNWxOpDA5cEHVgZRGvQWfOhS4sHNqYU0tUy6qbj/ZoxZsUYtksuWhlIynw==
X-Received: by 2002:a05:6512:1309:b0:536:568f:c5ed with SMTP id 2adb3069b0e04-536ac2d6909mr5891988e87.1.1727085510477;
        Mon, 23 Sep 2024 02:58:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368709684dsm3220907e87.148.2024.09.23.02.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 02:58:30 -0700 (PDT)
Date: Mon, 23 Sep 2024 12:58:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH] drm/msm/hdmi: drop pll_cmp_to_fdata from hdmi_phy_8998
Message-ID: <utahvquemchnryqnbhuv2rfxqcgfowqqhjrbs3xtxej7ts47km@bbir4nq2mfwv>
References: <20240922-msm-drop-unused-func-v1-1-c5dc083415b8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922-msm-drop-unused-func-v1-1-c5dc083415b8@linaro.org>

On Sun, Sep 22, 2024 at 12:14:48AM GMT, Dmitry Baryshkov wrote:
> The pll_cmp_to_fdata() was never used by the working code. Drop it to
> prevent warnings with W=1 and clang.
> 
> Reported-by: Jani Nikula <jani.nikula@intel.com>
> Closes: https://lore.kernel.org/dri-devel/3553b1db35665e6ff08592e35eb438a574d1ad65.1725962479.git.jani.nikula@intel.com
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 


And of course

Fixes: caedbf17c48d ("drm/msm: add msm8998 hdmi phy/pll support")

-- 
With best wishes
Dmitry

