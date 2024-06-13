Return-Path: <linux-kernel+bounces-214062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A21907ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6186283CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAA114B95B;
	Thu, 13 Jun 2024 22:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVEh5Hc8"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D152481AB5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317530; cv=none; b=WJpm5Lvj2JRpf8bTlrPHoj1Hf7hzGRfOmZCHf0ytG38ZVxd5UlE5w65ronYepHt5l3pCrqP6LV/pTGcLN5NU3VwGnn0C3RRUoPwO5yiQMlSt/jp3Pak6tGUa68FDjomE/vanTSpwWQzwiSrI2O2nfp7AIVgpI/Cz2Rw/YlMDLLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317530; c=relaxed/simple;
	bh=Qm+6lH4QT5+duyt9kwMx/N9wK/PVnWhswUSaPZETrqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8l0S3wTKaQ6wAOhAfA7NzqGF8nKxgZODDtLImtGIu9AJBiAgT/gIxBL+J+s3vdUmxFgF3ROdN8WMgyZmHWxg8ifxfkTJR6ea+bFuQpTm9B3v1am5BsNCeBZmqxaWw/hJEDP1HjaDkFFSJuWq8GU/TfiYCPIZsJZJs7UM4YA6Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wVEh5Hc8; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52bc1261f45so1741148e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718317527; x=1718922327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/f9/zCFFnr5q6snjU3sDCoWKGd4r7oZIhbqaxupgdQ=;
        b=wVEh5Hc8azC8gM9yAjco1HfhHUqtjns+OzYmra2D/UpDQRgi/0Cg6ly7sN88PRhK1n
         J9jo/jvIsbvRuWLSbD/njhUXJgjyXrvCZuf7H9MZgyHnB2pxdYeeuEeKnwGVXO5T3DmC
         moj/g0Imzu7HNmELtuvBX8+9GRkTrP81omsqBN9TTVW6ZQm5vd3QXy9XD8zl8MkvuJ1Z
         udtqouMSvN/9TKxA25vgWObXpNqr0+uflW5hAMqgU76p5GOamxGl7ELoF2yrHxySEcrI
         bdq2OSlp1swn7qIqWJeGjvBOHDtO12L/D7cQ2O+e8aezIACSavFNPTTM9t8rJrpP691B
         oGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718317527; x=1718922327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/f9/zCFFnr5q6snjU3sDCoWKGd4r7oZIhbqaxupgdQ=;
        b=rg37z8TgcnNbvdncGohQZ8d8YbIWgDO3hw3dRM+u9N1Zj36u2vBZGjn8EiaVdXtf/t
         NJQ/eI3+E9i02mTcaZ9GG2zrNtu0QNBHKVm/7Tck/bRemGD8dICBHH63W4Ikpu9Is5fQ
         MKiXWxXzwzqqvkkJlQy1gESHfTT2OA6QEKUeebPrcLOwRY9SB9e45I50TNnSGKyfEkaZ
         wIAWGZZ5MFfNPWrT+FO9yMGLV7TQrXDhiiUC4Yw/Mr6nY5x+FGFj0kwBb6AYeUynMCQi
         DKDZOzTUDlDkxIQtjo65Izh9MtZOu8IBgWJhbwg5I8EkKJ6SuUWsQFvFOxsxbNLm7KVP
         AaBA==
X-Forwarded-Encrypted: i=1; AJvYcCXxvGbuJ4y3tyU5Vi14BDj4YK0GKHqwRJ0OCczPkVzxlTE387TVJmYeZWMpPQMXDICGSb9qvF6lLxOB9u7Jp5JyLI56nBxQe8hbAJtw
X-Gm-Message-State: AOJu0YypwNFpEqqgRgLc6kIddpU8tspdpahXayo1R3PH3M6VUyjgAuq7
	Fu2iWzDNx/dF95RStqhZfe1L3RJuJc56KK/lrhcBBaIGz1T9rS3K1UKlEDuxvNDKpguMoo51V8p
	7x45va4TY+u5c2RbP/2fndpi0AOANlcA9ACI/
X-Google-Smtp-Source: AGHT+IGws2WNiAW+CHMNO5l3bV/NuBf94dey6Xz+Fqz4NyttzRBZUtmmXF+78525k26piEhTbhFpGostqyGGy5wNbQU=
X-Received: by 2002:a19:ca5d:0:b0:52c:81b2:ad2a with SMTP id
 2adb3069b0e04-52ca6e65709mr540514e87.24.1718317526706; Thu, 13 Jun 2024
 15:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3c11000dd6c1df83015a8321a859e9775ebbc23e.1718266112.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <3c11000dd6c1df83015a8321a859e9775ebbc23e.1718266112.git.baolin.wang@linux.alibaba.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 13 Jun 2024 15:24:48 -0700
Message-ID: <CAJD7tkYj_+edtqxTWH6Hmakv48Fx0GMUWwvU82L-V8SxmNg2qQ@mail.gmail.com>
Subject: Re: [PATCH] mm: shmem: fix getting incorrect lruvec when replacing a
 shmem folio
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, hannes@cmpxchg.org, 
	nphamcs@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 1:21=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> When testing shmem swapin, I encountered the warning below on my machine.
