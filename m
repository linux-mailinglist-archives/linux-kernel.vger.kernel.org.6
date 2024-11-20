Return-Path: <linux-kernel+bounces-416039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E7E9D3F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24424283017
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15841149C7A;
	Wed, 20 Nov 2024 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BlrHt/Hl"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93454146A9B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118070; cv=none; b=SsxhsSMf4fOrQ5taMxzsnColMC546u7DpryJU6GBhzyciWAwxjg+o9vbNIJF7iAJkPduS6/MthqC1ddOAoFG/eCg1BXQfQ4G1qXx2EvnJqNQI7+y50ZvN+62GX8AvsFd9tGp1U20a6mt9zNqhlFcaYLHdcfP8n8WiD+kP1KfM7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118070; c=relaxed/simple;
	bh=bhRppJgkks3jfVd6iSx55ByppbUZk1/Ld6IMmnvx0FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WoNDALZ9d9WEkb/QHkU2XpU87G7njjG2M0qr+5m49+lLu+4z49HkyQiDc4InBx/61qCnamXr2RnehVDkTQism13qSAYwckE9mV9pRC0ETgfsB1wMS3bmVNwI/824GyhU1wN/cvfOFv4Oxs+k2cK1gsso9EmGaTomiAxGqL9uOFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BlrHt/Hl; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4635b03a3cdso507851cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 07:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732118067; x=1732722867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aS8lSIRxg0WP9jRTUfXo3i0w6S60egDeEb+mK1HEyI=;
        b=BlrHt/Hl/Ddkn0Gjm0uuAI/5M1mLdiHLWzzznvUTFOd1r500yRK8R5s85JgmU9uTdw
         mZLQyUeZSRl/+89J8zxPlItJunP0IPcVa3a/vwq6pAd9sxPTqiLEoIOnyY89NyFFTjyo
         UzRTALAmate6ZKDAFGWPOyP7KTzd43g4atMkR+KJDZOOcU2U9gP/5BZRBB+YEiSoBtf0
         0i1G8MD44IQswqwwsk/eW5rsCntfars9n4N3a3UsZF+U2563ThxL/G623VUVbnDwZ6Pw
         ziS1yLVKe7bpnbHL0tgTRLByS+ry5QXMRy4Kh3js2pGJfbNYqpCBXONPRlD9kBmmVhzL
         pdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732118067; x=1732722867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aS8lSIRxg0WP9jRTUfXo3i0w6S60egDeEb+mK1HEyI=;
        b=FwJza4HpVTBfkWBV1MXhppBOh7bv4Gze5AiQ/b1mPXneE7iFwYFSVVPBpTPtivSbdQ
         r6+F6w96+3jhXivVmQ+0aoAYUathR/gSCWocmBp05YDvSuuEoWl9V8nvoM7qWL9gQDKf
         9T/rqAYnJCli/Sa4tX8opRu5gwAtyj1/12QxNtMfrHlxEiLz3qapI9JibaOFMKraxdNP
         AUlLS8styXVPMm/lqrQuCtojsUdMumb/LbeLt9VlRPKrxmZPErRfG0Uc5rOgJL/PFyBz
         M3t/vM3ZNonqCYYPRB7d+4fgzrwE8WAEx/Tkx90Aj/qlXMSqHUhkdUWdnKmtmxheq1dK
         Kitg==
X-Forwarded-Encrypted: i=1; AJvYcCVfkzDzdyJA0IJ6Dla5D/C+yQP8P6FwH5w7hgdpCs0VpPF3c7Okw5cudFLIOt235lKc46TznWxOttk5Ig4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7UxcQiL/aLOPgYPIUtDaqvMxIrGnoCL9r57NIzMtBr0M6S2/+
	Ht1DTo13kG0Hwgl5sP+fNXcDAihjh57B3J8eNcWuzKMCrEA/R8T+9a44CJ0CjVkwuPC/fO+QgwH
	Lk2TFKVweDararGdlmQD62aJyYIxCfLeafFJI
X-Gm-Gg: ASbGncsHDlw+4DMccevgpvp7pElgMcu6fnMZWUZAUN4hWnJSMiTlcZ7n32k6vt5EnWr
	you20qu/Mpt0Qn5eNW7qF2Bp3ALF18AiyTQh7YIJu6gcWjK/rG5zcGjYmvzrzqQ==
X-Google-Smtp-Source: AGHT+IHjkarCx+F0hcYKxhgZhANOrHBhOqvAWG4Bxw406DhR0f2zkhheZsfKiSDdM6g4dVF7Q5o38nXkwWZlAmq4Kt4=
X-Received: by 2002:a05:622a:1823:b0:461:4898:8614 with SMTP id
 d75a77b69052e-464d36ed8f0mr3163811cf.27.1732118067061; Wed, 20 Nov 2024
 07:54:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120000826.335387-1-surenb@google.com> <20241120000826.335387-5-surenb@google.com>
 <d3e5cb3a-9c58-477f-a7f7-c96f7e856a9f@suse.cz>
