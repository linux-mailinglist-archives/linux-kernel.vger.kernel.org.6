Return-Path: <linux-kernel+bounces-303851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB289615F9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D2E1F2691F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4692E1D1F51;
	Tue, 27 Aug 2024 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wdhqesp5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E593126F1E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781141; cv=none; b=YO6hdJmyf5yMT3ZeANhsdMzvbfdnLt3tZe8OqOOJZ7emLfnhnVQ1Q8R8fXO+MEPswQlNJbEDrYtx7P16FMVmlhW04p16R27i5lFfHOVz4DuIQbhY2ppA8A/ulJp9kUBBVY46vR8P/ma0o3W0pcLfxBgkzYVtUJgtV1tym7uUoTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781141; c=relaxed/simple;
	bh=e7BKM5olZ94L3g9T2tqv0EdE7YzzCKLnErdUyr4cFak=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jRXRsJ7IdwKQqs5VoKXJjUZEDvhn8vIYbRtxpzLzexLLgnNxiJJCXjX9hpq/FcfYOt6ntatgwhhL/4xItOHWhNzqqOg5f3q3w7B5wmDInx3xgIqVGSscSSeV0+DcBcbwGECuaCo7ztsRQOfGTd8MdRcvXdAlM/blP9WoR8eqwqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wdhqesp5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724781138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7HPuEU7mzMlv+Rhl994NDb/ii54cFT6bi9t362pW9Pk=;
	b=Wdhqesp5cEY9lyeZeW52jkOpqGWauv1voInvC6qXUDTzBM4U2WnN0V1yhMq8OpeigugJNy
	VhUvVApLlcWVRnof0wqSzFfS9rhVS0/DuptxLoRsHbhxJiSJzZflzfajKMgHyUzxhltFqx
	nDbFG+CUECY+Jjh9/yn0lZ2VExx6en8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-KxS0O9jGOEComt96m23FkQ-1; Tue,
 27 Aug 2024 13:52:14 -0400
X-MC-Unique: KxS0O9jGOEComt96m23FkQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E21141955BF2;
	Tue, 27 Aug 2024 17:52:11 +0000 (UTC)
Received: from [10.45.224.222] (unknown [10.45.224.222])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FEC519560A3;
	Tue, 27 Aug 2024 17:52:09 +0000 (UTC)
Date: Tue, 27 Aug 2024 19:52:05 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: =?ISO-8859-2?Q?=A3ukasz_Patron?= <priv.luk@gmail.com>
cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm: Implement set_read_only
In-Reply-To: <20240821213048.726082-1-priv.luk@gmail.com>
Message-ID: <da447e8f-0068-d847-b712-47081fa9f2e7@redhat.com>
References: <20240821213048.726082-1-priv.luk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811712-837155280-1724761611=:915355"
Content-ID: <c128e9d3-00f9-b4bb-ea49-474e3a00510d@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811712-837155280-1724761611=:915355
Content-Type: text/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Content-ID: <62eac86b-f87a-04be-2451-5a96461c9b07@redhat.com>



On Wed, 21 Aug 2024, £ukasz Patron wrote:

> This lets us change the read-only flag for device mapper block devices
> via the BLKROSET ioctl.
> 
> Signed-off-by: £ukasz Patron <priv.luk@gmail.com>
> ---
>  drivers/md/dm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 87bb90303435..538a93e596d7 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -410,6 +410,12 @@ static int dm_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
>  	return dm_get_geometry(md, geo);
>  }
>  
> +static int dm_blk_set_read_only(struct block_device *bdev, bool ro)
> +{
> +	set_disk_ro(bdev->bd_disk, ro);
> +	return 0;
> +}
> +
>  static int dm_prepare_ioctl(struct mapped_device *md, int *srcu_idx,
>  			    struct block_device **bdev)
>  {
> @@ -3666,6 +3672,7 @@ static const struct block_device_operations dm_blk_dops = {
>  	.release = dm_blk_close,
>  	.ioctl = dm_blk_ioctl,
>  	.getgeo = dm_blk_getgeo,
> +	.set_read_only = dm_blk_set_read_only,
>  	.report_zones = dm_blk_report_zones,
>  	.pr_ops = &dm_pr_ops,
>  	.owner = THIS_MODULE
> -- 
> 2.46.0

Hi

Device mapper already calls set_disk_ro in the do_resume function. So, the 
problem here is that the value set using set_read_only will be overwritten 
as soon as a new table will be loaded.

I'd like to ask why is this patch needed? Why do you want to set read-only 
status using this ioctl instead of using the existing table flag?

If this is needed, we need to add another flag that is being set by 
dm_blk_set_read_only, so that dm_blk_set_read_only and dm_resume won't 
step over each other's changes.

Mikulas
---1463811712-837155280-1724761611=:915355--


