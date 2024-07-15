Return-Path: <linux-kernel+bounces-252277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2819310DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633A11C21F70
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EBE186E50;
	Mon, 15 Jul 2024 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ze3eCgGF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD51185E53
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721034463; cv=none; b=EJ8Yhzzp157RtDObxJ3612fJWtLqPSFy11AELIiW0eG5n08/5iDnwUE3MKOfsrEdT9l25l4NEbe5vo5D0VJ4EgIC8dLCDBJ26x9osw+Ob+iVFhmqibzntK7PnLfqPwEsxh6o1sA9n/GB0u69+f8EAHmbo/vZaoRlv2AeVuS8xjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721034463; c=relaxed/simple;
	bh=SaagXfvjOJrqhWp5wq/kmkkFgsOqTCTh0w/zLSlrF+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8WqS6xfGneiR8wzdlTGXOTIJ1KT0FJxPrtdW9yDbL5tKInuznNzwvEMEmgdTdz0YMQLLpLxcQ4FYwwTuRytJ9WNoZwMC5Cv7BuBEWxpWuD+tyNDHeTI0wLiSAoK/Jv39gHK3CUsbacyWQ6a8wl6HDIDYj85pxSRnXEO9ZgRv0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ze3eCgGF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721034460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eH72eS6Nfsd8BGGyd0s/cB539dWJLqVScR1RR0nuva0=;
	b=Ze3eCgGFvQiAi1cm7zqSbCtp3ud6dHThrTvizkVO49K00zHw3n3sO4Ia32dy2TA4WOfaAf
	i8/KU4j85/irCZzvO4SOv4oS5NagpqSH/GGh51FxXPvH9i9G8yT2Of7G/MOStRX7I/lWAm
	003AngH3UuLIEVh8XUwOg8bV3nKcA30=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-4aoKucdDPP-WzUPniAmKww-1; Mon, 15 Jul 2024 05:07:36 -0400
X-MC-Unique: 4aoKucdDPP-WzUPniAmKww-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52e96ca162dso3996433e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 02:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721034455; x=1721639255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eH72eS6Nfsd8BGGyd0s/cB539dWJLqVScR1RR0nuva0=;
        b=eg0DQEMAwiAON3qs/YdfZ2gLtOwFeSR5ejaY8CBMKc9RnnmpXi4ENkoYimpEbTML0W
         fcNfnAqDbCJNqrdpbmuE7psR3b0Vx6u0KUbV+B8GUKMgWvtB5+Sm8JdXxac4Vgpr03ag
         xOVIGk8XcBxs0dNz6x5XFV3t/X1JIVT72K/ioeRqVsH5Jjh6vx0Nsngt/3yzYBWlqc7I
         QSug02JpbzVrjQ90xaghkaPMayxMf3wkCO55KgJkxt7zp9X5kydzX7Vsi9aWP0AVF1L0
         kdG3SxeQEy69zDgSRZXb4DQKLj3MCcYiEYU7Eri7Iwgu7N7NaHZKOT7GVkHDrsgJGx+I
         NwTg==
X-Forwarded-Encrypted: i=1; AJvYcCWVwDldAoExtphcdQRapUUfsWnYjfC/wyIAnObluYqNpXURDf4JOOcfAXfrwipBoDyGsvTpi0C0VGaMqmjFTw6hA3GTBWXrqs9sEexp
X-Gm-Message-State: AOJu0YwZcc6oWka3BtV/h7UqTwu/soxFYNiDPPfho+n2jff1tsNgB5je
	cQxL+QN3pDxtNdjXIaSNRBvkxv2xlSWHEcz+srdyzDeej4+2c8nkjywi2uVu6N8UL2U7ULrdtba
	OBC7vTHaapqREWX1bvtCQxBptyyOkFnsLdk77w82scJn24p+sCZPCgR54IS32rg==
X-Received: by 2002:a05:6512:214e:b0:52c:8920:875 with SMTP id 2adb3069b0e04-52eb9994aecmr8544218e87.20.1721034455156;
        Mon, 15 Jul 2024 02:07:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFhfLgY+bn99BkvxgIHF9fTJuKWkSpE3lF6FxeMKlgnydVdlFufzTjpZYisBAUDPH3nAsusA==
X-Received: by 2002:a05:6512:214e:b0:52c:8920:875 with SMTP id 2adb3069b0e04-52eb9994aecmr8544197e87.20.1721034454471;
        Mon, 15 Jul 2024 02:07:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:240:5146:27c:20a3:47d4:904])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f25942csm111837255e9.15.2024.07.15.02.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 02:07:33 -0700 (PDT)
Date: Mon, 15 Jul 2024 05:07:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio Perez Martin <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH V2 3/7] vhost-vdpa: VHOST_NEW_OWNER
Message-ID: <20240715050637-mutt-send-email-mst@kernel.org>
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <1720790333-456232-4-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1720790333-456232-4-git-send-email-steven.sistare@oracle.com>

