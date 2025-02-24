Return-Path: <linux-kernel+bounces-530121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65017A42F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 477617AA346
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977141E0DE4;
	Mon, 24 Feb 2025 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlsEwGfx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB831D6187
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433393; cv=none; b=RV39KXWPsoxoMFtvCMfjSTCPOXx2AGOxT9nDVuwsnq3tw1bzPJtyyW+lBbReT5YerlFKGONU23x7p1USDP6lmdmSbGMqm6p3fyd0adQG59JChxz/Q+SXOy3kOMku25wquxOThpt6sbMXLgFLPWJwB9FDYlu4+9WPEbiTqRTgmQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433393; c=relaxed/simple;
	bh=rGCaM38jYnJVXBwmgw8Sh7VmVvIrDfJq+EHfQSyCLRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXDlAw7mDjQQS+8+qFu5V9JDCD+N3W0AtHQBfhE2x9yBEa9J7vhxWQgqazjnP9P5EPd0PykpXU4i1gAg4GAN1bSSBIa4o95BJhCp1mInqr2asA0bBORasOg8IQIExMIh2Au+F8HiPUtyWDhG6+x3LvUiTDbYaWow2DzxDBFcEhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UlsEwGfx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740433390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eRvlyIwfIErpAyFrGoq863D4eRcM+k3YszciGmJ1mwo=;
	b=UlsEwGfx0P6BfJrnof8mG5mFQQRWFELak9NgzsuG+wkCuMrNEvNhmB8wesjZMQ0E37SKv4
	jSyRn+xyVAja/RaAXfjO8I2azB0iZZZ6d8/eaxeLWGHMnp8ZJrCCemzAmzed1+zB5q5D0F
	/M0+P7kH0ykyCy0mHED/eFidEo3L8lM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-mFBxkSiaMsSWelnDqBXjvg-1; Mon, 24 Feb 2025 16:43:08 -0500
X-MC-Unique: mFBxkSiaMsSWelnDqBXjvg-1
X-Mimecast-MFC-AGG-ID: mFBxkSiaMsSWelnDqBXjvg_1740433388
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e08dfe2283so4417548a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433388; x=1741038188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRvlyIwfIErpAyFrGoq863D4eRcM+k3YszciGmJ1mwo=;
        b=Lab4npdnNZOYylvKGvRs0Mtcc7d092+NAYJuzPG42Nw+qUKk9kHp3ptg4XBY1LQSPw
         RJLALx0xtOJezSxSlRsjALiN4yeij/aWMFssmGYGwXHB7SeAhxo+i+oerNFdxgjDwBiw
         bZdKJhMBRaH19mpDXEZZMYbqfX5hWx7YmHm51yk1Tiq6uXPIZBMLxTy1Zu55ZvuMKD0y
         A7QJA/qJFQUSIuxyc4F+gG+0yKrvHkKqRsEvdfiklswBMYu5uEe5qgxwdRYsJetYkB04
         I5mmslWUxV9xb9P7S+imeGNG1P8qjBbt9TF/c03OCd23yugWJOP7KVdH9ayPvQLluZUS
         OqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmuNFh9QRNvPwRJpK3YC4g/A2hIdfjTcGY9s8Z7QVNU5v94qBNdv1IAnmKJsFLxsPUD4b++Zce1jAv40U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9HNDbgaYzdsVUxMMAJWQO9L4lP0jCftmMDNkR+G7LUaIAtz+X
	dv9jWq/AgX3pSZT1lM3FDpP8RFBZrxS/GDEIizpzIg55mnGypGmAKoQWQIcNAmIaan/zPbQEEQA
	KxOOf+IhIzvf6tpTq9vT8VEtoVNLsxbIyik+yDQt4j+z5z201Weha2uyp9PTEKw==
