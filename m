Return-Path: <linux-kernel+bounces-210149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33884903FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4776C1C23E00
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501AA23767;
	Tue, 11 Jun 2024 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yWi+yrth"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2619928399
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119484; cv=none; b=toGRnHy/Y2haSOFnIHdlyZPAc0O+0yNIRy+Ioo6LIPWo4jp59c536gb/5ACrtH/aIG9E85cqOQ8oqja8h77eUZiZH6TP0GvGwHnsGxvg/mVWL06HMPPv91n4KPBrGc9KVXUe82wk/Z5Pl/pTqnPlPm687ariZJThkuRIELvX3BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119484; c=relaxed/simple;
	bh=/dwSstVRIHN9PEcFF8K2VCWFhDw3CyWBawICLCnTK4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzfIIQEGgpK44558jMufFfPQp4YH0jnBB3pX16wnOAwXDaOiw4UCKmX/IOXWI40J8g5aTyKgrNo97mE+PvusQfwPRvB2jWgV9fwozRXkAAZW3HHcRvAUzE/oj8/JBZPmIdBi76iXFvjW6TD9542k1RM0lPT8dHvCb+NSkkszvE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yWi+yrth; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57c61165af6so5010914a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718119480; x=1718724280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+70rPRbTmia/VEIc1/MKb7Bbc21YVKTZi4Axx4ZXvY=;
        b=yWi+yrthNtTae+UCzrvplnxb4Puf5cwLyKdMa1frAGrfiQGECAHVe/3OcZtpslnwVV
         wp6zat0ubhUrSfg0FGIBkF6NsHn4tOOE+NXVkefTUejeVQU00KJ0mrFP4QEE/J2OQTdk
         Yh4Afmd0eEnFIXd1Kpb6tjS5feQpDU69AIVGuhWIV2e4AY+sJbnggvILooAOmhHusZnA
         kQL8gFPVU8H+XqIN+kLNseUCyyLcAuD6qBs1j8jgGWwjq1JAUTbj+Q8P2PyGJMAIG9/b
         xjAB9ZYKyKS/OVFlGvBVLkv8imp4h2QacQthz6kNh/3SsfjiFZLNH2Ko7iiyEBUpSdwt
         OILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718119480; x=1718724280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+70rPRbTmia/VEIc1/MKb7Bbc21YVKTZi4Axx4ZXvY=;
        b=D+mVeMXyJAZNhqZ/8YowFk7kZUzpqp2RQJN4IcAFwPAxTTCRJSTAv2CdIppe+5mJci
         NW1IO334Fs9NIO6XtK0yNZb9DMqB7x4x6tmUwhIvlLNM6d3fjfrrC75WwRzfOhBCGIcl
         Touc60ZyBu8qJyyTMjD13U5aVP+jb5PTe6qOW2IV+v4AmrUxLxFYsZAQPNnzEeJMNQs+
         gr2sE+ybFoNWzp4kIx36I+IowRG4XMJ0d/qeSk3iDEwL+ZZM9xn0iiJLRFVM/6PlG+bH
         zF/a1Dhufug8BuHA/lOcGAIRWZX7n97fnU9REXeRrNXjsrNUY1tqjrRkK00Kb8XG960X
         mKHw==
X-Forwarded-Encrypted: i=1; AJvYcCWNorDcPypw1nBLapVxmUTHGIMA38WEIhrQrO9IPnZlyRcWrLzZpXKX5XWW2rVkLpI6YkIYrWG5uFgMHMcdWErYFHSRdbdIqthO4mF6
X-Gm-Message-State: AOJu0YyaSwARjm1JszvNrVwNlx6BtxaJEmWFiJ8o8TWMEElodWczUsh0
	ievkN6RO1cEf3CPwCHaTBkq353soN7N9F43K1hh1/gDA9XkR6Y8J/sD++aD6Qf/rk0Gm8cSI0We
	pd1AVRNIOyZT4LhWmzGMQc+7K2mDAWlJXwGu1Zw==
X-Google-Smtp-Source: AGHT+IHWWWOkriPN+KE2CITqDSoNEiVlJsEhFm+lzJh/A8Jg4Wdvxi/Mv2AisOMO+RU+t5zcPZFRFSgiNLS4Lk4twq4=
X-Received: by 2002:a50:9e4b:0:b0:57c:5637:b2ae with SMTP id
 4fb4d7f45d1cf-57c5637c846mr7651818a12.12.1718119480355; Tue, 11 Jun 2024
 08:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611141849.2788693-1-abrestic@rivosinc.com> <6b5392f5-209d-4d3e-b5c3-ba875bf8416d@redhat.com>
In-Reply-To: <6b5392f5-209d-4d3e-b5c3-ba875bf8416d@redhat.com>
From: Andrew Bresticker <abrestic@rivosinc.com>
Date: Tue, 11 Jun 2024 11:24:28 -0400
Message-ID: <CALE4mHotopTeAX05knsfQ6U1tYP+pQjWAbS5KbxKH5exU1frtw@mail.gmail.com>
Subject: Re: [PATCH] mm/memory: Pass head page to do_set_pmd()
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:46=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 11.06.24 16:18, Andrew Bresticker wrote:
> > The requirement that the head page be passed to do_set_pmd() was added
> > in commit ef37b2ea08ac ("mm/memory: page_add_file_rmap() ->
> > folio_add_file_rmap_[pte|pmd]()") and prevents pmd-mapping in the
> > finish_fault() path if vmf->page is anything but the head page for an
> > otherwise suitable vma and pmd-sized page. Have finish_fault() pass in
> > the head page instead.
> >
> > Fixes: ef37b2ea08ac ("mm/memory: page_add_file_rmap() -> folio_add_file=
_rmap_[pte|pmd]()")
> > Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
> > ---
> >   mm/memory.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 0f47a533014e..f13b953b507c 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4764,7 +4764,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> >
> >       if (pmd_none(*vmf->pmd)) {
> >               if (PageTransCompound(page)) {
> > -                     ret =3D do_set_pmd(vmf, page);
> > +                     ret =3D do_set_pmd(vmf, compound_head(page));
> >                       if (ret !=3D VM_FAULT_FALLBACK)
> >                               return ret;
> >               }
>
> That certainly makes the "page !=3D &folio->page" check happy.
>
> It is *likely* incorrect if we would ever have folios > PMD size (which
> we don't have on that path yet).
>
> I assume that the thp_vma_suitable_order() check would detect any kind
> of "different placement of the folio in virtual address space", where we
> could mess up.

thp_vma_suitable_order() checks that the folio fits in the vma, if
that's what you mean.

> Question is: should we instead drop the "page !=3D &folio->page" check
> that I added?

Indeed that's probably better as I'm now noticing that
filemap_map_pmd() has the same issue. Will send a v2.

Thanks.
-Andrew

>
> I think I added that check because I saw the "compound_order(page)"
> check and assumed it would return 0 for tail pages, but missed that we
> get the compound head first.
>
> --
> Cheers,
>
> David / dhildenb
>

