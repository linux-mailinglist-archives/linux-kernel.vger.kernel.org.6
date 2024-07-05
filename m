Return-Path: <linux-kernel+bounces-242430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F28FC9287F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E50D1C22087
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24691494C9;
	Fri,  5 Jul 2024 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hr8g2iY7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727786A039
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179062; cv=none; b=Zxn1Y4n3iLGn03uFoGOC0T7Vro2f2yJdekOwZxevB8RwDJwOWK5XzR/YksmaglKKxdVIC/+UNsY6/x3TKHU90QiwKgev3e2wlQ9AxHn5+y6s2YCAJZrHTPLgF3Q1FRaNFy2GD6Mw9BE70vfB2xMwsLQYDWUGFi8gYLGEaJ1UaV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179062; c=relaxed/simple;
	bh=onBN9KO+lIzsFEQ/fDXx61eO24M3dMCZ/svot/VNlGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1JVgNpqnIINrYn2kF6WYgRtok0LKWuM7Jr+J9jE1rOGCeKlZzjlAIZ8FwqKvOqiFsZwpf99cW8mpaMdr3kVx0fNPXESCQqtFr5ScwDY/TJWQcoR7jsR9T6cDYcAuWBCNiHHeQGuMcWI/s4k1DQV8TYgzpJT8eKxsUqvw4ixdrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hr8g2iY7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720179059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wSxPxNWjmfmCaCrv5YXNN9JRGPE4XS8LqrwWBh6MCYo=;
	b=hr8g2iY7+cifeqqGqf5cBceQJ3HE4Le8CxI6pBuwfJwVc4qHWCvWSL/QbBkUCJrLXFdOJG
	wn+D39kLDeU68sx/wL9wJ6Nc/lp4c6/5Fbr0PFcpsLyx+H491LAi07JAJjjwcNYTwQFdob
	C1yw3JL+nC13yPofEfGdSucXXUNN6ms=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-IJYZQv7ENh-3kL0_w59zFQ-1; Fri, 05 Jul 2024 07:30:57 -0400
X-MC-Unique: IJYZQv7ENh-3kL0_w59zFQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-367af2cd5f3so202055f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 04:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720179057; x=1720783857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSxPxNWjmfmCaCrv5YXNN9JRGPE4XS8LqrwWBh6MCYo=;
        b=BlaZTgsG8VSRCy5AKPExWIx/FFBHSrVF+iwZDsrKNt6WTqb6UfWOJWdfIzFly6t1ww
         s3QVO5V6Bf/JgYex4PBDDWfUhx8neOcphkf05LwcNjhMcTXZZTx+0JnrjGlcluLoehc2
         Hav8We9WPSFXjD+Po3eI8yFdQezL9lwRLA3dtRapyDXmC6FlwkY8Exnby08OhiNYVSzM
         KdtjTlX5lMFQYwrttfrHl19RZM4NfdHk1xbYEJWWK7CfL3zXZq/fYmTEZWo63sSA1AF1
         mWEap4uLN/cVvtpNPim2NTjsL9Kx894IXYmnSR8CsUI0T9KWGC1pxlPeWOOVSfrBt3v/
         RN5A==
X-Forwarded-Encrypted: i=1; AJvYcCWM5mnmuJ4g5kgv7goOfqEbkm2bY3FCiwC/Xto/GedLlyp4wUWSK5lpjw4OXT8lwyw3dt9deIP+oPdW8zetx7fGUQHru4V24qYttVEM
X-Gm-Message-State: AOJu0YybZD5PaQx1Q5prrT0yK3g804gfCSg0+X6gzelpdRZXGWqVZ7Em
	ZoRlt+jhVZJi3MPpoFBWaW9ykznxF5nUloMWPdY7e21uqRUtKFJkJR31ogOXkttd5GEn33EnfXf
	Qetz6uS0YTrWV8guAzZTk+AWR4il66jsM6dtKB4cDMrWaqHAHwUo0iIx0WkA7sg==
X-Received: by 2002:adf:a1cf:0:b0:367:97fd:1d75 with SMTP id ffacd0b85a97d-3679dd441e5mr3036741f8f.27.1720179056804;
        Fri, 05 Jul 2024 04:30:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYIskuxCgnnQ5o9Ei3vPbmfJwvs58n/dENLo/BzbYNqk6AfWrjE+2qFmWCJOxsQfv7sAPixA==
X-Received: by 2002:adf:a1cf:0:b0:367:97fd:1d75 with SMTP id ffacd0b85a97d-3679dd441e5mr3036708f8f.27.1720179056067;
        Fri, 05 Jul 2024 04:30:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:1b5b:ac5c:b82e:a18c:2c6e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36788e37b53sm9113952f8f.45.2024.07.05.04.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:30:55 -0700 (PDT)
Date: Fri, 5 Jul 2024 07:30:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH] vdpa_sim_blk: add `capacity` module parameter
Message-ID: <20240705073017-mutt-send-email-mst@kernel.org>
References: <20240705112821.144819-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705112821.144819-1-sgarzare@redhat.com>

