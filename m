Return-Path: <linux-kernel+bounces-361220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8255899A531
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9437E1C25C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E373218D85;
	Fri, 11 Oct 2024 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EbC87Zl2"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AF02185B1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653783; cv=none; b=omJjKeHLmRu+lMvsiwhMO1vQh5hmT8BwizGO8EhtBmqURjErqIx6CtabENNzXs8AZd75T3Om7y0GcGaekWEbFtDDtWQ3vxXxN9qia0c5BNKHmfR4eDghme/pKQgyHnr/Vw6so7x3czMgWNua02R57ju9uYsAA8BQ6jJyLHQ2fTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653783; c=relaxed/simple;
	bh=D6gOZfnGcYSVxHiFpN8NO/ZqXyxi89KGytlDAam+Z2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cl735F7FmACrhO0ZCij2ry8DYl8cNojXUzdsm7tV9x1hqPjamXTF4Dh+8yFCdLxK9BJaBUxHe+09WH3HGK9oLTlR1tp/eoWfhS3KQJhkH7tXKf97zgSS+NLdTPtBme77XkYft46R1eUosYPaTiSI+HD85wn9PTjBD653+FOrYTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EbC87Zl2; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5398e53ca28so2276719e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728653780; x=1729258580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=16NQJIfQQN3RKWzJPPJqfkpmPdgnP/hNFrOu52tsvRQ=;
        b=EbC87Zl2SxN3p1HZxY+HRlfxeQxpVPRyL8hD1C6UOTj1Vto2XK/LpGTUmQxK2H1G9p
         NEA3p0kUFpMRnBqFSuRhnZ/gyBFnInb9YsWD7lh6x+l+y6ERVvz9ljn2v+4/fQRbOSqm
         XCE/s5yCVJ8EKuYQlEPW+t84eAmRAmxtqzOKOItC0JAX6uLHv374H3z5GpKNoFlxS6Kc
         NgfVHDRzlyynwdlSTMMB1TmyJ+gp7VNgAW0JsBqa5oO7cVP9oFdY1grdWRmjhMyvg/Or
         VH3NhgzrEyXgRMIne9XqW1UK3LNHhZ7L6cAfi52QhcUlg8GcIz8MCKiFCsTfTqXYa6XM
         Ip1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728653780; x=1729258580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16NQJIfQQN3RKWzJPPJqfkpmPdgnP/hNFrOu52tsvRQ=;
        b=GkXoSRgv/gZ/sxkilIC+gFmWhzr6f3l7NIIIxvXyKFqYVBx14bhPSBInLuSsTm7tLw
         75HATCm6mDY2qFfbUVlUGFifo4/Mve8+WNvZTZsGGjQ9xqkiR878Y+mQ54czxzmaGtRj
         6kEfvbmYiNUVApgAxtCnqzVUa3zTudbXu0vdc1GsJR9rV6wot7oLR3tT3Yg2ILd3CNRm
         mPPlgxxHXXJiVVqF6C66lXXp98vFiMNnlSICrCqhDRNK16BQ8KwElEdwdoqDO2cze1rN
         8M0Ugv8NesEK5QKtFDao/U5dfUCtavX28cu+TRYVdvqS8j1Zcn/A3B5gxh3w19lJ/k/O
         AGdA==
X-Forwarded-Encrypted: i=1; AJvYcCVytYP1HUEEqyoFoF0aV3CEpJdzYmrT0QH0aXJkzLxTFR6f31+LFlgO6I1tis0SLB/ubwWi/cG3rpVN4qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YweRFFuJe9FXzNnKsObbos4CFL2M40XtL4g8hVB5kJmmpOopMaK
	QolYwuf5PRI77WjOlQfKjpMVom7xtgw22Na7iM2fwxYUBih9VTA2BDe3BIeHaXM=
X-Google-Smtp-Source: AGHT+IEl3rntcvnVaj6u16HUW1Qsjdsjk6hBk4pKAVJDuvo7v9gcY4KzRIeDk2gIrVO8gByUKBaGBg==
X-Received: by 2002:a05:6512:31c3:b0:539:9ee4:bab3 with SMTP id 2adb3069b0e04-539da598f02mr1638654e87.59.1728653779871;
        Fri, 11 Oct 2024 06:36:19 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb8d8074sm608931e87.129.2024.10.11.06.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:36:19 -0700 (PDT)
Date: Fri, 11 Oct 2024 16:36:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 10/10] remoteproc: qcom_wcnss_iris: Simplify with
 dev_err_probe()
Message-ID: <6o5takrpkgunudfqptwa7q2xbqzkldsctpiys27f2b5gkilcgr@ojqh2k4byqkb>
References: <20241011-remote-proc-dev-err-probe-v1-0-5abb4fc61eca@linaro.org>
 <20241011-remote-proc-dev-err-probe-v1-10-5abb4fc61eca@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-remote-proc-dev-err-probe-v1-10-5abb4fc61eca@linaro.org>

On Fri, Oct 11, 2024 at 03:09:18PM +0200, Krzysztof Kozlowski wrote:
> Use dev_err_probe() to make error and defer code handling simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/remoteproc/qcom_wcnss_iris.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

