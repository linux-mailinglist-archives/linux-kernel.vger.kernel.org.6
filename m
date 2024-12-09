Return-Path: <linux-kernel+bounces-437489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B1B9E9400
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E758D18874E3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DB52248BF;
	Mon,  9 Dec 2024 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="B8i7V//7"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D918F22371C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747406; cv=none; b=B0qEu9QSEM37I2TT67W7qtaPYwSpnP+WX4dyddSndQMyLx2bQlKtKMn4ky6M8GQ3ghCnZmFwOLm5rN7EHNvPlYUf37xpS2lm4BD9uolnjADuBIxf83aRSBsyo4vpdg9CciZvwBOpk/PiKU4LALxfLjZ/WedCXBrUtzazvlxfsEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747406; c=relaxed/simple;
	bh=wIVxmYGBvBpq++kLbxbwLd240k3rLusqWrJmUJqrEkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4r2TdwMl/NKqHpuu5/A43nE4I/0GstAz3XJ16etL0TwPMLv8b8HeQPYfjpsHaCaYSGiwAAks7kLJTQ6mgLfo4s00syim8fEp31mdYW3vS9Z1b361v9bgcUruvbdAmhg7RaUYz8B/dAiqjgFO3gNoPx89WhhOx/6Ymc8xp9pHNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=B8i7V//7; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ef66fd2183so38398317b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1733747402; x=1734352202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afzGvHIxUQuobSoWANXyOzSRFkePjvUX0nCz0uF3j80=;
        b=B8i7V//7XWRlMBHawvJtKCusaHQbcq0L8bDUnVAYxAcY6tp2dXGJCw7xuDsJ6Mi/9x
         grDGWruC0T4Sn6tYXY0oDGCdhSgCvegSeJHd8MuHIYwiuomykakUR8Er8GALXCkw7qA7
         3CRtyyYnIpAzroY8j9+ZsWChbUD47TKLhmzJGF4opdi/bYxAH5MORhhzIzKWM7Q0M9Ip
         bxs1Qd7ZexCuxTglryZP6NN4N2oKHUWMMPL86I+fJJhippU13VD+sansB1bvGseInsS1
         UkykYWXfnmxzLDqv67fjAO9cy+VNnFD5/z6AT9D3ND2TiDnPkBP3aURV13Gq0p9Gpclk
         CcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733747402; x=1734352202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afzGvHIxUQuobSoWANXyOzSRFkePjvUX0nCz0uF3j80=;
        b=onN3Ibz5nwA42/poO2tU+Z6+xBX8gwecqm+IKT+kccidIqnUkk+ZlQpfApxCvdSqOR
         X3dvk3tqTvlFpsqKh1nPz0Oy+pkB96NfFyEqJ5QXkHhbanN4MeZrU+sqyp48t7LmRNft
         bCdU5E8yhaM+IOv6jqxa/U7OJtH1/iKHURdHLzzMQ5Ep75XA6khvJqtNBLYl1+HUNhNN
         Srf9XChCI39lOJmSb8kWJwLKvBF7xmutvFvnf2HvIolb+zl9ZREp8q/cxVLGFCOnNmr+
         Ar0X9xsP9luWLtNiqfBCRFbCVtayCQGReNh2jIdhgNsQcAeJhFUzkmTQS8OIR9nQuvTP
         dzOw==
X-Forwarded-Encrypted: i=1; AJvYcCWEJwyay2ZWDWfwPp38PEes0nPunauHsN7v3vGW/drowhi1ezKAyWM48KQHNJcQQ2Y432e+wJelfQai8JM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNaMvcsdF7HbVrIYcdSMsVfknnNGG69pkx1Ktbxv3UB243k6ef
	nRk5Qfv5OXDDVzRpcT6JpHRKJGprX1wdKDaOYn1DT7y/B4tQOMfuPQpYfqq8njCXU4R+nfCC4gf
	3bX0gmkpE1XMChEtzpkxsgQAoJIZo6pKnTv40Uw==
X-Gm-Gg: ASbGncvfEzmKFbCwERlsfP76fgcphZz918zXgnEHqTzLLuQUXzlpp940Bb9hPycc/jL
	cKkxWGCeIfHi5xlIO3JkASOPK2yynmlQ=
