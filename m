Return-Path: <linux-kernel+bounces-392872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978D29B9918
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19CB1C20F56
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C561D3627;
	Fri,  1 Nov 2024 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MZp118Ia"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F31D2B11
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730491203; cv=none; b=AMwVedw2ajzAaSNQOE69BNtJBl0Uq3q2K1bq1vkOdmkjPmlUnqqll2+mBmuJLnEDWQB5kB3KSngtVZndx3Co+CQg6LioNGPkc+YXIjDhmkbfL2j/qd9LUtNCm7BI3ZocXjh8XZ38CRsOYabSszB7dxtat2XKf9MF399Erk7CPrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730491203; c=relaxed/simple;
	bh=F6kBmZT7OU0NVOBFv4mfxiqC6/Bi11D8yX02duZcFWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAIAkBEgCC3MtHmCbKTF1/oHAp/TheAm6S578EiazK2J7lD4D8P9CqzMPIytAxHAPm8cMU6Q7XNUZSgEEkU1kOr4yUB84TVX5zpINEa2yG1LE6knyNE9E2FE2ITimRDYugZmArdyTQZPtw/6L4SiJPKRM03fP2XF5VC255UzXdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MZp118Ia; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso18615975e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 13:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730491200; x=1731096000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LtNzEDDdPt17bYZ+ONL9zzS/KcLaUhJn31ZbZyaW9V4=;
        b=MZp118IaqvQYHJA5w3XY5tkc5H14tjrBbk+ouI7jSn+NFptUwDhb1qjR6JfFgTYqL1
         hQM+XefHOE81cyhIsMDPZDZFHdsd0ab5VL4zcUCReDcARuwFYNM0trlywzpJ2ABhFCe4
         /IrRC57Brkdw/ZXoU2Rbigr+wW62M/vHFuoEUTXn9g58N5cwI9ertV6fzXQBIUq+0rFc
         5DGFzv4sS7Lp5mNWRJKdvZGw05xkU30mCsb74BEBGOQrTiQU2vozq1XY9jM6vvlXmICH
         aok2x/hzOL3Luh8tdX7HF0cJSr/v7dfPhDUpsP9mwiwU0IA3O1x22i6S9xNTIrUPIrN8
         dS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730491200; x=1731096000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtNzEDDdPt17bYZ+ONL9zzS/KcLaUhJn31ZbZyaW9V4=;
        b=molJeBEuvnX9qFcTBZytnhYctIGEUUntG5axzPV/sG57fsxU9hdHND7xG3aPt0bbuY
         GxA4GwaG+mh/BigOh8VoMmrv/wrgo9N3m4d3Wi8TzS/duy/qM+c9YJnCZu50yrMdKpkx
         0ty/yz3zjyBwDcSFKtrQC744PMKyd4ZA8ssSGmYPCJvasiRbyTIvZL6P6HhF6nELzVrH
         XFejMxAsS+PxrGnWIofrR8ksisR1PttYU/pW8MsNwDsGRo+vnR9x1j1BhDluM2lqvz/0
         twDJstv8DtloPHbr6wyGFB25oOoFOUu/VkVfAqHqOcQhXRg/DqvYvhr9gjSRnwvOCcSe
         3I6w==
X-Forwarded-Encrypted: i=1; AJvYcCWSFHGG76FPo6c1WDJhkMDU8os6Sga7w4RVbKIEgnGHeMDRqehc7tr5qYwPGOYkRWmPqKQxmwMx3REnOgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoCJDKAM8fQcXFkmDgyJhn9LHcocGGlq8mrYvLAXJxBo2Q4TYH
	3fSlPiAz0pJZjVvrUPiwV9vV8gfFJSSdNlOpF9K1yqhKH8KR/OASaNFU9uGSzzE=
X-Google-Smtp-Source: AGHT+IG5skR8+WQG9WSnEgqMZ8NLGirak1/JcBLF4yc1053I18pyf4+wlYqJDyTAjIE4LAs2grJnow==
X-Received: by 2002:a05:600c:5618:b0:42c:cd88:d0f4 with SMTP id 5b1f17b1804b1-431a01782c6mr198040425e9.22.1730491199963;
        Fri, 01 Nov 2024 12:59:59 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5e8915sm72134045e9.27.2024.11.01.12.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 12:59:59 -0700 (PDT)
Date: Fri, 1 Nov 2024 22:59:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	arnd@arndb.de
Subject: Re: [PATCH 9/9] Correct check for max secondary address
Message-ID: <ee7fd6ca-a5ad-47fe-8526-49ed2f7cc341@stanley.mountain>
References: <20241101174705.12682-1-dpenkler@gmail.com>
 <20241101174705.12682-10-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101174705.12682-10-dpenkler@gmail.com>

On Fri, Nov 01, 2024 at 06:47:05PM +0100, Dave Penkler wrote:
>   GPIB secondary addresses can be between 0 and 31 inclusive
>   unlike primary addresses where address 31 is used for UNT and UNL

What do UNT and UNL stand for?  I don't know what those words mean.

I can tell from looking at the patch that this is a behavior change, but I don't
know from the commit what the change will look like to the user.  Please,
explain that better in the commit message.

> 
> Signed-off-by: Dave Penkler <dpenkler@gmail.com>
> ---
>  drivers/staging/gpib/common/gpib_os.c | 3 +--
>  drivers/staging/gpib/common/iblib.c   | 4 ++--
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/staging/gpib/common/gpib_os.c
> index c0b774a831a6..65ab190ac68e 100644
> --- a/drivers/staging/gpib/common/gpib_os.c
> +++ b/drivers/staging/gpib/common/gpib_os.c
> @@ -525,7 +525,6 @@ int serial_poll_all(gpib_board_t *board, unsigned int usec_timeout)
>   * SPD and UNT are sent at the completion of the poll.
>   */
>  
> -static const int gpib_addr_max = 30;	/* max address for primary/secondary gpib addresses */
>  

You'd want to delete the blank line as well otherwise you're left with two
blank lines in a row.

>  int dvrsp(gpib_board_t *board, unsigned int pad, int sad,
>  	  unsigned int usec_timeout, uint8_t *result)
> @@ -538,7 +537,7 @@ int dvrsp(gpib_board_t *board, unsigned int pad, int sad,
>  		return -1;
>  	}
>  
> -	if (pad > gpib_addr_max || sad > gpib_addr_max) {
> +	if (pad > 30 || sad > 31) {

These should be a define instead of a magic number.

regards,
dan carpenter


