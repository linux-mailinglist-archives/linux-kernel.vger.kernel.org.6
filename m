Return-Path: <linux-kernel+bounces-530564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2D0A4352A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA8B17AB4C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92642256C95;
	Tue, 25 Feb 2025 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPLpWHa+"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8F6256C9F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464610; cv=none; b=HMf0mUqPeDbCpKBNw5+h5HTCe8DyJGkV6xl18zVXnpN98VhjlLsx9FlK3iQw4XTO78tqW28SkS/RPt9n2kGivW/bFTkxWotgsGUvXKR3Jf4gMSHqI+TeX9KedSGQMPXBRORD1DGcgw2jJlAaiSLPn0WGniTBewojTyVHIgd/76I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464610; c=relaxed/simple;
	bh=7XrWL/mfJYaxpUkKboQd5WFxOxUGJ1yfAX6kGCsFGZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=besr4eWgLTxTPpp6dnHb8YBPBWuHuVQATSkxMkg8OGQj3nQEAg+gahrmkafGHxBS9PQjbm5rhJ07lQwuNYhwa2BClWo/CJF5Im9zlhDDX4/EqD4/hZ3wr892kNqdQgKK4u19VyCZyVlosv5AgcxBunW9rkSf222xldyhOAbW/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPLpWHa+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so11240741a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 22:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740464607; x=1741069407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5VaoRwGRt5rhI0585yryJiuNqsJailyleI/CBPAMbA=;
        b=TPLpWHa+KmHPk+dWT2gvTUEbB+Sxb6WaMjxfx7BJVPXUvzv05EELu0jxiiyNR4LmGg
         9keLC+VBgDnds7TKA5EOSuIb2IrbF5LxJuYSoLpzqldUl/q1TvWJgSLzTf8Tzh9yWew3
         ddqYOOAUspGI7PDA19tkEG8aLxA3+mwHXOcUzJdFcZkN+sSOv48XXR97nArY2+9yICLf
         QnHDhl78/tWjqLMnj1NwdeT4apYCBWxyZF6DyYkEPONHqAhSpmuwKEDPqe72Iy/VzjqB
         BVgf6lcRPu8GZTL8WfjhcYZJO6M7uu8Le20QZdoWEXmuf9G8ZC9wMP8g07ytO0CWyRnY
         hWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740464607; x=1741069407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5VaoRwGRt5rhI0585yryJiuNqsJailyleI/CBPAMbA=;
        b=M/sRSVKHS4+LeFIWrojqbC1mtAC4COA0Y5ZTW88lAnMP6nHy0nFjR1UIiVKJJ1A75g
         RKR/StNG490EeP8sE4nBI4i7DzXbxn2ZEhHLuWQipnCenM04+UeEbZckd7REJr4PBk3V
         yMN7ei8o2mIA3gwmjelEUBUySdMW5YlP21UzirVw2TvKTdZvf9XJBeRbSx/07l/4XPQZ
         pgz3fadh75bcQjIP4Va1S4e9xQc/AE0Ror7nxA8GRrrctyR79jAU0G0ZUaYSF8Cthffa
         KViYSpFWZYxAE2a0Di09dfnfSrFoa5kWL0XjBom7Dw5FFbl91LGjLQPOI/LhqQtnUeOA
         rzHg==
X-Forwarded-Encrypted: i=1; AJvYcCWnTUBzlRpFHDpWAUoNdxy6UeVTvf1pwYRG7wr/zNLFBb0ZRAlbMiFUJLjLUydiULiGT/+5ByBo3bcERQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygt1h7Cs8NK87XdlXVL4tfC0/IHXYEx/JszwQJY17/mbLY49xQ
	uetYnJaqAG0C/QSSvmiZyvJUcjCB0gp85frXKyHs4kgAtGUdPRooO8a9N9qOkEgVhGji8saUFtC
	GDoC6Yivqai0kWU3Yyn0U/zcowsY=
X-Gm-Gg: ASbGncs/rvOZu45rThfhLOzHMD9mk8ckPYrgmqJH1d2nhpxoNdqp4pFwkSuTNIPfEjK
	yyX5pqSOFWTfsdI99h9f1zla+0jhmR/7H1Qg11EEkgcDIek3GTennJPN9MxzvxaD0Xr1nXFAsJp
	IRt8UIu1QT
