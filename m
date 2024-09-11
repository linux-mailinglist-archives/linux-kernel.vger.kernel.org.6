Return-Path: <linux-kernel+bounces-325514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0B0975AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD7F1F23453
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412641B5804;
	Wed, 11 Sep 2024 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GOckHCbl"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4BD762EB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 19:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726081301; cv=none; b=J/pnV8FQ1O0yJeccW2UUZ5R5eXx0m42QZNVYXKR2FRnluv52bq1V2gH4j/o3qnw/3kdfd1pYSXoFzen3KzVXIAAuBfVuK+S75gzj0jWeJulOfFBx8vBagnWNW94sZoDINkGMKByRLkgq33MfYB0Ak+nB1XsOd0rR2/CTmWiZ0yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726081301; c=relaxed/simple;
	bh=kH3LuToOHa6db3WM2nZY+JYRpzIzkBdEitM5B9H22Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mI22kqeMvnbEn/PH1LWPRTSIlEAnJ7zcBUa26Le7GdSU9j06mJD2FJtczaXf8SJSkaEJZgV54CstcDfApumjqmhJ4b+qtvSNQQtdZRHcOkriIRJCJRfi+b4j4460lIbOZlxrtEhzD5opEEEPOvmDjeMWUxHUTsYXdZnOvqiaLrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GOckHCbl; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5365928acd0so165402e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726081298; x=1726686098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gWLfBvU9thbiDwhY0G6uXsn1HToOTkJx1+aOpLmvWp0=;
        b=GOckHCblGkRklTosyMy3byELv9kFRRM6na76FI4BpVDmiei8psfuVB61wvMjpd5Ixy
         E5/g8bO3UMpt2VHClrWBaC0b8Z5QH/jaGD68rviwsZ7DxUmo0lMCSQdy1t1Lvzl5J3Vf
         l4NDEGftOFLFeLOxZYnKB9pk0Tc9XUSBEr7W8y/+RcVGx4Ei/SXZo/SGyDNBBo8UVpJD
         hYEizM70jlHleSHZMErKzaMfKxI2iG20n5VNg4n0TEI/n/bz1deBgbn+NTtntN42PkEQ
         SXYW2f1kzSQwG9GldVkTZq+2zM7w79CBiIREJVfa6u+WEbCtQdUuVekYMdNJjwPT953I
         ma5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726081298; x=1726686098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWLfBvU9thbiDwhY0G6uXsn1HToOTkJx1+aOpLmvWp0=;
        b=WhErs93RdPYmvRRRtSbrHXZ7uQdhPreXbyL+6ckZkFNlPZ8DBUDtoUlNVn/eLC6TlV
         4OlyiIrwdJSxz15Cn5LfMx0yHOL1vDV93ZaMyrFDDIgmPIZFaXU2xNUudSTLlQVSm9H4
         kD4PnCbQ6XfeyXAXMuw3gI9P4G/AJakrDcEjU4SteWf5qL3rf02koX3gtCFZJUGRmgsW
         N9XaO93Ndoapm3hBiuiAuXY1kKQvb/jFRKX3/6XIyT5+b569r030XwzJ6DGCjCIx1On8
         Xq1lyguR7sD1upz9RDC1+YxmRSfxX7dkqBT/P0xGHgAF0TpXNo8XiqGfiWpddsweO3fY
         NBbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTJjkNZYTEBWaN8Yr2ExH4/2rg+dpk00kU6KDgfwh/FlCHkMV+OV8O3j+rdyBo/TCWV1QUM1B7sR+C+Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw32u+flYdJPv28FZv2xCxcmZl6eT6caHAhIiRPE2Aw0efO5ZUe
	/+TecouqjC31LY9ebumuMDy8npkZ+CaqKonS50ZF4nqdKNHSLRlb3IvAyOfEsMo=
X-Google-Smtp-Source: AGHT+IGvUrY0NXLE2kfEi1SjtrIlfxaP29Ud499f9t88oQIMLSOo2+1mSb0m/gpMYrvrvoW7C3IPNQ==
X-Received: by 2002:a05:6512:e99:b0:52e:9f6b:64 with SMTP id 2adb3069b0e04-53678fc2279mr203397e87.34.1726081296949;
        Wed, 11 Sep 2024 12:01:36 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f90c306sm1653668e87.245.2024.09.11.12.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 12:01:36 -0700 (PDT)
Date: Wed, 11 Sep 2024 22:01:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] phy: qcom: qmp-usb: fix NULL-deref on runtime suspend
Message-ID: <zvy3mvgvkhrey3qcj4m3mgfs7apinsr6t2zo5afjjxpijhs7ig@tzv7fe47bodk>
References: <20240911115253.10920-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911115253.10920-1-johan+linaro@kernel.org>

On Wed, Sep 11, 2024 at 01:52:49PM GMT, Johan Hovold wrote:
> When working on suspend support for Qualcomm platforms like x1e80100, I
> ran into a NULL-pointer dereference in one of the QMP drivers. Turns out
> this issue has since been reproduced in two more drivers.
> 
> Johan

For the series:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

