Return-Path: <linux-kernel+bounces-195150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AB68D4833
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B3D28365D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E926F2FF;
	Thu, 30 May 2024 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnliNSAA"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4260E18396E
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060592; cv=none; b=BA6Y+9Pdtih21eaxyRxjhTdSOGN1Gr6oylvO6IpRvNPoaONdYOXTtO8XmiTliyB1SHLL/LWdOvx7v2krz0rsDt3zKpm+klCjOBBKzhvnOhyCjZJv94ncBdJ7eLOjB/SGX+oIses5Nf5E2Cn5dbycs8IiyAmpLiC/PbPupEoX+k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060592; c=relaxed/simple;
	bh=NgD7WfXlMQalY3ONpVkE3pFYSug4wiT90SHVL79/DFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1rYeQ3LRcBnenRw9tjKDyRjBR749Op7DPdbzz/SctuDsZakKCpupFNokoocJ/w+4pDU1TgMsMIhU7eFDHU/Hz+l+/1oknG+2qOralWzyy1fg4dG+NQCOkIEsBp4vPHBWuSfMlK8IkNEAJq3H3DhQIHoAiZRP8oqKyb5cWI7q2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnliNSAA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5785eab8d5dso665627a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 02:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717060588; x=1717665388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1XnOTuhpxpO8zzU87yFsF7xaPtDUjo2SnjXEIe/jGE=;
        b=mnliNSAAS0xeYx7iy7sr9nU9Xl/Fx6G3Ryz8QeVkYhrPHaXApz2fyoNUMGecA5q5+k
         fNqHbC3g+y2ZFo7KrAfv0mXBwD4RBZ/355HmLc4gb+5ICTcDv3PLDh7RyfMRonlUBYxB
         hIR/TtqG8o4L+fPJOLzxANawMe7BhogJwF0cBGH57mIjmELqaFhW2KYRRCVnDU63lxQk
         Cc3P4F5J3QKZoQoGb+EWEwQjYE+20n9MEnwbXDM82RVBPF+Z+ON6EesfoQ/k2gfX0S46
         t6osOIYR0TprRZuX2e5VZ4R7EyyXU8B3gwQdYcgiLSvSC0XziIwkNyaPnL92lc8o4VEv
         EU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717060588; x=1717665388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1XnOTuhpxpO8zzU87yFsF7xaPtDUjo2SnjXEIe/jGE=;
        b=tPNJyys3C3cg4gByZxG2vcYF+3hwSUpnVYp9OURmobtZnw8vmBdqot/HFYUk1OCm8n
         o5uaaj2b298dwIX/mGhxniN5N4MlmeptNYYA+1JNj9yb3+y8a6/Kgo6eihScmDvUSr0P
         fxdg6txo8z332jpE7Rwt5PdvoR5c8X4uEUavBGJ8ZtvJ6PowqE52UOGq88LeeNSKXipK
         kfl77gVFupiRMLtd/f6DsXwgxiTTn1A8IpEbNMWxK/MdEkywoYB2tsOGgIZ0299cxBs/
         ZA0qlU+xaeV0oztdsUZkkRqLv0QcWjF3LA9ff9OEm8JfCaupZhN0P7jkJ/tAhQgVEzDq
         Kndw==
X-Forwarded-Encrypted: i=1; AJvYcCWfLY2LZBROO7GQ2ksHafQlG/37vyMeZKGgFyKpKqsUc2pnPrv1TzXqe32VFpBh/YhHYzqUMG/uFvkVUDsqa1Yc6h0s1Fx8KspGx11D
X-Gm-Message-State: AOJu0Yw7JREplh+l21cJ9O+F5AYlXzj/rK3+yhz4IT7QJHXFGg959pX+
	Rz+GwM+QkQxtuXsJ9VeYcCAlq2K3eiPVXspZLinwm/RvbR04HYn83q0tlr5CsBR2T08L31dgzbR
	WO82g+ycXYjbCm1JorAF4c/LbBCa41DCZ
X-Google-Smtp-Source: AGHT+IHY5FGqB1MS6tM5VBgblHUPJiGBCEDB0yMW+i4DBD6TVapuznm+n3XAy9sEeOq7UIFcrSqhaNuOKrqfUUp1W08=
X-Received: by 2002:a50:9514:0:b0:579:e6d1:d38b with SMTP id
 4fb4d7f45d1cf-57a17837d0bmr888746a12.2.1717060588376; Thu, 30 May 2024
 02:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530025144.1570865-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240530025144.1570865-1-zhaoyang.huang@unisoc.com>
From: Chuanhua Han <chuanhuahan@gmail.com>
Date: Thu, 30 May 2024 17:16:16 +0800
Message-ID: <CANzGp4+HJE_h+kBsx9cJzKxJRi3u_y204-numUgzYgJBo2AJfg@mail.gmail.com>
Subject: Re: [PATCH] mm: fix incorrect vbq reference in purge_fragmented_block
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

zhaoyang.huang <zhaoyang.huang@unisoc.com> =E4=BA=8E2024=E5=B9=B45=E6=9C=88=
30=E6=97=A5=E5=91=A8=E5=9B=9B 10:52=E5=86=99=E9=81=93=EF=BC=9A
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
This seems to be the same as before fix :),  the vbq found by
addr_to_vb_xa is still added to the xarray vbq, not necessarily to the
free_list vbq,
These two vbqs may not be the same, we need to find the vbq when added
to free_list.

For example:
We add vb to vbq1's xarray and vbq2's free_list, and we need to find
vbq2 instead of vbq1.
So I feel like this place isn't really fixed=EF=BC=9F
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
>


--=20
Thanks,
Chuanhua

