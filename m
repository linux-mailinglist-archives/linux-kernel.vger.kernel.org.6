Return-Path: <linux-kernel+bounces-567954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36242A68C61
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50643B8CBB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55357254AED;
	Wed, 19 Mar 2025 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwdyih2b"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFEC1E1DF4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385983; cv=none; b=qbHe1bfNWM/wsRIQ022aLSkRhaGRrl4kg4Ht0gFd/q/+8/tjWhzwanfZCOcJhdAP+XByzIDvBa3vPddMtJkcw62FEO+0j7MRxKsICXg14BvsP3GriImLwYrTAn4qMc+nWQ508DGO3fM93hXP4F97lqNXFFzS3ip78UBrNcCp4S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385983; c=relaxed/simple;
	bh=7TBVX10VVkB2XcwzQB3uaAP59uAA9pyFtsT7OJY3iBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afPSxITA52mJ84R/rVBLedhLI28MUqBxr/DiZ8XcHabtMzTT0XZ88Z4JTOckiG6BYKrsyX/XtHS83i6xlISF+tPRCCpZByfKGmbfOnC0FDUHxG0/6OR9Bf3/u5DG6XkEjFF5JK4faVCDwkqlBv9LyYFrvU/4Bp501GNxZPiJcOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwdyih2b; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e686d39ba2so12638568a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742385980; x=1742990780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3EL0y1nxdn+S0kg3WciVAYwKV1UdCQFtV9QNzVBZpA=;
        b=bwdyih2bptI2rjkVJKSJwM+xTnHKxEE58rQPdHLcIF/AiDN0jMXyWgfaNfQBjcZefA
         COwgrweUxZIw8L5y9yEeR4AxG+WojLaQRn1bpjufNgN8SipsSjC1puYFnyxSZDaLsLlg
         83O7CrOuhiFqM6Zr44mu8idl/vhVSWi83jXopLwkXL8ZtYXLQMgm2FfsKDPVB56I3Erq
         C5LmbX/13L3SA4SOwRaHeR39gPhA/L3qmDHYZWLG9rLYVRC3cO6E6g8MV4k4Ir9qoghV
         pg4yafY9wTYoYjElTdeQQo01lBoCXh83XOyy4hj8ZUlp2SQPJSfn6fZR5H8/S6oWTT+r
         42Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742385980; x=1742990780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3EL0y1nxdn+S0kg3WciVAYwKV1UdCQFtV9QNzVBZpA=;
        b=NLzjxIBUk2rZUV66KMQveon27Ikzwi0o/hY2HC03kdxRoSOpaW1v7KthVraVLB+dJV
         GqmlOs0vrhX4q+hTk9RlJVz3uQjomXnV3/D0l9/uV52BK3e6Iv5XSJaASQwsnU/Oc4tN
         tGAyYgQjtKNfduLfIF5NIDhmt67P7u/SGsMWq+kCfqcNQMWSDZ+m2zfEYfBNZostkMWS
         XiQ/raSAjUqwnWuluhoCIp07HkVagemD0yMZR9ScKAA2qIigFOAATWiStcYLd2MhQ6AS
         2nFk1biPx8aSo8aiJQCmb6OGK2o59CK6eJtLYJKTXEaPiBcNT5GChFeJyWh/StZ43ego
         hnZA==
X-Forwarded-Encrypted: i=1; AJvYcCUudDOiGvp7Rw1JBVmMPn5v7zI0bmLdRGr26EfLeYWUbLKY0LIeWuqtZVA5mZQNZ89Rg+Xu94inEWifZL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDzJPmqqCn9ldPm//7thSJ3NCRmXRf4/lQRCs1ecJR3DD6oSZ7
	WcAXdZUcMawfj71reeh2p6RYeii1DSz3CxEF62uHx+wXQinypX6K6MXv0T+PcC1uDtwQl8w2LCP
	kgxCqP1A/YUkdLzqxZUJqmAhV/js=
