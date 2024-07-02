Return-Path: <linux-kernel+bounces-238140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1507C92440E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45EEB1C23336
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775721BE224;
	Tue,  2 Jul 2024 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MibujdPT"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8F91BD505
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719939792; cv=none; b=kJZPug9supDUHaFNnFr0FYIqlC/NrXrP9tlCD3FygaQ8IQirINQlYeHEvBhjMIhV9E1pNnMJRQa7hgxZ7MukBEwR7fP1XawZW8XEEyO2Q36xUzE1Cv17VSR9IYVTtEA2WF09EO6GFs1DucD11Mgf/deUv0d3fmpHhH6laRTekyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719939792; c=relaxed/simple;
	bh=SJjrYGYHHwZ61PnvF9q5/p7fpSWQxsDabX0KAL9mp38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkNUlPvLk9/fNoiIeYEl28R4FIieVqchxOamoYnHC3pxK6mVcH4J70dkn0Zebuz2TTrYF5fkLoHm5eFcO8I6AkCeagWiKb4s9LUMhYQoNihRa5zSJluuvODOtKYdUV+jy9raF+CbyT5a0i/VVYYPD3b0LOAilkYAKwGNPhNTCZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MibujdPT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58b447c51bfso1548126a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 10:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719939789; x=1720544589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJjrYGYHHwZ61PnvF9q5/p7fpSWQxsDabX0KAL9mp38=;
        b=MibujdPTntvyTAN2q4+s3H4vtodG2OibkFdEgETXdP2a/vlA67L9h6jbRmVAfzz2eD
         e6YQ+gROt27tWba9+ekR10Up/7b3MKGYC3i5ZDUj3hd6y1jaSi9Xl/XDr3dIGjTwLUy7
         SVJCqQqJE2fmktbAM8sMNZVO4ZtpCYBE9B/D0qd0KeyXFUvm+wvguMXJVuBUSAk9JBhw
         NqiWvdBekNQWaIFyDVFYCTyXeuybtN8S1Wvb9czYMdP5opBrR1P/AO/e3kZ4GN2KXDIm
         X2B4/QvzXYP43rVKwOo8KOqAdFP4v1mR38x0s2mFmiGnWFaM8ANEWrrB334x0H0oQH+n
         CvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719939789; x=1720544589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJjrYGYHHwZ61PnvF9q5/p7fpSWQxsDabX0KAL9mp38=;
        b=jKlBXGUKrzMG+JgG0BANYCto6UH12il/yOK1SS44iFshGUXazEKWMsCD+UerqFPfOi
         s6ubD/4LVPvoDui2WesvX8shlOhKVM9YEFZ97wqrcsYDjJoUgBFEG/v6ayr4siZOUiMm
         GfhnABgqOMM1YtBHJ7BXDJuQjVNWd8T9ofLYXmX+GVrmtgYvzSZ4eX2tVPDiFWR/rn2r
         sQQ8FG8zIUIH5bsX8zdVMgcux60dUldOqJKyFSTmE6zmup6Y/Ma8MIZzB98BZh9wVL7j
         RsJnsga696GXeym1g7c0jzH0kVdw1gSAqkF/Ah7ZUS+bmLgmUcs5+lzA0evc3VLHeRi3
         xuHg==
X-Forwarded-Encrypted: i=1; AJvYcCU3DzdIyc39nTvE7Gdr4vSugRcFQzmNLoCo5kWGt1asP4hYrs+eXFKCZfc2tHRT7q3GMeBMsdVxyXRrATBOu1I3QUejTaFb/wJIzs0p
X-Gm-Message-State: AOJu0YxZaIJQ1iwGX+4fPM42G9W+Oqh4wNPakxOXvXx4cIYgIu4wr1eV
	MFa1sgc0cFJ/Ih28X7QVz+eaM6mFfcgmqVcnBc3ZmDHaZ46cq5Xfg6pUPqnxhVJ+SRiWoGHtW2t
	2pd9O1udqcOoBUVrj1pk4qFV/40M=
