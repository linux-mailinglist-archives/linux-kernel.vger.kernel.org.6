Return-Path: <linux-kernel+bounces-521362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03461A3BC43
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F16B3A438D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F281DE891;
	Wed, 19 Feb 2025 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="EId4WNAO"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AB11DE896
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962753; cv=none; b=RB6NAPByQ+Aq+r8ZCO+C3dx3TCIt4DlcReHSXEqBsFh2LStOLE6DsC7jP0XLiXk9fdRL0GWXibS3xhI3IC1uMDOreNX3tb4n2OdTr4QTOqv6XhxBZp1PYoLeEK89HxFY207jyDK2bv6w+IFaJ1kDDw5gIQTMMeFKBbDV6o/rt3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962753; c=relaxed/simple;
	bh=StEZrLs9kkzMPaj+AlZ/oMjrecLrpcK3kuXoQ+//Wx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOvB8IrclkJLv1pBiPYdbhVLkgHBKTV5qyOAJ3rRpEN5ddXRVchN/7hEHjllT+8ba91eXpImZLmzGRKaJPE0ZEuhHE6xWNbfd8ESAGAKu8iLSCf4vl6fBWO/cQ6AIPCGVvk/xcCbQ4EVHD86xApwg1HArufyIVi0EMQigqsmTuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch; spf=none smtp.mailfrom=easyb.ch; dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b=EId4WNAO; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5452c1daabeso4239014e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1739962748; x=1740567548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvUqBXo7pX3OGufaHCVvGrqItUXzyJoYQX0buW7FGwM=;
        b=EId4WNAOTQleyzARRXV0ErPkw0XTCD/SvSSncKkao0/8nTAtwTtm4Cegtlla+OwZn3
         WCZHm9D9Nxr67Fa6mTXHw4esFa36Oc+5FgiTR2LjZjU5oFQ6tmYERYayGLpmcOOvj3tn
         xAqvJ2rUtD5USAAJigsUQNlZJpfMrTIR2qmMKSTpy357FW+HzL0t5Czr3SuS+oLb/YT7
         09vSunYqDoLH3wf+uaHDLVQdiN0qo4Vo7RxOkC1Z+xHZdOZLjzYqjXM07e0ges/2COKl
         +s+DiezW/XuZM7P7N0KUGFQoJWYVn99jfjeG9hHrrx46D/qMYVlANI0pdYiGvSA2gkej
         m7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962748; x=1740567548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvUqBXo7pX3OGufaHCVvGrqItUXzyJoYQX0buW7FGwM=;
        b=GQREUJaddZzZ+ksOa7LBizylIV6AgtzIjym2RUZrexFNJDnJi7pYka+5++9Ohkod0e
         FUqOTaZxeERKAIasw48trWndy/Se3XqwIaesQZFNwxcRsw5qs35RLO8gCbfsn/5TigEQ
         xKj/Z5HEHkt+AadMoQnLZH7m8twBJnhu5ZMvElWIvmatxz5Ha1b9wz0mRNB7c/4bCqR6
         2koaancbtc+0Rf33Sg+y1CfwSDFEq3P4hioFbhsmtS5N+VyZrTTPV4lU779QRQ8W79+0
         boDxU5uFGtH5nk6eYNkCq1YwXxwzWE28BSzJ7OHkuIuCONmchNykVgtMJdSO/1BER+cA
         ofmA==
X-Forwarded-Encrypted: i=1; AJvYcCXaO4kLQfiz4UuKK7VFYiUOhK+nZ/AHUgb5XJm4/ZNbL7BXz8e+TVAmgUPi3KKXmQ7JHQUspdmHEXbrhvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcpsdOG29bjNKWhinEp2CBARRMdH5iiTbZP3dILdfo9CAVLof0
	vS4ovdHEBmZwP7Kf1yw9booOSa1BCdVKLWE+I82yyTnILuoIWQhZPayBs4lPqZGa8iWjc5uH3xa
	uhtm6XMO0h2t+joojLOjmxL9Z5x+dYErp16uSWQ==
