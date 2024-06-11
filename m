Return-Path: <linux-kernel+bounces-210514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5899044D1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C19B23A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B007581F;
	Tue, 11 Jun 2024 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrFKcaDC"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F358AA7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718134423; cv=none; b=KpGZn46qRV2QltLPhp5eHKMGg17jlGT6B5/rQok/A5GqO6vSbPXUKOjorR35FtZcM41Fkz+JnVgovBhPLW1N+CpW9zM8MSO7YQDgD8qovVIfT2HKRjCsnN6UcBmAukLO1UYQHo6frIFY2j1GVuWt98q+yxfsSEK9VHCN4Sppr0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718134423; c=relaxed/simple;
	bh=3q/oHd/sGPhrKLrE76Ky4IeFbRTUZXL3KdgTklMqIlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsYmfwKsZCXcdiEjVH3dla8QocrgRJE47vgL+2Cg/VQ8gisc0Ve6FlgDz8OMX8p5fT/bVvjxIa0M4eVN4MQ1/34PU6v3lzvd8PK5TNc42qLhdI+SOn6zxmzXjPjKMRP6cxOxYNTU7Mmuj/mwrn//pwgXqMN0ZA9B4x/DaBgM+hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrFKcaDC; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-795fb13b256so17605985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 12:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718134420; x=1718739220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGtzdB8knDd9uVpWyNbE1brN7EN38ArWVMjYz6tbA8E=;
        b=LrFKcaDCe83LMxE0syM0qCTGOTwL3EyuczdiEAPjTXvVSJnPNjZc7v+auh4A7wQiQj
         GIdVfnaTue9yB7bsGWOY+bTYa3DVDzIdzJ3zXpdj1Na1i++mS2LwntE/qOB0qleCKy0T
         srrmgCVn1oD/FxyRyeC4kdXxmvhMv98ng5DKc109yx/qd71bTAO9dHDz6Cqj0G2a1Ji9
         shtgvAKof/k1bdyZamaVpad0bAOCKxW2cN8nE3cOBtQr3TdGk4p/89iDRULDubWIqlxY
         pwqP5qn6emtwRIb/L3Xey+VNHuM4S6rshqC9IARkrwjw5lffEvirnpgPRlGBQ+N8XP1X
         Nv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718134420; x=1718739220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGtzdB8knDd9uVpWyNbE1brN7EN38ArWVMjYz6tbA8E=;
        b=XpFvIk0D2wPf3uLUKsKHf2l8/FdFgUc7XKFDYe/oWP3BVXtyaxKvJHjhS4POgLONTy
         YjiqYHC2gFNWI6mg0J9JBY2A1kTvuRPGBzNbpxGSzCXlIcjxqJKbr1nBa7UWeVXPkXD7
         A7Pfm+cH1c9T7Iwigq4CKKHO1PGY6Tazw8eaa9w56rffXzadzJFsziBoaBvrVJcV9Cnq
         dHyi5j73sOCv1GnCvxzp0oH5msC6nzN1X5xFax1oRnoihdD6PnW/pcA6JOnkJN+TkL9o
         5i6GsHMXgMOstwaez8eaSMZD9XvTJ+K+0ByFDdvMhrVZ6whincS0nd9lxzCKcJ5fQBJ1
         Bz3w==
X-Forwarded-Encrypted: i=1; AJvYcCV/eD0STxlo3Vau+fPoWsH3DCxIDnVNnFknZf6KVXJauOfcKfOB/0c/M3ciW+CKBmWbetQFa3V+h1t/pNHrD7Kyvvq8HmTP1SeB5zt+
X-Gm-Message-State: AOJu0YyHzmLSlSP1I0E8we8zJ24YHpKliG5lEqBIxT6j+Gq9s7p34bav
	IxiUQbnp3Ne1LWaTfj4XBQwrSI88X14PgKucUtIE/p3UWSOpyrcefTycQCwy9pbFyG4UmSf54jn
	+NfZlWT2uTrZJpecLz6BlTm9A/lc=
X-Google-Smtp-Source: AGHT+IHhC+MO1Zr9z6Wg7jVXqtwNEJPILeYSXjDsNPiz7wS1EB8kCfVlhBWp0VQpcu59rSs79Z4d1dcaNbff0ZGzNFM=
X-Received: by 2002:a05:6214:418c:b0:6b0:820a:db18 with SMTP id
 6a1803df08f44-6b089f4870fmr63732926d6.16.1718134420632; Tue, 11 Jun 2024
 12:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610121820.328876-1-usamaarif642@gmail.com>
 <20240610121820.328876-2-usamaarif642@gmail.com> <CAKEwX=PnwjmZKPLX2=ubD6+-+ZAqpXnczkHe4=1QY1hizOE8WQ@mail.gmail.com>
 <d6088fb2-58d8-4ed1-8d3b-83ea34657db7@gmail.com>
In-Reply-To: <d6088fb2-58d8-4ed1-8d3b-83ea34657db7@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 11 Jun 2024 12:33:29 -0700
Message-ID: <CAKEwX=MOWFQojVgO7u=zEpQSG661j1QHjTGL9m3Gcy47CLNKAg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: store zero pages to be swapped out in a bitmap
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com, 
	ying.huang@intel.com, hughd@google.com, willy@infradead.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 11:50=E2=80=AFAM Usama Arif <usamaarif642@gmail.com=
> wrote:
> In swap_writepage, with this patch you have:
>
>      if (is_folio_zero_filled(folio)) {
>          swap_zeromap_folio_set(folio);
>          folio_unlock(folio);
>          return 0;
>      }
>      swap_zeromap_folio_clear(folio);
>

I was concerned with the swap slot being freed and reused, without
ever being read :) But looks like it has to be properly reset before
being reused, so all is well on that front.

What about the put_swap_folio() -> swap_free_cluster() case - do we
need to handle zeromap bit clearing here too? Looks like it's clearing
the swap_map (i.e returning it directly to the swapfile, allowing
those slots to be reused) here, and I notice that you clear the
zeromap bitmap wherever the swap_map is cleared as well :)

I jumped around the code a bit - in free_cluster() (called by
swap_free_cluster()), there's this chunk:

if ((si->flags & (SWP_WRITEOK | SWP_PAGE_DISCARD)) =3D=3D
    (SWP_WRITEOK | SWP_PAGE_DISCARD)) {
    swap_cluster_schedule_discard(si, idx);
    return;
}

swap_cluster_schedule_discard() does clear_bit() on the zeromap on the
entire cluster. We also clear_bit() in the work function
swap_do_scheduled_discard() (is this redundant?).

But what if this check is false, i.e the swap device does not have the
SWP_PAGE_DISCARD flag set? Are we not clearing the bits in the zeromap
here?

