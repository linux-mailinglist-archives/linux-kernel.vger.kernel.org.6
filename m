Return-Path: <linux-kernel+bounces-353419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC70992D87
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30EE3B20C00
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85FB1D414B;
	Mon,  7 Oct 2024 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvYcFzx9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8971D1E6A
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308272; cv=none; b=fegWvgHZeWukMjjxl3+7TPLH7m2czOQAxYP34rpWVABHIVKcjfRFR8m+SzSoFPm3nV2wkyMcB82IcPSikSW9Fr3m2BxCBkam4fUeeDAHBsm/TIHZ5Eo65rA+sxGebuQU7qKCygxoGQC+WuaDhzfZXv75MN6/iMufI+dL2ErVkGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308272; c=relaxed/simple;
	bh=hB2s2lfcHmnZyQnBQtcYGPUu92PIitX04lRdk6K+6i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeDGuKBu7rCJnV1IOp/Fpc6s1AJ8uwfYtupccbbTDNkZHGaZK7iTRMgohjNYBcGOzh5vZXJ89mKJnERjc1K/UPoJefO6FIHNEc2ozjoOztRHDMoScGt/OLlRBPaMCznocu5K3f1GvRoC4zzJt5xJd/VjWV7PXjlILkwok1D9/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YvYcFzx9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728308269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u55VIzbnsDYZ6+urjTeBn/sPe+UeOPYjNBp44UJwta4=;
	b=YvYcFzx9rNXsonIE5/Mf3mPHhQZ/iEAaFtruB0XVcCKuLNEVsbN4li14cL4f3minWhaOAL
	i+5FlqPIffQQDEiEsmpYaDmb3VoH/R4Qx72uzNNH4V0w1Q3dmi1DHjCwYZy8dpZTvEOh3G
	F92XsWVBvelwVvKkcYZ7Xew0bGXsb44=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-iuPoVAo3P0WYVWdlx_vpSQ-1; Mon, 07 Oct 2024 09:37:48 -0400
X-MC-Unique: iuPoVAo3P0WYVWdlx_vpSQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a1a969fabfso56033695ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728308268; x=1728913068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u55VIzbnsDYZ6+urjTeBn/sPe+UeOPYjNBp44UJwta4=;
        b=m50ERu/toI/+hxuBKDBr6Aof333nLdelDJQWALwKfyeZQbgE1jiEJk0FN+xaZ58eUt
         L8JH7hIJ5NWzGL2fDIIA8GKEzXKp5lmKOwZsHmJy8mDZXLUrqPVbt87NaS585zA0so1e
         ArMxZa4qdsrkWT80ZKnglMcPVHS1nDSBfFF4eCW/L/YBFqKny4LxWLzjm6RLIJ58ibaE
         Aet66kh1vUiDzR+50Ykv+ZpegkwQd8B6Vk7fwVSctn+ZS2sAyCwvjDX3dAgp256zX4fF
         +NEsUKdPV5OeGp77RLj1Sicwh73U9/4XRIh3p6CvjgMvSXzPRIwKnaC4xIdw6wQFUaUN
         OI3w==
X-Forwarded-Encrypted: i=1; AJvYcCVV4udU3rnFwokZyjg3C7WnrVY1uqC4LudB/v0Dfp9DqTjqARIytatf/vn7D15zPL+Ea1uZH4mo0D86h+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0aXiDQbe65EpYvRoMxGLms8FRqaO2ZG//C2+V2WjTxsGmwGUc
	QLOyKEFQqCkXoNckup/tpVQ1QiXKyW0WnTDjlEQ3Wiejv3WPOkWhzX+wACS9ptijo2uy3LUUQJp
	paM7lf9Rdp61uQ10eIMuKVCDJnkzVyVsM6azvb1tLJXdRLR7JvTDfeYl++zbQOiTFyXvg9ZeW
X-Received: by 2002:a92:cd82:0:b0:3a0:9952:5fcb with SMTP id e9e14a558f8ab-3a375bb6652mr104129055ab.17.1728308267896;
        Mon, 07 Oct 2024 06:37:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY4DVSl0pKaQLg5oB3Cu7qBASwkdVyLfgME8TrpLYdIQrARbPLldNRPAtt7pwFAXQQCbp5QA==
X-Received: by 2002:a92:cd82:0:b0:3a0:9952:5fcb with SMTP id e9e14a558f8ab-3a375bb6652mr104128765ab.17.1728308267474;
        Mon, 07 Oct 2024 06:37:47 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db8479ff8fsm566559173.2.2024.10.07.06.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:37:47 -0700 (PDT)
Date: Mon, 7 Oct 2024 15:37:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 7/7] vhost: Add new UAPI to support change to task mode
Message-ID: <trrpnhe3qahveeizjlwfp33thudcw5jcmh3uunllucgur4txub@gm2k3p4sx6in>
References: <20241004015937.2286459-1-lulu@redhat.com>
 <20241004015937.2286459-8-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241004015937.2286459-8-lulu@redhat.com>

On Fri, Oct 04, 2024 at 09:58:21AM GMT, Cindy Lu wrote:
>Add a new UAPI to support setting the vhost device to
>use task mode. The user space application needs to use
>VHOST_SET_INHERIT_FROM_OWNER to set the mode.
>This setting must be set before VHOST_SET_OWNER is set.

Why?

>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c      | 18 +++++++++++++++++-
> include/uapi/linux/vhost.h |  2 ++
> 2 files changed, 19 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 08c9e77916ca..0e5c81026acd 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -2341,8 +2341,24 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> {
> 	struct eventfd_ctx *ctx;
> 	u64 p;
>-	long r;
>+	long r = 0;
> 	int i, fd;
>+	bool inherit_owner;
              ^
              This can be moved ...
>+
>+	if (ioctl == VHOST_SET_INHERIT_FROM_OWNER) {

                 ^
                 ... here.

>+		/* Is there an owner already? */

This comment is superfluous, I would instead explain why there has to be 
an owner, what problem would we have if not?

>+		if (vhost_dev_has_owner(d)) {
>+			r = -EBUSY;
>+			goto done;
>+		}
>+		if (copy_from_user(&inherit_owner, argp,
>+				   sizeof(inherit_owner))) {
>+			r = -EFAULT;
>+			goto done;
>+		}
>+		enforce_inherit_owner = inherit_owner;

mmmm, I'm confused.

IIUC with this change, an user, for example, can call 
VHOST_SET_INHERIT_FROM_OWNER on /dev/vhost-vsock and change the 
behaviour of /dev/vhost-net.

Is that really what we want?

Maybe it's better if the module parameter controls the default of any 
device, but the ioctl changes the behavior only for that device.

>+		goto done;
>+	}
>
> 	/* If you are not the owner, you can become one */
> 	if (ioctl == VHOST_SET_OWNER) {
>diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>index b95dd84eef2d..1e192038633d 100644
>--- a/include/uapi/linux/vhost.h
>+++ b/include/uapi/linux/vhost.h
>@@ -235,4 +235,6 @@
>  */
> #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
> 					      struct vhost_vring_state)
>+

Please, add documentation here.

>+#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, bool)
                                        ^
                                        Please, add a tab like we did
                                        for all previous definitions.

Thanks,
Stefano


