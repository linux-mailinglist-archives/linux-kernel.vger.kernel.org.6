Return-Path: <linux-kernel+bounces-533126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70231A455EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DAA3164CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEFC2686B0;
	Wed, 26 Feb 2025 06:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eL9hfIe3"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84448192D63
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552379; cv=none; b=BSyZxh74Ss6L6ZWt0gv5ZfdglP9WeJCJEnBcstzxGVitzluYfX9Hk3kbU/x+TzmGfSkcglhcIUgbjgqLiRTRm+6ZkTZJZqBxF9S1oCm7JLTuTaMLbMbM70usA03uHjcFdMx5LaRSEPQa8sos2h2dSzb2gxO1H6mIcdJ03DVdkqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552379; c=relaxed/simple;
	bh=n1ksIIbOR/Lc+6eP821WkdFeukwPoF9bQaEgMCDQBQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJaQvC2QIPRn27XuwkOBpvMeA4KN/7FfdiBEUOpFIm39bbdIiEyrjkYvJAEiofM9mFdE3j/wGmbaK63N0kGvkJQUN5uCs3cPtdser7XRDiZtgwGW9UvlOXf1Bwdmo/vMfuqGqo8yqB/PhpwIEs3CsyVzCxFyMrYqiVVISt1S85Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eL9hfIe3; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso7650258e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740552374; x=1741157174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AWm0q5kkg5ASyqrsLf1hxDCAdhd0X/a8g8veLb66Zls=;
        b=eL9hfIe3qn0j5MxsWeFcqCD2lMmrkSdQ6SsZ8kM0tUFZ3ZdBxxQDgYqHCEn6rH3GzG
         4QPS7sutcUjkc+e6Iy5I1OME3eSE6oRywpzpkntQ0HMTsqJMMP9ZGD3IXyqR934h64sz
         XqIG+YKrLLZltU98KjW9bV0q0w1nXzjC8Lj4e7og9KP1mpwTafTdylkeC1WJtB059TOL
         2gk06JOvHb1BumzVNylwhapjK863F+iCjpk8Mv/dRujJFFbYMxGChG/mqmBfTmqW/P/M
         q3cPHmPkeTADCFF2qXFTEsiPxShMAo9myXxUa4ar3dNR02ChmlEVejVhCpCVDBHgz9cT
         +wcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740552374; x=1741157174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWm0q5kkg5ASyqrsLf1hxDCAdhd0X/a8g8veLb66Zls=;
        b=nkw+bafWjzQ5B0949NeRYbyewPE4sMMguRDCThzoKNudOMoLV6jc5NlOf2LuksHB5a
         VKtmPFqBZAIlUbA7mFMJpiseLEZ0XVf++f9hSe/crBv7xAuNRE1XTYSUBTHfgP3aF+Mn
         0TtDuXAfABN9xkJEYbFa8lkfS765GhXEEqCTMlAvYh6XP2mCMQBWVd1/6BBsgtOvnw6u
         AHYZwbF7oBqi4FM7uXlzkPuDVNEoMJF1oQo/bpkekYRVFXLBd+MvmFlM9Jpbt2lyKHPO
         9nOgYUVwfKY1agl8RLNnI1Tgxbam6aZxId5ALgUWsmXJ3ENw9AKtp6tYl95IvY2mva4Z
         Xjfw==
X-Forwarded-Encrypted: i=1; AJvYcCV8iWDwVV6J7yk33CGCsCP1QlT4frE1lvy2QmGI2IOqMp4bbDGmIEOrhP5MBGiLlq+XIRylxaYLUFcMCQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpSAEAtFDwf7uqo3vYjEm0mqpHJ7CHXikAkxyVivpJTglNzQVD
	s4emKH7r63hHqkvN8ZyPs3Tvmj+WVvzVDcl26KpXVryF6Jqi+B6UVCM4oxWvN3o=
X-Gm-Gg: ASbGnctWwCtOY5hTNSZZyq6BDTW6VtBabyk629E2ewaFX7t/4//976oDROaGY95335u
	v1Usudh8YkcpuCVUvYvG7lXBrJZ6wNuSoIy5QsYVsOIrNbzlqoDulwFzr6sZ//3yTmcgEEX84Ck
	CcikSDaMXiOfnkiTwyZxH03EaNrE904P81ANQ9D1iSIyr+o1Bp0c0isDmZgGm3h1lcqkpUwFn8S
	8iVyQXpHBsLxPNGPAZeOzihxaTs1Q6ecrw4IW1KauNBsZO+nUvrESZ6qvQTMa2HKdydy15SSglQ
	qiGG3qfzrqbu77XihRgcFrbtK3e77MB7F/uS/dLblPpVU213bKz6t2ZnbBGQ7rTG3clBVuupZ1P
	P6/cuoA==
X-Google-Smtp-Source: AGHT+IESQSBp1tzujDCzQLATI4kgIcFpaXxaN5497nW7ec58c47/b6CNi+Ll6FkX3dtBSCR5Fo4K2A==
X-Received: by 2002:a05:6512:b9d:b0:545:e2e:842b with SMTP id 2adb3069b0e04-54838eddd50mr8543750e87.9.1740552374224;
        Tue, 25 Feb 2025 22:46:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514f9e3fsm363186e87.217.2025.02.25.22.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:46:12 -0800 (PST)
Date: Wed, 26 Feb 2025 08:46:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	Herve Codina <herve.codina@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/15] drm/tests: bridge: Provide tests for
 drm_bridge_reset_crtc
Message-ID: <w5nycbnj67yjpmxpqn7n44vjxq4tc66h3qnnzq7tplnms2cw7r@sppgyer3n4o6>
References: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
 <20250225-bridge-connector-v4-8-7ecb07b09cad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-bridge-connector-v4-8-7ecb07b09cad@kernel.org>

On Tue, Feb 25, 2025 at 05:43:56PM +0100, Maxime Ripard wrote:
> Let's provide a bunch of kunit tests to make sure
> drm_bridge_reset_crtc() works as expected.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/tests/drm_bridge_test.c | 168 +++++++++++++++++++++++++++++++-
>  1 file changed, 167 insertions(+), 1 deletion(-)
> 

BTW: it would be nice to verify reset of the disabled bridge for the
disabled connector.

-- 
With best wishes
Dmitry

