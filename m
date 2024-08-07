Return-Path: <linux-kernel+bounces-277935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDCC94A866
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A201B21342
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E871E7A2E;
	Wed,  7 Aug 2024 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GStIOZn5"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E39155C83
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723036412; cv=none; b=l04tgfIOrG0QhYXFucs1fFzzQZ+SZjdq7SLLO/1C1esRjGrLp8ItaEckyM5xWjnBhOwaHns3/hZK3vQglz52OIVROlIQ9TrqLRCTX8K3D3Hm79FcCVlrUG1GODkB8I64M7JG/o3XkZGNXG0wjA/D+M4bJfvwtaYJGajkj5ifliI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723036412; c=relaxed/simple;
	bh=u7ed/2Weoxr+YdpOE1EMtMcWyTBdf5L+GUHUD8Fk84Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MI9lIyUjwXnYs0nznImtnZbVscwS6vh9YDMvQ7SVfrq2RltMT+K9kGVJDhzZ89Cqd3W52oQy02qMowkQsZ6ssyN8HJgitms47LzGCUB17Q6qG6kvCURlRNuszjVxsRGjeEgTRXuiCRb9EDASwvF7m23XBPjygfbAdWV3p3V5lfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GStIOZn5; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7094641d4e6so766230a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 06:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723036410; x=1723641210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7ed/2Weoxr+YdpOE1EMtMcWyTBdf5L+GUHUD8Fk84Q=;
        b=GStIOZn5pBDvxUkiRH/1kFHtwDSGqdPv/D4SNj1vf/Cg8OVDbB+qQ1ck2ZqJdKVhzv
         aI++iGoqNzoZKWK/Xj9gJ37cbHCNDg+1JJ+j9bOGUszVf13r1mSWgEDg8W6OiL+orYUp
         PL6fOpXMHm4y/CuXAnoDk6nm8v8WnKos6VE4f0xu8Kmcz3ZLBMpjhZqL3B6db9cvsKTv
         NBzTe8+cEVFudN3PpftbuYEOUz4DAqZx2Id9TE31PAk2LjWkqikuTbadZ06EfdqpfHm8
         svu3t9XCf/RwQb7QyexY5eZPN5ORiCbIEHxBbn+ELMCP+EmDOUYzO60aEZPRvLTYRbfS
         xhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723036410; x=1723641210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7ed/2Weoxr+YdpOE1EMtMcWyTBdf5L+GUHUD8Fk84Q=;
        b=uPhcoaogNLacM+5/Y/s8yjyjZK1a2iD21D55AFIV7edXJ9O98fv/JMnOAkfoGPadHB
         rYVrZ944AqSKn2IWY4Wehgc3/3VNH90uSDaOMmh5WziNy5fuuReKA3ELq33m8eNyLrX5
         u/eh8ia3pPnaI4DY8CiN2kn0gGQjZhEA6pWwS1vQjtCjCnKlk2zpJtin9cCkzYbz4h56
         /UUsh64+D6cKGZ/kNOwjGcIqhrRBE8ynOw3dzxEnt7R9otDSX/AsnKA4x5+tTmBoujB5
         +RQMtloJPKlEVXiq/n/hk/mFl0VSBCqUZjA5lvaMEGb67RjlOr4zW6/Q8MmGNcekA7nL
         9dBw==
X-Forwarded-Encrypted: i=1; AJvYcCWQsKyTT31bEoVrZNyR7M6sXw0kulDg+eAaBF+/p4cE5QDIOGkE59SMHR6U62UymlUtqkVTsYhgDQVdjXxaWzJIJjoWuAdnH4nrOgAh
X-Gm-Message-State: AOJu0Yxrjg0p+M6tFI2H+SeGUgRp0WZCsMHh605c4I4cVMbKH1J0kg61
	Xt6We2QcxZ7VPHuuW6nY9RqtWYrO5oD48AyyXyDc4h9gXYGzRujiz1aYaxlPguQrYWLRMSM7tCY
	3Y6yZ40y/OObv6DNmH7F1FVbzkvI=
X-Google-Smtp-Source: AGHT+IGcUJm2zcLpzucEqHA+016xcCdViDf6243shSYybmTdgJYwU0OtVNu+quSxGE3UQwEuxCkNUPCytzC1FVxnwU0=
X-Received: by 2002:a05:6358:c6a2:b0:1ad:a25:a6d8 with SMTP id
 e5c5f4694b2df-1af3bb93427mr1635895955d.27.1723036410351; Wed, 07 Aug 2024
 06:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806212808.1885309-1-pedro.falcato@gmail.com>
 <20240806212808.1885309-3-pedro.falcato@gmail.com> <4a84c992-58ed-459e-bf84-02c59ba1d00d@lucifer.local>
In-Reply-To: <4a84c992-58ed-459e-bf84-02c59ba1d00d@lucifer.local>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Wed, 7 Aug 2024 14:13:19 +0100
Message-ID: <CAKbZUD2pVQAyUNJjRxoS1VOnJ09winf79eXUDgn_1V4OH2UzDA@mail.gmail.com>
Subject: Re: [PATCH 2/7] mm/munmap: Replace can_modify_mm with can_modify_vma
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	oliver.sang@intel.com, torvalds@linux-foundation.org, jeffxu@google.com, 
	Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 2:02=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Aug 06, 2024 at 10:28:03PM GMT, Pedro Falcato wrote:
> > We were doing an extra mmap tree traversal just to check if the entire
> > range is modifiable. This can be done when we iterate through the VMAs
> > instead.
> >
> > Note that this removes the arch_unmap() callsites and therefore isn't
> > quite ready for Proper(tm) upstreaming.
>
> If this isn't ready for upstreaming which is it being submitted as a patc=
h
> series and not an RFC or such?

Crap... I wasn't sure whether to mark this as RFC or not (I wasn't
sure if this could be applied as a hotfix, yes it's a little risky but
the changes themselves are simple, and fix an active regression).
I'll err on the side of caution next time :)

>
> Liam is likely to do some significant rework of this arch_unmap() stuff
> soon, and is certainly significantly reworking the munmap() logic, so to

FWIW there was a new series posted at
https://lore.kernel.org/linuxppc-dev/20240807124103.85644-1-mpe@ellerman.id=
.au/T/#m353eb23fc263033c9ca023ead6fa82d1a1ff3263
that do away with arch_unmap altogether (resulting from our exchange
on the regression thread).

> avoid conflicts it goes doubly that if this isn't meant for upstream then
> it should be RFC'd.
>
> >
> > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
>
> This patch doesn't apply in the mm-unstable tree. If you want your series
> to come in through the mm tree you need to rebase on this.
>
> I made a major change to file structure which moves a bunch of mm/mmap.c
> stuff to mm/vma.c (similarly moving things around in headers), which is
> why.
>
> It also means I can't sensibly review it... :)

ACK. I'll rebase on mm-unstable for v2, sorry for the time lost.

--=20
Pedro

