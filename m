Return-Path: <linux-kernel+bounces-196042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908C58D566B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DEA5286FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CC818399A;
	Thu, 30 May 2024 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yONUZ+ot"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB6718398A
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112650; cv=none; b=W81lhh/m6xV7WBZtBNjqzkbRL+pizWtHdtll7fAWgq9aBUc6hY10swNsJgdxMLdgeEgIm41fHvmzI/LNo0NwY/xu8u3OFq8dAQ7i57OkLfuafCtxQ8Z19eWnSnGnFkJFrieXRyZBIzFpXx1nVXx2vo2FROFUtu7wnKQ3ejV/RyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112650; c=relaxed/simple;
	bh=kL/kiUcLaLIfA3cIdKOpIHxHQrBbusNQ/XLds9iAj6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEmULO49rwO0/pVQFkk3ht6aCRZaJmMgUonkA9bSw2ihKMsdRilw+yBT9xqnO7MNTUP0L2DuGt9EjrVawEm50EfyXvW4SMAVWjEOC3cqjPdkGw/aD3QvKAbtDqd3GVYDHDebB8JjB45jFeOlPhU9fTftAyGrQWPCfxZAacYcBLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yONUZ+ot; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52b0d25b54eso2126452e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717112645; x=1717717445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3exUfZ3ejiDWBxEQD8BJS8a+rZdA/iQu6hH8ZcW++8=;
        b=yONUZ+otjX1/bI8CXIb+tvd9zQMAQiWxM1GsLoFIXQV8MXQ3w1b0JD0dpwjEwTzz4B
         UeKxR75o4rlFr8M+vUsGpxM7BXZopc9qmkvkoPQ7Z6wtEkKZGtbKZKrH2/BJk9sn+PM9
         ynQ49vKUJqCXcYvyN8r3JseFsro8xOX5QNdcFR1WEvF2ld27AwogElLz7c/G2bvHN87O
         v4uH3+nq9LUPA2lVmtdIZ0/fKBoZV65TS/9+vnOkBCLsnne064zoKHkhpGHj37xJ9gQw
         BuDJHKh6FdA5CGBQloJMU5US01B5dMvlfX2Y0PeUOG9z96t/d8XpB1gS/ZktzWojXmqo
         WvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717112645; x=1717717445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3exUfZ3ejiDWBxEQD8BJS8a+rZdA/iQu6hH8ZcW++8=;
        b=jAx4CdiZBkBnUXsK7EvAJiDgG+HvekgZZO3l/IUikIF9mk5bvAd/hlCowsyCsgGrtf
         B6DLJI8Hs00BB8i76CI+dgy8OdpAPx9PXpNNg0ljE9xZLbZcaKg+LZCjWvQDm1nJDeut
         /RqdRT1IxDOUiubYTO/a3pJDU+4dTlvwEXgekYWrmmZRLcFH56A+yNgWVKJ1htPiFY+k
         1SYmPFke9Ws8Wrxcsuzo8Q+BptQ0SQx+F5tc8XlqBS6W0qCnQoYLwxZbfiMhe3IY7++z
         bqBQIR71Jyh1rj/3jtFokAEZW1qTGXDr0TcOaR+P18ptZLxli15O3oi9htPQ9fOM2Nyv
         HHlg==
X-Forwarded-Encrypted: i=1; AJvYcCWji+dgCjbp4zJtP3fAEsS1C+ik6dtYQav5iF6SP6i5NS5Wf2QyAf2GuDhuR+riewvm42sgDxke2AP9GaHko8+eXWf73r5gI0C3w+h9
X-Gm-Message-State: AOJu0YxzyJYmi5YFJKkOkvH1imeOSaBMmHo6NiO0KRFx3Ais5Rq90mue
	HYujj4H/7BEwVgxq1ETY3TtDaprwtlvhA6pWvrCzC6PT4SQYUperXNUgT217U8s=
X-Google-Smtp-Source: AGHT+IG9W+/4XzHEznToNXIyenEcuBKjdmBOBsPM2eSHlnEAsz24766aBt5e0ze44TiBVzoJKYO5bw==
X-Received: by 2002:a19:f80a:0:b0:522:8352:ff29 with SMTP id 2adb3069b0e04-52b895a3e63mr88303e87.42.1717112645366;
        Thu, 30 May 2024 16:44:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d34d81sm125982e87.1.2024.05.30.16.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 16:44:04 -0700 (PDT)
