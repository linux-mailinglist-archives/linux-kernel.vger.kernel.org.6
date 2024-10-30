Return-Path: <linux-kernel+bounces-388637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C149B6262
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08CA1B20D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80891E7C0A;
	Wed, 30 Oct 2024 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5fOB86V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C60F1E573F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730289483; cv=none; b=LmnQbuG7UMOlTE6fboUZIt08XlQlxuBTCZn9ivAIzynzWXM8YM+e+rJx/FvKY9rw+hVVt0Sn32YBRRizBh5zxSSoG2g5xVrHuG+5vo07C/assf+BiLQ/UEhLGeb2GPMAZqLI6rvf23AUAsgCX10uw7f4cu6a2zuvD51SVKBFzZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730289483; c=relaxed/simple;
	bh=+unSjnXH5Cb2JXz2/L4dsEP7mbwUy2ht9QU3aEK55LU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NfzJaywXug5ardf7lBFLpN6uXW7scaKAzP/lo8AmVcxnJbvSK7QN441+vb0S3OVZgtZR5iyBymIkELi5AHL0EA5ddrcrGhlv272QGdSQRg5/aTQSPOaaK44+ouVlIkWUeGOcW+mUMbdTdCt6wa1LS6OVKh5XxftBkvLBkpRYaDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S5fOB86V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730289480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+unSjnXH5Cb2JXz2/L4dsEP7mbwUy2ht9QU3aEK55LU=;
	b=S5fOB86VtvWD+WTvQy44IK3Nzs7aekgT6bxjTnbGn9UEmMIBGIBkwkWGLefmP4hTF7rHCL
	AiaIIRIq4jHakiHly4m4Mm10daD1KjSUcWr/ckFputBoG8hVKydS++giOzR8+fPe4MhmnN
	sKjmHYLgvVzW7lpZGbg4mLcXNVAWVIg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-aOBqEZunPAiXs3nNtyKXkQ-1; Wed, 30 Oct 2024 07:57:58 -0400
X-MC-Unique: aOBqEZunPAiXs3nNtyKXkQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a99f084683fso471683566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730289477; x=1730894277;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+unSjnXH5Cb2JXz2/L4dsEP7mbwUy2ht9QU3aEK55LU=;
        b=wv6y3XF3S/dMEbg2lq/+Mguinsbe8dVOUCj3MY4vvEQfPmHixWswuOOqN8oIG5e0YO
         uZRoQNHnBOsgP17jv+rxHA++FuSc3xK59Zt9umFLHdPnvk20Qwx0pASChfz9nHIFwXyB
         0h26QAwOHB/FIZ1mxIYwNzxfAnWjAxU36E9ItfvswDcl4DZvuzVB6XAjXdxvvZ1pZ8nJ
         mmfyMYvojfm3KkmPvJGzmpqkgFKWfF76fWKh0lIJHucbkZdvAqB1A6QH5eTwI4R8IOqj
         87Xqzjw6M6HUX98fVHlEk3WRm0IKSe0cnDMS5qFttSn3WgfA3QRLdZKj+YuGfkxkcbJc
         gRpg==
X-Forwarded-Encrypted: i=1; AJvYcCVyI30jrDfCMGflMoloKGnSt4ydhgW1CTH7snoxeBsnIkFp4xEY9GWIWq2TfYOKgcN+Maj3ThF0KGGyloM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOqBdGtI5JpaSzfnEpNIdBWgeO2G5a46AvXXPc1vOPasXF+BcX
	82h5Y2idVYzxRSTglHOg/UcKE7ZbdqTwbbjqx8F4iSQkCww3KcENoashf0ec9f6rZUrfEbY9Ggc
	nnrFvhFRiibfcsh0rS+K8p002lSLJPbvd4I26p1MZmCZ9zp45Y5vs20GRkUlx1g==
X-Received: by 2002:a17:907:6d15:b0:a99:ecaf:4543 with SMTP id a640c23a62f3a-a9de5d8272dmr1567689766b.25.1730289477278;
        Wed, 30 Oct 2024 04:57:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVLgw5rE9QA3Icf5YbgX5jGmETg3oQl1odAk1S8jhHGqLiYvv6XcYW/kBL6ZHibuCo5cMEsg==
X-Received: by 2002:a17:907:6d15:b0:a99:ecaf:4543 with SMTP id a640c23a62f3a-a9de5d8272dmr1567687166b.25.1730289476927;
        Wed, 30 Oct 2024 04:57:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f2982e1sm568328366b.99.2024.10.30.04.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:57:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 49BAC164B390; Wed, 30 Oct 2024 12:57:55 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: zhangkun09@huawei.com, fanghaiqing@huawei.com, liuyonglong@huawei.com,
 Robin Murphy <robin.murphy@arm.com>, Alexander Duyck
 <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
In-Reply-To: <1eac33ae-e8e1-4437-9403-57291ba4ced6@huawei.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com> <878qudftsn.fsf@toke.dk>
 <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com> <87r084e8lc.fsf@toke.dk>
 <cf1911c5-622f-484c-9ee5-11e1ac83da24@huawei.com> <878qu7c8om.fsf@toke.dk>
 <1eac33ae-e8e1-4437-9403-57291ba4ced6@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 30 Oct 2024 12:57:55 +0100
Message-ID: <87o731by64.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yunsheng Lin <linyunsheng@huawei.com> writes:

>> But, well, I'm not sure it is? You seem to be taking it as axiomatic
>> that the wait in itself is bad. Why? It's just a bit memory being held
>> on to while it is still in use, and so what?
>
> Actually, I thought about adding some sort of timeout or kicking based on
> jakub's waiting patch too.
>
> But after looking at more caching in the networking, waiting and kicking/flushing
> seems harder than recording the inflight pages, mainly because kicking/flushing
> need very subsystem using page_pool owned page to provide a kicking/flushing
> mechanism for it to work, not to mention how much time does it take to do all
> the kicking/flushing.

Eliding the details above, but yeah, you're right, there are probably
some pernicious details to get right if we want to flush all caches. S
I wouldn't do that to start with. Instead, just add the waiting to start
with, then wait and see if this actually turns out to be a problem in
practice. And if it is, identify the source of that problem, deal with
it, rinse and repeat :)

-Toke


