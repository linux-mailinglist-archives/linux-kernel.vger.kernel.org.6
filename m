Return-Path: <linux-kernel+bounces-529638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6336A42910
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C754237F3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E01244195;
	Mon, 24 Feb 2025 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ac1+xFJY"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345F52641D0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416786; cv=none; b=ELQDnvEyhegrBV34jhRSuiboQeB3BRBRLOVVktTz1XpIYO/h5Gx681y+RtsrA9+vjrrrHwLFeLArYr1Gv9x+V5WXKgoHHFUXzRZ2h9sT116eTioekTqWa6qXgEAAiceLzFKmznDWzARKLG1MOuhY1ivhV21T1CMx/LwJMzK0S58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416786; c=relaxed/simple;
	bh=yvED5J2XN1JbyB5oPdWALpBVxI60w9uI2eoMV6sBGTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkSRwEMxNzrb24wbxCL+weesoRl75vkJvJIZOyyxdlDQNQfMu1FfYl/JJ5RbUmSdQjXDPuxW1ov4MXEiBSVD8tlWfC+nYu2MOtg3wTQdzX8oEWpM4gZe/HhkWxyz+UGkCv6IPXb93649mx+ff0I5oncAZCuniJ53XkEZ6tY0Evc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ac1+xFJY; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5462a2b9dedso5554537e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740416782; x=1741021582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KAI2Dv3BmBIOzPpofW0T5viVb5YozbQk3DlKy+pFvjU=;
        b=ac1+xFJYJqvRiGGwpw8SFzUn8WXs8x46p2JV1qUVNAqP7iATAnoxsJWSI24D2FT45J
         ISurQeo0qRmI6HH+6Y1xnUOuJunASeP79uf8QqSbgvBvZ2EOCi/ZEsWnt96vpxz15iKZ
         +HRibIgukvIaWkBc4TBfhbCAEdzXmlSjAtWrJGAJR2OiLXolTfvunCyYi4Mhwx1UQDus
         z/mfYy9wRSRbF6BaQ3u91YPCKZxmurYmBBx4dV53G5QCu35EGdee7VlIoPsjyTefxPIK
         iZTlDUnSMTDQcuTpG2JQ80WqjXlGyIedaIZku/m2ffX2KsXCOqg0wGRDAvzDah6YWsr/
         tu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416782; x=1741021582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAI2Dv3BmBIOzPpofW0T5viVb5YozbQk3DlKy+pFvjU=;
        b=XX/XWMXAwrd+ctRlgIPQZNJ+0QvABvVk6Va3mXDeRJVtrGx+weVkCzCpRMaGjfNQ8F
         L3VcAjqdd0D7VNTQoKvhXcepCNjsicv+uPqsknX10iFhD1wEDsVdJqECjVh7OmzBLQYV
         9brwfnt5d+wnHLHeHT3/7F7ztiN0Q5kzqT5GVINwTJzxvHRdCXfGe7fU43JzOJba6iU6
         augFw5RHO7z2bkJqhvyq2O92fnKSPtDZjSDC8FWAXDgz5rKMDKVVGl6gYw8wt0nhwgrP
         1c6e4zQq0jnPaDpgmBlv/851KpgWsE7UWZk+69uPuS5jiXpFAB3jVBW9jZNjVSCXc8Eq
         qJ5A==
X-Forwarded-Encrypted: i=1; AJvYcCXFTD2OcBpDTfFJoFgDA7UfLmJ4DA1+QaHppEeZu3Ea0wGNMv7zQE5RzDqppKypbrD7DwwEHKrVQUUlpmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyelHOB5Va+ENKsX6IeqKZstFCqAypq5gC+h9o+dIAsx1pANBkZ
	cvxb5U5zLyp8qryvpL5dc+U6aCMSMXoTULSBX1DxzHbgRD1L83yX5z4z7g4MFO0=
X-Gm-Gg: ASbGncs3/toIuYnXvVezQmpXG8UTNvL1vOolBL6pZXx32hgcWJPrrQICuTkc9gG0Fo7
	HgZcAx8OT6s/coJ5x3H0DUXL/5UkIAR4GRgDlWcgRJG5m254IMcj+VxmyQKYHyX3gPMNsexjtrE
	Zu6jf3pWGjr6MsbOHTxBTfL/yv0pR/Iuf7tI9S6m6XBOSyQQ88rogJMb8HxlEsrrDovyIeOmf1x
	wG6LbrnxRs7Ch13FDgKPLfQdXNkrQIaS9jiJHwj8ZOqZbms93LHXIP8o7rug6d5pdAmOPY5B3eO
	BunWgBFsrmfKS1Iau2u3ooMNsCGsfI6UvkhBvatFC8PdpCZ4HG5W09voLV42Kcxsi/WZnKhN9JZ
	dPCiVTg==
X-Google-Smtp-Source: AGHT+IGLfOFOqzaQJyDCTcv0MpDet3B2RRWuZ7gWh8BalbKLyn2Zcyxy6bVh1dYMVsTGa+JcYy5D2g==
X-Received: by 2002:a05:6512:31cf:b0:545:a5e:b4ef with SMTP id 2adb3069b0e04-5483913ae13mr6288350e87.16.1740416782196;
        Mon, 24 Feb 2025 09:06:22 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452b496aafsm3110858e87.29.2025.02.24.09.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:06:21 -0800 (PST)
Date: Mon, 24 Feb 2025 19:06:20 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: q6dsp: q6apm: replace kzalloc() with kcalloc() in
 q6apm_map_memory_regions()
Message-ID: <taqe76gyodbrbp3qxvzhgmhdaae5jrun66wtlrq5jeklonp2sh@ujmwaxdhjxcc>
References: <20250222-q6apm-kcalloc-v1-1-6f09dae6c31c@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222-q6apm-kcalloc-v1-1-6f09dae6c31c@ethancedwards.com>

On Sat, Feb 22, 2025 at 02:55:20PM -0500, Ethan Carter Edwards wrote:
> We are trying to get rid of all multiplications from allocation
> functions to prevent integer overflows[1]. Here the multiplication is
> obviously safe, but using kcalloc() is more appropriate and improves
> readability. This patch has no effect on runtime behavior.
> 
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  sound/soc/qcom/qdsp6/q6apm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

