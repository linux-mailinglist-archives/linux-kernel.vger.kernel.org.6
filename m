Return-Path: <linux-kernel+bounces-530244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472F8A43100
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A5D7A5C01
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D4020764E;
	Mon, 24 Feb 2025 23:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Gz2VHX56"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9BA18E377
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 23:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440299; cv=none; b=cUtqbioefOqKvyDSNy2nM22wxkkTirWBFClY/6/e3y8HWl2MI5kXwqQMWi8I4fwNE+7p8v/8IpXZs4b8Ov8iWYlZDoI+uF3iJevoZAAgl+CQw/q3PH4Hfr/ozbenUbqMavbcTVOC77XkMvZqNPwYQfISJVGpYBP6/ZSORANHTXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440299; c=relaxed/simple;
	bh=COGtongC60D5ksGsk3HM5LdLcr94wSavtYKrc0iy6ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ql6iUVsWEhKXGs3utb7rVQ0WioH4snM15cfucEEoxrdwYH0h761txpqJ0qvANvv9/QAAF8Vr0T4gVFWs097R3VVm3qDTy1rgJ0XiGk/P4jllXF1nu7UA4YM0VZYNQlxRCFhSGkrzY5DQu0gp1nW0xTs0h88q3HETS9Mj7/qlSd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Gz2VHX56; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so8916306a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1740440294; x=1741045094; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wkt34unE7pOLVPJWOh4dB2cek6ffzA3+1Jm/WIgxTr8=;
        b=Gz2VHX56Hm4zcE3A/emkhplgXL73cLM/w5Vw6VbhAcHxVqFTy5aFgW02YgV/qY5B7e
         0YPYb1ovyl74YAB52kkSAS0j4GnNjrp8Fias91je0L5bGXIShDmRjs3m4dhV8lyYPpUD
         8s6HrQwpgcvux1uyz6b3ae1O+JF4Xaq75Tsj19KfYiSwbkOg6gYX8YprqP7BGOHg4kS5
         txJXw2d8DV7RfLEOx8IwEaFHM7PHtY9bmUTX38E467G2bQixqdF1DDJ4JOFdKRLq3ypG
         xrHJa2IihxRcEnZZUCRvu/GqGax22OlAJHDI5nwNfaYInbsIh6d4Pa//JZHeH+oLbpYQ
         4i+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740440294; x=1741045094;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wkt34unE7pOLVPJWOh4dB2cek6ffzA3+1Jm/WIgxTr8=;
        b=HvP4pwaQIZa36x0rlQREoW5t5ccU6O9Dopu4eMI1/asvEez+K28eFIyVrkARlLel7z
         fj5jccSv46juz7z9lwDVboqGbUWQrz9PCE1v3TWt+/lgH1S8+7848Z1ddPxya+uthbyZ
         S6EwnjKwNxlKxohBzPmeHN2Bn4ALQsX4vItvkJ1wBk/SjpanvtW+xtunRc2DkuHcw4XO
         Zf497ON6MhNH3tDVyaR9G5gIFHlKFZ0d1jlen2CMelOwtrQggEahgkawj0H+EQ6IJOI5
         vCNV9G3d6UaE2/qL9yXr52TzuQ40eihw9Hzouy2ee/E3ApkrGs1EUVTiFg9CRO8qyw48
         el6A==
X-Forwarded-Encrypted: i=1; AJvYcCVLCpqhC5pda2VUJu6i0flhW8NhucYd5lhURP+rB9d/feH5sJ5hRR2Jz6MbJFsclL26DazNTZfZPDOLe+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YznMR+QIUKaqxsT0kGfY3vCsXf22BJreuXHE845nxDCC2Ok3EI1
	ZEiiRDXXUsH5YiG8wG1KV2cPYKX1jo24meppO8djLpZ6fdk0/ntBNusBoX9R1yc=
X-Gm-Gg: ASbGncsrJ9GA9vub83Zv3/KFHmOeCLWLsEFhd0GSiM+RIB+qSwyOThxrmcvRRnXrHqU
	c6REO5JDPtq6ohEo75mGUXXIQbS1bdvtCMysINdBIOYiVE3pSl8J0SjCSp2C0UcujjkCq2ujqBW
	+Fg1VMdb8ZUXE50obk1EOOh9O5wqedTJpt4ZieX08GbBEVLyHeUgUxDvOjjsHJP6Eh9ElXuEmr3
	V14sv5ykRbhn6H8aOpBqK+CNCvUQA0io0DaqhCsA7UAgUp6sWpMO2sd5tDpbA7JGM8qkOBXu5Jw
	ATtOZkbeG7+LjzuQFxYR
