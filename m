Return-Path: <linux-kernel+bounces-201799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528828FC356
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81034B22A89
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2409321C193;
	Wed,  5 Jun 2024 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avbaxKhe"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4163F2BD0D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717568215; cv=none; b=Q1/btzdsFhUP+/yMI2wEoBvI6cubCTPriB1kQLpM4P5KLAFbm10prn8yShkxpmkyVMwisa72XMIEO0PAzFIkY5xqkgcJp0XRIuy9sD5mWkxkLEnV5wUx+3g8pEiPY4KOAoZVjIoMOfz2DAFk8pyXnh+WVrlexFt7evopVE7llfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717568215; c=relaxed/simple;
	bh=CjMSUzegv17drsCk39vqlkWEL3OD456iy+JDHMJpID8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0T2qZCnnKR7P46Rt1+dqTpDwVXAmPGrs5zG3YmlElCDCY7F1Cpk7gK0aHKCzps5R1z5pDGlvBMhqk6PM64BcfAeoYyfwmP+ICrzxBwZStUuxn0nK50yMbpW7/tMBTa94FWvxvo8vyGAoZlbCKktTjjIVECHCiesK5MJ3RRu3dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avbaxKhe; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35b6467754cso1326648f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 23:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717568211; x=1718173011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwGm8rESyWh/j9N7TP3XclxhQKKbAqP/4YUVHI40L1M=;
        b=avbaxKheWPLKz6BX1gqSFx1iInhdB9My5U8y5IQGxwBB2pr67otAhkYJQ33Caloez4
         xWe9dM1S+MPj5LMc9S94kad98qhV+dNgTjBoDXmAh4HnPl/eWwKcPC86LFqxLzfE/g6b
         lI077wYyT3ZuXHJ4Xp+JN84REyUoZKWtU77a2ksVrmDe4jxnhqZGo9h7hB1HjwJp7KTL
         ijN+f1b21pYvrpxyq39xPqE3SkYLz4SduRtVTPgXVYAivCgFSVcXZZ4mX6KttrtRraQ6
         UJSGAbs/MRoS9aZrLt3kiVZQRuTiqWB4pBv3+Kz0iGK3pcjBbvnNzmt5/S8mx8uC3FR+
         1ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717568211; x=1718173011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwGm8rESyWh/j9N7TP3XclxhQKKbAqP/4YUVHI40L1M=;
        b=rYDjEnil46wGrIdKKx7s4dUupn4NFv8xdMnyYALE1LdGw3DVPwuPmbtEDYXJ9JZoN1
         xXzXbgPXEgMWi2EIglPy+04UW0GLHKnCj9lKY+ebBmEtBhQpDl2hJhPgr/5EYflRLhIQ
         5fmUM5kozNZQcpLP5OMWQMPC/UY+ISYVlDkrX8uMKXOWS25yekJjog5aQH/MtL1pI8tJ
         8Jc6vfijibwLsi7YXzq6jRvKJ5EfHU6SdBnWEyEs3yeqRFuj/D31kolCYorH3XPW15Br
         8PKuShTJ+e9p3kBsie9f8AbdHlPGHqy4BVyKXlLv3OB+yohO0foH33ua2zfr+93r29j1
         xbuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUwiEhxcgk34ZLFl2MjrUJRw10qnym5YPF25JmCFqjenlTtnAcWU7nI45XiZzW3D4ktnqOhozQ15nfTf2Y8uNjWnwOYeKgECJJRoH6
X-Gm-Message-State: AOJu0Yw70cCc2AINjscrgPXI+HYn/+NtRCbCn0SaFhFwA6VNgyAR5JTm
	j3cPE0rswsiZXdg7kIbfc1M5VpyCTxXMOYTwY1SCE6WypUWxCJh+F2AlcOLX1iUAn/YCBasv9dY
	n0j+yAzpd0iEx0Fwa3Dmh3VQL64U=
X-Google-Smtp-Source: AGHT+IHvLDn3WWDRIgiBb8xegCJSb9c/zQHxf2WkNfJ5iZcm6MyyQdSm7iuIni8OEHC+yMg0pvFFNUMJsFjTx3TDHb4=
X-Received: by 2002:a5d:54c9:0:b0:354:f622:fc5b with SMTP id
 ffacd0b85a97d-35e88338622mr1177547f8f.23.1717568211177; Tue, 04 Jun 2024
 23:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716204978-29455-1-git-send-email-zhiguo.niu@unisoc.com>
 <446c7e4a-2a1e-402d-8238-2eee7cdfd5c2@kernel.org> <CAHJ8P3J2NkSfVTEcpxR+n3CjtywMxxEDMg4cLSL=8UOX8KcM+Q@mail.gmail.com>
 <8b841ec1-cb43-462a-9e87-aecdb0755318@kernel.org> <CAHJ8P3K_u=ZmXaMF5jUu_MPSJPAhKmEx4hyaTinMQ=nnLQ9aRA@mail.gmail.com>
