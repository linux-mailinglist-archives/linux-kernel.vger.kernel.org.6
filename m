Return-Path: <linux-kernel+bounces-379077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A329AD961
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4D61F23B94
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA7D4D8CB;
	Thu, 24 Oct 2024 01:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezb3LWD+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EDC2C9A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729734226; cv=none; b=tofqwJiXJVD3D/V3UftiP46nq+hOGjiFh3laVtnI81ia6Wc1LCb+4iyP285M0bEolcLcm4Bszy820a5anaenfyZBMB6ucnPu1YQ1psIl+fpxfu3gBId0Rgx8UXwbKPVqta+JJRXYFqv8lg5ciHoII4SE4Q75yZcq1veigQMkhZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729734226; c=relaxed/simple;
	bh=o4ltZnnlcUnByy0T3/h7zh9wMD/iuPy0Yb4VcqXcmAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mq8VxFIYRQf3tp4DvzVAWse5TPvdUfyoanRPcqufp7tVkVNlYaZvjqtJ0CKb0W6sdVCQLBW9VucLpkh1cFqGWfYs95mEN0UujhbvfYVLEYPtYBqRY1qpnpkBZN2jBa+Z8tiBcvLm+y5+9mMSTnPbY48+lSfHK4tGzBx7pabNnM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ezb3LWD+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729734222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FVDP3C9t0rRyIGE67pf88Dpw8UTOmBVb92+6d4ABj6k=;
	b=ezb3LWD+zs895jx9m+BmwojzEbsTdXbk4rmfVw3pR6p21sTeDWoacCWrDblAk5KHTb24cI
	3bnOYWtzEeR5hcZ8owa08lb2VmKcu3Ewh9HZh7sVd7czvbofeMXWrEZ56IY5Q5CnlIeC3G
	L7/XP+crELeinbAYz0pfMjgpEKaovh0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-vzvEd914OiW2oUhy5dKUkg-1; Wed,
 23 Oct 2024 21:43:39 -0400
X-MC-Unique: vzvEd914OiW2oUhy5dKUkg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC447195608B;
	Thu, 24 Oct 2024 01:43:37 +0000 (UTC)
Received: from fedora (unknown [10.72.116.101])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A8E21956088;
	Thu, 24 Oct 2024 01:43:29 +0000 (UTC)
Date: Thu, 24 Oct 2024 09:43:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 2/3] nvme: core: switch to non_owner variant of
 start_freeze/unfreeze queue
Message-ID: <ZxmmPKFksWc5LLlc@fedora>
References: <20241023095438.3451156-1-ming.lei@redhat.com>
 <20241023095438.3451156-3-ming.lei@redhat.com>
 <20241023122115.GB28777@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023122115.GB28777@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Oct 23, 2024 at 02:21:15PM +0200, Christoph Hellwig wrote:
> On Wed, Oct 23, 2024 at 05:54:34PM +0800, Ming Lei wrote:
> > @@ -4913,7 +4913,7 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
> >  	set_bit(NVME_CTRL_FROZEN, &ctrl->flags);
> >  	srcu_idx = srcu_read_lock(&ctrl->srcu);
> >  	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
> > -		blk_freeze_queue_start(ns->queue);
> > +		blk_freeze_queue_start_non_owner(ns->queue);
> 
> Maybe throw in a comment like:
> 
> /*
>  * Will be unfrozen at I/O completion time when called by
>  * nvme_passthru_start.
>  */
> 
> so that it's clear why the non_owner version is used here.

There are one more such usage: 

- freeze in nvme_dev_disable()/apple_nvme_disable() from timeout work, but
unfreeze in nvme_reset_work()


Thanks,
Ming


