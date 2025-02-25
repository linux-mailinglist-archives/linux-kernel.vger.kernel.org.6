Return-Path: <linux-kernel+bounces-531441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5C9A4408E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87D31889C90
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E82C2690D7;
	Tue, 25 Feb 2025 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="DA9NYiZF"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDAA2561A9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489473; cv=none; b=LMxXOL+v46Pt5076I2yIvHCW0MrGvqLoqWFzsZZ+KVNWKVaNsBzw56fQmR9YdR89LIWltMnT5ZvQ+ri0hZxCNlJQwQEjm32bDu67tukuDbFGN006k7xm+b/r30Z8xEg5gakgpY9xvEuuuiTnZzMyiNtxUYx96zGYjjRXCKX4EpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489473; c=relaxed/simple;
	bh=coiQ5jWlh487ykX7qP20FSX2c9/+vfsqreI546F9X4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsWsGjpiQs/MJRiIsk8BleUjCociZ5bWrFKnZees4NoncRKA6YN6U+XPdJBxQl+d8WAKRp8Aq1FeoXp2a+K9mwJcymzvWC6Bys8m+i6dQZILE6P6AJzoO2ZCypcRSSU7id9NzndL189sMyLRlq3e5ETAsJ1iOYuk0rV8AOBeySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=DA9NYiZF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4398e839cd4so38593405e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1740489469; x=1741094269; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZHiSBuspqa+Lo7NvOnsuxzepVxm+Oqk2YJCR3kKklRA=;
        b=DA9NYiZF699A75JqnUh8A0U4nXgBFbyfaREnAdMIbHmVwF/boFrphom8b/2TB26TMK
         c2rGZEOgDpdZ2IZTgiPmiN68K+z8vjBe6FPkALZza0J4pJwFuE9sWrAeqeYpAyzMjMUT
         HtKSOzbZUlRu7MSyK4VLxXIWrgHyWlnJadY7IkhZSdCZM+hBoEkKrl4F451X3vvw2Ii1
         fyQ5FUugRb9QYp7ayI6ycU7f1a+H/n+gySA6fDm7VsnlhH0hqqJls+ouaSy8cHH9OrFj
         e7DE3BMIPYew5DqLdC+1WcgxjnTdsMupGV5tSNFIc/bO08ZqeyoLjMsx830fA5wi+4Ar
         mUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489469; x=1741094269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHiSBuspqa+Lo7NvOnsuxzepVxm+Oqk2YJCR3kKklRA=;
        b=bVPksNeS7Te2t+RTC8Y+FiXJacZvKJ4uyW+sxDpSm2E+N9vQINg57L7WK1jUr22CXo
         7Y4dgSzv4ghz7aCZZNGVhM9wEOw0YLA/NLkKESjlUw4HQPQbn5hd61GuWbwAfwdSNTlS
         L9oHjq7XIEsVCynXqk3f2yV0PK8ol5Xyi+/lBTDitMDQixTCBfbJMW+Y7+vTpeBJ1kUu
         Ac5NelwjWsYT2EG202sDcvQKhRcI2Miec8Mg06kLwwTfeG020ywz6IL5PXwpnrQWeZTw
         6Q4/Z1Wpc/B+bofjBah4Yp4V5b9HopYRPo6uFm1496F8tnUoA+Dj6IrlYNH9pKJT+EhX
         xlrw==
X-Forwarded-Encrypted: i=1; AJvYcCV6awVTVqAXM3080HR6wUmiJdSnHaHO6vPMK8D5MdzR9aQLnIaFnB8+CaMPkZbAKkpw3G6/H8UVEcQNd4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTq1OdHCJrPJZBKVSKI4LAELwcCd4g5DJdLExa/cmU5KojXbgd
	vCz7kWLiic5KbCkK4xc9Kb+m9MoCRp0E17QxnohJ94jGWua8AllRYM2/svlWXuA=
X-Gm-Gg: ASbGncvIHHrp7c4r+LlyiKJLgKxRky1bbLcVh2cn3O4XPtOXEZIPKzjLGYxE5mQvOS6
	TQsTdRhuC9THMDQNvS0HFxLr3AUMkK/D6e+Ef2TsOSOtX8JVRWPRD/x18Sa1RUTfQXGjZEXVwVU
	I6OHyrwUpIbdAsrje9ZhAviFqlinOCfO+AVa9FmggI+aiVfl+zYOf0owVYYOSi3xb1Hfz8fiheK
	k0RPPGZESlHmE11v6A3uFYYGYn8Iahig52DCRzgN0KZMSoQI0JGr/JMtDxfJoGunqA2mQTmOfkW
	bdv30NJGeZmVYguZFGcq
X-Google-Smtp-Source: AGHT+IGkWRdahuDVdr65bSLK9QOPfwKfuKfP4bPrJ2wj5uN+i6AmgCZDHsE7NQNlDpcvnBZLlkfL+Q==
X-Received: by 2002:a5d:59ac:0:b0:38d:d8f7:8f75 with SMTP id ffacd0b85a97d-38f6160f9a0mr18157036f8f.17.1740489468688;
        Tue, 25 Feb 2025 05:17:48 -0800 (PST)
