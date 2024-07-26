Return-Path: <linux-kernel+bounces-262840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD6593CD98
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1B61F2211F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 05:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576AF39AEC;
	Fri, 26 Jul 2024 05:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtkVEcFt"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1527B381BD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721971798; cv=none; b=c9PJALt1gt8sZacjLoTdKZwUg82onU1e90OGQGyVXYr61dPqjNUAk2GSRAZCCB//jNUVnRnLq1rbLN6BDdfLiP4WzSKTu1IF4ZAi7e8IcomIbXwg7gP8jgadXZARyPYaOf6iXuAgCL0+vtSsJYBkQupPeqR0ZnPDkdNPL6mC/iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721971798; c=relaxed/simple;
	bh=66dBSVK6Mq2VOAzCsV/C7OQnAqkL2BqwrFs9p7gcs3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+XLVdavR4zMsFr0C6Qn7YpEwMa5oHHoukAljsybmqVaT+rOyiDfq0ILbal6Y+O+oFXIgVmU//bhs2FGYjTJX3IzNk6PckWbukcru9zI3BMpmRLVf0Zcvt4sHtVnDFbaCSk4jkZF+foiemqZ5HugIBE1T/oq2vyfqBso0q4cxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtkVEcFt; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f50dd3eab9so107662e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 22:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721971796; x=1722576596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtvEPRvVT6P08LbTj9n6n9WKl7c6OVDzze2g6xsE7DE=;
        b=VtkVEcFtVeYR6snjjPL2UXiKo0bJb2JsYdIhRkxB3xN2XACSkqha7MwvWIc90r0ctU
         wLr6IJGy4nJiRSq5MfWEhqKptetCtGus1cVZbH8LdCcj57Yibj29vOm7zT4opZ+DQ4Jq
         w0Ej0LBx1LPr7RYRwnY+zCqzKudUjVkjzKzZuKjwgfOVUPHcQKalQ+1bsTIlD5GzuOPn
         SOOTh5cD7Z37iCQh4ghWwBClXDx26yctsQhxQoi2OLwZ36rm+xPVN3UiwtSe+4Egn3Oo
         9i5N28pKwaYGMURzY1oNMbsWwlLB+bceocH6V1RHBlEurqEVmLJZz9RvGla/ijsgBGr4
         kRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721971796; x=1722576596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtvEPRvVT6P08LbTj9n6n9WKl7c6OVDzze2g6xsE7DE=;
        b=fQCkjbqWHpJJeEJ1lJ9HRYqR1ci4lNOo7e1q1GtU2WqaAhOey11yx1TvDJek5wE5yn
         9CQ0HSUYQHOAGTzfdbopjX0RAtZkoj98d+IBqF7TJjBW+hbqRfMwqx8S+MSXPUxszPyN
         kD7nDi6say+y/DPAjor/0rcXCJFgEVvsQ8ZGTxWZqB6x3aF9SL1X89lZk+1sX3ZUBGcH
         rKbb/RjV2vv99HC+LPkEfVbqzDAKtnagEgvURZUUyQGsIi3guY3VBaHjexX5Xu8Ho9p2
         Lg/ajSwecoq4VsH/E2cEggU+DL3/MY4w3P0N906I55UANyDr7RqURI5bmi2otb7BLa2r
         vchQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEGIrMMpWilLDJ32qaPo8avVUwSwTKrm5xH5V+VvVWIgfWI3vCuEOOsfmE7whoQfD8ZBAFpusEScKZSlAb8fyf9RDjv8pWActi28Zp
X-Gm-Message-State: AOJu0Yyb7fwj+D78xFFGOtj/R8lLLjUXjckDPeUR++7vpjzDUBCarzSJ
	zaW+lvK8HibD3I/Fq0nvQra2PfA0GMeXemdkFQsAGXrbvfAnC3K1daKZETrIXO2jOzWx/JDdtRe
	BuAfLf7r1vu3dLh2rvo3qBbxgNyc=
X-Google-Smtp-Source: AGHT+IFgsokiU004rCnirxcltPgVF00Ev7xNNGQ8SdWAEbfO927jp75/niejt62iKcmxuP5K4l3qiUxL/Akfiopc0Oc=
X-Received: by 2002:a05:6122:91d:b0:4ed:14e:9342 with SMTP id
 71dfb90a1353d-4f6c5b5a63amr6117959e0c.1.1721971795746; Thu, 25 Jul 2024
 22:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725035318.471-1-hailong.liu@oppo.com> <ZqI5V+5E3RNhuSwx@MiWiFi-R3L-srv>
 <20240725164003.ft6huabwa5dqoy2g@oppo.com> <ZqMKZ67YhzhbqYg9@MiWiFi-R3L-srv>
 <20240726040052.hs2gvpktrnlbvhsq@oppo.com> <20240726050356.ludmpxfee6erlxxt@oppo.com>
