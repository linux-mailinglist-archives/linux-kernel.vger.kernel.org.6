Return-Path: <linux-kernel+bounces-170310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E34018BD4EF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7351C217A6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F96E158DB0;
	Mon,  6 May 2024 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sjm9G8aC"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4168774E37
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021602; cv=none; b=hDX22tQG1izyr2yrTxutNSX5Ysb7G3A2+nrr4QRzX2piq7W1r6uJW9QL0V4PUngYSLIxpGXufZRDX87M1C8hCZl7IwHuwkrAcejp4/kI+rK2J6qTiQ4TJPuDk5QtE4l8pGISxETf7RGC0VeaKa3KCuIcG0sNu+6FKxmTs25R29E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021602; c=relaxed/simple;
	bh=uvqnx8a52JgW44MRDiVGrtHg7doUR6XkYawNsmmAJKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORdCyD8fcgxpfU/HDDOctMnhocuPY3NPTp0FiQMYID4LiZYKh/4cvnLgCET/WbflOZV5x9yqayXM/H2aTdW02Zr5aAYYz/lUnW518nfZX0gyWYdHr9KCNXoe3GFv3nXSk7cFnxqXXBMu+P9rXBS+MV80KEduoclTWGRJxk/H7rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sjm9G8aC; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59c448b44aso375348166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 11:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715021599; x=1715626399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvqnx8a52JgW44MRDiVGrtHg7doUR6XkYawNsmmAJKQ=;
        b=Sjm9G8aC+JASzV38yLWDqBehSVt6ubHxeIcb1xzWDU3hy9NnnSX5usWCKIHjuSSaef
         G1BgYYB1jKePxxxxKHu/P/1jvN39P6ZnjAmtDdkWI5CNhPi32tvhZJUd4JzyGsN8oO/3
         95TDrk6mxaeCr00DeArWjA4I9tpKDBq46Z1teRLuU51+vAqCQDFVzYq4XFMiKy/3/iuw
         J9X/J62fTzM9dzwua0vOMoB3b0/4Hk51M+HC517/QrswoGlCHqzjSG+BJjAc6ZQ+oxcD
         uTYdMuKWyIbdiWWSAqUu11j4a90EOZ+JUnNOHq+zEvu6tkfUdOLlr5x4HX8VUrB/xQFu
         Y9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715021599; x=1715626399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvqnx8a52JgW44MRDiVGrtHg7doUR6XkYawNsmmAJKQ=;
        b=QIH/IlLJMueO53eCOHl19s3vFNqM/yW7nqrtODWYEexlLsJ7ZigI+uyw0OnFG4WgdA
         +2fXgiJ2nm4dhXXelBn/TTB7kPEB4QHnMx7dDfzBIjyqpFiuNyrv6cPZMEdHZj5UNTiu
         hQhGUloQY2M5CGQLPIVOf1jbMk+5c2NBtY7yXwBUB+EHqgmMedakyVx5uhlDbfjaP1X0
         fX7bFJN9FNLG6PjdPqtByaZ9qYrfV6jvFTv5ZJlSaMtEZlk7wJAYpEq8LKZTxWwkNNtY
         jnO+adJpLe8pPVNxSpPA3tILdpzSAB6W3lf9iRILqVBCvco6ELRFYQFNdfljzfFvOu/2
         mVKA==
X-Forwarded-Encrypted: i=1; AJvYcCVNLd/hNT52GD7Q9RxGTwtubPMDuYSsfprIZq44jfszGZZkyZxb5h+HSszEEH8OJwOGWvSHy2x5IfQE9SEz4pIFagaSCruO+9qY1E5i
X-Gm-Message-State: AOJu0YxV/JQgSj6QYanvMuTBL/pYnZhaoyxh9o9hfOs/4zubLt6AmBJg
	qNh8QgLNIhq6uyDMqmSjmbxbvfLgqZersANO6FUXR1NzjT643W0Jni3rjllrADm5j/MzHokmC09
	0DInWIueZJl1SI8ZYnSak44ZbOmmy+/xOwWKO
X-Google-Smtp-Source: AGHT+IHaoPMigFap9qR56mDK6IoGtW0CNZrr495O28d2oa2CU+qgAxuG5JrPxUlJnGEnR0Odtvd35E9w1QRml/F5ldY=
X-Received: by 2002:a17:907:7e8b:b0:a59:bfab:b254 with SMTP id
 qb11-20020a1709077e8b00b00a59bfabb254mr4113478ejc.64.1715021599491; Mon, 06
 May 2024 11:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506170024.202111-1-yosryahmed@google.com> <d546b804-bb71-45c7-89c4-776f98a48e77@redhat.com>
In-Reply-To: <d546b804-bb71-45c7-89c4-776f98a48e77@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 6 May 2024 11:52:40 -0700
Message-ID: <CAJD7tkaPvYWhrMSHmM0n0hitFaDdusq7gQ=7+DTUQLODGdo6RQ@mail.gmail.com>
Subject: Re: [PATCH] mm: do not update memcg stats for NR_{FILE/SHMEM}_PMDMAPPED
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 11:35=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 06.05.24 19:00, Yosry Ahmed wrote:
> > Do not use __lruvec_stat_mod_folio() when updating NR_FILE_PMDMAPPED an=
d
> > NR_SHMEM_PMDMAPPED as these stats are not maintained per-memcg. Use
> > __mod_node_page_state() instead, which updates the global per-node stat=
s
> > only.
>
> What's the effect of this? IIUC, it's been that way forever, no?

Yes, but it has been the case that all the NR_VM_EVENT_ITEMS stats
were maintained per-memcg, although some of those fields are not
exposed anywhere.

Shakeel recently added commit14e0f6c957e39 ("memcg: reduce memory for
the lruvec and memcg stats"), which changed this such that we only
maintain the stats we actually expose per-memcg (via a translation
table).

He also added commit 514462bbe927b ("memcg: warn for unexpected events
and stats"), which warns if we try to update a stat per-memcg that we
do not maintain per-memcg (i.e. the warning firing here). The goal is
to make sure the translation table has all the stats it needs to have.

Both of these commits were just merged today into mm-stable, hence the
need for the fix now. It is the warning working as intended. No Fixes
or CC stable are needed, but if necessary I would think:

Fixes: 514462bbe927b ("memcg: warn for unexpected events and stats")

, because without the warning, the stat update will just be ignored.
So if anything the warning should have been added *after* this was
fixed up.

>
> Fixes: ?
>
> Do we want to CC stable?
>
>
> --
> Cheers,
>
> David / dhildenb
>

