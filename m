Return-Path: <linux-kernel+bounces-415303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 085AC9D3417
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CDE6B230CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1B8158DD8;
	Wed, 20 Nov 2024 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uT2YawOD"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D962156F20
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 07:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732087611; cv=none; b=AzOc23ICoOpF1O9OI+xByrkmuYgWZ2fO43/3Qn9gZvAhC+wLvZnjwXfDbYIiyAfNJ3bpjlAE7uaNHpXS5jTs2VsR1louB9feIQsMEEXqKyActo/dtwjBYXOyCiBro+Jz0C2Ii8Ly6hSe+P/zj0fWiSPLuUQmZV/rI+zkk/s5CIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732087611; c=relaxed/simple;
	bh=biP9Dvrhc+G0qDx7cODYLf6RQAzvBJDKrAIMDhqkKjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUzsCDUz7C3UWXEsEBIFP3/F4kPalxGczLk4/ZyDKLqp6XAER3hGujRXVOoBmLixcnYLyKJrsR8M+sYjgeq2vXIXft3GsPJ35Ga4DPpH0Y8SbhTRt/AvOlrNw1DHWRuFa2mVZgnhgCv5nq/+wb2LzU0QIE0UiYoaPOyYvUlAbag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uT2YawOD; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3824aef833bso2014410f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 23:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732087608; x=1732692408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JIPtm7b8Gz8+1qEAQ0SdnpTPbujFoftQyLLRu5cTOkc=;
        b=uT2YawODPzeBb2/tEwMbVkSAOe0IrXWXouBCkX2G/KwyRRXThbQ7NofzAqg9ZIgKcm
         ZOV8RTIdc+GE1qrEBtaqOl7vgpK23kYlqZLcerTwjobgH66AFyU3QRt3RbbHfHAlm01R
         HQErGToGIZtjLezYLZJrApSPRD/f1eFO0SOk9fDiSbahRMmAiJqW0hN9TWmV+5sZ9+1C
         cQhLToGutLTjYBK8GVuIBCQ9gbWxFDzwm+ci7+RPB5d42fDete7bQKfBrYkF7bFYhBKX
         eTa1kEJm4G0H65aypmYoehLebDhjqpEs78tXo7EcfF9v5B4hinuKC9rvl3IpaOkoUu5W
         dJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732087608; x=1732692408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIPtm7b8Gz8+1qEAQ0SdnpTPbujFoftQyLLRu5cTOkc=;
        b=ggDCIFkTJ17nnczBxa/1nQjxsGyjz3b4guPwtwdIDQsE7vz9BAe+z6hSZywSeMvogN
         8O5SBhLjdUnCXliY2LbrZ/EU5k1ZXZX4wfUWxJGKsK55rdQU/t8j0POSYdkk5bxEwblv
         nbK5QEeHmoOioBaSRQY+2CrVic6zIezq+tiqlW64jHZdZ74EbPd3k5hLmXOGmA8wLKS7
         BEzTnVxtl40BT+RarUUFE8fbH7hNj+yI4dcvOR52w5oQpeHZSztPew6euve+kgLe4aIh
         LPnwFwXdQOvc4ZdxikBH5To2jVz6wE8h9oXZK8ZEZNupCbgvzsQtu8yoQjhx33kf4JTR
         sm+A==
X-Forwarded-Encrypted: i=1; AJvYcCVkt033oXT3zqFN6Ezw4IL/khd8dAHJHjHhTqQJcp5N+lPQZkK2uWlJlPscGghPyyhpvKTm+W94jlUKx48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDgp+Uuel1TeP/ZazFLHxY0SV/jkfeyzkkjOYCgUtEFeXmNBt6
	SbQlaDNmmmykUXreOO2fpM0EFox9Y6iakwyXN9EED6k9JPNKZoPV/0cV1FOlY3Y=
X-Google-Smtp-Source: AGHT+IE4o51sEx8SfAWBLWFg+1eVtkYzjlvSdvNDJErKDfiQXG6P7uoQ+i1al4onHerpPjh2jAqQUA==
X-Received: by 2002:a05:6000:2a8:b0:382:4a45:15ed with SMTP id ffacd0b85a97d-38254b1625cmr806374f8f.41.1732087607953;
        Tue, 19 Nov 2024 23:26:47 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254911220sm1266335f8f.60.2024.11.19.23.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 23:26:47 -0800 (PST)
Date: Wed, 20 Nov 2024 10:26:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com,
	Satha Rao <skoteshwar@marvell.com>, schalla@marvell.com,
	vattunuru@marvell.com, ndabilpuram@marvell.com, jerinj@marvell.com,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] vdpa/octeon_ep: handle device config change events
Message-ID: <e939fa9f-fedf-4097-8dbe-45d3bc2523d9@stanley.mountain>
References: <20241120070508.789508-1-sthotton@marvell.com>
 <20241120070508.789508-2-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120070508.789508-2-sthotton@marvell.com>

On Wed, Nov 20, 2024 at 12:34:51PM +0530, Shijith Thotton wrote:
> From: Satha Rao <skoteshwar@marvell.com>
> 
> The first interrupt of the device is used to notify the host about
> device configuration changes, such as link status updates. The ISR
> configuration area is updated to indicate a config change event when
> triggered.
> 
> Signed-off-by: Satha Rao <skoteshwar@marvell.com>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> index 482c178a5221..6db951c6cb92 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> @@ -74,6 +74,14 @@ static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
>  		}
>  	}
>  
> +	/* Check for config interrupt. Config uses the first interrupt */
> +	if (unlikely(ring_start == 0 && ioread8(oct_hw->isr))) {
> +		iowrite8(0, oct_hw->isr);
> +
> +		if (likely(oct_hw->config_cb.callback))

Adding unlikely() and likey() hurts readability.  It adds noise.  You should do
it if it makes a difference on a benchmark but that seems unlikely here.

regards,
dan carpenter

> +			oct_hw->config_cb.callback(oct_hw->config_cb.private);
> +	}
> +
>  	return IRQ_HANDLED;
>  }
>  
> -- 
> 2.25.1
> 