X-Gm-Gg: ASbGncuQRySqh/mNU5B935X+Tmxo0vPsJQ2ms8nMsIjHzfe9wtau+KBVj/BtZ8Hxlyo
	7ZWl2m/4mY+toWbPXpEhWRUH7glH89TgQc9d+5JfGHnkK39NS5VadcnDBlQtJa0A2cjI7LZU+zN
	WeAyyWuAcYqJVYTX+Eo115XkebpTDxVsewzRx4
X-Google-Smtp-Source: AGHT+IEIcf7UonIF+NpmUjJ3QMKQJCa9BgVGGRtc/zSfqj6COuPWDcLkqLjAuw48+kWzcNtDBtH/n6NtIDOW9yT9Ek0=
X-Received: by 2002:a05:6402:354e:b0:5e6:13bf:2c7c with SMTP id
 4fb4d7f45d1cf-5eb80cda978mr2460294a12.9.1742385979998; Wed, 19 Mar 2025
 05:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312221147.1865364-1-jstultz@google.com> <20250312221147.1865364-3-jstultz@google.com>
 <20250313061351.412bc92e@batman.local.home> <CANDhNCou90nzwZR+cQisJnwBis=JGSw0WYE6BDRddhMobrkkXA@mail.gmail.com>
 <20250318231101.a77dd6de0f5e48cffad5e08a@kernel.org> <CAK1f24=rTxBF6RGrToHLCg0cZ5ffe-OLEqXu8eyC5nqStMVRwA@mail.gmail.com>
 <CANDhNCofYzVrdND+iPBU64feim+Cqi+bOCp-iaWJ8=HkAcDJ2A@mail.gmail.com>
In-Reply-To: <CANDhNCofYzVrdND+iPBU64feim+Cqi+bOCp-iaWJ8=HkAcDJ2A@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 19 Mar 2025 20:05:43 +0800
X-Gm-Features: AQ5f1Jr-LoGxmP_ubb9Za6nGRg0IIaB3FzVW6MQxuPK7TnI81GPa_dp-jcjUlkg
Message-ID: <CAK1f24=pmf3+Co5B49TngNrNJiAWse3zRc0tUJe30XKHxcKg6g@mail.gmail.com>
Subject: Re: [RFC PATCH v15 2/7] locking/mutex: Rework task_struct::blocked_on
To: John Stultz <jstultz@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com, hikalium@google.com, 
	amaindex@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 5:49=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
>
> On Tue, Mar 18, 2025 at 4:33=E2=80=AFPM Lance Yang <ioworker0@gmail.com> =
wrote:
> >
> > When=E2=80=99s the next version expected? I intend to send a new versio=
n out
> > soon, and it=E2=80=99d be great if you could include it in the next ver=
sion ;)
>
> Yeah, I've pulled in your old version already, but I'll update my tree
> with your new one.  Between conf travel and vacation, it might be
> April before I get v16 out.

Appreciate it! I've sent a new one[1] out today and also Cc'd you. Will
keep you in the loop if anything changes ;)

>
> Most likely I'll be moving much of linux/hung_task.h into
> linux/sched.h to get generic accessors to setting and clearing the
> task blocked-on relationship (so its not just tied to the hung task
> debug logic). Then for proxy I just need to integrate it with the
> additional blocked_on_state that is used to determine if the
> (previously blocked, but left on the rq) task is runnable or not.

Yes, that makes sense to me. Feel free to adjust as needed ;)

>
> > Also, since we have similar use cases, it might make sense to use
> > the same field to store the lock, encoding the lock type in the LSB as
> > Masami suggested.
>
> Yep. Agreed.  As I mentioned earlier, proxy only works with mutexes at
> the moment, but I do intend to expand that once we have the core proxy
> logic well tested upstream, so the multi-type blocked-on relationship
> is really useful to have.

Yeah, let's keep it simple for now and expand it later once the core proxy
logic is good to go ;)

Thanks again for your time!
Lance

>
> thanks!
> -john

