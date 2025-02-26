Return-Path: <linux-kernel+bounces-533381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CDEA45958
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3CBF7A1A69
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1E2224247;
	Wed, 26 Feb 2025 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYUcrSvh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D621E1DE8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560593; cv=none; b=oo7sJ1tL76zHGkkwD17Y6guhQcLXFf+M7GTZ9jszbwvPzevnVJl/Fme1gVOpT8Rb68mSbL/vbOga6go9kvx2XH/c+Qgw/ZixqYbtn5qSb5mme9b+SGi9oWMOSwIPhbakN+qCl6AmGkYTAvpn2xCzKIePjleSvchdwHdgoXLBkSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560593; c=relaxed/simple;
	bh=g6gLBFXvpEOgGJDjblXWCArBBdvpGNVPxWYKgaS04As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kd4w9VhWmRX3sB4Fdqkvz9D3Kz6B6MKTVKgpVrcecbYjMQ644J3p2ZIoE11wEsbpnWzMN7989lDVdOhtQDtSbqkUUG+w20EtnfqxG2SdCzY+oapRxIRqSs7VLgjD42tjdOyEkCNQ3WRupVNwjxlnBjByF5Q9/1J/2FWHiz7QciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PYUcrSvh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740560591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qi5HciIV3JUutET+RsOw0o6fA6bk9IwEPBCuSO3/i6w=;
	b=PYUcrSvh3Whc3pad+baUCaClVbgt7e19HEGVUtDSgkCQZjVDxOz4Twu5x/Z23kJAr7OhtX
	sUFjzHQhSWPOldz72DzVbxP8VSllfNEI6XarBKBaDB2ZO83cBs1pQakASves9a8Wa4GOx0
	npdfzzjvssvcb3rLBs4Q5RcoPORe21g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-Mur8Q0eWMhiS3zFD2U7vYQ-1; Wed, 26 Feb 2025 04:03:08 -0500
X-MC-Unique: Mur8Q0eWMhiS3zFD2U7vYQ-1
X-Mimecast-MFC-AGG-ID: Mur8Q0eWMhiS3zFD2U7vYQ_1740560588
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abba896add9so621961366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:03:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740560587; x=1741165387;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qi5HciIV3JUutET+RsOw0o6fA6bk9IwEPBCuSO3/i6w=;
        b=ishC2JKZL0ftlt8sWe41FyxuNBsiHqAvR88QNsC7Era7HFC1xtLqKBIXqpDboO/kWm
         9g/VjO7fsH0kKooJCnqAizUatZYZe8PA3eDeThM2L/4wtaFSHd/cV3MDY56Vhwhz/dJX
         wwNtLn1BYTLGv1PRnVZcTlTcahssCPrL5cmR1d+DBj17S7tDu9bMo1Kco+CmWxHWdsmF
         pmW0wfNamp2DqdBX1gJzAc/2OOQyPfpTSZHpZyWXse6zYlR8R1pKnf54+GU60nza3lJ/
         ntbuLZ1oh0DQqiN00AbgeKC37sOl9KjwN+87R1bUm+vwYa0o1jHY//K4413J+B5WCzpZ
         aeqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV43iS1U0xEoXw/rJ1AuZAAlKZRq+HVu9hJnuIj+zcbC76lz/anztN05dxmO7/DG5N24LGNd/5qp5BV12A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEF1NsyUuoqMDYGn0LTgetih10L8qZsvwV3WDJ0cvVIVANYYK5
	FfBg6V9Pw3WOOdZknfbdmmxtCUpgZmXxYE8xSLDMCPMrW6ZM4RiVtcpwS3dq/gQvfdvIo6THcfk
	oTN7bCsLUju93FCIk05wSIbDM/KLS01QFMUPb2xE/emZmhtGSSO2uK1Hmadd2YQ==