X-Gm-Gg: ASbGncu71PV2C8WU6kxmIKD1HLLR0poqc2Cp0EOzP58ZWIEmAMsG5wuJ+dyZnjOTbZh
	+ApAPAyf6IB2P65cD183MODTCDLqpmN8rY5VlcFPKbrbT6h8tdG+FkDgIOA1rrQ3KnGKHWfWiqz
	XdXCZPe+Vg89VFjUvR8P+WxIrAPQ==
X-Google-Smtp-Source: AGHT+IFDf2xMI1aCLfZeNkHbqTc1fxdjKU8LMLIa3hxyXKQN16RxmxbrXD8qMf75n+E2fkiXk1K0zktwSDgaBlo61MM=
X-Received: by 2002:a05:6512:158b:b0:545:2cb6:af31 with SMTP id
 2adb3069b0e04-5452fe426cdmr6409842e87.15.1739962747645; Wed, 19 Feb 2025
 02:59:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217024924.57996-1-zhengqi.arch@bytedance.com>
In-Reply-To: <20250217024924.57996-1-zhengqi.arch@bytedance.com>
From: Ezra Buehler <ezra@easyb.ch>
Date: Wed, 19 Feb 2025 11:58:31 +0100
X-Gm-Features: AWEUYZlJLxDsFiFpyrhpbMagLjwKnctzA_YuuA29jDCzt3ZkPaZaHYpVKVWkXxU
Message-ID: <CAM1KZSnM-imYwM5Gf4gw8yXr1+6PXyLvbpKbBu_KJmPR0WS7cA@mail.gmail.com>
Subject: Re: [PATCH v3] arm: pgtable: fix NULL pointer dereference issue
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux@armlinux.org.uk, david@redhat.com, hughd@google.com, 
	ryan.roberts@arm.com, akpm@linux-foundation.org, muchun.song@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Ezra Buehler <ezra.buehler@husqvarnagroup.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 3:49=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.co=
m> wrote:
>
> When update_mmu_cache_range() is called by update_mmu_cache(), the vmf
> parameter is NULL, which will cause a NULL pointer dereference issue in
> adjust_pte():
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
030 when read
> Hardware name: Atmel AT91SAM9
> PC is at update_mmu_cache_range+0x1e0/0x278
> LR is at pte_offset_map_rw_nolock+0x18/0x2c
> Call trace:
>  update_mmu_cache_range from remove_migration_pte+0x29c/0x2ec
>  remove_migration_pte from rmap_walk_file+0xcc/0x130
>  rmap_walk_file from remove_migration_ptes+0x90/0xa4
>  remove_migration_ptes from migrate_pages_batch+0x6d4/0x858
>  migrate_pages_batch from migrate_pages+0x188/0x488
>  migrate_pages from compact_zone+0x56c/0x954
>  compact_zone from compact_node+0x90/0xf0
>  compact_node from kcompactd+0x1d4/0x204
>  kcompactd from kthread+0x120/0x12c
>  kthread from ret_from_fork+0x14/0x38
> Exception stack(0xc0d8bfb0 to 0xc0d8bff8)
>
> To fix it, do not rely on whether 'ptl' is equal to decide whether to hol=
d
> the pte lock, but decide it by whether CONFIG_SPLIT_PTE_PTLOCKS is
> enabled. In addition, if two vmas map to the same PTE page, there is no
> need to hold the pte lock again, otherwise a deadlock will occur. Just ad=
d
> the need_lock parameter to let adjust_pte() know this information.
>
> Reported-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> Closes: https://lore.kernel.org/lkml/CAM1KZSmZ2T_riHvay+7cKEFxoPgeVpHkVFT=
zVVEQ1BO0cLkHEQ@mail.gmail.com/
> Fixes: fc9c45b71f43 ("arm: adjust_pte() use pte_offset_map_rw_nolock()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Tested-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>

I confirm that this fixes our issue on the AT91SAM9G25-based GARDENA
smart Gateway.

However, unfortunately, I do not have a 4-core ARMv5 board at hand to
test the CONFIG_SPLIT_PTE_PTLOCKS case.

Cheers,
Ezra.