X-Gm-Gg: ASbGnctRiqMqtT71Z/LlGhbkaodYyuDVgmgBRoQvV/tGTogPhaKdYuW2FE2T5Fs1voT
	T82ZFlY9eZXYL2mTe33HIPyVsV2MuyiNUYgKsP9QPVDZD/qVKubNZ2znAjfyY7OLWxN+Yjaz7o0
	6+AT+i2zbF3H5Dfd+kh1EMbE25wbwFeiFEmIy4rp7lBFHe4dQO2jKFmFxA13oRrieyN43q/Jedb
	aFxaC/ByECwgxHoRVuUn/rXObfAenhs707lFgtrhzWGUwPbQC+8NydGy7taDmGFaj2pnJIm8vtJ
	gAG5kfN8zg==
X-Received: by 2002:a05:6402:2684:b0:5e0:49e4:2180 with SMTP id 4fb4d7f45d1cf-5e44a256c8dmr1414778a12.25.1740433387666;
        Mon, 24 Feb 2025 13:43:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFggkY3qckFwg+3BfU9CiVPo7fKtfcLRWbW/4aTirrRH/YEvcpVLH1Iwi+Ay7RISwY3EepFrw==
X-Received: by 2002:a05:6402:2684:b0:5e0:49e4:2180 with SMTP id 4fb4d7f45d1cf-5e44a256c8dmr1414733a12.25.1740433387287;
        Mon, 24 Feb 2025 13:43:07 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:441:1929:22c5:4595:d9bc:489e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1a01648sm29278766b.0.2025.02.24.13.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:43:06 -0800 (PST)
Date: Mon, 24 Feb 2025 16:43:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 0/6] vhost: Add support of kthread API
Message-ID: <20250224164233-mutt-send-email-mst@kernel.org>
References: <20250223154042.556001-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223154042.556001-1-lulu@redhat.com>

On Sun, Feb 23, 2025 at 11:36:15PM +0800, Cindy Lu wrote:
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),   
> the vhost now uses vhost_task and operates as a child of the   
> owner thread. This aligns with containerization principles.   
> However, this change has caused confusion for some legacy   
> userspace applications. Therefore, we are reintroducing   
> support for the kthread API.  


This looks good to me.

Pls address Jason's comments and add a Kconfig knob, and I will apply/

> In this series, a new UAPI is implemented to allow   
> userspace applications to configure their thread mode. 
> 
> Changelog v2:
>  1. Change the module_param's name to enforce_inherit_owner, and the default value is true.
>  2. Change the UAPI's name to VHOST_SET_INHERIT_FROM_OWNER.
>  
> Changelog v3:
>  1. Change the module_param's name to inherit_owner_default, and the default value is true.
>  2. Add a structure for task function; the worker will select a different mode based on the value inherit_owner.
>  3. device will have their own inherit_owner in struct vhost_dev
>  4. Address other comments
> 
> Changelog v4: 
>  1. remove the module_param, only keep the UAPI
>  2. remove the structure for task function; change to use the function pointer in vhost_worker
>  3. fix the issue in vhost_worker_create and vhost_dev_ioctl
>  4. Address other comments
> 
> Changelog v5: 
>  1. Change wakeup and stop function pointers in struct vhost_worker to void.
>  2. merging patches 4, 5, 6 in a single patch
>  3. Fix spelling issues and address other comments.
>  
> Changelog v6: 
>  1. move the check of VHOST_NEW_WORKER from vhost_scsi to vhost
>  2. Change the ioctl name VHOST_SET_INHERIT_FROM_OWNER to VHOST_FORK_FROM_OWNER
>  3. reuse the function __vhost_worker_flush
>  4. use a ops sturct to support worker relates function
>  5. reset the value of inherit_owner in vhost_dev_reset_owner  
>  
> Tested with QEMU with kthread mode/task mode/kthread+task mode
> 
> Cindy Lu (6):
>   vhost: Add a new parameter in vhost_dev to allow user select kthread
>   vhost: Reintroduce vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: introduce worker ops to support multiple thread models
>   vhost: Add new UAPI to support change to task mode
>   vhost: Add check for inherit_owner status
> 
>  drivers/vhost/vhost.c      | 227 +++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h      |  13 +++
>  include/uapi/linux/vhost.h |  18 +++
>  3 files changed, 234 insertions(+), 24 deletions(-)
> 
> -- 
> 2.45.0


