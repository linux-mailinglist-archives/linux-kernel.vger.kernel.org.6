Return-Path: <linux-kernel+bounces-437775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4339E9880
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190601881988
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C463233157;
	Mon,  9 Dec 2024 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="QmOC7M5s"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CBE35971
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753559; cv=none; b=LppGlVldXB2MpCEZKTKvt/0nJ++YK/F6AT580ZzBrbSYGpQsxl2QyVWboTCAtxdedqWkEt2MKLLUGmbdX3wrqEaMfRKhL7shvKkre4o4efpGZuq9bYbe64yYrZA2DFo2as6Kg5Hw924HDlKlrSkt/S6hwD4wDwyRnXanRgKXmcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753559; c=relaxed/simple;
	bh=oFrlp2F4hEM6caKItKjiLvrAcghM9kpM0OzhcKyv/Wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIu7qSqBZx6BkVQHAAbWLJG1dlFxw5mBZg7ALqAHzk7qRY/oqAUKM40w3VhI3SHDakTcdvbpRPqFsudXlo3WkY1Psh5VLvwkgNuZDdFz6Q/cB88T86WuekLtwrgmkWnEW1D1aKjiG/ZldsJ93sZo2HhrY+MKiggRoY3mhfbh5+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=QmOC7M5s; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ef66fd2183so39463737b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1733753556; x=1734358356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oFrlp2F4hEM6caKItKjiLvrAcghM9kpM0OzhcKyv/Wo=;
        b=QmOC7M5sENF5//qOssTk9mWXfSQV7cl7PtNef2FhDk3MSxReMdUS/h5DLlNdG4imsU
         C8HrDSJ7twcble9AxRz4zJnyjzKtfXQz3mogvr1CKCEHnvNPh9ejRlHxF+yxSLSnZPv/
         +sgyc/JaJZEYorEQlCS49UP9QPTGZJ7QEohGYMr5uO5rFdxsjWmeilHba8AIZFVsi8r3
         jlTCHEJzCA+PipWWPgBMKzHYWyfepqFLhUMT287gjlEI4m/T3QS4DRhDSph+46kMN/fE
         Y9W864ywnAs+EGybJZkIxxgX8m+KMHEcvf1B/+VmwOY+ml3q7FFSn3PBpxuHcwy8UgPQ
         o1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753556; x=1734358356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFrlp2F4hEM6caKItKjiLvrAcghM9kpM0OzhcKyv/Wo=;
        b=sDW8fAQndEi5eGvETDrwqm87bkarskJwVhZyjj9qKfQKNlfpqThA9nfpYCkWFeiiI3
         1nX8droCMV7jv29T0hRcWL+iF2uLXk+xy35PUUqCUXemGJOyMGYf1OR5dyx0/K/ZzGgm
         lC/2EvVe7qJ3PNFY2pADKhucyZxsRcxg9tRfVzO9p/i+7uLOXMVtmoRJxXmFxsJFom1k
         ZwjJ3WrRIYlw+tyXN+++M7Y3/QFjJJqQk2/GaQJGH+mQKKsLsxcl691WiveOBuzW8IG8
         yHc/B/PDTq31YN3ufeRJDMlLzNGB4soBT1qZ/2gyVkFphRqouBJ0e2vv5PMJd0sVV5iC
         u2tg==
X-Forwarded-Encrypted: i=1; AJvYcCWKV6r8/LGj25sL+a4/Qms8b5YYUC735rX5t24bnj98Kp2sESOrTZMDMujZ5VIJY3EAU1wCBAETSPAp4q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRmYkm5DV6AdBhnbadAGyZRfYsyDs4qO9+ATg4mxCMlIktp5pC
	HZitF5E+tNKuRgHwShVahtvWvLzf3SkkpuIOEZwU3SQDDqeF0qLHS+N0vYNoFM36m5+V9Ma23B6
	Z7HoOBxsOfip8dyTL0O9IHm281NLYJIjH+3hb6w==
X-Gm-Gg: ASbGncsfX35kuPJuWGfuBfP/WMHrZm2QZZKhyq/YHPoJnhhR/gQTl9luznw1ht2KgiV
	1pBg1AgceqpQrkpNdQ8iwhaJg3vKGDk8=
X-Google-Smtp-Source: AGHT+IGJS5KjkrOs31Ev3+cpXuX3oQ6C3bZQ+5dPrvHjkrZcEADQA3OQB24ZaxIIcJLxCks/Xb+GYxkk4mDO9MvAw+o=
X-Received: by 2002:a05:690c:6809:b0:6ef:59ef:f194 with SMTP id
 00721157ae682-6efe3bd5b3dmr117495037b3.4.1733753556397; Mon, 09 Dec 2024
 06:12:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <571b2045-320d-4ac2-95db-1423d0277613@ovn.org> <20241206151819.GA3949140@google.com>
 <CAO7JXPhdv+Jx_UpAq=-aG-BKwiyjZ2kvuZDM4+GLjbya_=ZJsw@mail.gmail.com>
 <20241209105514.GK21636@noisy.programming.kicks-ass.net> <CAO7JXPgSYCzu0mtnWqBaS8ihmoQXX3WE_Yb_rEYuMeQn+B6KJg@mail.gmail.com>
 <20241209125601.GQ35539@noisy.programming.kicks-ass.net> <CAO7JXPj6_VF+T1ykwQsCmBjVhHQdpX0wJssPPRYOazJcciCCyA@mail.gmail.com>
 <20241209140108.GL8562@noisy.programming.kicks-ass.net>
In-Reply-To: <20241209140108.GL8562@noisy.programming.kicks-ass.net>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Mon, 9 Dec 2024 09:12:25 -0500
Message-ID: <CAO7JXPjckPaW7=dkCGUk-yD+CgNW9iN4TpkknCeTkmBAZ2u1OQ@mail.gmail.com>
Subject: Re: [v6.12] WARNING: at kernel/sched/deadline.c:1995
 enqueue_dl_entity (task blocked for more than 28262 seconds)
To: Peter Zijlstra <peterz@infradead.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, Ilya Maximets <i.maximets@ovn.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, vineethrp@google.com, 
	shraash@google.com, marcel.ziswiler@codethink.co.uk
Content-Type: text/plain; charset="UTF-8"

> > >
> > > Which then also goes *bang*. The above can't happen if we clear
> > > current->dl_server in dl_stop_server().
> > >
> > I also thought this could be a possibility but the previous deactivate
> > for this task would have cleared the dl_server no?
>
> That gets cleared in put_prev_set_next_task(), which gets called *after*
> pick_next_task() completes. So until that time, current will have
> dl_server set.
>
Ahh ok that makes sense.

> > Soon after this in
> > update_curr() we again call dl_server_update if p_.dl_server !=
> > rq->fair_server and this is also another possibility of a double
> > enqueue.
>
> Right, there's few possible paths there, I've not fully mapped them. But
> I think clearing ->dl_server in dl_server_stop() is the cleanest option
> for this.
>
Even clearing would not help here as it will still make this condition
true (NULL != &rq->fair_server). Now that we have the dl_active flag,
we should probably check dl_se->dl_active before doing the
dl_server_update.

Thanks,
Vineeth

