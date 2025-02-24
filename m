Return-Path: <linux-kernel+bounces-528049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A8FA412D3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FB4B7A1DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2912819539F;
	Mon, 24 Feb 2025 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX+1kIWp"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB25BE40
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362144; cv=none; b=HAJAAW7rLvqvZFtWs1H15YnT1YVW5geP0fCTfzbOULFmygRtVwUuOGduFQUPHUNDz1Eysm/lW5TVTDLIFc8deHu/3850nRxHtoH/P7QBbguP2IIP1Jp8cv98uGHx0iRp1jflGIF/M91spbJJkSbslEg1/wK4QWuchn/Jvu7Bwmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362144; c=relaxed/simple;
	bh=lF+wszWTUg+smF+quXuL7YpMqbmBOLuAUdZafgSB5y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fC83bzpQ4xUor1fdPCIZID0JCqYFRwjuUmqgFqolDCmMdG23hNxHVPhm4+1ubkV4BaqVlQrdPTzhJ546/WTvucCr6eF4H+PT1hEHYbwuuE9VNbj/bdjP15K+nIV0gH2GyjvO68jJHrLIezW/tvlPt1h3WGQeduNBAk+KrHtRNeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BX+1kIWp; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e04f2b1685so5837771a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 17:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740362141; x=1740966941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOwvrvOEdZ4KUCylMY2dhS9aiHBzjEWdOCh9BrGc7P0=;
        b=BX+1kIWpbsmOuK4Cz9JDFHvyFPBPAtRNbgJLcsoz/+6mUjVb+KQNyFPQwNLrpL95XN
         1MXAREnGXL+z84HSOV5hQTzgI6L12SB3vV1nl+qsafi7rSeB+LnxyS0ogrkAUshVoa4D
         sIT+Kjv7XoQufukxkHA0HoDVHepQHF0lhOcxWf3cHmvmn1w/3xaejWJMkPG3wWvBJ8Mz
         Modryu4B+qSVg7kmL2dKVyDZxhufl/KBASomZP+o/yhEggGGeG27Abb1Bcjt1vI/HXpO
         ErE1GV0VPT1MD9CuZvlKHuNN4gYGsj+QG7Odw1Vvz+7/+X8IWNUlHiiyAY/lCuSUJ0IR
         wdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740362141; x=1740966941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOwvrvOEdZ4KUCylMY2dhS9aiHBzjEWdOCh9BrGc7P0=;
        b=cLvgRlFH6VDOesWuYu/8sf7Tz6974v3zjmGSAKnq1z9d0aFI3YCqRzfr8xw3GnXLJd
         y160LEQ3mi4k82QklnO1M1iaoYCPwu0tf03AQRKjwG1qnFf+EA/HW6SxAXaUec8k0bwC
         +EkMDenjg3M1USg+GsinZuTqJC9JCI6Cm9xFWRGdTZpXhf/plQpUpONowftjMgklqHT7
         THnwYV0E4vKfTg7ENUe7Wkbs6gKtDXQxItFd0tb1mN1C3KK4LQnchrjPbBKu5lvF4YdF
         MHlgF5dlIlTY2Iyqn1eV+WGNTzc+/70XZr7mECjhCUuXVVjNRPxaPy5Qzueps2lnxqcb
         X6qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnUXhTmodH1XT4pejHGA4uAUyaQ2e0WqNTT3iyTmH/fOzaobXtu36dUql0NUvQY1f5xpaRmXCJ3M5Sslc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAQG9hEr5Z2WrlJJunFoAdYNx98O/rniUsljI57X5OQBjuFXyW
	pfHYGWqLIAndE0CCTppLPgrs82zAnvHou55QLmYnvvsDJyFj+evkeMlg2crWHjvVOy9WKBsG281
	/nhPW4O1/mx/RbxwfTNGUbkUaMPw=
