Return-Path: <linux-kernel+bounces-195214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CCC8D48E7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B683C1C21B96
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629D515444F;
	Thu, 30 May 2024 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRnA1RZ+"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED78118396D
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717062585; cv=none; b=gP5isqUXvFdYfegKNdbdAWmN/eVCg1/Q1JhXZydyRlShTkxZvYyACIzTDtC7R4UnmOlqzhyheMgitcsOSx4NLIS/nMyhGPjpDZ4rjQf8o0z+fyYTYQEJKZ8HU7N9mPY2hgaNjfH12q00NaaQcoRGDYdt7FN7E74VD7GbZyDz65A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717062585; c=relaxed/simple;
	bh=fQ+3phoyGWnxDQWBqX2maaRMs6DQ1OVnd2iqqX09eDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogsc1qPM02571hTa8D6HuFn3ga0JwS+8xCgcGS8GTy6BkeCa3vu45IILv0J9Se2veArdbYeIQ8ixjyk6UUFbOaG9JoDW8LyV6DCSzHBqgpaFuBdbX4V1NdnB5Kqw/OZ/jC3+DISkpmq86KGZlXZmMS3qHvlqBtUXqdkl0f68Vbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRnA1RZ+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35dc984b3d2so296104f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 02:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717062582; x=1717667382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ou7/re3lRwcgcNyKTGkXvwqkQT9+iebWGeN2EOTv3AM=;
        b=mRnA1RZ+c11sYwFSjqBimqQB23CG1fIgHRhBEvmTqxKi8sQ9PGwTrobvN+gINl2rDS
         dwO2JV1qN2h5Q6U+CUPxA6vFsz75phLMZqYi9PTHGeKTcZoHfuXcOz6EI+mGIP5HWIFl
         ungsNwX4rcz35sjWI6d4ZTZyOLCnDD59pzIqd8X/zSd6/G/OAjOO16EBpXWGmooEszVR
         qWBWw5xNJJe4x0qJ9SDWB5SV8FOG9HvHcYjp7ThFu6mfPEyU9Xq/sKZb/kSX100StN5l
         5z0MB8PXJOKeoguPQY+NJRw8YO0ueH39IuWBFBepW2ZAn1fh1/9GW/3SyR1eYBwNcDAm
         Yh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717062582; x=1717667382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ou7/re3lRwcgcNyKTGkXvwqkQT9+iebWGeN2EOTv3AM=;
        b=PjjlwDkjh6EGNX1X9TSkjXoZG+drA+AaAyujuRghK78xgdN0oAPriPds0H8wLp2VmB
         ns9bTwg10dPUcS5L0ZvQCbORBYoz7TwZHhsVajlzPzxDPjTst+8RbWZvgXfmg7uKJ6Be
         L8Xcz7IsYaj03sM9daMhnwwkZxsfUVR0yoOoOT6AtAw4QlcEiHpdKSIMXTeHTzlWKByM
         1My/JU8RjCa0xyYA4A1zmcW6AiVIRB2+GRiNYI+5WFBWWqyUxzxsqEgFL5/mcm86wfqU
         v12yuN2AYoB9uSRZGbW+hNAmTmUQbmwWLa6OunOes4c/d3ewODyKUtSsHUJlrEXiz1gE
         p7uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE2yaKd5M2ZOhVU7IFB7F+DgNwOx/mkayYvKNbhRkmkh/bLCMX7RzrDjgw7vZT/Us/CCFj/WR8IIicT0C0Gl8jQeSyR/aE/n+KwmOo
X-Gm-Message-State: AOJu0Yz0HTqdfceJ4Wik/0i200EXg7JmFua7CTvOmFhwN5waYu17K971
	kzFRpMAdB9R0Y1nQMwvTbYBUTIuEu0XlSjA2NlVOs+81cT4TGDvEy6KSS00fru5Bnh83qmfxMkj
	LSFWN/YdCg1GpXf1xgqqjCmWzJii5qFTaycs=
X-Google-Smtp-Source: AGHT+IEjQDQ6uEg4JbtAD/ivMW1amNAemiInuIQiVjoRJK+OE1744Qu9ueJxqowtj9ltrNYo8iCENN3zD8l/lz9+hsY=
X-Received: by 2002:a05:6000:1188:b0:354:fa5b:62ab with SMTP id
 ffacd0b85a97d-35dc00924e7mr1913281f8f.18.1717062581967; Thu, 30 May 2024
 02:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716204978-29455-1-git-send-email-zhiguo.niu@unisoc.com>
 <1d67715b-5f88-4940-969d-e098fd80ae2a@kernel.org> <CAHJ8P3LXYWQ+bLZHPn_5FLu3oi83ei8C9ZCzAXwa9oBdEKVDNA@mail.gmail.com>
