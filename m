Return-Path: <linux-kernel+bounces-278860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D7E94B5BD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B631C21BA6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6AD81AD2;
	Thu,  8 Aug 2024 04:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="QpGbMDmX"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C101D502
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 04:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723089881; cv=none; b=q+l+tYpc8UFFVvVec1zinJiJbkqwxdEWDTEsF8KKw/wmQO5o8zaw0jPcy5cPzYmSgwKVksvzgXUWhhnnxDi0Z+FtomqnD4kLRS19y+ZKTfMmIavDe5D+ir99HomKRc3AGxTb1FivXY0raNNAvhrBAODW+ojbqcae69MZucwCYWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723089881; c=relaxed/simple;
	bh=5T4yliEUXD2GyWcO3gOirN1YwWDNHBcjUYPLz0YK+Pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UbQg7v53MsXgYroRWLBzbZeOc78TII0oga0ruQXXvdnDRmW05hzDb45GGcCslexsZVrC02fwiKvvV/ebLcGvdDDuKuTTobj6gaGQt2lXHrs46JXrCr3Khttwcxm2VmDV8LnaZiqSxFt2lcoANhVGk0NLdwd/3yNGRy4903YDN94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=QpGbMDmX; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44ff7bdb5a6so3306601cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 21:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723089878; x=1723694678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLWCB8OwsSfViIae6+JL4jzVA8gtPMCZnWmBMW4Tb+I=;
        b=QpGbMDmXkGhcOLvB6S3jFVmiccu8Vo1muHPpmgQf1UNbPRdR5Q5fVILxW9SavKFUYF
         iBQwNrpxN+CWq/j8mEBiak3T3ctMkM881lXQM6+Ctfq93oF618t3k4gj4KQ5wVvF2PJk
         gGEqVQtfVgIZRVeAOoDIiPWhoRDGvdw8/+fwJNxkuu4hcBf3TOf0tGfW1XsbiRpjMf+s
         koC7yvNjBNMFVLpj3zKXe1i3HUyxDyuHinSjfuKHmVUh2S6cxL/oPR4ApTSi92oD4mbD
         rTA50m1onsFcbBi18cQqO4q4aJlhqEhA5RVfS4WOR7uCD+GVa6QF0ycdK/FqoXg9pwkY
         fBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723089878; x=1723694678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLWCB8OwsSfViIae6+JL4jzVA8gtPMCZnWmBMW4Tb+I=;
        b=QOhx0DP44RNPPowtzqyWzAPXpYLb1fn/K1BWUnxx/ZQYUBLRqg9Acy8fpI8EJGjZGw
         G4OfuEk+z8FiztuJjV85oiROxaN1LZTQcmE3a5ZQGCCKpX70BfJVpI/Vd3T5SMn3+eeo
         IbhFykCY/xaiRhFCrM/k2MBVeVmMCntjb0R2W1aajbdCbm9ERrNyNqda9A9A8MdW0yY/
         7UtMkolQTi/zGnuJqAH7O26mkKQxQNhpzK6iwKVGWwmreTkSvS/nN//fzy/hf9w9IQvV
         zXe/omQBHYSMl1aiTOneVXmVggVZuDifu6QAXn7oszf+oaw6901HVpNK+j4BABb4aXKW
         F5/w==
X-Forwarded-Encrypted: i=1; AJvYcCV8drANjq1m3UawiP+GM8VLKAQcDbC2c/qKh4mTFdxrmCf+jYamlvQRHwPBilenUppvcl1S5EJmkUUcQhE6XpeJXA3ljCrvJ/A/4wlX
X-Gm-Message-State: AOJu0YxhQcOkAC3RWEdAeW5mORm4oAVWDK86O2pYiE4MGTvFNkmGbFnj
	We8gZ15z1R5Kc9vxXBnPPVlHHBkx2yFZu25uMxqFsO7TlQ6B40kGo/hkJXwb0SJ0YpgDiIyP41w
	3biuhvUMh3AbOc1Bxzk+cJRo6H7KFQ5W+ayAcQg==
