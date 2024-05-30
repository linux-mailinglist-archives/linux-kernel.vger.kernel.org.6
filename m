Return-Path: <linux-kernel+bounces-195290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881E68D4A1F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1091F1F21CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9306016F85C;
	Thu, 30 May 2024 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YhDrEFXy"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A001716F0F3
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717067680; cv=none; b=WnzDG/jgtI/Ne8dQJ1b12ehuImdguYolC2bPN6ZGe9KxSEQyYy9L75ez1xFiF92+3FRDym8gi5Jpo8REkyhdPrHPACSEhQy4Smw9NsI9o7owaXvhyEhaoMOfa4FS2C3WEfP3/DQlDroQU+dTQ0N77P3wjiy8DOTrZQwP0V6YkFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717067680; c=relaxed/simple;
	bh=732Gjhc2RgUE8SmuB/jR+r6xLyR5NGjIurE8vs9v2zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKrJRLxqrtz+L0NHUqQJn8RAaHQcUY6Vef49h3t9BriC72Uu0eP4kguVF35yQC2nr3QTzTqZjH3bgDUlLTNhhnSPCiZcjywL9MQ3TACveUgEPVFS0pHRanZW8hAs2zx1Zebg6d9c2Mnh0dvvKsJH3YzQKoD4Gs19Gpggprs2SOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YhDrEFXy; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ab11ecdbaso929284e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 04:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717067676; x=1717672476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nnzatbAObdOj+XjAy/eNaVKqECTozKKVjBHcPUxzmuE=;
        b=YhDrEFXyZBdY6Fmi/oZx7JXWEeH2CeJzl3XQ8U3b9BnKIjyPRTb7R5xe7+C38lvsK0
         jHXZBDCnfpUAnTpSjvoB91pwugWUoMjej4P/y7BuJEn6eKKEx7tvMMKe58BVMVwWyLD6
         ow2JCZ+xvKB5zBrkKBlCQ54wlv7tOItavDtaFFCJKlHpzmSwBoTq2APwdFhKVcIsHUv+
         +QqGKBQf4R3NQSCsuHIlnMrz+tYtcFHh9UXH9Ol85ahKQQEEUzZE3scgoiDj/Ij1IKi0
         Am43EhfZlc68Ow2F8z72pf3Ou/7rpW2EQbaOPmQTtTa4tI4agy8GvhcVl1aKOKVBSbM1
         yw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717067676; x=1717672476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnzatbAObdOj+XjAy/eNaVKqECTozKKVjBHcPUxzmuE=;
        b=A+bakFai5FOprBYba1MGqUPEZj7gA0HTmBoRwXac3bhDN1IJRQd3blSnDBANH/Kan6
         lcZnornf2khoJRmr4HXy/dSAfUmS8npk7cR5wjZI+lrf84VwBAwKpukqKgrie4Kvl+eW
         +6wqSSkZHqRTPb0byxDiGl+r2W9Cyo0wfYKmX0ec1aFHL8Gmpg/80faXs85InXkG2tiA
         OngKWzAAm3nTKh3446I3d9Y56zSw+5AQin0ug0Mone5VKqPrCO4KeIK8HkWXJ68C9KTr
         wW3vox/ikAAxReByIT5ZPekPePYOgk777DC0mrXofbFPMzVC8JJzyflOQdfoA57mkHEd
         aT0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVYHFgZzp2yUsUdqa75PG6sv8OX3Su3ImWRgP2PLenCdD7EXLQqPkM39GcB4YunBdK8IQSBOCTf/yaUXANzao3P01BMCAnp6qMSW61
X-Gm-Message-State: AOJu0YwlDJ4leM1CG9wF035yy1//BKyFMCFZgQlamrwwEWBLaDAt7E2i
	aaPb09cig+NpZ/y29KZFrVyhJkLjjpV0EWgtW1QNhfnsRfFRQn8IovIsAdnM/20=
