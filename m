Return-Path: <linux-kernel+bounces-201851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9668FC43F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7EA1F21AB9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D442418C358;
	Wed,  5 Jun 2024 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrQYRAUs"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33FD19048C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571713; cv=none; b=D/tD3YddMZO2a1aqnSublOFGw02YDs80s1N+igQ55qmLH+3nhRGLc78pT1JBr7/cDn2dLNH7N20LXn+AitBmnk3Few25YdGdyWYKPZD0+aGy86YxOdi0i/w8gk1D/yWD6jfreubgi1B0edd6OGMiPRs1P2U844PmXtbzODm3l20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571713; c=relaxed/simple;
	bh=sa1m57lh1lJHvHiacREWUvdFajnjZbQ7aya2M8AcO9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMetYS77wbW2uFD6XCU6VErpBOcWm1hUSDloyGis+Y580GQIe1m29h6JjBP1fBWnS4hEABj/Ktar0WPl69q+t6GWvbxZkFpZMK7lvBk7HeDPq3wGa+YCyiVqJ5Xl7M4fvnathienRZME/fawF3qvAFwOw7JlLaVtpZifr+6u3ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrQYRAUs; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35dc1d8867eso5604134f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717571710; x=1718176510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J96CFqMHnnrbEyvOUEQjbx8HxqBEViaaD1bEUYtTtvw=;
        b=WrQYRAUsQn0MIae4GVO9D2j8dn6aDd8zKzw3IGypqfpkJrUpXm4AuuQwY10yDNB4FV
         m4FN1yQt2v65ah0zU0b++Yi1n9iIGmUjCsjyI70FDPw98Wny/rsRKhbb/WO7Z2o/0ELI
         z6T3G9yck8U02hDcjhVJh0s1+ZLcK465Gkvvtlqu7FJk09elTM9bazhtU3sxQomp4+DS
         FCa6DM7lD+/1cJvj5ZcVslfwrCPSo2DqD+7qlcVcBJy32VQsL9xfRnCrW1Zb/UKcwkNI
         xGCGnx7AevFmlA0ypt6GlV+3wX2BUxpT66PBamilE1Kv5ht41AVnX9F8cE39KUlTWgWv
         ggqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717571710; x=1718176510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J96CFqMHnnrbEyvOUEQjbx8HxqBEViaaD1bEUYtTtvw=;
        b=dxRnxbuu0V8NNTmmHRKQvjaerWMtuYJ4SNEd8iS4FtlXgJbvBsNlYtxDlhCY9mUgyD
         pEbX/aMdMeB7JmmI2vMIFvA/VsSU6raJRkjf3Ay1BTvmQwwEUh0+Ca0XHE3FmKFQ73aU
         0Q7ofoTQpG384qK4g1y9WOArLQ8fmZ8dNTAJW85bfB4wwlijAFK9ywIZllPhj9Cb8qNS
         c7Uzj8ZGuoV5Tv3np2ggX+90oIKlvGNCxFnevZ783D55X50jeeAl4igBUp6uZBwpsbI3
         lqB70qFfA9x8jac+vJDdGuwvpddfzbvA4pRMwuXQEBaSu+9bdfyNBgt15cS7EiSeFzK6
         6aJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhDqdIqA722ZsJq7FIXnEMWPD6uMr4+eUAJxWq+9YhCG2WVKRUbZxaJyl/PtyXCEtN9iumG1+DI556vt+jUtTW1YRtpZWMGRTZVMnh
X-Gm-Message-State: AOJu0YydejTVh/3V2WSCB1GM7gpEBWboWEf78l5itIn/6l7xXTkPhCnE
	H/LuUUKkWuftRij04JOJdu0dQrNgZLOVfT/jczSZzStZeiuXt+Yg3vUQ3oCNLkoW2rVdAkde6dG
	zaAJxO9s4+1sDqSWpgDUcyhsYo2UC21bt
