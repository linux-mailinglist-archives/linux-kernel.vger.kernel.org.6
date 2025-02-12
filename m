Return-Path: <linux-kernel+bounces-510620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193F9A31FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB003A9811
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E231FF1BD;
	Wed, 12 Feb 2025 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWqQJu8/"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82D91F8BCA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739343927; cv=none; b=Ubpii8bN/eL3gHq6jSU42m6Ti5eEyi5B60WkkW2944+glCOB0G9tRlQlNq9qy7tiaVh7UIdIja90xc1jpiaySfGjbSAcFDd6OR+KrPfKQLwz4FzBRMiV79U3H0X+AEsz7ipiqAwlXGomEgBfgd5GIij/9IyxVn3PtONORCe9rJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739343927; c=relaxed/simple;
	bh=zXcsr3pYSv/96sSEGUCA4EAQ0xqtIRVkV7ZrcBxxVWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0QQtH2P1cKhfSLnBNI0cpSWCLw5++FxEDIhpnwrDr2ruUUzXlKFpG158YRJG80CIJ+Owu8VN3bYarAxweH/3gjXRDbBqsTIRK4e/rn9ib095VLXLQ2pwLxh937McEYevMtk5Dg+XuYFgekVfN1oU0NSRZ1VQatE2jg4J4dz/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lWqQJu8/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de5e3729ecso7918791a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 23:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739343924; x=1739948724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=euETd8cRVjpfUqZLd/hQWqqaZoYqUqUdjkzivEPa4lo=;
        b=lWqQJu8/85KpusyJbq8egp/daKG/AjZjEeGwOMlnF+AT6kdSJ9SEUfWc/ddnd08G7O
         xzDm+gYrwEbIcVVuvwfUEnrarU8mBhclQ+eML7/uOwa9bSx2JMha5IGCabsAXRsXDvNm
         JthCxSDhM0P9To4zbzZL73/nXVp/XXsZUnKIm3ZNPG8LPEzaWI+E+9PpD3QDl7HdY89q
         wTp/uhhTIcvRuG2lCvX7UiybzdRSzSRelq52AhDLbCZ+XsjvxvzswG4jPmpvDr58eY4O
         hgCDRnMvSFhEQCTEzyg6nCgQ4wu+rdkCpdTUyfvxO6zP22V59uiaPnx7/9nw2EcXFuP9
         kECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739343924; x=1739948724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euETd8cRVjpfUqZLd/hQWqqaZoYqUqUdjkzivEPa4lo=;
        b=sPDY4/ZOopUmcH9+k6vbjt0RTrlScW2AloGAzf4E1fqgIThdij5q7gm0R3hysHIq00
         UcriXy6NCvnsEgJJIAWvcgWScTBnglk9Xvq7D6dB0inrlGSO1BT0m72zNIm/D6ac6CN6
         HF/y8brFH8tFyQy7p7rimpC03wOhczK6jaz3ofSSInCa9fexLo+rFf3m54CATuFcaMQx
         hIiG8ENsUG4jLuWIR/4e86TYMTCeebzszcU17Zy7jEeE062s40pqzWAxRkVs898+E8Gj
         Xc9b5c5+KS4Rg14+cFXnYYKd4sg6VeFyFP/yh2Xg23etV+YYIbSb2rCxxffWy47sl8d5
         /arA==
X-Forwarded-Encrypted: i=1; AJvYcCUWXTjBgOxnSgn5aVsjgfyG85aji9tmuvH3lpjOtrl8K+8o4x9ReK494T9saa+fANpfejFfcaSKXd9aTwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtA9NsJ9JD8eDRPkafWU5ExVy6XdGHSvpbj9is342pbSTGSr1J
	9H9mjsYZimcdVNrrArsvfP9Vr4Fif+FLDLM5B0G5bnz2t1VAu9KYmmuxUUXALXo=
