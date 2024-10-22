Return-Path: <linux-kernel+bounces-376070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7BB9A9F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F201C23D74
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A526C1991CC;
	Tue, 22 Oct 2024 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vXPZVFWe"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945A145B24
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729591562; cv=none; b=tEpPWyr/NhCZTYEyQfTvz+zIh/Jf5RFOfOoQfEpNS4J+EnMi9fKILfC+EGWMzEXXsBelJCjBYDVDmWIfTntz1teWIRxiO5sjPhOprf0YTZ6K8YhW1NZyUJlyCTpanue1EiIoh94yC3j0zjXG1eddUeIbVpH7nItrlcANFrAcPfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729591562; c=relaxed/simple;
	bh=gIXc7PVa7+/YsDHcjS3zLaR6+ygz7n1170bJx4NtwoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqWUhn0v3NnsTXor8svfpv2jeC/VrHo3ruHGIx/xMzkJ8Xw1ZvHL4GpTTbw7u5jfdVimU4s1pa3h3mllKf1Vin//CJms+vnFMyjjuDdBLr29Yyy8dSrxnL6SRq9k7IKmyK7jDNoYQzt+vs2xBwBGn860glG8d3/A6VvrW7bTebY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vXPZVFWe; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f84907caso6123784e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 03:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729591559; x=1730196359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CC7DJqMFm22rWa2CZIV7iyhBuISYs9V8wjvuLCW0J3g=;
        b=vXPZVFWed8ru0SI7ZOrA9RdivSzRwMwPXJc7Rywesi6t0SB1wYt9VnunSKajM0Hm3L
         oDF8U0zOcmPttFG7upbJ4omgE17aHuUzMPUr2AiS+8jys7Gg75DtaREjabh6FL3s5kA/
         kLSs1U9xsyktirsjT+tzLgbO50mH3XH2LICrZskATOw09AHFmpyrWh9w0jyd00DMDPxF
         uT1bnhkYatW2/U5ffv92lERhM+/rDZcSx1JmIRV1NWc6a8hTP+sHjD+jtkGkjYkQCkKY
         KCxCj1bIyuVIwNuivGf/c5rbK/8mwxpJjERJir3qCM/ThI1WmlZHAX6MzEGCQSDuZgdf
         t7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729591559; x=1730196359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CC7DJqMFm22rWa2CZIV7iyhBuISYs9V8wjvuLCW0J3g=;
        b=guezIJ1gHhlOxUQtGCAXz/EcmOAK92ebVAxGmNdIfqePrmYfHZUI2Y0d0+oaLIKC0h
         Zuio7o08dH+LyEBdVpe6HMMMQsPCbfRr06mjhA11f/XwJJjCkorXHcioxWAnZ/WeqMKG
         6VA6qXFsONxFOWNkRq5FXPL0r7Kyrk3Ac/tLGN0jfJoqRJs9mSH706VwVkmDY9eTIbB1
         R675fyB02rWIXcHjVjfMHw2cH3glOsrMFEZJfZgO3ZPZaa+Y4npfoJKxgUNcJkoL/d00
         8DUfeyfLPX2siE9nCKrDVsFm/NdyAcRhXclYv8Qw9jtkUgWCSyRWrqOltWQ361qC2JIG
         jUrA==
X-Forwarded-Encrypted: i=1; AJvYcCXBfjmEFwnraoYOyF9xUlNBbrSutkxRsb0jx4C/0RzxN540wnvLoxXpEBd/dkdZ5Zs+p5VjF3lKKlV5ZUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkh/uCAQqwMZi9RpwElrYLxawabdDq4T5RcsFXGkOD8LKy13/q
	1bn9wXLLi2xDMqk1vyhqMZSWHlwDS+m6FPNLzlSyZjC/lG06Qto6zE+3gm/6tIM=
X-Google-Smtp-Source: AGHT+IEI/FYIMNLCpPAvkqpzVkn0rC0BC2pW5ZYZtQPQQIGXmZDU5cGg5ISGF5wbLXSztakYj3sKRQ==
X-Received: by 2002:a05:6512:3995:b0:539:e65a:8a7c with SMTP id 2adb3069b0e04-53a154a839bmr8428205e87.58.1729591558557;
        Tue, 22 Oct 2024 03:05:58 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b136c2762sm192378e87.250.2024.10.22.03.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 03:05:58 -0700 (PDT)
Date: Tue, 22 Oct 2024 13:05:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Chris Lew <quic_clew@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: pas: Make remoteproc name human
 friendly
Message-ID: <2ehdvo2ba6l245nmpqi6o3mbx5kgwcp5iz7ghphpnr3veqqrai@2gogkb7irosy>
References: <20241022-rproc-friendly-name-v1-1-350c82b075cb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022-rproc-friendly-name-v1-1-350c82b075cb@oss.qualcomm.com>

On Tue, Oct 22, 2024 at 04:21:03AM +0000, Bjorn Andersson wrote:
> The remoteproc "name" property is supposed to present the "human
> readable" name of the remoteproc, while using the device name is
> readable, it's not "friendly".
> 
> Instead, use the "sysmon_name" as the identifier for the remoteproc
> instance. It matches the typical names used when we speak about each
> instance, while still being unique.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

