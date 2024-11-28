Return-Path: <linux-kernel+bounces-425138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206CA9DBDE0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 00:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75441648F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DECB1C5793;
	Thu, 28 Nov 2024 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G43P13K9"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78DD15250F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732835342; cv=none; b=PjR71cqzbl/OvOu6UUikw0vSwiJQOJC4fXnRKK17qiD1ORs/nv+IZGwnnIFIa2mL4iE5Uxi7AngJibKxk8ybWdW48fj2ckKYc9teBubDIt8ttEzPVXsRL96JeuGtr9iukUobTtj1BzJ+12eECmw7O+piJrLXUChtOqKXXssWOX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732835342; c=relaxed/simple;
	bh=Dbcv1JjOxDrAkccSNGF3uB1TyIf75kxPwnKq2nF90f8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ghmw66lneGdnJPQNzMeex9C12PXj0uokb9tNqwqECwbmpgkxA6sF3GsZ8zTxW7af4YWkrPSMDnb1v0QpruQ4cOjUsJ5JkWWiFY5Y3xAkypafEcY0hlJPMPD8fdHXKfrqaspwKTaaALeTDyuVWd6USJ8n8xpRkRuEmrDDJLaZ4mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G43P13K9; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b667d2fb9dso71616285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732835340; x=1733440140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73AVzzP2v1m625wf6xJ/CbK4UaWJ5lWVRfV8EUqXnOk=;
        b=G43P13K9idpuRHgGBHNuMuvAxIBlMjjSgBmYMnSj7VVYGjcImo3yhX0+f7ikdP7Lns
         /qs54hPyapgfbxWjlZz8P8/mHC0mydJZnmaVUuYtBRb+FSP/513JygfnMxEBk6JrtgGc
         FEfx471HBc8Tc0rrCMbdLKBfO+NFxGbfGUsOqEEMCYVOjvzCZr7JNwUGyUNbS1Q2szHG
         fTRfxeASueK8WKes8woUBEeJs0f7boAF/vEiDN0KWX2E+apv6AEiWZD/tlsIWEmBejuI
         7TMSb1QO5bbUK6iQ3MaoMAf++nRCilJjPGljZHToqHz0KhKvhf/1CYJyg7T3haY+EajV
         iydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732835340; x=1733440140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73AVzzP2v1m625wf6xJ/CbK4UaWJ5lWVRfV8EUqXnOk=;
        b=aylw5Bl77skdCIKMspABOrTsvcTpNEcPesTBtOW2TgmWgb+oMam7V14nPk2SN1WxnI
         zj06A2WN2Kf4bb7ffJ9w95AYM2EyXtuLJFP2q+TsOZYRU6bh/fBYtKD00bSYHbKLlwYB
         YC3CLL65Bsbtmq2T20GE22ImcC0Sweq56zZOqgtJ+HiSfPooiDGIz0vXNf4fQKkNPAdI
         SjMyMb6c/v5S4q8PGCA+oU8245QG6jXUGuetSWts/OTs/kkmqfMjD82WY7e1WXuYwjwE
         f8TU6rdNvCwBym+47mk6Z6kd+xeCQe4ab9AjJBSn7g16cu4wlmZROCZYQ3R3DsLeANyn
         BYyA==
X-Forwarded-Encrypted: i=1; AJvYcCW0c3nnHlB5HckvZsIXOucMM9rFb8xZLmQZu3xwujep72H2YD4eoWHeiMV9io4Ea+B2lNtK8cLXmcKSWI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ifxxGwPeiSQk/amItiaLLfH3+pcvS4Q5yQ1JAyB0+NBtsMds
	g94fqHZykOa5Dlh/8FBWf+Z04c76XlpHbgQyvZv6wyhbhnAsVCpCkYvhzaUwqx88t1GrLDgIuVR
	akKWfEiJeaGTMdJSfPB+YDVm0Ixk=
X-Gm-Gg: ASbGncshfgmt7TfV1yPLpSk2CO0KIYr9wfP/XbqDmBepEaU3JhXJBYQIa1biYikhZwL
	iS8Fn5CcUEuUTYmToTMT4SIAk/fp5gROQ5oIIDgX4CKOaWfn5n5lwOUWSy66vM+wFUQ==
X-Google-Smtp-Source: AGHT+IEMgywl73xEWtsWe0pwsi0QHZeQHj2IfZ8pzf/4HpesUX2DC/FR25/TSrlLpjPifzadfwa23N2UrJho1ZIWbIY=
X-Received: by 2002:a05:620a:1b98:b0:7b6:668a:5a7 with SMTP id
 af79cd13be357-7b67c4a3ab4mr1192641985a.62.1732835339756; Thu, 28 Nov 2024
 15:08:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116091658.1983491-1-chenridong@huaweicloud.com>
 <20241116091658.1983491-2-chenridong@huaweicloud.com> <Zzq8jsAQNYgDKSGN@casper.infradead.org>
 <CAGsJ_4x0OrdhorQdz8PyLD84GOYVZJ7kLfGV_5yupLG_ZQ_B3w@mail.gmail.com>
 <ZzrA5nXldoE2PWx4@casper.infradead.org> <7e617fe7-388f-43a1-b0fa-e2998194b90c@huawei.com>