In-Reply-To: <CAHJ8P3LXYWQ+bLZHPn_5FLu3oi83ei8C9ZCzAXwa9oBdEKVDNA@mail.gmail.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 30 May 2024 17:49:30 +0800
Message-ID: <CAHJ8P3+ro9YsU7jZWeAfiUh9uNFEj_=Wiaf2YRLVLBD5_9fM0g@mail.gmail.com>
Subject: Re: [PATCH] f2fs: enable atgc if atgc_age_threshold from user is less
 than elapsed_time
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 12:07=E2=80=AFPM Zhiguo Niu <niuzhiguo84@gmail.com>=
 wrote:
>
> On Mon, May 27, 2024 at 11:49=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
> >
> > On 2024/5/20 19:36, Zhiguo Niu wrote:
> > > Now atgc can be enabled based on the following conditions:
> > > -ATGC mount option is set
> > > -elapsed_time is more than atgc_age_threshold already
> > > but these conditions are check when umounted->mounted device again.
> > > If the device has not be umounted->mounted for a long time, atgc can
> > > not work even the above conditions met.
> >
> > Zhiguo, I didn't get it, can you please explain more about this issue?
> >
> > Thanks,
> Hi Chao,
>
> At present, the point of atgc enale is checked during the mount
> process. What I mean is that if a device has not been rebooted
> (re-mounted) for a long time, even if the above two conditions are
> met(ATGC mount option is set, and the device has been powered on long
> enough=EF=BC=8C more than atgc default threshold ), atgc cannot be dynami=
cally
> enabled.
>
> If the user is used to not restarting the phone after turning it on,
> it will be difficult to use atgc.
> thanks!
Hi Chao,
Do you have any suggestions or comments on this?
thanks=EF=BC=81

> >
> > >
> > > It is better to enable atgc dynamiclly when user change atgc_age_thre=
shold
> > > meanwhile this vale is less than elapsed_time and ATGC mount option i=
s on.
> > >
> > > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > > ---
> > >   fs/f2fs/f2fs.h    |  1 +
> > >   fs/f2fs/segment.c |  9 ++++-----
> > >   fs/f2fs/sysfs.c   | 16 ++++++++++++++++
> > >   3 files changed, 21 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index 1974b6a..e441d2d 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -3694,6 +3694,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb=
_info *sbi,
> > >   int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
> > >   void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
> > >   void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
> > > +int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi);
> > >   int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int =
type,
> > >                                       unsigned int start, unsigned in=
t end);
> > >   int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, b=
ool force);
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > index 71dc8042..44923d4 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -2931,14 +2931,11 @@ static int get_atssr_segment(struct f2fs_sb_i=
nfo *sbi, int type,
> > >       return ret;
> > >   }
> > >
> > > -static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
> > > +int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
> > >   {
> > >       struct curseg_info *curseg =3D CURSEG_I(sbi, CURSEG_ALL_DATA_AT=
GC);
> > >       int ret =3D 0;
> > >
> > > -     if (!sbi->am.atgc_enabled)
> > > -             return 0;
> > > -
> > >       f2fs_down_read(&SM_I(sbi)->curseg_lock);
> > >
> > >       mutex_lock(&curseg->curseg_mutex);
> > > @@ -2955,7 +2952,9 @@ static int __f2fs_init_atgc_curseg(struct f2fs_=
sb_info *sbi)
> > >   }
> > >   int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
> > >   {
> > > -     return __f2fs_init_atgc_curseg(sbi);
> > > +     if (!sbi->am.atgc_enabled)
> > > +             return 0;
> > > +     return f2fs_init_atgc_curseg(sbi);
> > >   }
> > >
> > >   static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int =
type)
> > > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > > index 09d3ecf..72676c5 100644
> > > --- a/fs/f2fs/sysfs.c
> > > +++ b/fs/f2fs/sysfs.c
> > > @@ -673,6 +673,22 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
> > >               return count;
> > >       }
> > >
> > > +     if (!strcmp(a->attr.name, "atgc_age_threshold")) {
> > > +             if (t < 0)
> > > +                     return -EINVAL;
> > > +             sbi->am.age_threshold =3D t;
> > > +             if (sbi->am.atgc_enabled)
> > > +                     return count;
> > > +
> > > +             if (test_opt(sbi, ATGC) &&
> > > +                     le64_to_cpu(sbi->ckpt->elapsed_time) >=3D t) {
> > > +                     if (f2fs_init_atgc_curseg(sbi))
> > > +                             return -EINVAL;
> > > +                     sbi->am.atgc_enabled =3D true;
> > > +             }
> > > +             return count;
> > > +     }
> > > +
> > >       if (!strcmp(a->attr.name, "gc_segment_mode")) {
> > >               if (t < MAX_GC_MODE)
> > >                       sbi->gc_segment_mode =3D t;

