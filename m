Return-Path: <linux-kernel+bounces-442113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CF49ED823
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802F628112F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C0220A5F1;
	Wed, 11 Dec 2024 21:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="paKlsZoq"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C58259498
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733951345; cv=none; b=AHH1pqBU3JaWTxeOV2E96/Ubv9j126eVKwUYEdeBpXLCQZMMLKNWvxmWosg+8qUJurONoazHW/1M4U+pgID7xyDGrCAUGFXVb1ASKjydMuMaMvQyTQ2DHFUSTfBaP2VkPMgzbBDDitA3+gwM3LR/ClMmlYZ5RYOObEukRfV5XKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733951345; c=relaxed/simple;
	bh=UMuf7QvTA2XnQeJlFbn5Vjur7t71UGz4wsZfjqaheEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHU30ho5h0ND6V/ukCJCQVrU1d+4YJgA1aWaDbzQZQOBAirjCf0c0z4W0jyrpHGWypfK9Er+fkL7cd9HZ/e7/bqXq3bIcY4Ir3gqGV7jTEX32jI+K6l1Df1Q+EY4UF5B+sz1IxvnzduxQm3c8QEx+u1XjlKtvAJW8V4hqvVEND8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=paKlsZoq; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so4997395a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733951342; x=1734556142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWKr7BaXZ+vIkPYK2y+8utG89WgugqNGBQQeRRKrwRg=;
        b=paKlsZoqZ7Pdl3CM9z91NI5Jeru/AhyG9P7NKptCnq7fvCAkVZIFjhtAf7YKexMhnz
         klYkWhUzRfKXb7t7U5C+Fs7pygXPteWBmdEJ9CgD6JrgEU9rbZtQv6v4KRtvSThzrmaU
         mt792FL58bAcys03m5RJ+SYgdO3psZth8xn3GUhHDVEYH7Qv3RbV+fQg0Mr/DMSxizxo
         KSs3UDTbl6VQkL87VjR0bHHrUSZKCLLnyMokO6v0rlnb4ip2H87jM9EJMm/txWZI3LXn
         OFbbeA8RWLZ8xWwGA+Zl2ldJm+fI+nLjJkWt8EJqgv99EWlLLmFK3hflOlyfvHKUDSrh
         7OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733951342; x=1734556142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWKr7BaXZ+vIkPYK2y+8utG89WgugqNGBQQeRRKrwRg=;
        b=bsN24nCoLFIjRAcAuGhEt4ekAEeFKLsNo2r9yPwTH5knNxbsvQ6dDwtiLTzM57yNUv
         hLxjp2b6ToyK4oB8ZYB/+iQochISAq5OIp8Y+y7L6CiLYIWHirsBLhMOaVlpvWMyfacg
         DLGaoyrPE50TPHm1R7lvtXD1HNwWtqt5oT+HUTRuK/RE20vd98vX5WEkcyqEJWxcCAX3
         Mhs1fc4Q+Im1ol51iAlSLWJpwnB9XFlxmT07vEb0HdzbCsTCBk0y45CL+1/tHqjeOmtY
         O91/rqT3waDHrTFGGbmBL068FVm2ByimMxUaE6IH9ncLBwXjWAAMD9+PT3evRtyQ3bWb
         pDag==
X-Forwarded-Encrypted: i=1; AJvYcCVXgyp0HRNcBloiSwT7G4ArIyr3d5f4rhhmw9bXYmxlIxucbiEXMmOMGS588y50TFD08cMkwiiQ7EOEwYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1suJNhMQaO651yIChfiaNw4cqDCoobwMI7EQd4PBdUEMey/gg
	SfsQfXlDDoVG8LDOXTwvRLiDQRNJK281eT3m6TLP+4cg+ZMyNKHCdORC2BUrqPeTDGHVhxTJP2I
	7kfsKk6rmOMb4Mf+uQwxl7pV48V7Ut3lbhEg=
X-Gm-Gg: ASbGncvmTN+cDiz+XmQEx8d7rfkrq2CQLX9xsY8KUs84751Az79WbEeUhXcd74XKtdm
	jD7TUeCyyNZyWHI4Gu3OUHkVXMJhDh7KysmECaF7Jx9MqcRxq3Z70jtR/TWzBmNzS
