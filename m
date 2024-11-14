Return-Path: <linux-kernel+bounces-409907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA119C932A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ECA4B227CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0DF1AB52D;
	Thu, 14 Nov 2024 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DoxpDapI"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F371A9B4F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615784; cv=none; b=aMHXhBZpV0stxLg6wmDyYYcc1BVmE/cPH+mkh8ZdKdSCXNpIqIw5E+TIzpDie9zQYhWHxc48F1GCkfX9qmSPa3GNd8/7ocRnYQx20nFx9LhT4k54hdkrze5F8aFLcRLvqwul/y2crXia0NyAn151WJtJl8cORPOa1ccU+xl4pfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615784; c=relaxed/simple;
	bh=KBsWFgY9fSpfMfPlCHiqICzY59uOl70IGpw/FtILLq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETRZRWxaPALVlqPzGh+mYKXOKsobdD7yoH4vLXD4RsF6Ql8Z8xowP62apmxbczhloWG/gcHiqrsbu2eYkQPOOxZ2f14LJerKDF3lMa39E16qwa24qPI6rghL6hy6aa98sY4+zilrNqc7xrdZwGzK+m7u8XvA/0qCQQEioOm2kS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DoxpDapI; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ee7e87f6e4so803077a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731615781; x=1732220581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3t3j3ES+KMYiY+uHRfv46SZpfLjb2BlkXR6mS0oLpes=;
        b=DoxpDapIR7bo8fFV7YQn4FKLv/cx+Ud2XWiM+OjHQwT/ucSxh5dLnwHMYc7A5RDwc+
         Eog05ZWrKxnhswDy7Xo3zqxng2YRtp5JJ9MbTqxSuM/4v2udla7ErmCLpv2WaAbxnpVb
         Ozgz4DA39BNY4WHGlvQoOxFp5JrLo/ELcm8ZWaeSv4rgF59LDP+YQJiQMu+zgC4HfGt3
         89Vn0kYWNAyn2gMw6yFye3yX8xxdBP0zykjkuONWKfLEEpfnvxwX+2Z4HFP6Jy+KMpzM
         vfuoCQ9AHhtbOxjq5/4H1DcW8ps1y/T6ZxI/ftZa8FjPpFq/cAQ+PXXBHHohDYX8FtZW
         3vJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731615781; x=1732220581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3t3j3ES+KMYiY+uHRfv46SZpfLjb2BlkXR6mS0oLpes=;
        b=ukcOpJ7bjhdcvhVMZXgtLHT0R3rzx52MmRokNmxwX6n7toKt4NGLKdEyOWQQSfimGA
         U0YVqx7MMq//REvwcjm/02Hy8frCLjBboZIHGAcuxo1wYR82Ue6KEXeqBGHkUTIcPqSM
         3f2vt5B4rBomMNCmHvUrmL3N3xsPdVrP0snZxwT17eSqew/tQ51//QWkYzyq9eEnMNsC
         Khpy/V/fHxV8N/4GsBwABvReUuAsWqSOF17fCQDy2Tnm9A6dpdq/qoi9lEYCvq9FoLPH
         r6G/8Hz23mUQELi+1n45Da92GXvJsVQ85sdg7fM4lrDR2y/3SfY23YUCJFmEkm8om66W
         agWw==
X-Forwarded-Encrypted: i=1; AJvYcCWQkF5O0S0VmUJNXPwTpgUVs2Ur4iEDZHgfCqhNPDorNm9+0Be/6q8Dsdc0lMtxexp5NrwKMyH1oMe1whM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCVhFpWt891OzXmGoGNPAxtqrjV9zrFdKEH41D60kHEYsnK0aN
	LLeYAPXymLYzoeA0x7diSu1HmSb6iOCzk0dDE1R7g+YDntNIwbXwVm8ZX628doY=
X-Google-Smtp-Source: AGHT+IEWrtvYg0ycOEPvYgPz1j1Z/Gs2uiPWVaIPMlwwfbfV9OSuuEkejTWFwmCY24eOW9B2M742Dg==
X-Received: by 2002:a05:6a20:7346:b0:1db:e9f6:8dd7 with SMTP id adf61e73a8af0-1dc90afcb5fmr65998637.1.1731615781071;
        Thu, 14 Nov 2024 12:23:01 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:d240:c440:31fa:1568])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72477120aa5sm39076b3a.79.2024.11.14.12.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 12:23:00 -0800 (PST)
Date: Thu, 14 Nov 2024 13:22:57 -0700
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
Subject: Re: [PATCH v13 4/7] remoteproc: Introduce release_fw optional
 operation
Message-ID: <ZzZcITZq/U9SOqnP@p14s>
References: <20241104133515.256497-1-arnaud.pouliquen@foss.st.com>
 <20241104133515.256497-5-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104133515.256497-5-arnaud.pouliquen@foss.st.com>

On Mon, Nov 04, 2024 at 02:35:12PM +0100, Arnaud Pouliquen wrote:
> This patch updates the rproc_ops struct to include an optional
> release_fw function.
> 
> The release_fw ops is responsible for releasing the remote processor
> firmware image. The ops is called in the following cases:
> 
>  - An error occurs in rproc_start() between the loading of the segments and
>       the start of the remote processor.
>  - after stopping the remote processor.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> Updates from version V11:
> - fix typo in @release_fw comment
> ---
>  drivers/remoteproc/remoteproc_core.c | 5 +++++
>  include/linux/remoteproc.h           | 3 +++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 7694817f25d4..46863e1ca307 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1258,6 +1258,9 @@ static int rproc_alloc_registered_carveouts(struct rproc *rproc)
>  
>  static void rproc_release_fw(struct rproc *rproc)
>  {
> +	if (rproc->ops->release_fw)
> +		rproc->ops->release_fw(rproc);
> +
>  	/* Free the copy of the resource table */
>  	kfree(rproc->cached_table);
>  	rproc->cached_table = NULL;
> @@ -1377,6 +1380,8 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  unprepare_subdevices:
>  	rproc_unprepare_subdevices(rproc);
>  reset_table_ptr:
> +	if (rproc->ops->release_fw)
> +		rproc->ops->release_fw(rproc);

I always thought that looked hackish and brittle.  I am trying to find a better
solution.

Mathieu

>  	rproc->table_ptr = rproc->cached_table;
>  
>  	return ret;
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 2e0ddcb2d792..08e0187a84d9 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -381,6 +381,8 @@ enum rsc_handling_status {
>   * @panic:	optional callback to react to system panic, core will delay
>   *		panic at least the returned number of milliseconds
>   * @coredump:	  collect firmware dump after the subsystem is shutdown
> + * @release_fw:	optional function to release the firmware image from ROM memories.
> + *		This function is called after stopping the remote processor or in case of an error
>   */
>  struct rproc_ops {
>  	int (*prepare)(struct rproc *rproc);
> @@ -403,6 +405,7 @@ struct rproc_ops {
>  	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
>  	unsigned long (*panic)(struct rproc *rproc);
>  	void (*coredump)(struct rproc *rproc);
> +	void (*release_fw)(struct rproc *rproc);
>  };
>  
>  /**
> -- 
> 2.25.1
> 