X-Google-Smtp-Source: AGHT+IFK2kor0YOQCZPsisXWAwOCpMyGrTTnqwekLQzUl9ojJ7Mz9Nre+9tY2VXdOFIr9DCRCnuMwtYPOMMrK8bCTDI=
X-Received: by 2002:a05:690c:62c8:b0:6ef:698a:1f02 with SMTP id
 00721157ae682-6efe3c6f6a9mr131375897b3.32.1733747402650; Mon, 09 Dec 2024
 04:30:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <571b2045-320d-4ac2-95db-1423d0277613@ovn.org> <20241206151819.GA3949140@google.com>
 <CAO7JXPhdv+Jx_UpAq=-aG-BKwiyjZ2kvuZDM4+GLjbya_=ZJsw@mail.gmail.com> <20241209105514.GK21636@noisy.programming.kicks-ass.net>
In-Reply-To: <20241209105514.GK21636@noisy.programming.kicks-ass.net>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Mon, 9 Dec 2024 07:29:52 -0500
Message-ID: <CAO7JXPgSYCzu0mtnWqBaS8ihmoQXX3WE_Yb_rEYuMeQn+B6KJg@mail.gmail.com>
Subject: Re: [v6.12] WARNING: at kernel/sched/deadline.c:1995
 enqueue_dl_entity (task blocked for more than 28262 seconds)
To: Peter Zijlstra <peterz@infradead.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, Ilya Maximets <i.maximets@ovn.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, vineethrp@google.com, 
	shraash@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 5:55=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Fri, Dec 06, 2024 at 11:57:30AM -0500, Vineeth Remanan Pillai wrote:
>
> > I was able to reproduce this WARN_ON couple of days back with
> > syzkaller. dlserver's dl_se gets enqueued during a update_curr while
> > the dlserver is stopped. And subsequent dlserver start will cause a
> > double enqueue.
>
> Right, I spotted that hole late last week. There is this thread:
>
>   https://lore.kernel.org/all/20241209094941.GF21636@noisy.programming.ki=
cks-ass.net/T/#u
>
> Where I just added this thunk:
>
>   @@ -1674,6 +1679,12 @@ void dl_server_start(struct sched_dl_entity *dl_=
se)
>
>  void dl_server_stop(struct sched_dl_entity *dl_se)
>  {
> +       if (current->dl_server =3D=3D dl_se) {
> +               struct rq *rq =3D rq_of_dl_se(dl_se);
> +               trace_printk("stop fair server %d\n", cpu_of(rq));
> +               current->dl_server =3D NULL;
> +       }
> +
>         if (!dl_se->dl_runtime)
>                 return;
>
> Which was my attempt at plugging said hole. But since I do not have
> means of reproduction, I'm not at all sure it is sufficient :/
>
I think I was able to get to the root cause last week. So the issue
seems to be that dlserver is stopped in the pick_task path of dlserver
itself when the sched_delayed is set:
__pick_next_task
=3D> pick_task_dl -> server_pick_task
     =3D> pick_task_fair
          =3D> pick_next_entity (if (sched_delayed))
               =3D> dequeue_entities
                     =3D> dl_server_stop

Now server_pick_task returns NULL and then we set dl_yielded and call
update_curr_dl_se. But dl_se is already dequeued and now the code is
confused and it does all sorts of things including setting a timer to
enqueue it back. This ultimately leads to double enqueue when dlserver
is started next time(based on timing of dl_server_start)

I think we should not call update_curr_dl_se when the dlserver is
dequeued. Based on this I have a small patch and it seems to solve the
issue:

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d9d5a702f1a6..a9f3f020e421 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2419,12 +2419,18 @@ static struct task_struct *__pick_task_dl(struct rq=
 *rq)

        if (dl_server(dl_se)) {
                p =3D dl_se->server_pick_task(dl_se);
-               if (!p) {
+               if (p) {
+                       rq->dl_server =3D dl_se;
+               } else if (WARN_ON_ONCE(on_dl_rq(dl_se))) {
+                       /*
+                        * If server_pick_task returns NULL and dlserver is
+                        * enqueued, we have a problem. Lets yield and do a
+                        * pick again.
+                        */
                        dl_se->dl_yielded =3D 1;
                        update_curr_dl_se(rq, dl_se, 0);
                        goto again;
                }
-               rq->dl_server =3D dl_se;
        } else {
                p =3D dl_task_of(dl_se);
        }

I can send a formal patch if this looks okay to you all..

Thanks,
Vineeth