In-Reply-To: <20240726050356.ludmpxfee6erlxxt@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 26 Jul 2024 17:29:44 +1200
Message-ID: <CAGsJ_4xOauOwkHO5MTKHBP=fpeoNiP_9VJ31G4gBECFvLG4y0g@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm/vmalloc: fix incorrect __vmap_pages_range_noflush()
 if vm_area_alloc_pages() from high order fallback to order0
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Baoquan He <bhe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, Tangquan Zheng <zhengtangquan@oppo.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 5:04=E2=80=AFPM Hailong Liu <hailong.liu@oppo.com> =
wrote:
>
> On Fri, 26. Jul 12:00, Hailong Liu wrote:
> > On Fri, 26. Jul 10:31, Baoquan He wrote:
> > [...]
> > > > The logic of this patch is somewhat similar to my first one. If hig=
h order
> > > > allocation fails, it will go normal mapping.
> > > >
> > > > However I also save the fallback position. The ones before this pos=
ition are
> > > > used for huge mapping, the ones >=3D position for normal mapping as=
 Barry said.
> > > > "support the combination of PMD and PTE mapping". this  will take s=
ome
> > > > times as it needs to address the corner cases and do some tests.
> > >
> > > Hmm, we may not need to worry about the imperfect mapping. Currently
> > > there are two places setting VM_ALLOW_HUGE_VMAP: __kvmalloc_node_nopr=
of()
> > > and vmalloc_huge().
> > >
> > > For vmalloc_huge(), it's called in below three interfaces which are a=
ll
> > > invoked during boot. Basically they can succeed to get required conti=
guous
> > > physical memory. I guess that's why Tangquan only spot this issue on =
kvmalloc
> > > invocation when the required size exceeds e.g 2M. For kvmalloc_node()=
,
> > > we have told that in the code comment above __kvmalloc_node_noprof(),
> > > it's a best effort behaviour.
> > >
> > Take a __vmalloc_node_range(2.1M, VM_ALLOW_HUGE_VMAP) as a example.
> > because the align requirement of huge. the real size is 4M.
> > if allocation first order-9 successfully and the next failed. becuase t=
he
> > fallback, the layout out pages would be like order9 - 512 * order0
> > order9 support huge mapping, but order0 not.
> > with the patch above, would call vmap_small_pages_range_noflush() and d=
o normal
> > mapping, the huge mapping would not exist.
> >
> > >  mm/mm_init.c <<alloc_large_system_hash>>
> > >  table =3D vmalloc_huge(size, gfp_flags);
> > >  net/ipv4/inet_hashtables.c <<inet_pernet_hashinfo_alloc>>
> > >  new_hashinfo->ehash =3D vmalloc_huge(ehash_entries * sizeof(struct i=
net_ehash_bucket),
> > >  net/ipv4/udp.c <<udp_pernet_table_alloc>>
> > >  udptable->hash =3D vmalloc_huge(hash_entries * 2 * sizeof(struct udp=
_hslot)
> > >
> > > Maybe we should add code comment or document to notice people that th=
e
> > > contiguous physical pages are not guaranteed for vmalloc_huge() if yo=
u
> > > use it after boot.
> > >
> > > >
> > > > IMO, the draft can fix the current issue, it also does not have sig=
nificant side
> > > > effects. Barry, what do you think about this patch? If you think it=
's okay,
> > > > I will split this patch into two: one to remove the VM_ALLOW_HUGE_V=
MAP and the
> > > > other to address the current mapping issue.
> > > >
> > > > --
> > > > help you, help me,
> > > > Hailong.
> > > >
> > >
> > >
> I check the code, the issue only happen in gfp_mask with __GFP_NOFAIL and
> fallback to order 0, actuaally without this commit
> e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")
> if __vmalloc_area_node allocation failed, it will goto fail and try order=
-0.
>
> fail:
>         if (shift > PAGE_SHIFT) {
>                 shift =3D PAGE_SHIFT;
>                 align =3D real_align;
>                 size =3D real_size;
>                 goto again;
>         }
>
> So do we really need fallback to order-0 if nofail?

Good catch, this is what I missed. I feel we can revert Michal's fix.
And just remove __GFP_NOFAIL bit when we are still allocating
by high-order. When "goto again" happens, we will allocate by
order-0, in this case, we keep the __GFP_NOFAIL.

> >
> > --
> > help you, help me,
> > Hailong.

Thanks
Barry