Date: Fri, 31 May 2024 02:44:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, stable <stable@kernel.org>
Subject: Re: [PATCH v3 6/9] misc: fastrpc: Fix unsigned PD support
Message-ID: <hrkn5cbhzs3y34o6beyvvnujf7zzjtkqsbigokceycjki5toz6@g2v4l4z2dlxr>
References: <20240530102032.27179-1-quic_ekangupt@quicinc.com>
 <20240530102032.27179-7-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530102032.27179-7-quic_ekangupt@quicinc.com>

On Thu, May 30, 2024 at 03:50:24PM +0530, Ekansh Gupta wrote:
> Unsigned PDs are sandboxed DSP processes used to offload computation
> workloads to the DSP. Unsigned PD have less privileges in terms of
> DSP resource access as compared to Signed PD.
> 
> Unsigned PD requires more initial memory to spawn. Also most of the
> memory request are allocated from user space. Current initial memory
> size is not sufficient and mapping request for user space allocated
> buffer is not supported. This results in failure of unsigned PD offload
> request. Add changes to fix initial memory size and user space allocated
> buffer mapping support.
> 
> Fixes: 7f1f481263c3 ("misc: fastrpc: check before loading process to the DSP")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 221 ++++++++++++++++++++++++++---------------
>  1 file changed, 141 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index ef9bbd8c3dd1..d9d9f889e39e 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -40,7 +40,7 @@
>  #define FASTRPC_INIT_HANDLE	1
>  #define FASTRPC_DSP_UTILITIES_HANDLE	2
>  #define FASTRPC_CTXID_MASK (0xFF0)
> -#define INIT_FILELEN_MAX (2 * 1024 * 1024)
> +#define INIT_FILELEN_MAX (5 * 1024 * 1024)
>  #define INIT_FILE_NAMELEN_MAX (128)
>  #define FASTRPC_DEVICE_NAME	"fastrpc"
>  
> @@ -327,6 +327,7 @@ struct fastrpc_user {
>  	int tgid;
>  	int pd;
>  	bool is_secure_dev;
> +	bool is_unsigned_pd;
>  	char *servloc_name;
>  	/* Lock for lists */
>  	spinlock_t lock;
> @@ -1488,7 +1489,6 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
>  		u32 siglen;
>  	} inbuf;
>  	u32 sc;
> -	bool unsigned_module = false;
>  
>  	args = kcalloc(FASTRPC_CREATE_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
>  	if (!args)
> @@ -1500,9 +1500,10 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
>  	}
>  
>  	if (init.attrs & FASTRPC_MODE_UNSIGNED_MODULE)
> -		unsigned_module = true;
> +		fl->is_unsigned_pd = true;
>  
> -	if (is_session_rejected(fl, unsigned_module)) {
> +

Nit: extra empty line. Please drop it if you are going to send next
iteration.

> +	if (is_session_rejected(fl, fl->is_unsigned_pd)) {
>  		err = -ECONNREFUSED;
>  		goto err;
>  	}
> @@ -1986,6 +1987,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
>  {
>  	struct fastrpc_buf *buf = NULL, *iter, *b;
>  	struct fastrpc_req_munmap req;
> +	struct fastrpc_map *map = NULL, *iterm, *m;
>  	struct device *dev = fl->sctx->dev;
>  	int err = 0;
>  
> @@ -2032,76 +2034,49 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
>  		}
>  		return err;
>  	}
> -	dev_err(dev, "buffer not found addr 0x%09lx, len 0x%08llx\n",
> +	spin_lock(&fl->lock);
> +	list_for_each_entry_safe(iterm, m, &fl->maps, node) {
> +		if (iterm->raddr == req.vaddrout) {
> +			map = iterm;
> +			break;
> +		}
> +	}
> +	spin_unlock(&fl->lock);
> +	if (!map) {
> +		dev_dbg(dev, "buffer not found addr 0x%09llx, len 0x%08llx\n",
>  			req.vaddrout, req.size);
> -	return -EINVAL;
> -}
> +		return -EINVAL;
> +	}
>  
> +	err = fastrpc_req_munmap_dsp(fl, map->raddr, map->size);
> +	if (err)
> +		dev_dbg(dev, "unmmap\tpt fd = %d, 0x%09llx error\n",  map->fd, map->raddr);
> +	else
> +		fastrpc_map_put(map);
>  
> -static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
> +	return err;
> +}
> +
> +static int fastrpc_req_map_dsp(struct fastrpc_user *fl, u64 phys,
> +			u64 size, u32 flag, uintptr_t vaddrin, u64 *raddr)
>  {
>  	struct fastrpc_invoke_args args[3] = { [0 ... 2] = { 0 } };
> -	struct fastrpc_buf *buf = NULL;
>  	struct fastrpc_mmap_req_msg req_msg;
>  	struct fastrpc_mmap_rsp_msg rsp_msg;
>  	struct fastrpc_phy_page pages;
> -	struct fastrpc_req_mmap req;
> -	struct device *dev = fl->sctx->dev;
>  	int err;
>  	u32 sc;
>  
> -	if (copy_from_user(&req, argp, sizeof(req)))
> -		return -EFAULT;
> -
> -	if (req.flags != ADSP_MMAP_ADD_PAGES && req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR) {
> -		dev_err(dev, "flag not supported 0x%x\n", req.flags);
> -
> -		return -EINVAL;
> -	}
> -
> -	if (req.vaddrin) {
> -		dev_err(dev, "adding user allocated pages is not supported\n");
> -		return -EINVAL;
> -	}
> -
> -	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR) {
> -		if (!fl->spd || !fl->spd->ispdup) {
> -			dev_err(dev, "remote heap request supported only for active static PD\n");
> -			return -EINVAL;
> -		}
> -		err = fastrpc_remote_heap_alloc(fl, dev, req.size, &buf);
> -	} else {
> -		err = fastrpc_buf_alloc(fl, dev, req.size, &buf);
> -	}
> -
> -	if (err) {
> -		dev_err(dev, "failed to allocate buffer\n");
> -		return err;
> -	}
> -	buf->flag = req.flags;
> -
> -	/* Add memory to static PD pool, protection through hypervisor */
> -	if ((req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR) && fl->cctx->vmcount) {
> -		u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
> -
> -		err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
> -			&src_perms, fl->cctx->vmperms, fl->cctx->vmcount);
> -		if (err) {
> -			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
> -					buf->phys, buf->size, err);
> -			goto err_invoke;
> -		}
> -	}
>  	req_msg.pgid = fl->tgid;
> -	req_msg.flags = req.flags;
> -	req_msg.vaddr = req.vaddrin;
> +	req_msg.flags = flag;
> +	req_msg.vaddr = vaddrin;
>  	req_msg.num = sizeof(pages);
>  
>  	args[0].ptr = (u64) (uintptr_t) &req_msg;
>  	args[0].length = sizeof(req_msg);
>  
> -	pages.addr = buf->phys;
> -	pages.size = buf->size;
> +	pages.addr = phys;
> +	pages.size = size;
>  
>  	args[1].ptr = (u64) (uintptr_t) &pages;
>  	args[1].length = sizeof(pages);
> @@ -2111,49 +2086,135 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>  
>  	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MMAP, 2, 1);
>  	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
> -				      &args[0]);
> +					  &args[0]);
> +
>  	if (err) {
> -		dev_err(dev, "mmap error (len 0x%08llx)\n", buf->size);
> -		goto err_invoke;
> +		dev_err(fl->sctx->dev, "mmap error (len 0x%08llx)\n", size);
> +		return err;
>  	}
> +	*raddr = rsp_msg.vaddr;
>  
> -	/* update the buffer to be able to deallocate the memory on the DSP */
> -	buf->raddr = (uintptr_t) rsp_msg.vaddr;
> +	return err;
> +}
>  
> -	/* let the client know the address to use */
> -	req.vaddrout = rsp_msg.vaddr;
> +static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
> +{
> +	struct fastrpc_buf *buf = NULL;
> +	struct fastrpc_req_mmap req;
> +	struct fastrpc_map *map = NULL;
> +	struct device *dev = fl->sctx->dev;
> +	u64 raddr = 0;
> +	int err;
>  
> +	if (copy_from_user(&req, argp, sizeof(req)))
> +		return -EFAULT;
>  
> -	spin_lock(&fl->lock);
> -	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR)
> -		list_add_tail(&buf->node, &fl->spd->rmaps);
> -	else
> -		list_add_tail(&buf->node, &fl->mmaps);
> -	spin_unlock(&fl->lock);
> +	if ((req.flags == ADSP_MMAP_ADD_PAGES ||
> +		req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR) && !fl->is_unsigned_pd) {

Please indent to the opening bracket rather than with the tab.

Also, looking at the funciton and at the error path, this almost looks
like two different functions. Could you please split it?

> +		if (req.vaddrin) {
> +			dev_err(dev, "adding user allocated pages is not supported for signed PD\n");
> +			return -EINVAL;
> +		}
> +
> +		if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR) {
> +			if (!fl->spd || !fl->spd->ispdup) {
> +				dev_err(dev, "remote heap request supported only for active static PD\n");
> +				return -EINVAL;
> +			}
> +			err = fastrpc_remote_heap_alloc(fl, dev, req.size, &buf);
> +		} else {
> +			err = fastrpc_buf_alloc(fl, dev, req.size, &buf);
> +		}
> +
> +		if (err) {
> +			dev_err(dev, "failed to allocate buffer\n");
> +			return err;
> +		}
> +		buf->flag = req.flags;
> +
> +		/* Add memory to static PD pool, protection through hypervisor */
> +		if ((req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR) && fl->cctx->vmcount) {
> +			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
> +
> +			err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
> +				&src_perms, fl->cctx->vmperms, fl->cctx->vmcount);
> +			if (err) {
> +				dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
> +						buf->phys, buf->size, err);
> +				goto err_invoke;
> +			}
> +		}
> +
> +		err = fastrpc_req_map_dsp(fl, buf->phys, buf->size, buf->flag,
> +					req.vaddrin, &raddr);
> +		if (err)
> +			goto err_invoke;
> +
> +		/* update the buffer to be able to deallocate the memory on the DSP */
> +		buf->raddr = (uintptr_t) raddr;
> +
> +		/* let the client know the address to use */
> +		req.vaddrout = raddr;
>  
> +		spin_lock(&fl->lock);
> +		if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR)
> +			list_add_tail(&buf->node, &fl->spd->rmaps);
> +		else
> +			list_add_tail(&buf->node, &fl->mmaps);
> +		spin_unlock(&fl->lock);
> +		dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
> +			buf->raddr, buf->size);
> +	} else {
> +		if ((req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR) && fl->is_unsigned_pd) {
> +			dev_err(dev, "secure memory allocation is not supported in unsigned PD\n");
> +			return -EINVAL;
> +		}
> +		err = fastrpc_map_create(fl, req.fd, req.size, 0, &map);
> +		if (err) {
> +			dev_err(dev, "failed to map buffer, fd = %d\n", req.fd);
> +			return err;
> +		}
> +
> +		err = fastrpc_req_map_dsp(fl, map->phys, map->size, req.flags,
> +					req.vaddrin, &raddr);
> +		if (err)
> +			goto err_invoke;
> +
> +		/* update the buffer to be able to deallocate the memory on the DSP */
> +		map->raddr = (uintptr_t) raddr;
> +
> +		/* let the client know the address to use */
> +		req.vaddrout = raddr;
> +		dev_dbg(dev, "mmap\t\tpt 0x%09llx OK [len 0x%08llx]\n",
> +			map->raddr, map->size);
> +	}
>  	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
>  		err = -EFAULT;
>  		goto err_copy;
>  	}
>  
> -	dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
> -		buf->raddr, buf->size);
> -
>  	return 0;
>  
>  err_copy:
> -	spin_lock(&fl->lock);
> -	list_del(&buf->node);
> -	spin_unlock(&fl->lock);
> -	fastrpc_req_munmap_impl(fl, buf);
> -	buf = NULL;
> +	if ((req.flags != ADSP_MMAP_ADD_PAGES &&
> +		req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR) || fl->is_unsigned_pd) {
> +		fastrpc_req_munmap_dsp(fl, map->raddr, map->size);
> +	} else {
> +		spin_lock(&fl->lock);
> +		list_del(&buf->node);
> +		spin_unlock(&fl->lock);
> +		fastrpc_req_munmap_impl(fl, buf);
> +		buf = NULL;
> +	}
>  err_invoke:
> -	fastrpc_buf_free(buf);
> +	if (map)
> +		fastrpc_map_put(map);
> +	if (buf)
> +		fastrpc_buf_free(buf);
>  
>  	return err;
>  }
>  
> -
>  static int fastrpc_req_mem_unmap_impl(struct fastrpc_user *fl, struct fastrpc_mem_unmap *req)
>  {
>  	struct fastrpc_invoke_args args[1] = { [0] = { 0 } };
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