X-Gm-Gg: ASbGncurq0hy8zR4PTBk24URP+Z1ArGMBN0Vex+v7yDr2p6WZVn5pLk0xoUqnQB7EDo
	PFwwtkxhoVfM4vt71MaNTYrGZSsXcRNEfS83NqTZgKxGX1ZneIjXUEmc7dM7flF2JMlGn9npt4l
	ESoF0zBaU0vhRMZeMps2shEQw/AZnZP7GxHsHGMKYHy4ivhkyk+7GrYhjeixFrT5Dvd4633202T
	tn5YdJvfacC3p1YSg4tMo101SCksmcRgHGGjW6pPUllnj7GrO7uuqV4nanQ+rqadYON/ze5O+d2
	sChLNOXs7pD75IH6r8o=
X-Received: by 2002:a17:906:31c4:b0:aa6:6885:e2fa with SMTP id a640c23a62f3a-abc09a0772bmr1929048466b.14.1740560587266;
        Wed, 26 Feb 2025 01:03:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHINfbQ4wBoMreLCkELfzuU4I4j2q+Sul+AT/r/Jhkj+j3SVH2xhet7ld3h5p6Rb1LvmOnUiA==
X-Received: by 2002:a17:906:31c4:b0:aa6:6885:e2fa with SMTP id a640c23a62f3a-abc09a0772bmr1929039966b.14.1740560586548;
        Wed, 26 Feb 2025 01:03:06 -0800 (PST)
Received: from sgarzare-redhat ([5.179.186.222])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed201330csm287247066b.87.2025.02.26.01.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 01:03:05 -0800 (PST)
Date: Wed, 26 Feb 2025 10:02:57 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, 
	michael.christie@oracle.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
Message-ID: <CAGxU2F4b+P4ur16t_qDp-jdf5EJkbtraNFoO4XM3HP1RuOQxzg@mail.gmail.com>
References: <20250223154042.556001-1-lulu@redhat.com>
 <20250223154042.556001-6-lulu@redhat.com>
 <6vadeadshznfijaugusnwqprssqirxjtbtpprvokdk6yvvo6br@5ngvuz7peqoz>
 <CACLfguU8-F=i3N6cyouBxwneM1Fr0oNs9ac3+c5xoHr_zcZW6A@mail.gmail.com>
 <CAGxU2F7-UB+Jh41HkHKOqM+KNqSi2chEzVnFe9XAFmNun=0CTA@mail.gmail.com>
 <20250226035030-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226035030-mutt-send-email-mst@kernel.org>

