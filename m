Return-Path: <linux-kernel+bounces-533327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7155EA45871
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499D8167E68
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E801E1E05;
	Wed, 26 Feb 2025 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4U59130"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFD127702
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558868; cv=none; b=JnpW4JTKeOexAVs9SfSZ0v93hPJjaxEGx5ixT5WGBhfnbzr1oh+1eeZvzxwZtTy8vm7SlYifxQV/ucG4kdBeIx29W4X+hTUfwz1JMyY6jIizPKaF/+zcd/hK0x90luoMbDTErNEc2TlVeXlc/nHT9GELDiuhwU3VqH5s/qZs6W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558868; c=relaxed/simple;
	bh=nNK3eON7sgCfOoj/gz1hzVi92eFm3usqdnxBzxGqZKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W15oUJiiu35WKpkWl8hugsxLEeaM80IkDKvoQDT++CHyrUR5TznoY42u+NGjPzSmDhDwds+39dU2EWrjKCYFSRV5BWiIJYhWqYwM7admvXMq2rFxzfdg0gK9JH5lcRbYVQgfSRsYQGrpmzc0MTgRXjnSD4K/Qoe5wApgX3OT/uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4U59130; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740558865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fImwG0gjP1kPfa1qAhDHGLxTqLh4BuZ+7fvJaclJjHc=;
	b=G4U59130bcsBoDDEitWUwZU/N9p19M6qHB9ecKdZK10xuf+AlMB3FzcLfmYwYOZ3KRPjtp
	ExmoDsVkDoDVfGe6z29rwBtenQdAtbsJejafuu4pFMeUpxgm8+rBiHELsN3tLvXd4RTMS4
	Qj/YwUHR60ZVdNcEz8L7qktdBTtwuKQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-eLi501WYORugUbouz1XuFw-1; Wed,
 26 Feb 2025 03:34:23 -0500
X-MC-Unique: eLi501WYORugUbouz1XuFw-1
X-Mimecast-MFC-AGG-ID: eLi501WYORugUbouz1XuFw_1740558862
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00E4519373DC;
	Wed, 26 Feb 2025 08:34:22 +0000 (UTC)
Received: from fedora (unknown [10.72.120.27])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 226E11800352;
	Wed, 26 Feb 2025 08:34:12 +0000 (UTC)
Date: Wed, 26 Feb 2025 16:34:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, vgoyal@redhat.com,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] blk-throttle: fix lower bps rate by throtl_trim_slice()
Message-ID: <Z77R_rqgDdAvFVgP@fedora>
References: <20250226011627.242912-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226011627.242912-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Feb 26, 2025 at 09:16:27AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> The bio submission time may be a few jiffies more than the expected
> waiting time, due to 'extra_bytes' can't be divided in
> tg_within_bps_limit(), and also due to timer wakeup delay. In this
> case, adjust slice_start to jiffies will discard the extra wait time,
> causing lower rate than expected.
> 
> This problem will cause blktests throtl/001 failure in case of
> CONFIG_HZ_100=y, fix it by preserving one finished slice in
> throtl_trim_slice() and allowing deviation between [0, 2 slices).

I think it only can cover single default slice deviation, since
throtl_trim_slice() just keeps dispatch data in the previous single
default slice. Or can you add words on how to allow 2 default slices
deviation?

> 
> For example, assume bps_limit is 1000bytes, 1 jiffes is 10ms, and
> slice is 20ms(2 jiffies), expected rate is 1000 / 1000 * 20 = 20 bytes
> per slice.
> 
> If user issues two 21 bytes IO, then wait time will be 30ms for the
> first IO:
> 
> bytes_allowed = 20, extra_bytes = 1;
> jiffy_wait = 1 + 2 = 3 jiffies
> 
> and consider
> extra 1 jiffies by timer, throtl_trim_slice() will be called at:
> 
> jiffies = 40ms
> slice_start = 0ms, slice_end= 40ms
> bytes_disp = 21
> 
> In this case, before the patch, real rate in the first two slices is
> 10.5 bytes per slice, and slice will be updated to:
> 
> jiffies = 40ms
> slice_start = 40ms, slice_end = 60ms,
> bytes_disp = 0;
> 
> Hence the second IO will have to wait another 30ms;
> 
> With the patch, the real rate in the first slice is 20 bytes per slice,
> which is the same as expected, and slice will be updated:
> 
> jiffies=40ms,
> slice_start = 20ms, slice_end = 60ms,
> bytes_disp = 1;
> 
> And now, there is still 19 bytes allowed in the second slice, and the
> second IO will only have to wait 10ms;
> 
> Fixes: e43473b7f223 ("blkio: Core implementation of throttle policy")
> Reported-by: Ming Lei <ming.lei@redhat.com>
> Closes: https://lore.kernel.org/linux-block/20250222092823.210318-3-yukuai1@huaweicloud.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-throttle.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 8d149aff9fd0..cb472cf7b6b6 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -599,14 +599,23 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
>  	 * sooner, then we need to reduce slice_end. A high bogus slice_end
>  	 * is bad because it does not allow new slice to start.
>  	 */
> -
>  	throtl_set_slice_end(tg, rw, jiffies + tg->td->throtl_slice);
>  
>  	time_elapsed = rounddown(jiffies - tg->slice_start[rw],
>  				 tg->td->throtl_slice);
> -	if (!time_elapsed)
> +	/* Don't trim slice until at least 2 slices are used */
> +	if (time_elapsed < tg->td->throtl_slice * 2)
>  		return;
>  
> +	/*
> +	 * The bio submission time may be a few jiffies more than the expected
> +	 * waiting time, due to 'extra_bytes' can't be divided in
> +	 * tg_within_bps_limit(), and also due to timer wakeup delay. In this
> +	 * case, adjust slice_start to jiffies will discard the extra wait time,
> +	 * causing lower rate than expected. Therefore, one slice is preserved,
> +	 * allowing deviation that is less than two slices.
> +	 */
> +	time_elapsed -= tg->td->throtl_slice;

Please document that default slice window size is doubled actually in
this way.


Thanks,
Ming


