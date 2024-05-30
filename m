Return-Path: <linux-kernel+bounces-194900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CA38D43E6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 04:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B4E1C23277
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 02:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F7A1CA9E;
	Thu, 30 May 2024 02:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk9h0nUo"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8CBF9F7
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 02:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717037814; cv=none; b=HKYkBjGqVObe016wawpFrqKOF0raG7AcZwUyVTIxgy6aKsKDS9S70qyDp4zxE/eYLZhqJIS6As4lRY7fHoqUH/i/hS/Yn3sPmvm1ijXmzLhx1h++ozEYMYHmR0/7N+IkypFaNeX6JSakHEE9kmzoZ+gRbXJxHCD49UV7SRXZG6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717037814; c=relaxed/simple;
	bh=d9/ahd5YF85nH46FuwMEbEAhWjNPf6Zo4Qqtup6Yddk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YY/rWqY/lqq7CnF/sJ6K2Q30q5ztC9SR4TEgcEix/tguqpAeBkSpK9CtfobzGQMINXfLVU7uLlfN5NS4EtoRCUXeA0fGKVBgUmEZiFN9rnAkPHeZHbT8YiRK7MDBJUGDDSIKcHlKtxliaAQocHfoj0hpg/EGWYF6p6FIDBVGGpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk9h0nUo; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e95a1f9c53so4375241fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 19:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717037810; x=1717642610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKswQv9vOWbij26jBLWYSo21fHi9SD5RXG5TtneGY0w=;
        b=Vk9h0nUoLiWKkgqtdKhj27SnyIVyJBBZJq+0ICdxMkPqz6OGHMj+rmZLa62JBUoJQV
         yQqnPeT1DlhLTzBupUm7gSrIST6SOL+7N7l+R71t+dqkZJQahjsuQ+gdtuJEcvwGQ4IV
         3YqXjJ67557h+xiqwlzn9qfct5CCwzabMbw7U5gmpp8gpGe+tZnV96boVYPeMsbHAD5L
         0p2bwZGAz3qIYtLB6JdaO0KkO61yqjNFmygkWxqJVQvMsvoZLOvpbeA78zIRAVRlKl8+
         RW91oON8nKaOmlDFmSdJ0WwfPEoHAQc9Uzg71kZKWofAx35X7k/QxfwWCFT1Jv9bx0g4
         rhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717037810; x=1717642610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKswQv9vOWbij26jBLWYSo21fHi9SD5RXG5TtneGY0w=;
        b=h/I5S0x5ppv3nVqWpLCVCRtq2keARBrE17RJZ4l2hoYFblB2Vt6e5EXeXs0IWPia+K
         Vw7rVpOfhiheYAWw1K+gSYJb74KeVH0plMQ9Jnq5CRxXjK2lfkd4135Cf05MaJt0Brah
         h6pVUPkht8l9LkiY0Yw7xrH5VaBhxqnCs+aV/6pDwSeLZonC1tKSIbmrL5dX3v5bgdEh
         IfXMmqY8hoE6MJFuRfCAZnHPtQo43rdytDZEcmGZgUb+ByznB9FIsZ3itHnfJ0nzNPqh
         6tZXuiJaYY8WVjGCe62wKhJIummGYWgLbUx9dybA+73/FlE+gIHNFoXF0B0IMKBqLxB3
         s2ww==
X-Forwarded-Encrypted: i=1; AJvYcCUx1vsWYgHzDsP/Yxe+6WHEvTmR1dqb0c+H49JHnSwmplwvpCFUxlDJoGkRC1PJctzq7gy8LSS7Jmlj7PiveQCdbvMCU41SHHr6OmLi
X-Gm-Message-State: AOJu0YyAhQCZSaff56b9Gu2RhLSAoR0Kun9359Nw2GyB5qguvtfqefr+
	3OrRiugODy9QhsO5u52RAjAeLLRvUZB4tSQL0YnI7IsV5awVmOvitEzs1PdbeNZvKnPv+UJ7kaM
	J7FoDyHPeHddhEqnsIaKe7CV0Z0w=
X-Google-Smtp-Source: AGHT+IFHdaPznOOwq25PGPvHah0rs3J8h66WFAhG7pqRuuNSsQIKCVf40+wZoXITYhppyxfdypQ8COsBCyVi/lmTGMM=
X-Received: by 2002:a2e:9c91:0:b0:2ea:7def:46d0 with SMTP id
 38308e7fff4ca-2ea84782d1dmr3354241fa.9.1717037810182; Wed, 29 May 2024
 19:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530025144.1570865-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240530025144.1570865-1-zhaoyang.huang@unisoc.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 30 May 2024 10:56:39 +0800
Message-ID: <CAGWkznGnOn9+5Uk9Lu+p++FdJ3KiP6y6t5BSMpmZ=FTTO1w7CA@mail.gmail.com>
Subject: Re: [PATCH] mm: fix incorrect vbq reference in purge_fragmented_block
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

loop Thomas

On Thu, May 30, 2024 at 10:52=E2=80=AFAM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Broken vbq->free reported on a v6.6 based system which is caused
> by invalid vbq->lock protect over vbq->free in purge_fragmented_block.
> This should be introduced by the Fixes below which ignored vbq->lock
> matter.
>
> Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized bl=
ocks")
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/vmalloc.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 22aa63f4ef63..112b50431725 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2614,9 +2614,10 @@ static void free_vmap_block(struct vmap_block *vb)
>  }
>
>  static bool purge_fragmented_block(struct vmap_block *vb,
> -               struct vmap_block_queue *vbq, struct list_head *purge_lis=
t,
> -               bool force_purge)
> +               struct list_head *purge_list, bool force_purge)
>  {
> +       struct vmap_block_queue *vbq;
> +
>         if (vb->free + vb->dirty !=3D VMAP_BBMAP_BITS ||
>             vb->dirty =3D=3D VMAP_BBMAP_BITS)
>                 return false;
> @@ -2625,6 +2626,8 @@ static bool purge_fragmented_block(struct vmap_bloc=
k *vb,
>         if (!(force_purge || vb->free < VMAP_PURGE_THRESHOLD))
>                 return false;
>
> +       vbq =3D container_of(addr_to_vb_xa(vb->va->va_start),
> +               struct vmap_block_queue, vmap_blocks);
>         /* prevent further allocs after releasing lock */
>         WRITE_ONCE(vb->free, 0);
>         /* prevent purging it again */
> @@ -2664,7 +2667,7 @@ static void purge_fragmented_blocks(int cpu)
>                         continue;
>
>                 spin_lock(&vb->lock);
> -               purge_fragmented_block(vb, vbq, &purge, true);
> +               purge_fragmented_block(vb, &purge, true);
>                 spin_unlock(&vb->lock);
>         }
>         rcu_read_unlock();
> @@ -2801,7 +2804,7 @@ static void _vm_unmap_aliases(unsigned long start, =
unsigned long end, int flush)
>                          * not purgeable, check whether there is dirty
>                          * space to be flushed.
>                          */
> -                       if (!purge_fragmented_block(vb, vbq, &purge_list,=
 false) &&
> +                       if (!purge_fragmented_block(vb, &purge_list, fals=
e) &&
>                             vb->dirty_max && vb->dirty !=3D VMAP_BBMAP_BI=
TS) {
>                                 unsigned long va_start =3D vb->va->va_sta=
rt;
>                                 unsigned long s, e;
> --
> 2.25.1
>

