Return-Path: <linux-kernel+bounces-325248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA77C9756DB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1971F22D96
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEEB1AC433;
	Wed, 11 Sep 2024 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ToWkr1H1"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2430C1AC426
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068031; cv=none; b=m/GT9xRU6kH/pm90MdwKeaRguQrJCkHuMWnpxCf0uGQMtcBl1JevoGGmXISUWmmwt7QMpzg/jzZoDtGN3LGVngf/EAUHEFShD4aK+FTNfGvqk0v5fHYosEJv1ofeU8maq52oL3BB9gvYjLgZ8gdZCAAJ2R3b65TB3lOaqHkM9w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068031; c=relaxed/simple;
	bh=h1IZOH7/jMEJ6Q+LRccc6HsCSL0I04Yr9fwpPaCiu0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyze8/mP5Os3K+cD+6ZPs0Ftl1XuREgp6qd5cOHofNgZ4zLj7iiaZkBjQGrcwEju/+eU+Qy7AsRer9P1zdJaXnRirCZCPEwv1O2jYU60F7C8vJbCmwv+BbF7NRS6coEyslkZBxgO6BBzzmMwt94NNKSbwYz7Y33NhQDO5ZsYUFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ToWkr1H1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-718e285544fso3333083b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726068029; x=1726672829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6QsnF80Nnvoo/JnHghxBCTtAMnmOaIQ36MmFNNxPphg=;
        b=ToWkr1H1K3GrmyZs65aLcdN0Z53cxRkPNTqRGeHi46bH2dPPvaGFjkhiKK4C2WgpXr
         BSm01UxUrPi5JlMPfYNhinWspvvAGtFe4EyknvPLArSQAUG32UcSG5r9TiW16DXoxMrG
         pCQLF2dZbx1YoGegnQLZkYZI/2bTQ5Y7PnzXOpGyhQBY/a/Dku+wIvXzXHYv+yBxAvLk
         pM+Ba2LPx+9He6aXde51hwpQn5yRO+KaufjZoBLtZULaHt+VJSITSYLZll46UgTBxRsd
         rnHojbHjkW7JVuhRcXtiwChhVq0WGl2Ck0FhJIZmB5U3JcyLuEXNDg3MycuOs7FMse4S
         kb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726068029; x=1726672829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QsnF80Nnvoo/JnHghxBCTtAMnmOaIQ36MmFNNxPphg=;
        b=kRiYcQpuw4mB++re4jwnW8lZaXESAmkkOFyqcTKHm+CiBlnaCDeS7lGLipEhrzCUnP
         uo4h0ICf4RbHhnjzNNiR/MlPrea/8aehE8DiAVy5YnSPplN30vYTRRZ9kjWaxxPVgA3N
         fgosMtwdD/Bkwj4wPuN847LuqjJZVTSOcMZBv8Y5Qu7ALwAJMB72hkh9Pk8F9iMcMdWK
         S5xi8FQeXBOAiv6OkDen/zQ0q0d7NEk8BbAIrSJERct5+I8RJNOHu/Lq8uRCZXdMtVxt
         hbP2xDML1idNa4iUrg2DqSnBEWBnI3WIN4jk/Uo1+0VggQnkNyHVFbE48J/TMaC3vRYK
         P+gw==
X-Forwarded-Encrypted: i=1; AJvYcCXz4NEKeiKSEtUUAudkocoow9yufciupE/u+pdYGT8wJz14ANPybudC3dVL9AGy6SeUctelE9BPkVEm4U0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh7iFxOAE32AWlO95CyVRpS0xRUP5dOcd9/6o5OwCKNsc0RldK
	8dskCB72IzZK5f/KiqvqAI0HVRM9L9QzD3Hb5neZCeve5Wd0pJgkZdUVkaN28e0=
X-Google-Smtp-Source: AGHT+IF62OJJay2y+CU+PR4n787g3j2oQeP+yBY3R968kbDmjxolxaxWKCPxr0TAOuJnc1ZT8F6S1Q==
X-Received: by 2002:a05:6a00:92a6:b0:706:b10c:548a with SMTP id d2e1a72fcca58-718d5f06a3emr22601898b3a.22.1726068029283;
        Wed, 11 Sep 2024 08:20:29 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:cc9a:9892:2799:3634])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090ada75sm3099467b3a.162.2024.09.11.08.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 08:20:28 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:20:26 -0600
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
Subject: Re: [PATCH v9 3/7] remoteproc: core: Refactor resource table cleanup
 into rproc_release_fw
Message-ID: <ZuG1OiYO7YA+c81G@p14s>
References: <20240830095147.3538047-1-arnaud.pouliquen@foss.st.com>
 <20240830095147.3538047-4-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830095147.3538047-4-arnaud.pouliquen@foss.st.com>

On Fri, Aug 30, 2024 at 11:51:43AM +0200, Arnaud Pouliquen wrote:
> This patch centralizing the cleanup of the resource table into a new
> helper function rproc_release_fw().
> 

Sure, but you did not explain _why_ the change is needed.

> Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index ace11ea17097..7694817f25d4 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1256,6 +1256,13 @@ static int rproc_alloc_registered_carveouts(struct rproc *rproc)
>  	return 0;
>  }
>  
> +static void rproc_release_fw(struct rproc *rproc)
> +{
> +	/* Free the copy of the resource table */
> +	kfree(rproc->cached_table);
> +	rproc->cached_table = NULL;
> +	rproc->table_ptr = NULL;
> +}
>  
>  /**
>   * rproc_resource_cleanup() - clean up and free all acquired resources
> @@ -1485,9 +1492,7 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  
>  clean_up_resources:
>  	rproc_resource_cleanup(rproc);
> -	kfree(rproc->cached_table);
> -	rproc->cached_table = NULL;
> -	rproc->table_ptr = NULL;
> +	rproc_release_fw(rproc);
>  unprepare_rproc:
>  	/* release HW resources if needed */
>  	rproc_unprepare_device(rproc);
> @@ -2067,10 +2072,7 @@ int rproc_shutdown(struct rproc *rproc)
>  
>  	rproc_disable_iommu(rproc);
>  
> -	/* Free the copy of the resource table */
> -	kfree(rproc->cached_table);
> -	rproc->cached_table = NULL;
> -	rproc->table_ptr = NULL;
> +	rproc_release_fw(rproc);
>  out:
>  	mutex_unlock(&rproc->lock);
>  	return ret;
> @@ -2133,10 +2135,7 @@ int rproc_detach(struct rproc *rproc)
>  
>  	rproc_disable_iommu(rproc);
>  
> -	/* Free the copy of the resource table */
> -	kfree(rproc->cached_table);
> -	rproc->cached_table = NULL;
> -	rproc->table_ptr = NULL;
> +	rproc_release_fw(rproc);
>  out:
>  	mutex_unlock(&rproc->lock);
>  	return ret;
> -- 
> 2.25.1
> 

