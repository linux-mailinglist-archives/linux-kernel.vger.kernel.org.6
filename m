Return-Path: <linux-kernel+bounces-195010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDCF8D4627
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63C5BB226B8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 07:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4628219FC;
	Thu, 30 May 2024 07:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6978FXc"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245C34D8B1
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717054567; cv=none; b=XTTjnOyVoo3LoxiKJOKsb60bNIo6Nq+0J0jXIxY/h72eQeH0XPmZMrnnTz/+6wc5Fd/WOxgfs30YrSrutDoLqccAbk8tIm/HFj55EmSlrMrF/e74i6aG4JdK6FE9YxtZW6WMdPPEZnYIGTuHXJE2VHwmgQfOVQtf6iajCjsLRhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717054567; c=relaxed/simple;
	bh=XrFaVHL4oDULO419QNHiN/+UmkOARCe6g27e6qBLEF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsBNdNma274h4VJ+P1TrtrI2n16hVZ+/7KXEV1hxeF/btaPzKU//DZAZEa88Lk4IVhDH6o+SsIeR9fSFLFGo3Kp/MQe6oRXwqGZ0qTUpLhlNMkB7ERHqfTW+TKZfjTesNjNj/bVDOH4QFidGr/mVh9KDD1NGtvwIsRWO4ULKA3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6978FXc; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e724bc46bfso5809751fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 00:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717054564; x=1717659364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSdMX9nVn63UzsnfKzlfMyErtMmAkmSMyXsDizDSnrU=;
        b=U6978FXcb5O9viFQySvnXeL16JanEJQ5OJ1nKSVLJd0V41EpRiq7Cm6+vl0+FhMLVx
         0LgQwvpgUBhDR1P35j8HkzvZi/hhClUvwY9b2EYjZEDa0lc1AZIttVtH58dHgiZjbVK/
         LlP3v/GAfrXgStsroT9Ri9euhiwjmPXlh7lCgEEdfeSCwCxICvqdVEVTUph1DlQg/PH6
         gHXP4gnY78Sy4ndQcxc4f5YdGchDxcCj5Z3HuMNx+qf5p5RR6YhVhQwyjSVbHfEK02cs
         GXRzdZftvO0cAf6yAS2O3mK14OhlKeWwIsupWSV8FNJZzrymLQUr8axv4kwh4kocoRCv
         N4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717054564; x=1717659364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSdMX9nVn63UzsnfKzlfMyErtMmAkmSMyXsDizDSnrU=;
        b=MoRUsrKMXXG0eir7Lrmu21ItFM0Cyo6SeritY5MDfQLr5TINAiKUDMs1AALGcpqMgl
         BSuAF5BMUheXsSVMTUwpleO+JLFKDKBKY/NbmB82piPWkpGfexnEUaGdkMYeTuDlY17X
         obUjhcebSVEQrOWHsKazHlX2Kx0uaPuTtW190CVzfPXrJH352v1pbxUe9lV2eOg/EOzB
         JsskqcPruyB8cdqYuPFCSuLyydku78rJ6HAeA9xTMNS0p8QTDN7vM0z2WrCgOvNPyqtq
         XiPJuJPPOtECW/qATw7pa4rAWyAikxkO4hJCzOOE3ljgizRmkwP6K3NtBLQbxjbS2OGv
         0/vg==
X-Forwarded-Encrypted: i=1; AJvYcCX3tfqqR5sq9bEC4/W7fwJlSOmHx/AwFS3iA/2UbIxjSgyUla3F7zF0t1CQLkKg2k6iY6g28nzjy59iyy5kK8cadKlMHNn7K4eZi6Jy
X-Gm-Message-State: AOJu0YwHhV+559Q0BOfb/9KrWKgHKwQEDSB14e3KfktjSml7M2C6uV6T
	yvpViOobU0yJ3D/l75AQgTlFbu+R6apY6LnEV04o3PG7REV/WguK8+8i4CmuTSsf5rYCu/gK7Jg
	u7itciU0a/ISyNLkwHq6vsJWVBuU=
X-Google-Smtp-Source: AGHT+IGt4yUZwhuTvVGgWsfFTUOCI4IUIKuGOQdQBQ4ueIr+TvLrPg/MUYEVlyPEvn9z6PHZ4g/KIWcq6W87wJ8RT14=
X-Received: by 2002:a2e:90d2:0:b0:2e1:fae0:8ba3 with SMTP id
 38308e7fff4ca-2ea846e416emr7310961fa.0.1717054563994; Thu, 30 May 2024
 00:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530025144.1570865-1-zhaoyang.huang@unisoc.com> <ZlgoX1E4/juuP7+o@MiWiFi-R3L-srv>
In-Reply-To: <ZlgoX1E4/juuP7+o@MiWiFi-R3L-srv>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 30 May 2024 15:35:52 +0800
Message-ID: <CAGWkznE=akrSBEQyq+f6tDN6fJ_J59WhJ-bvxpfrLUgTJ73h4g@mail.gmail.com>
Subject: Re: [PATCH] mm: fix incorrect vbq reference in purge_fragmented_block
To: Baoquan He <bhe@redhat.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 3:19=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> On 05/30/24 at 10:51am, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Broken vbq->free reported on a v6.6 based system which is caused
> > by invalid vbq->lock protect over vbq->free in purge_fragmented_block.
> > This should be introduced by the Fixes below which ignored vbq->lock
> > matter.
>
> It will be helpful to provide more details, what's the symptom of the
> brekage, and in which case vbq->free is broken.
Vmalloc area runs out in our ARM64 system during an erofs test as
vm_map_ram failed[1]. We find that one vbq->free->next point to
vbq->free which makes list_for_each_entry_rcu can not iterate the list
and find the BUG.

