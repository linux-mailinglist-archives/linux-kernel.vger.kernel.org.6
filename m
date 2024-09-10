Return-Path: <linux-kernel+bounces-322485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B1C97298A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC41B23C48
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB459178CE4;
	Tue, 10 Sep 2024 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEnfnFN9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD6013E02D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 06:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949771; cv=none; b=i/xlp2Dblv/DR8p1LH6ddTk8JGlxkXD2aGN61p5A84Hm51ZMZjG0rIWtmcfTyG1PsMxJKtXaqooAPy2dyOkzZjIG3hOktMU9b4vnAstesjlu3zTCO3RcXMAqLTRBBnr4QxRpXOCxbjqhIpqSNldYtoe+kaxG4x2j1BUmDqpKnag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949771; c=relaxed/simple;
	bh=xYE2j6hsQhcBJCANyatZ9d21NJz+/bdQZjeik81Edl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JErtA1EMFhqedu5orJn2jUUvV6Z65ky7891JkaYvp34sOtbgchPP9+fat4UUeDaxeXqIAXWH1TJ0DU4J2x3xdgdkl1GnOMPdJU0ujNHrsxq+xk/lMzzgK9GffhXKhaCwmi6Xa3jtH9Tuj3YqqXPKQly8WXY8BYikHjKVfK7Q0JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bEnfnFN9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725949768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=slRCTHzCCcQBwX+pPISbs1hQFnemuMhepgFBpAq56NA=;
	b=bEnfnFN9qZ+vHcCw1hf62xrw43EmQTnjDHGjBCGBDl0Wy4AEUQlgivFhNHPl0rVnAXJXDr
	8jKIMB6m98ei9knpDtRaF9/YRRNI5N3Ua8g9uDvUWyk39YWqICuDJEfBr4sJGU0Niir5Oo
	2XW5iZ9nca2Shyvs4Yg6KdWsS5IHNBg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-1px0sapiOGSLqt_nmORvbA-1; Tue, 10 Sep 2024 02:29:26 -0400
X-MC-Unique: 1px0sapiOGSLqt_nmORvbA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb9e14ab6so9037335e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 23:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725949765; x=1726554565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slRCTHzCCcQBwX+pPISbs1hQFnemuMhepgFBpAq56NA=;
        b=WbazxafqtAyZ1cr9PxNGoB8xCbHrx+VsmIthSy/Wq76fM0o1yyHe7Kkni9yAiVy7L6
         mlyWrbZXCM87c720OR6b6V1JRLyfzV37CBx/lUX2IOG91CxPrW/6LFb3djaiTp5JDBFN
         jS2OpeOcq+A5frZm9XPcLjmPHua/KQ3TauA3qSlr93+VHrhv/yoB9qWzpNugjXCqP3mQ
         qYVYk+zBsDX85MrE9ThV/bpc6XIiPi/lbeejCUBvaCViPzUF6PePWpil8daZAflAQXE4
         E9p1ZiG/ICud2vAVvYW4sk/izv90VtwJsrrlJHv1wwW/Gx/zvVELrXJS7uLL/3SPWJHL
         wRYw==
X-Forwarded-Encrypted: i=1; AJvYcCWn44LNObheN9G0YE3M9p/pske8+I3Ok0dvNRL/8q65Uw4tqS+1ZYrGvlHNX+OykEdF+mq3h6tc3I57MM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn5Uh7vshy8LEpn0XB4yZabvqygbYd1eFVD2qlme/i7OsHLtvG
	+cNc4JThSwRleysKgoEudMfOyBivv8PMg0x9TsxBeoVSbnD4b8OMCt/U2QTiAx+ciZnZeGQfchS
	6REtiWsk13gX0N0+HD1IgZobgLbBIAcyRvXiRflPp9MDXBzPX8XYCfq59lmrLYA==
