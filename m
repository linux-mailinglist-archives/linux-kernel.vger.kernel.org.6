Return-Path: <linux-kernel+bounces-174078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4768C09FE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84287B220CB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9C614601F;
	Thu,  9 May 2024 03:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BP1CM1DZ"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E4812BEA4
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715224162; cv=none; b=qeFclPI2nWbZWExuhCAgzcwMR1/WI241AdNETfP+Z2OBUn4fYgyd28fciorNrfz8PHiLVWyzhypQ/c54rT6XTwd0o/Ta/g9vgd3QtDNdqGBuzNvP6lSgXURx7hfQIB1kfbphJE12W/HkZBpVH/o4tnUwQ4Ypz4S3oxoFxDJKNG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715224162; c=relaxed/simple;
	bh=Tr9u5FKM0KlukAPyAfGt2WLtyejJAu0FQLn2JmwYL2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SP/z7bvJFoxDxOpRiOnCZJpNynZsJH/xcrI85CXcbAdo/tBh05+K91+wu6ASBpYWVG5YAROPxl+EiRfb9C46VEJVcRmeTMlNCMeOZw2DVfteLzoIDHQAbjs6DYR1uF/SpFOHCRHJVV8w/le0yiSp/lDfmRUSHdRuXuSG534Tid4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BP1CM1DZ; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4df29c84f60so259868e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 20:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715224159; x=1715828959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8ZuJSLHVy2XSy/nvCPgDIRow5iMVn6G7A/A6pwXhWw=;
        b=BP1CM1DZcJjmubeJYl/KHYeqXaUMsGKuGnhHABUj91PWS5yGH7w1jhPgGwIBiU/CzC
         jd4BKuDTn1I5PwDXc8FMsz/IpAZKQj4mrre8KEDdsXFL8C67CdzNBG6HzYF01cwj2tIY
         sHefFlfK2DAg8Czju8rXfMsbY5UTGFsjjuMrLkOI27Fc3hD+koAwmgrtPJEQgd0PwgPu
         TRcbDeLELFrDW0sTCSCI9k50RWWlR6et8ISmE1m79GDJSDKqDqTv/0BHExGDT3W1enoG
         5FyNB16FG0PoIODOkYlreq1fTraxNV1n/cy74ZmUKwH4q8xAnKYvFX1JI2HRDmdyN8Cb
         50VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715224159; x=1715828959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8ZuJSLHVy2XSy/nvCPgDIRow5iMVn6G7A/A6pwXhWw=;
        b=vL3BmKPxWl6oB53HqaFwaHP9226O8p4vL1vZhrOHadkli+jpT1ofmhg7aiU2w6fI9q
         J9Eec+2Mswge2yxIMVLy1xuv4RndPGBDdb5Agn+LX7WYAsbqwH9Sa5DD4Pibly4rqiTw
         mGmLiOQs3sPoJNTXbYvxVmiywqYBu4M4BYJsSwv/ggoqE+gmrp6RePFfZclvW6L+B3ey
         x9Lfk17ndkTHs/TRtLm8gkr5I/q6VCev9qtcSWN4YiJHf17o41o8iVUCaJikPg5EvO/x
         A/Ps20o8lulkdxKJTXZv9BFh4NENuBL70ah4+FPsO0lZ/j3uCWUawAhDuZ0B9tKN8gVK
         ZEQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU9P4peFNhnHD6u9SfwzxWE68GeSQh9kaYULBhW9FaiZcaGev2YQPKI9L753TMVKdKsisCcFocRaGileB2OvaKkLy6Bnc3ThN5kIwe
X-Gm-Message-State: AOJu0YxQzQ16kO6KVo8NppGcxVLRb8RvAGpRU7VotOPMGFGNvrvui42F
	ckRwE/wMSBm1WQ77N6QIbDhRxXf6mqxQP/d98MZ7BHTKFVtv8HAETKKIyMPg/7CEA5Vs2d0iAKF
	4ef5c0DLfllot5abFIdTZ5sTOgls=
X-Google-Smtp-Source: AGHT+IHRZyXY+v7E9ZZWepqn/PVV+z+GqkL5ZnKAwS01Bth0M8FbhZovpaubSh7sb6BiNkrZz7IZGylCy/46KttPpxA=
X-Received: by 2002:a05:6122:917:b0:4da:bae9:4449 with SMTP id
 71dfb90a1353d-4df78f09a5fmr1344260e0c.4.1715224159442; Wed, 08 May 2024
 20:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508125808.28882-1-hailong.liu@oppo.com> <CAGsJ_4xN0MBz_73wUvMp74upd9SaQ+TCRJufEj26Y619Rtr7Zw@mail.gmail.com>
 <20d782ad-c059-4029-9c75-0ef278c98d81@linux.alibaba.com>
