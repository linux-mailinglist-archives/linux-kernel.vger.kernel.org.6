Return-Path: <linux-kernel+bounces-397586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3053E9BDDAE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 04:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4508284DC4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA02C190497;
	Wed,  6 Nov 2024 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQ6EgedF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3087D190468
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 03:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730864227; cv=none; b=ODgE6rKKWy9k6zY8k7PHc6OM54BgnBSTYgUVqSH2UEbrNVVww1800qUwHkVl6o+J7GoBAlODhEgU2Fmae/Z7e9cS+U1TcEcaCpayZ4/pTx2Hp3I39AGhI5we9t4VKZ5bm705aA2doBOtsNhTtvW6oVBrp7QleGfWCfAK4mfLkx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730864227; c=relaxed/simple;
	bh=ud5DPf8b1BJaqDIlmiz+Q5kYJJuvjAF6DaXxik5Amzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6DpPGVCA9FalrreKiTaf/I20YJNFzYDDYH9QeZzAzockjV3RnqgrpDtXm6033EMmsIOVmBASLwRPn5+WfTavPMUGZBj0A9wOCS1C9mTc4Sn5FGr/TWkVjAxGE4I2JYNwuyIr1LUIgzOclirT1wQZuYkgejXQ2ye8a8k1q/FrQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQ6EgedF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730864224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IozFIWMN3tDIjYprpdVk+X7PaeotOhVHEqTW5MuzcUI=;
	b=MQ6EgedFXkQ7fUWfNQxIj/zCNoZNiQGC2i2EQWdj3BunHsuvYI8Zym+HtoYXuPSB01eSer
	tyDDQcHRraXsW1jFyeGebgWVTYBAYREcVOHWaa3nK9m7kffsOTp2e6WzZfVLtOf+OBXAh9
	7lwXd6NTy1h3KWX9z+uXEjaHCaJEjmA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-k1TH40dEPBucbsXCT-DgeQ-1; Tue,
 05 Nov 2024 22:36:59 -0500
X-MC-Unique: k1TH40dEPBucbsXCT-DgeQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1D941955EE7;
	Wed,  6 Nov 2024 03:36:56 +0000 (UTC)
Received: from fedora (unknown [10.72.116.96])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C38E0197132A;
	Wed,  6 Nov 2024 03:36:50 +0000 (UTC)
Date: Wed, 6 Nov 2024 11:36:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next] block: fix uaf for flush rq while iterating tags
Message-ID: <ZyrkTB0-SKjrQaiZ@fedora>
References: <20241104110005.1412161-1-yukuai1@huaweicloud.com>
 <Zyn_RGV2i9COvNQl@infradead.org>
 <217f242b-b4e2-89f7-3b0f-3337c251a603@huaweicloud.com>
 <ZyreVTWn2no-WCC3@fedora>
 <43ed2c81-7e86-a106-3592-7f1944ce0f25@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43ed2c81-7e86-a106-3592-7f1944ce0f25@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Nov 06, 2024 at 11:25:07AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2024/11/06 11:11, Ming Lei 写道:
> > On Wed, Nov 06, 2024 at 10:58:40AM +0800, Yu Kuai wrote:
> > > Hi,Ming and Christoph
> > > 
> > > 在 2024/11/05 19:19, Christoph Hellwig 写道:
> > > > On Mon, Nov 04, 2024 at 07:00:05PM +0800, Yu Kuai wrote:
> > > > > From: Yu Kuai <yukuai3@huawei.com>
> > > > > 
> > > > > blk_mq_clear_flush_rq_mapping() is not called during scsi probe, by
> > > > > checking blk_queue_init_done(). However, QUEUE_FLAG_INIT_DONE is cleared
> > > > > in del_gendisk by commit aec89dc5d421 ("block: keep q_usage_counter in
> > > > > atomic mode after del_gendisk"), hence for disk like scsi, following
> > > > > blk_mq_destroy_queue() will not clear flush rq from tags->rqs[] as well,
> > > > > cause following uaf that is found by our syzkaller for v6.6:
> > > > 
> > > > Which means we leave the flush request lingering after del_gendisk,
> > > > which sounds like the real bug.  I suspect we just need to move the
> > > > call to blk_mq_clear_flush_rq_mapping so that it is called from
> > > > del_gendisk and doesn't leave the flush tag lingering around.
> > > > 
> > > 
> > > This remind me that del_gendisk is still too late to do that. Noted that
> > > flush_rq can acquire different tags, so if the multiple flush_rq is done
> > > and those tags are not reused, the flush_rq can exist in multiple
> > > entries in tags->rqs[]. The consequence I can think of is that iterating
> > > tags can found the same flush_rq multiple times, and the flush_rq can be
> > > inflight.
> > 
> > How can that be one problem?
> > 
> > Please look at
> > 
> > commit 364b61818f65 ("blk-mq: clearing flush request reference in tags->rqs[]")
> > commit bd63141d585b ("blk-mq: clear stale request in tags->rq[] before freeing one request pool")
> > 
> > and understand the motivation.
> > 
> > That also means it is just fine to delay blk_mq_clear_flush_rq_mapping()
> > after disk is deleted.
> 
> I do understand what you mean. Let's see if you want this to be avoided,
> for example(no disk is deleted):

It is definitely another issue, and not supposed to be covered by
blk_mq_clear_flush_rq_mapping().

> 
> 1) issue a flush, and tag 0 is used, after the flush is done,
> tags->rqs[0] = flush_rq
> 2) issue another flush, and tag 1 is used, after the flush is done,
> tags->rqs[1] = flush_rq
> 3) issue a flush again, and tag 2 is used, and the flush_rq is
> dispatched to disk;

Yes, this kind of thing exists since blk-mq begins, and you can't expect
blk_mq_in_flight_rw() to get accurate inflight requests.

> 4) Then in this case, blk_mq_in_flight_rw() will found the same flush_rq
> 3 times and think there are 3 inflight request, same for
> hctx_busy_show()...

But we have tried to avoid it, such as in blk_mq_find_and_get_req()
req->tag is checked against the current 'bitnr' of sbitmap when walking
over tags. Then the same flush_rq won't be counted 3 times.



Thanks,
Ming


