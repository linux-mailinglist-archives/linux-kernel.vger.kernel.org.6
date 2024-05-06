Return-Path: <linux-kernel+bounces-170332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9658BD557
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0CE1F22799
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE9A1591E5;
	Mon,  6 May 2024 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="UQMOj33V"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1D17CF27
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023393; cv=none; b=FTA/vR6m1JEL2REp5RvbyKG1zhbZD5D1PFqVDZ1hB7q0EdBVZBLh2S6nNhJAXGgeha/vdle8PgN9aAcQtxrw901pxtB7OHvQggL98endz446Eyl+K4eUHxWbwrb9QYPPPQCOasmqJE93coRGvmUhVVQ+2UF3K9DxEEFeHLSSs80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023393; c=relaxed/simple;
	bh=bguUNC2PFMLeuU94T+lwcP3rh0QVeoRiROpAOKqlvwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJ5cy1zP9qm1DZZ9F7n3QH0NgYzX9lkSEYvB4w0EJA+VhlLNr+6oY5x0JiGETAtgN0+G8o6uM20THk73zWWmgaTb466Pj2eOdd1JzQ3EsQ78yAoWMyxHtxf55aX0uiThV7tECO/SWZyy1Gld34JvqIEtXd8IAdc6X7L4QAqQrg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UQMOj33V; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59a17fcc6bso500861366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 12:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715023390; x=1715628190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bguUNC2PFMLeuU94T+lwcP3rh0QVeoRiROpAOKqlvwg=;
        b=UQMOj33V3aqmV7EJcN214LSqqXl+ImjyoYENeQ44xOrgzWcGNpK7EczH9+wCsb8ibF
         UP0lT+0qH7EWNbM9zK+NCLZnKuvu3BYeBH+NdA8OXjwWVjL1XbyaxB3MzRFmxtnqZnhD
         utgRK/oSJ3/jPh2fk2YyHkIu/RWdGTQbDRPFdtRVprbG+acBWZ58U5ShAlvfp+PbcD2R
         8yfcP0UW4HjzVWlBK1VegUf4aPLIfodBChU6t7KKmQIT4+3fm2Q2tL3h/lU6/yaTMZx/
         53IbOFx6mHs3BoBkZKJTTdmfaCNGkU+dFKnTKo/1YOKjeA7ojVMSu/2p8om4Tcbslmt0
         nFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715023390; x=1715628190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bguUNC2PFMLeuU94T+lwcP3rh0QVeoRiROpAOKqlvwg=;
        b=pVtbC/nqGnUVF5iVm6lgctClGzyXgcxFIPUM/5bulPym06bcqbB4Dnbx8jKBBcAn7f
         WvpoQi3W+zbR0Am9MmFjuuZ9da1Zr86yD70oY888+bV7IXgSXv2hVjcDkP283iORdBp4
         674OTQv6uRzqli0SosOngleTD8ymbElXyQuyscPbktHqgfPRdaN4XTSs1OM0JksLc36i
         fjHWPWl028EGKVxkbuqXvYDwwBGUaYcabaszwNNr2YU2DDcWt0t50StH6IwO6qoLhOp9
         xrxkbeuSUl582psXIf7obLQVdtUCoa6A3wB4GmQtDqyOcLLHJc8nMREGzxtdlvCt9y8v
         pcWg==
X-Forwarded-Encrypted: i=1; AJvYcCUw+xXrjCtXLtMF97fx02azXMEUuCA9/eF33aFBV/HCY+oC6l2SYCCtQVqVByoVLvr66tE6p7dAatBKItM01eATAlxnq/YC81/3Agui
X-Gm-Message-State: AOJu0Yz3LRZc+WeUq0+BdhKmjmZMEQVXYJ1+LGkRyawuHNK8+uFVzoJD
	NbNI+ASGLsORbEL14l/S+EVacutcDy8Q+VcXG1tRuBqbyLzTejWBcnY6JmRxbMPdm8+pIrCHVY/
	BdIlqsuxnuo/6NhL18Xz67hOo56jppb0TAs0+
X-Google-Smtp-Source: AGHT+IHiRAz+VJrjTyQErBwaHiOk6l7d/y+oDGAU/XgFssJkdn8QbudNBadDoKfGqCjFhWshhxfGxx9cQBFG8uqsLm4=
X-Received: by 2002:a17:906:a288:b0:a59:c728:5421 with SMTP id
 i8-20020a170906a28800b00a59c7285421mr3071578ejz.68.1715023389989; Mon, 06 May
 2024 12:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506170024.202111-1-yosryahmed@google.com>
 <d546b804-bb71-45c7-89c4-776f98a48e77@redhat.com> <CAJD7tkaPvYWhrMSHmM0n0hitFaDdusq7gQ=7+DTUQLODGdo6RQ@mail.gmail.com>
 <d189730a-aab7-4a3b-bc0f-6abe17ea2c91@redhat.com>
In-Reply-To: <d189730a-aab7-4a3b-bc0f-6abe17ea2c91@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 6 May 2024 12:22:31 -0700
Message-ID: <CAJD7tkbaoQU6AAcxawz9VpdYnHBZJuLJfT_Rz30i0xopkDNM3Q@mail.gmail.com>
Subject: Re: [PATCH] mm: do not update memcg stats for NR_{FILE/SHMEM}_PMDMAPPED
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 12:18=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 06.05.24 20:52, Yosry Ahmed wrote:
> > On Mon, May 6, 2024 at 11:35=E2=80=AFAM David Hildenbrand <david@redhat=
com> wrote:
> >>
> >> On 06.05.24 19:00, Yosry Ahmed wrote:
> >>> Do not use __lruvec_stat_mod_folio() when updating NR_FILE_PMDMAPPED =
and
> >>> NR_SHMEM_PMDMAPPED as these stats are not maintained per-memcg. Use
> >>> __mod_node_page_state() instead, which updates the global per-node st=
ats
> >>> only.
> >>
> >> What's the effect of this? IIUC, it's been that way forever, no?
> >
> > Yes, but it has been the case that all the NR_VM_EVENT_ITEMS stats
> > were maintained per-memcg, although some of those fields are not
> > exposed anywhere.
> >
> > Shakeel recently added commit14e0f6c957e39 ("memcg: reduce memory for
> > the lruvec and memcg stats"), which changed this such that we only
> > maintain the stats we actually expose per-memcg (via a translation
> > table).
>
> Valuable information we should add to the patch description :)
>
> >
> > He also added commit 514462bbe927b ("memcg: warn for unexpected events
> > and stats"), which warns if we try to update a stat per-memcg that we
> > do not maintain per-memcg (i.e. the warning firing here). The goal is
> > to make sure the translation table has all the stats it needs to have.
> >
> > Both of these commits were just merged today into mm-stable, hence the
> > need for the fix now. It is the warning working as intended. No Fixes
> > or CC stable are needed, but if necessary I would think:
>
> WARN* should usually be "Fixes:"d, because WARN* expresses a condition
> that shouldn't be happening.
>
> Documentation/process/coding-style.rst contains details.
>
> >
> > Fixes: 514462bbe927b ("memcg: warn for unexpected events and stats")
> >
> > , because without the warning, the stat update will just be ignored.
> > So if anything the warning should have been added *after* this was
> > fixed up.
>
> Ideally, yes. But if it's in mm-stable, we usually can no longer
> reshuffle patches (commit IDs stable).

I will send v2 shortly with the missing negative sign, amended commit
log, and the Fixes tag.

Thanks for taking a look!


> --
> Cheers,
>
> David / dhildenb
>
>

