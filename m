Return-Path: <linux-kernel+bounces-435360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C379E768B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CD91664CD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FAD1F3D5F;
	Fri,  6 Dec 2024 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="QWfK/CHQ"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2971F3D30
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504265; cv=none; b=fhdlHz++PMwG52EigaWJZVDVYUfjukWlbmfngQXpiB6U1HkqCKuLc6jtRxIHazG7BOIeW0oX9Lt/Dq8wJh30lW71TZuAagiTuLOiDaYi5kV4Ec7BSLwej194W5yFHJZIfZ2RoM9sMW5XyYTjXkYd/YDbh+++5Vck/n+R7o56HoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504265; c=relaxed/simple;
	bh=E6QwZKG0YjJB+ofGtSJYqsI0+qdZKAAHJViVA7qt6xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLBJM7NEp3sC3if3jEy6oihYeitDE3QHf5mKBmLNBSxDdqOQNnxAfK65oV7ztjJbwh4jLZWbz4puXNba6ZC8AQC6Xsi6qjWPGoNP5QWkd2kocwrzSkaRI1pYDbUuWrbYs0vEWyj6mZIYzaWjzXFq58ajQHgb9hGC+08N2PPm480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=QWfK/CHQ; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ef524fda21so22787187b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 08:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1733504261; x=1734109061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW72hRv7mXpJHZEInqGilZ7ceKeJDRwUn2BGFVSq0ok=;
        b=QWfK/CHQeMzqPUO4cwUm4/ioesBKDpPe3rGmUdZvmyI6Os0TSwYXf+1u/+koihscv7
         4ugpZMWf57kAU/8AjvQW8uSNMwL3gz+u1bO0sMSBWywZ4nSWiovazYqgZz0co+tixRjR
         VkBnTYBjm4qJZUVXtmeAN0vadizCVt9o/HiTPiu0x89ClyW6vkwZkJj5R9BFJrRARulm
         /+BKvXzQuLxdgERLugZMSpVM/jL+Fb48ZKQgvfUhS57+Kn+n/EikjpVk1A1sHmIaHqXM
         cwtktJc6m3q22h2uD+WW+d5Tjn1lRaShAdoEx7YBcJDKmnO6OecMnoh7HhIHG5aQHVT5
         cuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733504261; x=1734109061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JW72hRv7mXpJHZEInqGilZ7ceKeJDRwUn2BGFVSq0ok=;
        b=m8gL8nNyRTVIddKCUugc7rCvGX7/FjyE3lgOQJGmNCoYdCCtS8op1gOTWZqa7dX5eF
         2pPPyQBlItN+6KLjfgtd4nq3QWFBRpYmFVA6bKlDyITH8xi3MwbnTI5umdzDMm/S6neS
         rFnUuju06D2kWjjEZ/pcYFwLzIC8SWkrPkYYgRDQgEp+FUNo9PRIDSUc6yJpontj5KcN
         6jyNjtLi5VFj24ZdN6awKZjDBlzVLpaLCbpZHEJpYUMbRUdrG5nTn1VxWikrYW/PBVe9
         2OJwNBavWpDS4BHaPC2LGSfpCcbCrDwCIjropjqlZB5NspDCu+CbkktzZsYzhbhqZu7F
         naaw==
X-Forwarded-Encrypted: i=1; AJvYcCXfkW/kl8BxswXpI0Bfsof6WLY3owYQrCynUQPzS/TPsKTfhuoSMYGXr3dKiNS/DxIoLrVXMe/rWX6Zlww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz28dunvk1nCWfLEfhj/KlaKVPqGDp01wlwVDskOBtWD/3ztROu
	vcsBH21xYgyLZpyx+fxoMcUwPfhfgfKTlpzlOnueIk6u/eidFyrXZmanjNdUY47C7C29Kc6Zh0y
	v16TJFezWE/x7z8b/wVWLrjz/FghBHYO5kkT6Mg==
X-Gm-Gg: ASbGnctv1Kblhkw/ad0eIXTCcHGAwJ3On8t5tc5VN8hpfb7oVSsVbVCJFnXZhEP5FS+
	N5qPSnHonfTdo5QVNB2O/Ug46ciY3WX4=
