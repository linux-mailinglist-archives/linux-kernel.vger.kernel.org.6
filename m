Return-Path: <linux-kernel+bounces-533384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2E1A45963
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A647F188F870
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439D1224245;
	Wed, 26 Feb 2025 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pps13Sp0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94B220C033
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560721; cv=none; b=D4PcTrnxP0xbIURyfulpnQ031iqqTMH4xDsCZJwsTUvOlOvk0qQwS0tMYRcBWyM2bzhSTJspshp+yFCwi3/mkch/Mf765VEoisYtHotGMIb4BaqmsOzpahapQl0CPnwSP1dBmomQC+/UqNNdQSrwKMHPWQWGgGgfxkif2jqtNL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560721; c=relaxed/simple;
	bh=70Bz6bXCIZd7CqL1a4wfBpVEIhFZTwDuQ4RJXOiwz4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmIcnPmo0P8HCp9yzJQXnZPXnIyxNZrJxkOJHGzhcl2jTmZ6TtOx90z8gWgZ627OlnP9l+yqvhMrgTTLgprWGvg6L0p9SKtfBE8Eb+VA9+Ec2Pa3unVSBbzfM9V/YqVP46NVk9D8I1KbcXKryKUsQj1DAqvnqZSvAKu+w+8o7BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pps13Sp0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740560717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3R3qxZExX3qPpR7lrGEQWDQ55EmOXnXBA4eKFTOeSc=;
	b=Pps13Sp0szRBZFNTh+o8WDmpVb7eRwgPoTUKJyNWa7GjXcKrhumhn7zXZjyDZFjIl91mNa
	1RsaSaNfKnQfzhxwtoOgX4+fC08X0iZRbN9WjkuH4yTS617IS3ProQuPM5ckyZvrNYCsCW
	WmDWB5NSM2zS/b8qQ/RRoDXRtd+aCSg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-5y0izBq_NS27L1cfZ851Bg-1; Wed, 26 Feb 2025 04:05:14 -0500
X-MC-Unique: 5y0izBq_NS27L1cfZ851Bg-1
X-Mimecast-MFC-AGG-ID: 5y0izBq_NS27L1cfZ851Bg_1740560713
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e08b755856so5709167a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740560713; x=1741165513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3R3qxZExX3qPpR7lrGEQWDQ55EmOXnXBA4eKFTOeSc=;
        b=B5X/PzQjEPNYKxWhMaO0bgUT+6bn1HbY0liImyDH8+HB4Qds3K5Idu2kHHvxzgWe4U
         o5Id3SKCWIneveds4yGMG5PyMkOkJ9kel0C4UGlIUaREmiRpdYCqKnqzfnZvTU/qAOQw
         MJM5Fjt/+jItOCQKasz6h/t9t+DYZr0DijtcHipE78oJzm/7OrjCccw2VLnR/loN61Ss
         SpFdFG+kceObBd1NxgRHKsMjz6tOwHZ6oTKKVA6MJS/udClfG6hATvcJJzZKVzU8qPAA
         hEPp7zTGrYlUzN+/oY9vwMZFXbZVMKc3XtonmxDMbyUfzRW7+oaJRIhSClZ6X3qGgJF+
         Mu2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+6QrG6NNi6UC4fGsaagtLgjixFmykZcC01+2XOwlyS/0tfSRArHVvEG4DQhg/l1HE1Zmzu6504reqUlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGPJ5nNf8NTIL0+s/kf0wWjKO2REq4XYSEnKE+vdvT2TwzF0nv
	8NqZqjijGfwHSy94B8Svhorb1O61W73aD7U3eQjB/91MLPkUB/VmOfPGJNBeRWKEpxLmeVy8BYi
	/RcO7Mi+avLZKajLPQBEKNnGQuIcxD1ICvGAEsAKbCGHGGzJzCvTpmtj8B6VHsQ==
X-Gm-Gg: ASbGnctRzOMVX+AvJQYZf3dDKG44/jPm7nuBoqp8+KwBigPJtmxsbaagJoge4ks5rxR
	0wGKyZobqIfQJ3zG0laiJp3cKPN2Bffna72OB85BFoy7ClxIC8hWrBK7u9bFLf/2S71ogM3ze5j
	0hSgaHtUDwgSME02gyIXLxd0m173+/AxOzVdVMpQAN8DLMB/Ur+Fd1YMLG70osY1xT35Qn2NAw6
	p96TbzIPkWNmELswoVrFoE+J8MqAUTXfqw00MM59fUp0I2svLFXBSj3++imKHAGjmeuLI7ujacC
	TKUXHbJkB/wVdilNdM0=
