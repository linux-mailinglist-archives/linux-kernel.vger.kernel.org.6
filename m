Return-Path: <linux-kernel+bounces-429928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250489E2C8B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DDBBB62384
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0621FBC9E;
	Tue,  3 Dec 2024 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M3HVLEkH"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481331FAC54
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246552; cv=none; b=WNhHRaYJKGIckyFqQLMeI3FZob/k9eSehTO0815Dz1B23j3ebVMsc+FzLdyDUKTpC/NyXaDr/JgsggiZl7eNrdUWBB2mXEUHKspjhlV/qUvov6ZXReBXu4LmPCAxtaPxnGCaadCcAK4k1IUBRMTfgE03L3s45h1ZQkePLvX6yo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246552; c=relaxed/simple;
	bh=ambfS4WoveG8II7nXrhuj9lumnu9MBqclxTd+cEOVds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6AKykKwEIQkODnoGGbX9iE1+2t0z1s+VIvksnlZHYd88m1r1sTin+8sBtwhKDWBtX/6q0fEglb2tRpORjB1Q6fH22YyrPmBgsebQkFT+QuAlppRp/D2kJal4jTdJFl9KBgPZG0djVKLynPFStyF6TYiea3thqk47ZX1+T1w/tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M3HVLEkH; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7253bc4d25eso15334b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 09:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733246549; x=1733851349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PdoHayyIdXsbMDpG0gx0vG65IcXIXANC4Un+ouz1IIg=;
        b=M3HVLEkHKV+nfVAOpHj2H1f8wI0QPS6m6d4z1Ta4PDj08lrt2fJuuRlzH07LUx4w+d
         YcJHLnBOgmNr2cX4i3DbMcOGw/OdR+4RJQ0UIcJnxsBVYX9TynHe6uRjrkC+mXVVXD2R
         kHoANAGApUuXHDm3Ne7V3/aIt8nnnDCB7oyHwT4eVCnQhWR5LPV2ORBk3JsNyUvqGEQ4
         QAjg5XoQEmshTTu7aF/PA1VSS8XXQ0kBAvfnz6GdVT1AP8IlPawJXOuQ7ObmWbdPtPvE
         Hxr95OlRqjVRx23ZsAAXDpRdhrjA3ekHD8/r1XxbEJFc9ZfVSIFF+EjwQPVjOOIQPZuV
         t1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733246549; x=1733851349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdoHayyIdXsbMDpG0gx0vG65IcXIXANC4Un+ouz1IIg=;
        b=GcvTv4jDEKHgZqq13eyYFfe+PMzzJtInIxIp9PYnZYc8Rf3ogPREEf1oLwlJ3Uyx6O
         BftQR7L0OrA50ge8tjnmNbu5vVwAJoG/I6yDlvc9had9x6SnVmvjuz1HTiultjGizH3j
         eiMfGTmlm/iw7P7Hl3CTcBQT2D+GYHajcKVmDMAVPjb/xPtxX1J4VBQcTA9i7CzIf6vD
         1OdeH4ej+EjApZysySx4N2abnS2FGbQMeH6svekbsrMK9MMTn6ENeKRdvn4uZ7jG3RQc
         C3NO8DS37azzNYLbTgVtEtKiVbRyTsz6W7MMNFvCkMI3UiZruZjCKkGMNHk7sjdaX7Z4
         1XUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8btrHpO6ayHy198jCVjCFHzp914S2kDCwCDzvIKbBt6xHjDXx7dH8Pw43X/R5A2H0TnOsep9V/0Dxp0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz2jjg0Mro1w2q0vfDRai868PNJC+CY9weTkeYakf5c37lOaGv
	GPhJpVDbu0fyjtvoHpwya7cwK6OrDGohAGkyUA2roACVbBVhLi4m7yLvnxGJ9iQ=
X-Gm-Gg: ASbGnctfKrHzUUE8SdbqjiqfSicL3oG9/1Zzb5udOEhB76JKEtFOEsraL0xX9S22LCc
	yxIZnhZmq7KK557it/MxhUPB/avRqRZ41P+3WhZJQutORzVt6aE+7nJOiZAsiUiqCH4vL2oLEfO
	3E41wNmdwFx+Y86MM9kIKMLHH9EnWPJy86FN8dT4bxIlPz/gi8ASid+vlGA39Fogo3b6zh8kCDk
	+2iwhkno9TS+JYSToLuxiLKc3hTxgedxZL2E9uLgk/wMK0Fx1ztuA==
X-Google-Smtp-Source: AGHT+IEoymzNNSllAeD2SQwfIIeulsi3g/WibK2dwsw8TsIn6yI7isE2yGRKm7EdzdFv65EXMB9ZFw==
X-Received: by 2002:a05:6a00:cc4:b0:725:4915:c0f with SMTP id d2e1a72fcca58-7257f97b262mr5199733b3a.11.1733246549507;
        Tue, 03 Dec 2024 09:22:29 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:9565:82dc:a655:df70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbf2fsm10690724b3a.112.2024.12.03.09.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 09:22:28 -0800 (PST)
Date: Tue, 3 Dec 2024 10:22:26 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 3/8] remoteproc: Introduce load_fw and release_fw
 optional operation
Message-ID: <Z08+UnATLQQ6kmaD@p14s>
References: <20241128084219.2159197-1-arnaud.pouliquen@foss.st.com>
 <20241128084219.2159197-4-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128084219.2159197-4-arnaud.pouliquen@foss.st.com>

