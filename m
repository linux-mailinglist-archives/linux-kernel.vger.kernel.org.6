Return-Path: <linux-kernel+bounces-522490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCD2A3CB0C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A725E1897E30
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784A22566FB;
	Wed, 19 Feb 2025 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY/e0v1S"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533972566E4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999143; cv=none; b=RlxRbMk+QkOPxleu4hgJR4fwJ4wI1C8eOBzL8ucOlIDU4N6fBJHGTRA4OHelQ/OYmZfNm3kZ75QXybTtwVa7gpsLStm7RBBjl2J4E716ynIds7gLbrP/bqTjlUJQt5TJJfrkmTMj0ac7XlfYlGMd2oOQCHEiF7CUsm2V3DyAjmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999143; c=relaxed/simple;
	bh=0Rm9eIfKSQ/zlt5KMl79nVp8kIScLXvUY15VEZHBKYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCqMYSXiqV0BEhBFvF3x5ra/VA3ZN3NSTFWanIWCa2w++1YLSzVq8I98XMvlOBjkBXuWfwN8ASEzPO21553wyS2KWULMFbHBZmdHBzP+oSFZEqQNOgZEWM/7TaR64UUa93ncUzU3MG0RRAomUewgOEt+IJ+KLVQShxm+EEKzTng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TY/e0v1S; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5209962eefbso797920e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739999141; x=1740603941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozKX8EB595dKWkVx/ZkqcwD0irC5HmAJEn7UpeXQpdo=;
        b=TY/e0v1S5nRHyUy2OoC5VPu+6axfTjGeYoq13GmnTe1K054vRbKw75i2ZOk5UrRRDI
         Zq19puHuVqcDIaIyVsZY4p9foE8WVBj/hIhz5iF6Uc/HTKn9hbAqaZKs4vjIiD5m6eZY
         jysLndgC5hy+F2SWcqh9Hh7o0laEOogvLx9bgl43mimV1d15bZgjqDenbB0tukipcNYt
         9pyqEbC1PYUwh96YZkrXTGQIyYN7C6taAl7aw53v1KMVX355mk0xn7gi6dVkKd8yLUbc
         6NnKzFy8H8dhf6q58g4a0+ayNOu9X5r04cs+xtmzo3jGgSdTjb3tGDqQYnBNj4idrDi4
         9MYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739999141; x=1740603941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozKX8EB595dKWkVx/ZkqcwD0irC5HmAJEn7UpeXQpdo=;
        b=vyEF9LibyCzzMcRw5a7tyY+MHt+V2J6UPw6+yc0VEUIhkYt+Mig1TeE0ML3S0g0oNz
         xfBZSx5axbhJmH8zRDp775V/81TXNsLdG2Gwfxcaq2UaE034q7Jh9It5im5z6xPNL2or
         CLP/Vwo2NC8SLYQpY/Q3xl6dg/Ie8yMfUmcfLhKomc6LiWzsCkNkVCsXZuml0uS8qyE0
         VFFH7kbZq6hL8gaLAjFvxVHr1S8bysODRwQQmWQmIFMZCRIfw9lonW0RjJBSfnvfYbRA
         vZkGvKTDLJkgv6sYoiDm7/D/4AwRq8c/SdoITcniWHMXE9Ac3Ie/PhiBL1+Fmw95jHsx
         kmhg==
X-Forwarded-Encrypted: i=1; AJvYcCX76f6aomR2P1Bl+Ag1t+6yy45MBXpsSjUHl8c0HfvnZat/1Yq7KpkJl+QP9NoBihcnyf2qyP7I5fhTti8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtsTB/8vB/S0pKpnk8fDLcZ0foEQY9o+kzloLIEc2I30aekhKa
	DUfBiG2aC7vzAZBjrPBX80I5YoOwWb4bQ+pw/pIL5OSAotBcD+9Mb84IApf2vWygFmkkYCw6KZ2
	U34IHGtMw4efPXtuPEXpQ0rI5vc5GW8TV8nw=
