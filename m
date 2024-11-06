Return-Path: <linux-kernel+bounces-398648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60BE9BF41F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 228C4B25C56
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4912076AA;
	Wed,  6 Nov 2024 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XKVa7f8u"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59952076A4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730913210; cv=none; b=ElYyuQFEGKR0BLCB9rtEs2Wze+2HEI6PsdULeYGMtJx0U+QdS+O61h9YjLNQqzhL9ZwielYsSGIv696yP018O3DyUz8ne9+Ubss3tfT6yqz0JpM2M8CwtC1h8bxNcZCQ1JxlP89HUOh91yE9caHU1BSp7QIKuIQoLC9ZaVXj/KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730913210; c=relaxed/simple;
	bh=HWA6WwXEa8NmER/NxLu39EO5D474iX8PomLkWuNDyaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtdMl4cdXGHdqYiMPSc0MaiugJ6uN2pS/uJW6A/n1Z1uAcr5EFiN/L0lhlfAasjieag2z5Jig4fcpfQjiY9qQz+gm0hhLr1g2P5j68avMoVfap5Y7CkKN7x47hmGM45lEvhEoqO0WxjM9ykwBZoGVk0Fhu/CpcJQnV5VZlI97Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XKVa7f8u; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so261495e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 09:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730913207; x=1731518007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nWxkLmSYZt8bb8qa+yKimaqE18BPc68KrcHf4c2nOUw=;
        b=XKVa7f8ugPljp0OCn6dig89AY7PCAj/q/7zOEOtjXInxGHS/zTR/LqhCpzDUyhAsbt
         4us4+75xABPeICJOr1k7lYHTN480e2f5UMz+MZrS71fK5JwYulDv8f9Y3UWsXqdcM1zB
         0ayCHrnwiUIlfaW+IFRGUoS5B/ewUIYLi98hONsMm7ABIIk0+eH2lii4cqDvH1GPtZxe
         Qigw6ti1hGVEgKZhuXqPvwiw5Al8wDis2lxj5/VVSLnzm1hqeE0X+x2Mt1InI1UlpupJ
         bDqVuTC6D6xXb+MQHxySzZdJQdbDvpPVtbEIEg3xAnUd7avHRBMfMC9JRH6z+vAeTCns
         z5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730913207; x=1731518007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWxkLmSYZt8bb8qa+yKimaqE18BPc68KrcHf4c2nOUw=;
        b=XOXIkNnxDXgA5UBkoHY0zEjxXyaKHnsN81pqVm6H54fj3kJE17NFmdp1Ph6O4sBvWg
         cPhtP6q/QWw3mJi3YE6ODf/3zk98ddHiG7HVXWej9xNQfzTAFGgcLZY1kAkTxqT6lC//
         4D7oT32tBLXpHHK/MYMc68KObnfuRf7V08Ij8ddH5QnELpnsv0DdnILznbZGncQd8oSu
         gvE1ELuhGd1tllQQdji2lZaHmcNpNFLBEeUOwOuo0M9t4a0gV+d66ZKRh8IJOejGUygT
         +q9uJPL42Vsd/XDxAHQn3K8xrXULCUCTOg18uUo3PKhMbMmwAhONS19JoIADLHthyHLp
         ZEeg==
X-Forwarded-Encrypted: i=1; AJvYcCWZO24hSpSUNlMzIjNM51yHMxPyC68JAbdQ1rtGp7k6F7AXuSgQOqA91qZzr9XJj6gIJ8uvYHVf/Q4Tbf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YweY87gT0+HCmpzGlApQSD9Pe+gaeKNcumuswa7PUV6qkvdHMmL
	+0WQIMr8SeEQT7AujzntTv418emWoRmbu2TgWGv7i4Co8zH4n5YlnsNr/guTiZk=
X-Google-Smtp-Source: AGHT+IF94+4n9DkLA8ryG4ma5I1NS45gXV4wdJ033eQXkLHagSLJ09QodataxdxrklvqlMUrudmtOQ==
X-Received: by 2002:a05:600c:458f:b0:431:5ed4:7e7d with SMTP id 5b1f17b1804b1-4327a82f755mr243023525e9.18.1730913207006;
        Wed, 06 Nov 2024 09:13:27 -0800 (PST)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6eb5fesm30793125e9.41.2024.11.06.09.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 09:13:26 -0800 (PST)
Date: Wed, 6 Nov 2024 19:13:25 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogeurs@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH 2/2] usb: typec: ucsi: glink: be more precise on
 orientation-aware ports
Message-ID: <ZyujtW8XvehO/6q4@linaro.org>
References: <20241106-ucsi-glue-fixes-v1-0-d0183d78c522@linaro.org>
 <20241106-ucsi-glue-fixes-v1-2-d0183d78c522@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106-ucsi-glue-fixes-v1-2-d0183d78c522@linaro.org>

On 24-11-06 17:45:55, Dmitry Baryshkov wrote:
> Instead of checking if any of the USB-C ports have orientation GPIO and
> thus is orientation-aware, check for the GPIO for the port being
> registered.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 2e12758000a7d2d62f6e0b273cb29eafa631122c..90948cd6d2972402465a2adaba3e1ed055cf0cfa 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -172,12 +172,12 @@ static int pmic_glink_ucsi_async_control(struct ucsi *__ucsi, u64 command)
>  static void pmic_glink_ucsi_update_connector(struct ucsi_connector *con)
>  {
>  	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(con->ucsi);
> -	int i;
>  
> -	for (i = 0; i < PMIC_GLINK_MAX_PORTS; i++) {
> -		if (ucsi->port_orientation[i])
> -			con->typec_cap.orientation_aware = true;
> -	}
> +	if (con->num > PMIC_GLINK_MAX_PORTS ||
> +	    !ucsi->port_orientation[con->num - 1])
> +		return;
> +
> +	con->typec_cap.orientation_aware = true;
>  }
>  
>  static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
> 
> -- 
> 2.39.5
> 

