Return-Path: <linux-kernel+bounces-286026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD9C951580
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F6C1F26E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDBC1448EB;
	Wed, 14 Aug 2024 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHrJq4vB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A5713BC0C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620447; cv=none; b=dYCvqlbk4m+bQkzwfqNJhf4upsZtWuUXqzTEDsbQE75xZ/PEEjeUPqa0CmVF051DlR17PmYl2z4C5b9hrbMmzVWhJC7P0vTZIbdVyUUi+1MEHsXUHw/yBr1KSYBteKEQqv5sPuVR6Aaa7aZ+uSDnLAoYbj/uKqdMogoF7tOfCbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620447; c=relaxed/simple;
	bh=1UP383j6hjG1P69n1FRHYze421i09BJSQebpheB6rVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AECP6WAJ/vTHeeG5b1r/NRlzHq7wViyc2xWzVGoZj2EcZ8omYpSd9LlNqCjP7OuShgiFzDl52LJz0vGIiGP7741ZWdtJjQqCOk2koTk2wmOI1bqWGqJKnMxDpe7oXLD9ytzrFQfylMHgsL1YkjXg2wZ7NYpv6hElNsrsP5njyJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IHrJq4vB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723620444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lWW6/JtLLOdbS2RriwQ1Xt/j+3UDgvX+fkiP4SLbmfs=;
	b=IHrJq4vB/fV7DRuOiSPfu5RX7YoX/yvRXHH/6WEWiFD5ehUC437Ssa2gMhgcxVebi04kYE
	4gYejjKWcz5fiLjVFlh+bfnd34HcRozjlLUiWtIqor4T9iS2glBloRZ9f9hzGNUmCpvG/I
	ABQvmsetuss58ca9/tpYNn7i5QzKu+8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-g7T-xtRMPMSpf5cF6ABslA-1; Wed, 14 Aug 2024 03:27:22 -0400
X-MC-Unique: g7T-xtRMPMSpf5cF6ABslA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a77e044ff17so405877266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 00:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723620440; x=1724225240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWW6/JtLLOdbS2RriwQ1Xt/j+3UDgvX+fkiP4SLbmfs=;
        b=Rl8cn00Yg0Sq0EXww4uheY5yjsIagZDINwdi7wz+X+iDP+9hmxurnOHm5eHZeGOUsg
         TiM+C2ltk+lEOQQnfPSNqPLqN7x8pTfulTfpH5ACpEdBWdvDXVtLI6xjmtAZ3wcWPXa3
         y16uhbctYjmtz6b8bau1HrVWXFEn7+xqmscWE+0qhfPHoT9DV+3k/cPoaHjfCcqSFyeE
         oSuDZo6MkO6/fEhvWW/G2vtcdHEXeWnedR9pCAYQsSAedm73BMoww5Q/J3Y4xOFtsGYN
         C2xNPU5bLFeez5E3lvGeUr21XrIxRWusjFUX0c1qkEV2uodhG03OrsDlClGcgVOnDL1r
         hEig==
X-Forwarded-Encrypted: i=1; AJvYcCX/zFWL87nX52M6xIaAZR8SU3pcFR4UOboUF0aIo8KzGDjA0TOnODaRpl66ySb0t+HbaDreau+EvI+ne6ld3IHgYxGO1shghD1efWnu
X-Gm-Message-State: AOJu0Yy0V8hCS5y4SuJ0cWsAFDemfFHdudlvFRUkNKvnhty4veGwevek
	0AI/uem+z5szs5wfjFm+juP7FwT8x849xdCIwmBt1sOw8H3jf8EkGpm/SG6rkWAi8GUGyHXTW33
	edyQZSO6TEqZaF8vrq8bipaBy8t0yzpqTA5+XtevxcIMybe2auHQdAG+mdj3aR6cGjHKvZg==
X-Received: by 2002:a17:907:e6cb:b0:a7a:83f8:cfd5 with SMTP id a640c23a62f3a-a8366c31b00mr116565866b.18.1723620440172;
        Wed, 14 Aug 2024 00:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWLP3dpgqeL2l8ABzufX/5DIla/d7Ejaojfhfx0OWK/1bdtH+0ljIF9zLiuDaMf7faqOl25Q==