X-Google-Smtp-Source: AGHT+IFWxTHVb9OnRBgD45vXv1XLuJL2UZSsumqhHxpJWayZovCq+ciAkyfWhNTgWrNEHjJ3sZfIXnzbngrkIHck8DA=
X-Received: by 2002:a17:907:720a:b0:aba:6385:576e with SMTP id
 a640c23a62f3a-abc0ae1aed3mr1510502666b.3.1740464606329; Mon, 24 Feb 2025
 22:23:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220055950.4405-1-xuewen.yan@unisoc.com> <20250220055950.4405-2-xuewen.yan@unisoc.com>
 <20250224234511.godsizj7kuv7zrtl@airbuntu>
In-Reply-To: <20250224234511.godsizj7kuv7zrtl@airbuntu>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 25 Feb 2025 14:23:14 +0800
X-Gm-Features: AQ5f1Jp0Q0U23cCJV93wuWeIq3IOUlRyMAzD94B1K2bxjGrFcldVxFFIkj0qAVQ
Message-ID: <CAB8ipk_NOi0rZQR0X7zveyyL-E7mJVLX92sKVO0=C0TmkcvDOQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] sched/uclamp: Add uclamp_is_used() check before
 enable it
To: Qais Yousef <qyousef@layalina.io>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, christian.loehle@arm.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, hongyan.xia2@arm.com, 
	ke.wang@unisoc.com, di.shen@unisoc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:45=E2=80=AFAM Qais Yousef <qyousef@layalina.io> w=
rote:
>
> On 02/20/25 13:59, Xuewen Yan wrote:
> > Because the static_branch_enable() would get the cpus_read_lock(),
> > and sometimes users may frequently set the uclamp value of tasks,
> > and this operation would call the static_branch_enable()
> > frequently, so add the uclamp_is_used() check to prevent calling
> > the cpus_read_lock() frequently.
> > And to make the code more concise, add a helper function to encapsulate
> > this and use it everywhere we enable sched_uclamp_used.
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> > ---
>
> [...]
>
> > +/*
> > + * Enabling static branches would get the cpus_read_lock(),
> > + * check uclamp_is_used before enabling it. There is no race
> > + * issue because we never disable this static key once enabled.
> > + */
> > +static inline void sched_uclamp_enable(void)
> > +{
> > +     if (!uclamp_is_used())
> > +             static_branch_enable(&sched_uclamp_used);
> > +}
> > +
>
> As I indicated in [1] I think the pattern of repeatedly enable is actuall=
y sane
> and what we probably should be doing is modify the static_key_enable() lo=
gic to
> do the early bail out logic outside of the lock. I had this code this way=
 FWIW
> initially and Peter asked for it to be called unconditionally instead.
>
> I think repeated calls to static_key_enable/disable() should be made chea=
p and
> I don't see a side effect of _replicating_ the early bail out logic outsi=
de of
> the lock so that if we have already enabled/disabled we just return immed=
iately
> without any side effect (holding the lock in this case). I agree the hotp=
lug

Because of the jump_lable_lock(), early bailout could indeed be a good idea=
.

> lock is ugly and if we can avoid touching it when we don't really need to=
 that
> would be better.
>
> --->8---
>
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index d9c822bbffb8..17583c98c447 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -214,6 +214,13 @@ EXPORT_SYMBOL_GPL(static_key_enable_cpuslocked);
>
>  void static_key_enable(struct static_key *key)
>  {
> +       STATIC_KEY_CHECK_USE(key);
> +
> +       if (atomic_read(&key->enabled) > 0) {
> +               WARN_ON_ONCE(atomic_read(&key->enabled) !=3D 1);
> +               return;
> +       }
> +
>         cpus_read_lock();
>         static_key_enable_cpuslocked(key);
>         cpus_read_unlock();
> @@ -239,6 +246,13 @@ EXPORT_SYMBOL_GPL(static_key_disable_cpuslocked);
>
>  void static_key_disable(struct static_key *key)
>  {
> +       STATIC_KEY_CHECK_USE(key);
> +
> +       if (atomic_read(&key->enabled) > 0) {
> +               WARN_ON_ONCE(atomic_read(&key->enabled) !=3D 1);
> +               return;
> +       }

Maybe here should be just check whether =3D=3D 0, because when enabling
the static key, the enable may occur to be -1.

+       if (atomic_read(&key->enabled) =3D=3D 0)
+               return;

> +
>         cpus_read_lock();
>         static_key_disable_cpuslocked(key);
>         cpus_read_unlock();
>
> --->8---
>
> [1] https://lore.kernel.org/all/20250222233627.3yx55ks5lnq3elby@airbuntu/

BR