> The reason is that replacing an old shmem folio with a new one causes
> mem_cgroup_migrate() to clear the old folio's memcg data. As a result,
> the old folio cannot get the correct memcg's lruvec needed to remove itse=
lf
> from the LRU list when it is being freed. This could lead to possible ser=
ious
> problems, such as LRU list crashes due to holding the wrong LRU lock, and
> incorrect LRU statistics.
>
> To fix this issue, we can fallback to use the mem_cgroup_replace_folio()
> to replace the old shmem folio.
>
> [ 5241.100311] page: refcount:0 mapcount:0 mapping:0000000000000000 index=
:0x0 pfn:0x5d9960
> [ 5241.100317] head: order:4 mapcount:0 entire_mapcount:0 nr_pages_mapped=
:0 pincount:0
> [ 5241.100319] flags: 0x17fffe0000040068(uptodate|lru|head|swapbacked|nod=
e=3D0|zone=3D2|lastcpupid=3D0x3ffff)
> [ 5241.100323] raw: 17fffe0000040068 fffffdffd6687948 fffffdffd69ae008 00=
00000000000000
> [ 5241.100325] raw: 0000000000000000 0000000000000000 00000000ffffffff 00=
00000000000000
> [ 5241.100326] head: 17fffe0000040068 fffffdffd6687948 fffffdffd69ae008 0=
000000000000000
> [ 5241.100327] head: 0000000000000000 0000000000000000 00000000ffffffff 0=
000000000000000
> [ 5241.100328] head: 17fffe0000000204 fffffdffd6665801 ffffffffffffffff 0=
000000000000000
> [ 5241.100329] head: 0000000a00000010 0000000000000000 00000000ffffffff 0=
000000000000000
> [ 5241.100330] page dumped because: VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_=
cgroup_disabled())
> [ 5241.100338] ------------[ cut here ]------------
> [ 5241.100339] WARNING: CPU: 19 PID: 78402 at include/linux/memcontrol.h:=
775 folio_lruvec_lock_irqsave+0x140/0x150
> [...]
> [ 5241.100374] pc : folio_lruvec_lock_irqsave+0x140/0x150
> [ 5241.100375] lr : folio_lruvec_lock_irqsave+0x138/0x150
> [ 5241.100376] sp : ffff80008b38b930
> [...]
> [ 5241.100398] Call trace:
> [ 5241.100399]  folio_lruvec_lock_irqsave+0x140/0x150
> [ 5241.100401]  __page_cache_release+0x90/0x300
> [ 5241.100404]  __folio_put+0x50/0x108
> [ 5241.100406]  shmem_replace_folio+0x1b4/0x240
> [ 5241.100409]  shmem_swapin_folio+0x314/0x528
> [ 5241.100411]  shmem_get_folio_gfp+0x3b4/0x930
> [ 5241.100412]  shmem_fault+0x74/0x160
> [ 5241.100414]  __do_fault+0x40/0x218
> [ 5241.100417]  do_shared_fault+0x34/0x1b0
> [ 5241.100419]  do_fault+0x40/0x168
> [ 5241.100420]  handle_pte_fault+0x80/0x228
> [ 5241.100422]  __handle_mm_fault+0x1c4/0x440
> [ 5241.100424]  handle_mm_fault+0x60/0x1f0
> [ 5241.100426]  do_page_fault+0x120/0x488
> [ 5241.100429]  do_translation_fault+0x4c/0x68
> [ 5241.100431]  do_mem_abort+0x48/0xa0
> [ 5241.100434]  el0_da+0x38/0xc0
> [ 5241.100436]  el0t_64_sync_handler+0x68/0xc0
> [ 5241.100437]  el0t_64_sync+0x14c/0x150
> [ 5241.100439] ---[ end trace 0000000000000000 ]---
>
> Fixes: 85ce2c517ade ("memcontrol: only transfer the memcg data for migrat=
ion")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/shmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 99bd3c34f0fb..4acaf02bfe44 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1908,7 +1908,7 @@ static int shmem_replace_folio(struct folio **folio=
p, gfp_t gfp,
>         xa_lock_irq(&swap_mapping->i_pages);
>         error =3D shmem_replace_entry(swap_mapping, swap_index, old, new)=
;
>         if (!error) {
> -               mem_cgroup_migrate(old, new);
> +               mem_cgroup_replace_folio(old, new);

The comment above the definition of mem_cgroup_replace_folio() needs
to be updated with this change. It mentions that it is only used in
replace_page_cache_folio(), which is no longer true.

>                 __lruvec_stat_mod_folio(new, NR_FILE_PAGES, 1);
>                 __lruvec_stat_mod_folio(new, NR_SHMEM, 1);
>                 __lruvec_stat_mod_folio(old, NR_FILE_PAGES, -1);
> --
> 2.39.3
>
>