X-Received: by 2002:a17:907:e6cb:b0:a7a:83f8:cfd5 with SMTP id a640c23a62f3a-a8366c31b00mr116563466b.18.1723620439327;
        Wed, 14 Aug 2024 00:27:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411d225sm137283666b.107.2024.08.14.00.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 00:27:18 -0700 (PDT)
Date: Wed, 14 Aug 2024 03:27:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, lingshan.zhu@intel.com, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] vhost_vdpa: assign irq bypass producer token
 correctly
Message-ID: <20240814032700-mutt-send-email-mst@kernel.org>
References: <20240808082044.11356-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808082044.11356-1-jasowang@redhat.com>

On Thu, Aug 08, 2024 at 04:20:44PM +0800, Jason Wang wrote:
> We used to call irq_bypass_unregister_producer() in
> vhost_vdpa_setup_vq_irq() which is problematic as we don't know if the
> token pointer is still valid or not.
> 
> Actually, we use the eventfd_ctx as the token so the life cycle of the
> token should be bound to the VHOST_SET_VRING_CALL instead of
> vhost_vdpa_setup_vq_irq() which could be called by set_status().
> 
> Fixing this by setting up  irq bypass producer's token when handling
> VHOST_SET_VRING_CALL and un-registering the producer before calling
> vhost_vring_ioctl() to prevent a possible use after free as eventfd
> could have been released in vhost_vring_ioctl().
> 
> Fixes: 2cf1ba9a4d15 ("vhost_vdpa: implement IRQ offloading in vhost_vdpa")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Want to post a non-RFC version?

> ---
> Note for Dragos: Please check whether this fixes your issue. I
> slightly test it with vp_vdpa in L2.
> ---
>  drivers/vhost/vdpa.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index e31ec9ebc4ce..388226a48bcc 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -209,11 +209,9 @@ static void vhost_vdpa_setup_vq_irq(struct vhost_vdpa *v, u16 qid)
>  	if (irq < 0)
>  		return;
>  
> -	irq_bypass_unregister_producer(&vq->call_ctx.producer);
>  	if (!vq->call_ctx.ctx)
>  		return;
>  
> -	vq->call_ctx.producer.token = vq->call_ctx.ctx;
>  	vq->call_ctx.producer.irq = irq;
>  	ret = irq_bypass_register_producer(&vq->call_ctx.producer);
>  	if (unlikely(ret))
> @@ -709,6 +707,12 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  			vq->last_avail_idx = vq_state.split.avail_index;
>  		}
>  		break;
> +	case VHOST_SET_VRING_CALL:
> +		if (vq->call_ctx.ctx) {
> +			vhost_vdpa_unsetup_vq_irq(v, idx);
> +			vq->call_ctx.producer.token = NULL;
> +		}
> +		break;
>  	}
>  
>  	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
> @@ -747,13 +751,14 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  			cb.callback = vhost_vdpa_virtqueue_cb;
>  			cb.private = vq;
>  			cb.trigger = vq->call_ctx.ctx;
> +			vq->call_ctx.producer.token = vq->call_ctx.ctx;
> +			vhost_vdpa_setup_vq_irq(v, idx);
>  		} else {
>  			cb.callback = NULL;
>  			cb.private = NULL;
>  			cb.trigger = NULL;
>  		}
>  		ops->set_vq_cb(vdpa, idx, &cb);
> -		vhost_vdpa_setup_vq_irq(v, idx);
>  		break;
>  
>  	case VHOST_SET_VRING_NUM:
> @@ -1419,6 +1424,7 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
>  	for (i = 0; i < nvqs; i++) {
>  		vqs[i] = &v->vqs[i];
>  		vqs[i]->handle_kick = handle_vq_kick;
> +		vqs[i]->call_ctx.ctx = NULL;
>  	}
>  	vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
>  		       vhost_vdpa_process_iotlb_msg);
> -- 
> 2.31.1


