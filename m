Return-Path: <linux-kernel+bounces-308947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53712966426
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866D41C239A9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585AF1B253E;
	Fri, 30 Aug 2024 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ef87sS9u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCE91A287C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725028004; cv=none; b=eGBMRUmm9Ry0bhDadKsXIlG+PGOiV6/yhFFx9X9nbNrWhsakE0zG2r/Ik3JXi2rGfa4ZNVVdiSvuN/s90GzuUena3HC3Y/2QfX93/E0OfC8yCvuge7xtIPUITmiOcqMC8rZRgybtbiTwyN+Yr66CyW9LAt+RKQa0e3SEuWQi0Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725028004; c=relaxed/simple;
	bh=CA+5xZblNQYW35zLyyYrYa9TQOqlCs+1mMvIBKR1KRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5D3P+LMCzD7+uyistgenD+L23jRwGlIti2vs9zCdNFX3832PYzpZmJ6Xb6A59C92978PLsP5Tbp4Q4nQ3HSWV8FyCsMvjXoL3tiVjCXsXoGvtMIZPIQU/LTicsH6txMX1SfKmKQ1iIIL44oB1WBd/2G68M/3L1IMdri6XdBKQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ef87sS9u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725028002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8gbf0b2/ZuVUhqMwXNidR0owQ7FJQ8sNsGIOb0RlOMo=;
	b=Ef87sS9uMO5FvVv+zBuEB19iw+SSswZreRNEEc9jw8vIdANrOAYBufuEnLhOgwUHjoGMoS
	J5kxakMwDT+9h7wZYzal08mPMxOX5bWJKlWs8SpPyScuQ9PNPE4HeQ3W/Tya3gY9HjsCg/
	giQBYCwlSTE0HUGDJifsDwOgIy2EVy4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-r20Wsz3fOMqUlVvLXE-8iw-1; Fri,
 30 Aug 2024 10:26:36 -0400
X-MC-Unique: r20Wsz3fOMqUlVvLXE-8iw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDE181955D47;
	Fri, 30 Aug 2024 14:26:35 +0000 (UTC)
Received: from fedora (unknown [10.72.112.237])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3FD219560AE;
	Fri, 30 Aug 2024 14:26:31 +0000 (UTC)
Date: Fri, 30 Aug 2024 22:26:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Tero Kristo <tero.kristo@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [RFC PATCH 1/2] bdev: add support for CPU latency PM QoS tuning
Message-ID: <ZtHWkn2FJhAa+Vvo@fedora>
References: <20240829075423.1345042-1-tero.kristo@linux.intel.com>
 <20240829075423.1345042-2-tero.kristo@linux.intel.com>
 <e5e97bad-075a-4d78-af78-3bbc124c06b1@kernel.dk>
 <e38630e41353d083f7c0f4d726218aa5f3b36827.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e38630e41353d083f7c0f4d726218aa5f3b36827.camel@linux.intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Aug 30, 2024 at 02:55:56PM +0300, Tero Kristo wrote:
> On Thu, 2024-08-29 at 05:37 -0600, Jens Axboe wrote:
> > On 8/29/24 1:18 AM, Tero Kristo wrote:
> > > diff --git a/block/bio.c b/block/bio.c
> > > index e9e809a63c59..6c46d75345d7 100644
> > > --- a/block/bio.c
> > > +++ b/block/bio.c
> > > @@ -282,6 +282,8 @@ void bio_init(struct bio *bio, struct
> > > block_device *bdev, struct bio_vec *table,
> > >  	bio->bi_max_vecs = max_vecs;
> > >  	bio->bi_io_vec = table;
> > >  	bio->bi_pool = NULL;
> > > +
> > > +	bdev_update_cpu_latency_pm_qos(bio->bi_bdev);
> > >  }
> > >  EXPORT_SYMBOL(bio_init);
> > 
> > This is entirely the wrong place to do this, presumably it should be
> > done at IO dispatch time, not when something initializes a bio.
> > 
> > And also feels like entirely the wrong way to go about this, adding
> > overhead to potentially each IO dispatch, of which there can be
> > millions
> > per second.
> 
> Any thoughts where it could/should be added?
> 
> I moved the bdev_* callback from bio_init to the below location and it
> seems to work also:
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3b4df8e5ac9e..d97a3a4252de 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2706,6 +2706,7 @@ static void __blk_mq_flush_plug_list(struct
> request_queue *q,
>  {
>         if (blk_queue_quiesced(q))
>                 return;
> +       bdev_update_cpu_latency_pm_qos(q->disk->part0);
>         q->mq_ops->queue_rqs(&plug->mq_list);

IO submission CPU may not be same with the completion CPU, so this
approach looks wrong.

What you are trying to do is to avoid IO completion CPU to enter
deep idle in case of inflight block IOs.

Only fast device cares this CPU latency, maybe you just need to call
some generic helper in driver(NVMe), and you may have to figure out
the exact IO completion CPU for hardware queue with inflight IOs.

Thanks,
Ming


