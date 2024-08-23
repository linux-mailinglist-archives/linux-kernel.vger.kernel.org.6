Return-Path: <linux-kernel+bounces-299517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B531B95D5B6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE011F23BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBD918F2F6;
	Fri, 23 Aug 2024 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGj5RxzO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A8D18BC30
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439686; cv=none; b=s+wRLNAHQBIbsuceGAfjdS28lxe/3GYdNXLag7g4QDu/BVLhVNZukz2kk4U2b5RddFYiLQ+WMkR1hkLQNNj6sX8bpuBZPciJr70PUr2EbFfqbWjNDQxNHls9Yy7agxNNC5dBM/ioizgneeczDn02Vl8Hxj32aADFTnsrNwAiOpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439686; c=relaxed/simple;
	bh=XM29QN1zNdWqSYn3JhQ8CIliLRh7S+UaeuU0ediUmVI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nw/uT4XqZjjhNdd3z9s/47rXx7Y9J5q/utQIEoh5d87A9D7hFcP66kRQVwndSNrLvVozZlc/Ym59w9dGzkQaZEF1+g7+4f1uVKcyCIhKP7/FAOgGOZf03rdGFNrlbeY4sYoRhi4HwH4ztRChMj6P4jX2mXzW+X6TRHSoU3B9Dw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGj5RxzO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724439683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bk3r4/l3ko/4wgWLAt441cHjNkjE8LMnufEljr7zc6g=;
	b=EGj5RxzOGhXciVk/TvQfRU+Br1/aknyrIPf77zXqnw+pNlcVPa0O6eNt+3N7zUV3F+WFnZ
	4wX62HRFBPG7eGxDsfwCvonHvykMWWFa7Isbv6wiqckyOvKxBQbxTwteyLDU31/nvY+4Fw
	3DuQUm4/iLBeqw4azELmKZkvRi00w8g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-InkpVxeGPESYWMrwVhPYHA-1; Fri,
 23 Aug 2024 15:01:16 -0400
X-MC-Unique: InkpVxeGPESYWMrwVhPYHA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 800611956080;
	Fri, 23 Aug 2024 19:01:14 +0000 (UTC)
Received: from [10.45.224.222] (unknown [10.45.224.222])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B9D2300019C;
	Fri, 23 Aug 2024 19:01:11 +0000 (UTC)
Date: Fri, 23 Aug 2024 21:01:08 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: =?GB2312?B?s8LT8bey?= <chenyufan@vivo.com>
cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: [PATCH v1] Device-mapper(LVM): Convert to use time_after_eq
 macro
In-Reply-To: <bc1025c5-fa3c-4a49-9d91-d2d90e7423b4@vivo.com>
Message-ID: <6f732dc5-b80e-0e79-a1dd-faebd0d91933@redhat.com>
References: <20240822015416.3627-1-chenyufan@vivo.com> <1abae895-7fb4-0342-21b9-1fd8e085dc9a@redhat.com> <bc1025c5-fa3c-4a49-9d91-d2d90e7423b4@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811712-1359953336-1724439674=:765655"
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811712-1359953336-1724439674=:765655
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Fri, 23 Aug 2024, 陈玉凡 wrote:

> 在 2024/8/23 1:08, Mikulas Patocka 写道:
> >
> > On Thu, 22 Aug 2024, Chen Yufan wrote:
> >
> >> Use time_after_eq macro instead of opening it for readability.
> >>
> >> Signed-off-by: Chen Yufan <chenyufan@vivo.com>
> >> ---
> >>   drivers/md/dm-writecache.c | 5 +++--
> >>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> >> index 7ce8847b3..548d4d37e 100644
> >> --- a/drivers/md/dm-writecache.c
> >> +++ b/drivers/md/dm-writecache.c
> >> @@ -16,6 +16,7 @@
> >>   #include <linux/pfn_t.h>
> >>   #include <linux/libnvdimm.h>
> >>   #include <linux/delay.h>
> >> +#include <linux/jiffies.h>
> >>   #include "dm-io-tracker.h"
> >>   
> >>   #define DM_MSG_PREFIX "writecache"
> >> @@ -1994,8 +1995,8 @@ static void writecache_writeback(struct work_struct *work)
> >>   	while (!list_empty(&wc->lru) &&
> >>   	       (wc->writeback_all ||
> >>   		wc->freelist_size + wc->writeback_size <= wc->freelist_low_watermark ||
> >> -		(jiffies - container_of(wc->lru.prev, struct wc_entry, lru)->age >=
> >> -		 wc->max_age - wc->max_age / MAX_AGE_DIV))) {
> >> +		(time_after_eq(jiffies, container_of(wc->lru.prev, struct wc_entry, lru)->age +
> >> +		 (wc->max_age - wc->max_age / MAX_AGE_DIV))))) {
> >>   
> >>   		n_walked++;
> >>   		if (unlikely(n_walked > WRITEBACK_LATENCY) &&
> >> -- 
> >> 2.39.0
> > I'm not sure about this. The old and new code is not really equivalent.
> >
> > Mikulas
> 
> The code here is susceptible to overflow issues, and the time_*() macros 
> can handle this.
> 
> Chen

So, describe some case (i.e. the values of jiffies, 
container_of(wc->lru.prev, struct wc_entry, lru)->age and wc->max_age) 
where the old code misbehaves and the new code doesn't.

If we want to fix a bug, we need to know what the bug actually is.

Mikulas
---1463811712-1359953336-1724439674=:765655--


