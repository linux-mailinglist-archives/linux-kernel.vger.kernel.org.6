Return-Path: <linux-kernel+bounces-220058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E22B90DC26
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2D91F23AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6742715EFCB;
	Tue, 18 Jun 2024 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXwmHngq"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA69914F13E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 19:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718737356; cv=none; b=UgnsE627ASUoos0Kscw6f7TDOJJ+Y1TiPQSFc//gbYBYOnNndYtYfiZEoFk1CHfG+rECNHokppzrPbl5ENOaP0qT7FtZ9JxiD+4xqbhjnb2A/NfWgw23xqS4cIjo/H7H6LY76U/N840OBv+zOGTdheUohU2t59feM+vSADAB+CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718737356; c=relaxed/simple;
	bh=1UkEwDwHiA9y5SGuBuTcRn+jHryc/+jQlJOnBQ+Ekow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KB742dAHbvLjPs2JbL8jnXayYmes0yZpQP3rXG0zfUmobg6JSf1X2JaCwYyU08VtPumTCHc7iYSvxerPfpYYFMlThwv7RUK8XnpeJ90rrkaR2f8kRr3TVf2B/7VfVg1I7A8bxKIODZtPNcU3FRl0mLeK6Z1spLS2f3mRrp182VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PXwmHngq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42172ed3597so882805e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718737352; x=1719342152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0nW5Lw5L1U/vXOS5IOb1o4dhA6pmFIZMeuoNJs90Ac=;
        b=PXwmHngqP1lU19BW1s0zoBGslLBfIQXgvC9aC1pk2pFHIWh5sTM3EXf/X9yhUaZWg4
         Lr0EIW4GHXMm+BnAfI2BBIt0L6WP6EPSf9kWa85TfbZ6d0/SNjcZZy7P7UZ8/10MhPBF
         vIsNFoCSATjICMRkzjjagKnueLC0rG0QZ51IEnqNAzIeEFdLcnOW8VaNkiW9Dc00e8pd
         RBLgb/r65NDJERe73uMCAO7ufWFQughFJQkfiVO3PhiaWSwJ8QwZAklGa/C7eX7AHZUC
         DHDzFa6tBdTitXoZFtdxscXha2HZECepJZYk6aL2M8eBmeA3o1s6lPx2wBTCFizOeSyL
         ZJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718737352; x=1719342152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0nW5Lw5L1U/vXOS5IOb1o4dhA6pmFIZMeuoNJs90Ac=;
        b=uioaML1uPsoflb2JHbGjelPZyJqHnUaNesAWVtWzqiac23fdyqyW0hg+faPKvGgxLV
         Bm7nZU5dVchiCOF7gx6HydEm7omPRAlhoBNr9KVQInzZivum0Zl2WBT5OV/p2W6pjwuN
         KX7kY511Ci3MwXaixA204kcYdqOQJUGjHpfJtdhlLaDt4R+GMNC5y8wvX4xgLIpJ0Y/u
         5ySwgeldqVVigFfjsL+oLlVzcq4VO3RjWggbzxndjL0CUirW5UN2UCYIGG16xUaygeQk
         J/1yKpTThCKauT9Da0r7dZMz+yoRxmWfHYKfpPWhN7uAvcjvHqown06r1+7gPOgqJP1R
         eqUA==
X-Forwarded-Encrypted: i=1; AJvYcCUEIUbNdwsQNiD+v5Ug2+rgK2kLFOqpO95R5BMA0vOebFpMGE/Nvqf/hREegyaBL4ucW690G18BW+mlZd63vyNz0nPLeD64jia90NBp
X-Gm-Message-State: AOJu0Ywq44gNONSwoQjAyZsDNt9tQ4EJjz4qyy0qnaaDFMVplxDtx8jg
	8uL6qc3KbYXvVE+QEmUY1otZjQ1qoXDEuvwlvIOiHF63LFgoYvQYzwDEAyPpQm0=
X-Google-Smtp-Source: AGHT+IG7lBWAP2S0mJtpOdeqTmDaeSfFJwS3uCXt8D79J41M/fUJYZCYbP8ihtzZVXtw5EnRrS5WtQ==
X-Received: by 2002:a05:600c:787:b0:421:8179:6127 with SMTP id 5b1f17b1804b1-42474d41065mr6543715e9.20.1718737351821;
        Tue, 18 Jun 2024 12:02:31 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:5d11:7fa7:8997:f811? ([2a00:f41:9028:9df3:5d11:7fa7:8997:f811])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075093a3fsm15011713f8f.1.2024.06.18.12.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 12:02:31 -0700 (PDT)
Message-ID: <ecadeb37-fd12-4b63-949b-136356a42362@linaro.org>
Date: Tue, 18 Jun 2024 21:02:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] drm/msm/adreno: Move CP_PROTECT settings to hw
 catalog
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robdclark@chromium.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20240618164303.66615-1-robdclark@gmail.com>
 <20240618164303.66615-6-robdclark@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240618164303.66615-6-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/18/24 18:42, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Move the CP_PROTECT settings into the hw catalog.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

[...]

> +static inline void __build_asserts(void)
> +{
> +	BUILD_BUG_ON(a630_protect.count > a630_protect.count_max);
> +	BUILD_BUG_ON(a650_protect.count > a650_protect.count_max);
> +	BUILD_BUG_ON(a660_protect.count > a660_protect.count_max);
> +	BUILD_BUG_ON(a690_protect.count > a690_protect.count_max);
> +	BUILD_BUG_ON(a730_protect.count > a730_protect.count_max);
> +}
> +

patch:394: new blank line at EOF

other than that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

