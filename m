Return-Path: <linux-kernel+bounces-198173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F208D7476
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 11:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0339E1F21C46
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 09:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DAA28DC1;
	Sun,  2 Jun 2024 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/Hr5mla"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FBB3207
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717319166; cv=none; b=mWtj00jAVfb5hRDUse08rniNjiTHxHqqZJ5u7zzoPLGk1mwLcKN/vyb3bOY2PwObEAzGSwpsLk7qQrLhQn5cMdqWBnVbdvFTjFMwtKc10KPWe2qEWbNoWQOV3x54m/YuRZrHc6aFnmtsL3gU902SLJ3U45uGLXRiD9s6lTjvYhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717319166; c=relaxed/simple;
	bh=elAiB3nzPWvkznBhTCvp6lnihKedbn6QZBUL9k/FIWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AArVpeaqrYR/ncWeOwqQIy5ptZbCr8J385z65rRRboU0WLitg2ucWFM74k9WMnJUOg+NKyMt1BfWcaPoT+OAuR0GulOMT5IFe9jHeCZu0WfkbNrqzTu2r822v4F6N37bcP4M0oRFroMm7FpxzEhufjU17zuSpks7gpTWnU4GYzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/Hr5mla; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b89fcdcc7so2637343e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 02:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717319163; x=1717923963; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ni5qfj/DTcTpIPY+I+qnaf/B7kcFH0t6iPU99jBic6U=;
        b=A/Hr5mlasNZYrZjCuGtf5mzHYv1Kp0+Ifh8+FTNqttKSOQOrrmSnFMtwjLWLohkLs7
         7l7xrH7HGuqGWGifzu8n6+JSJ6N0lW1OHuk5pRH/tLNp3xLlxHrvGYnwCBijjxVwsPf+
         iIPB4subL4S5fJ0ZVe0vTRPt4ujqIuxQX6FSv3kIVeKrAW0hnMtmqHipBTDUQ7tqlIXB
         jzKBnMJZyTTtFKTWfqOlJ/Dfxa9S0KCr9hNMJykhxFeOkHlJNiNikr6ioUyt0G+fT/Oe
         ohAk20P+34ZxPPR+1IlEpcwz6T0u+DhMf7UskeQ5X0KTuQTz1mM3DFTd488xIQLF+GqB
         +NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717319163; x=1717923963;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ni5qfj/DTcTpIPY+I+qnaf/B7kcFH0t6iPU99jBic6U=;
        b=RWRmtqD42YmeFxEzTjpbeaGTJlV2KvFrKbANbSg9BJPeYTl+oZWLmjtGgYmgv96R7Y
         mth2mwDbhx+P33qoueJvDGxknun1boBzYbp9LEKfRrwStxoFtSBTgMoFwj3RB1iicQek
         ylAEKM8R7vtxb0mgbTUN0nvStPG9YqYU6dfz9bGAGKgHOS1C2Z2NA+NB5zE3SJHdOiLT
         J9PojNrDFU8CYNI74y5annLqYmENZTt3L3pyus7FT3DE1tL3NDuQmSHYd3jSJV2nQqzY
         8rFZmegnvxOcgBnp+HzjixRVnJZpRNhMu9JQ4U42B09R8j9Tz0sWpvSOUHcHpRJp2adC
         NrYw==
X-Forwarded-Encrypted: i=1; AJvYcCVe+0eskP6yQqfuw0XevrmPv07nVB3oPxpS69PFSxqMxYHLdZUvSIM3lKDK4AxdidO8h6bJvygL4a/3ICFHzEBL0TPWp1aYh+GLF3T7
X-Gm-Message-State: AOJu0Yxq/NcZ5quHyS/V/OBkp9R9+Cjgf6rbbvQhTWUWNJRLb438m1NF
	fCqIpGUmaXs7rRYIilUedDoAl8bGrocNtliynmzjLf5ODYGl5qtxYsh34EDBY1VZVx8ZdfshTj2
	Ee+ShK6/k7ZpFVxkK2lsL0qQfxAw=
