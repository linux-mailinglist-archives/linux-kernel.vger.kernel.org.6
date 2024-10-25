Return-Path: <linux-kernel+bounces-381022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 689479AF933
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279252834F1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7F018E054;
	Fri, 25 Oct 2024 05:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nC82eifV"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8EC176AAD
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 05:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729834897; cv=none; b=kPAgSMZynk8OiUGqK9LHxU1zhwEIpOdo+uFsVmcn+1dbPlsm5OgTfeF6VH4/HI5ahPl47v5ZXUGaCFxab1UqcAaLLkbanlevy/2+5/bHAPzNhzlTaMFJdH742kPWYAP2wGLY8v0lrStiidCdJRjWaUGfPnMNzoFi5GJXi1cU+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729834897; c=relaxed/simple;
	bh=SN9U4BptMLX7ZOYkn/Cbn1wN9xs5UL4NOWh1pQ/IUYs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Y5Y2GIOxfjyK8Qa0MFaeukeYDAMi1bK8aOFlyn2vuuVlS5XwcRqUtkOYJ7CFEXCNv81rngAnecisJadANIKsHzCke/oz4/T8FAxyEbLUtQ1PQ768Bi0c8YqJbU/HE3XtCBb81+YPQVvR7v7oWFp+nsFF2y0yAVmn0ysFkQ47Zxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nC82eifV; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7183a3f3beaso1003779a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 22:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729834894; x=1730439694; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U8gDvgJg3Z19JQm8nPvjNW9GLKb42/hZuKryzCAKj00=;
        b=nC82eifV6JEs6qdN0Y1tbU5LqtYfdS8BuMPYHbe8AQnq3WJWDxUTB2h4WJZYQROolv
         KUNjITtm4aO5J5QxbBDeKDI4AQcrOFp3Ee7iSW5jr8aLoww9zW2DxQN97SCLHmAN91QE
         vXuZN6Hp57FSH17vitRUBdZW+XDSQ5SRMHobqMhwo0tjcSbcmxiPMvC0kFtIPGeRf0qS
         7TKZyxR4xvpVxi0hRWe4KCqoNLqEhrXbvij82BnnVhgIfj8Ub89mBetLEKxrLNPbwS7F
         RoDmaUyNnV773o73RPHvr6AJM+/dnXiearkSirbK0Obe1LyVJhkyEBapAvMDRxppTB7Z
         Gobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729834894; x=1730439694;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8gDvgJg3Z19JQm8nPvjNW9GLKb42/hZuKryzCAKj00=;
        b=aow0o8ewaGTkLLaQSmvnLnx4omK6Cb3P0vC8xiqKch6zSdd3UqqmiDEYeu5rsDQTM+
         HhfRFSgNzuK3OVaHZOQqEdNWN3jn569xAZjs7Wvl8BBQ488dBvZAFOtgUtR353rLqeZY
         GSd33NlbeonDBaWgZ4bylC9w2CRdRxRwJ0uprOEOM589D7HljhEitYFN9FjZKLwao1tD
         Wk9555kCJaVTd/Ww2mk8KAM4iw0inPiEIozIdKmnGVqjs8Xuu28lligNBuIy9UzEAX4g
         /e3+jbBRe+bCHCP+lYBGRYi25W2WTbKx9v4bBUTasuVjaTNOfnoK31weZ7STUgoind9/
         CgJw==
X-Forwarded-Encrypted: i=1; AJvYcCWW+54puL4GsZzVb0WFrWTgzJZ4ZjMEbAz9D0QfxdXbv/kjY9L5mFk+MhkbzKbQythknKhFE0GMIFS86FM=@vger.kernel.org
X-Gm-Message-State: AOJu0YycKjQLWeM+nurHPXgcHSS39fJtjnxnQkOhCpRoRyyenzPNgVzK
	jIJuD7GbY1+6+kuv3zmE14o/xdpbDD601WdEMQq6l42DbPbYKLVeU2SImAUL4Q==
