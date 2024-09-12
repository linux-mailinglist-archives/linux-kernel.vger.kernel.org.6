Return-Path: <linux-kernel+bounces-326853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A61F976DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2D01C23D38
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E50B1BB68F;
	Thu, 12 Sep 2024 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b2JPV9lE"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7590F1B985C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154777; cv=none; b=kEDWnEV0GJgBbAgD8heSwr+jVi7cxrAlasrGa9oIXec9f/HwrUPUq5KBR9qJbJN67fgUIewwFRKrYYf8BEwwV1L+RvJVObBpiTAnn4njys6wOYUkPFtjTxObRhKvWESRqUbIxqLYOdrB4LU/jrKb9xAgEZLSYIjBWhYeEZBL0dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154777; c=relaxed/simple;
	bh=v52nmnOZNec06vdDlmZPhbWPQ5IkWzhXc7hhshl0NiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h53DNop5uSS4NISYxdKGs22yaB1auNSGJUkAv5yR+1hsM67vwd7XxY5HWIPvts2kZHzZYWlCnzKn+wXsdyJMFyFub+m5wC0PvDJA8J1yAFU1DI1LdOauowOTJGuFqylhNDrGZxNeAtoK8uEVm3UkjH2cgYpbi1CONpTkJQP7EZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b2JPV9lE; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d8a54f1250so773085a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726154775; x=1726759575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AW/y1gSAhKENjHL3lW9TJj79JKhDjrYNIUo6Ww7RCUs=;
        b=b2JPV9lEr5OC7Da3FPQQqMQVWp0mk0SCIZ5AUnVaCmPxxBtc+A6UpNqWVl6iJ0TVWs
         Ft2cY967DIXgGVaIlDKBgFJBYtt9O+9wpLIGCxm3UfGjxj3YMvysJlcpwdpHhMaWVcFC
         1yLWVY/h0nPPPm1t8Jm4uT2NQRxo68WmfWGcPIiVcz3IQwPE7UykA7bkzuQuKAutyKao
         4Rh3+XVjD3T3L6yhXG4fBg/OaVfDTd2ZlzWFQfx1+lIO31wQ7caH4c6muOf9p3L5b4eJ
         XgOP1ZZZC29kAl+XtSsolEsRgfmlDg7Gs+6dpqz8DDFXkq7eIIEDo5NUE78IRvPWnOeL
         7q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726154775; x=1726759575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AW/y1gSAhKENjHL3lW9TJj79JKhDjrYNIUo6Ww7RCUs=;
        b=PjjOcocw4SEpy/Bivwilhzeb66KgnfGUAunC5Ay0QhkdAreaLNAnXPdR0Yz2ZhU+IM
         hsqTfrLnT45WGv9hlXsB82lgcEY1HLT1bk4FQK/j+3pEQ1Z3TCIwKBVMOJHEqjYfu9v/
         paCf7eKkve3L5g9blcW4dmHtHj7BzA9zJWAZ+b30bsoPFmg4l9Sf6wlBKshtjnnHF1zu
         4Mh0B9YAWZHwVUzImrFUpxtjR58kTuL2hmjxCsOBr//fo2P1gY8p0xxfU+ILEb9wmwPP
         BycaVM3r63uGDVAg6EHFt5MHXi8QdqSoJpVjCJqypcdXvWmCXvQDtbJKrvap4T47bvey
         LZaA==
X-Forwarded-Encrypted: i=1; AJvYcCXVTO53bZ6LKnCUZbcm/CKYmXwn8w8PNvg19Z8y6z/Ee4HM8boUPE5L4W2tyVT+ytLKbSgjyECltbtCJ5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt/6pL9wdq/E0ANo5lUFCHaBDvfBZ8/y/yJSCCxVT0W650IPnO
	4fa2oqhVkMHR98KxlbcHVubtTVb5YzM/eX666MO8OT7249+OqfuGxc5nRB+rTa0=
X-Google-Smtp-Source: AGHT+IEnUV2gdc2JrTZ0PDN+tPvw1sNecok9fGkCMZLj9cBqFlHeQWX0ELyRbR9mPIeM7B+XWHHF5Q==
X-Received: by 2002:a17:90a:f00b:b0:2d8:7a3b:730d with SMTP id 98e67ed59e1d1-2db9ffee5e9mr3070246a91.21.1726154774608;
        Thu, 12 Sep 2024 08:26:14 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:a82e:e104:d822:3d3c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc03d0ecsm12710893a91.23.2024.09.12.08.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:26:13 -0700 (PDT)
Date: Thu, 12 Sep 2024 09:26:10 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 4/7] remoteproc: core: Add TEE interface support for
 firmware release
Message-ID: <ZuMIEp4cVrp1hWa7@p14s>
References: <20240830095147.3538047-1-arnaud.pouliquen@foss.st.com>
 <20240830095147.3538047-5-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830095147.3538047-5-arnaud.pouliquen@foss.st.com>

On Fri, Aug 30, 2024 at 11:51:44AM +0200, Arnaud Pouliquen wrote:
> Add support for releasing remote processor firmware through
> the Trusted Execution Environment (TEE) interface.
> 
> The tee_rproc_release_fw() function is called in the following cases:
> 
> - An error occurs in rproc_start() between the loading of the segments and
>   the start of the remote processor.
> - When rproc_release_fw is called on error or after stopping the remote
>   processor.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 7694817f25d4..32052dedc149 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -29,6 +29,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/rculist.h>
>  #include <linux/remoteproc.h>
> +#include <linux/remoteproc_tee.h>
>  #include <linux/iommu.h>
>  #include <linux/idr.h>
>  #include <linux/elf.h>
> @@ -1258,6 +1259,9 @@ static int rproc_alloc_registered_carveouts(struct rproc *rproc)
>  
>  static void rproc_release_fw(struct rproc *rproc)
>  {
> +	if (rproc->state == RPROC_OFFLINE && rproc->tee_interface)
> +		tee_rproc_release_fw(rproc);

Function tee_rproc_release_fw() returns a value that is ignored.  I don't know
how it passes the Sparse checker but I already see patches coming in my Inbox to
deal with that.  In this case there is nothing else to do if there is an error
releasing the firware.  As such I would put a (void) in front and add a comment
about the return value being ignore on purpose.

> +
>  	/* Free the copy of the resource table */
>  	kfree(rproc->cached_table);
>  	rproc->cached_table = NULL;
> @@ -1348,7 +1352,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  	if (ret) {
>  		dev_err(dev, "failed to prepare subdevices for %s: %d\n",
>  			rproc->name, ret);
> -		goto reset_table_ptr;
> +		goto release_fw;
>  	}
>  
>  	/* power up the remote processor */
> @@ -1376,7 +1380,9 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  	rproc->ops->stop(rproc);
>  unprepare_subdevices:
>  	rproc_unprepare_subdevices(rproc);
> -reset_table_ptr:
> +release_fw:
> +	if (rproc->tee_interface)
> +		tee_rproc_release_fw(rproc);

Same here.

>  	rproc->table_ptr = rproc->cached_table;
>  
>  	return ret;
> -- 
> 2.25.1
> 

