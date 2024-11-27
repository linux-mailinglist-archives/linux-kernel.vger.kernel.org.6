Return-Path: <linux-kernel+bounces-423178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C29EC9DA3F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0C8164E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82CF18CBFE;
	Wed, 27 Nov 2024 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOc38dii"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E34148832
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732696250; cv=none; b=smagFGj48K2BjbhL4d2Qh/aUWNpeOycyV6ASpEjFEC5uRqLYFwPBBxjtl+qpZ3kpDUS+hKL8qoa5YW3ZmVESrkP+EZKjx04bQeEMlJ/rR7ZvxowyYbD9E+lT7VZG5/cModQPalSALkHJ/Z0ekeu4kr4I2st2p9lFUWsbxL48hnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732696250; c=relaxed/simple;
	bh=Eoz0Q8Mkl/Pr7C3Gb8h9/rvKIVaHswPcRREVkWgCHFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aek4/VKnd5zkcPd9QIRKzo9n5fxE/p9UbWyz2jyHMxBcd5QBbMKDU6zA6YFzwYoN6M218cycjBcx2gsxYI4vrNJu26NnqIaHHounj+YJnl5TkxKc1UxM3pq1+Qc1hxENf5ikmS2OeA0SvJQCHTmwTxWdB4YGpspna4dunMVla4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GOc38dii; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732696247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4MUFVXWBRckkMqy36xXoK5Hu73zQLVLWkWdXnXLcAfI=;
	b=GOc38diim1rsdgIwrNU68kOakEz33NPfBZ+7Zk1f3qLFBlTMZpCaH8wzJ1W/ynxm+wlZQI
	7SSnLPNHYlLTtrqAuGsA3q6zWWG9GpMvFXsJaYFJc+qRh0Z6L2Oa/MNqZP0MkEAmW6mUjQ
	E+GTJOdyWS9fNs/0ZQFL07n9tLy3vkQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-B3JS6U35Pqyl2VzJ2FgJ7g-1; Wed, 27 Nov 2024 03:30:45 -0500
X-MC-Unique: B3JS6U35Pqyl2VzJ2FgJ7g-1
X-Mimecast-MFC-AGG-ID: B3JS6U35Pqyl2VzJ2FgJ7g
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4349eeeb841so24679355e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 00:30:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732696244; x=1733301044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MUFVXWBRckkMqy36xXoK5Hu73zQLVLWkWdXnXLcAfI=;
        b=TY744gh6OYicASfNO2qatZRyq/FrUmyxWKEWKAY/l4cFkEENQpGbUr6mjhlnP9btDC
         z11J6m9nZv33ZAh0m9NE2sH0hQvP9iSjUG3iUsYk9IHtRzCk+OnzgOfRv0AV3ZlM2BYo
         eYhMAOuNHXHmiEvjGrq45FP54J6voT5L5W7HnmjX95vayD5B/7vv0zIKwR3H+PZpNG54
         46WqAI6Ph2r9IckiaP+fttXjClgWX/q2UBmfQ1rXTzYrhMJYdTbB3+9pRmyJXZ8KJUA2
         eCxia9O6pPyG/nM+TJmdAFP4gVpeEBOmz0SIqt3MLlvuQt2xcSOCVN4Zjrokpul5cCPA
         eObg==
X-Forwarded-Encrypted: i=1; AJvYcCVml1fNKFsHEekRXM4hUT3zRj2DdQp42ctlaNSFdX+zJs//PaTIrrN4v2Iix/Ir3bjPvX0AhzL0Kln647U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoIM5LT4DYZisYbqx1kBk1J1csCdOEsbQPiKlsralDRr9YBK5H
	aAJO0NrUptGRmm/CSQqNUj19hOOfqzjREEO1c+EeThHu5mIsT/s1Rrj2CY434SyjDCdaaZqtKhW
	qlGC9Gk/ZPHBQyhE0uGmKOv9TX6CpZqZx4HphIHVSGhgfT8KM4QR9USDctjBwDg==
