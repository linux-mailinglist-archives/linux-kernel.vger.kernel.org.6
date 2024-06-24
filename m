Return-Path: <linux-kernel+bounces-227795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F34259156A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E93BB227FA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1413722615;
	Mon, 24 Jun 2024 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AgRw6n+z"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CD0225D9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719254923; cv=none; b=EU7lY3wgkvUuF0x2USN9aRRW4414iNHHnxU36b5LVu1jqz3W7VppWdQFZNoHw4c3LApAowe5shFxKhpxy6bSOcSaPG62d/84BNIYgaClbOqFHA1KHOTKEWJQ6Q3x+wBtll+hsGFyFLmuCflcyxOErqnd8P1IU1rA7USVh6gT7gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719254923; c=relaxed/simple;
	bh=TBWTE0DFqAnUn1NOKc+liqONRpFyWiUqipzt2mx8Gdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3ndMPBfd9g3rqLcDkqjrXcEk+NPf+QSwvmzQVBNptNZs7wCghILCHjl579qLKZAhb9rlMYPOFYRrmK8ArrJIViwvuGudrsnl2XQ6GR3q/E2QSNw8PHPpQvz8KZhCvBJuT+AYkjXJB1UZcD64VGq2UosmG3B30quQKBqqj3utJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AgRw6n+z; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57d119fddd9so1765a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719254920; x=1719859720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBWTE0DFqAnUn1NOKc+liqONRpFyWiUqipzt2mx8Gdk=;
        b=AgRw6n+z1WuPnNoNKNcaKtlO0hakFwlg7JVP73YH+tjK7TUNSvrnQU52O4h/uWCEB5
         Fb9YikJM/6Wr/33wr5t07HCaRLBv4P/0CfBX/Cs71QnV2b84CQ3OCSZhXv4D3xIZoj2D
         1XCibVLcxzNeVmo+Nmj460kCTyTLVvySklpKdXUp/P7GOYlFxsIzRFdR5RshoxVsEPsH
         Ad9MuIgeDke5ela/nCRyOiHgV62o6KK8Hb7+3IIFrg6vmlw4RiK1SP2b/q7tc2JG1qg/
         3pB2Dpny0jrnCjJNDyDREPk44mT5rrAPpJ6nNrt1LcbTfF2Y4ziji8CgbhA9S7MNKi0+
         ojDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719254920; x=1719859720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBWTE0DFqAnUn1NOKc+liqONRpFyWiUqipzt2mx8Gdk=;
        b=gWZ+VKhUO5xUJENc9Mn0S05kE9z7HLOAF4v2E4gpEz7UQrF7dPaZfRHEHx6+GNpJb/
         GhAiWThf/OTfmzQKrKcyYsD0sarI2am7KbMSTXHmB9AWw9zXeEjLbqIQfThw659wvZ6l
         XedcQZiFCOCrbKzjO4lLOjBAPREjhSHBAF58vkWav/TmQY8KCuCTV2E+jB8cgRwnWRoX
         dX24o4XXw6M4bId0Uq4xVaqX+mYyMjLGb0RMU9TOWTmpzffwwAGG2DHXTUS19vXyPj3x
         BcYUwC4/QYlx1Sijhpw5xEF48C5dGXk+aqJnlL4IVHTLgktS1n/hnRgzElr8IJzwIU3P
         z4pg==
X-Forwarded-Encrypted: i=1; AJvYcCV6vxqk+/jrJgw5z6olUVpnVOL4U/9+OeSq9fb0yNueSvVwfapBGh2/nFqv6KNCV3CkaharC8lF/vnx3LFxYcdcCxXLW2OtGTlruo0E
X-Gm-Message-State: AOJu0Yww7rQiCRUjw00eP40i/eWWcb292pkiwCptIo0mSX9m/Qr11kIN
	vvid5jcECp2KokKHHEKdx96wY7AQ6eZ7S8gjuBOdL74NiAO0asqOquis3ONoX/31eCA4BN70k3d
	2mh9r89JYCDxfH5bzqdrTqsSBcin6s0nnQXWc
X-Google-Smtp-Source: AGHT+IGUsDFPtHJ+mh22laSrDlDc6wo++qSX9UUURM/Lrz8/o5PeL576MP1+SWkFuLAdA3ptGpZbk/C/O36Q/uBN9nk=
X-Received: by 2002:a05:6402:27d1:b0:57c:cfa9:837b with SMTP id
 4fb4d7f45d1cf-57dbc5439b2mr28062a12.0.1719254919965; Mon, 24 Jun 2024
 11:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620214450.316280-1-joshdon@google.com> <CAKfTPtDDSzLi7PEJkBqepx9cRgmbBKy2ZXJuT0h62e3RkQBoYw@mail.gmail.com>
In-Reply-To: <CAKfTPtDDSzLi7PEJkBqepx9cRgmbBKy2ZXJuT0h62e3RkQBoYw@mail.gmail.com>
From: Josh Don <joshdon@google.com>
Date: Mon, 24 Jun 2024 11:48:28 -0700
Message-ID: <CABk29Nts22FySj_hrX2hnSCLvs4eSuPA69WrOW_RbVG6RA6FwA@mail.gmail.com>
Subject: Re: [PATCH] Revert "sched/fair: Make sure to try to detach at least
 one movable task"
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 2:19=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Thu, 20 Jun 2024 at 23:45, Josh Don <joshdon@google.com> wrote:
> >
> > This reverts commit b0defa7ae03ecf91b8bfd10ede430cff12fcbd06.
> >
> > b0defa7ae03ec changed the load balancing logic to ignore env.max_loop i=
f
> > all tasks examined to that point were pinned. The goal of the patch was
> > to make it more likely to be able to detach a task buried in a long lis=
t
> > of pinned tasks. However, this has the unfortunate side effect of
> > creating an O(n) iteration in detach_tasks(), as we now must fully
> > iterate every task on a cpu if all or most are pinned. Since this load
> > balance code is done with rq lock held, and often in softirq context, i=
t
> > is very easy to trigger hard lockups. We observed such hard lockups wit=
h
> > a user who affined O(10k) threads to a single cpu.
> >
> > When I discussed this with Vincent he initially suggested that we keep
> > the limit on the number of tasks to detach, but increase the number of
> > tasks we can search. However, after some back and forth on the mailing
> > list, he recommended we instead revert the original patch, as it seems
> > likely no one was actually getting hit by the original issue.
> >
>
> Maybe add a
> Fixes: b0defa7ae03e ("sched/fair: Make sure to try to detach at least
> one movable task")

Ack

>
> > Signed-off-by: Josh Don <joshdon@google.com>
>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks Vincent!