X-Google-Smtp-Source: AGHT+IG3rFoWDGrZWFr40yiagl0NYBAUuSGLIHHSR0Qq8SIRGT82Tmfyf9cpNzAf9Euu7zdl5Ocb94WVlep5eC+ie0w=
X-Received: by 2002:a05:622a:510c:b0:447:e046:8482 with SMTP id
 d75a77b69052e-451d421cb8dmr11194011cf.23.1723089878291; Wed, 07 Aug 2024
 21:04:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807211929.3433304-1-pasha.tatashin@soleen.com>
 <20240807211929.3433304-4-pasha.tatashin@soleen.com> <E5F2A1F6-DD29-4FD8-B4AA-2CA917F6E89F@linux.dev>
In-Reply-To: <E5F2A1F6-DD29-4FD8-B4AA-2CA917F6E89F@linux.dev>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 8 Aug 2024 00:04:00 -0400
Message-ID: <CA+CK2bCOYYkGK6yDm4NKto15TjgNGXrDDbhkx1=rGeyQ-ofv9w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm: don't account memmap per node
To: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, cerasuolodomenico@gmail.com, 
	Johannes Weiner <hannes@cmpxchg.org>, Joel Granados <j.granados@samsung.com>, lizhijian@fujitsu.com, 
	Nhat Pham <nphamcs@gmail.com>, David Rientjes <rientjes@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Sourav Panda <souravpanda@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 10:59=E2=80=AFPM Muchun Song <muchun.song@linux.dev>=
 wrote:
>
>
>
> > On Aug 8, 2024, at 05:19, Pasha Tatashin <pasha.tatashin@soleen.com> wr=
ote:
> >
> > Currently, when memory is hot-plugged or hot-removed the accounting is
> > done based on the assumption that memmap is allocated from the same nod=
e
> > as the hot-plugged/hot-removed memory, which is not always the case.
> >
> > In addition, there are challenges with keeping the node id of the memor=
y
> > that is being remove to the time when memmap accounting is actually
> > performed: since this is done after remove_pfn_range_from_zone(), and
> > also after remove_memory_block_devices(). Meaning that we cannot use
> > pgdat nor walking though memblocks to get the nid.
> >
> > Given all of that, account the memmap overhead system wide instead.
>
> Hi Pasha,
>
> You've changed it to vm event mechanism. But I found a comment (below) sa=
y
> "CONFIG_VM_EVENT_COUNTERS". I do not know why it has such a rule
> sice 2006. Now the rule should be changed, is there any effect to users o=
f
> /proc/vmstat?

There should not be any effect on the users of the /proc/vmstat, the
values for nr_memap and nr_memmap_boot before and after are still in
/proc/vmstat under the same names.

>
> /*
>  * Light weight per cpu counter implementation.
>  *
>  * Counters should only be incremented and no critical kernel component
>  * should rely on the counter values.
>  *
>  * Counters are handled completely inline. On many platforms the code
>  * generated will simply be the increment of a global address.

Thank you for noticing this. Based on my digging, it looks like this
comment means that the increment only produces the most efficient code
on some architectures (i.e. i386, ia64):

Here is the original commit message from 6/30/06:
f8891e5e1f93a1 [PATCH] Lightweight event counters

 Relevant information:
  The implementation of these counters is through inline code that hopefull=
y
  results in only a single instruction increment instruction being emitted
  (i386, x86_64) or in the increment being hidden though instruction
  concurrency (EPIC architectures such as ia64 can get that done).

My patch does not change anything in other places where vm_events are
used, so it won't introduce performance regression anywhere. Memmap,
increment and decrement can happen based on the value of delta. I have
tested, and it works correctly. Perhaps we should update the comment.

Pasha

