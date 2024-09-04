Return-Path: <linux-kernel+bounces-314191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFC996AFE6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 06:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA659286DA6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD84823D1;
	Wed,  4 Sep 2024 04:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFuw3LjJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71413635
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 04:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725424744; cv=none; b=olnR3fM48tCZSAbAEK0DZ/73wTzMD1XO5Y8ZsC2dmtpo94Q9AnRJNafNe/+Mrggth4wuLlWH02gK8geFPwSlrB/0kwDl79Yu5Q8/wqNCDfYCLt+lkK7UyNWVBr/MhMi0NqJouxltyvdktO1LfVicqNREmR4aDRZmYOfw2Q165xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725424744; c=relaxed/simple;
	bh=x9qDFWxMO96K95WfPtNrQiI5WrN0j5yTvSTJ5hJKH7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqKOWzQHrtYwcbALk1vcwt5N8qz3isy0qrdaUrTZYKSOoazlRkxnNt2bcyCLlzGumTy6BCkIfeUD+T+DkBjJ6amI6idoOo+HGJY6ihEsGXt74/Sm65SAlQX3gRhW/NVBa+bPDvDhDRstEgcY7eCIF6OYXu3r8Jd5pNqWDS2nUSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFuw3LjJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725424741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3zsKB3WdrmMbEpvlPWbs3HIFo2lGSqwqj8i5jKNJQ5U=;
	b=FFuw3LjJ6hEO1CXvtjdE+qa5teEuRGiKbqWEx5hzOT0Tb1B5gSfVvIu2SJmV5/vG62qXcp
	Gll9qtkuuzCZEuS+pqpahR5V87THn+lQ6Dkkay+AR1bUSzU9HtjS4xYO5FSAL2Ca6YBzds
	/N7uuyXW9TIEBc0VCP1O+88/Ug79wzU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-npusVDDyNsWTrMLS-6XdPA-1; Wed,
 04 Sep 2024 00:38:57 -0400
X-MC-Unique: npusVDDyNsWTrMLS-6XdPA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCBDA19560A3;
	Wed,  4 Sep 2024 04:38:53 +0000 (UTC)
Received: from fedora (unknown [10.72.116.130])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 537E6195605A;
	Wed,  4 Sep 2024 04:38:44 +0000 (UTC)
Date: Wed, 4 Sep 2024 12:38:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, jack@suse.cz, tj@kernel.org,
	josef@toxicpanda.com, paolo.valente@unimore.it,
	mauro.andreolini@unimore.it, avanzini.arianna@gmail.com,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH for-6.12 0/4] block, bfq: fix corner cases related to
 bfqq merging
Message-ID: <ZtfkTyxvwTzRTnG5@fedora>
References: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
 <2ee05037-fb4f-4697-958b-46f0ae7d9cdd@kernel.dk>
 <c2a6d239-aa96-f767-9767-9e9ea929b014@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2a6d239-aa96-f767-9767-9e9ea929b014@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Sep 04, 2024 at 09:32:26AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2024/09/03 23:51, Jens Axboe 写道:
> > On 9/2/24 7:03 AM, Yu Kuai wrote:
> > > From: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > Our syzkaller report a UAF problem(details in patch 1), however it can't
> > > be reporduced. And this set are some corner cases fix that might be
> > > related, and they are found by code review.
> > > 
> > > Yu Kuai (4):
> > >    block, bfq: fix possible UAF for bfqq->bic with merge chain
> > >    block, bfq: choose the last bfqq from merge chain in
> > >      bfq_setup_cooperator()
> > >    block, bfq: don't break merge chain in bfq_split_bfqq()
> > >    block, bfq: use bfq_reassign_last_bfqq() in bfq_bfqq_move()
> > > 
> > >   block/bfq-cgroup.c  |  7 +------
> > >   block/bfq-iosched.c | 17 +++++++++++------
> > >   block/bfq-iosched.h |  2 ++
> > >   3 files changed, 14 insertions(+), 12 deletions(-)
> > 
> > BFQ is effectively unmaintained, and has been for quite a while at
> > this point. I'll apply these, thanks for looking into it, but I think we
> > should move BFQ to an unmaintained state at this point.
> 
> Sorry to hear that, we would be willing to take on the responsibility of
> maintaining this code, please let me know if there are any specific
> guidelines or processes we should follow. We do have customers are using
> bfq in downstream kernels, and we are still running lots of test for
> bfq.

Hi Yukuai,
 
BTW, BFQ is default IO scheduler for SCSI/MMC in Fedora. That is great if you'd
like to volunteer to take over maintaining it.


thanks,
Ming


