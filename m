Return-Path: <linux-kernel+bounces-199323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3845B8D858C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942EC1F22D7C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0AA130A53;
	Mon,  3 Jun 2024 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RohCQUgT"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2A612FB0B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426554; cv=none; b=OKitvloG8JqvSqJ1lKsjpa8sB82tD1NusShGix/F7yC4yDawqMw26TSXFtxk/95PpqwBHE8cDQn2y2z/ooyPjk7mnuleBDisoCF1zSVK7vedP5uTH3xRZGqQQEHJ7oJnOk1Gvwhh0EnXR9uuiMjHt+1MEQZfLOLlhJHgmsNa8xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426554; c=relaxed/simple;
	bh=eosEL625DAcXRH0WIoIoTSG8Fgy0pt/eMlBqprB+iuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYrvZdvGwEYr0un6X/wXamWv+26JtpFsUxaCsBbSrXvqJbMXm9heVbT4q9P0ihZK9g7IH2xHYQ0IxR/jEPvLMT4spbro6ySZppvKFbfCKcY/AMn8neL9t2H4znwjhT1PAZE1fiFOTtC9kT6X9LfxNBjH3YyEPvLk3xzfnrOaXTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RohCQUgT; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso7259261a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717426551; x=1718031351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlpW76QzeKSCw9BT8nBrdK8u4rSw9sQ8fa+4t5SibFw=;
        b=RohCQUgTDLePppZ52bHvyUxEZpJcqcZ0FlCs+lMub5aNouQk4lfDSPPKj1cIhPSwQw
         SX1F7kwsFZ9vPnk4x2FKiLg8xkalzLW3toQZiQ8BLtd5F+5ed3JiSwjdj/R2KpqOW17h
         PasggYG2Pplc1ct7qUw4ZJvRLvpjLUVlTERzf3ZSG4O1JY62yVrVoQnlXfhV9N40KbW3
         ym4n3LEt+VtTKhpaGQSnK4FdHihe8h0cNFyr0UDO3G2f3PWg7xI/GT0w0RCIbnvG9QOp
         OpT2/IbE2Vr1WnGROVtNUH5xoPYU81n8BsW1f+T9MJDS/5NAA0GR4IOInpqnuIkXj4am
         2K6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717426551; x=1718031351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlpW76QzeKSCw9BT8nBrdK8u4rSw9sQ8fa+4t5SibFw=;
        b=m4pfH2YIdtAZ6yQ798rFYkEPOKFBBCG9EBgUuTywKiYvyq3nVKdkl7RKPkt4ryfLiK
         fMubOBW5VZsRsofBrjbHWjQw9SqBdFKZtHsngKtHqlQbsy46w7P7u58uLd0Ng01ofS4/
         jkBY6nMauYBgQGlje3kdsV0tVFZNk5+8060GZPgc1y+AVJzdaYroRTpk4S2wz+EoaI/i
         rp26+o9MiGgS+fH3C7kLk7Q58K5jIVrp9+UNaQjqzVvfbvPEBfN8kqaqbyzI9uAUQeKv
         cHgJ8648V3sfFiH7PFCte65PSA6x74SvnxvRH2QFfAcKEP1QjRNZwTeDm3w7idTdbu0b
         /CpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7YM20TvbHdHWoUr2M3Qurx8bpmZsyrHbTCgSIGR7rwfY3YwVopGrmD0M1YlS8aLPeihOluPMZwdVZofTQ3nn59DnzWs5lpqx2pSUc
X-Gm-Message-State: AOJu0YyM0+DK2pt5SOIGJrMoJJ+js/YERDdraEqyHQ+gELLsLB1HzmyH
	LBuaujDiUSIvWkDsnlsM/dim97jDOsYiDeJI3nuphlZWbiDPM9cA3BdAQgnQwebXiuvgqratWyN
	c3KiXIOsRsS5NbdPCa/gzNFI9Ukk=
X-Google-Smtp-Source: AGHT+IE+5fY9qISHCDlYFcC5wT1Cb0y+XbKMMlJ7jBjqsxJGDGodBpMrWKxVC+PD1fHS5whqcz3mFeE5fDcy5hEJjIA=
X-Received: by 2002:a50:9fc3:0:b0:57a:79c2:e9d1 with SMTP id
 4fb4d7f45d1cf-57a79c2ea97mr112736a12.8.1717426550804; Mon, 03 Jun 2024
 07:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603140745.83880-1-ioworker0@gmail.com> <Zl3Wjh9_aGY8Xxm7@casper.infradead.org>
In-Reply-To: <Zl3Wjh9_aGY8Xxm7@casper.infradead.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 3 Jun 2024 22:55:37 +0800
Message-ID: <CAK1f24kKkX8Ed-MGUJbEhJFSUa2CLpo+H-f3ijVBnqFHRHdA3Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/mlock: implement folio_mlock_step() using folio_pte_batch()
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com, 
	21cnbao@gmail.com, baolin.wang@linux.alibaba.com, ziy@nvidia.com, 
	fengwei.yin@intel.com, ying.huang@intel.com, libang.li@antgroup.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 10:43=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Jun 03, 2024 at 10:07:45PM +0800, Lance Yang wrote:
> > +++ b/mm/mlock.c
> > @@ -307,26 +307,15 @@ void munlock_folio(struct folio *folio)
> >  static inline unsigned int folio_mlock_step(struct folio *folio,
> >               pte_t *pte, unsigned long addr, unsigned long end)
> >  {
> > -     unsigned int count, i, nr =3D folio_nr_pages(folio);
> > -     unsigned long pfn =3D folio_pfn(folio);
> > +     const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRT=
Y;
> > +     unsigned int count =3D (end - addr) >> PAGE_SHIFT;
>
> This is a pre-existing bug, but ... what happens if you're on a 64-bit
> system and you mlock() a range that is exactly 2^44 bytes?  Seems to me
> that count becomes 0.  Why not use an unsigned long here and avoid the
> problem entirely?

Good catch! Thanks for pointing that out!
Let's use an unsigned long here instead to avoid the problem entirely :)

Thanks,
Lance

>
> folio_pte_batch() also needs to take an unsigned long max_nr in that
> case, because you aren't restricting it to folio_nr_pages().
>