Received: from airbuntu ([46.186.201.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1546df4sm25505865e9.17.2025.02.25.05.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:17:48 -0800 (PST)
Date: Tue, 25 Feb 2025 13:17:43 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	christian.loehle@arm.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, hongyan.xia2@arm.com, ke.wang@unisoc.com,
	di.shen@unisoc.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] sched/uclamp: Add uclamp_is_used() check before
 enable it
Message-ID: <20250225131743.id4q2hotdfvzhkfh@airbuntu>
References: <20250220055950.4405-1-xuewen.yan@unisoc.com>
 <20250220055950.4405-2-xuewen.yan@unisoc.com>
 <20250224234511.godsizj7kuv7zrtl@airbuntu>
 <CAB8ipk_NOi0rZQR0X7zveyyL-E7mJVLX92sKVO0=C0TmkcvDOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk_NOi0rZQR0X7zveyyL-E7mJVLX92sKVO0=C0TmkcvDOQ@mail.gmail.com>

On 02/25/25 14:23, Xuewen Yan wrote:
> On Tue, Feb 25, 2025 at 7:45 AM Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 02/20/25 13:59, Xuewen Yan wrote:
> > > Because the static_branch_enable() would get the cpus_read_lock(),
> > > and sometimes users may frequently set the uclamp value of tasks,
> > > and this operation would call the static_branch_enable()
> > > frequently, so add the uclamp_is_used() check to prevent calling
> > > the cpus_read_lock() frequently.
> > > And to make the code more concise, add a helper function to encapsulate
> > > this and use it everywhere we enable sched_uclamp_used.
> > >
> > > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> > > ---
> >
> > [...]
> >
> > > +/*
> > > + * Enabling static branches would get the cpus_read_lock(),
> > > + * check uclamp_is_used before enabling it. There is no race
> > > + * issue because we never disable this static key once enabled.
> > > + */
> > > +static inline void sched_uclamp_enable(void)
> > > +{
> > > +     if (!uclamp_is_used())
> > > +             static_branch_enable(&sched_uclamp_used);
> > > +}
> > > +
> >
> > As I indicated in [1] I think the pattern of repeatedly enable is actually sane
> > and what we probably should be doing is modify the static_key_enable() logic to
> > do the early bail out logic outside of the lock. I had this code this way FWIW
> > initially and Peter asked for it to be called unconditionally instead.
> >
> > I think repeated calls to static_key_enable/disable() should be made cheap and
> > I don't see a side effect of _replicating_ the early bail out logic outside of
> > the lock so that if we have already enabled/disabled we just return immediately
> > without any side effect (holding the lock in this case). I agree the hotplug
> 
> Because of the jump_lable_lock(), early bailout could indeed be a good idea.

Yeah AFAICS the current code already handles the double enable, but it's
embedded within the cpus_read_lock(). I don't see why they must be inside.
Though I think we can't just move the code, we must replicate it outside the
lock in case the two enables race. I don't think the atomic_t will protect and
force one of them only to proceed. The lock will be stronger synchronization to
serialize, but one of them will end up doing the actual enable and the other
one will bail out after holding the lock. All future redundant enables will
bail out before holding the lock safely AFAICT.

> 
> > lock is ugly and if we can avoid touching it when we don't really need to that
> > would be better.
> >
> > --->8---
> >
> > diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> > index d9c822bbffb8..17583c98c447 100644
> > --- a/kernel/jump_label.c
> > +++ b/kernel/jump_label.c
> > @@ -214,6 +214,13 @@ EXPORT_SYMBOL_GPL(static_key_enable_cpuslocked);
> >
> >  void static_key_enable(struct static_key *key)
> >  {
> > +       STATIC_KEY_CHECK_USE(key);
> > +
> > +       if (atomic_read(&key->enabled) > 0) {
> > +               WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
> > +               return;
> > +       }
> > +
> >         cpus_read_lock();
> >         static_key_enable_cpuslocked(key);
> >         cpus_read_unlock();
> > @@ -239,6 +246,13 @@ EXPORT_SYMBOL_GPL(static_key_disable_cpuslocked);
> >
> >  void static_key_disable(struct static_key *key)
> >  {
> > +       STATIC_KEY_CHECK_USE(key);
> > +
> > +       if (atomic_read(&key->enabled) > 0) {
> > +               WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
> > +               return;
> > +       }
> 
> Maybe here should be just check whether == 0, because when enabling
> the static key, the enable may occur to be -1.

If it is -1 then the code is already being patched to enable the key and this
call to enable is redundant and can be ignored, no? ie: if we check for ==
0 then we'll hold the lock to bail out anyway.

There's no need for the warning though as this can trigger incorrectly, yes.

> 
> +       if (atomic_read(&key->enabled) == 0)
> +               return;
> 
> > +
> >         cpus_read_lock();
> >         static_key_disable_cpuslocked(key);
> >         cpus_read_unlock();
> >
> > --->8---
> >
> > [1] https://lore.kernel.org/all/20250222233627.3yx55ks5lnq3elby@airbuntu/
> 
> BR

