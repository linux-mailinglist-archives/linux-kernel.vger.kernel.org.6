Return-Path: <linux-kernel+bounces-264118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D238093DF18
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D57E1F22761
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9530C770EF;
	Sat, 27 Jul 2024 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k0uqt+TI"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2076C7603F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078460; cv=none; b=p8CIvK6rzP/jU6W/Ityl8sLoDszBBh0TZ8UNTpd/Uiej50IBlNAQB9X7pnD27pv4zDmpdl+eu94CTfAHPz0V0KXr1Lfmq6wR8rh/IA3FPj61B0czmCt0RBmJ3mfUeNdQO3MHv9Q8Dp8GAQEMZOOxixnUUcPUJmyIcnvPnZ0dmtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078460; c=relaxed/simple;
	bh=YUwp0RGlQnxwoOMaiTqHkR8lIkWS3xy4A3f0bl+uA+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJkjg3WUvraNAZxaFPADAO9xuIm68wNzSVigrkHAOmYeDJoj/7IiIcRDk9XZTNcBJ46CiGj3HsOphQLG/5nIII25Ev4r4lh83CbyhVlCG1NHj2IAkexruPSC5Pze0bLqUTErmJxnxMuvJDYGt9r70K830/9LH1R5E9VCwN8M1gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k0uqt+TI; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso27928791fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 04:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722078457; x=1722683257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1U3X29423c8z5yD/QrqPkOy052ePtHqm9D+QDlwezUk=;
        b=k0uqt+TI/B8IdXq5e0SfKKPN3DgOx5jdWoTLQ59OyO3ZyualK6IWwKFCY/t3TmAV5I
         yypotwfCXeZYDczC4Ag4fzGYOTze1W6KafyZ7m5aMrIPdiAW8QXgfXQ0mvwZiQG7Ax3t
         /9doJ3oWt5CD2c/LyGjKcHY+Ches0pKQMxOcK5EJHi1gX7glA8yif/8Gh6mCEzrKbtpn
         NcwdlPP4FeLU8nbDGO41aFwDmHKEbhDJ5lS+lGIPFoq1DgUhN/bSl9gKL0NM4fUHXsCV
         kzf/bNbSB8DslzYAkxD6nxIMp7mOrjc+aPZeQ7OA/3aE2C/v/QT+z/lfp8JRYFqcSp10
         tpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722078457; x=1722683257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1U3X29423c8z5yD/QrqPkOy052ePtHqm9D+QDlwezUk=;
        b=CrWu6KM8yH1gf8DAd1pmfxEBDA7xbIrS5M9BbkJFTJCiOvz6CzVvZJAC8WVmmgkNja
         3mSXxAa/49rwCvoslqB4ZEyGTQDaAiArfyLw8anXaNwwm6VrtMgHFttyTowYPvAer76s
         d3PI6fM0tZdcGti+gY6A1mwsl+a5v70T3G4VyjtykDQDsyu8vn73eAK3Eq8bqYhyvhj1
         2t8Ld/ENHVgT4/mUSpzinpAqY9IivOxt4ImtVOoJlPMd4BDmlGbRTSCIXRFLDrlZ52s4
         CxeSplSPdBlptmWJ/3zXgrtF+ZpWVay27rvsNfRROQVm1cFJnX1HhGfCOy00M5ZFXaIp
         uRjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUno5tsL0Sy9kyl0WpBGVdo7U9QlAkKRb3tLYH8C9Ldkru8L8OcW/1GDJaqwcpq/BgtJRCH5YjgVtPi5+Ff9rgQ/ueS4PFz33gk/tc0
X-Gm-Message-State: AOJu0YzHY3bGJol1mWRtMcPjH5hL6rStdCdpp2LThAVUchlSxL/qHoZd
	L1HIhKC7b+dsOf/+WcX5WTMjSA5/cTDJqhNb97iLyxiVNB+O7YvWd+09FBJWQzE=
X-Google-Smtp-Source: AGHT+IFUtNEzYvSVB7hdKMvLpCNk72wB5jl9A4vCWm8luVysahZN6DgP+uhGK+yL4UeqsFYV8c3g+A==
X-Received: by 2002:a05:651c:1714:b0:2ef:2e0e:c888 with SMTP id 38308e7fff4ca-2f12ee6a4a6mr12915331fa.48.1722078457205;
        Sat, 27 Jul 2024 04:07:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03d09574dsm6600101fa.140.2024.07.27.04.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 04:07:36 -0700 (PDT)
Date: Sat, 27 Jul 2024 14:07:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Andersson <andersson@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2] usb: typec: fsa4480: Check if the chip is really there
Message-ID: <wescb5qz3ckdns7bhopehz5vst2mffewyng3wq5zzlu2d37cfd@powc5ybrebpn>
References: <20240726-topic-fs4480_check-v2-1-901ca449db15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726-topic-fs4480_check-v2-1-901ca449db15@kernel.org>

On Fri, Jul 26, 2024 at 01:43:30PM GMT, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Currently, the driver will happily register the switch/mux devices, and
> so long as the i2c master doesn't complain, the user would never know
> there's something wrong.
> 
> Add a device id check (based on [1]) and return -ENODEV if the read
> fails or returns nonsense.
> 
> Checking the value on a Qualcomm SM6115P-based Lenovo Tab P11 tablet,
> the ID mentioned in the datasheet does indeed show up:
>  fsa4480 1-0042: Found FSA4480 v1.1 (Vendor ID = 0)

So wonderful to have 0 Vendor ID (initially assumed that you are showing
it as an example of an error). But yes, the datasheet has 0 there.

> 
> [1] https://www.onsemi.com/pdf/datasheet/fsa4480-d.pdf
> 
> Fixes: 1dc246320c6b ("usb: typec: mux: Add On Semi fsa4480 driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
> ---
> Changes in v2:
> - Prepend the new defines with FSA4480_ to make them more obvious
> - Link to v1: https://lore.kernel.org/r/20240212-topic-fs4480_check-v1-1-d9969e4d6f9a@linaro.org
> ---
>  drivers/usb/typec/mux/fsa4480.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

With the S-o-B tags fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