X-Google-Smtp-Source: AGHT+IGWATenhfNDGMe5lR8Qo7v9m5GRG45d78yyblvl2VAcN/Ee+r8eXJRI3Nbw/VWQP+GfXC7nkjlugT6AdnGNZ6k=
X-Received: by 2002:a5d:4f83:0:b0:354:de3c:6ee9 with SMTP id
 ffacd0b85a97d-35e84058179mr1121251f8f.6.1717571709913; Wed, 05 Jun 2024
 00:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716204978-29455-1-git-send-email-zhiguo.niu@unisoc.com>
 <446c7e4a-2a1e-402d-8238-2eee7cdfd5c2@kernel.org> <CAHJ8P3J2NkSfVTEcpxR+n3CjtywMxxEDMg4cLSL=8UOX8KcM+Q@mail.gmail.com>
 <8b841ec1-cb43-462a-9e87-aecdb0755318@kernel.org> <CAHJ8P3K_u=ZmXaMF5jUu_MPSJPAhKmEx4hyaTinMQ=nnLQ9aRA@mail.gmail.com>
 <0c52e657-9872-4dfa-9c4d-83d74f0c9b07@kernel.org>
In-Reply-To: <0c52e657-9872-4dfa-9c4d-83d74f0c9b07@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 5 Jun 2024 15:14:58 +0800
Message-ID: <CAHJ8P3K-LOMDU0udwXj__qRpozNmv2tvvA4BRdktcOaK4OB7Bw@mail.gmail.com>
Subject: Re: [PATCH] f2fs: enable atgc if atgc_age_threshold from user is less
 than elapsed_time
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 2:26=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/6/5 13:59, Zhiguo Niu wrote:
> > On Wed, Jun 5, 2024 at 11:48=E2=80=AFAM Chao Yu <chao@kernel.org> wrote=
:
> >>
> >> On 2024/6/3 17:05, Zhiguo Niu wrote:
> >>> On Mon, Jun 3, 2024 at 3:41=E2=80=AFPM Chao Yu <chao@kernel.org> wrot=
e:
> >>>>
> >>>> On 2024/5/20 19:36, Zhiguo Niu wrote:
> >>>>> Now atgc can be enabled based on the following conditions:
> >>>>> -ATGC mount option is set
> >>>>> -elapsed_time is more than atgc_age_threshold already
> >>>>> but these conditions are check when umounted->mounted device again.
> >>>>> If the device has not be umounted->mounted for a long time, atgc ca=
n
> >>>>> not work even the above conditions met.
> >>>>>
> >>>>> It is better to enable atgc dynamiclly when user change atgc_age_th=
reshold
> >>>>> meanwhile this vale is less than elapsed_time and ATGC mount option=
 is on.
