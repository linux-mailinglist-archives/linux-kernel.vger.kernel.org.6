Return-Path: <linux-kernel+bounces-201792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A369F8FC336
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5570928722F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EA721C187;
	Wed,  5 Jun 2024 05:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu5HLBgG"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AC5F9E9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 05:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717567197; cv=none; b=crlgL9ekeWw2wOEAo1JxPQ4eV34FKPmKCFLX4SQFg9WlVwPVXIJv7FYIMKUYo79TV3qlpxWmhkcD+zkxlGyJHMti7xMAFfmW5EWB+djmwmyMdy6Ntjz1vGTRvoWLtF7D8l8u0KpRgsWETsQLWxN8kDlQLPcy0WHmRHQwGY6kPHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717567197; c=relaxed/simple;
	bh=SFcXvKnQpgRF95UBd7x99GK8J+a/xynZOL1qztGEfD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leXzFa5/qXSBXedK8u8c0damni9JEgBfqsH9+4bPNsfWXn3eWhWUr3+xrFtzflznx29QcnD3jIcClYBbLZQhxxau3abaXdGSihWZv5v1gPM7IHtVcQabAnJlnuHTXnB75NgykkMJa5Zf08A7kKOaY2RuooBCPbDEsNjDM+qt09A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hu5HLBgG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35dcd34a69bso4916986f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 22:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717567194; x=1718171994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZ8hI2v3Jfgp0yW8nd6gtJuT9yXGJAiH03ugTaPEmcU=;
        b=hu5HLBgGomWu3gQQg5DmRti88hcTzIAW22BUUQhL1O8ldspxoRy0erOnkowh2neKIU
         1c2myNFUQiR/6zOzsuCeS/AM9NrDezcByfEjQBfpZbQCgZIa8COkv9rm2uGC6o9CIp4Q
         UBxE8M5Sh/i542YGNHs2dEaNH4Y+bFiHnulIAKvJTUD+gpG3PQh8tcSUPXTfNWtEwoPt
         SfUWwA45QjaFshPMYS+sMNfGxtT+dviq7dSNxlxXlfr5rYnt1WWhUzDjNqZKbytGkbkJ
         VBOvYkWnH/lEGIcKZpsCQreOS4J9dPwKNTwCObm7RSPUTT4x/ED/oLQcE0iJqFp+hmk2
         Xybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717567194; x=1718171994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZ8hI2v3Jfgp0yW8nd6gtJuT9yXGJAiH03ugTaPEmcU=;
        b=Qr2QjGoucPvEjZ+UdLVtGSY4HawcMfBEPZikCk4g+BaohorV9YiRMK5DteFv2Z5FIl
         OXEepBFDJOLO0i5M1T159RvU8a7LLqfurUDgqxYSjsa+JQP3iWJJqeHI/Mn91qjhlGuj
         8oe70SnO1YJscZuevzr2ah24UBPwIH2LUiTbPqFzvT2nageX/J+wudtDcqHKIoa6xd2u
         pDernNCybSXVZG1cInlh73v0ciMUGfNnxvL8O8gmtxRbkeblo+bN51GsU2LKcQ1HxpJM
         rhrli4r6pWlAjPRvZURk/R1vhxhWVcbvHWgTD+iFWU9U1+TZN4nCY9MHydWa9sBaGC5a
         GhqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcJcSpLTjZml1u3lU3vi0PgFqIQ6GEpdj33ngaSJYKj7Ob8MnxbR7u6xnMHDfxUhf64GjeyPN9qZoiBzqx/BUvHS2Vo2n025jz7zDs
X-Gm-Message-State: AOJu0YyadTYVCv3YWuocRr6NOdPQkIlNbHJT83tyR++UakGMAULOhYAy
	v1fadrJykBB9dQIFCvsaAjF0j0eLVtyk6+wL5UrRhJg7A9bquLF8Z+IlzD1QoDsaPboMqVCcwe8
	aOWvOQA+pv3A6ppMOztVo0S2k4OE=
X-Google-Smtp-Source: AGHT+IHiliPx0ALdMYvkld9eVusUhyWhRN5fBQD3CNvIMmQDsLQzudx78IeEjP7X2hFvR4pC4q9uU7OcGMRGlaoTjJw=
X-Received: by 2002:a5d:4f02:0:b0:346:e9c4:65b with SMTP id
 ffacd0b85a97d-35e84070e07mr842320f8f.27.1717567193606; Tue, 04 Jun 2024
 22:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716204978-29455-1-git-send-email-zhiguo.niu@unisoc.com>
 <446c7e4a-2a1e-402d-8238-2eee7cdfd5c2@kernel.org> <CAHJ8P3J2NkSfVTEcpxR+n3CjtywMxxEDMg4cLSL=8UOX8KcM+Q@mail.gmail.com>
 <8b841ec1-cb43-462a-9e87-aecdb0755318@kernel.org>
