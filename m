Return-Path: <linux-kernel+bounces-394659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09CE9BB26C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE241C21620
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0826B1EC008;
	Mon,  4 Nov 2024 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehvVF8Ab"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF601EBA0B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717705; cv=none; b=myGw9Qti6WYu2mD4QMpylx2r5Nos1HBjCc1Ibf6b9GOxRW3ByScj4qIOiMsrJ9sm5U9rHBeLkhXYNPank1Y1gVvK83Zk/SqyPgJok/dY8RKe5NNKLv+l87L7IAwaenqpc+jCZ873ALCnpovgQgX4SW0UEKUU7h07dqRCXC9Xjpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717705; c=relaxed/simple;
	bh=I9OiWUCyKv2i9D1CwAcyraCsNGRc6/tNnnnAMUwXakI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB19jJkKZ3TSSZCvPOi8vr1PLANhuXXQRai46ceUyaqWYhCJiSmvEMrjSo8gsw3H5cGzx8IAKWdzAovlCcuH4Elrz1h3bHxqC6GlqXxPJLey4E6p24Q06rpOzXT5tG6XXSj5PXXfc4cMCoWJiZMDV+pShZtTDzoIWwi1dHY/WyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ehvVF8Ab; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539ee1acb86so3962329e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 02:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730717701; x=1731322501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=upe7MW1samf6eEWvfqgJG4VdfRS5tGsncnrDJbr4CFw=;
        b=ehvVF8Abiyfq0cgPrRjJP2WUEJidSxnLx2yAPiqikwx+hPBxsxdzyGtv9WwnfHNIvJ
         AWm4yO2A2GufN+3Jk5qRQTHTb2NM5PV1oNp2W0PwRfJaLzUQ0RpOFXyznX3LE6kLknzs
         8M1rKwTD7XEd8AZQfsuwruJzbFJBm3o1/Cx0b+lyxWruJAoyx1YIHb+ZOqoZmvezyIiS
         YNtsm22wD0i/NE5IbBSjStg6eYgnoi8MRYlHtuBNioStR7C9jc0Oc8ZqQHtwF2044rku
         J6OTEPJuVupVxKl2JU8hSQT4XubuPSlM/r35HoCjYYPOlU+i1Bp7HruFsjrZ5x6UVpx7
         Pv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730717701; x=1731322501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upe7MW1samf6eEWvfqgJG4VdfRS5tGsncnrDJbr4CFw=;
        b=pmVVMPVPNgeKRYVAGn/2IsmMSEdtv4O0gWNHNg7GiThdNsd2ncwnOjfMVgefqWLS+C
         PG6/7rkG0EqmvgDynv385OUSk8QRshqhBpe9yYeM0yhSDtDrPOlcFDAuJ4/aa/1EBej9
         oWTdJ5vFhstowScf8r4RxDeRvobpUrSWTz3IPp8NS81MMSnktqEqIjrIllGhR+Zeyiwe
         w3g65z0A329tm7HDrpirwQFrAi0PzYl5XaCen07F5lW20mXBiu6FAZ2dvoA1/1wlHQpb
         cIMaW5np0uGhw83hIOZrPM7PONddBHTlECQbzmxxNpYnoR4qD387PEOa9uobsIrqEn3k
         iJqw==
X-Forwarded-Encrypted: i=1; AJvYcCUKCSeEa1a/8VbfRzMaMRo1o1JfbWDwGM+Y3gFghzQMHD3G9g45OLaVhymCkCrauDY3Hu/Juo0lqkpyIgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHkDBJU2fJmrOmlK0N7t6J49P1h3QkG7GHe9FDn7hQhYeAAi/T
	uK1D2Gje2oDRmD5hadLFxFiDnMLhxmrkGg4afWWl3StrC6TAQOpHBmwhl5LDFjs=
X-Google-Smtp-Source: AGHT+IHUBwMeOaPmp1xgOzS0MycFuKWOfrs4hmJDzT6l2IQ76clWN20uWq7MD2t7TvXn3CfLtTD79Q==
X-Received: by 2002:a05:6512:6cd:b0:536:52ed:a23f with SMTP id 2adb3069b0e04-53d65d945a9mr5861120e87.0.1730717700730;
        Mon, 04 Nov 2024 02:55:00 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc96136sm1631523e87.10.2024.11.04.02.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 02:54:59 -0800 (PST)
Date: Mon, 4 Nov 2024 12:54:57 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] soc: qcom: rmtfs: constify rmtfs_class
Message-ID: <c2agcw3hnwknxtsp5al4bfyjlzauyrz6d43imcbagp2wm5rmrd@y3t5kmbxuxgo>
References: <20241014130303.123394-1-brgl@bgdev.pl>
 <20241014130303.123394-2-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014130303.123394-2-brgl@bgdev.pl>

On Mon, Oct 14, 2024 at 03:03:03PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The rmtfs class object is never modified and can be made constant.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/soc/qcom/rmtfs_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

