Return-Path: <linux-kernel+bounces-401765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F252F9C1EDE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABBA1F20D45
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3191F4710;
	Fri,  8 Nov 2024 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="CrntBuLj"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B201F4282
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074937; cv=none; b=HCHfISpvjzkVZFSdy5TkZDD6V3oCTo7PDwZ2dAaCY94cmGs3wwSutfHJfeXqYkOo1ahpA1jAErF3Lx2rJomAjaKxPWcak3iRw8dmGfBwze4/INX/Egq/r1itw4rQJbFms5OBpKwPFj8+/AkVMI573+pjzaGFKuVftLA+y8Gm3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074937; c=relaxed/simple;
	bh=KExqbf/k1K5jA+XDKyLl0s3iDkO6sjOXt2uAj01ZmCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPOLSYlhjnwJCglCMmEX6mPMO5cS6ARXAnuPJYdCUSn6eyrwxrY2xKBbUiZS/deqiRkZAjgGlH5h3Ne5eysBc+pgzX2EPhXUi4LIwTvg7iz6uhzm59QNWj4Jy+6ZEBXk/mMiQX1wzjS/oPuDIThAY4LfVmADdHrshiWPQnY23G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=CrntBuLj; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbf0e6414aso10956046d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 06:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1731074934; x=1731679734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vEs+Cvdo88hID74B2Tz0bsmB7rf5MJJrk+JfTQxl8PY=;
        b=CrntBuLjlIORsVMXvt3oUwEktST2+jxSTMjGN6R5DGTsVOzyfzOOHm7P0kuJUgadXH
         eSimiL2ruY9/8YTxXKhCX7/IDplYPGG5Hn9ydeRJ8RNoHZN1yOK0MP84yTClkvDrEy6W
         VFYDyAz4+0rPMSXTzX8iAQ01mKDUh/nTqmS2c9a8WbMCNTfNOKa4yK8gxH0OVX6vNxaF
         cbX/1Hkh4eXYw5+uNR2v1HGjWGeLzaRt4ZxSf23uZROjuvoJFhpibFqoMzXFXGclLcQp
         St5GTIozwbuFVo10ZJOZJtNaFemggnLYgmZ/Wx126Nl+Jmxp5MBMNps0bSazib0rZP8d
         5omA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731074934; x=1731679734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEs+Cvdo88hID74B2Tz0bsmB7rf5MJJrk+JfTQxl8PY=;
        b=ULXREVpoMXQox6Yunf7NB679FC10Oo5G9nvrfSVhMb372yDCxsoZlbaeHfMXQbIk7b
         KqPWwFfRsBTJJoraGdgjX1SSUdKcb5pfwMzUUkTiRMG4Tr+Gw236iNLkSvZqZtlkM235
         xU2eICqrvwiQ5C6md09SC2v5pWqFEg2F54+HvbBi1nb86BWZiIv5aW7x1waXM5/g4LqP
         7xSM1KFF6Ms6m+U6Cg+2IvS5fB2miNE9OE1OUCmp7QL7M5n10FiehLcnAv2ToAPs2FKJ
         j7UHsmsA3n5OETd8VY1UYc2jVWldWEM5BZpL1/A0qG5pSMTT9RJ26IwUidUFpmxduF83
         zGWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCvKbhBgBZznXuaxEck4vMVhUrVee4sqYKjvbWYGPn29vkw9aD3dbJrvCogqsTdk0Vv2/ADYex5Zz2PK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz5TzJh2OWNZ6CRpm1l146xuDC0liLvqzxHyqNr7yL8hu/hZnn
	TYV6tiBw3HhisbSJrS9E5GcJoJOW2q98quAZ3LZN6u4K3SAbX64n8qF9rw9azg==
X-Google-Smtp-Source: AGHT+IEzObL6UAU9yJ7jTgc1UgisBaDPStxv3ts2Ea+AI00Pk1QIitQFDzlUiloIeOtyKXC3RnS10A==
X-Received: by 2002:a05:6214:570a:b0:6d3:531d:8aa7 with SMTP id 6a1803df08f44-6d39e19d5bemr37918486d6.25.1731074934122;
        Fri, 08 Nov 2024 06:08:54 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::b282])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961ed26asm19698146d6.38.2024.11.08.06.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 06:08:53 -0800 (PST)
Date: Fri, 8 Nov 2024 09:08:51 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Rex Nie <rex.nie@jaguarmicro.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, angus.chen@jaguarmicro.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: core: remove dead code in do_proc_bulk()
Message-ID: <160ed4e4-0b8b-4424-9b3c-7aa159b8c735@rowland.harvard.edu>
References: <20241108094255.2133-1-rex.nie@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108094255.2133-1-rex.nie@jaguarmicro.com>

On Fri, Nov 08, 2024 at 05:42:55PM +0800, Rex Nie wrote:
> Since len1 is unsigned int, len1 < 0 always false. Remove it keep code
> simple.
> 
> Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> ---
>  drivers/usb/core/devio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index 3beb6a862e80..712e290bab04 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -1295,7 +1295,7 @@ static int do_proc_bulk(struct usb_dev_state *ps,
>  		return ret;
>  
>  	len1 = bulk->len;
> -	if (len1 < 0 || len1 >= (INT_MAX - sizeof(struct urb)))
> +	if (len1 >= (INT_MAX - sizeof(struct urb)))
>  		return -EINVAL;
>  
>  	if (bulk->ep & USB_DIR_IN)
> -- 
> 2.17.1
> 
> 

