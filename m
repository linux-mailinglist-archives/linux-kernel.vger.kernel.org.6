Return-Path: <linux-kernel+bounces-205167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C658FF84C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1091C22780
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428F313F439;
	Thu,  6 Jun 2024 23:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuI73YAB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144AB13D89F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 23:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717717612; cv=none; b=dYFF3PePO6Gzz5neAXhI2L+VYbyzV1cNMu1l7YlGmQh+EReSbdONOUGiCLE5uGq/6AwbCA1bhHz+cBOPniFHJ+zRa5aIBgd94pBkeG7EcnrP6PlMId69DrTEqE3tAR8k0IEZbdvH8LNWDPjxq0mIoLAj1opBKmWvjieoevZcFK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717717612; c=relaxed/simple;
	bh=Q5ZcmHTBdEtDXi0V6CYL5t/Co7Vi1if2BDN7rDzndCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrc0UfWcNJfLmKO/pVkl5wNQe98BmdwUUaraMldj1KDqiqEtbrV7FnBuR3/M7QGDzrsY7W7etjmBj626M1Uha+TBU3rU5/kYH6XnGk3kIRJPzGkCnFh0uL/GMtMYFrXQvgAiylN7hqlb9rjDcbb4LYM1O/YEsReWoXlkxEZ8QY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IuI73YAB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717717610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u6KkShH+LBPBDtFL/J7+56MEKPg8eU6ralQnJ1U5rNo=;
	b=IuI73YABJVfcYeLha96qo82giM/M/EQEsHZ26/gGjk1ylqXGXo4V5JTHAhlNYcofI6gjUn
	10I7eIKSMrA+IOwjawhTbbaxn9zC00eIeMDboFC3Y/8rjQIN/5jYA3Sioe5/0zNmt60WZw
	Eerp+OsvsMb72o4TjuaH2EBCwcQvIwk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-HAhIOT2zNmKofTm7DiPH8g-1; Thu,
 06 Jun 2024 19:46:43 -0400
X-MC-Unique: HAhIOT2zNmKofTm7DiPH8g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E5371944D3B;
	Thu,  6 Jun 2024 23:46:40 +0000 (UTC)
Received: from fedora (unknown [10.72.112.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CE101955F14;
	Thu,  6 Jun 2024 23:46:32 +0000 (UTC)
Date: Fri, 7 Jun 2024 07:46:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: yebin <yebin@huaweicloud.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ye Bin <yebin10@huawei.com>, Zhang Yi <yizhan@redhat.com>,
	"Ewan D. Milne" <emilne@redhat.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: bio-integrity: fix potential null-ptr-deref in
 bio_integrity_free
Message-ID: <ZmJKU9mMDg1+mO3i@fedora>
References: <20240606062655.2185006-1-yebin@huaweicloud.com>
 <ZmFatW3BEzTPgR7S@infradead.org>
 <66619EB6.4040002@huaweicloud.com>
 <ZmHH7mW0M80RaPlj@fedora>
 <ZmHNQ56C6Ee01Kcv@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmHNQ56C6Ee01Kcv@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Jun 06, 2024 at 07:52:51AM -0700, Christoph Hellwig wrote:
> On Thu, Jun 06, 2024 at 10:30:06PM +0800, Ming Lei wrote:
> > Yeah, that is one area queue freezing can't cover logical block size
> > change, but I'd suggest to put the logical bs check into submit_bio() or
> > slow path of __bio_queue_enter() at least.
> 
> We really need an alignment check in submit_bio anyway, so doing it
> under the freeze protection would also help with this.
> 
> > My concern is that nvme format is started without draining IO, and
> > IO can be submitted to hardware when nvme FW is handling formatting.
> > I am not sure if nvme FW can deal with this situation correctly.
> > Ewan suggested to run 'nvme format' with exclusive nvme disk open, which
> > needs nvme-cli change.
> 
> .. and doesn't protect against someone using a different tool anyway.
> 
> That beeing said, nvme_passthru_start actually freezes all queues
> based on the commands supported an affects log, and
> nvme_init_known_nvm_effects should force this even for controllers
> not supporting the log or reporting bogus information.  So in general
> the queue should be frozen during the actual format.

That is something I missed, thanks for sharing the story.


Thanks,
Ming


