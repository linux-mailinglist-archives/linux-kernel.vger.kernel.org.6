Return-Path: <linux-kernel+bounces-198549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B70FA8D7A1E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 04:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D02B20B98
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 02:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064CF8460;
	Mon,  3 Jun 2024 02:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7gxFhFi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA563B9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 02:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717382651; cv=none; b=rWyix9APaoPXpaGDccPUN1vOTH3Z2XUNmFI+r/eALyQ0hpsfbn1FUoc2r7Nc3aihcg93DSme8yLPv2UXQVQ5+od7l3rUnG38ZRuLZNoWF0iEeq6P0J9e108Tvcdz4PC49lk1kI4S9hM//3Zi8UkKtVVAEjRN4K7mUduDbFtIPe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717382651; c=relaxed/simple;
	bh=YmffdCZX+QfHi+DHuaDWTe2NbDgd175ZCCdBejQe9hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utd5EJvWV3B8zFFMYyewm2+6zCj8s3JNPsKWC/PVyNejw8Ze6MDpGzfY4qaRNQaNdKzMqUmGugGXj0CEI1/62RonKRgL2h5pvyzms+jV2lPwS6YshGCH7grMPlZI+4CWzEbGCqS8/MHcBeftqfPDhQmSl/aDOrJ4ilyTRNeKYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7gxFhFi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717382648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYh7TnCnCAANHzNAKdvfvxpMmsmyucOVTxxcqwn5OJs=;
	b=O7gxFhFi0CFNSqvFX/T+uC+OYqqUnZlM5kD6JQkzNCveaPxm9G+tqmLgZBK2zzFeUBrQKZ
	n3jHJdsxV943XXkpEN/unt2Pid5ubjQIDx0dVCitEQ6ywfg319zR9vQkrvdukWGsT81QZg
	+r5VrRBmeMXYaPU/Bg2UpQ9HNnu12/A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-uzmAEO9QNG-PqZAfkg0tTg-1; Sun,
 02 Jun 2024 22:44:05 -0400
X-MC-Unique: uzmAEO9QNG-PqZAfkg0tTg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EF601C05129;
	Mon,  3 Jun 2024 02:44:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A3FA2200BFC7;
	Mon,  3 Jun 2024 02:43:59 +0000 (UTC)
Date: Mon, 3 Jun 2024 10:43:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Li Nan <linan666@huaweicloud.com>
Cc: axboe@kernel.dk, ZiyangZhang@linux.alibaba.com, czhong@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH] ublk_drv: fix NULL pointer dereference in
 ublk_ctrl_start_recovery()
Message-ID: <Zl0t68TNz2alGvM+@fedora>
References: <20240529095313.2568595-1-linan666@huaweicloud.com>
 <Zl0QpCbYVHIkKa/H@fedora>
 <225f4c8e-0e2c-8f4b-f87d-69f4677af572@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <225f4c8e-0e2c-8f4b-f87d-69f4677af572@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Mon, Jun 03, 2024 at 10:19:50AM +0800, Li Nan wrote:
> 
> 
> 在 2024/6/3 8:39, Ming Lei 写道:
> 
> [...]
> 
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 4e159948c912..99b621b2d40f 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -2630,7 +2630,8 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
> > >   {
> > >   	int i;
> > > -	WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
> > > +	if (WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq))))
> > > +		return;
> > 
> > Yeah, it is one bug. However, it could be addressed by adding the check in
> > ublk_ctrl_start_recovery() and return immediately in case of NULL ubq->ubq_daemon,
> > what do you think about this way?
> > 
> 
> Check ub->nr_queues_ready seems better. How about:
> 
> @@ -2662,6 +2662,8 @@ static int ublk_ctrl_start_recovery(struct ublk_device
> *ub,
>         mutex_lock(&ub->mutex);
>         if (!ublk_can_use_recovery(ub))
>                 goto out_unlock;
> +       if (!ub->nr_queues_ready)
> +               goto out_unlock;

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


