Return-Path: <linux-kernel+bounces-531217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3280A43DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C7D1731AA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6D8267B97;
	Tue, 25 Feb 2025 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAuU4mwF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16852267B84
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483078; cv=none; b=dwotlMxa773Tc6johZle1azZZFVeiQwmeeSE8uGJOR424Kd2UxhHFgI5plXf8DsimN+3G69HTeciJoXfGQsMJhzK/UPBhRuls335eozvRSGICDFUDweMyL/ivjqG02NbyaLrgBGVOFywj0PZUY/Wsfy+dmfI6ojRwnunoItx0Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483078; c=relaxed/simple;
	bh=JNsvBkbU/xeGUA2wB24yiaAwvMR0TShWcVfnwYO9psk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBnCEF8ZuVdKrbYm9wWzJpJ29pykUc8F/g0vi6lvxCT2yT6LA7+4F1wKXTjfTfzbAPdMLDdc4ZFmcMJN9T2T6XghTTrkewCTE8rzfb6pQ1YY9leKfBARJe10fWAPcr0i6j373i7Wf2/buNpPeWcN2ZLNwuUTxuy+kjt/mgBD4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BAuU4mwF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740483075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=amu6qNJ2XLnE1PzLc9Jh3MOyLPKxqhaqigKuNJC2nTU=;
	b=BAuU4mwFFyQQo5LANcgQnZZzzO3DGucodasAnZm846hFNCRnGZfludpvM8Nq39k0O3bA2m
	v89YOZdfNoiNcfMl8PD6QlWM/m8pdfMlIp1Q7FlB2GcRkZOsY1H3thNgKBgzkVwHwcSWUk
	RijtBHlycow7b8aPy169mAfhla2YlVs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-upGo8e87OAKAGh8GDNse3w-1; Tue, 25 Feb 2025 06:31:14 -0500
X-MC-Unique: upGo8e87OAKAGh8GDNse3w-1
X-Mimecast-MFC-AGG-ID: upGo8e87OAKAGh8GDNse3w_1740483073
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f36fcf4b3so3398475f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740483073; x=1741087873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amu6qNJ2XLnE1PzLc9Jh3MOyLPKxqhaqigKuNJC2nTU=;
        b=SAkIZNeeMeM0VS16QPYfbLE07JPjirFSQuNdnsjvPuhv85CWV6flm9EIgi8Y3P/Ya6
         aQt0gPUb3H7Kv6cZzlzNpT3XjIU1h3DYh8Z0gWse0hhoNWNiF9R1mLQbeDt/+OjaFsXC
         Eu/pM4vMeiUj+V262i9pSndcV/qADERUQpg2TvVXv0eep3XnJABXG/JqotIW0Ed6uHed
         fiHQ1Ttd0wrRcafPagrdbK03E0Z4OuGXWxtPd4Pg4TWtBfYLHd0l83tNW0bY5fkqCN0Z
         dvhuG+Oc5uMk6iX7wOk3PFLroSJ3iZO0yVT4j3h3WHFOYN+ZrHmAoAWyzlWFpTp+3Xoy
         6twg==
X-Forwarded-Encrypted: i=1; AJvYcCXOM8Dan56jg0UqXmFVQoLkqnN0mKg/3AU3W9b51FaCnHEi4f4CGIL4p7VB6kSJyxERQEvbS40WAMyIm5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzifxs1JG1+YO71Y1lSGSShzi6RAM+9ymLdI0jZawyY9H2LemNx
	cvuKwW1mjzw7jrfZNwOc82y4VITnU6bAp94e2lHcY4aRHVUkfDqHsN/g6sE3S+90QAtHieVLWjy
	vi1dnBjXQK7QEN9ZKKRCR0YmyjUdRuDlqxXAK1PCKa9JiS+9Z7NKPeZ27KMLkYQ==
X-Gm-Gg: ASbGncv0GO0M8RyXpmuIRoN6SqCRcGOBGvPPLWJKIgDDa37oVT39bh+QP7un19TDah4
	kCjWy90RJ6Nx6XMCUf2hparBLVKc5XdWe/qHBV8E26Y56KB0FZe2aDK0eDlcJyxuygFIrqYAHtc
	yeTCONPqngh8rhy53+HYvrl4kkg0Rgdh7wL6I2paihIsCtqIRO4VbmFZLL1zrIPOLn8XV4u8/Zb
	moaPJ6k4vSHmH1rXfe+bm6d2svhL90vdwUJOMyfVFlNH9O3R2pgh5IisM+lC+V45BHGJq1Q/+wl
	MVkPwdaarrGuoUM=
X-Received: by 2002:a5d:584f:0:b0:38f:1e87:cc6e with SMTP id ffacd0b85a97d-38f6e74f270mr14234549f8f.9.1740483073110;
        Tue, 25 Feb 2025 03:31:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtz5zkAxf+n06y+uM0vFkhN66Z0eIXxRWu45tZA+nsHTF3VLjPSb93B6lqTibRPrNYImW8BA==
X-Received: by 2002:a5d:584f:0:b0:38f:1e87:cc6e with SMTP id ffacd0b85a97d-38f6e74f270mr14234497f8f.9.1740483072522;
        Tue, 25 Feb 2025 03:31:12 -0800 (PST)
Received: from sgarzare-redhat ([5.77.102.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd883934sm1996643f8f.59.2025.02.25.03.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:31:12 -0800 (PST)
Date: Tue, 25 Feb 2025 12:31:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
Message-ID: <6vadeadshznfijaugusnwqprssqirxjtbtpprvokdk6yvvo6br@5ngvuz7peqoz>
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
>+ *
>+ * When inherit_owner is set to 0:
>+ *   - The VHOST worker threads will use the traditional kernel thread (kthread)
>+ *     implementation, which may be preferred by older userspace applications that
>+ *     do not utilize the newer vhost_task concept.
>+ */
>+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)

I don't think we really care of the size of the parameter, so can we 
just use `bool` or `unsigned int` or `int` for this IOCTL?

As we did for other IOCTLs where we had to enable/disable something (e.g 
VHOST_VSOCK_SET_RUNNING, VHOST_VDPA_SET_VRING_ENABLE).

Thanks,
Stefano