X-Google-Smtp-Source: AGHT+IHofp7vRVOpiPgw5YPvIaiOB6qMaFrK55v8F8LRPbSi4sK4R9eg/m4ApRBF+2r4+sIqv/38tQ==
X-Received: by 2002:a19:c505:0:b0:52b:72d2:8ebd with SMTP id 2adb3069b0e04-52b7d428dcdmr1083209e87.24.1717067675618;
        Thu, 30 May 2024 04:14:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52970d2a08fsm1518624e87.217.2024.05.30.04.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 04:14:35 -0700 (PDT)
Date: Thu, 30 May 2024 14:14:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com
Subject: Re: [PATCH v3 5/9] misc: fastrpc: Redesign remote heap management
Message-ID: <5bcrmwh4on5u37awkv4tmgl6v34sdbwa2v4zc5flkgqm5qknap@mvrvecmekety>
References: <20240530102032.27179-1-quic_ekangupt@quicinc.com>
 <20240530102032.27179-6-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530102032.27179-6-quic_ekangupt@quicinc.com>

On Thu, May 30, 2024 at 03:50:23PM +0530, Ekansh Gupta wrote:
> Current remote heap design comes with problems where all types of
> buffers are getting added to interrupted list and also user unmap
> request is not handling the request to unmap remote heap buffer
> type. Add changes to maintain list in a way that it can be used to
> to support remote heap grow/shrink request and the remote heap
> buffers cleanup during static PD restart.

This commit seems to contain several fixes squashed into one. You have
heap management, scm_done fix, missing SCM calls on rpmsg removal and
maybe several other fixes. Please separate them so that each commit
fixes just one issue in an atomic way.

> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 221 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 175 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d115860fc356..ef9bbd8c3dd1 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -210,6 +210,7 @@ struct fastrpc_buf {
>  	struct dma_buf *dmabuf;
>  	struct device *dev;
>  	void *virt;
> +	u32 flag;
>  	u64 phys;
>  	u64 size;
>  	/* Lock for dma buf attachments */
> @@ -274,6 +275,7 @@ struct fastrpc_session_ctx {
>  };
>  
>  struct fastrpc_static_pd {
> +	struct list_head rmaps;
>  	char *servloc_name;
>  	char *spdname;
>  	void *pdrhandle;
> @@ -299,7 +301,6 @@ struct fastrpc_channel_ctx {
>  	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
>  	struct fastrpc_device *secure_fdevice;
>  	struct fastrpc_device *fdevice;
> -	struct fastrpc_buf *remote_heap;
>  	struct list_head invoke_interrupted_mmaps;
>  	bool secure;
>  	bool unsigned_support;
> @@ -1256,6 +1257,53 @@ static bool is_session_rejected(struct fastrpc_user *fl, bool unsigned_pd_reques
>  	return false;
>  }
>  
> +static void fastrpc_mmap_remove_pdr(struct fastrpc_static_pd *spd)
> +{
> +	struct fastrpc_buf *buf, *b;
> +	struct fastrpc_channel_ctx *cctx;
> +	int err;
> +
> +	if (!spd || !spd->fl)
> +		return;
> +
> +	cctx = spd->cctx;
> +
> +	spin_lock(&spd->fl->lock);
> +	list_for_each_entry_safe(buf, b, &spd->rmaps, node) {
> +		list_del(&buf->node);
> +		spin_unlock(&spd->fl->lock);
> +		if (cctx->vmcount) {
> +			u64 src_perms = 0;
> +			struct qcom_scm_vmperm dst_perms;
> +			u32 i;
> +
> +			for (i = 0; i < cctx->vmcount; i++)
> +				src_perms |= BIT(cctx->vmperms[i].vmid);
> +
> +			dst_perms.vmid = QCOM_SCM_VMID_HLOS;
> +			dst_perms.perm = QCOM_SCM_PERM_RWX;
> +			err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
> +				&src_perms, &dst_perms, 1);
> +			if (err) {
> +				pr_err("%s: Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
> +					__func__, buf->phys, buf->size, err);
> +				return;
> +			}
> +		}
> +		fastrpc_buf_free(buf);
> +		spin_lock(&spd->fl->lock);
> +	}
> +	spin_unlock(&spd->fl->lock);
> +}
> +
> +static void fastrpc_mmap_remove_ssr(struct fastrpc_channel_ctx *cctx)
> +{
> +	int i;
> +
> +	for (i = 0; i < FASTRPC_MAX_SPD; i++)
> +		fastrpc_mmap_remove_pdr(&cctx->spd[i]);
> +}
> +
>  static struct fastrpc_static_pd *fastrpc_get_spd_session(
>  				struct fastrpc_user *fl)
>  {
> @@ -1282,9 +1330,12 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  	struct fastrpc_init_create_static init;
>  	struct fastrpc_invoke_args *args;
>  	struct fastrpc_phy_page pages[1];
> +	struct fastrpc_buf *buf = NULL;
>  	struct fastrpc_static_pd *spd = NULL;
> +	u64 phys = 0, size = 0;
>  	char *name;
>  	int err;
> +	bool scm_done = false;
>  	struct {
>  		int pgid;
>  		u32 namelen;
> @@ -1330,25 +1381,26 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  		goto err_name;
>  	}
>  	fl->spd = spd;
> -	if (!fl->cctx->remote_heap) {
> -		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
> -						&fl->cctx->remote_heap);
> +	if (list_empty(&spd->rmaps)) {
> +		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen, &buf);
>  		if (err)
>  			goto err_name;
>  
> +		phys = buf->phys;
> +		size = buf->size;
>  		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
>  		if (fl->cctx->vmcount) {
>  			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
>  
> -			err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
> -							(u64)fl->cctx->remote_heap->size,
> +			err = qcom_scm_assign_mem(phys, (u64)size,
>  							&src_perms,
>  							fl->cctx->vmperms, fl->cctx->vmcount);
>  			if (err) {
>  				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d\n",
> -					fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
> +					phys, size, err);
>  				goto err_map;
>  			}
> +			scm_done = true;
>  		}
>  	}
>  
> @@ -1365,8 +1417,8 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  	args[1].length = inbuf.namelen;
>  	args[1].fd = -1;
>  
> -	pages[0].addr = fl->cctx->remote_heap->phys;
> -	pages[0].size = fl->cctx->remote_heap->size;
> +	pages[0].addr = phys;
> +	pages[0].size = size;
>  
>  	args[2].ptr = (u64)(uintptr_t) pages;
>  	args[2].length = sizeof(*pages);
> @@ -1380,10 +1432,17 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  		goto err_invoke;
>  
>  	kfree(args);
> +	kfree(name);
> +
> +	if (buf) {
> +		spin_lock(&fl->lock);
> +		list_add_tail(&buf->node, &spd->rmaps);
> +		spin_unlock(&fl->lock);
> +	}
>  
>  	return 0;
>  err_invoke:
> -	if (fl->cctx->vmcount) {
> +	if (fl->cctx->vmcount && scm_done) {
>  		u64 src_perms = 0;
>  		struct qcom_scm_vmperm dst_perms;
>  		u32 i;
> @@ -1393,15 +1452,15 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  
>  		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
>  		dst_perms.perm = QCOM_SCM_PERM_RWX;
> -		err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
> -						(u64)fl->cctx->remote_heap->size,
> +		err = qcom_scm_assign_mem(phys, (u64)size,
>  						&src_perms, &dst_perms, 1);
>  		if (err)
>  			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
> -				fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
> +				phys, size, err);
>  	}
>  err_map:
> -	fastrpc_buf_free(fl->cctx->remote_heap);
> +	if (buf)
> +		fastrpc_buf_free(buf);
>  err_name:
>  	kfree(name);
>  err:
> @@ -1866,17 +1925,16 @@ static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
>  	return 0;
>  }
>  
> -static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *buf)
> +static int fastrpc_req_munmap_dsp(struct fastrpc_user *fl, uintptr_t raddr, u64 size)
>  {
>  	struct fastrpc_invoke_args args[1] = { [0] = { 0 } };
>  	struct fastrpc_munmap_req_msg req_msg;
> -	struct device *dev = fl->sctx->dev;
>  	int err;
>  	u32 sc;
>  
>  	req_msg.pgid = fl->tgid;
> -	req_msg.size = buf->size;
> -	req_msg.vaddr = buf->raddr;
> +	req_msg.size = size;
> +	req_msg.vaddr = raddr;
>  
>  	args[0].ptr = (u64) (uintptr_t) &req_msg;
>  	args[0].length = sizeof(req_msg);
> @@ -1884,11 +1942,38 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
>  	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MUNMAP, 1, 0);
>  	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
>  				      &args[0]);
> +
> +	return err;
> +}
> +
> +static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *buf)
> +{
> +	struct device *dev = fl->sctx->dev;
> +	int err;
> +
> +	err = fastrpc_req_munmap_dsp(fl, buf->raddr, buf->size);
>  	if (!err) {
> +		if (buf->flag == ADSP_MMAP_REMOTE_HEAP_ADDR) {
> +			if (fl->cctx->vmcount) {
> +				u64 src_perms = 0;
> +				struct qcom_scm_vmperm dst_perms;
> +				u32 i;
> +
> +				for (i = 0; i < fl->cctx->vmcount; i++)
> +					src_perms |= BIT(fl->cctx->vmperms[i].vmid);
> +
> +				dst_perms.vmid = QCOM_SCM_VMID_HLOS;
> +				dst_perms.perm = QCOM_SCM_PERM_RWX;
> +				err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
> +								&src_perms, &dst_perms, 1);
> +				if (err) {
> +					dev_err(dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
> +						buf->phys, buf->size, err);
> +					return err;
> +				}
> +			}
> +		}
>  		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
> -		spin_lock(&fl->lock);
> -		list_del(&buf->node);
> -		spin_unlock(&fl->lock);
>  		fastrpc_buf_free(buf);
>  	} else {
>  		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
> @@ -1902,6 +1987,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
>  	struct fastrpc_buf *buf = NULL, *iter, *b;
>  	struct fastrpc_req_munmap req;
>  	struct device *dev = fl->sctx->dev;
> +	int err = 0;
>  
>  	if (copy_from_user(&req, argp, sizeof(req)))
>  		return -EFAULT;
> @@ -1910,20 +1996,48 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
>  	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
>  		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
>  			buf = iter;
> +			list_del(&buf->node);
>  			break;
>  		}
>  	}
>  	spin_unlock(&fl->lock);
>  
> -	if (!buf) {
> -		dev_err(dev, "mmap\t\tpt 0x%09llx [len 0x%08llx] not in list\n",
> -			req.vaddrout, req.size);
> -		return -EINVAL;
> +	if (buf) {
> +		err = fastrpc_req_munmap_impl(fl, buf);
> +		if (err) {
> +			spin_lock(&fl->lock);
> +			list_add_tail(&buf->node, &fl->mmaps);
> +			spin_unlock(&fl->lock);
> +		}
> +		return err;
>  	}
>  
> -	return fastrpc_req_munmap_impl(fl, buf);
> +	spin_lock(&fl->lock);
> +	if (fl->spd) {
> +		list_for_each_entry_safe(iter, b, &fl->spd->rmaps, node) {
> +			if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
> +				buf = iter;
> +				list_del(&buf->node);
> +				break;
> +			}
> +		}
> +	}
> +	spin_unlock(&fl->lock);
> +	if (buf) {
> +		err = fastrpc_req_munmap_impl(fl, buf);
> +		if (err) {
> +			spin_lock(&fl->lock);
> +			list_add_tail(&buf->node, &fl->spd->rmaps);
> +			spin_unlock(&fl->lock);
> +		}
> +		return err;
> +	}
> +	dev_err(dev, "buffer not found addr 0x%09lx, len 0x%08llx\n",
> +			req.vaddrout, req.size);
> +	return -EINVAL;
>  }
>  
> +
>  static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>  {
>  	struct fastrpc_invoke_args args[3] = { [0 ... 2] = { 0 } };
> @@ -1950,16 +2064,34 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>  		return -EINVAL;
>  	}
>  
> -	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR)
> +	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR) {
> +		if (!fl->spd || !fl->spd->ispdup) {
> +			dev_err(dev, "remote heap request supported only for active static PD\n");
> +			return -EINVAL;
> +		}
>  		err = fastrpc_remote_heap_alloc(fl, dev, req.size, &buf);
> -	else
> +	} else {
>  		err = fastrpc_buf_alloc(fl, dev, req.size, &buf);
> +	}
>  
>  	if (err) {
>  		dev_err(dev, "failed to allocate buffer\n");
>  		return err;
>  	}
> +	buf->flag = req.flags;
>  
> +	/* Add memory to static PD pool, protection through hypervisor */
> +	if ((req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR) && fl->cctx->vmcount) {
> +		u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
> +
> +		err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
> +			&src_perms, fl->cctx->vmperms, fl->cctx->vmcount);
> +		if (err) {
> +			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
> +					buf->phys, buf->size, err);
> +			goto err_invoke;
> +		}
> +	}
>  	req_msg.pgid = fl->tgid;
>  	req_msg.flags = req.flags;
>  	req_msg.vaddr = req.vaddrin;
> @@ -1991,26 +2123,17 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>  	/* let the client know the address to use */
>  	req.vaddrout = rsp_msg.vaddr;
>  
> -	/* Add memory to static PD pool, protection thru hypervisor */
> -	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
> -		u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
> -
> -		err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
> -			&src_perms, fl->cctx->vmperms, fl->cctx->vmcount);
> -		if (err) {
> -			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
> -					buf->phys, buf->size, err);
> -			goto err_assign;
> -		}
> -	}
>  
>  	spin_lock(&fl->lock);
> -	list_add_tail(&buf->node, &fl->mmaps);
> +	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR)
> +		list_add_tail(&buf->node, &fl->spd->rmaps);
> +	else
> +		list_add_tail(&buf->node, &fl->mmaps);
>  	spin_unlock(&fl->lock);
>  
>  	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
>  		err = -EFAULT;
> -		goto err_assign;
> +		goto err_copy;
>  	}
>  
>  	dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
> @@ -2018,14 +2141,19 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>  
>  	return 0;
>  
> -err_assign:
> +err_copy:
> +	spin_lock(&fl->lock);
> +	list_del(&buf->node);
> +	spin_unlock(&fl->lock);
>  	fastrpc_req_munmap_impl(fl, buf);
> +	buf = NULL;
>  err_invoke:
>  	fastrpc_buf_free(buf);
>  
>  	return err;
>  }
>  
> +
>  static int fastrpc_req_mem_unmap_impl(struct fastrpc_user *fl, struct fastrpc_mem_unmap *req)
>  {
>  	struct fastrpc_invoke_args args[1] = { [0] = { 0 } };
> @@ -2249,6 +2377,7 @@ static void fastrpc_pdr_cb(int state, char *service_path, void *priv)
>  			spd->servloc_name,
>  			domains[cctx->domain_id]);
>  		spd->ispdup = false;
> +		fastrpc_mmap_remove_pdr(spd);
>  		fastrpc_notify_pdr_drivers(cctx, spd->servloc_name);
>  		break;
>  	case SERVREG_SERVICE_STATE_UP:
> @@ -2400,6 +2529,7 @@ static int fastrpc_setup_service_locator(struct fastrpc_channel_ctx *cctx, char
>  	cctx->spd[spd_session].servloc_name = client_name;
>  	cctx->spd[spd_session].spdname = service_path;
>  	cctx->spd[spd_session].cctx = cctx;
> +	INIT_LIST_HEAD(&cctx->spd[spd_session].rmaps);
>  	service = pdr_add_lookup(handle, service_name, service_path);
>  	if (IS_ERR(service)) {
>  		err = PTR_ERR(service);
> @@ -2566,9 +2696,6 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>  	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
>  		list_del(&buf->node);
>  
> -	if (cctx->remote_heap)
> -		fastrpc_buf_free(cctx->remote_heap);
> -
>  	for (i = 0; i < FASTRPC_MAX_SPD; i++) {
>  		if (cctx->spd[i].pdrhandle)
>  			pdr_handle_release(cctx->spd[i].pdrhandle);
> @@ -2576,6 +2703,8 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>  
>  	of_platform_depopulate(&rpdev->dev);
>  
> +	fastrpc_mmap_remove_ssr(cctx);
> +
>  	fastrpc_channel_ctx_put(cctx);
>  }
>  
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