X-Google-Smtp-Source: AGHT+IGT6t80p69VNhshuvixbcOyqcWp2eED0QpyGRPx6NauRFanoffxK7RlzoKK2feecO1Apc5gjg==
X-Received: by 2002:a17:907:988:b0:ab7:f2da:8126 with SMTP id a640c23a62f3a-abed0c77ec0mr119160866b.11.1740440293869;
        Mon, 24 Feb 2025 15:38:13 -0800 (PST)
Received: from airbuntu ([46.186.201.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20b72bbsm38318266b.182.2025.02.24.15.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 15:38:13 -0800 (PST)
Date: Mon, 24 Feb 2025 23:38:08 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, ke.wang@unisoc.com, di.shen@unisoc.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/uclamp: Add uclamp_is_used() check before
 enable it
Message-ID: <20250224233808.5jubn7icui5r2ufz@airbuntu>
References: <20250213091554.2593-1-xuewen.yan@unisoc.com>
 <20250213091554.2593-2-xuewen.yan@unisoc.com>
 <20250222233627.3yx55ks5lnq3elby@airbuntu>
 <CAB8ipk_qXYrMC54ddxA=wJ7YabxMwKmp1MzJRSq=NcfMJDOfjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk_qXYrMC54ddxA=wJ7YabxMwKmp1MzJRSq=NcfMJDOfjQ@mail.gmail.com>

On 02/24/25 09:55, Xuewen Yan wrote:
> Hi Qais,
> 
> On Sun, Feb 23, 2025 at 7:36 AM Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 02/13/25 17:15, Xuewen Yan wrote:
> > > Because the static_branch_enable() would get the cpus_read_lock(),
> > > and sometimes users may frequently set the uclamp value of tasks,
> > > and the uclamp_validate() would call the static_branch_enable()
> > > frequently, so add the uclamp_is_used() check to prevent calling
> > > the cpus_read_lock() frequently.
> >
> > FWIW original patch was doing such check but it was taken out after review
> > comments.
> >
> > Is something like below completely broken instead? I think uclamp usage isn't
> > unique but haven't really audited the code to see if there are similar users.
> >
> > I think it is a valid pattern to allow and the expectation was there shouldn't
> > be side effect of calling this repeatedly.
> >
> > Good catch by the way.
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
> > +
> >         cpus_read_lock();
> >         static_key_disable_cpuslocked(key);
> >         cpus_read_unlock();
> >
> > --->8---
> 
> I don't think we should do it this way.
> Uclamp can do this because it has never been disabled after being enabled.
> However, for others, they might frequently enable and disable it.
> If we don't add a lock here, there could be concurrency issues due to
> potential race conditions.

I can't see why this is special to uclamp because it is not disabled. The
problem is that we enable unconditionally because the logic in the jump_label
should know that this call is redundant. And that was the feedback from Peter
then as I had it exactly as you're trying to do now initially. It just it seems
we do the bail out check after holding the lock, we can replicate this
condition before holding the lock so if there are double, triple or N'ble calls
to static_key_enable() they'll just end up doing nothing without any side
effect of holding the lock. The fact that it gets disabled doesn't relate to
the problem that the static_key_enable() is being called repeatedly is what is
causing the problem here. And the solution is to not hold the lock. I think the
atomic_t variable is enough to do early bail out without holding any locks.

What are the concurrency issues you have in mind? And why the frequent disable
is a problem to _replicate_ the early bailout logic outside of the lock?

If you have in mind a concurrent enable/disable, then I'd say the calling code
has a bigger problem for doing concurrent enable/disable. This doesn't make
sense and the logic will be accidentally enabled one time and disabled other
times depending on the planet order, and moving the guard for early bail out
out of the lock wouldn't make this any worse, no?

> 
> ---
> By the way, I sincerely apologize for forgetting to add you when I
> sent the patch-v2 and patch-v3 emails.
> 
> V2: https://lore.kernel.org/all/20250219093747.2612-2-xuewen.yan@unisoc.com/
> V3: https://lore.kernel.org/all/20250220055950.4405-2-xuewen.yan@unisoc.com/

np, I'll put a comment there too.

Thanks!

--
Qais Yousef

