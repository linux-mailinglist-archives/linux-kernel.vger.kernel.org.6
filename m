Return-Path: <linux-kernel+bounces-189999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B990F8CF840
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62631C20E52
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017B179E1;
	Mon, 27 May 2024 04:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYRAlzYc"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F3E323D
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716782844; cv=none; b=n441mzUjNHERm7Cu7+b7cq8y9PTMKYlQaJm0MzMvJovKoYJU/AxsWun/R/dtS+AvB36xsgnVkXJ5oeI5UymrG0C950Tf07Imb35b3N92ZGWUQqovxlxxOgOLm/g52L89eHyxMywekwS3m0w7kbrkIp7JJKk1Ch4iBVtQYZht7os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716782844; c=relaxed/simple;
	bh=71oaZq4xR9DQ028U8pjpCHAuPZbnjTR5ff8W4JCHNiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3AfJvE3y3DAakK95324AxMgaG316DWhLPu5VKB7xDiPS7+3VcKPuP1aRcMlfuIgxvvf0n+u+PqWXgx/vn0Qnan6Uyeo6TQyf8aTd2Pd/TM3gXP3K+MEljPVLNox7Cv3NwOnLKaAv8pZI68L9xBOD/QDS/4/VjfbGhrF6M+r8LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYRAlzYc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-420180b58c3so81424045e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 21:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716782841; x=1717387641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3d4wcnpC+sJlEKgi++LLlXHUe/6Lf69h5GwFk08nXEw=;
        b=DYRAlzYcW110aH6q/86lLQz1qg4W+xzkOnsyZ3oDkB8FahHCh/yKJi+SD105sDeTn6
         xBYElzBYfFEKVcoW0KQDI+SpPJul6rT0k5bmzEzfi6Y2BgCt+AfvkwlQCRP/4sFAzbQa
         zaChGBkPQyVrgw82IdJUZn3oy8mBc3Ah2Pl5JxiMF5zSscSbIovjUgeOLxdB/upyIphm
         XY0fsM0eIZZ3OM8LbvvsgqyhJCkiPE7m9G1IHO19a5+D82qYlAp3tz1cYk1eAdeDRlLu
         62II7xy2zt/h1mDoC9y9evz8/WpDirCFFEt6xlxwSWeXUTsr3vu6rty5HjsrtTKAcy/h
         TecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716782841; x=1717387641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3d4wcnpC+sJlEKgi++LLlXHUe/6Lf69h5GwFk08nXEw=;
        b=LdwLRqsEXHXbbfn0ebo/UrVX07MuOswKkbD6h6KhAyVTj90MT4C35c2g1/l5UMOxVH
         DGDbGGzF9YES5viLbUD1EeTqxxJP2WU86FYIR7AY59wH2LQ4Q95yu3d3fZFBmfuFW63P
         1AQKK8Jli1MEu3efcufiQTMcAvwoTcPRDtaCS+q5L/WwR+qoUDN/QQttkdyjRE3WWPvd
         6nLBYloRIhfqVHquHbbsHxWqu1oBI2OVaQzR/SGYsQNj5trZY1aAm8Cz6b3RC2HHqyH5
         ddVz5xz6wBwCrYw1qOSLNnSyfFiiVFRanc1sSJBxfUVdU6HFs+nfnvXUG3NWtHjPC698
         QecA==
X-Forwarded-Encrypted: i=1; AJvYcCXFSRlIu2GCUMb9eO5WEMyRbf4MfoiZpIhmgV3QlK0BsfgntQrCeyFNLJL8BrnMl2jNE6z1pDT3u4n4PvTMB+p1fLGxcOp+Aml3/Iru
X-Gm-Message-State: AOJu0YwYygNZk3DYg8LVmwsN0HPkPOY1LMvC0fdDBcguopZL/knDlBTG
	jhOLNPwOCeuQ60nK4aUCDrWYZIJkzTrtE3DYfKI3c14AKplZvgsO1aST+rGpF3QColmtXgy4Di+
	JjObWJTt1kJ+md7qLezw2O9sWf/o3Wgf9OXk=