X-Gm-Gg: ASbGnct5C7Az8Vit9kwwZqyoPxVms+0pFDu5PW/6yyQl9JT7ohl/L05BRwBCiUtWHrR
	+7Uscp6SeGEkrJTRnuS8FDneOiGScZtSwuzFPDXEI01oUp6ecr5PtfMWy+3D7YtcKgiR7OZeag/
	i2i0y8AyDlYZHEVyKo10G8f2QIDZrj9CRJPp0HuU4TKn0f3NDyJNq/bYYSvriUHj3Emalgo++Vu
	dpEeb3tftanAt2u9YoheymKegQzJSCTn/sVctZXWhJ1
X-Received: by 2002:a05:600c:198c:b0:434:a386:6ae with SMTP id 5b1f17b1804b1-434a9db7cf7mr17738075e9.7.1732696244295;
        Wed, 27 Nov 2024 00:30:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2ADNx1yo7XqVN38+hjrq+uT0dwvOn8CIAZOqDBS7VnrgJbvD/98tIaKuZzdGb8T2i4UE1fg==
X-Received: by 2002:a05:600c:198c:b0:434:a386:6ae with SMTP id 5b1f17b1804b1-434a9db7cf7mr17737925e9.7.1732696243978;
        Wed, 27 Nov 2024 00:30:43 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f6:a902:b9b1:2d24:8c60:30dd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74ea95sm13552115e9.5.2024.11.27.00.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 00:30:43 -0800 (PST)
Date: Wed, 27 Nov 2024 03:30:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	colin.i.king@gmail.com, dtatulea@nvidia.com, eperezma@redhat.com,
	huangwenyu1998@gmail.com, jasowang@redhat.com, mgurtovoy@nvidia.com,
	philipchen@chromium.org, si-wei.liu@oracle.com
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
Message-ID: <20241127032948-mutt-send-email-mst@kernel.org>
References: <20241126163144-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126163144-mutt-send-email-mst@kernel.org>

On Tue, Nov 26, 2024 at 04:31:51PM -0500, Michael S. Tsirkin wrote:
> 
> I was hoping to get vhost threading compat fixes in but no luck.
> A very quiet merge cycle - I guess it's a sign we got a lot merged
> last time, and everyone is busy testing. Right, guys?

You will get a merge conflict with net, resolution is here:

https://lore.kernel.org/all/20241118172605.19ee6f25@canb.auug.org.au/


> The following changes since commit 83e445e64f48bdae3f25013e788fcf592f142576:
> 
>   vdpa/mlx5: Fix error path during device add (2024-11-07 16:51:16 -0500)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> for you to fetch changes up to 6a39bb15b3d1c355ab198d41f9590379d734f0bb:
> 
>   virtio_vdpa: remove redundant check on desc (2024-11-12 18:07:46 -0500)
> 
> ----------------------------------------------------------------
> virtio: features, fixes, cleanups
> 
> A small number of improvements all over the place.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Colin Ian King (1):
>       virtio_vdpa: remove redundant check on desc
> 
> Max Gurtovoy (2):
>       virtio_fs: add informative log for new tag discovery
>       virtio_fs: store actual queue index in mq_map
> 
> Philip Chen (1):
>       virtio_pmem: Add freeze/restore callbacks
> 
> Si-Wei Liu (2):
>       vdpa/mlx5: Fix PA offset with unaligned starting iotlb map
>       vdpa/mlx5: Fix suboptimal range on iotlb iteration
> 
> Wenyu Huang (1):
>       virtio: Make vring_new_virtqueue support packed vring
> 
>  drivers/nvdimm/virtio_pmem.c |  24 +++++
>  drivers/vdpa/mlx5/core/mr.c  |  12 +--
>  drivers/virtio/virtio_ring.c | 227 +++++++++++++++++++++++--------------------
>  drivers/virtio/virtio_vdpa.c |   3 +-
>  fs/fuse/virtio_fs.c          |  13 +--
>  5 files changed, 159 insertions(+), 120 deletions(-)