In-Reply-To: <8b841ec1-cb43-462a-9e87-aecdb0755318@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 5 Jun 2024 13:59:42 +0800
Message-ID: <CAHJ8P3K_u=ZmXaMF5jUu_MPSJPAhKmEx4hyaTinMQ=nnLQ9aRA@mail.gmail.com>
Subject: Re: [PATCH] f2fs: enable atgc if atgc_age_threshold from user is less
 than elapsed_time
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 11:48=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/6/3 17:05, Zhiguo Niu wrote:
> > On Mon, Jun 3, 2024 at 3:41=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
> >>
> >> On 2024/5/20 19:36, Zhiguo Niu wrote:
> >>> Now atgc can be enabled based on the following conditions:
> >>> -ATGC mount option is set
> >>> -elapsed_time is more than atgc_age_threshold already
> >>> but these conditions are check when umounted->mounted device again.
> >>> If the device has not be umounted->mounted for a long time, atgc can
> >>> not work even the above conditions met.
> >>>
> >>> It is better to enable atgc dynamiclly when user change atgc_age_thre=
shold
> >>> meanwhile this vale is less than elapsed_time and ATGC mount option i=
s on.
> >>>
> >>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>> ---
> >>>    fs/f2fs/f2fs.h    |  1 +
> >>>    fs/f2fs/segment.c |  9 ++++-----
> >>>    fs/f2fs/sysfs.c   | 16 ++++++++++++++++
> >>>    3 files changed, 21 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>> index 1974b6a..e441d2d 100644
> >>> --- a/fs/f2fs/f2fs.h
> >>> +++ b/fs/f2fs/f2fs.h
> >>> @@ -3694,6 +3694,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb=
_info *sbi,
> >>>    int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
> >>>    void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
> >>>    void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
> >>> +int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi);
> >>>    int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int=
 type,
> >>>                                        unsigned int start, unsigned i=
nt end);
> >>>    int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, =
bool force);
> >>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>> index 71dc8042..44923d4 100644
> >>> --- a/fs/f2fs/segment.c
> >>> +++ b/fs/f2fs/segment.c
> >>> @@ -2931,14 +2931,11 @@ static int get_atssr_segment(struct f2fs_sb_i=
nfo *sbi, int type,
> >>>        return ret;
> >>>    }
> >>>
> >>> -static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
> >>> +int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
> >>>    {
> >>>        struct curseg_info *curseg =3D CURSEG_I(sbi, CURSEG_ALL_DATA_A=
TGC);
> >>>        int ret =3D 0;
> >>>
> >>> -     if (!sbi->am.atgc_enabled)
> >>> -             return 0;
> >>> -
> >>>        f2fs_down_read(&SM_I(sbi)->curseg_lock);
> >>>
> >>>        mutex_lock(&curseg->curseg_mutex);
> >>> @@ -2955,7 +2952,9 @@ static int __f2fs_init_atgc_curseg(struct f2fs_=
sb_info *sbi)
> >>>    }
> >>>    int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
> >>>    {
> >>> -     return __f2fs_init_atgc_curseg(sbi);
> >>> +     if (!sbi->am.atgc_enabled)
> >>> +             return 0;
> >>> +     return f2fs_init_atgc_curseg(sbi);
> >>>    }
> >>>
> >>>    static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int=
 type)