On Fri, Jul 12, 2024 at 06:18:49AM -0700, Steve Sistare wrote:
> Add an ioctl to transfer file descriptor ownership and pinned memory
> accounting from one process to another.
> 
> This is more efficient than VHOST_RESET_OWNER followed by VHOST_SET_OWNER,
> as that would unpin all physical pages, requiring them to be repinned in
> the new process.  That would cost multiple seconds for large memories, and
> be incurred during a virtual machine's pause time during live update.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Please, we just need to switch to use iommufd for pinning.
Piling up all these hacks gets us nowhere.


> ---
>  drivers/vhost/vdpa.c       | 41 ++++++++++++++++++++++++++++++++++++++
>  drivers/vhost/vhost.c      | 15 ++++++++++++++
>  drivers/vhost/vhost.h      |  1 +
>  include/uapi/linux/vhost.h | 10 ++++++++++
>  4 files changed, 67 insertions(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index b49e5831b3f0..5cf55ca4ec02 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -632,6 +632,44 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
>  	return ret;
>  }
>  
> +static long vhost_vdpa_new_owner(struct vhost_vdpa *v)
> +{
> +	int r;
> +	struct vhost_dev *vdev = &v->vdev;
> +	struct mm_struct *mm_old = vdev->mm;
> +	struct mm_struct *mm_new = current->mm;
> +	long pinned_vm = v->pinned_vm;
> +	unsigned long lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> +
> +	if (!mm_old)
> +		return -EINVAL;
> +	mmgrab(mm_old);
> +
> +	if (!v->vdpa->use_va &&
> +	    pinned_vm + atomic64_read(&mm_new->pinned_vm) > lock_limit) {
> +		r = -ENOMEM;
> +		goto out;
> +	}
> +	r = vhost_vdpa_bind_mm(v, mm_new);
> +	if (r)
> +		goto out;
> +
> +	r = vhost_dev_new_owner(vdev);
> +	if (r) {
> +		vhost_vdpa_bind_mm(v, mm_old);
> +		goto out;
> +	}
> +
> +	if (!v->vdpa->use_va) {
> +		atomic64_sub(pinned_vm, &mm_old->pinned_vm);
> +		atomic64_add(pinned_vm, &mm_new->pinned_vm);
> +	}
> +
> +out:
> +	mmdrop(mm_old);
> +	return r;
> +}
> +
>  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  				   void __user *argp)
>  {
> @@ -876,6 +914,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>  	case VHOST_VDPA_RESUME:
>  		r = vhost_vdpa_resume(v);
>  		break;
> +	case VHOST_NEW_OWNER:
> +		r = vhost_vdpa_new_owner(v);
> +		break;
>  	default:
>  		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
>  		if (r == -ENOIOCTLCMD)
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index b60955682474..ab40ae50552f 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -963,6 +963,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_set_owner);
>  
> +/* Caller should have device mutex */
> +long vhost_dev_new_owner(struct vhost_dev *dev)
> +{
> +	if (dev->mm == current->mm)
> +		return -EBUSY;
> +
> +	if (!vhost_dev_has_owner(dev))
> +		return -EINVAL;
> +
> +	vhost_detach_mm(dev);
> +	vhost_attach_mm(dev);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(vhost_dev_new_owner);
> +
>  static struct vhost_iotlb *iotlb_alloc(void)
>  {
>  	return vhost_iotlb_alloc(max_iotlb_entries,
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index bb75a292d50c..8b2018bb02b1 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -187,6 +187,7 @@ void vhost_dev_init(struct vhost_dev *, struct vhost_virtqueue **vqs,
>  		    int (*msg_handler)(struct vhost_dev *dev, u32 asid,
>  				       struct vhost_iotlb_msg *msg));
>  long vhost_dev_set_owner(struct vhost_dev *dev);
> +long vhost_dev_new_owner(struct vhost_dev *dev);
>  bool vhost_dev_has_owner(struct vhost_dev *dev);
>  long vhost_dev_check_owner(struct vhost_dev *);
>  struct vhost_iotlb *vhost_dev_reset_owner_prepare(void);
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b95dd84eef2d..543d0e3434c3 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -123,6 +123,16 @@
>  #define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
>  #define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
>  
> +/* Set current process as the new owner of this file descriptor.  The fd must
> + * already be owned, via a prior call to VHOST_SET_OWNER.  The pinned memory
> + * count is transferred from the previous to the new owner.
> + * Errors:
> + *   EINVAL: not owned
> + *   EBUSY:  caller is already the owner
> + *   ENOMEM: RLIMIT_MEMLOCK exceeded
> + */
> +#define VHOST_NEW_OWNER _IO(VHOST_VIRTIO, 0x27)
> +
>  /* VHOST_NET specific defines */
>  
>  /* Attach virtio net ring to a raw socket, or tap device.
> -- 
> 2.39.3