On Thu, Nov 28, 2024 at 09:42:10AM +0100, Arnaud Pouliquen wrote:
> This patch updates the rproc_ops structures to include two new optional
> operations.
> 
> - The load_fw() op is responsible for loading the remote processor
> non-ELF firmware image before starting the boot sequence. This ops will
> be used, for instance, to call OP-TEE to  authenticate an load the firmware
> image before accessing to its resources (a.e the resource table)
> 
> - The release_fw op is responsible for releasing the remote processor
> firmware image. For instance to clean memories.
> The ops is called in the following cases:
>  - An error occurs between the loading of the firmware image and the
>    start of the remote processor.
>  - after stopping the remote processor.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> Update vs version V13:
> - Rework the commit to introduce load_fw() op.
> - remove rproc_release_fw() call from  rproc_start() as called in
>   rproc_boot() and rproc_boot_recovery() in case of error.
> - create rproc_load_fw() and rproc_release_fw() internal functions.
> ---
>  drivers/remoteproc/remoteproc_core.c     | 16 +++++++++++++++-
>  drivers/remoteproc/remoteproc_internal.h | 14 ++++++++++++++
>  include/linux/remoteproc.h               |  6 ++++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index ace11ea17097..8df4b2c59bb6 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1488,6 +1488,7 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  	kfree(rproc->cached_table);
>  	rproc->cached_table = NULL;
>  	rproc->table_ptr = NULL;
> +	rproc_release_fw(rproc);

This is not needed since rproc_release_fw() is called in rproc_boot().

>  unprepare_rproc:
>  	/* release HW resources if needed */
>  	rproc_unprepare_device(rproc);
> @@ -1855,8 +1856,14 @@ static int rproc_boot_recovery(struct rproc *rproc)
>  		return ret;
>  	}
>  
> +	ret = rproc_load_fw(rproc, firmware_p);
> +	if (ret)
> +		return ret;
> +
>  	/* boot the remote processor up again */
>  	ret = rproc_start(rproc, firmware_p);
> +	if (ret)
> +		rproc_release_fw(rproc);
>  
>  	release_firmware(firmware_p);
>  
> @@ -1997,7 +2004,13 @@ int rproc_boot(struct rproc *rproc)
>  			goto downref_rproc;
>  		}
>  
> +		ret = rproc_load_fw(rproc, firmware_p);
> +		if (ret)
> +			goto downref_rproc;

In case of error the firmware is not released.

> +
>  		ret = rproc_fw_boot(rproc, firmware_p);
> +		if (ret)
> +			rproc_release_fw(rproc);
>  
>  		release_firmware(firmware_p);
>  	}
> @@ -2071,6 +2084,7 @@ int rproc_shutdown(struct rproc *rproc)
>  	kfree(rproc->cached_table);
>  	rproc->cached_table = NULL;
>  	rproc->table_ptr = NULL;
> +	rproc_release_fw(rproc);

Please move this after rproc_disable_iommu().


>  out:
>  	mutex_unlock(&rproc->lock);
>  	return ret;
> @@ -2471,7 +2485,7 @@ static int rproc_alloc_ops(struct rproc *rproc, const struct rproc_ops *ops)
>  	if (!rproc->ops->coredump)
>  		rproc->ops->coredump = rproc_coredump;
>  
> -	if (rproc->ops->load)
> +	if (rproc->ops->load || rproc->ops->load_fw)
>  		return 0;
>  
>  	/* Default to ELF loader if no load function is specified */
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 0cd09e67ac14..2104ca449178 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -221,4 +221,18 @@ bool rproc_u64_fit_in_size_t(u64 val)
>  	return (val <= (size_t) -1);
>  }
>  
> +static inline void rproc_release_fw(struct rproc *rproc)
> +{
> +	if (rproc->ops->release_fw)
> +		rproc->ops->release_fw(rproc);
> +}
> +
> +static inline int rproc_load_fw(struct rproc *rproc, const struct firmware *fw)
> +{
> +	if (rproc->ops->load_fw)
> +		return rproc->ops->load_fw(rproc, fw);
> +
> +	return 0;
> +}
> +
>  #endif /* REMOTEPROC_INTERNAL_H */
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 2e0ddcb2d792..ba6fd560f7ba 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -381,6 +381,10 @@ enum rsc_handling_status {
>   * @panic:	optional callback to react to system panic, core will delay
>   *		panic at least the returned number of milliseconds
>   * @coredump:	  collect firmware dump after the subsystem is shutdown
> + * @load_fw:	optional function to load non-ELF firmware image to memory, where the remote

Round this down to 80 characters please.  Here having a longer line doesn't
improve readability.

> + *		processor expects to find it.
> + * @release_fw:	optional function to release the firmware image from memories.
> + *		This function is called after stopping the remote processor or in case of error

Same.

More comments tomorrow or later during the week.

Thanks,
Mathieu

>   */
>  struct rproc_ops {
>  	int (*prepare)(struct rproc *rproc);
> @@ -403,6 +407,8 @@ struct rproc_ops {
>  	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
>  	unsigned long (*panic)(struct rproc *rproc);
>  	void (*coredump)(struct rproc *rproc);
> +	int (*load_fw)(struct rproc *rproc, const struct firmware *fw);
> +	void (*release_fw)(struct rproc *rproc);
>  };
>  
>  /**
> -- 
> 2.25.1
> 