X-Google-Smtp-Source: AGHT+IEUeA0ff0dxVTDovehLioBGuQ2FGaIBS0liXo2qsXQHMXTMHMmslflWNxaxc9ICALN9Liue0xXyczTtZL8BSjM=
X-Received: by 2002:a05:690c:48c4:b0:6ef:a9da:f4b3 with SMTP id
 00721157ae682-6efe3c8aba3mr46198477b3.39.1733504261037; Fri, 06 Dec 2024
 08:57:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <571b2045-320d-4ac2-95db-1423d0277613@ovn.org> <20241206151819.GA3949140@google.com>
In-Reply-To: <20241206151819.GA3949140@google.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Fri, 6 Dec 2024 11:57:30 -0500
Message-ID: <CAO7JXPhdv+Jx_UpAq=-aG-BKwiyjZ2kvuZDM4+GLjbya_=ZJsw@mail.gmail.com>
Subject: Re: [v6.12] WARNING: at kernel/sched/deadline.c:1995
 enqueue_dl_entity (task blocked for more than 28262 seconds)
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Ilya Maximets <i.maximets@ovn.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, vineethrp@google.com, 
	shraash@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 10:18=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> On Wed, Dec 04, 2024 at 01:47:44PM +0100, Ilya Maximets wrote:
> > Hi.  It seems like I'm hitting some bug in the scheduler.
> >
> > I'm running some tests with Open vSwitch on v6.12 kernel and some time
> > 5 to 8 hours down the line I'm getting task blocked splats and I also
> > have a WARNING triggered in the scheduler code right before that:
> >
> > Dec  3 22:19:55 kernel: WARNING: CPU: 27 PID: 3391271 at kernel/sched/d=
eadline.c:1995 enqueue_dl_entity
> >
> > I have a lot of processes (kernel threads and userpsace threads) stuck
> > in DN, Ds, D+ and D states.  It feels like IO tasks are being scheduled=
,
> > but scheduler never picks them up or they are not being scheduled at al=
l
> > for whatever reason, and threads waiting on these tasks are stuck.
> >
> > Dec  3 22:22:45 kernel: INFO: task khugepaged:330 blocked for more than=
 122 seconds.
> > Dec  3 22:22:45 kernel: INFO: task ovs-monitor-ips:3479822 blocked for =
more than 122 seconds.
> > Dec  3 22:22:45 kernel: INFO: task mv:3483072 blocked for more than 122=
 seconds.
> > Dec  3 22:24:48 kernel: INFO: task khugepaged:330 blocked for more than=
 245 seconds.
> > Dec  3 22:24:48 kernel: INFO: task ovs-monitor-ips:3479822 blocked for =
more than 245 seconds.
> > Dec  3 22:24:48 kernel: INFO: task ovs-monitor-ips:3480383 blocked for =
more than 122 seconds.
> > Dec  3 22:24:48 kernel: INFO: task ovs-monitor-ips:3481787 blocked for =
more than 122 seconds.
> > Dec  3 22:24:48 kernel: INFO: task ovs-monitor-ips:3482631 blocked for =
more than 122 seconds.
> > Dec  3 22:24:48 kernel: INFO: task mv:3483072 blocked for more than 245=
 seconds.
> > Dec  3 22:26:51 kernel: INFO: task khugepaged:330 blocked for more than=
 368 seconds.
> > ...
> > Dec  4 06:11:45 kernel: INFO: task khugepaged:330 blocked for more than=
 28262 seconds.
> >
> > I have two separate instances where this behavior is reproduced.  One i=
s mostly
> > around file systems, the other was more severe as multiple kernel threa=
ds got
> > stuck in netlink code.  The traces do not have much in common, except t=
hat most
> > of blocked tasks are in scheduling.  The system is also idle, nothing i=
s really
> > running.  Some of these tasks are holding resources that make other tas=
ks to
> > block on those resources as well.
> >
> > I seem to be able to reproduce the issue, but it takes 5-8 hours to do =
so.
> >
>
> CC'ing a few more from my team as well.
>
> We haven't seen such an issue with the DL server, but we are also testing=
 on
> slightly older kernels.
>
> Its coming from:
>         WARN_ON_ONCE(on_dl_rq(dl_se));
>

Thanks for including me Joel :-)

I was able to reproduce this WARN_ON couple of days back with
syzkaller. dlserver's dl_se gets enqueued during a update_curr while
the dlserver is stopped. And subsequent dlserver start will cause a
double enqueue. On the peripheral, we don't track where dlserver is
active or not directly and an explicit tracking could solve this
issue. But the root cause is a little more deep and I think I
understood the real cause. I have a potential fix and doing more
testing to verify. Will send the fix out soon after a bit more
verification


Thanks,
Vineeth