X-Google-Smtp-Source: AGHT+IEn/W8MSUdwZOfZ1YLWWsTSkpu1Fb/efk+yVX5YIfoTvWbNwj840nO9OwLFlqLPBcOiEbLh/nkQtDaOkO140Lg=
X-Received: by 2002:a19:6449:0:b0:52b:84bd:3452 with SMTP id
 2adb3069b0e04-52b89563492mr3562309e87.7.1717319162881; Sun, 02 Jun 2024
 02:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601025536.25682-1-rgbi3307@naver.com> <ntycfywrhmt2beba7pgyxmahwhncufgnpjxjobl33f2tyrhzpb@cckdgisyqlra>
In-Reply-To: <ntycfywrhmt2beba7pgyxmahwhncufgnpjxjobl33f2tyrhzpb@cckdgisyqlra>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Sun, 2 Jun 2024 18:05:49 +0900
Message-ID: <CAHOvCC6vZQkotPCvOafGxXWb5GygMSUiYUaYZu3RwFA9cCY2nw@mail.gmail.com>
Subject: Re: [PATCH] maple_tree: add mas_node_count() before going to
 slow_path in mas_wr_modify()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jung-JaeJoon <rgbi3307@gmail.com>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, Liam.
Thank you very much for the detailed answer and explanation.

I tested this patch in userspace.
In user space, this phenomenon always occurs when kmem_cache_alloc()
is executed to allocate a new node.
I will try to test it in more detail in kernel space.
I will also refer to the notes from the email list you shared
and send results once a more clear analysis has been made.

Thanks,
JaeJoon Jung

On Sun, 2 Jun 2024 at 11:41, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
> * Jung-JaeJoon <rgbi3307@gmail.com> [240531 22:55]:
> > From: Jung-JaeJoon <rgbi3307@gmail.com>
> >
> > If there are not enough nodes, mas_node_count() set an error state via mas_set_err()
> > and return control flow to the beginning.
> >
> > In the return flow, mas_nomem() checks the error status, allocates new nodes,
> > and resumes execution again.
> >
> > In particular,
> > if this happens in mas_split() in the slow_path section executed in mas_wr_modify(),
> > unnecessary work is repeated, causing a slowdown in speed as below flow:
> >
> > _begin:
> > mas_wr_modify() --> if (new_end >= mt_slots[wr_mas->type]) --> goto slow_path
> > slow_path:
> >     --> mas_wr_bnode() --> mas_store_b_node() --> mas_commit_b_node() --> mas_split()
> >     --> mas_node_count() return to _begin
> >
> > But, in the above flow, if mas_node_count() is executed before entering slow_path,
> > execution efficiency is improved by allocating nodes without entering slow_path repeatedly.
>
> Thank you for your patch, but I have to NACK this change.
>
> You are trying to optimise the work done when we are out of memory,
> which is a very rare state.  How did you check this works?
>
> If we run out of memory, the code will kick back to mas_nomem() and
> may start running in reclaim to free enough memory for the allocations.
> There is nothing we can do to make a meaningful change in the speed of
> execution at this point. IOW, the duplicate work is the least of our
> problems.
>
> This change has also separated the allocations from why we are
> allocating - which isn't really apparent in this change.  We could put
> in a comment about why we are doing this, but the difference in
> execution speed when we are in a low memory, probably reclaim retry
> situation is not worth this complication.
>
> We also have a feature on the mailing list called "Store type" around
> changing how this works to make preallocations avoid duplicate work and
> it is actively being worked on (as noted in the email to the list). [1]
> The key difference being that the store type feature will allow us to
> avoid unnecessary work that happens all the time for preallocations.
>
> [1] http://lists.infradead.org/pipermail/maple-tree/2023-December/003098.html
>
> Thanks,
> Liam
>
> >
> > Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
> > ---
> >  lib/maple_tree.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index 2d7d27e6ae3c..8ffabd73619f 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -4176,8 +4176,13 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
> >        * path.
> >        */
> >       new_end = mas_wr_new_end(wr_mas);
> > -     if (new_end >= mt_slots[wr_mas->type])
> > +     if (new_end >= mt_slots[wr_mas->type]) {
> > +                mas->depth = mas_mt_height(mas);
> > +                mas_node_count(mas, 1 + mas->depth * 2);
> > +                if (mas_is_err(mas))
> > +                        return;
> >               goto slow_path;
> > +        }
> >
> >       /* Attempt to append */
> >       if (mas_wr_append(wr_mas, new_end))
> > --
> > 2.17.1
> >