In-Reply-To: <d3e5cb3a-9c58-477f-a7f7-c96f7e856a9f@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 20 Nov 2024 07:54:16 -0800
Message-ID: <CAJuCfpFLgO5E23xcXMVF=ADz9aNJ-OowHSsC48iF+y+P5fMoVQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, hannes@cmpxchg.org, 
	mjguzik@gmail.com, oliver.sang@intel.com, mgorman@techsingularity.net, 
	david@redhat.com, peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, 
	paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, 
	hughd@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	corbet@lwn.net, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 2:16=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 11/20/24 01:08, Suren Baghdasaryan wrote:
> > To enable SLAB_TYPESAFE_BY_RCU for vma cache we need to ensure that
> > object reuse before RCU grace period is over will be detected inside
> > lock_vma_under_rcu().
> > lock_vma_under_rcu() enters RCU read section, finds the vma at the
> > given address, locks the vma and checks if it got detached or remapped
> > to cover a different address range. These last checks are there
> > to ensure that the vma was not modified after we found it but before
> > locking it.
> > vma reuse introduces several new possibilities:
> > 1. vma can be reused after it was found but before it is locked;
> > 2. vma can be reused and reinitialized (including changing its vm_mm)
> > while being locked in vma_start_read();
> > 3. vma can be reused and reinitialized after it was found but before
> > it is locked, then attached at a new address or to a new mm while being
> > read-locked;
> > For case #1 current checks will help detecting cases when:
> > - vma was reused but not yet added into the tree (detached check)
> > - vma was reused at a different address range (address check);
> > We are missing the check for vm_mm to ensure the reused vma was not
> > attached to a different mm. This patch adds the missing check.
> > For case #2, we pass mm to vma_start_read() to prevent access to
> > unstable vma->vm_mm.
>
> So we may now be looking at different mm's mm_lock_seq.sequence and retur=
n a
> false unlocked result, right? I guess the mm validation in
> lock_vma_under_rcu() handles that, but maybe the comment of vma_start_rea=
d()
> needs updating.

Correct. I'll add a comment about this.

>
> > For case #3, we ensure the order in which vma->detached flag and
> > vm_start/vm_end/vm_mm are set and checked. vma gets attached after
> > vm_start/vm_end/vm_mm were set and lock_vma_under_rcu() should check
> > vma->detached before checking vm_start/vm_end/vm_mm. This is required
> > because attaching vma happens without vma write-lock, as opposed to
> > vma detaching, which requires vma write-lock. This patch adds memory
> > barriers inside is_vma_detached() and vma_mark_attached() needed to
> > order reads and writes to vma->detached vs vm_start/vm_end/vm_mm.
> > After these provisions, SLAB_TYPESAFE_BY_RCU is added to vm_area_cachep=
.
> > This will facilitate vm_area_struct reuse and will minimize the number
> > of call_rcu() calls.
> > Adding a freeptr_t into vm_area_struct (unioned with vm_start/vm_end)
> > could be used to avoids bloating the structure, however currently
> > custom free pointers are not supported in combination with a ctor
> > (see the comment for kmem_cache_args.freeptr_offset).
>
> I think there's nothing fundamental preventing to support that, there was
> just no user of it. We can do it later.

Oh, ok. I can add it back so that we have one user and then when the
mechanism is implemented it can be used for testing. Adding freeptr_t
has no negative effects and will reduce later churn.

>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -436,6 +436,11 @@ static struct kmem_cache *vm_area_cachep;
> >  /* SLAB cache for mm_struct structures (tsk->mm) */
> >  static struct kmem_cache *mm_cachep;
> >
> > +static void vm_area_ctor(void *data)
> > +{
> > +     vma_lock_init(data);
> > +}
> > +
> >  struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
> >  {
> >       struct vm_area_struct *vma;
> > @@ -462,8 +467,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_s=
truct *orig)
> >        * orig->shared.rb may be modified concurrently, but the clone
> >        * will be reinitialized.
> >        */
> > -     data_race(memcpy(new, orig, sizeof(*new)));
> > -     vma_lock_init(new);
> > +     vma_copy(new, orig);
> >       INIT_LIST_HEAD(&new->anon_vma_chain);
> >  #ifdef CONFIG_PER_VMA_LOCK
> >       /* vma is not locked, can't use vma_mark_detached() */
>
> Here we mark it detached but we might have already copied it as attached =
and
> confused a reader?

Very true. Thanks for catching this one!

>
> I think this will be covered by what you said in reply to willy:
> "vma_copy() will have to also copy vma members individually."

Yes, I think so. vma_copy() will need to copy most but not all
members. vma->detached will be among those not copied.
Thanks!

>
> > @@ -475,32 +479,37 @@ struct vm_area_struct *vm_area_dup(struct vm_area=
_struct *orig)
> >       return new;
> >  }
> >