[1]
PID: 1        TASK: ffffff80802b4e00  CPU: 6    COMMAND: "init"
 #0 [ffffffc08006afe0] __switch_to at ffffffc08111d5cc
 #1 [ffffffc08006b040] __schedule at ffffffc08111dde0
 #2 [ffffffc08006b0a0] schedule at ffffffc08111e294
 #3 [ffffffc08006b0d0] schedule_preempt_disabled at ffffffc08111e3f0
 #4 [ffffffc08006b140] __mutex_lock at ffffffc08112068c
 #5 [ffffffc08006b180] __mutex_lock_slowpath at ffffffc08111f8f8
 #6 [ffffffc08006b1a0] mutex_lock at ffffffc08111f834
 #7 [ffffffc08006b1d0] reclaim_and_purge_vmap_areas at ffffffc0803ebc3c
 #8 [ffffffc08006b290] alloc_vmap_area at ffffffc0803e83fc
 #9 [ffffffc08006b300] vm_map_ram at ffffffc0803e78c0
#10 [ffffffc08006b420] z_erofs_lz4_decompress at ffffffc0806a49b0
#11 [ffffffc08006b670] z_erofs_decompress_queue at ffffffc0806a8fd0
#12 [ffffffc08006b860] z_erofs_runqueue at ffffffc0806a8744
#13 [ffffffc08006b970] z_erofs_readahead at ffffffc0806a6cfc
#14 [ffffffc08006ba00] read_pages at ffffffc08037ed78
#15 [ffffffc08006ba70] page_cache_ra_unbounded at ffffffc08037eb58
#16 [ffffffc08006bb00] page_cache_ra_order at ffffffc08037f42c
#17 [ffffffc08006bbb0] do_sync_mmap_readahead at ffffffc080371d3c
#18 [ffffffc08006bc40] filemap_fault at ffffffc080371774
#19 [ffffffc08006bd60] handle_mm_fault at ffffffc0803cc118
#20 [ffffffc08006bdc0] do_page_fault at ffffffc08112a618
#21 [ffffffc08006be20] do_translation_fault at ffffffc08112a36c
#22 [ffffffc08006be30] do_mem_abort at ffffffc0800bfbf0
#23 [ffffffc08006be70] el0_ia at ffffffc08111583c
#24 [ffffffc08006bea0] el0t_64_sync_handler at ffffffc0811156a4
#25 [ffffffc08006bfe0] el0t_64_sync at ffffffc080091584


>
> >
> > Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized =
blocks")
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  mm/vmalloc.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 22aa63f4ef63..112b50431725 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2614,9 +2614,10 @@ static void free_vmap_block(struct vmap_block *v=
b)
> >  }
> >
> >  static bool purge_fragmented_block(struct vmap_block *vb,
> > -             struct vmap_block_queue *vbq, struct list_head *purge_lis=
t,
> > -             bool force_purge)
> > +             struct list_head *purge_list, bool force_purge)
> >  {
> > +     struct vmap_block_queue *vbq;
> > +
> >       if (vb->free + vb->dirty !=3D VMAP_BBMAP_BITS ||
> >           vb->dirty =3D=3D VMAP_BBMAP_BITS)
> >               return false;
> > @@ -2625,6 +2626,8 @@ static bool purge_fragmented_block(struct vmap_bl=
ock *vb,
> >       if (!(force_purge || vb->free < VMAP_PURGE_THRESHOLD))
> >               return false;
> >
> > +     vbq =3D container_of(addr_to_vb_xa(vb->va->va_start),
> > +             struct vmap_block_queue, vmap_blocks);
> >       /* prevent further allocs after releasing lock */
> >       WRITE_ONCE(vb->free, 0);
> >       /* prevent purging it again */
> > @@ -2664,7 +2667,7 @@ static void purge_fragmented_blocks(int cpu)
> >                       continue;
> >
> >               spin_lock(&vb->lock);
> > -             purge_fragmented_block(vb, vbq, &purge, true);
> > +             purge_fragmented_block(vb, &purge, true);
> >               spin_unlock(&vb->lock);
> >       }
> >       rcu_read_unlock();
> > @@ -2801,7 +2804,7 @@ static void _vm_unmap_aliases(unsigned long start=
, unsigned long end, int flush)
> >                        * not purgeable, check whether there is dirty
> >                        * space to be flushed.
> >                        */
> > -                     if (!purge_fragmented_block(vb, vbq, &purge_list,=
 false) &&
> > +                     if (!purge_fragmented_block(vb, &purge_list, fals=
e) &&
> >                           vb->dirty_max && vb->dirty !=3D VMAP_BBMAP_BI=
TS) {
> >                               unsigned long va_start =3D vb->va->va_sta=
rt;
> >                               unsigned long s, e;
> > --
> > 2.25.1
> >
> >
>

