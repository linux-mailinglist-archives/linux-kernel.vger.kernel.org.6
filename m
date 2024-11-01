Return-Path: <linux-kernel+bounces-392856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 478C19B98E7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA51A1F224CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3721D1726;
	Fri,  1 Nov 2024 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XO3Dxtp0"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC6E1D1728
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490503; cv=none; b=iLMathAsb9NCMGka1l/bxNDrdG7iH/2U/GBXHebk9OnRB9BRNKybx4hlKnJ/IJGTCZH9ToyMWH6gmb0U4ibqM9cDKoefyELQZOjTdxI08z5h6ko/gKFQygMty8mUWsHS+ls0ZAKcNMwp/k3J9IOgW5hnMDY0qcYcfxWISEyjwjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490503; c=relaxed/simple;
	bh=3UcgYWbawCrKqnDgXfJyWHag37jLry65DZFURo9649w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0c2Su3y5cZUTOK+emouTuBxiyZuPWw2VXZRyg+a3TAoDcA0axQry3yk7iFfMDA59AX505/lJvOciGzj55Q2QO5Gu+54exYrL5kmuT5wYBm+TUe8hVT5LAZZ6JciX6hxS9z9Ot5e+WGbyjyFS9rYxnPY2FwC3E/IaRzemkOpWlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XO3Dxtp0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so18392555e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730490500; x=1731095300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VyOSdZozKOWrrNO+3IjlLg6SrCFccraJpEYre6+ope4=;
        b=XO3Dxtp0QGqxRUGCgKj+2pedfNGc1MT8MEtbfJIt6Fq9UvdF8dqNzAOLTYz4+9s1Mr
         Cil3COyfgoeXANg7lrtaNJDrCWqvEkU5xbRAhgYJBPZqK1m2J1qFGnPnL567+s2Uzq8v
         F5numYIZXXZsQrjTZ+5Q1rmUvTTMZvVPK3UcZuVqYPMS+RkV6dj50OC5xQlOV3ETgmjE
         H/Y6dFXBfc94JhZqU97OXqL/EPxkrrnPH+j7DLhgM0L+JSVaCg7w9SjgbQbGXl8xwbf2
         jRAt+WQ2GnjStj+47KO/eBMOnrLScEUTpBhZF9CzBbmWGyxyQ5wLm6JpEer6EoCX2SaV
         7OkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730490500; x=1731095300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyOSdZozKOWrrNO+3IjlLg6SrCFccraJpEYre6+ope4=;
        b=GhQkc5KvJH8MV4wOK/RodfGCwrT3VQesjn+F3MfB3DwZY6uA6XaaBIFHXqrIajAPc0
         DFDFSbt3FvwCXTgJZ9PGj5ovrnV+bUC9Tny110CoTUnn8mx5Du9vUanPY7BArkN3J8T3
         JMZ71xWXFE6UHnJnAKXKm3zHDKNLGdmSb6b8H85R23IVJ36vbvyDspH05ORyr+J82dUF
         Iyl9lJsNc3GmOcHtwZBrwBzZlE9k+/D5/tw7uN5I8Fwr9Q0BYDfIjva78rzSsnl2z8+U
         yRDwTn7C8jbWpJzDVOIusMIrwYda91H9oniRFP4zf3YfarP8HvWlzaoXEFFrw1XKGldC
         NzeA==
X-Forwarded-Encrypted: i=1; AJvYcCWZubJSLbKnbsdkM59ZsW9xI0t7I0OqyidOxJoT/HlhMd+o2mLeik5uOhmdzDXIUFNxUPbL+nMrZtnlcOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY148NhiaXNR1xQAyUY+mJNcBOioRWvbCw9bvy2mTiHvnNw2By
	7UnxyqNfhTjRuzvSmAEtaCtEoXJbIszGBO+1NpB2jjXnj/a6PsvPDLtiyxYxnTc=
X-Google-Smtp-Source: AGHT+IEgrI9/MtejE5D2yrq6YK8eiMxUyT5D3Anib7RxObpFW22X85P9QXkSDkMps5fnbwBE2ASoBA==
X-Received: by 2002:a5d:49c2:0:b0:37d:39c1:4d3 with SMTP id ffacd0b85a97d-380610f2ea6mr17995150f8f.6.1730490500309;
        Fri, 01 Nov 2024 12:48:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d429dsm6074722f8f.31.2024.11.01.12.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 12:48:19 -0700 (PDT)
Date: Fri, 1 Nov 2024 22:48:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	arnd@arndb.de
Subject: Re: [PATCH 3/9] Update messaging and usb_device refs in ni_usb
Message-ID: <ab4f8854-8d97-4c9c-bff1-86a73b4f7cab@stanley.mountain>
References: <20241101174705.12682-1-dpenkler@gmail.com>
 <20241101174705.12682-4-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101174705.12682-4-dpenkler@gmail.com>

On Fri, Nov 01, 2024 at 06:46:59PM +0100, Dave Penkler wrote:
>       Replace GPIB_DPRINTK with dev_dbg
>       Replace pr_xxx with dev_xxx wherever possible
>       Use previously initialized usb_device pointer
>       for usb_get_dev() and usb_put_dev().
> 
> Signed-off-by: Dave Penkler <dpenkler@gmail.com>
> ---
>  drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 377 ++++++++++++----------
>  1 file changed, 205 insertions(+), 172 deletions(-)
> 
> diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
> index 9ff56b063681..50ec934fe8be 100644
> --- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
> +++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
> @@ -132,13 +132,14 @@ static int ni_usb_nonblocking_send_bulk_msg(struct ni_usb_priv *ni_priv, void *d
>  	if (timeout_msecs)
>  		mod_timer(&ni_priv->bulk_timer, jiffies + msecs_to_jiffies(timeout_msecs));
>  
> -	//pr_err("%s: submitting urb\n", __func__);
> +	//dev_err(&usb_dev->dev, "%s: submitting urb\n", __func__);

Just delete commented out code.

regards,
dan carpenter