> >>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> >>> index 09d3ecf..72676c5 100644
> >>> --- a/fs/f2fs/sysfs.c
> >>> +++ b/fs/f2fs/sysfs.c
> >>> @@ -673,6 +673,22 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
> >>>                return count;
> >>>        }
> >>>
> >>> +     if (!strcmp(a->attr.name, "atgc_age_threshold")) {
> >>> +             if (t < 0)
> >>> +                     return -EINVAL;
> >>> +             sbi->am.age_threshold =3D t;
> >>> +             if (sbi->am.atgc_enabled)
> >>> +                     return count;
> >>> +
> >>> +             if (test_opt(sbi, ATGC) &&
> >>> +                     le64_to_cpu(sbi->ckpt->elapsed_time) >=3D t) {
> >>
> > Hi Chao,
> >> Oh, I guess you want to fix this:
> > Yes,  Sorry for not making it clear before.
> >>
> >> static void init_atgc_management(struct f2fs_sb_info *sbi)
> >> {
> >> ...
> >>          if (test_opt(sbi, ATGC) &&
> >>                  SIT_I(sbi)->elapsed_time >=3D DEF_GC_THREAD_AGE_THRES=
HOLD)
> >>                  am->atgc_enabled =3D true;
> >>
> >> What about enabling atgc_enabled during checkpoint once elapsed time i=
s
> >> satisfed w/ the condition? I guess this can give another chance whenev=
er
> >> CP is been triggered, and it can avoid the racing condition as well.
> > 1. I'm not sure if this will increase checkpoint time consumption?
>
> Since it won't increase any IO time, I guess it's fine tolerate time cons=
umed
> by initialization of atgc curseg.
>
> > 2. dynamically enabling atgc may have other problems. Is this confirmed=
?
>
> I think so, checkpoint has avoided most race cases.
>
> So, how do you think of below diff:
Hi Chao,
 I think flow is ok,  some details need to be discussed.
>
> ---
>   fs/f2fs/checkpoint.c |  2 ++
>   fs/f2fs/f2fs.h       |  1 +
>   fs/f2fs/segment.c    | 26 +++++++++++++++++++++++---
>   3 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 55d444bec5c0..4a73bd481a25 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1718,6 +1718,8 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi,=
 struct cp_control *cpc)
>         }
>
>         f2fs_restore_inmem_curseg(sbi);
> +       f2fs_reinit_atgc_curseg(sbi);
> +
>         stat_inc_cp_count(sbi);
>   stop:
>         unblock_operations(sbi);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 9688df332147..8d385a1c75ad 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3693,6 +3693,7 @@ void f2fs_release_discard_addrs(struct f2fs_sb_info=
 *sbi);
>   int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra=
);
>   bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
>   int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
> +int f2fs_reinit_atgc_curseg(struct f2fs_sb_info *sbi);
>   void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
>   void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
>   int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type=
,
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index bdc2247387e8..6d4273faf061 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2949,12 +2949,12 @@ static int get_atssr_segment(struct f2fs_sb_info =
*sbi, int type,
>         return ret;
>   }
>
> -static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
> +static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi, bool force)
>   {
>         struct curseg_info *curseg =3D CURSEG_I(sbi, CURSEG_ALL_DATA_ATGC=
);
>         int ret =3D 0;
>
> -       if (!sbi->am.atgc_enabled)
> +       if (!sbi->am.atgc_enabled && !force)
Is this parameter  "force" unnecessary?
in mount flow, even atgc enable conditions are all met, it is not
enabled because of force=3Dfalse.
Or am I missing something?
>                 return 0;
>
>         f2fs_down_read(&SM_I(sbi)->curseg_lock);
> @@ -2971,9 +2971,29 @@ static int __f2fs_init_atgc_curseg(struct f2fs_sb_=
info *sbi)
>         f2fs_up_read(&SM_I(sbi)->curseg_lock);
>         return ret;
>   }
> +
>   int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
>   {
> -       return __f2fs_init_atgc_curseg(sbi);
> +       return __f2fs_init_atgc_curseg(sbi, false);
> +}
> +
> +int f2fs_reinit_atgc_curseg(struct f2fs_sb_info *sbi)
> +{
> +       int ret;
> +
> +       if (!test_opt(sbi, ATGC))
> +               return 0;
> +       if (sbi->am.atgc_enabled)
> +               return 0;
> +       if (SIT_I(sbi)->elapsed_time < sbi->am.age_threshold)
SIT(sbi)->elapsed_time is just updated in mount flow, so
ckpt->elapsed_time is  more suitable here?
thanks!
> +               return 0;
> +
> +       ret =3D __f2fs_init_atgc_curseg(sbi, true);
> +       if (!ret) {
> +               sbi->am.atgc_enabled =3D true;
> +               f2fs_info(sbi, "reenabled age threshold GC");
> +       }
> +       return ret;
>   }
>
>   static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int type=
)
> --
> 2.40.1
>
> > thanks=EF=BC=81
> >>
> >> Thanks,
> >>
> >>> +                     if (f2fs_init_atgc_curseg(sbi))
> >>> +                             return -EINVAL;
> >>> +                     sbi->am.atgc_enabled =3D true;
> >>> +             }
> >>> +             return count;
> >>> +     }
> >>> +
> >>>        if (!strcmp(a->attr.name, "gc_segment_mode")) {
> >>>                if (t < MAX_GC_MODE)
> >>>                        sbi->gc_segment_mode =3D t;

