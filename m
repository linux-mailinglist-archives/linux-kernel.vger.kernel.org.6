Return-Path: <linux-kernel+bounces-402319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BB39C2645
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B6C1C23745
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4204E1C3316;
	Fri,  8 Nov 2024 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0wW+rUgQ"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141141C1F24
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731096598; cv=none; b=EMC49lZK6rVE1IdMKdMQE5f1uBIa2c8Ez2z0XyXNtYpK3OGR+1a37+QZsawZ8RXSdAvoiBopCScmHzK0/mAzlqEu7itUMuLw3oD9cRst3ju3lULB/Cv+t8nBenpzE2QkjG1EtPF59XRf1zpACCWyCQsQ54La9FcAKVXdvyQnGe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731096598; c=relaxed/simple;
	bh=SXaPSXR2wH0iwxfDYf46FOc1GqDB95Jn2NxKS4L93+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PaFh+ZK2iBnT4LchFs2Fal99sFMYC1yKGxJzo6UeUpLZVscATabtyIB6AJLBxsjaVi46PTtg5c3OxzZ2rzhI72WSdEa5VYIbksCv+dZvw5O8NujxbJPDlf6NH6TI/4KS720maBOGRU3oNYZRvKcJoBArLllMsW5kvwE65mwxJ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0wW+rUgQ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e66ba398so2705e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 12:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731096595; x=1731701395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hf3tpCTalxz4qxYH5spgabs2ALD7qMqzUB+5d0zJbzU=;
        b=0wW+rUgQteVQp4jCqyTv35oOdwLS6WXSuYN6bTeZzgM4iKtaqW5QcXPmDp/XmaFF5d
         +C0hbZQAm/5JCDFjDGRWIbGCSSsps80hIKqlQne5VLJB45iG4fmJ+0S7dbZAnd/r57XT
         ad+ZDZjKSS24BdZhvvOzX9WfPBMLUJz9xcVTVBmNJznP15POLqBl2rRVRD6I/YKZat6+
         lCOxktSL35KgrJrf2ML94DH6Y2/vFa+4qmUo2gvdpab+qORl5mA/7LJ+j4QuMCszVv+s
         cwBCGB8/Xu3O+I+q46k8AK5NW5iT6R8kujWZiGAfMOH7Sq5pD+KB+OaDBTeGdn8lAWQe
         Bp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731096595; x=1731701395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hf3tpCTalxz4qxYH5spgabs2ALD7qMqzUB+5d0zJbzU=;
        b=On2WoIe9NOVNuWLhJUvy+c9mMOlhIvP8ojkUNaR+tThtWL0HCOE+fJQnnh134XWmvN
         CD0tgXog6hy1aKfFd2ScT6P+TWPgYTLyD4MHQJGod8zgxK5HpVxrm9P7pOUyE9tWHXfr
         8gxyOU9J9MGTX5/jBdEo0ephdMrUiyeIm0mxVkLAleflV5eW3TTUcF541yNWTU9OArCB
         d1kRKMtNChTOcFCPd2QxvO7hwsHwaoKNrp1lbAFacfkmZbQly0Rjqi7E96XetPyqbFow
         G15Ka6RQKDLuJtzU6KY2gkELEz/azUEwTf6Mi3FtEo7+iNsrYeeEVmXMgfMjF+YvCS+Y
         RfXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi3IcLC9xEo0Y+JiRo/6AxLRleD4ImmpageiLJrjB2wNiHPrx1v/ABrhFUv0rDZVWOHW0ZZMI4GDKchNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOGJjwjh2frD1bJ5vEtTgIn6zCvtQH3rat6GFdMnFSGRYDt2AM
	JR8yjbyMkR5LaUlWz6vBKO9lpnmpm79DRzxKflVSK8lpkwBZ5hZjn692ysp/twWhqIIXMMZ+yPP
	Ng891hRFXqgFpbxegmLVPNQDKw6XVO3oXlx6z
X-Gm-Gg: ASbGncuO4kAPnBfUKRNPN6WakjP6JyBnYnzpDazMzn8ujkeDF08EHYaWHRMMIf0tYAr
	D9jLobaZaSHM19nhtP9KC/fk81uQ3b2ZM2NFj3K7frMxt1KS+zGTkwXNMfgg=
X-Google-Smtp-Source: AGHT+IGxsSdDSM1ls7dyN2AAYI6rW5aYk+0vrPkBnevyKEM5jiIyRQHStd4kyGNLQuvzn4Ryu1xh43M9zjjV86MNM9M=
X-Received: by 2002:ac2:44cf:0:b0:533:49ab:780e with SMTP id
 2adb3069b0e04-53d8bd9a3e5mr67921e87.2.1731096593347; Fri, 08 Nov 2024
 12:09:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
 <c45cf245592ad4ccc86429f71500d3fc378ac4a4.1730360798.git.zhengqi.arch@bytedance.com>
 <CAG48ez0XhKnr3uVODu+iihRi4XwLupy=YX8BHa==1Y-ZvrmKjg@mail.gmail.com> <e308363a-0c1e-421f-a35e-5bb750992554@bytedance.com>
In-Reply-To: <e308363a-0c1e-421f-a35e-5bb750992554@bytedance.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 8 Nov 2024 21:09:17 +0100
Message-ID: <CAG48ez1xdvsyABAzaBmcmHWwLHzgyb4ORnNE5OG-As5Mq2=MgQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] x86: mm: free page table pages by RCU instead of
 semi RCU
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, david@redhat.com, hughd@google.com, 
	willy@infradead.org, mgorman@suse.de, muchun.song@linux.dev, 
	vbabka@kernel.org, akpm@linux-foundation.org, zokeefe@google.com, 
	rientjes@google.com, peterx@redhat.com, catalin.marinas@arm.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 8:38=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.com=
> wrote:
> On 2024/11/8 06:39, Jann Horn wrote:
> > On Thu, Oct 31, 2024 at 9:14=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedanc=
e.com> wrote:
> > free_pte
> >    pte_free_tlb
> >      __pte_free_tlb
> >        ___pte_free_tlb
> >          paravirt_tlb_remove_table
> >            tlb_remove_table [!CONFIG_PARAVIRT, Xen PV, Hyper-V, KVM]
> >              [no-free-memory slowpath:]
> >                tlb_table_invalidate
> >                tlb_remove_table_one
> >                  tlb_remove_table_sync_one [does IPI for GUP-fast]
>
>                    ^
>                    It seems that this step can be ommitted when
>                    CONFIG_PT_RECLAIM is enabled, because GUP-fast will
>                    disable IRQ, which can also serve as the RCU critical
>                    section.

Yeah, I think so too.

> >> +#ifdef CONFIG_PT_RECLAIM
> >> +static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
> >> +{
> >> +       struct page *page;
> >> +
> >> +       page =3D container_of(head, struct page, rcu_head);
> >> +       free_page_and_swap_cache(page);
> >> +}
> >
> > Why free_page_and_swap_cache()? Page tables shouldn't have swap cache,
> > so I think something like put_page() would do the job.
>
> Ah, I just did the same thing as __tlb_remove_table(). But I also
> have the same doubt as you, why does __tlb_remove_table() need to
> call free_page_and_swap_cache() instead of put_page().

I think commit 9e52fc2b50de3a1c08b44f94c610fbe998c0031a probably just
copy-pasted it from a more generic page freeing path...

