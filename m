Return-Path: <linux-kernel+bounces-551984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573A3A573C1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D86577AA44A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BF125A2AD;
	Fri,  7 Mar 2025 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0xEOFAi4"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BDE259C98
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383449; cv=none; b=PHpL17IttW6UeJs43GDTqZwz1FE7vrrevsGCe8FSzgZy9Jt8/SVH/SyrHK6BwqJRbmKbBxiiVM860TTO6jlAx6cvA/PPVx4qlr432JYSpVk4+qqyvUbmgp3GPFP0HWbHEltFECxf0oSL3hXVL5BKezD2sp+TkqrQd0ah0uf6Oxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383449; c=relaxed/simple;
	bh=SBGexYpo//Qnxu3348oUujz0dCyz2i7NvjCBbM8doGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3teaMbc72rlU775bK1mWa8h8Pp5je0bKUcoqeeOvDNkHm2N0OXTCxSKcU27vUoExclXTuGlb4GGx01RqBqDCBSftWB6sm6bCpq7GLzUXI6J8FelAuvAv6HYMhaadgOx5jRa7WrN06JuQweUI9QY+r0LkzkU2HjbyBBJEFgux6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0xEOFAi4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43bdf606c48so3415e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 13:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741383446; x=1741988246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NB51fEUoqyERZmGfEYA6o6eyNvKm6CVr9KyZULA3XZE=;
        b=0xEOFAi4NfquFezeKVkrZFWv2RQQbr31omnizmigbiifT+yXZR0EJxCkx8FtdMIe49
         +qlRRXbg5h1+iev7JjZ5K9Fe0L9D3Xi6pwmZwP4xxVz681syYBbKFCOyuEv6ANZU3kQk
         uYUdgaanSrHAVYl3hksSoOLbvq2aWwxls6J/T5DOr1R3RB3pp+fUc6f9xOymj2Lro/ET
         W58m7usn+xxPhxjioaJc/UrlbVdBOg7l9v2v2ninrkCHAKdpv8ODixpFV0ro4ITJZW87
         8XubdahVRiL+1bbnMSGHy/p7qy5JW8A2ThhmFqlud9M4diX+D2N4Tr+gfmmGUVdj+iXt
         iUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741383446; x=1741988246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NB51fEUoqyERZmGfEYA6o6eyNvKm6CVr9KyZULA3XZE=;
        b=sE3atCgk1SA7VCIvzjSScTJdPcOuzVsGqv38FZ6fdJEnlee+y0BL3lvjlXgj/qQZ9P
         deUbzqlBlkBjF2bwpDH1611jR+hn0hda7cPgwnnkBNWhVe0FaX8yngRsod0kIlx1oCrL
         pk3e0WihEBd9sySlC2V90l5QL5gTM+m1FzZzrJryGAwDXWvOJWb9FmsIbt6oOthsuSeQ
         8IpP4kd7S9lwbWF3O5F8wM/BarrMIF5UGcY4+Fx/4rJAWBV5z155dr5WtT+XAtuUwmHk
         4nZI2d0UxOl6PD1smf63Z+MJz6FUzk2j3Pa/+llL3ysk+tHvTBLIQh3OMvaozBfoMRyA
         Ubrw==
X-Forwarded-Encrypted: i=1; AJvYcCV2KccyK12f6RsLfgtkPVLNoIjkUnptBFS0IXaxQzVCGI4Fz8n5Yo1GtY3LZ0lOy4wT8p4PnuhbcFifSCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5y5AyUNz1O+EoKGtsBd6rPKlxTiZb3ANctiZeUE0lKjFlHCtN
	VS+p2e4uWy5Kzezkt9XwuaXzmBwi+5RrlAC47jCpYv06iivL+5j6OyRCHYr2jXB3kefl9dOE8/W
	Ud9EFZ01z2VRnieO3UMDm5wBK0lVa712Rbwse
X-Gm-Gg: ASbGncs+CPhJifXqUixo7c84Dt6ETbGTIHR7ZNJuWVQudT5NtLi9BSBEBOaCfDSvfXg
	KhKZR8G/xYGPCdbpY/GrNAYSWVsnxgVZ+28lVZUjjZxhC9lwHrbJWiER9eoEAj3vNSC3CB56SIT
	qYFgiJ0wtlyQ4SxRUX4nZu2KiKeQ==
X-Google-Smtp-Source: AGHT+IGDutuXG0UbvOaXHMe/NbRvGfGlU+UpdPPeggEqEDxRRFbQI1pFrswRlgRq4PMxSPJPbOaxi/8bYGSSATetA3k=
X-Received: by 2002:a05:600c:6002:b0:43b:c744:1b39 with SMTP id
 5b1f17b1804b1-43ce90989c3mr11025e9.1.1741383445477; Fri, 07 Mar 2025 13:37:25
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
 <20250306074056.246582-1-s.suk@samsung.com> <Z8m-vJ6mP1Sh2pt3@infradead.org> <Z8tVrOezU2q_0ded@casper.infradead.org>
In-Reply-To: <Z8tVrOezU2q_0ded@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 7 Mar 2025 13:37:12 -0800
X-Gm-Features: AQ5f1JqlHQT7Qaz2gu-J2A3s4-t4ifPXIt5qp-vryKMRMi-m9r1t0bmwLS6Hhbw
Message-ID: <CAJuCfpFKuQfQ74f4pLtEO3K1GGeMazb6z52d+oO005ciR8b9+g@mail.gmail.com>
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct IO
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Sooyong Suk <s.suk@samsung.com>, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	jaewon31.kim@gmail.com, spssyr@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 12:23=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Mar 06, 2025 at 07:26:52AM -0800, Christoph Hellwig wrote:
> > On Thu, Mar 06, 2025 at 04:40:56PM +0900, Sooyong Suk wrote:
> > > There are GUP references to pages that are serving as direct IO buffe=
rs.
> > > Those pages can be allocated from CMA pageblocks despite they can be
> > > pinned until the DIO is completed.
> >
> > direct I/O is eactly the case that is not FOLL_LONGTERM and one of
> > the reasons to even have the flag.  So big fat no to this.
> >
> > You also completely failed to address the relevant mailinglist and
> > maintainers.
>
> You're right; this patch is so bad that it's insulting.
>
> Howver, the problem is real.  And the alternative "solution" being
> proposed is worse -- reintroducing cleancache and frontswap.

Matthew, if you are referring to the GCMA proposal I'm working on,
that's not to address this problem. My goal with GCMA is to reuse
memory carveouts (when they are not used) for extending pagecache.

The way I understand this particular problem is that we know direct
I/O will allocate pages and make them unmovable and we do nothing to
prevent these allocations from using CMA.

>
> What I've been asking for and don't have the answer to yet is:

I'll send my findings related to GCMA usecases separately since I
don't want to mix that with the problem discussed here.

>
>  - What latency is acceptable to reclaim the pages allocated from CMA
>    pageblocks?
>     - Can we afford a TLB shootdown?  An rmap walk?
>  - Is the problem with anonymous or pagecache memory?
>
> I have vaguely been wondering about creating a separate (fake) NUMA node
> for the CMA memory so that userspace can control "none of this memory is
> in the CMA blocks".  But that's not a great solution either.
>