X-Google-Smtp-Source: AGHT+IG1ThQcEXyaHAOSLJxJW/2A94goCkpaCrH9Bfq0+RvJapArC69q8s/jJf0m0XglRgpgSEHC9hCPQI8U6vu3VgU=
X-Received: by 2002:a05:6402:3595:b0:5d0:c7a7:ac13 with SMTP id
 4fb4d7f45d1cf-5d4331655d1mr9972942a12.34.1733951341792; Wed, 11 Dec 2024
 13:09:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211182502.2915-1-spasswolf@web.de> <87wmg69gex.ffs@tglx>
 <CANDhNCpUWk_7Ocp0fvvjsLgZavcxvFcr3ac6psaZOa0xySfxZw@mail.gmail.com> <1d0d23600f87a95ce15998eaae8600ebe1d87ce6.camel@web.de>
In-Reply-To: <1d0d23600f87a95ce15998eaae8600ebe1d87ce6.camel@web.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Dec 2024 13:08:50 -0800
X-Gm-Features: AZHOrDlLBjEKcWGxZVnSkyBmE95w9T6y8wD1yqOSbsKPqOCw8j1aqjvg5744tEo
Message-ID: <CANDhNCrkDxPqyV5BhawdO8H2u+TbMVQjC51jwwY=qn2Q5RhTAg@mail.gmail.com>
Subject: Re: commit 894d1b3db41c leads to frequent hangs when booting
To: Bert Karwatzki <spasswolf@web.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Metin.Kaya@arm.com, boqun.feng@gmail.com, 
	bsegall@google.com, daniel.lezcano@linaro.org, dave@stgolabs.net, 
	dietmar.eggemann@arm.com, joelaf@google.com, juri.lelli@redhat.com, 
	kernel-team@android.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	longman@redhat.com, mgorman@suse.de, mingo@redhat.com, paulmck@kernel.org, 
	peterz@infradead.org, qyousef@layalina.io, rostedt@goodmis.org, 
	vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org, 
	xuewen.yan94@gmail.com, zezeozue@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 12:44=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> =
wrote:
>
> Am Mittwoch, dem 11.12.2024 um 12:27 -0800 schrieb John Stultz:
> > On Wed, Dec 11, 2024 at 11:19=E2=80=AFAM Thomas Gleixner <tglx@linutron=
ix.de> wrote:
> > >
> > > On Wed, Dec 11 2024 at 19:25, Bert Karwatzki wrote:
> > > > I tried to debug this with CONFIG_LOCKDEP=3Dy in v6.13-rc2, but usi=
ng CONFIG_LOCKDEP=3Dy
> > > > makes the hangs disappear or far less likely, and I get this warnin=
g
> > > > (2 examples from two boots):
> > > >
> > > > [   17.203857] [   T1337] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> > >
> > > config LOCKDEP_CHAINS_BITS
> > >         int "Bitsize for MAX_LOCKDEP_CHAINS"
> > >         depends on LOCKDEP && !LOCKDEP_SMALL
> > >         range 10 21
> > >         default 16
> > >         help
> > >           Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAI=
NS too low!" message.
> > >
> > > Can you increase the chain bits config and try again?
> > >
> >
> > Thanks for the report and bisecting this down!
> >
> > Can you double check that the following commit is in your tree? I
> > think it has landed just in the last few days upstream:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D82f9cc094975240885c93effbca7f4603f5de1bf
> >
> > thanks
> > -john
>
> v6.13-rc2 does not contain commit 82f9cc094975, but linux-next-20241210 d=
oes
> contain it and shows the same buggy behaviour as v6.13-rc2, I'm currently

:/ hrm.

> testing if linux-next-20241010 can be fixed by the same revert as v6.12-r=
c2.
>  I didn't bisect this in the linux-next tree to avoid an overlapping bug =
which
> also caused a hang on boot (this has already been fixed):
> https://lore.kernel.org/linux-mm/CAOQ4uxgVNGmLqURdO0wf3vo=3DK-a2C--ZLKFzX=
w-22PJdkBjEdA@mail.gmail.com/T/#t

Could you share the config you're using to reproduce this?

I'll try to work up a few smaller reversions (along with some extra
debug details) to see if we can isolate where things are going awry.

thanks
-john