X-Gm-Gg: ASbGncvpjNWM7mGxvNAczJP7UfJzTghT6RXVKwMCJ8YkMCGBSJk0zEqqNkdGxwoTaP5
	cYtUT+srmuiDOXTjs7krvOMD253Zn1dgoMsum6zJ+pYb6E2VU0aUsTeLzpWzoC09Ie9hXnkLJ
X-Google-Smtp-Source: AGHT+IGCD214O1Z2CAttBkQ7cpwBR6P2ls1wpoMRnm+e71A2GGx/72YrPtTouPG1GusemkVSbUBoq1j5AJR73SKr2iU=
X-Received: by 2002:a05:6122:4694:b0:518:8753:34b0 with SMTP id
 71dfb90a1353d-521dcdc478fmr451305e0c.4.1739999141143; Wed, 19 Feb 2025
 13:05:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219112519.92853-1-21cnbao@gmail.com> <CAJuCfpEWFz14R1vD4Rezy98WBk25HWWX+6DsGBekeYMugKTsfQ@mail.gmail.com>
 <CAGsJ_4yx1=jaQmDG_9rMqHFFkoXqMJw941eYvtby28OqDq+S7g@mail.gmail.com> <Z7ZFwff-8StHCzWl@casper.infradead.org>
In-Reply-To: <Z7ZFwff-8StHCzWl@casper.infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 20 Feb 2025 10:05:29 +1300
X-Gm-Features: AWEUYZlvbRw9NuFg1mjfhj_LuhQYh60Hg4fzYAQ4DfjWzpY3Gb3EqUjybcro_fs
Message-ID: <CAGsJ_4xTXqdFdOuGKEw9MffQYPHasBVQ8aumL_kwGbCSvqJ9VQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
To: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	zhengtangquan@oppo.com, Barry Song <v-songbaohua@oppo.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Axel Rasmussen <axelrasmussen@google.com>, Brian Geffon <bgeffon@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Jann Horn <jannh@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Nicolas Geoffray <ngeoffray@google.com>, Peter Xu <peterx@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>, 
	ZhangPeng <zhangpeng362@huawei.com>, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 9:57=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Feb 20, 2025 at 09:37:50AM +1300, Barry Song wrote:
> > > How complex would that be? Is it a matter of adding
> > > folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() and
> > > folio->index =3D linear_page_index like in move_present_pte() or
> > > something more?
> >
> > My main concern is still with large folios that require a split_folio()
> > during move_pages(), as the entire folio shares the same index and
> > anon_vma. However, userfaultfd_move() moves pages individually,
> > making a split necessary.
> >
> > However, in split_huge_page_to_list_to_order(), there is a:
> >
> >         if (folio_test_writeback(folio))
> >                 return -EBUSY;
> >
> > This is likely true for swapcache, right?
>
> I don't see why?  When they get moved to the swap cache, yes, they're
> immediately written back, but after being swapped back in, they stay in
> the swap cache, so they don't have to be moved back to the swap cache.
> Right?

I don=E2=80=99t quite understand your question. The issue we=E2=80=99re dis=
cussing is
that the folio is in swapcache. Right now, we=E2=80=99re encountering a ker=
nel
crash because we haven=E2=80=99t fixed the folio=E2=80=99s index. If we wan=
t to address
that, we need to perform a split_folio() for mTHP. Since we=E2=80=99re alre=
ady
dealing with swapcache, we=E2=80=99re likely in a situation where we=E2=80=
=99re doing
writeback (pageout), considering Android uses sync zram. So, if
swapcache is true, writeback is probably true as well.

The race occurs after we call add_to_swap(), try_to_unmap() and
before we complete the writeback - page. (Swapcache will be cleared
for the sync device once the writeback is finished.)

Thanks
Barry

