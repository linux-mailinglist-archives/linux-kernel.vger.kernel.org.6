Return-Path: <linux-kernel+bounces-198832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 353B48D7E11
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A871F2107A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D93776F17;
	Mon,  3 Jun 2024 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kky3hHnt"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF233BBF3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405551; cv=none; b=n0uMc0Vsl561+b/uSnXYkzi7DjUdcAplL4jNc929HyMt+ZIAhq3uSvWrjRMaRosgjd7hv/+Nf+PTM85wrEjuuUs0WmdPk9W3TtCFrEZ9DKsZnmwv8LtXkpCj3qeugPVaPqVVEH0M5Y5Zz23s0JJ+D6173Z4Y5oS2GY5Uz+b9Ky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405551; c=relaxed/simple;
	bh=6WLa7LruKri98nPh55YBV/dK/7sYjTWL0W7ZcMRoybo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eldy8B2QAWC1jUk95LkA6hZbCNrPpfsRwY4v70czowEHX1h58WWAfjDz3+ohm+85t3bwVrRvBXSAAXnV3qKeu9iIefbX5Sz8CkJPP5xGQirDHVlrwrTBZyWVzNvyCC1qVwU6q182b0rKVeEWvgtq3DMZTX1uoyGgfJg6ku1WLnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kky3hHnt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-35e4aaa0f33so1560493f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 02:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717405548; x=1718010348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSQVPnz7myYAOgmYIoz+PW++0ntehkTkLHzuX99TEyc=;
        b=kky3hHntKi/fstQtWPFhESoFPYn335JCfQXHzFwn/Rm3V1j3plyGhC7NTMWl8btc9n
         ABFJIc4ygslpMVubhu2DC3JSEKB2v6bqfiFqvdSPk2ZeXArsUduNyTdHPXmB2K6Ig9A1
         XiXqM5QpWcBGVNEKPaJrI9OJgg3nVDQRELRRY2NqkOOjECkL8yrtJb7zMB82k3rlEBiL
         bK6JnmxCQQwW0jDDJewfnygKEYKuoSec53GK1NSjcqiVm08lT7Ed1IvyLX/AzMAC3Ip5
         UtOV5z12Noz99wuN9Atu/1aFoVMyrdV/jgLJcEbmaTheWB3CUlisrXwTqnfrRry1DPwJ
         On1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717405548; x=1718010348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSQVPnz7myYAOgmYIoz+PW++0ntehkTkLHzuX99TEyc=;
        b=BA/1H1wuBMN9kWuU/WCl8yY142/esxL88X16hCGaw45NeLUuwzosKk5Uby8vPP7DHb
         IXoJCqESfphLM6OyvLLH+0MIaVKmZub2gP8w/92lTLJ4hGBMCUpttC7DyvoBuHXb6sdC
         O37c1rLQ2wGwle/gdS/GuiErNrdXN2CduDMBMV70duMVcz1+jPQJlaWils2sHcqKZHMu
         A/IPOKcH1EciK2FZSL+g4cwkjL87mlVeM+hvUHlKsnToflQ1P9ia+EjmWKJYSBGWomVf
         SUu4M6u8phPlC1HSf1/xG+PMsnsOMJGF7lrHhPs/f0+BlgWcymfuuXzm4n211ZUXeoTP
         qu/A==
X-Forwarded-Encrypted: i=1; AJvYcCUnIvwOIthP858YDeGQjpFqxYA7PPHiWpaALlSGTsuCZERx7ftZexxW7JBeRrMK19fdYfzu7Tu/BC4+UZX+R7Kkx+M2SrkGgKA4A+bJ
X-Gm-Message-State: AOJu0YyX9AYhQmTl1oiLn9Jm36fW5i9zcZ419CGaefP7beQVp+6ghXWV
	jrIm6EfpAhvTdJIqVhC/7xxyDSYbK+wrBhilBi4FF67TJ19kwDVrB8Ejk0/yR/bAjtcDV6SU+qk
	hDsCN0KE5sQl/e0W1EmcxXmI/ukyAtd5IdQY=
X-Google-Smtp-Source: AGHT+IF6++1LgATf/3YMjs1tFLt22xdXcldrBzpJboHBzvEckJfcXDY+IuIp7q2opq5t1jO5g0VwBtK1ZfFXWvAYsfY=
X-Received: by 2002:a5d:5350:0:b0:351:b56e:8bc3 with SMTP id
 ffacd0b85a97d-35e0f325baemr7011366f8f.53.1717405547911; Mon, 03 Jun 2024
 02:05:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716204978-29455-1-git-send-email-zhiguo.niu@unisoc.com> <446c7e4a-2a1e-402d-8238-2eee7cdfd5c2@kernel.org>
In-Reply-To: <446c7e4a-2a1e-402d-8238-2eee7cdfd5c2@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 3 Jun 2024 17:05:36 +0800
Message-ID: <CAHJ8P3J2NkSfVTEcpxR+n3CjtywMxxEDMg4cLSL=8UOX8KcM+Q@mail.gmail.com>
Subject: Re: [PATCH] f2fs: enable atgc if atgc_age_threshold from user is less
 than elapsed_time
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 3:41=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/5/20 19:36, Zhiguo Niu wrote:
> > Now atgc can be enabled based on the following conditions:
> > -ATGC mount option is set
> > -elapsed_time is more than atgc_age_threshold already
> > but these conditions are check when umounted->mounted device again.
> > If the device has not be umounted->mounted for a long time, atgc can
> > not work even the above conditions met.
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
>
Hi Chao,
> Oh, I guess you want to fix this:
Yes,  Sorry for not making it clear before.
>
> static void init_atgc_management(struct f2fs_sb_info *sbi)
> {
> ...
>         if (test_opt(sbi, ATGC) &&
>                 SIT_I(sbi)->elapsed_time >=3D DEF_GC_THREAD_AGE_THRESHOLD=
)
>                 am->atgc_enabled =3D true;
>
> What about enabling atgc_enabled during checkpoint once elapsed time is
> satisfed w/ the condition? I guess this can give another chance whenever
> CP is been triggered, and it can avoid the racing condition as well.
1. I'm not sure if this will increase checkpoint time consumption?
2. dynamically enabling atgc may have other problems. Is this confirmed?
thanks=EF=BC=81
>
> Thanks,
>
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

