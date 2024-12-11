Return-Path: <linux-kernel+bounces-442307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBBA9EDA69
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF82A1885606
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5CA1EC4E0;
	Wed, 11 Dec 2024 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VsqtcorI"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14571C5497
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957564; cv=none; b=EPzRgti3IeAXxPJDgWifXY210DSfweGm2fImpqNkQ9fzA1q16IuOk2aglRFmt4fNJKPX6m0SbjwEKahCv3fzBiVOO49yLjz05bNeC5/+SM9Jh6SHbj7NiOZG359iYhFcTPPLukDasC+jTZ/z86HZyb+XeRit09K2veoiEe1HkaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957564; c=relaxed/simple;
	bh=vrvqy58xGiO1WMhROBtmXIyu9sVa+DLAprL0zNPPebM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nde8cz8mdiJ6MNak03slNywk4+ZR+deEpsLjZjnpEGZZ/qowoHOtUgzn/8wdNvyqVpyiSgAZ9bFrLsxUMFjEzu9F3UkYs32fQpJaCd/8+oyWTPOOISjqguIaX9IKQlJg0au3h25TFbh77eVUAqptwmKszmF7rSaHTnTWvuGa0VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VsqtcorI; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53ff1f7caaeso5077865e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733957560; x=1734562360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NY0DaHYgseRDWZY4d4IDidbyN2YiOVi5DaD5aAxmd4A=;
        b=VsqtcorIkH8HLjbGQT7XYDEULYbjOvHCDy4AFo4NGy5VMY6U5pq5b6ERUCXIirjCJR
         41SOim1hKB1gciAJF+5CmUQS1dSXODK9pNOUvAGTa7bYy4ZhM5bHz9Q7it2Q6lznOUSw
         Zwk+R2rP9FrAa4v0NtTPVzIXCzsDiZe9tfuyvKhpEArAeU6ps2cMXO7pW/Spte9VHGeN
         l+glnChL+qKiKEou7d2hm2pMag9ab2E1ezOtgjYlWE5lWvjNgHvWwLLCIPvbNo1CnEt/
         p2fb9ROlkb6KIUlZbk1foWnR9np4tWhXaDtr2dhF9R0TC77tVjFo8fr5DJPWn9iZOPLq
         cZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733957560; x=1734562360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NY0DaHYgseRDWZY4d4IDidbyN2YiOVi5DaD5aAxmd4A=;
        b=aWuJA8CJe3guPtb31sWnNkSK/GatKSDlirLbB4YOoJkmZd9KmPEuw3UtU6fS3RD9e8
         jP0nPDg3G/eWbfSDWZmOsMWkfKjqgz8Nc8X35bt/kGde+sv7DZn38w0C/76ZfEmsG4Ia
         li1hCdNUw1TFC/qsL/DR9jWCOg53h2WewIdzHdA0ph7JZkEY7FbpiOXAde9+yO/bdD+8
         IDCw2H6XxzWGzf9rQJsjHJV5HtaoMS8Zu8HNSRLL0gsSMG3vICtNi5phjANx6c1/ayJG
         /AFaLDWTsV7IDYxKS2IxqSO78UoeEeaAQB4iSJJVsYCWmxKmzYwqQDQ3paMirJq/lqie
         P3bA==
X-Forwarded-Encrypted: i=1; AJvYcCUsT2vkBEnrcut6xSdlmtkeDS6jkJFGtp7OYSQDQs3PRKj/BZE3YyLC3AkczogM6QgL80oVyW8vks/FzE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOwfmCF2Tv5/YyVjsa1Q6Bs31wTePmwe7jSJABtTuRRQvoK1a1
	BhVh8Y3OE1NZzKuWtXBoD3NopoaycdAdhrcwOV6GnLgTcA9hoUAxHGl4hXdqqng=
X-Gm-Gg: ASbGncuJUGxTH2EQazuwmxzUbWnkBKa+xEIYwqZbFZ0vlqLIeN+PJieYFZIqtqjiuEr
	YGKxQ9KMNfQy4p0erBeAceMQm/9ISevWcAOXHE/dj4/KDfzwH2zD3bCBlAAPNioS45US+o5W6FS
	k6UuvpldNZPquxM/YCCqGg6+bol54980ARsB9C92PKUgQ7ARuy5Elb6FhIElqZL0hQ5PK1HsZCb
	pC87HSy0Qz35SNDGoxDUUNAmg3IUFpVfRUC+zCF3WpcN8SRQFcMiEO7h6AiBfpZiur+3S4yyjX4
	8fagBNlNBqkRWmVZ305Bzi/8++NAGBwizw==
X-Google-Smtp-Source: AGHT+IF9HHn7otIsRRSetNzaUeXvxCJbkji7UoBVMa3gLuVqW6w3nM5oSY6llrPi+iNGIGJkdw3BTA==
X-Received: by 2002:a05:6512:3e05:b0:53e:350a:7298 with SMTP id 2adb3069b0e04-5402a5e4b93mr1104975e87.25.1733957559885;
        Wed, 11 Dec 2024 14:52:39 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401a5360bcsm1378038e87.174.2024.12.11.14.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:52:38 -0800 (PST)
Date: Thu, 12 Dec 2024 00:52:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm: bridge: adv7511: fill i2s stream capabilities
Message-ID: <rilzmak24odk34q3rglnkmi23e7warmd6dytx2opkhjl3kjujm@fqxqydwhcluy>
References: <20241210134254.2967524-1-olivier.moysan@foss.st.com>
 <20241210134254.2967524-2-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210134254.2967524-2-olivier.moysan@foss.st.com>

On Tue, Dec 10, 2024 at 02:42:52PM +0100, Olivier Moysan wrote:
> Set no_i2s_capture flag in hdmi_codec_pdata structure to report
> that the ADV7511 HDMI bridge does not support i2s audio capture.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> index 61f4a38e7d2b..28ae81ca3651 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> @@ -234,6 +234,7 @@ static const struct hdmi_codec_pdata codec_data = {
>  	.ops = &adv7511_codec_ops,
>  	.max_i2s_channels = 2,
>  	.i2s = 1,
> +	.no_i2s_capture = 1,

Does it support spdif capture?

>  	.spdif = 1,
>  };
>  
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

