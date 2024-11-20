Return-Path: <linux-kernel+bounces-415264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB639D33AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74A51F24087
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 06:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9E415A86B;
	Wed, 20 Nov 2024 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nqCrA6ON"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B22C15855E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732084671; cv=none; b=bzm5mFLDAzRt9HRR8Ii8VJMmSVLBQA8MaM5Ls9qNiABslbVSd020kQC+tEtOFtTwFW12ACszeEsn9uXMsgzyyWI/3E3DJiZMKG7Knyv6Osnbow/pULHWxaFpJG3QPUgx5m6GWt0N9/ojUScPSDHu2DWEAy+GciuKRcQopCJC+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732084671; c=relaxed/simple;
	bh=bNqVRYONXINW30ljhJmbYoefJAAq9tPUUJFrPE5KjX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWFHTWhxXl6dkRdBf9oVK2N2oeheJsO3EjUgrxJW3BX2o+fltWBNOCiwJRbuDwFZRMobQqd0ajvXJiUnBVphxGNTcfmCwCM+J/KAN+kz0kuYHSgsk1pzFklWsTxIsfYlApjQP90+g5Rh8oYVL5Q3RGNSe7ga+9wzaEpxNrhKPhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nqCrA6ON; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4635b03a3cdso398321cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 22:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732084669; x=1732689469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twOFcafBA8zbtRCLGHiLepRQE+KfwEfxqM6TFZTLEH8=;
        b=nqCrA6ONLvFiZ3OMWNJG62eN07eyxHcvc/KVGra4Ur3Ng2UyHU64aHLIzLb1seO/Pt
         Bi8wac/MpZxFTTLzObyVrLthIATfjFbx0kZsag6GZu1nmVrxS8PRCSE0ACWhjDhVIpcO
         0iU2V88WCZiTRlfW4ezS1oAY2ts+wBvQzxHQa8GZK+HUZEpsJGAZu9HJ5Sm3AazJGkU8
         CiWjSC+f16XKGz2EQva/GKERNkMeDvMKQ3SdXuLTCVNcNw63wEzVb1krV3GqUqnS+1BM
         50Txxah8rmA+TZTIzWrcY8lJpDXeUhA6C/SYcJFC3b7a2u/dXrWkAHI4B5LBE1mlND0g
         G4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732084669; x=1732689469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twOFcafBA8zbtRCLGHiLepRQE+KfwEfxqM6TFZTLEH8=;
        b=sN2VOtUZt9ochCRhj5E4w/KhlmdqFvHyDK824Si8bpApqaPaGer2t2/mhOtWrPExvn
         uKja92vl8B8tHkKmdFd0/CUCYYN1C+nkvmLDwnTA5wFQKK3w+cnSct4WviYta5Eg4jWj
         G8n5j/TBKl/VnkWLywNL4RZ+1f4VemyqgdVc/POpgNybrjVdMOWdhplrZBXbUnZj0QSO
         FEDrwCs6mjTWrlH4tz2l+SfRJGKVz0AD2JESe8WYO1/az62TMqsSxgKn2dAcQcWrv1fZ
         /u+aFEdG3ieEAHX4iJEKxJQBK0i8a4Ue65huH7EhUNwXuEeoseXHAlB+wpWXdYg1jKYD
         12rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWas9CCqXwudqvbTDnWjCCpTEZW+RacxaLBKwi4Iai1vbVFBTU2d0fTOWrJsXAnK6EMRbvKlzJFL3HaUZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUYMlltM9l/w1uMw4gJtF0XL3h1BRz1dv5nU0zq9lhU5YeNrp
	V/P0bXSqT3jGkzeAo0mKpZ/sbaOuhsFuQ8BrOej3WsappNJ2hdsdCfo6yKwSlFkCZ3xQFat/yqN
	swVHvH1m12LPGc6EuzJzuz6l0vbYjpzxZ73PS
X-Gm-Gg: ASbGncvoWhEyL4eO0jUW844L2GN9JvbSOHTM+DhdU2L4eHaFNUfKZ6XXNv51WlFdm2m
	AOJ8PFVpxCbJDdL1/f8fBWJbzjaiWDMA=
X-Google-Smtp-Source: AGHT+IHJlWHMudI2smz0xt8RkruDOEJTR5wc3FLspHJfaWPzdFAukEcueD4KFTtcCkdjIYKkMcCiriZYSOiRiPlUNfA=
X-Received: by 2002:ac8:5856:0:b0:461:32e9:c5f1 with SMTP id
 d75a77b69052e-464268e9273mr2284921cf.10.1732084668507; Tue, 19 Nov 2024
 22:37:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120000826.335387-1-surenb@google.com> <20241120000826.335387-5-surenb@google.com>
 <Zz1nRyMnIaCa0TL5@casper.infradead.org>
In-Reply-To: <Zz1nRyMnIaCa0TL5@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 19 Nov 2024 22:37:37 -0800
Message-ID: <CAJuCfpFO3Hj+7f10e0Pnvf0U7-dHeYgvjK+4AFD8V=kmG4JA=w@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, minchan@google.com, 
	jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com, 
	pasha.tatashin@soleen.com, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 8:36=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Nov 19, 2024 at 04:08:25PM -0800, Suren Baghdasaryan wrote:
> > +static inline void vma_clear(struct vm_area_struct *vma)
> > +{
> > +     /* Preserve vma->vm_lock */
> > +     memset(vma, 0, VMA_BEFORE_LOCK);
> > +     memset(VMA_LOCK_END(vma), 0, VMA_AFTER_LOCK);
> > +}
>
> This isn't how you're supposed to handle constructors.  You've fixed
> the immediate problem rather than writing the code in the intended style.

Yeah, I don't like this myself but the only alternative I can think of
is to set the struct members individually.

>
> > +static void vm_area_ctor(void *data)
> > +{
> > +     vma_lock_init(data);
> > +}
>
> After the ctor has run, the object should be in the same state as
> it is after it's freed.  If you want to memset the entire thing
> then you can do it in the ctor.  But there should be no need to
> do it in vma_init().

IIUC, your suggestion is to memset() the vma and initialize vm_lock
inside the ctor. Then when it's time to free the vma, we reset all
members except vm_lock before freeing the vma. As you mention later,
members like anon_vma_chain, which are already clear, also won't need
to be reset at this point. Am I understanding your proposal correctly?

BTW, if so, then vma_copy() will have to also copy vma members individually=
.

>
> And there's lots of things you can move from vma_init() to the ctor.
> For example, at free time, anon_vma_chain should be an empty list.
> So if you init it in the ctor, you can avoid doing it in vma_init().

True.

> I'd suggest that vma_numab_state_free() should be the place which
> sets vma->numab_state to NULL and we can delete vma_numab_state_init()
> entirely.

Sounds good to me.

Please confirm if I correctly got your idea and I'll update this patch.
Thanks for the feedback!

>