On Fri, Jul 05, 2024 at 01:28:21PM +0200, Stefano Garzarella wrote:
> The vDPA block simulator always allocated a 128 MiB ram-disk, but some
> filesystems (e.g. XFS) may require larger minimum sizes (see
> https://issues.redhat.com/browse/RHEL-45951).
> 
> So to allow us to test these filesystems, let's add a module parameter
> to control the size of the simulated virtio-blk devices.
> The value is mapped directly to the `capacity` field of the virtio-blk
> configuration space, so it must be expressed in sector numbers of 512
> bytes.
> 
> The default value (0x40000) is the same as the previous value, so the
> behavior without setting `capacity` remains unchanged.
> 
> Before this patch or with this patch without setting `capacity`:
>   $ modprobe vdpa-sim-blk
>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
>   virtio_blk virtio6: 1/0/0 default/read/poll queues
>   virtio_blk virtio6: [vdb] 262144 512-byte logical blocks (134 MB/128 MiB)
> 
> After this patch:
>   $ modprobe vdpa-sim-blk capacity=614400
>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
>   virtio_blk virtio6: 1/0/0 default/read/poll queues
>   virtio_blk virtio6: [vdb] 614400 512-byte logical blocks (315 MB/300 MiB)
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

What a hack. Cindy was working on adding control over config
space, why can't that be used?

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> index b137f3679343..18f390149836 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -33,7 +33,6 @@
>  				 (1ULL << VIRTIO_BLK_F_DISCARD)  | \
>  				 (1ULL << VIRTIO_BLK_F_WRITE_ZEROES))
>  
> -#define VDPASIM_BLK_CAPACITY	0x40000
>  #define VDPASIM_BLK_SIZE_MAX	0x1000
>  #define VDPASIM_BLK_SEG_MAX	32
>  #define VDPASIM_BLK_DWZ_MAX_SECTORS UINT_MAX
> @@ -43,6 +42,10 @@
>  #define VDPASIM_BLK_AS_NUM	1
>  #define VDPASIM_BLK_GROUP_NUM	1
>  
> +static unsigned long capacity = 0x40000;
> +module_param(capacity, ulong, 0444);
> +MODULE_PARM_DESC(capacity, "virtio-blk device capacity (in 512-byte sectors)");
> +
>  struct vdpasim_blk {
>  	struct vdpasim vdpasim;
>  	void *buffer;
> @@ -79,10 +82,10 @@ static void vdpasim_blk_buffer_unlock(struct vdpasim_blk *blk)
>  static bool vdpasim_blk_check_range(struct vdpasim *vdpasim, u64 start_sector,
>  				    u64 num_sectors, u64 max_sectors)
>  {
> -	if (start_sector > VDPASIM_BLK_CAPACITY) {
> +	if (start_sector > capacity) {
>  		dev_dbg(&vdpasim->vdpa.dev,
> -			"starting sector exceeds the capacity - start: 0x%llx capacity: 0x%x\n",
> -			start_sector, VDPASIM_BLK_CAPACITY);
> +			"starting sector exceeds the capacity - start: 0x%llx capacity: 0x%lx\n",
> +			start_sector, capacity);
>  	}
>  
>  	if (num_sectors > max_sectors) {
> @@ -92,10 +95,10 @@ static bool vdpasim_blk_check_range(struct vdpasim *vdpasim, u64 start_sector,
>  		return false;
>  	}
>  
> -	if (num_sectors > VDPASIM_BLK_CAPACITY - start_sector) {
> +	if (num_sectors > capacity - start_sector) {
>  		dev_dbg(&vdpasim->vdpa.dev,
> -			"request exceeds the capacity - start: 0x%llx num: 0x%llx capacity: 0x%x\n",
> -			start_sector, num_sectors, VDPASIM_BLK_CAPACITY);
> +			"request exceeds the capacity - start: 0x%llx num: 0x%llx capacity: 0x%lx\n",
> +			start_sector, num_sectors, capacity);
>  		return false;
>  	}
>  
> @@ -369,7 +372,7 @@ static void vdpasim_blk_get_config(struct vdpasim *vdpasim, void *config)
>  
>  	memset(config, 0, sizeof(struct virtio_blk_config));
>  
> -	blk_config->capacity = cpu_to_vdpasim64(vdpasim, VDPASIM_BLK_CAPACITY);
> +	blk_config->capacity = cpu_to_vdpasim64(vdpasim, capacity);
>  	blk_config->size_max = cpu_to_vdpasim32(vdpasim, VDPASIM_BLK_SIZE_MAX);
>  	blk_config->seg_max = cpu_to_vdpasim32(vdpasim, VDPASIM_BLK_SEG_MAX);
>  	blk_config->num_queues = cpu_to_vdpasim16(vdpasim, VDPASIM_BLK_VQ_NUM);
> @@ -437,8 +440,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  	if (blk->shared_backend) {
>  		blk->buffer = shared_buffer;
>  	} else {
> -		blk->buffer = kvzalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
> -				       GFP_KERNEL);
> +		blk->buffer = kvzalloc(capacity << SECTOR_SHIFT, GFP_KERNEL);
>  		if (!blk->buffer) {
>  			ret = -ENOMEM;
>  			goto put_dev;
> @@ -495,8 +497,7 @@ static int __init vdpasim_blk_init(void)
>  		goto parent_err;
>  
>  	if (shared_backend) {
> -		shared_buffer = kvzalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
> -					 GFP_KERNEL);
> +		shared_buffer = kvzalloc(capacity << SECTOR_SHIFT, GFP_KERNEL);
>  		if (!shared_buffer) {
>  			ret = -ENOMEM;
>  			goto mgmt_dev_err;
> -- 
> 2.45.2