X-Google-Smtp-Source: AGHT+IH35LbnqZnz2MEhPcWo8pALPNMvotL/XItOiTeeEUgG53iEA89bzekf4xU3ZhH9A1wuQ24HeA==
X-Received: by 2002:a05:6830:310c:b0:717:f864:90cb with SMTP id 46e09a7af769-7185940e4admr4008880a34.4.1729834894298;
        Thu, 24 Oct 2024 22:41:34 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a3af59sm332273b3a.186.2024.10.24.22.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 22:41:32 -0700 (PDT)
Date: Thu, 24 Oct 2024 22:41:21 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Zi Yan <ziy@nvidia.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Usama Arif <usamaarif642@gmail.com>, Yang Shi <shy828301@gmail.com>, 
    Wei Yang <richard.weiyang@gmail.com>, 
    "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
    Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
    Ryan Roberts <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>, 
    Chris Li <chrisl@kernel.org>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH hotfix 1/2] mm/thp: fix deferred split queue not
 partially_mapped
In-Reply-To: <3A1E5353-D8C5-4D38-A3FF-BFC671FC25CE@nvidia.com>
Message-ID: <966a4aff-f587-c4bb-1e10-2673734c2aa0@google.com>
References: <760237a3-69d6-9197-432d-0306d52c048a@google.com> <3A1E5353-D8C5-4D38-A3FF-BFC671FC25CE@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 24 Oct 2024, Zi Yan wrote:
> On 24 Oct 2024, at 0:10, Hugh Dickins wrote:
> 
> > The new unlocked list_del_init() in deferred_split_scan() is buggy.
> > I gave bad advice, it looks plausible since that's a local on-stack
> > list, but the fact is that it can race with a third party freeing or
> > migrating the preceding folio (properly unqueueing it with refcount 0
> > while holding split_queue_lock), thereby corrupting the list linkage.
> >
> > The obvious answer would be to take split_queue_lock there: but it has
> > a long history of contention, so I'm reluctant to add to that. Instead,
> > make sure that there is always one safe (raised refcount) folio before,
> > by delaying its folio_put().  (And of course I was wrong to suggest
> > updating split_queue_len without the lock: leave that until the splice.)
> 
> I feel like this is not the right approach, since it breaks the existing
> condition of changing folio->_deferred_list, namely taking
> ds_queue->split_queue_lock for serialization. The contention might not be
> as high as you think, since if a folio were split, the split_queue_lock
> needed to be taken during split anyway. So the worse case is the same
> as all folios are split. Do you see significant perf degradation due to
> taking the lock when doing list_del_init()?
> 
> I am afraid if we take this route, we might hit hard-to-debug bugs
> in the future when someone touches the code.

You have a good point: I am adding another element of trickiness
to that already-tricky local-but-not-quite list - which has tripped
us up a few times in the past.

I do still feel that this solution is right in the spirit of that list;
but I've certainly not done any performance measurement to justify it,
nor would I ever trust my skill to do so.  I just tried to solve the
corruptions in what I thought was the best way.

(To be honest, I found this solution to the corruptions first, and thought
the bug went back to the original implemention: that its put_page() at the
end of the loop was premature all along.  It was only when writing the
commit message two days ago, that I came to realize that even put_page()
or folio_put() would be safely using the lock to unqueue: that it is only
this new list_del_init() which is the exception which introduces the bug.)

Looking at vmstats, I'm coming to believe that the performance advantage
of this way is likely to be in the noise: that mTHPs alone, and the
!partially_mapped case on top, are greatly increasing the split_deferred
stats: and may give rise to renewed complaints of lock contention, with
or without this optimization.

While I still prefer to stick with what's posted and most tested, I am
giving the locked version a run overnight.  Thanks a lot for the reviews
and acks everyone: at present Zi Yan is in the minority preferring a
locked version, but please feel free to change your vote if you wish.

Hugh

