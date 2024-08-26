Return-Path: <linux-kernel+bounces-301151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9629395ED08
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DC7282130
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202E414386B;
	Mon, 26 Aug 2024 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMInmhEj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF09657CBA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664222; cv=none; b=T9adEBzyFcPGQtuGAche9n5KkxsPidk1QgOSffWbEpcILn/ME1qgRKZ6vGBQKO8Ww7H/kY69RPyMp8Wv1tpYRj/d2ab0YlkWu6tbrcVFgxoghr/dBdqnEcfuE5Y9VM/QnAicszL/xjIn9sZ3n/8DDmKDuLEbj35qgUrIrc3OkS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664222; c=relaxed/simple;
	bh=71telQe5u2/lKw7RfN9qGHW1wjYgdID/jPjgDLWtRq0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fzZY9VW/KkZGSvFH7w4idiOBMcZ5KojkmFqU1jVP4/+WWrSu9suOQ+HtrtzFKwa5uzBGAzNTjLBBK40ooCc+ok8PA+ihBlDwf9LCw/RAgS3lPoKwkGnpktQ0JcxTOIv+urkVlXcKn/9kxfmRiHMzjIZ9BaXPeTJUqIKM/NuuGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YMInmhEj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724664219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MkjXy/+CcBoacZKR/Pjt2a/67DruiSDyT8kYHTqBAUg=;
	b=YMInmhEj45ZOGF0lFfoiBj6fOOKy6VRlRRjE02cYlXEkRr9CfQQqDfInsoWZ/N2waNEVb0
	FrbCNHq4dHeE/uu2PpANn7FeWtKQR8qDF/wY10xOerU6P9aerlUjHappqYIGvsOQektTxx
	JkHzfXOKoAQZkAEog3b4SOcOE/r155E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-RMh53bYKOu6o21-_81pxJw-1; Mon,
 26 Aug 2024 05:23:34 -0400
X-MC-Unique: RMh53bYKOu6o21-_81pxJw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DB8E1955D47;
	Mon, 26 Aug 2024 09:23:33 +0000 (UTC)
Received: from [10.45.224.222] (unknown [10.45.224.222])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07E1619560A3;
	Mon, 26 Aug 2024 09:23:30 +0000 (UTC)
Date: Mon, 26 Aug 2024 11:23:26 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: =?GB2312?B?s8LT8bey?= <chenyufan@vivo.com>
cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: [PATCH v1] Device-mapper(LVM): Convert to use time_after_eq
 macro
In-Reply-To: <de43d61e-05c0-466f-b004-a97f2bf2ec39@vivo.com>
Message-ID: <9cdc4de9-82b8-87fe-4845-6b18ffe26d18@redhat.com>
References: <20240822015416.3627-1-chenyufan@vivo.com> <1abae895-7fb4-0342-21b9-1fd8e085dc9a@redhat.com> <bc1025c5-fa3c-4a49-9d91-d2d90e7423b4@vivo.com> <6f732dc5-b80e-0e79-a1dd-faebd0d91933@redhat.com> <de43d61e-05c0-466f-b004-a97f2bf2ec39@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811712-1301487623-1724664212=:882105"
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811712-1301487623-1724664212=:882105
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 26 Aug 2024, 陈玉凡 wrote:

> 在 2024/8/24 3:01, Mikulas Patocka 写道:
> 
> 
> On Fri, 23 Aug 2024, 陈玉凡 wrote:
> 
> 在 2024/8/23 1:08, Mikulas Patocka 写道:
> 
> On Thu, 22 Aug 2024, Chen Yufan wrote:
> 
> Use time_after_eq macro instead of opening it for readability.
> 
> Signed-off-by: Chen Yufan <chenyufan@vivo.com>
> ---
>   drivers/md/dm-writecache.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index 7ce8847b3..548d4d37e 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -16,6 +16,7 @@
>   #include <linux/pfn_t.h>
>   #include <linux/libnvdimm.h>
>   #include <linux/delay.h>
> +#include <linux/jiffies.h>
>   #include "dm-io-tracker.h"
>   
>   #define DM_MSG_PREFIX "writecache"
> @@ -1994,8 +1995,8 @@ static void writecache_writeback(struct work_struct *work)
>   	while (!list_empty(&wc->lru) &&
>   	       (wc->writeback_all ||
>   		wc->freelist_size + wc->writeback_size <= wc->freelist_low_watermark ||
> -		(jiffies - container_of(wc->lru.prev, struct wc_entry, lru)->age >=
> -		 wc->max_age - wc->max_age / MAX_AGE_DIV))) {
> +		(time_after_eq(jiffies, container_of(wc->lru.prev, struct wc_entry, lru)->age +
> +		 (wc->max_age - wc->max_age / MAX_AGE_DIV))))) {
>   
>   		n_walked++;
>   		if (unlikely(n_walked > WRITEBACK_LATENCY) &&
> -- 
> 2.39.0
> 
> I'm not sure about this. The old and new code is not really equivalent.
> 
> Mikulas
> 
> The code here is susceptible to overflow issues, and the time_*() macros 
> can handle this.
> 
> Chen
> 
> So, describe some case (i.e. the values of jiffies, 
> container_of(wc->lru.prev, struct wc_entry, lru)->age and wc->max_age) 
> where the old code misbehaves and the new code doesn't.
> 
> If we want to fix a bug, we need to know what the bug actually is.
> 
> Mikulas
> 
> When jiffies increased beyond the maximum value of unsigned long, it 
> wraps around to zero, and the value of jiffies would be smaller than the 
> container_of(wc->lru.prev, struct wc_entry, lru)->age value despite 
> logically being larger. Eventurally, because of the wraparound, the 
> result of the condition would be wrong.
> 
> Chen

For example, if "jiffies" is 0x10 (because it wrapped around) and 
"container_of(wc->lru.prev, struct wc_entry, lru)->age" is 0xfffffff0, 
then the expression "jiffies - container_of(wc->lru.prev, struct wc_entry, 
lru)->age" would be 0x20. That is the correct value, I don't see any 
problem with this.

Mikulas
---1463811712-1301487623-1724664212=:882105--


