Return-Path: <linux-kernel+bounces-269250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7BD942FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CC91C214EE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1771B14EC;
	Wed, 31 Jul 2024 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PaX3JNIz"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9D51B1422
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431447; cv=none; b=pfu/a/eGMbhaPTX9Ku6Uro9YhXW6XgsPoOqFZcP3jrzy7Xvn39NE+ikOcksT2G6yQvU9gVb2BFyl5GgkzlC9Kkau5egsGOzTT37gt9a2zKCdUfsFGbMgJVQc1PPaCQMhrGTC9zeVv00SWdZvKiA5+eOnan+i02MKGRt3ZoJuyWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431447; c=relaxed/simple;
	bh=dX9kVn4xUeFUcfWVpo/tCIEzYvdt9I8uq2wPXw5+h4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yc96iSFrJ3Q52bPVXZuSOzjUVUmBkE+Tdm5Bdfo7pTWuHf0iERe3g/7b2MWLZTq/6J7cNiTtYi1lX6/FI59Bn7B7PIigyFo3a2ekGLB9CGORTYhpNX97ZC3nCEqKfrKIjV0x9tVNYoctP4tRFgvnKyj7DRcRrKnHmfQjPeDp4rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PaX3JNIz; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eecd2c6432so87684851fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722431443; x=1723036243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BtHopVaA5DnFXJsXndmzbhLYPQA3VMI9Krw2dYXiGpg=;
        b=PaX3JNIzFYbsCPDfbtmZfIW7qx9/DubdYdvDdxTxqwxogNPETLetmlgRF9pzbfd6p9
         mITEV62n3OGwGaO0xCyRQBjYTT7EaKaHUK/j+G9WIcKgdHEs07L9BSnVhV1YKOH8X+MX
         FlmCOHZ3AwVBNGoSBqB5+DhpwDnYYbr+vFPtmNUnT25mL8qUwtRAzfvLfrE6VqzU9aiH
         g5+gP5Piv1V7BcafR7OEbjP8gruO3n4KJjgpUeDLCd5fxgfleiJ+aQnSIeNQDSYGfYDi
         l9h52r20BwNGKN51j+cOASuathL35kiLaF+eP6oHtP0+8IRhMqbZbpaUCaQTVX1LUdBb
         RzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722431443; x=1723036243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtHopVaA5DnFXJsXndmzbhLYPQA3VMI9Krw2dYXiGpg=;
        b=YPlPcKCQeyukYTvY9T3NRIJoUWxavlUY75sJz7Pok0HfXnryVFjodh23QnT+3vZGVB
         CbZkiCUxAvReXUceZg7QSrGJJiiEZIeqCApdPFndUeqpg3v1mIzGWU143dtPrqK9yycY
         bh3n67MDjSkp+unGSSpLPI5Yt+CV2Icv6Kp2XQwvNq3wL83QNWTIW/QiujompoInGm6P
         iNpahAlMq0s12T5CFvYx4YeLx+uImpDOo4lJOWTXbpf1M84/Blq4J/HILR6HgG+cxAog
         zFatmjehgMDjgu2AAnobC/gT3GGuiyKnJs2oVICvOrD+PkNTE1gf4nfWgqqV45MjyZwv
         J5bw==
X-Forwarded-Encrypted: i=1; AJvYcCUHMubRue8ChTDUTb0zWGtfEldE9x/mCU4wjIkkdf2OF37MUUV8gDy4ZqXfLBllNcRkK2k7zEEye0dU2x+a4WMM27fnaMEFBRCQsz5P
X-Gm-Message-State: AOJu0Yx28Hj+j5a9LRy7ua3FWtUNcwY0Goyh+2QhKD+SBBO4Vvb5Vs2g
	pzTC2aHy6l6tV3XynggNhoyKl3s3l12khUtaJ4rl+a3MsrP/N2ZCeevPJnK3r0I=
X-Google-Smtp-Source: AGHT+IFKydn1H0rLRwTRWvuLChZ8ue/chEQn7wpdnSNhAgn3Eg7AyBP8EzlGjX88wgzpDyvecJjSEw==
X-Received: by 2002:a2e:a30e:0:b0:2ef:18ae:5cbd with SMTP id 38308e7fff4ca-2f12ee289ddmr117984021fa.27.1722431443345;
        Wed, 31 Jul 2024 06:10:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03d075447sm19696621fa.121.2024.07.31.06.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:10:42 -0700 (PDT)
Date: Wed, 31 Jul 2024 16:10:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: misc: eud: switch to fallback compatible for device
 matching
Message-ID: <blagk4fkptszkmuk7qkeiptpi6uzigw4t4t6djlb3uxsu66eoz@vrt5u6ag2arg>
References: <20240731054438.9073-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731054438.9073-1-krzysztof.kozlowski@linaro.org>

On Wed, Jul 31, 2024 at 07:44:38AM GMT, Krzysztof Kozlowski wrote:
> The bindings require two compatibles to be used: qcom,sc7280-eud
> followed by fallback qcom,eud.  The convention is to use fallback
> compatible in OF device ID tables, unless some device-specific quirks
> are needed.
> 
> This will also simplify matching any new devices - they will use
> existing OF device ID entry, instead of adding a new one.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/usb/misc/qcom_eud.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