In-Reply-To: <7e617fe7-388f-43a1-b0fa-e2998194b90c@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 29 Nov 2024 12:08:48 +1300
Message-ID: <CAGsJ_4yA5graSSE3cBf_RB=cGc3hLpcB-3pR9ymVfzKx_dg3Zg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] mm/vmscan: move the written-back folios to the
 tail of LRU after shrinking
To: chenridong <chenridong@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, 
	Chen Ridong <chenridong@huaweicloud.com>, akpm@linux-foundation.org, mhocko@suse.com, 
	hannes@cmpxchg.org, yosryahmed@google.com, yuzhao@google.com, 
	david@redhat.com, ryan.roberts@arm.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, wangweiyang2@huawei.com, xieym_ict@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 2:19=E2=80=AFPM chenridong <chenridong@huawei.com> =
wrote:
>
>
>
> On 2024/11/18 12:21, Matthew Wilcox wrote:
> > On Mon, Nov 18, 2024 at 05:14:14PM +1300, Barry Song wrote:
> >> On Mon, Nov 18, 2024 at 5:03=E2=80=AFPM Matthew Wilcox <willy@infradea=
d.org> wrote:
> >>>
> >>> On Sat, Nov 16, 2024 at 09:16:58AM +0000, Chen Ridong wrote:
> >>>> 2. In shrink_page_list function, if folioN is THP(2M), it may be spl=
ited
> >>>>    and added to swap cache folio by folio. After adding to swap cach=
e,
> >>>>    it will submit io to writeback folio to swap, which is asynchrono=
us.
> >>>>    When shrink_page_list is finished, the isolated folios list will =
be
> >>>>    moved back to the head of inactive lru. The inactive lru may just=
 look
> >>>>    like this, with 512 filioes have been move to the head of inactiv=
e lru.
> >>>
> >>> I was hoping that we'd be able to stop splitting the folio when addin=
g
> >>> to the swap cache.  Ideally. we'd add the whole 2MB and write it back
> >>> as a single unit.
> >>
> >> This is already the case: adding to the swapcache doesn=E2=80=99t requ=
ire splitting
> >> THPs, but failing to allocate 2MB of contiguous swap slots will.
> >
> > Agreed we need to understand why this is happening.  As I've said a few
> > times now, we need to stop requiring contiguity.  Real filesystems don'=
t
> > need the contiguity (they become less efficient, but they can scatter a
> > single 2MB folio to multiple places).
> >
> > Maybe Chris has a solution to this in the works?
> >
>
> Hi, Chris, do you have a better idea to solve this issue?

Not Chris. As I read the code again, we have already the below code to fixu=
p
the issue "missed folio_rotate_reclaimable()" in evict_folios():

                /* retry folios that may have missed
folio_rotate_reclaimable() */
                list_move(&folio->lru, &clean);

It doesn't work for you?

commit 359a5e1416caaf9ce28396a65ed3e386cc5de663
Author: Yu Zhao <yuzhao@google.com>
Date:   Tue Nov 15 18:38:07 2022 -0700
    mm: multi-gen LRU: retry folios written back while isolated

    The page reclaim isolates a batch of folios from the tail of one of the
    LRU lists and works on those folios one by one.  For a suitable
    swap-backed folio, if the swap device is async, it queues that folio fo=
r
    writeback.  After the page reclaim finishes an entire batch, it puts ba=
ck
    the folios it queued for writeback to the head of the original LRU list=
.

    In the meantime, the page writeback flushes the queued folios also by
    batches.  Its batching logic is independent from that of the page recla=
im.
    For each of the folios it writes back, the page writeback calls
    folio_rotate_reclaimable() which tries to rotate a folio to the tail.


    folio_rotate_reclaimable() only works for a folio after the page reclai=
m
    has put it back.  If an async swap device is fast enough, the page
    writeback can finish with that folio while the page reclaim is still
    working on the rest of the batch containing it.  In this case, that fol=
io
    will remain at the head and the page reclaim will not retry it before
    reaching there.

    This patch adds a retry to evict_folios().  After evict_folios() has
    finished an entire batch and before it puts back folios it cannot free
    immediately, it retries those that may have missed the rotation.
    Before this patch, ~60% of folios swapped to an Intel Optane missed
    folio_rotate_reclaimable().  After this patch, ~99% of missed folios we=
re
    reclaimed upon retry.

    This problem affects relatively slow async swap devices like Samsung 98=
0
    Pro much less and does not affect sync swap devices like zram or zswap =
at
    all.

>
> Best regards,
> Ridong

Thanks
Barry

