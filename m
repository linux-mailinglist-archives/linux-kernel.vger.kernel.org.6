Return-Path: <linux-kernel+bounces-317670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2951196E1D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CBE1C20DE6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED6918785F;
	Thu,  5 Sep 2024 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7vnAisM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D714F125
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560521; cv=none; b=M9/wxYckE8pos41e7rhvlxQ205YT16IppFvNYGUyHiR/z7uTCy8sQdz0zGsRqb5q30U0THDamizHA85khTxJG1S0Ys3C7ED4CM40b4IwlAjtl4KqmP9oHzJQhhU+wpRKGs2Wgs/nQg5OQKpKYt7axHGV5qT5zCxAYGrtaFomxhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560521; c=relaxed/simple;
	bh=Hby1hOdwKYCfXNR4WIB+PqjAkcRH83kj+jNz8JiJ2Uc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=shlASbfiXZxlTs+wkktJYI2HtV6EGtPB8It+p/TZrIlsqeC12s22hr0M9O2NpPAf3XI45e1tzbbd0fHcHf9SOI+Q2pQU3ItSct+L1Y4sCJCCwvBmQQpYC12vFyyZTS6dH7anqpTe57+dAvovmuoOQ2FXhokw24wXvp3FW6XkkFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7vnAisM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725560518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZVrq2tmtI8yniXwYB5nDBHMyXlS7xVzITGYCNH+G7Q=;
	b=a7vnAisMneXRe99xXAE6kIGWKeza1lb7Mx3/cJ9k3coOU5Mtfg/0cufL8FoSTGIt64NbZA
	2yqrIKv2vh/nadVQo6UNrJtCIgoGA0yNoHxmTD+fnFUaDWj3KyJUTixljumTIGPHAYDxYJ
	C6cpeN2xxtf6leL7kkUL32Hp2TwOHBs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-ixL1IET2MEKSKlEPYgR2kA-1; Thu,
 05 Sep 2024 14:21:55 -0400
X-MC-Unique: ixL1IET2MEKSKlEPYgR2kA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE7DF195608B;
	Thu,  5 Sep 2024 18:21:53 +0000 (UTC)
Received: from [10.45.224.222] (unknown [10.45.224.222])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B84F330001AB;
	Thu,  5 Sep 2024 18:21:50 +0000 (UTC)
Date: Thu, 5 Sep 2024 20:21:46 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
cc: dm-devel@lists.linux.dev, Alasdair Kergon <agk@redhat.com>, 
    Mike Snitzer <snitzer@kernel.org>, Tejun Heo <tj@kernel.org>, 
    Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] dm verity: don't use WQ_MEM_RECLAIM
In-Reply-To: <20240904040444.56070-1-ebiggers@kernel.org>
Message-ID: <086a76c4-98da-d9d1-9f2f-6249c3d55fe9@redhat.com>
References: <20240904040444.56070-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On Tue, 3 Sep 2024, Eric Biggers wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> Since dm-verity doesn't support writes, the kernel's memory reclaim code
> will never wait on dm-verity work.  That makes the use of WQ_MEM_RECLAIM
> in dm-verity unnecessary.  WQ_MEM_RECLAIM has been present from the
> beginning of dm-verity, but I could not find a justification for it;
> I suspect it was just copied from dm-crypt which does support writes.
> 
> Therefore, remove WQ_MEM_RECLAIM from dm-verity.  This eliminates the
> creation of an unnecessary rescuer thread per dm-verity device.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Hmm. I can think about a case where you have read-only dm-verity device, 
on the top of that you have dm-snapshot device and on the top of that you 
have a writable filesystem.

When the filesystem needs to write data, it submits some write bios. When 
dm-snapshot receives these write bios, it will read from the dm-verity 
device and write to the snapshot's exception store device. So, dm-verity 
needs WQ_MEM_RECLAIM in this case.

Mikulas

> ---
>  drivers/md/dm-verity-target.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index cf659c8feb29f..051e84ca401dc 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -1488,11 +1488,11 @@ static int verity_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  	 * Also as required for the "try_verify_in_tasklet" feature: WQ_HIGHPRI
>  	 * allows verify_wq to preempt softirq since verification in BH workqueue
>  	 * will fall-back to using it for error handling (or if the bufio cache
>  	 * doesn't have required hashes).
>  	 */
> -	v->verify_wq = alloc_workqueue("kverityd", WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
> +	v->verify_wq = alloc_workqueue("kverityd", WQ_HIGHPRI, 0);
>  	if (!v->verify_wq) {
>  		ti->error = "Cannot allocate workqueue";
>  		r = -ENOMEM;
>  		goto bad;
>  	}
> 
> base-commit: 88fac17500f4ea49c7bac136cf1b27e7b9980075
> -- 
> 2.46.0
> 