X-Google-Smtp-Source: AGHT+IGXNQd+0tJLmUXddHIo1j/DHEEZvybJUyBGUresmYG9sx1mdFAY7nd0ymNHYdn+8GtUly3OiEWyux7bo0SKJ2Q=
X-Received: by 2002:a17:906:3183:b0:a75:1069:5b94 with SMTP id
 a640c23a62f3a-a75143e700emr545024766b.21.1719939789328; Tue, 02 Jul 2024
 10:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406270912.633e6c61-oliver.sang@intel.com> <lv7ykdnn2nrci3orajf7ev64afxqdw2d65bcpu2mfaqbkvv4ke@hzxat7utjnvx>
 <vgg45kxk2fiyznm44w2saz3qjiwrjp3spvpswsl4ovd2jl5c5g@54dlbd4kdlh4> <CAHk-=wgnDSS7yqNbQQ9R6Zt7gzg6SKs6myW1AfkvhApXKgUg4A@mail.gmail.com>
In-Reply-To: <CAHk-=wgnDSS7yqNbQQ9R6Zt7gzg6SKs6myW1AfkvhApXKgUg4A@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 2 Jul 2024 19:02:56 +0200
Message-ID: <CAGudoHGuTP-nv=zwXdQs38OEqb=BD=i-vA-9xjZ0UOyvWuXP_w@mail.gmail.com>
Subject: Re: [linux-next:master] [lockref] d042dae6ad: unixbench.throughput
 -33.7% regression
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 6:47=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 2 Jul 2024 at 05:10, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > Well there is also the option of going full RCU in the fast path, which
> > I mentioned last time around lockref.
> >
> > This would be applicable at least for stat, fstatx, readlink and access
> > syscalls.
>
> Yes. That would be the optimal thing - have some "don't take a lockref
> on the last component at all, because we will finish the use of it
> under RCU".
>
> I looked at that some time ago, and it didn't look _horrendous_ from a
> conceptual standpoint, but the details just got to be nasty.
>
> What I wanted to do was to hook into the "we're still in RCU mode"
> with a callback that stat could set.
>
> And we'd call it at complete_walk() -> try_to_unlazy() ->
> legitimize_path() time just before we do that lockref_get_not_dead()
> thing.
>
> So then the path walkers that are ok with RCU state (ie mostly just
> 'stat()' and friends) could set that callback, and get a callback
> while the path walk is still in RCU mode, and could fill in the stat
> data then and say "I'm done" and we'd never actually finalize the path
> at all, and never do the final lockref_get_not_dead().
>
> Sounds simple in theory. And then when I looked at doing the actual
> code patch, I ended up just running away scared.

I was thinking a different approach.

A lookup variant which resolves everything and returns the dentry + an
information whether this is rcu mode.

if not the regular handling + path_put sort it out.

If yes then the fast path handling gets involved. If a filesystem can
provide a custom callback for the regular usage above, there would be
an optional callback for rcu mode as well (and it would be illegal to
only have one). Should this run into any trouble it can return -AGAIN
at which point try_to_get_actual_full_ref() (but better named) routine
is called and it tries to get the actual ref.

Suppose the callback or in-place handling worked out. Then a routine
to validate nothing changed (at least dentry seq?) is called. Should
it succeed that's it, otherwise the entire thing redos the work the
old fashioned way.

I have not looked to closely yet but I think this is very much doable
without much swearing, I am going to look into it after I find some
time, maybe this weekend.

Regardless of the above I think decoupling actual dentry ref from the
d_lock is a valuable step anyway, I am going to take a stab at that
too. Most of the work is kind of already done with the 1->0 transition
already handled. Just need to replace non-atomic updates with atomics
and cmpcxhg with a flag to whack new additions.

All that aside, the lockref patch reported here needs to get dropped
from the tree and I don't think a lockref-specific replacement is
viable.
--=20
Mateusz Guzik <mjguzik gmail.com>