In-Reply-To: <20d782ad-c059-4029-9c75-0ef278c98d81@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 9 May 2024 15:09:07 +1200
Message-ID: <CAGsJ_4xoqdd7+vWAnAdaib_NM8Snf=pxkThT1-b0aU-CPaQBYA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: hailong.liu@oppo.com, akpm@linux-foundation.org, urezki@gmail.com, 
	hch@infradead.org, lstoakes@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, xiang@kernel.org, chao@kernel.org, 
	Oven <liyangouwen1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 2:39=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
> Hi,
>
> On 2024/5/9 10:20, Barry Song wrote:
> > On Thu, May 9, 2024 at 12:58=E2=80=AFAM <hailong.liu@oppo.com> wrote:
> >>
> >> From: "Hailong.Liu" <hailong.liu@oppo.com>
> >>
> >> Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
> >> includes support for __GFP_NOFAIL, but it presents a conflict with
> >> commit dd544141b9eb ("vmalloc: back off when the current task is
> >> OOM-killed"). A possible scenario is as belows:
> >>
> >> process-a
> >> kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
> >>      __vmalloc_node_range()
> >>          __vmalloc_area_node()
> >>              vm_area_alloc_pages()
> >>              --> oom-killer send SIGKILL to process-a
> >>              if (fatal_signal_pending(current)) break;
> >> --> return NULL;
> >>
> >> to fix this, do not check fatal_signal_pending() in vm_area_alloc_page=
s()
> >> if __GFP_NOFAIL set.
> >>
> >> Reported-by: Oven <liyangouwen1@oppo.com>
> >> Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
> >> ---
> >>   mm/vmalloc.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> >> index 6641be0ca80b..2f359d08bf8d 100644
> >> --- a/mm/vmalloc.c
> >> +++ b/mm/vmalloc.c
> >> @@ -3560,7 +3560,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >>
> >>          /* High-order pages or fallback path if "bulk" fails. */
> >>          while (nr_allocated < nr_pages) {
> >> -               if (fatal_signal_pending(current))
> >> +               if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(curr=
ent))
> >>                          break;
> >
> > why not !nofail ?
> >
> > This seems a correct fix, but it undermines the assumption made in
> > commit dd544141b9eb
> >   ("vmalloc: back off when the current task is OOM-killed")
> >
> > "
> >      This may trigger some hidden problems, when caller does not handle
> >      vmalloc failures, or when rollaback after failed vmalloc calls own
> >      vmallocs inside.  However all of these scenarios are incorrect: vm=
alloc
> >      does not guarantee successful allocation, it has never been called=
 with
> >      __GFP_NOFAIL and threfore either should not be used for any rollba=
cks or
> >      should handle such errors correctly and not lead to critical failu=
res.
> > "
> >
> > If a significant kvmalloc operation is performed with the NOFAIL flag, =
it risks
> > reverting the fix intended to address the OOM-killer issue in commit
> > dd544141b9eb.
> > Should we indeed permit the NOFAIL flag for large kvmalloc allocations?
>
> Just from my perspective, I don't really care about kmalloc, vmalloc
> or kvmalloc (__GFP_NOFAIL).  I even don't care if it returns three
> order-0 pages or a high-order page.   I just would like to need a
> virtual consecutive buffer (even it works slowly.) with __GFP_NOFAIL.
>
> Because in some cases, writing fallback code may be tough and hard to
> test if such fallback path is correct since it only triggers in extreme
> workloads, and even such buffers are just used in a very short lifetime.
> Also see other FS discussion of __GFP_NOFAIL, e.g.
> https://lore.kernel.org/all/ZcUQfzfQ9R8X0s47@tiehlicka/
>
> In the worst cases, it usually just needs < 5 order-0 pages (for many
> cases it only needs one page), but with kmalloc it will trigger WARN
> if it occurs to > order-1 allocation. as I mentioned before.
>
> With my limited understanding I don't see why it could any problem with
> kvmalloc(__GFP_NOFAIL) since it has no difference of kmalloc(GFP_NOFAIL)
> with order-0 allocation.

I completely understand that you're not concerned about the origin of
the memory,
such as whether it's organized by all zero-order pages. However, in the eve=
nt
that someone else allocates a large memory, like several megabytes with the
NOFAIL flag, commit dd544141b9eb aims to halt the allocation before success
if the process being allocated is targeted for termination of OOM-killer.

With the current patch, we miss the opportunity for early allocation
termination.
However, if the size of the kvmalloc() is small, as in your case, I
believe it should
be perfectly fine. but do we have any way to prevent large size allocation =
with
NOFAIL?

>
>
> Thanks,
> Gao XIang

Thanks
Barry

