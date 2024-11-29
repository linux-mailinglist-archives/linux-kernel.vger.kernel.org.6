Return-Path: <linux-kernel+bounces-416510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 729929D461B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2017B2252C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78E014A60D;
	Thu, 21 Nov 2024 03:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vj87BFSE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66BA55C29
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732158598; cv=none; b=rggsuv0GTpxo2/KrW/wKKmb25/f+wbXGm01tqKPqPpoBF1/0w/kE0D16tEMbwfIjYZh4my9Rv65vuwcewl7G4tCqXkjyp9ws97Y38cvcAqwmULhvSxQhPMTPZgPyRAIvBTdTNjaE31iT7D5cAgZFgOlatF8jvOBJd0qnGtB7igY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732158598; c=relaxed/simple;
	bh=0H1m0NX8j7Q4v3rXNl3ISQx66VLYoAUVltruNmHwR78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLzWweaB28bR1J5a/Q/qKOZ5f/3VLzmATKrJHt7N+xEJaB6qM9U0cdIXAojVKzfmNtU93ELiRQFjIF8MJYQeHCcPfA9DeTFlotpVhs41369VqJVsAg4I7cN/bMNndv0HYpqf3bTceif8QgADY2U7woMyRk68d1hAIw6PgbNL4tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vj87BFSE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732158595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i7WppD/Sc+LMLfzM3iKsXvqQTAszek1AB3KYAwb4TXA=;
	b=Vj87BFSEM8DZulp97VQY4ELiBiMWYUVS0IBYN8fL/ouuq33i4nLXQvybeG0XtXu7ObmR3S
	0YW25voqsdraFLiY8r4ryPJjm2FtSFcHJjhGAJ4nusPvA4ixRMPcf7uoe2MX4Nh9eRfUwe
	TSdiOwZIts/xMEwf5l5XFqEhj841P1Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-PVOQQv3VNfO2ZHF52GjPdA-1; Wed,
 20 Nov 2024 22:09:52 -0500
X-MC-Unique: PVOQQv3VNfO2ZHF52GjPdA-1
X-Mimecast-MFC-AGG-ID: PVOQQv3VNfO2ZHF52GjPdA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A544219560A3;
	Thu, 21 Nov 2024 03:09:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.87])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D18430000DF;
	Thu, 21 Nov 2024 03:09:33 +0000 (UTC)
Date: Thu, 21 Nov 2024 11:09:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Garry <john.g.garry@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 4/8] blk-mq: introduce blk_mq_map_hw_queues
Message-ID: <Zz6kZ7QZV9HKSWVR@fedora>
References: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
 <20241115-refactor-blk-affinity-helpers-v5-4-c472afd84d9f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-refactor-blk-affinity-helpers-v5-4-c472afd84d9f@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Nov 15, 2024 at 05:37:48PM +0100, Daniel Wagner wrote:
> blk_mq_pci_map_queues and blk_mq_virtio_map_queues will create a CPU to
> hardware queue mapping based on affinity information. These two function
> share common code and only differ on how the affinity information is
> retrieved. Also, those functions are located in the block subsystem
> where it doesn't really fit in. They are virtio and pci subsystem
> specific.
> 
> Thus introduce provide a generic mapping function which uses the
> irq_get_affinity callback from bus_type.
> 
> Originally idea from Ming Lei <ming.lei@redhat.com>
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