In-Reply-To: <CAHJ8P3K_u=ZmXaMF5jUu_MPSJPAhKmEx4hyaTinMQ=nnLQ9aRA@mail.gmail.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 5 Jun 2024 14:16:40 +0800
Message-ID: <CAHJ8P3LgbpLZhP3+maGXpuwsSzn20Kw5Rgdwsb7y1q5BfTyrwQ@mail.gmail.com>
Subject: Re: [PATCH] f2fs: enable atgc if atgc_age_threshold from user is less
 than elapsed_time
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 1:59=E2=80=AFPM Zhiguo Niu <niuzhiguo84@gmail.com> w=
rote:
>
> On Wed, Jun 5, 2024 at 11:48=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
> >
> > On 2024/6/3 17:05, Zhiguo Niu wrote:
> > > On Mon, Jun 3, 2024 at 3:41=E2=80=AFPM Chao Yu <chao@kernel.org> wrot=
e:
> > >>
> > >> On 2024/5/20 19:36, Zhiguo Niu wrote:
> > >>> Now atgc can be enabled based on the following conditions:
> > >>> -ATGC mount option is set
> > >>> -elapsed_time is more than atgc_age_threshold already
> > >>> but these conditions are check when umounted->mounted device again.
> > >>> If the device has not be umounted->mounted for a long time, atgc ca=
n
> > >>> not work even the above conditions met.
> > >>>
> > >>> It is better to enable atgc dynamiclly when user change atgc_age_th=
reshold
> > >>> meanwhile this vale is less than elapsed_time and ATGC mount option=
 is on.
> > >>>
> > >>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > >>> ---
> > >>>    fs/f2fs/f2fs.h    |  1 +
> > >>>    fs/f2fs/segment.c |  9 ++++-----
> > >>>    fs/f2fs/sysfs.c   | 16 ++++++++++++++++
> > >>>    3 files changed, 21 insertions(+), 5 deletions(-)
> > >>>
> > >>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > >>> index 1974b6a..e441d2d 100644
> > >>> --- a/fs/f2fs/f2fs.h
> > >>> +++ b/fs/f2fs/f2fs.h
> > >>> @@ -3694,6 +3694,7 @@ void f2fs_clear_prefree_segments(struct f2fs_=
sb_info *sbi,
> > >>>    int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
> > >>>    void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
> > >>>    void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
> > >>> +int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi);
> > >>>    int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, i=
nt type,
> > >>>                                        unsigned int start, unsigned=
 int end);
