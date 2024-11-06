Return-Path: <linux-kernel+bounces-397914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AB39BE253
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03CE1F22389
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08ED1D9663;
	Wed,  6 Nov 2024 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhPbZSk6"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B2A1D9591
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884974; cv=none; b=kjRplNbWWzIHRCOVzF01Gu0vVdBkgKr7V1BX3lwoFp2x/gSsWA9DAD1hIwsY1baJjUmppIIR0VK8qrNVwcCJ9xXkN0EvXJ7BibjicXq5Ae8r0FMsIepkSpIcksjg2f2gIhAr/Hdx5BPbxkszmGlDaCFroRixEztayfj17zOF6hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884974; c=relaxed/simple;
	bh=j1zaLifxSHG9dqHGVi3lzDCXh1QBtGfWizelzPv1KKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBWfz3uta8/QOsc7HF4Kh3hc2lm/9ZbPIAM57egM07fr1aCIZFPYxUrJjZHq72aDVQKrid/TG5buvTav/jfIactPwvAbhIw0TLXYL/cc266sSjjUOu6ju8X7Fk3xH0HTHPxsy5VTExBaIebKqJGy8IZOqMDAY1mi//S7HTzkSSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JhPbZSk6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7206304f93aso6117677b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 01:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730884972; x=1731489772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j1zaLifxSHG9dqHGVi3lzDCXh1QBtGfWizelzPv1KKI=;
        b=JhPbZSk6lltoIR5+KhKUlzcp3z9QFyaSlcWg43U/lZW9BUz9Xd/5ahyUPvSl0jtJV/
         V0ZDFJ8/CTco7Ovc6KOYtTiCqtG7Kf6xRR5kqr/2ETzNlahoOT+5Jrl/JAmJk37tj7Tn
         M4/FvSSypMocKpZV3UlPDbBuwCpGrrgFoteDTSkabDzJxn1Z6EVDror8UNBfwYw3kRDm
         RZ2r/9eNWaDsQxqtathAodfIgX0Hma4+l1dJoHzY2+jS5VY595JMI6FIYOzJhub4Xr05
         HYAr1ihww7j5m9wnnrTpaPPwGEk4WA10fZ3xMwcd9xN/+W5NVyjkXIUZ6JUNVXWtUcYn
         N6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730884972; x=1731489772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1zaLifxSHG9dqHGVi3lzDCXh1QBtGfWizelzPv1KKI=;
        b=RBZo1q867ljuvNWheXCP8Jvt9oPA6pI50x3tDxivIczMnK87PkjRPIUy7wiZmE8ckZ
         +So0W5qyvkerMTM/PgHv9pMePJK+JbZdWLQL9IovheIFXoLrqksQK0tr7FOj5eGjXX85
         tyZeoLkRRyUM1BMxChlhjRPo+iJNOnFkfGG/XYkXf75WcBL0lzycljAUk7hai0DcMypz
         gBj77+0SJjodSyhgVGkwtz67h5RAY+u4qf2dz3uzoie3vwwfbSb5lnU6mIhoFpqNuvQi
         sb/fqY91kli5H3L6m+BDxEN+hDOvTlaM9s/Ac6hapGveJ3nCy3ysjGXff8LA6tbQtmZg
         ybvw==
X-Forwarded-Encrypted: i=1; AJvYcCVMPr3W90EuXs+w+4LVOktSI4/gTLDcGMENgwSzL+1kSouT94c7lDtwddexn7635maSWZPIBlWGb0LTEZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzek9cqY6cwg102YJ7jQ52swpLOk36Zjel8pU8b4+Ce9D+chEeA
	qq0Sne6WrCMVFXZXaIGgmBOQQpyBkvOwP4IgqxMPP6+PiATndPi+Da1ISirVueI4E/NtfEHr1oU
	viKhEzExmx0NBvpW+HOq2irQyccq/RgJ3Lvn8
X-Google-Smtp-Source: AGHT+IHRgtOhdgUbzWm0hZmkvVPChJprngFowTe1zYH5hqiS5CqLKtCX4OnBjrenvIga2sRIn4q/sgidGoyGU7DNzxY=
X-Received: by 2002:a05:6a20:d48e:b0:1d9:26b7:6ca with SMTP id
 adf61e73a8af0-1dba556fbfemr27874210637.45.1730884971969; Wed, 06 Nov 2024
 01:22:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133610.1937089-1-elver@google.com> <20241105113111.76c46806@gandalf.local.home>
 <CANpmjNMuTdLDMmSeJkHmGjr59OtMEsf4+Emkr8hWD++XjQpSpg@mail.gmail.com>
 <20241105120247.596a0dc9@gandalf.local.home> <CANpmjNNTcrk7KtsQAdGVPmcOkiy446VmD-Y=YqxoUx+twTiOwA@mail.gmail.com>
In-Reply-To: <CANpmjNNTcrk7KtsQAdGVPmcOkiy446VmD-Y=YqxoUx+twTiOwA@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Wed, 6 Nov 2024 10:22:15 +0100
Message-ID: <CANpmjNP+CFijZ-nhwSR_sdxNDTjfRfyQ5c5wLE=fqN=nhL8FEA@mail.gmail.com>
Subject: Re: [PATCH] tracing: Add task_prctl_unknown tracepoint
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Nov 2024 at 18:22, Marco Elver <elver@google.com> wrote:
...
> > > > I'm also surprised that the comm didn't show in the trace_pipe.
> > >
> > > Any config options or tweaks needed to get it to show more reliably?
> > >
> > > > I've
> > > > updated the code so that it should usually find it. But saving it here may
> > > > not be a big deal.
> >
> > How did you start it? Because it appears reliable for me.
>
> Very normally from bash. Maybe my env is broken in other ways, I'll
> dig a little.

Some trial and error led me to conclude it's a race between the logic
looking up the comm and the process exiting: If the test program exits
soon after the traced event, it doesn't print the comm. Adding a
generous usleep() before it exits reliably prints the comm.

