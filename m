Return-Path: <linux-kernel+bounces-333804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095A197CE54
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 21:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC05D284FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AEC73440;
	Thu, 19 Sep 2024 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d4YSoGC7"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939D6139CFA
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726775905; cv=none; b=DCn+RthSXQKh7spcWUH35gVDVTY4C0quN58y9cB++MWEN5Gxpelp1mGDjPop3zq2mRX+qjdpZAii9igpjgcutFlho5Piy7ByaZ6VCVwCHdMLS/QPMnnzR5d39SooUx4pWWpKtjdwGw6mBjmPZZ6XHM5s3AoqOVXO8lnX7PMhwQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726775905; c=relaxed/simple;
	bh=aI7ClF1DwMBcWkQTFOuFWUi2ar++4bwigfoB5y/OgFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6iRMzyPuGGrmheLThrCzKN/0itVyzsMHLhnPyNQHj+epyeIDEYPdE6WWkJdWQThxeh5rViix0EUm/DSlhHX1TgOxuvXxOB0eNdLHRHWJCDXypmebmPxlufwMh+CbapBNtrTLu8jRNVsog12VsI1y2K+pHsai7UTD3o10f7l3a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d4YSoGC7; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f759688444so10655061fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 12:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726775902; x=1727380702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3T6VG4XZ1eVpUOvChP/8TFuvY3C5TZIY9Pixa3iMraw=;
        b=d4YSoGC722pcKxQ1SRPU7SQFBF4lMk4aSufXM1WownEY4GNInRUt/4QZwqDP/nZyT5
         a9G4q/b7QslJuON8Qxe3LYfM8LLP1UVfKxyjw0xfJF4sbJMsYYzul8ADA3H1WGcMP82X
         mnzQtJgdkgEO9XxrL6p64T3oscX0zTZtv13HiAjRQiOKDxFww1NQzCQonQLlA+JKeerh
         3SPDrKF4qWXW6bj7SvffDttTLi226bzYeyU/7Q1SPaO4TZoCr4h0dHvOV9C1bPgVn5oF
         +wWDgmcMbJNX6S2fbMCoVy+EOpe6la9ZDo629t4QhKVfCaR4qdjeRpVzwv++dWbyTOQR
         q0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726775902; x=1727380702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3T6VG4XZ1eVpUOvChP/8TFuvY3C5TZIY9Pixa3iMraw=;
        b=v4Tu7lSmM3wDV1S1da3IUJpIGMP/czHw4TTA054zRKkTSQrMPIKMiivdLC+p99nKA6
         P4jelHTwasD902UlEEvPPwEtCvXHgzeAsOMR3fdH1VHp16kdOA0MQ72FtC2ZAcZUJz7k
         N7n2RVbU65tA6dmFkMK2Tilk5yT04ZPyf9AsIVgaLCyqiy6LdkIDrRwANj7qfvv4YjbB
         ztFfCnEA5sQTWNiNhZEUDBmiq7CLZAwew/ycXMOfSG43Ax1BT4L8AzX6NBaWf/FKb9WW
         27nyeF0Pw2oDdoQY2+m3xK5kleoZDdkp4OnSTOfUheq9qIFuiAlhtMOLuXEeWwrmAg71
         GMAw==
X-Forwarded-Encrypted: i=1; AJvYcCUVJWjvdrAYjpfHxes4catiT3u8OH/P4XLQfGcLHQ67wT7Ta4ft8q0qV9Hd0szxLIUurKRxuvu5LxwTTZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSAxSZZR+bQGitDFXGcY/BeUn8BGGdBmb0pLgIXU33+K3HIfsT
	5Ok9vGyV7yhQypMWn8I9+CFRVNjYpe2il9DEzUTotY0EmEUy1bKfvxDhXDeI/kU=
X-Google-Smtp-Source: AGHT+IGGqyOMIVYAeKYZz4EQw1D3YuqXoDUEoNQl2L/Xv/bG3uOuEYCOKU5H2YjX2daigmABvXadTA==
X-Received: by 2002:a2e:83c4:0:b0:2ec:637a:c212 with SMTP id 38308e7fff4ca-2f7cb348cd7mr4137061fa.39.1726775901683;
        Thu, 19 Sep 2024 12:58:21 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d37fb73sm17030821fa.78.2024.09.19.12.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 12:58:20 -0700 (PDT)
Date: Thu, 19 Sep 2024 22:58:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maya Matuszczyk <maccraft123mc@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: qcom: enable qseecom on Lenovo Yoga Slim 7x
Message-ID: <6qcffqabpvfycrapicd5g7dnjwneqzdodx6hkzx3ybd3jxu74k@7kh3crxjrbal>
References: <20240919134421.112643-2-maccraft123mc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919134421.112643-2-maccraft123mc@gmail.com>

On Thu, Sep 19, 2024 at 03:44:21PM GMT, Maya Matuszczyk wrote:
> I'm not sure how to test it beyond checking if efivars work fine, and
> reading and writing them works, persisting after reboot - adding a new
> boot option with efibootmgr works perfectly.
> 
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