X-Google-Smtp-Source: AGHT+IG8kfC9vaSJM7DNnJOgGB0H0o6noT3lMj5oUdJAizBMG6v797upDh+ThyOKhMLrJe5nEVMlcjb9bYgMNvO38j0=
X-Received: by 2002:a05:600c:22d4:b0:41b:82ba:7997 with SMTP id
 5b1f17b1804b1-42108a4f8cfmr64099065e9.3.1716782840435; Sun, 26 May 2024
 21:07:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716204978-29455-1-git-send-email-zhiguo.niu@unisoc.com> <1d67715b-5f88-4940-969d-e098fd80ae2a@kernel.org>
In-Reply-To: <1d67715b-5f88-4940-969d-e098fd80ae2a@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 27 May 2024 12:07:09 +0800
Message-ID: <CAHJ8P3LXYWQ+bLZHPn_5FLu3oi83ei8C9ZCzAXwa9oBdEKVDNA@mail.gmail.com>
Subject: Re: [PATCH] f2fs: enable atgc if atgc_age_threshold from user is less
 than elapsed_time
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 11:49=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/5/20 19:36, Zhiguo Niu wrote:
> > Now atgc can be enabled based on the following conditions:
> > -ATGC mount option is set
> > -elapsed_time is more than atgc_age_threshold already
> > but these conditions are check when umounted->mounted device again.
> > If the device has not be umounted->mounted for a long time, atgc can
> > not work even the above conditions met.
>
> Zhiguo, I didn't get it, can you please explain more about this issue?
>
> Thanks,
Hi Chao,

At present, the point of atgc enale is checked during the mount
process. What I mean is that if a device has not been rebooted
(re-mounted) for a long time, even if the above two conditions are
met(ATGC mount option is set, and the device has been powered on long
enough=EF=BC=8C more than atgc default threshold ), atgc cannot be dynamica=
lly
enabled.

If the user is used to not restarting the phone after turning it on,
it will be difficult to use atgc.
thanks!
>
> >
> > It is better to enable atgc dynamiclly when user change atgc_age_thresh=
old
> > meanwhile this vale is less than elapsed_time and ATGC mount option is =
on.
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> >   fs/f2fs/f2fs.h    |  1 +
> >   fs/f2fs/segment.c |  9 ++++-----
> >   fs/f2fs/sysfs.c   | 16 ++++++++++++++++
> >   3 files changed, 21 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 1974b6a..e441d2d 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -3694,6 +3694,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_i=
nfo *sbi,
> >   int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
> >   void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
> >   void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
> > +int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi);
> >   int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int ty=
pe,
> >                                       unsigned int start, unsigned int =
end);
> >   int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, boo=
l force);
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 71dc8042..44923d4 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -2931,14 +2931,11 @@ static int get_atssr_segment(struct f2fs_sb_inf=
o *sbi, int type,
> >       return ret;
> >   }
> >
> > -static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
> > +int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
> >   {
> >       struct curseg_info *curseg =3D CURSEG_I(sbi, CURSEG_ALL_DATA_ATGC=
);
> >       int ret =3D 0;
> >
> > -     if (!sbi->am.atgc_enabled)
> > -             return 0;
> > -
> >       f2fs_down_read(&SM_I(sbi)->curseg_lock);
> >
> >       mutex_lock(&curseg->curseg_mutex);
> > @@ -2955,7 +2952,9 @@ static int __f2fs_init_atgc_curseg(struct f2fs_sb=
_info *sbi)
> >   }
> >   int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
> >   {
> > -     return __f2fs_init_atgc_curseg(sbi);
> > +     if (!sbi->am.atgc_enabled)
> > +             return 0;
> > +     return f2fs_init_atgc_curseg(sbi);
> >   }
> >
> >   static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int ty=
pe)
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index 09d3ecf..72676c5 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -673,6 +673,22 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
> >               return count;
> >       }
> >
> > +     if (!strcmp(a->attr.name, "atgc_age_threshold")) {
> > +             if (t < 0)
> > +                     return -EINVAL;
> > +             sbi->am.age_threshold =3D t;
> > +             if (sbi->am.atgc_enabled)
> > +                     return count;
> > +
> > +             if (test_opt(sbi, ATGC) &&
> > +                     le64_to_cpu(sbi->ckpt->elapsed_time) >=3D t) {
> > +                     if (f2fs_init_atgc_curseg(sbi))
> > +                             return -EINVAL;
> > +                     sbi->am.atgc_enabled =3D true;
> > +             }
> > +             return count;
> > +     }
> > +
> >       if (!strcmp(a->attr.name, "gc_segment_mode")) {
> >               if (t < MAX_GC_MODE)
> >                       sbi->gc_segment_mode =3D t;

