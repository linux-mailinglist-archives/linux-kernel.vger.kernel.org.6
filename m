Return-Path: <linux-kernel+bounces-388594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4BC9B61E0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFF81F26080
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2108B1EB9F7;
	Wed, 30 Oct 2024 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fy4uWG9x"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC401EABA3
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287888; cv=none; b=s2EzzGfhO7y5pLPTYJB3ipbUMeD7mTa3KpeJYdxfIHg+TcHrTXh799Cs8MKtwm1F7M/LWnj88IZuP7p9w588tNREWxS4YYUvkfpCaHcvFyzovg/SETS/WSwBuIOfPFDRdRT2jlVGe72JTOh3O9G+SfKPKEIPl734OwiXQFYhJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287888; c=relaxed/simple;
	bh=sxaelGT4Idpj3BClN0eoO2elk6zpAu4e/9ginvYJ+4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVCPe7L1x3WCClpnyOjoTz26AGACIEFuKXNf4D5gJsc+kqaqF0joxNQlu3Kw8HTrPaS/t6iy2QsWtXKxPMNNUMaRZO7hsr8MT9l8B7uyT87dhRyPbaPzLmXl/SvjuX0cf09Cfiza5YXo2Iv0I3ln2mFr9u1Bea70OQq89y8ofBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fy4uWG9x; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so7007013e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730287883; x=1730892683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cX+ON3ydOpBhTY6o2Rbqes4QOxAe5cTgNGKeiB9S9mM=;
        b=Fy4uWG9xdnh4BLS2yJeB3ZHbBdUc0ILLrxm2OSQ/T2OmB3pkIkx+/RXDO2OaoDlv1L
         pM3c3Qd92xzHkaBBEL7J6vxc2+Q0/AdWepcit3Fqfq4ia8o6ijvRc7fwrtzz0r7ORBmn
         5hxE/w/hnXZCHB7e+2a0lZA+EKQkCgJPHq7hvnufdLR/7PN5Z6KEBUEztfASseSXPsPu
         k8TgCxXjyZGiHqZ3v6h8EY1ijmAay0stCcrq25ZvH3/hNSIfc/j5E9VelH8dHfRo5jRe
         XdjU/2FkN5FlkF+kRmnx9w2RggjEYetRjU/+2Gq37jt2axyxY/WmXUnWIQVhAhlwlx/K
         mwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730287883; x=1730892683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cX+ON3ydOpBhTY6o2Rbqes4QOxAe5cTgNGKeiB9S9mM=;
        b=Gz49WRHfP/52GhpuIpJDoFQzLJxj/JA7XNhmSBI9bSoyC8Javlutft+2mnW+HhTaWz
         0S+U5pNPip0OHZFIqTXxKlq27JXS/dUYHgMGz8Z77gwnhL/rm4gwq6mFI4i3NYLJHCrc
         6kJlCjrhahM+Sj7YpfbNTsFGbaz9EJusn3oEb0687nMbnm7gT9mKn/twiQlxzOXsJ3od
         kPEZMjCMjiTR0rAsizCmmHbotHx1FNw0J8qmHfHVkWtm7OfLO02yUbT+grY+LaRD48VZ
         M/EQwFBQxkTNsNFOodOIOeNQ6hIo4WTbCl8LAMc6lwtYbDajhM5KX4MoX8skH3SiQWYp
         CyuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa/vaQtGhiO6RKTvszvaMopRSi7hStYECOeyWEHXJsAfJzN6o1nkzBgY0aR1Pa0U6zXqZdj1gQHNTapcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxemfmonmp33zwXSKb/z1VmxE3Ixh6OC87Z64+NC/2GcMxmTNHh
	vMp/gu5YsXonjuT+ZeHArpDah9VQj/pNZgPlR8pcMGOGiAGktxKyDIh7C6JZfco=
X-Google-Smtp-Source: AGHT+IEenLKvMDS8jmV4t5I3gxQ4u0flSc2k6Tm9NyWl2kHf7+zqlwDZsVHgTGFOMNvFzMYwSoNqqQ==
X-Received: by 2002:a05:6512:baa:b0:539:f1ad:b7a6 with SMTP id 2adb3069b0e04-53b3491c819mr7479539e87.37.1730287883506;
        Wed, 30 Oct 2024 04:31:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53bb8190cdasm229410e87.23.2024.10.30.04.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:31:23 -0700 (PDT)
Date: Wed, 30 Oct 2024 13:31:21 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, Stephan Gerhold <stephan@gerhold.net>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] cpuidle: qcom-spm: fix device node release in
 spm_cpuidle_register
Message-ID: <qpnqvvrv4lfmhavrt6apn2gajd3ugnd4k6ombcuejzmy2eczxq@3pgxhvac6eyv>
References: <20241030-cpuidle-qcom-spm-cleanup-v1-0-04416fcca7de@gmail.com>
 <20241030-cpuidle-qcom-spm-cleanup-v1-1-04416fcca7de@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030-cpuidle-qcom-spm-cleanup-v1-1-04416fcca7de@gmail.com>

On Wed, Oct 30, 2024 at 07:38:32AM +0100, Javier Carrasco wrote:
> If of_find_device_by_node() fails, its error path does not include a
> call to of_node_put(cpu_node), which has been successfully acquired at
> this point.
> 
> Move the existing of_node_put(cpu_node) to the point where cpu_node is
> no longer required, covering all code paths and avoiding leaking the
> resource in any case.
> 
> Cc: stable@vger.kernel.org
> Fixes: 60f3692b5f0b ("cpuidle: qcom_spm: Detach state machine from main SPM handling")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-qcom-spm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

