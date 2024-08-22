Return-Path: <linux-kernel+bounces-297725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E97FF95BCCC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B771C23FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1441CF283;
	Thu, 22 Aug 2024 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JG/3eZHY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865A1CDFC5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346528; cv=none; b=WaQZQ1Kc23dOuXhhjTs0GDZPU40kTwxqkfN7H8sm0YTL/OolSlA/JH93qYwtv+On4wq9cxNmFwOQR47+DOHk5Jfmssj+o/SZoXuNWkqyU9HDTgy3MoaTw6VWAl0Tx3/OKvpQOZw5Al1XOK45Xvsg4PXILvXJ1HHHOooC70vN9Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346528; c=relaxed/simple;
	bh=1dg4YEe0xZrT5WAbxZSFaD+eiz2MppGoRrrcvzBa9ko=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gEtZrhuIOjPgJWl539jQ2TfNxkB06GbsrKulML/jdTURSOInn2BKMT6HpVrjH4EMnO7yl/uZQ8pMv138N8c+htq5dari6Z3skVTXmwkWipeo22uPDIONAXmhHL0qbI0rO4xKd2I0uaoa3On2vzquqzB7MXFUm5Wycfoj9xFbg0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JG/3eZHY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724346525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VP0z4ZUja2rAQmlvGCWDjc4h6tAYEdJPEhXn0L4AZcQ=;
	b=JG/3eZHYsXQ078Mfyst1VFRqziYvqaVbunIp6vAsdYsgU4+Q6xQ3A2oN7OYcbvyVxXe6SR
	pAf3+P0aNE3BCu0dXdT1wqR5/wwPxmDccmNPaVM9i83fD44OtccnuvW+7yr9mObMxo9B3k
	g2l9XnjI+ud7vz04yZp8Fj7ALDWJIdg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-wggC0dfWPna8UYAvCztfpw-1; Thu,
 22 Aug 2024 13:08:41 -0400
X-MC-Unique: wggC0dfWPna8UYAvCztfpw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD6A81955D47;
	Thu, 22 Aug 2024 17:08:39 +0000 (UTC)
Received: from [10.45.224.222] (unknown [10.45.224.222])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A5723001FE8;
	Thu, 22 Aug 2024 17:08:37 +0000 (UTC)
Date: Thu, 22 Aug 2024 19:08:34 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Chen Yufan <chenyufan@vivo.com>
cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
    opensource.kernel@vivo.com
Subject: Re: [PATCH v1] Device-mapper(LVM): Convert to use time_after_eq
 macro
In-Reply-To: <20240822015416.3627-1-chenyufan@vivo.com>
Message-ID: <1abae895-7fb4-0342-21b9-1fd8e085dc9a@redhat.com>
References: <20240822015416.3627-1-chenyufan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On Thu, 22 Aug 2024, Chen Yufan wrote:

> Use time_after_eq macro instead of opening it for readability.
> 
> Signed-off-by: Chen Yufan <chenyufan@vivo.com>
> ---
>  drivers/md/dm-writecache.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index 7ce8847b3..548d4d37e 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -16,6 +16,7 @@
>  #include <linux/pfn_t.h>
>  #include <linux/libnvdimm.h>
>  #include <linux/delay.h>
> +#include <linux/jiffies.h>
>  #include "dm-io-tracker.h"
>  
>  #define DM_MSG_PREFIX "writecache"
> @@ -1994,8 +1995,8 @@ static void writecache_writeback(struct work_struct *work)
>  	while (!list_empty(&wc->lru) &&
>  	       (wc->writeback_all ||
>  		wc->freelist_size + wc->writeback_size <= wc->freelist_low_watermark ||
> -		(jiffies - container_of(wc->lru.prev, struct wc_entry, lru)->age >=
> -		 wc->max_age - wc->max_age / MAX_AGE_DIV))) {
> +		(time_after_eq(jiffies, container_of(wc->lru.prev, struct wc_entry, lru)->age +
> +		 (wc->max_age - wc->max_age / MAX_AGE_DIV))))) {
>  
>  		n_walked++;
>  		if (unlikely(n_walked > WRITEBACK_LATENCY) &&
> -- 
> 2.39.0

I'm not sure about this. The old and new code is not really equivalent.

Mikulas