X-Received: by 2002:a05:6402:35c9:b0:5dc:1f35:563 with SMTP id 4fb4d7f45d1cf-5e4a0d45ce0mr2974869a12.7.1740560713392;
        Wed, 26 Feb 2025 01:05:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE494TvftaZSM3XnKjm3rhP+LMRh6Vk2MpaWmBgbVXsiLnzb3YS6LBhcMLOzYGoliBdZ979FA==
X-Received: by 2002:a05:6402:35c9:b0:5dc:1f35:563 with SMTP id 4fb4d7f45d1cf-5e4a0d45ce0mr2974810a12.7.1740560712818;
        Wed, 26 Feb 2025 01:05:12 -0800 (PST)
Received: from sgarzare-redhat ([5.179.186.222])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e45b80b94fsm2569435a12.42.2025.02.26.01.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 01:05:11 -0800 (PST)
Date: Wed, 26 Feb 2025 10:05:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
Message-ID: <77uzlntuxfzcj4qxggac23g73hslbkstygunqus33hzwrmotzq@f2t22l52xqdo>
References: <20250223154042.556001-1-lulu@redhat.com>
 <20250223154042.556001-6-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250223154042.556001-6-lulu@redhat.com>

On Sun, Feb 23, 2025 at 11:36:20PM +0800, Cindy Lu wrote:
>Add a new UAPI to enable setting the vhost device to task mode.
>The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
>to configure the mode if necessary.
>This setting must be applied before VHOST_SET_OWNER, as the worker
>will be created in the VHOST_SET_OWNER function
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c      | 24 ++++++++++++++++++++++--
> include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> 2 files changed, 40 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index d8c0ea118bb1..45d8f5c5bca9 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -1133,7 +1133,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
> 	int i;
>
> 	vhost_dev_cleanup(dev);
>-
>+	dev->inherit_owner = true;
> 	dev->umem = umem;
> 	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
> 	 * VQs aren't running.
>@@ -2278,15 +2278,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> {
> 	struct eventfd_ctx *ctx;
> 	u64 p;
>-	long r;
>+	long r = 0;
> 	int i, fd;
>+	u8 inherit_owner;
>
> 	/* If you are not the owner, you can become one */
> 	if (ioctl == VHOST_SET_OWNER) {
> 		r = vhost_dev_set_owner(d);
> 		goto done;
> 	}
>+	if (ioctl == VHOST_FORK_FROM_OWNER) {
>+		/*inherit_owner can only be modified before owner is set*/
>+		if (vhost_dev_has_owner(d)) {
>+			r = -EBUSY;
>+			goto done;
>+		}
>+		if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
>+			r = -EFAULT;
>+			goto done;
>+		}
>+		/* Validate the inherit_owner value, ensuring it is either 0 or 1 */
>+		if (inherit_owner > 1) {
>+			r = -EINVAL;
>+			goto done;
>+		}
>+
>+		d->inherit_owner = (bool)inherit_owner;
>
>+		goto done;
>+	}
> 	/* You must be the owner to do anything else */
> 	r = vhost_dev_check_owner(d);
> 	if (r)
>diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>index b95dd84eef2d..8f558b433536 100644
>--- a/include/uapi/linux/vhost.h
>+++ b/include/uapi/linux/vhost.h
>@@ -235,4 +235,22 @@
>  */
> #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
> 					      struct vhost_vring_state)
>+
>+/**
>+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device
>+ *
>+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
>+ *
>+ * When inherit_owner is set to 1:
>+ *   - The VHOST worker threads inherit its values/checks from
>+ *     the thread that owns the VHOST device, The vhost threads will
>+ *     be counted in the nproc rlimits.

Should we document that this (inherit_owner = 1) is the default, so if 
the user doesn't call VHOST_FORK_FROM_OWNER, this mode will be 
automatically selected?

Thanks,
Stefano

>+ *
>+ * When inherit_owner is set to 0:
>+ *   - The VHOST worker threads will use the traditional kernel thread (kthread)
>+ *     implementation, which may be preferred by older userspace applications that
>+ *     do not utilize the newer vhost_task concept.
>+ */
>+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
>+
> #endif
>-- 
>2.45.0
>


