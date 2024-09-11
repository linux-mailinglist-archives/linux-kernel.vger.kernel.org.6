Return-Path: <linux-kernel+bounces-325314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768619757B9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89E11C2090F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F0E1AC881;
	Wed, 11 Sep 2024 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eT5ICDWd"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29A01AC427
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070198; cv=none; b=cQVfQiBG7M/w4vrGvJeNUGAVdw8jyjXYnddiPfv4yT//7iQQd7YqUjZB7dOJHXNJ7J+ffItgpal6L921qOfomtQJFeGfVORZ5tJx+ODtLOPyWcA5K2DmlG02/pHYj4dSmoebkrj23u+bm6Kq/xGusbUmFhibzcYK9aEy36rrMnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070198; c=relaxed/simple;
	bh=36KlrzfsV2g215KHFOOz45t4T5Bn2rd6NGxHlDdOsuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzLLixy5HR4d5FGgjSejOCQdqop2pAHy5jP21W2vxUCF5GekUBh3NwnTHJbdF1GUhnnW5uzKjnTJzhe6wSx3JNJhG2EULrFEgh6jKBtzHHDGImXw9xaihDQn0hz1rnxzqRB/JXVr1u10Z3RYkYDPzs6xe8p+y7W9i0Dwc84zCQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eT5ICDWd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20551eeba95so108895ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726070196; x=1726674996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qyEYdmmCtjL2ZglMclaQOmpZZ8FR1iFPca3qPYCy9w4=;
        b=eT5ICDWdox3B3cWNDHzc0VhPMARpfWmOpUbkivGYSls4AJ2ep8Z8GAyFdRZVQRXua1
         PUQ1YQtEAQ1McvpSvRXcBC+qWkiysPnMZt5IVUTfdxpA5PMOD7pQQ2xymudjFk9gnqAz
         MVET/XUgZ/HDnawZXGFzwgkFw+MCdeYa9i9CvPk77tuZ9JYEAeRmcaesM4uJpacQk7fb
         wIIMC+h6RHO4nHTffgGR0mIF6PQj0HTDEM8eAMFHuiXyEMFKMVEbjVmgTKYliR7Ek8jh
         hakzrcAeF9HYQKF08+EqfKH2OCFvThhUDd8pCeESZH4Qbd0hOWrmw0tob+NruXOJJArv
         Z0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726070196; x=1726674996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyEYdmmCtjL2ZglMclaQOmpZZ8FR1iFPca3qPYCy9w4=;
        b=TjjTvbjnEvkXxk/HlR1iU5IwTHtv6wE9yJdAY6/hOFyElwQ5gyRMBQYTlj1n/6PnsL
         8Vhd22yk6ED6B0M1yxbI25hdm3CxaNglu4JE2zAm/oMjYFDUCrlQMkqnN1E2jjjHPp8d
         eAxryXkS9LNo0etaYlIhEjF2c+TyAHT9WxXh435WvJcN3VfDAUgTZdSj+E3F5HDAqSVj
         xuD6ESKkti81Fb8+cHbe9W1qbZwHuWghC1GpynIpvDDFRXn+TVtjCFqHvUorn34WRsnR
         Ahz5neBCiVK+9LI+Wz77lRmOxUXI5jYhLGZi35uQC5aRFHlG8r6HWXB+kZYGuR2gy/iR
         uZQw==
X-Forwarded-Encrypted: i=1; AJvYcCXI8fnc+8xNhLDpc2nDSi73WeJJkdd5YrK903N9POQyiAr1Aa+Hx/0M+iyk6OcAk25zNhrDiJw4iqc/RTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL2n5NLI/XoqFsUAYzXQEH9FaA/EzIQEt1Quqh8OKXJufkW6Dc
	xFVaRdtUdTmCr5gLJz6aVqeLHrBkIej9pLT8G3+V6g9CeN/aQPu0rCM+jsx3G4o=
X-Google-Smtp-Source: AGHT+IGa4wRKlJxrETW0qCu5ZTTQ3xb8Do/wPK2e8jasfbzAeq1gxfAE2Mk/Fx9F2dJ/V92m0elHfA==
X-Received: by 2002:a17:902:d4cc:b0:207:3a46:345 with SMTP id d9443c01a7336-2074c761a4dmr58970435ad.51.1726070196194;
        Wed, 11 Sep 2024 08:56:36 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:cc9a:9892:2799:3634])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe9cb9sm1159555ad.193.2024.09.11.08.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 08:56:35 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:56:32 -0600
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
Message-ID: <ZuG9sOI+xX93NCQc@p14s>
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
> +

If I understand correctly, the first condition is there because the
attach/detach scenario does not yet support management by the TEE.  I would
simply move the check to tee_rproc_release_fw() with a comment to that effect.

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

I would have kept the old label.

> +	if (rproc->tee_interface)
> +		tee_rproc_release_fw(rproc);
>  	rproc->table_ptr = rproc->cached_table;
>  
>  	return ret;
> -- 
> 2.25.1
> 