X-Gm-Gg: ASbGncuWCMZC/xSdCVP8h3i1xZPr39ogDuDo9TmYoSrF7dLMpGqewz+gaV138MSeJ0P
	p/KnCz3SuuUsiEYpK5S9emGhu4Oi/wFpqMHaBno1O7FPFPOeRzVm1794thCDsTj4iiwolRYcT0z
	TW9bAJK3s9gulLFNBVziwiKQpx2mRwDKxK4hewB6dY+gwlWVi2zZgP9+s5Ai3or3QVwoLTxuxlk
	J4Wm9oJ6sxq6JsyoGm2aihYT1L8ALkhmuEw1sBBlte293wAWtt7I+uXSd5pshFjgwAf+QyAtCoV
	vLMDh3Ub900OJadFp+ZX
X-Google-Smtp-Source: AGHT+IEm2y8yicAGvHFY6cOVVOaorfYDtm2HfwUzjHmoNrYmYq8SoNb0GQoTipxLHQvOSBL85AXRNw==
X-Received: by 2002:a17:907:2ce1:b0:ab7:be81:892a with SMTP id a640c23a62f3a-ab7f3714cf7mr129434666b.12.1739343924046;
        Tue, 11 Feb 2025 23:05:24 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7832a02fcsm1116402966b.94.2025.02.11.23.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 23:05:23 -0800 (PST)
Date: Wed, 12 Feb 2025 10:05:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: gregkh@linuxfoundation.org, dpenkler@gmail.com,
	~lkcamp/patches@lists.sr.ht, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: gpib: change return type of t1_delay
 function to report errors
Message-ID: <90c2bfc7-9a76-483c-8cb6-4dfd358d586f@stanley.mountain>
References: <20250212024247.176572-1-rodrigo.gobbi.7@gmail.com>
 <20250212024247.176572-2-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212024247.176572-2-rodrigo.gobbi.7@gmail.com>

On Tue, Feb 11, 2025 at 11:35:36PM -0300, Rodrigo Gobbi wrote:
> Propagate t1 delay configuration error to userspace
> 

Better to spell out the problem a bit more.  What is the effect in terms
of what the user experiences and explain why what you are doing is safe.

  The current code returns "unsigned int" and it doesn't handle errors
  correctly.

  The ni_usb_t1_delay() is the only function which returned an error (-1).
  The caller, t1_delay_ioctl() doesn't check for errors and sets
  board->t1_nano_sec to -1 and returns success.  The board->t1_nano_sec
  value is used in ni_usb_setup_t1_delay() and a value of -1 is treated as
  being above 1100ns.  It may or may not have a noticeable effect, but
  it's obviously not right.

  Typical delays are in the 200-2000 range, but definitely not more
  than INT_MAX so we can fix this code by changing the return type to int
  and adding a check for errors.  While we're at it, lets change the error
  code in ni_usb_t1_delay() from -1 and instead propagate the error from
  ni_usb_write_registers().

You should add a Fixes tag.


> diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
> index d0656dc520f5..cb8840f2a461 100644
> --- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
> +++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
> @@ -1591,7 +1591,7 @@ static int ni_usb_setup_t1_delay(struct ni_usb_register *reg, unsigned int nano_
>  	return i;
>  }
>  
> -static unsigned int ni_usb_t1_delay(gpib_board_t *board, unsigned int nano_sec)
> +static int ni_usb_t1_delay(gpib_board_t *board, unsigned int nano_sec)
>  {
>  	int retval;
>  	struct ni_usb_priv *ni_priv = board->private_data;
> @@ -1605,7 +1605,7 @@ static unsigned int ni_usb_t1_delay(gpib_board_t *board, unsigned int nano_sec)
>  	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
>  	if (retval < 0) {
>  		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
> -		return -1;	//FIXME should change return type to int for error reporting
> +		return -EIO;

Better to "return retval;"

>  	}
>  	board->t1_nano_sec = actual_ns;
>  	ni_usb_soft_update_status(board, ibsta, 0);

regards,
dan carpenter

