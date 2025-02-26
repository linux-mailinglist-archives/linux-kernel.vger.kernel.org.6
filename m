Return-Path: <linux-kernel+bounces-534667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EE2A469C0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7DB1884E82
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C67A235BF5;
	Wed, 26 Feb 2025 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OO1aq1wo"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D27C2356C5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594458; cv=none; b=qC3tC+TaNgzz+cU/x7w+7xt2gSOwddTEOU41+fuKCv54iWDARccRivM0C3wZAE6xSg6cgvJEB3W93eneHbXMl906suwx/TmO88c9QinIwzmssBbAC/bmYDiP0JqB5vTNXXfLe0asO+DXxDX0nssKWlnbswa2BJh4L3xpOADpAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594458; c=relaxed/simple;
	bh=mDtSh+HotHwurwAnAYMDhlSrEAza9DEiUdKcOW4Tofc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFnFz0gi0GnhMQA3FMZRozdnR0AIncSVxfzThFeCzujEf4jE8mvkULBOk7P44gIPxL+MM+87DjVzkmAFAMQ12H3zdfFhAzBKMHnORux6nxZgmSyvS86+wUyu3LuuU87cb98PkDWNMMtNECP/d++UvZL6rrwLHA1H1zXC12pptvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OO1aq1wo; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e0573a84fcso5565a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740594455; x=1741199255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbGtNrkjyYgBwz5N4tw3xyPtem5v0qKByNJMW7ySY+w=;
        b=OO1aq1wopHfDM+lD8qGRFMqeZJ2sGH1q7obXwZno7UsWLKg5uHHPVSz3z0PhSdrokS
         Q+zU8R5DI45MB6sMckzr4pHmiXeFBPmeKD+Z8xcdBzXN190zFJ27BxW1e402nZThBWhb
         G1PZ0X0JbCVJSiq/p9xpPvLBxDOog7QQjXrt78NdCVfVx1ZBfMja76wuDdaKuJiuQqSJ
         03LQ+U7wpHoTcHrX8HHHcczS3tjNCbfpaGGPRTwB3avKZEtBSxPMGrNUdG0Mb0HBrUPX
         854L9Oiht+eVvPz17+oerc/NoIfbRy9WQwziL+JG/4Pm+qMMYrHui5qoc8RuVoYuGCC9
         Qo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740594455; x=1741199255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbGtNrkjyYgBwz5N4tw3xyPtem5v0qKByNJMW7ySY+w=;
        b=ZTAmduyc0ljd6ijKBg4nORIDe34O+oErghHC9XqTnnavoCQHXSEOLhIjr53dUEjRUm
         D8gaXSo4ESX49hDTDZ7CE7cFdNiUgBbjLJaiw3IG6CefLy9j/vr9o3Db/w0mSXliizHW
         4bl5yPij7ASYJmBKqic+PRGFLIwIyxtVe1m5TczoZmvGEJlJBAemY20RXAnSWa/ouw7t
         5V/7AsU6qBTnOhUKo4ZOp9wEg58djOArtyGM8TvzlbZtwPvqE6wBQuTf2/aHmsj/OO2V
         3AZe1P2Kr0JiloaarHW/xhBQH8YgHzQ98bdtz7gB+PBHWXiqvGRBkfE/fcChfttdfIK0
         bDWg==
X-Forwarded-Encrypted: i=1; AJvYcCULphxQrZDoQvNLUM5P9u57ok10EtbMpKGD3HJQJcju6qQWh0AFTQdE/U/XCELOYmRZONNuyjONfavMsPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Wzo1ncoJdN+oxTZkFj3rAmxZG640A455wiOP085opmmBteT/
	qT8ROEqM232Ozy0auL8IrPU+4wwpcCbNM+LbyoscQwWKNlY9sBuxNDjT5Gl1kc6bHpQac5AjyHj
	V4BFHRVPOV+YGFURq5n59CIAUiqEFBfLDc7e/
X-Gm-Gg: ASbGncu5Unyvi+35pxXjY/tXisCi3y8K8f4EL8WaTXBZ6gJqV/8CTMYigqLw+dRMoUS
	q79/qtCDZ/gCGVQu3b0fWwtnesvja7nWzO///7MLUwuo/Isb4MdjU8z5sbIkBRH1r6wn5LPtDt4
	ZW3LOfaoc=
X-Google-Smtp-Source: AGHT+IFZBOT6NZJ9lqdYQz9B0TtJE7SWPmI7w9k6cI2+KrhsOlofGrsGYOh36W2Hth5j++vVYOH1PeRrrnRFKS92TvY=
X-Received: by 2002:a05:6402:26d1:b0:5d4:4143:c06c with SMTP id
 4fb4d7f45d1cf-5e0b7222d3amr22842943a12.23.1740594455410; Wed, 26 Feb 2025
 10:27:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
 <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
 <559f3da9-4b3d-41c2-bf44-18329f76e937@kernel.org> <20250226-cunning-innocent-degu-d6c2fe@leitao>
 <7e148fd2-b4b7-49a1-958f-4b0838571245@kernel.org> <20250226-daft-inchworm-of-love-3a98c2@leitao>
In-Reply-To: <20250226-daft-inchworm-of-love-3a98c2@leitao>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 19:27:23 +0100
X-Gm-Features: AQ5f1JpnOes8jn9vTB8ptmBjvNQ7ShU9fUjTVWe0lA4VmH95ahg0G8P5C9WLQq8
Message-ID: <CANn89iKwO6yiBS_AtcR-ymBaA83uLh8sCh6znWE__+a-tC=qhQ@mail.gmail.com>
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
To: Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 7:18=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Hello David,
>
> On Wed, Feb 26, 2025 at 10:12:08AM -0700, David Ahern wrote:
> > On 2/26/25 9:10 AM, Breno Leitao wrote:
> > >> Also, if a tracepoint is added, inside of tcp_sendmsg_locked would c=
over
> > >> more use cases (see kernel references to it).
> > >
> > > Agree, this seems to provide more useful information
> > >
> > >> We have a patch for a couple years now with a tracepoint inside the
> > >
> > > Sorry, where do you have this patch? is it downstream?
> >
> > company tree. Attached. Where to put tracepoints and what arguments to
> > supply so that it is beneficial to multiple users is always a touchy
> > subject :-)
>
> Thanks. I would like to state that this would be useful for Meta as
> well.
>
> Right now, we (Meta) are using nasty `noinline` attribute in
> tcp_sendmsg() in order to make the API stable, and this tracepoint would
> solve this problem avoiding the `noinline` hack. So, at least two type
> of users would benefit from it.
>
> > so I have not tried to push the patch out. sock arg should
> > be added to it for example.
>
> True, if it becomes a tracepoint instead of a rawtracepoint, the sock
> arg might be useful.
>
> How would you recommend me proceeding in this case?

In 2022, Menglong Dong added __fix_address

Then later , Yafang Shao  added noinline_for_tracing .

Would one of them be sufficient ?