> > >>>    int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type=
, bool force);
> > >>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > >>> index 71dc8042..44923d4 100644
> > >>> --- a/fs/f2fs/segment.c
> > >>> +++ b/fs/f2fs/segment.c
> > >>> @@ -2931,14 +2931,11 @@ static int get_atssr_segment(struct f2fs_sb=
_info *sbi, int type,
> > >>>        return ret;
> > >>>    }
> > >>>
> > >>> -static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
> > >>> +int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
> > >>>    {
> > >>>        struct curseg_info *curseg =3D CURSEG_I(sbi, CURSEG_ALL_DATA=
_ATGC);
> > >>>        int ret =3D 0;
> > >>>
> > >>> -     if (!sbi->am.atgc_enabled)
> > >>> -             return 0;
> > >>> -
> > >>>        f2fs_down_read(&SM_I(sbi)->curseg_lock);
> > >>>
> > >>>        mutex_lock(&curseg->curseg_mutex);
> > >>> @@ -2955,7 +2952,9 @@ static int __f2fs_init_atgc_curseg(struct f2f=
s_sb_info *sbi)
> > >>>    }
> > >>>    int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
> > >>>    {
> > >>> -     return __f2fs_init_atgc_curseg(sbi);
> > >>> +     if (!sbi->am.atgc_enabled)
> > >>> +             return 0;
> > >>> +     return f2fs_init_atgc_curseg(sbi);
> > >>>    }
> > >>>
> > >>>    static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, i=
nt type)
> > >>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > >>> index 09d3ecf..72676c5 100644
> > >>> --- a/fs/f2fs/sysfs.c
> > >>> +++ b/fs/f2fs/sysfs.c
> > >>> @@ -673,6 +673,22 @@ static ssize_t __sbi_store(struct f2fs_attr *a=
,
> > >>>                return count;
> > >>>        }
> > >>>
> > >>> +     if (!strcmp(a->attr.name, "atgc_age_threshold")) {
> > >>> +             if (t < 0)
> > >>> +                     return -EINVAL;
> > >>> +             sbi->am.age_threshold =3D t;
> > >>> +             if (sbi->am.atgc_enabled)
> > >>> +                     return count;
> > >>> +
> > >>> +             if (test_opt(sbi, ATGC) &&
> > >>> +                     le64_to_cpu(sbi->ckpt->elapsed_time) >=3D t) =
{
> > >>
> > > Hi Chao,
> > >> Oh, I guess you want to fix this:
> > > Yes,  Sorry for not making it clear before.
> > >>
> > >> static void init_atgc_management(struct f2fs_sb_info *sbi)
> > >> {
> > >> ...
> > >>          if (test_opt(sbi, ATGC) &&
> > >>                  SIT_I(sbi)->elapsed_time >=3D DEF_GC_THREAD_AGE_THR=
ESHOLD)
> > >>                  am->atgc_enabled =3D true;
> > >>
> > >> What about enabling atgc_enabled during checkpoint once elapsed time=
 is
> > >> satisfed w/ the condition? I guess this can give another chance when=
ever
> > >> CP is been triggered, and it can avoid the racing condition as well.
> > > 1. I'm not sure if this will increase checkpoint time consumption?
> >
> > Since it won't increase any IO time, I guess it's fine tolerate time co=
nsumed
> > by initialization of atgc curseg.
> >
> > > 2. dynamically enabling atgc may have other problems. Is this confirm=
ed?
> >
> > I think so, checkpoint has avoided most race cases.
> >
> > So, how do you think of below diff:
> Hi Chao,
>  I think flow is ok,  some details need to be discussed.
> >
> > ---
> >   fs/f2fs/checkpoint.c |  2 ++
> >   fs/f2fs/f2fs.h       |  1 +
> >   fs/f2fs/segment.c    | 26 +++++++++++++++++++++++---
> >   3 files changed, 26 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 55d444bec5c0..4a73bd481a25 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -1718,6 +1718,8 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sb=
i, struct cp_control *cpc)
> >         }
> >
> >         f2fs_restore_inmem_curseg(sbi);
> > +       f2fs_reinit_atgc_curseg(sbi);
> > +
> >         stat_inc_cp_count(sbi);
> >   stop:
> >         unblock_operations(sbi);
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 9688df332147..8d385a1c75ad 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -3693,6 +3693,7 @@ void f2fs_release_discard_addrs(struct f2fs_sb_in=
fo *sbi);
> >   int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_=
ra);
> >   bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
> >   int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
> > +int f2fs_reinit_atgc_curseg(struct f2fs_sb_info *sbi);
> >   void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
> >   void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
> >   int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int ty=
pe,
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index bdc2247387e8..6d4273faf061 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -2949,12 +2949,12 @@ static int get_atssr_segment(struct f2fs_sb_inf=
o *sbi, int type,
> >         return ret;
> >   }
> >
> > -static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
> > +static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi, bool forc=
e)
> >   {
> >         struct curseg_info *curseg =3D CURSEG_I(sbi, CURSEG_ALL_DATA_AT=
GC);
> >         int ret =3D 0;
> >
> > -       if (!sbi->am.atgc_enabled)
> > +       if (!sbi->am.atgc_enabled && !force)
> Is this parameter  "force" unnecessary?
> in mount flow, even atgc enable conditions are all met, it is not
> enabled because of force=3Dfalse.
> Or am I missing something?
hi Chao,
sorry, I read && as || ,  Please ignore the above comment,
but Is it still OK without the  "force"  parameter?
thanks=EF=BC=81
> >                 return 0;
> >
> >         f2fs_down_read(&SM_I(sbi)->curseg_lock);
> > @@ -2971,9 +2971,29 @@ static int __f2fs_init_atgc_curseg(struct f2fs_s=
b_info *sbi)
> >         f2fs_up_read(&SM_I(sbi)->curseg_lock);
> >         return ret;
> >   }
> > +
> >   int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
> >   {
> > -       return __f2fs_init_atgc_curseg(sbi);
> > +       return __f2fs_init_atgc_curseg(sbi, false);
> > +}
> > +
> > +int f2fs_reinit_atgc_curseg(struct f2fs_sb_info *sbi)
> > +{
> > +       int ret;
> > +
> > +       if (!test_opt(sbi, ATGC))
> > +               return 0;
> > +       if (sbi->am.atgc_enabled)
> > +               return 0;
> > +       if (SIT_I(sbi)->elapsed_time < sbi->am.age_threshold)
> SIT(sbi)->elapsed_time is just updated in mount flow, so
> ckpt->elapsed_time is  more suitable here?
> thanks!
> > +               return 0;
> > +
> > +       ret =3D __f2fs_init_atgc_curseg(sbi, true);
> > +       if (!ret) {
> > +               sbi->am.atgc_enabled =3D true;
> > +               f2fs_info(sbi, "reenabled age threshold GC");
> > +       }
> > +       return ret;
> >   }
> >
> >   static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int ty=
pe)
> > --
> > 2.40.1
> >
> > > thanks=EF=BC=81
> > >>
> > >> Thanks,
> > >>
> > >>> +                     if (f2fs_init_atgc_curseg(sbi))
> > >>> +                             return -EINVAL;
> > >>> +                     sbi->am.atgc_enabled =3D true;
> > >>> +             }
> > >>> +             return count;
> > >>> +     }
> > >>> +
> > >>>        if (!strcmp(a->attr.name, "gc_segment_mode")) {
> > >>>                if (t < MAX_GC_MODE)
> > >>>                        sbi->gc_segment_mode =3D t;

