Return-Path: <linux-kernel+bounces-416515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30559D4632
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A212280ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268C414A0AA;
	Thu, 21 Nov 2024 03:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/372t3Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968ED2309A9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 03:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732159178; cv=none; b=R+pbbcd9+ciJLHQp5Rqf5LCy/7cEIx4i4BzSGSE3Egq6kctP2vllD9TZExRGZHSArVJZ6fzRYH4ljtvaS6fso0HQcEm2uyT/Xu2jWY8GybCXAKHpc6Iuny6wpu275dVTq/DlpdFJpgKrVxzSPBnGrdHIYHQqNL7M4KGODsOfR5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732159178; c=relaxed/simple;
	bh=n6fse5WF/o+E6zikQyV1GpWdO7mrGYNnHHmaFBQqD1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ru3JGq4N2CgiBfF+VAII1v7y4A3jWSJ5ugBJlqbGHEP9p9aqcr2ERjOcOJFMeUSdlkNVgJqrIZtXxd6WbPGfPuLaq0gnb2nBIqThWU4zek8AhYrxhdJ0f9GjzoGP3HSP+HiY1CUOJBlHLDdZxvrzik5F0gOmfVaf9tKRA0DELPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/372t3Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732159175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AOXvI++XSTiWCp1ZxrfaodBptdhJkbFw4zlLYFWlGt0=;
	b=Y/372t3Z9cAY8cEbpbqWNsHLgVYvt3XsBF/JC7RzjRVlUtjgRGj/QwD+yxWa6NY/idpbqT
	jdLNqp3gqAdXDUTCarrW9RqA/0vNScgZ9OqRJbGT0hwbStjGNXshKfUP8v2iOCvsiz8fDD
	O0Ut9KhKwLUxBQQouGeZ7JFBH0sutw8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-9N4rdBEgPGqmul26ngHxlg-1; Wed,
 20 Nov 2024 22:19:34 -0500
X-MC-Unique: 9N4rdBEgPGqmul26ngHxlg-1
X-Mimecast-MFC-AGG-ID: 9N4rdBEgPGqmul26ngHxlg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D47419560B8;
	Thu, 21 Nov 2024 03:19:30 +0000 (UTC)
Received: from fedora (unknown [10.72.116.87])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 152C830000DF;
	Thu, 21 Nov 2024 03:19:16 +0000 (UTC)
Date: Thu, 21 Nov 2024 11:19:11 +0800
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
Subject: Re: [PATCH v5 8/8] blk-mq: remove unused queue mapping helpers
Message-ID: <Zz6mrxOumUrDfBRM@fedora>
References: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
 <20241115-refactor-blk-affinity-helpers-v5-8-c472afd84d9f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-refactor-blk-affinity-helpers-v5-8-c472afd84d9f@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Nov 15, 2024 at 05:37:52PM +0100, Daniel Wagner wrote:
> There are no users left of the pci and virtio queue mapping helpers.
> Thus remove them.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