X-Gm-Gg: ASbGncuYhJZkaGrHfWLZuB6QH71SK9adc6QkvF6T2WxGtwYBDs3Brf+Zh0QohPGB54M
	TdFk8aZVy6otqyvQ2Brkz+lbmSgIE684qwFcWOtQgCGgmwfR0C24dTXN2ldYUlHuqjbIerfjFDF
	R1Gh9bxkfO
X-Google-Smtp-Source: AGHT+IH9iHxoq9nft7nbE1n4uOcg1yKgbuYATSFcm3cwmaU8NU9pHR7XIzp66/0klMxoWnX9UuLrK3X6dPA0w4qoLRw=
X-Received: by 2002:a05:6402:50c7:b0:5de:dfde:c8b1 with SMTP id
 4fb4d7f45d1cf-5e0b70c11efmr26267537a12.4.1740362140604; Sun, 23 Feb 2025
 17:55:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213091554.2593-1-xuewen.yan@unisoc.com> <20250213091554.2593-2-xuewen.yan@unisoc.com>
 <20250222233627.3yx55ks5lnq3elby@airbuntu>
In-Reply-To: <20250222233627.3yx55ks5lnq3elby@airbuntu>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 24 Feb 2025 09:55:29 +0800
X-Gm-Features: AWEUYZlSS7jEHc3N33fNxzyZghTU1LE6hlLowR-Bg_k2JF3l1GDIE3ts9oTTEus
Message-ID: <CAB8ipk_qXYrMC54ddxA=wJ7YabxMwKmp1MzJRSq=NcfMJDOfjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/uclamp: Add uclamp_is_used() check before
 enable it
To: Qais Yousef <qyousef@layalina.io>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	ke.wang@unisoc.com, di.shen@unisoc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qais,

On Sun, Feb 23, 2025 at 7:36=E2=80=AFAM Qais Yousef <qyousef@layalina.io> w=
rote:
>
> On 02/13/25 17:15, Xuewen Yan wrote:
> > Because the static_branch_enable() would get the cpus_read_lock(),
> > and sometimes users may frequently set the uclamp value of tasks,
> > and the uclamp_validate() would call the static_branch_enable()
> > frequently, so add the uclamp_is_used() check to prevent calling
> > the cpus_read_lock() frequently.
>
> FWIW original patch was doing such check but it was taken out after revie=
w
> comments.
>
> Is something like below completely broken instead? I think uclamp usage i=
sn't
> unique but haven't really audited the code to see if there are similar us=
ers.
>
> I think it is a valid pattern to allow and the expectation was there shou=
ldn't
> be side effect of calling this repeatedly.
>
> Good catch by the way.
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
> +
>         cpus_read_lock();
>         static_key_disable_cpuslocked(key);
>         cpus_read_unlock();
>
> --->8---

I don't think we should do it this way.
Uclamp can do this because it has never been disabled after being enabled.
However, for others, they might frequently enable and disable it.
If we don't add a lock here, there could be concurrency issues due to
potential race conditions.

---
By the way, I sincerely apologize for forgetting to add you when I
sent the patch-v2 and patch-v3 emails.

V2: https://lore.kernel.org/all/20250219093747.2612-2-xuewen.yan@unisoc.com=
/
V3: https://lore.kernel.org/all/20250220055950.4405-2-xuewen.yan@unisoc.com=
/

BR

---
xuewen

>
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  kernel/sched/syscalls.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> > index 456d339be98f..d718fddadb03 100644
> > --- a/kernel/sched/syscalls.c
> > +++ b/kernel/sched/syscalls.c
> > @@ -368,7 +368,8 @@ static int uclamp_validate(struct task_struct *p,
> >        * blocking operation which obviously cannot be done while holdin=
g
> >        * scheduler locks.
> >        */
> > -     static_branch_enable(&sched_uclamp_used);
> > +     if (!uclamp_is_used())
> > +             static_branch_enable(&sched_uclamp_used);
> >
> >       return 0;
> >  }
> > --
> > 2.25.1
> >

