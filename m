Return-Path: <linux-kernel+bounces-227848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371C891573C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592601C22187
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30B61A01C8;
	Mon, 24 Jun 2024 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1gK6ZiG7"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725D41A01B8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257684; cv=none; b=JY81ZkW4v6mb0n5eS9zwom4jLqwvQJbVBW8vhLLBlSf+IAse13YqaQU4VNyjJqfMY6nlL742JYLP/zwcNRd1xRJs5pAGzTcd4o7A+3lhXBXmFaNXRVUX3ERf3/e5i95bYOtD70ozNV6RHBtM7nREvBFJnzQ1aatORLcnzZPY41o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257684; c=relaxed/simple;
	bh=iRGtNnx1zZXQrR/w1GfqFSETXcoB/OmGwwh67RJ/kEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4pg/qC7jRE6eIorcaYlgQYC4idPUypybzEQagaA0MW7yrzy09QJCVZKaIekrFHYVxBj8UyF778C4boSHm8Dez6fMo/KKn/iuW7D/qPvYIu2EkKKqZXoy/gvgiHUUXQ8DhIh/1uX0zfPM6BHcJpq9ikGZBBYNhaLp9P4X1BGKkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1gK6ZiG7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6fbe639a76so753092166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719257681; x=1719862481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LR/qyqNf4yNhGg/W9gnglK9t/IsY+KbgwrDYpXJIh6Q=;
        b=1gK6ZiG7Hs+6XBsqiuOgqdtCmMh6uK20NcjFAPrYnyL2eaBPi2rASFo0iS0kjyPrBo
         i7RM+IEijRDKq4ahAOhgU3gSX5TZqDSCbKsjmCrME0yKmHFotYBRFx2l5XmBJZ8AfYg0
         v1iuMeq/DTKS/cNvlQjl49Q5KDUmmLn4xwBmOj4gLFFNvlKyrz5tRxdh5fKvHsqzB4o7
         Cj5rYVUGfUQyAhyhfzJN17yOXia/uW0xhiRtXi4Vx4wgLNrN7iArGiadb4S4IL800Vom
         +atrrRk+Gfocmn3dgy/Ldqysleo3vV1r0EU71O4VWgndcOrsxqORky2aR1KStu7Ali5u
         qGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719257681; x=1719862481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LR/qyqNf4yNhGg/W9gnglK9t/IsY+KbgwrDYpXJIh6Q=;
        b=Z0KTMASdxETLAazYGwNJM8VXnGF9Vmwm4rPZySQ3LijfKSmmuSoOTrM2LJtSOhpEFT
         Lp8X/b5C7isIKqx8QZX974r0RLm7Xdd/CJciNyTQGDankp4ufdWNb7ZaXz/hw3pJZ+Ld
         lAEP1C6lk7VPNbrEL6S1Zu//tHB1CNLr2xpPWbq9vCBJ2Hu4JePtZlp+IM4Dv0+oJZSZ
         4EuZfpUuGMMa/LY6PEuvU5nZ+nnonLxBX7b4IIcsM/0+p4vxebj+ETBre9Yjrpdf+nBP
         ip0tW6pkdz8VxxWVcWBFe/5pymi3vD7UGSxZdvGUdPNVi4qz9oTwsgRsuRV5D5Z//Q9K
         nqrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ/QGWOgcI7QTzdIUZz3Uqphyu4+juug+xFr4VrlNp/tPaVTGkRkKi4ShP3WhXzpJh4nDQpo94DSFWubdX5K44AoYQy92e2v9vB+6C
X-Gm-Message-State: AOJu0Yw8tvd9UlXcVLuvDZnHagwiQOrO17CNWIPT/vsYaelrxEh/bRx4
	R1HUzDXU/7FEhcFtiHvB+KAVNS2/n8i218waB7MJf0yrH7OMtyoa5IvVP2lBYKgc/DuBh/0nSG/
	L13pWKtRqO9nsc2Y0T71ZfHKKftwWwUSdKl9N
X-Google-Smtp-Source: AGHT+IGBuCU23m+wrmkFzQkUCc4DL4NBFPm8xZ6GTjzrHf41bNowvPfktB6PfvqelK6j4q2T/3ufnLal/dwQaerFDnk=
X-Received: by 2002:a17:907:cbc9:b0:a6f:b193:758e with SMTP id
 a640c23a62f3a-a70385e67dfmr488672466b.29.1719257680243; Mon, 24 Jun 2024
 12:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406241651.963e3e78-oliver.sang@intel.com> <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>
 <Znm74wW3xARhR2qN@casper.infradead.org> <CAJD7tkbF9NwKa4q5J0xq1oG6EkTDLz8UcbekSfP+DYfoDSqRhQ@mail.gmail.com>
 <ZnnBVBItTNWZE42u@casper.infradead.org> <CAJD7tkaC6d_RkhRhMpEeS1zTEtoQYw56J3LLdzD1aM9_qu-3BA@mail.gmail.com>
 <ZnnId18scFvE_a6K@casper.infradead.org>
In-Reply-To: <ZnnId18scFvE_a6K@casper.infradead.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 12:34:04 -0700
Message-ID: <CAJD7tkZZHxXR9cFE=ZHQOnYXakrhXg0+ScT2ExxihovSgDz7_g@mail.gmail.com>
Subject: Re: [linux-next:master] [mm] 0fa2857d23: WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof
To: Matthew Wilcox <willy@infradead.org>
Cc: kernel test robot <oliver.sang@intel.com>, Usama Arif <usamaarif642@gmail.com>, 
	oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 12:26=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Jun 24, 2024 at 11:57:45AM -0700, Yosry Ahmed wrote:
> > On Mon, Jun 24, 2024 at 11:56=E2=80=AFAM Matthew Wilcox <willy@infradea=
d.org> wrote:
> > >
> > > On Mon, Jun 24, 2024 at 11:53:30AM -0700, Yosry Ahmed wrote:
> > > > After a page is swapped out during reclaim, __remove_mapping() will
> > > > call __delete_from_swap_cache() to replace the swap cache entry wit=
h a
> > > > shadow entry (which is an xa_value).
> > >
> > > Special entries are disjoint from shadow entries.  Shadow entries hav=
e
> > > the last two bits as 01 or 11 (are congruent to 1 or 3 modulo 4).
> > > Special entries have values below 4096 which end in 10 (are congruent
> > > to 2 modulo 4).
> >
> > You are implying that we would no longer have a shadow entry for such
> > zero folios, because we will be storing a special entry instead.
> > Right?
>
> umm ... maybe I have a misunderstanding here.
>
> I'm saying that there wouldn't be a _swap_ entry here because the folio
> wouldn't be stored anywhere on the swap device.  But there could be a
> _shadow_ entry.  Although if the page is full of zeroes, it was probably
> never referenced and doesn't really need a shadow entry.

Is it possible to have a shadow entry AND a special entry (e.g.
XA_ZERO_ENTRY) at the same index? This is what would be required to
maintain the current behavior (assuming we really need the shadow
entries for such zeroed folios).

