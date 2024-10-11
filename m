Return-Path: <linux-kernel+bounces-361216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F96799A524
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534101F22E28
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CD6218D70;
	Fri, 11 Oct 2024 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DB2JkzZd"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C107B28E7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653722; cv=none; b=ZBh3rbJsKSWvVA8l1UEiqIPSKq5gmmGgLrxFH1CXdvvbIjqIl7TfgeJOlymRgDhBXjeDv9NykYoucGzbOcXrFEgdI1a+jqP9PFGtzvp48vNhMjuUJz755JgI3WRvNjEI/Q45gaMjSqo68E9BfBalSYQQ2CcSGXXu2q9dTvx/LkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653722; c=relaxed/simple;
	bh=EkTcLG59Q4Wh5ZIKc7+7wJm7NcDhqPA7VwUd8kbAgfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdwHCjOMS4YD62x7UGqLIi0dMGEundt/t5e9kaHWmzy8aEiVyxcOPYRNFLYjIRPhNJcfR42CiJdCZGFkNKTDVV8Ecy74OVBdwt7ZWc3Buf+oQCfRdfKdimeZ5G7zSdpKqscJO5fsEYaL45y6Jx4rUCULNOtcgVZgeT8C0jVVL+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DB2JkzZd; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539d9fffea1so825478e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728653719; x=1729258519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rG8zqMbqmQKD8FKQihMwNmSsjclOXl8It6tFFfw1Ars=;
        b=DB2JkzZdoJwYGNR7bhYjbfgwl5Jzg9gVz7M9558B3VVCeita6va1Pv8cJtmS9UnELC
         B35RbJzg1s7mnZBdhoBqBgnD378t5AcWj9hOB265yW2Z8pt6kRwh43BZo2/c4eGOYfHF
         XVUa5WvsK39TQTylgq+rtatOymnL1fb5cXTUjvlbyxS0x/pPf3oaR0L477gGMVHbr0+o
         4kQ3vA2q84WhnusFV81hgaeEQdgZoImI1UKYLNY64xtidoo1iY+RKvd+FfNGqPudEvZ6
         LBYRgoWBfjG+89giTjcT5BZCFwRuSXe6oh5v7Ila9ToUw4CeqQd7Si/U1CSdpRf/Wf5W
         xuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728653719; x=1729258519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG8zqMbqmQKD8FKQihMwNmSsjclOXl8It6tFFfw1Ars=;
        b=wNAtWiJ7cpDVJfSOtNJlAqXFHKHzOGjNnA0rXyXfBOhAUnn4ZyTn9CKABlRf2vtVHI
         BbsvEOuu4AG9+02OYEfxy5EzEpyKpneEJJ872bwrVgugwOrJrLL9g/utz060fisgJvvq
         UzW0GfxYR6hEbn4sD0fK63g9t23k0S5q0jPozErE5mwo2lkKS2VgHo4mZafC/C+0RGmt
         CDWtKJxmTRNMSc0AQti40D3UrM51nai672MvUMPWnpYbxcXPMAmT+iLWKqwmXGRlnG/P
         Bkg90LYoLbQVhfIQBsc8Z/cbaEwBtpCiOBOi8udDJQ/vrP3FvzRjj5Pw/tyIDZGD3dGX
         3b9A==
X-Forwarded-Encrypted: i=1; AJvYcCXExb6pDdGMZd6QZ193yo7nl+2hgEERyVv7+Kht9Pe1Xrk/gWxEcGDl05oaAsKiKblcu/BMb9HhpdzrqgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCj0lwohUbgGENNQ9IABTtiyPNSihFqminYAFwcJ2NVjvtJVLI
	h8N01Q3Zux+KnTqCWNSY2tO2VfHUUISCsmDmV32Tw6SZxXn8231oTOCRHxL8FD4=
X-Google-Smtp-Source: AGHT+IHQpz/6GvIvHaMf1u3ffEGjPUPDO5ESVhqpSrZKzBqsenT6o2iZkgVDJ/mHkWrrUbIg88qi+Q==
X-Received: by 2002:a05:6512:3e2a:b0:52f:1ef:bafe with SMTP id 2adb3069b0e04-539da3d0e40mr1403776e87.22.1728653718909;
        Fri, 11 Oct 2024 06:35:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539e3190932sm69337e87.174.2024.10.11.06.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:35:17 -0700 (PDT)
Date: Fri, 11 Oct 2024 16:35:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 06/10] remoteproc: qcom_q6v5_mss: Simplify with
 dev_err_probe()
Message-ID: <ihown6evv2vnlyaiffjuetpw5p3mzcgsg3cuy2npnk3s3atjm4@3lsk2s5kz2yd>
References: <20241011-remote-proc-dev-err-probe-v1-0-5abb4fc61eca@linaro.org>
 <20241011-remote-proc-dev-err-probe-v1-6-5abb4fc61eca@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-remote-proc-dev-err-probe-v1-6-5abb4fc61eca@linaro.org>

On Fri, Oct 11, 2024 at 03:09:14PM +0200, Krzysztof Kozlowski wrote:
> Use dev_err_probe() to make error and defer code handling simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

