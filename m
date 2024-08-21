Return-Path: <linux-kernel+bounces-296188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6114495A6EF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E61B1F23E93
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5D017965E;
	Wed, 21 Aug 2024 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ADCUuJhP"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E101313A3E8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276511; cv=none; b=tDeZwNTTPavlvcnMqVmGyeeSucQFPZgs+/OzWphnGHX3iINDPYkta9Eib0iioKnEjHG4Z4+TVRTkA6Oz7QP7c4Pbm4p50uRMliMjSvogcWUb57IO0Lh6GitzMJMVE1JbWxkctqbXuppTR+2j00Noa5SkmSOSytsCGoQiQryN4Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276511; c=relaxed/simple;
	bh=DLNDOrlGVajMi3Qd1IrA1Q9WSFxS9TC01GUJtrRk1Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eePk/8S1SIXLzTxCKhsGSvFcckO0D6rYubNowus+hs0F83gsRLZ/wGBj1yZF2zSGF71JUPowc1KltM3xJDpiXZFccfnzjxhTAEuK6nRvZ0jmB1NNTttTsM1mDCQn67Y+ytDwMC9zxeW3hkAW2NxhWiQQzIUaogo7SzETLr8HuWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ADCUuJhP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4281c164408so774935e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724276508; x=1724881308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ozgnoN2cFVfVrzpX6rNrewYUXIPLCDv41zrOLLKBEs=;
        b=ADCUuJhPTiJZRqoFjQY8FABOOAfEsiNwQsHIQtkec92ooGB5+aTVJjbFdgFEcuLl6D
         4Pbi4c+lNezppzJ516d3f0Zh6VuxoF0rC0FTbSW57ovYT94iRsI5yx+i211tKSrq9gB3
         Bns9dfgiFPnTA6rwHw5Rliwj95v8Bl4WCBbwOhwQu3i/t0paJjG5ItmGV6ITHw4gqq8d
         iFjFHc1W6zcHDMBvW0dweeD7ux2PXnTYLTNuMdpcLg7SFEFU8kjyliz/7CbedNY6Ybv0
         0ECVTWxWwP0tjUckWq8bZUTX0F+/u9IdwrZWoJS9zPXlNpsU8h5CwtkXzm64KySY3tmk
         kjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724276508; x=1724881308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ozgnoN2cFVfVrzpX6rNrewYUXIPLCDv41zrOLLKBEs=;
        b=VIDwSFC+3zSJuXdJCo1kBIGu56N8yqixr/5UwZcWQ75d7Hf/GaHUM4MbX+30qLfPpB
         fKhCK6c/9Yj76L9ejW0zeEBHIp9xzvlUB/C+i05wS0ae3w7/SbauDyPgbHUFc/qO26Ms
         Ye/XMDJrg5rolmSxvmQFQssZqwHIDjD+sY3wSXHb8PTD9BWg9982DhtW02TPrPci+c6u
         mrfN0PdwE+lWYVmB1+wxPBjlxJbw0eidS1WnDTKDmvnz+0ydrU6yS05gWNUUtYU6iV4x
         SKtDgyJBcdirGWXXu6ahlu7RO7yzuhDNnPTRtbOsYrilDrG4asGjMA48ZRy48RxhQxFh
         tL2A==
X-Forwarded-Encrypted: i=1; AJvYcCXWNYDYz1osdorh50q8KPQYRkmmldxF07Vmf4cGcMru3irLBkRJjJvLoQ6qR7U8PoUp8WU6vOWEaTUsZDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxA65St1llIAGwj9GrlRxbVO9GzmlAEHvMHxJH7XxryUWcVoYk
	BOOejvtM+jBg6sgtbrAleOkXDnwbHXEe493mtZoynBI4YNl5A8u4WKWFdrL89IMmVWMLMAA117F
	E6znW1AxA0TKfJWp5MLNKH5/KaEhCObxN/ofy
X-Google-Smtp-Source: AGHT+IE/kxEf642KZuNOsCXqKlhUE1zAigtPqYXCdqzHhQEPNge0SXXCMu8v/C+d7culmBcTIXphBYsoZVa+1zj8FK0=
X-Received: by 2002:a05:600c:4f96:b0:427:ff7a:794 with SMTP id
 5b1f17b1804b1-42abd11203amr27772155e9.4.1724276507934; Wed, 21 Aug 2024
 14:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813222548.049744955@infradead.org>
In-Reply-To: <20240813222548.049744955@infradead.org>
From: Joel Fernandes <joelaf@google.com>
Date: Wed, 21 Aug 2024 17:41:32 -0400
Message-ID: <CAJWu+oqUSOUrro-Rk-Bg7P6PyCWGKRZVT5i4Bi36XpRRFumL5w@mail.gmail.com>
Subject: Re: [PATCH 0/9] sched: Prepare for sched_ext
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, tj@kernel.org, void@manifault.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, 
	"Joel Fernandes (Google)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 6:50=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Hi,
>
> These patches apply on top of the EEVDF series (queue/sched/core), which
> re-arranges the fair pick_task() functions to make them state invariant s=
uch
> that they can easily be restarted upon picking (and dequeueing) a delayed=
 task.
>
> This same is required to push (the final) put_prev_task() beyond pick_tas=
k(),
> like we do for sched_core already.
>
> This in turn is done to prepare for sched_ext, which wants a final callba=
ck to
> be in possesion of the next task, such that it can tell if the context sw=
itch
> will leave the sched_class.
>
> As such, this all re-arranges the current order of:
>
>   put_prev_task(rq, prev);
>   next =3D pick_next_task(rq); /* implies set_next_task(.first=3Dtrue); *=
/
>
> to sometihng like:
>
>   next =3D pick_task(rq)
>   if (next !=3D prev) {
>     put_prev_task(rq, prev, next);
>     set_next_task(rq, next, true);
>   }
>
> The patches do a fair bit of cleaning up. Notably a bunch of sched_core s=
tuff
> -- Joel, could you please test this stuff, because the self-tests we have=
 are
> hardly adequate.
>
> The EEVDF stuff was supposed to be merged already, but since Valentin see=
ms to
> be doing a read-through, I figured I'd give him a little extra time. A co=
mplete
> set can be found at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/pr=
ep
>

So I booted queue.git sched/core branch on a newish Chromebook (after
applying 700 patches for making it boot and spending 2 days on it
since we boot old kernels -- I wasn't joking when I said I would carve
some time up for you this week :P).

With sched/core , it boots fine with core scheduling disabled, but
when core scheduling is enabled I am getting hard hangs and
occasionally get to the login screen if I'm lucky. So there's
definitely something wonky in sched/core branch and core sched.
I could not get a trace or logs yet, since once it hangs I have to
hard power off.

I could bissect it tomorrow though since it looks like a manageable
set of patches on 6.11-rc1.  Or did you already figure out the issue?

I am based on:
commit aef6987d89544d63a47753cf3741cabff0b5574c
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Thu Jun 20 13:16:49 2024 +0200

    sched/eevdf: Propagate min_slice up the cgroup hierarchy

Thanks,

 - Joel
(++ my open source email)

