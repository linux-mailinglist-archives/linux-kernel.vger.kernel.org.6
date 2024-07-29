Return-Path: <linux-kernel+bounces-265772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A91E93F5CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448BA283165
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A777214A4F5;
	Mon, 29 Jul 2024 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0j2aVwqa"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C07D149DFD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257159; cv=none; b=Cn3hLjE7EH4ChHXyznZuXGi8rZcOtuKazBNmINWI8YXC5/pbFnLjHsfHO83+6kuyLAD1OhwAnGbWJbCMs3mn1XM9XT/pgaM++po2yEdAnEGK9TENFe736C1dnQku9x6S90nIYHOfiIwNj5Mw0Chpza9UhxTtK6sLDMm8Vb4njhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257159; c=relaxed/simple;
	bh=+8434lN6ua4CcFvv8st/GhvaYrStkp0uclRD4U2eGv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pf01H3yMahls9G95FGSFS2iHSAUh7yIQ/vtxc1Vjziu1Qm5qVIRSlWxDveS6fpiNe90RKh2QE8upD6t5+lbbEH5kF5ZMVkQo4SXNvSTLzTWjE1XSWR7MDMQLkEcO+t3k6t9rTmjmKYS60up11fau0ynWqjVL/RCCudln08R4ti8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0j2aVwqa; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4928989e272so616656137.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 05:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722257157; x=1722861957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oZgdZG91J97JhZAPZXIGBxb7mC3XZ4lMKL0buOQ+YVk=;
        b=0j2aVwqaQuWsFJI6gJ8oy2ni84NX5jdyxl46nTuALihaJo6QtrOyOGPUjpnkB9Xo3f
         MyPLKpfHw1/RryGvIZNbOyiWKKMC3JHWr85cmkyvADKb9c1JHBqSG49+nSK+tl6fJ3bL
         Uq26BWeDlU2THsT1+DscNV9CTvdgrlbkBz2Bjuzr2rV2gxvuUUoanGeKA86oDMopYF0K
         eqGbt8Nenuexsvle8oWTfOuon2wvlKTJOqiSZIReoFeWnq4kFdTntMKqPvZDkIYpft7z
         +KEg5k5IwYR8XqKzgUpAyXnQG3d9tMd75jsgbCsdPpjBALJMPVubD88hAIrLbl874cVf
         VqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722257157; x=1722861957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZgdZG91J97JhZAPZXIGBxb7mC3XZ4lMKL0buOQ+YVk=;
        b=ZWYEfItdip1hfFDtKMKdURpMyse8adn95LsGKetZILJGOLRxvYoHlDnCaT6etfwgrX
         v5XusD5hzPzNui74KbGXeJI0QD0C7VezfHzCSxDThAN7y31ubblg/nrsJayn91D/nLy7
         99etkMJSMWhXXBkCCPPuFg1en4XC5WUfM7OBKzy5VxV6zkWyM0fO+9IYhYjEk4cqBOJb
         8d331i5PUre955kKhE+ptEq29XSl27PSuv8DOqQLphx+DyKxjE1oAtjB4Q3jxtuPPQEq
         UKASTT8j1Il+9w1lH2RPJjndW++MGhsm+DBhylLa0L0fH4I8U6re5AME/2vr25hII32t
         txaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHy1tgE1aUQcsQWj7ORZz9OFdP6nYHwlvzGUXIyfDAITRwGgXj7Wf7N4fpGU8YxXKV3cPNTa0Lu+zWhpvkhXnDN1adXyz1bIbOxHYx
X-Gm-Message-State: AOJu0YwhQlhDzP+O/WcoG3B6xMWfMCHWES/n4t4hx7fzlKYmeGfVLx83
	c0F5ijGmGD92obEy4UgmCm73ljnNAPm1ghsv81z/OXZQRdVKWdB5kNVe3xRMJ7+ZN1i53fpXKrG
	aQNVWm6yFtFBry3RKutjeXRojDuLg/SiFhK/E
X-Google-Smtp-Source: AGHT+IHmnfE1ygzY/qhGH4DKTImqmNpWMjOFZPler9WZ32cIt3tMKFcZ4e9BHs2Z3oXOtRZrptJpw5lnmnh2EiHF8no=
X-Received: by 2002:a05:6102:32c5:b0:493:bf46:7f00 with SMTP id
 ada2fe7eead31-493fa61bdf0mr8035840137.5.1722257157146; Mon, 29 Jul 2024
 05:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729114608.1792954-2-radoslaw.zielonek@gmail.com> <20240729122726.GA33588@noisy.programming.kicks-ass.net>
In-Reply-To: <20240729122726.GA33588@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Mon, 29 Jul 2024 14:45:19 +0200
Message-ID: <CANpmjNPrHv56Wvc_NbwhoGEU1ZnOepWXT2AmDVVjuY=R8n2XQA@mail.gmail.com>
Subject: Re: [RFC] Printk deadlock in bpf trace called from scheduler context
To: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, song@kernel.org, jolsa@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	mattbobrowski@google.com, qyousef@layalina.io, tiozhang@didiglobal.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 14:27, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 29, 2024 at 01:46:09PM +0200, Radoslaw Zielonek wrote:
> > I am currently working on a syzbot-reported bug where bpf
> > is called from trace_sched_switch. In this scenario, we are still within
> > the scheduler context, and calling printk can create a deadlock.
> >
> > I am uncertain about the best approach to fix this issue.
>
> It's been like this forever, it doesn't need fixing, because tracepoints
> shouldn't be doing printk() in the first place.
>
> > Should we simply forbid such calls, or perhaps we should replace printk
> > with printk_deferred in the bpf where we are still in scheduler context?
>
> Not doing printk() is best.

And teaching more debugging tools to behave.

This particular case originates from fault injection:

> [   60.265518][ T8343]  should_fail_ex+0x383/0x4d0
> [   60.265547][ T8343]  strncpy_from_user+0x36/0x2d0
> [   60.265601][ T8343]  strncpy_from_user_nofault+0x70/0x140
> [   60.265637][ T8343]  bpf_probe_read_user_str+0x2a/0x70

Probably the fail_dump() function in lib/fault-inject.c being a little
too verbose in this case.

Radoslaw,  the fix should be in lib/fault-inject.c. Similar to other
debugging tools (like KFENCE, which you discovered) adding
lockdep_off()/lockdep_on(), prink_deferred, or not being as verbose in
this context may be more appropriate. Fault injection does not need to
print a message to inject a fault - the message is for debugging
purposes. Probably a reasonable compromise is to use printk_deferred()
in fail_dump() if in this context to still help with debugging on a
best effort basis. You also need to take care to avoid dumping the
stack in fail_dump().