> >>>>>
> >>>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>>>> ---
> >>>>>     fs/f2fs/f2fs.h    |  1 +
> >>>>>     fs/f2fs/segment.c |  9 ++++-----
> >>>>>     fs/f2fs/sysfs.c   | 16 ++++++++++++++++
> >>>>>     3 files changed, 21 insertions(+), 5 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>>>> index 1974b6a..e441d2d 100644
> >>>>> --- a/fs/f2fs/f2fs.h
> >>>>> +++ b/fs/f2fs/f2fs.h
> >>>>> @@ -3694,6 +3694,7 @@ void f2fs_clear_prefree_segments(struct f2fs_=
sb_info *sbi,
> >>>>>     int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
> >>>>>     void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
> >>>>>     void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
> >>>>> +int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi);
> >>>>>     int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, =
int type,
> >>>>>                                         unsigned int start, unsigne=
d int end);
> >>>>>     int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int typ=
e, bool force);
> >>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>>>> index 71dc8042..44923d4 100644
> >>>>> --- a/fs/f2fs/segment.c
> >>>>> +++ b/fs/f2fs/segment.c
> >>>>> @@ -2931,14 +2931,11 @@ static int get_atssr_segment(struct f2fs_sb=
_info *sbi, int type,
> >>>>>         return ret;
> >>>>>     }
> >>>>>
> >>>>> -static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
> >>>>> +int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
> >>>>>     {
> >>>>>         struct curseg_info *curseg =3D CURSEG_I(sbi, CURSEG_ALL_DAT=
A_ATGC);
> >>>>>         int ret =3D 0;
> >>>>>
> >>>>> -     if (!sbi->am.atgc_enabled)
> >>>>> -             return 0;
> >>>>> -
> >>>>>         f2fs_down_read(&SM_I(sbi)->curseg_lock);
> >>>>>
> >>>>>         mutex_lock(&curseg->curseg_mutex);
> >>>>> @@ -2955,7 +2952,9 @@ static int __f2fs_init_atgc_curseg(struct f2f=
s_sb_info *sbi)
> >>>>>     }
> >>>>>     int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
> >>>>>     {
> >>>>> -     return __f2fs_init_atgc_curseg(sbi);
> >>>>> +     if (!sbi->am.atgc_enabled)
> >>>>> +             return 0;
> >>>>> +     return f2fs_init_atgc_curseg(sbi);
> >>>>>     }
> >>>>>
> >>>>>     static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, =
int type)
> >>>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> >>>>> index 09d3ecf..72676c5 100644
> >>>>> --- a/fs/f2fs/sysfs.c
> >>>>> +++ b/fs/f2fs/sysfs.c
> >>>>> @@ -673,6 +673,22 @@ static ssize_t __sbi_store(struct f2fs_attr *a=
,
> >>>>>                 return count;
> >>>>>         }
> >>>>>
> >>>>> +     if (!strcmp(a->attr.name, "atgc_age_threshold")) {
> >>>>> +             if (t < 0)
> >>>>> +                     return -EINVAL;
> >>>>> +             sbi->am.age_threshold =3D t;
> >>>>> +             if (sbi->am.atgc_enabled)
> >>>>> +                     return count;
> >>>>> +
> >>>>> +             if (test_opt(sbi, ATGC) &&
> >>>>> +                     le64_to_cpu(sbi->ckpt->elapsed_time) >=3D t) =
{
> >>>>
> >>> Hi Chao,
> >>>> Oh, I guess you want to fix this:
> >>> Yes,  Sorry for not making it clear before.
> >>>>
> >>>> static void init_atgc_management(struct f2fs_sb_info *sbi)
> >>>> {
> >>>> ...
> >>>>           if (test_opt(sbi, ATGC) &&
> >>>>                   SIT_I(sbi)->elapsed_time >=3D DEF_GC_THREAD_AGE_TH=
RESHOLD)
> >>>>                   am->atgc_enabled =3D true;
> >>>>
> >>>> What about enabling atgc_enabled during checkpoint once elapsed time=
 is
> >>>> satisfed w/ the condition? I guess this can give another chance when=
ever
> >>>> CP is been triggered, and it can avoid the racing condition as well.
> >>> 1. I'm not sure if this will increase checkpoint time consumption?
> >>
> >> Since it won't increase any IO time, I guess it's fine tolerate time c=
onsumed
> >> by initialization of atgc curseg.
> >>
> >>> 2. dynamically enabling atgc may have other problems. Is this confirm=
ed?
> >>
> >> I think so, checkpoint has avoided most race cases.
> >>
> >> So, how do you think of below diff:
> > Hi Chao,
> >   I think flow is ok,  some details need to be discussed.
> >>
> >> ---
> >>    fs/f2fs/checkpoint.c |  2 ++
> >>    fs/f2fs/f2fs.h       |  1 +
> >>    fs/f2fs/segment.c    | 26 +++++++++++++++++++++++---
> >>    3 files changed, 26 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> >> index 55d444bec5c0..4a73bd481a25 100644
> >> --- a/fs/f2fs/checkpoint.c
> >> +++ b/fs/f2fs/checkpoint.c
> >> @@ -1718,6 +1718,8 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *s=
bi, struct cp_control *cpc)
> >>          }
> >>
> >>          f2fs_restore_inmem_curseg(sbi);
> >> +       f2fs_reinit_atgc_curseg(sbi);
> >> +
> >>          stat_inc_cp_count(sbi);
> >>    stop:
> >>          unblock_operations(sbi);
> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> index 9688df332147..8d385a1c75ad 100644
> >> --- a/fs/f2fs/f2fs.h
> >> +++ b/fs/f2fs/f2fs.h
> >> @@ -3693,6 +3693,7 @@ void f2fs_release_discard_addrs(struct f2fs_sb_i=
nfo *sbi);
> >>    int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool fo=
r_ra);
> >>    bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno=
);
> >>    int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
> >> +int f2fs_reinit_atgc_curseg(struct f2fs_sb_info *sbi);
> >>    void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
> >>    void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
> >>    int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int =
type,
> >> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >> index bdc2247387e8..6d4273faf061 100644
> >> --- a/fs/f2fs/segment.c
> >> +++ b/fs/f2fs/segment.c
> >> @@ -2949,12 +2949,12 @@ static int get_atssr_segment(struct f2fs_sb_in=
fo *sbi, int type,
> >>          return ret;
> >>    }
> >>
> >> -static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
> >> +static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi, bool for=
ce)
> >>    {
> >>          struct curseg_info *curseg =3D CURSEG_I(sbi, CURSEG_ALL_DATA_=
ATGC);
> >>          int ret =3D 0;
> >>
> >> -       if (!sbi->am.atgc_enabled)
> >> +       if (!sbi->am.atgc_enabled && !force)
> > Is this parameter  "force" unnecessary?
> > in mount flow, even atgc enable conditions are all met, it is not
> > enabled because of force=3Dfalse.
> > Or am I missing something?
> >>                  return 0;
> >>
> >>          f2fs_down_read(&SM_I(sbi)->curseg_lock);
> >> @@ -2971,9 +2971,29 @@ static int __f2fs_init_atgc_curseg(struct f2fs_=
sb_info *sbi)
> >>          f2fs_up_read(&SM_I(sbi)->curseg_lock);
> >>          return ret;
> >>    }
> >> +
> >>    int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
> >>    {
> >> -       return __f2fs_init_atgc_curseg(sbi);
> >> +       return __f2fs_init_atgc_curseg(sbi, false);
> >> +}
> >> +
> >> +int f2fs_reinit_atgc_curseg(struct f2fs_sb_info *sbi)
> >> +{
> >> +       int ret;
> >> +
> >> +       if (!test_opt(sbi, ATGC))
> >> +               return 0;
> >> +       if (sbi->am.atgc_enabled)
> >> +               return 0;
> >> +       if (SIT_I(sbi)->elapsed_time < sbi->am.age_threshold)
> > SIT(sbi)->elapsed_time is just updated in mount flow, so
> > ckpt->elapsed_time is  more suitable here?
>
> Agreed, it needs to be fixed.
>
> Can you please update those changes into v2?
Hi Chao,
OK, and I will also verify the basic function.
thanks=EF=BC=81
>
> Thanks,
>
> > thanks!
> >> +               return 0;
> >> +
> >> +       ret =3D __f2fs_init_atgc_curseg(sbi, true);
> >> +       if (!ret) {
> >> +               sbi->am.atgc_enabled =3D true;
> >> +               f2fs_info(sbi, "reenabled age threshold GC");
> >> +       }
> >> +       return ret;
> >>    }
> >>
> >>    static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int =
type)
> >> --
> >> 2.40.1
> >>
> >>> thanks=EF=BC=81
> >>>>
> >>>> Thanks,
> >>>>
> >>>>> +                     if (f2fs_init_atgc_curseg(sbi))
> >>>>> +                             return -EINVAL;
> >>>>> +                     sbi->am.atgc_enabled =3D true;
> >>>>> +             }
> >>>>> +             return count;
> >>>>> +     }
> >>>>> +
> >>>>>         if (!strcmp(a->attr.name, "gc_segment_mode")) {
> >>>>>                 if (t < MAX_GC_MODE)
> >>>>>                         sbi->gc_segment_mode =3D t;