On Wed, 26 Feb 2025 at 09:50, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Feb 26, 2025 at 09:46:06AM +0100, Stefano Garzarella wrote:
> > Hi Cindy,
> >
> > On Wed, 26 Feb 2025 at 07:14, Cindy Lu <lulu@redhat.com> wrote:
> > >
> > > On Tue, Feb 25, 2025 at 7:31 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > >
> > > > On Sun, Feb 23, 2025 at 11:36:20PM +0800, Cindy Lu wrote:
> > > > >Add a new UAPI to enable setting the vhost device to task mode.
> > > > >The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> > > > >to configure the mode if necessary.
> > > > >This setting must be applied before VHOST_SET_OWNER, as the worker
> > > > >will be created in the VHOST_SET_OWNER function
> > > > >
> > > > >Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > >---
> > > > > drivers/vhost/vhost.c      | 24 ++++++++++++++++++++++--
> > > > > include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> > > > > 2 files changed, 40 insertions(+), 2 deletions(-)
> > > > >
> > > > >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > >index d8c0ea118bb1..45d8f5c5bca9 100644
> > > > >--- a/drivers/vhost/vhost.c
> > > > >+++ b/drivers/vhost/vhost.c
> > > > >@@ -1133,7 +1133,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
> > > > >       int i;
> > > > >
> > > > >       vhost_dev_cleanup(dev);
> > > > >-
> > > > >+      dev->inherit_owner = true;
> > > > >       dev->umem = umem;
> > > > >       /* We don't need VQ locks below since vhost_dev_cleanup makes sure
> > > > >        * VQs aren't running.
> > > > >@@ -2278,15 +2278,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> > > > > {
> > > > >       struct eventfd_ctx *ctx;
> > > > >       u64 p;
> > > > >-      long r;
> > > > >+      long r = 0;
> > > > >       int i, fd;
> > > > >+      u8 inherit_owner;
> > > > >
> > > > >       /* If you are not the owner, you can become one */
> > > > >       if (ioctl == VHOST_SET_OWNER) {
> > > > >               r = vhost_dev_set_owner(d);
> > > > >               goto done;
> > > > >       }
> > > > >+      if (ioctl == VHOST_FORK_FROM_OWNER) {
> > > > >+              /*inherit_owner can only be modified before owner is set*/
> > > > >+              if (vhost_dev_has_owner(d)) {
> > > > >+                      r = -EBUSY;
> > > > >+                      goto done;
> > > > >+              }
> > > > >+              if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> > > > >+                      r = -EFAULT;
> > > > >+                      goto done;
> > > > >+              }
> > > > >+              /* Validate the inherit_owner value, ensuring it is either 0 or 1 */
> > > > >+              if (inherit_owner > 1) {
> > > > >+                      r = -EINVAL;
> > > > >+                      goto done;
> > > > >+              }
> > > > >+
> > > > >+              d->inherit_owner = (bool)inherit_owner;
> > > > >
> > > > >+              goto done;
> > > > >+      }
> > > > >       /* You must be the owner to do anything else */
> > > > >       r = vhost_dev_check_owner(d);
> > > > >       if (r)
> > > > >diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > > > >index b95dd84eef2d..8f558b433536 100644
> > > > >--- a/include/uapi/linux/vhost.h
> > > > >+++ b/include/uapi/linux/vhost.h
> > > > >@@ -235,4 +235,22 @@
> > > > >  */
> > > > > #define VHOST_VDPA_GET_VRING_SIZE     _IOWR(VHOST_VIRTIO, 0x82,       \
> > > > >                                             struct vhost_vring_state)
> > > > >+
> > > > >+/**
> > > > >+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device
> > > > >+ *
> > > > >+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
> > > > >+ *
> > > > >+ * When inherit_owner is set to 1:
> > > > >+ *   - The VHOST worker threads inherit its values/checks from
> > > > >+ *     the thread that owns the VHOST device, The vhost threads will
> > > > >+ *     be counted in the nproc rlimits.
> > > > >+ *
> > > > >+ * When inherit_owner is set to 0:
> > > > >+ *   - The VHOST worker threads will use the traditional kernel thread (kthread)
> > > > >+ *     implementation, which may be preferred by older userspace applications that
> > > > >+ *     do not utilize the newer vhost_task concept.
> > > > >+ */
> > > > >+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> > > >
> > > > I don't think we really care of the size of the parameter, so can we
> > > > just use `bool` or `unsigned int` or `int` for this IOCTL?
> > > >
> > > > As we did for other IOCTLs where we had to enable/disable something (e.g
> > > > VHOST_VSOCK_SET_RUNNING, VHOST_VDPA_SET_VRING_ENABLE).
> > > >
> > > hi Stefano
> > > I initially used it as a boolean, but during the code review, the
> > > maintainers considered it was unsuitable for the bool use as the
> >
> > I see, indeed I found only 1 case of bool:
> >
> > include/uapi/misc/xilinx_sdfec.h:#define XSDFEC_SET_BYPASS
> > _IOW(XSDFEC_MAGIC, 9, bool)
> >
> > > interface in ioctl (I think in version 3 ?). So I changed it to u8,
> > > then will check if this is 1/0 in ioctl and the u8 should be
> > > sufficient for us to use
> >
> > Okay, if Michael and Jason are happy with it, it's fine.
> > It just seemed strange to me that for other IOCTLs we use int or
> > unsigned int when we need a boolean instead of a sized type.
>
> I only found VHOST_VSOCK_SET_RUNNING. which other ioctls?

VHOST_VDPA_SET_VRING_ENABLE use the `struct vhost_vring_state` where we 
use the `unsigned int num` field as boolean, but I see that this is a 
special case where we re-use the same struct for multiple ioctls.

Thanks,
Stefano