X-Received: by 2002:a05:600c:1c10:b0:42c:bdb0:c61e with SMTP id 5b1f17b1804b1-42cbdb0c782mr14797385e9.13.1725949765342;
        Mon, 09 Sep 2024 23:29:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6kk2YzMvA4RngNvuADaIpUJvCPpWuMQGvfkxNqLt6NjTpt10YtpZLMbS8AlyZJ/UVPyyijQ==
X-Received: by 2002:a05:600c:1c10:b0:42c:bdb0:c61e with SMTP id 5b1f17b1804b1-42cbdb0c782mr14797045e9.13.1725949764207;
        Mon, 09 Sep 2024 23:29:24 -0700 (PDT)
Received: from redhat.com ([31.187.78.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb323f4sm99266095e9.12.2024.09.09.23.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 23:29:23 -0700 (PDT)
Date: Tue, 10 Sep 2024 02:29:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: dtatulea@nvidia.com, jasowang@redhat.com, shannon.nelson@amd.com,
	sashal@kernel.org, alvaro.karsz@solid-run.com,
	christophe.jaillet@wanadoo.fr, steven.sistare@oracle.com,
	bilbao@vt.edu, xuanzhuo@linux.alibaba.com, johnah.palmer@oracle.com,
	eperezma@redhat.com, cratiu@nvidia.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Carlos Bilbao <cbilbao@digitalocean.com>
Subject: Re: [PATCH v3 0/2] Properly initialize speed/duplex and remove vDPA
 config updates
Message-ID: <20240910022843-mutt-send-email-mst@kernel.org>
References: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>

On Wed, Sep 04, 2024 at 10:11:13AM -0500, Carlos Bilbao wrote:
> From: Carlos Bilbao <cbilbao@digitalocean.com>
> 
> Initialize speed and duplex for virtio_net_config to UNKNOWN (mlx5_vdpa
> vDPA devices currently do not support VIRTIO_NET_F_SPEED_DUPLEX). Remove
> ioctl VHOST_VDPA_SET_CONFIG and its related logic as it is not supported;
> see: https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html
> 
> Carlos:
>   vdpa/mlx5: Set speed and duplex of vDPA devices to UNKNOWN
>   vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec compliance

This will need a rebase. Will apply once you post one.
Thanks!

> ---
> 
> Changes since v1:
>  Link: https://lkml.org/lkml/2024/8/29/1368
>  - Fix prefix of the first commit and add Reviewed-By tag.
>  - Redo second commit completely: instead of attempting to add support to
>    set configuration fields, remove ioctl and support entirely from vDPA
>    implementations -- because it's not allowed by spec.
> 
> Changes since v2:
>  Link: https://lkml.org/lkml/2024/9/3/1407
>  - Fix first commit by changing 4 spaces for a tab.
>  - In second commit, ENI is legacy and should keep set_config(). Change it
>    to set_config_legacy() to avoid future confusion and erroneous
>    implementations.
> 
> ---
>  drivers/vdpa/alibaba/eni_vdpa.c    |  2 +-
>  drivers/vdpa/ifcvf/ifcvf_main.c    | 10 ----------
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 19 ++++++++++++-------
>  drivers/vdpa/pds/vdpa_dev.c        | 16 ----------------
>  drivers/vdpa/solidrun/snet_main.c  | 18 ------------------
>  drivers/vdpa/vdpa.c                | 16 ----------------
>  drivers/vdpa/vdpa_sim/vdpa_sim.c   | 16 ----------------
>  drivers/vdpa/vdpa_sim/vdpa_sim.h   |  1 -
>  drivers/vdpa/vdpa_user/vduse_dev.c |  7 -------
>  drivers/vdpa/virtio_pci/vp_vdpa.c  | 14 --------------
>  drivers/vhost/vdpa.c               | 26 --------------------------
>  drivers/virtio/virtio_vdpa.c       |  9 ---------
>  include/linux/vdpa.h               |  7 ++++---
>  include/uapi/linux/vhost.h         |  8 ++++----
>  14 files changed, 21 insertions(+), 148 deletions(-)


