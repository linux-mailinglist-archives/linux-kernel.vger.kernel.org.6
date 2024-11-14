Return-Path: <linux-kernel+bounces-408758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 287369C8339
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FE19B249BE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EA41EBA0E;
	Thu, 14 Nov 2024 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zRGiLJt8"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4160470818
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731566233; cv=none; b=GlGaSVw3BFTyTG3rGHcI+bN1pUWnq6BC7VVr8rsFo9pxa5TypI85eQmgRDRJ9VrYj+OR4Te0Cq8LhCtJelA4PVJYskpzUJTmGT2+s4F0rhbmVwm9OdrMs4OJGNKhf9ZHog/bhbg63mmX2KAb8dtYhRhhOEy1yjFbw43NiQSiZso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731566233; c=relaxed/simple;
	bh=G4C2QDgvxEG64dJJj33+Io1cMrd3LUvrHs3SoSeluYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hB4xydQ/JfVQg1Z4E29xE2dC20moKHP8XwghI54LHwYoUxt+0N/c+GqXjy5EydyfM+Zphqi0uyXZKnve7bW8utJMSAm/4u18TkK46KXJbErLSVipQDk6brKSordoHfkwnLV3iPMDIpQeOIky2fo/Xl8vpfG2qGHDIWaHY321Tms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zRGiLJt8; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7f46d5d1ad5so164408a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 22:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731566231; x=1732171031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4C2QDgvxEG64dJJj33+Io1cMrd3LUvrHs3SoSeluYo=;
        b=zRGiLJt8nQcOphF/bxsl+HuvO0/+IykTuCVRcMnM6yciU90ZzKFs8nwLjCAOxnVJpE
         xf5YB4TaEy5pys7Q3KE8mtA8rkC/baQxAYNgbjGecWSCtDZ9ecDVB2Vpz8yWURa2KBJk
         6cL3bxlR83TJ3DaHtZaIv2cCprZFV2eVwsMLN0xoqWbnmwS3i9f6GZPPts8yOwNyBc0a
         DUmn2ebQv14WK2LH+2ABCAh83psZu8PizxS85pYzVjq3ngdNROMRZLRCJiKAn8NxVn88
         CMVBREgy2iNj67NlINQRSmYOF6y2+ROQsTuKSWeFJcibRzkqT9H947wKH0Jq+9y3oKVG
         pCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731566231; x=1732171031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4C2QDgvxEG64dJJj33+Io1cMrd3LUvrHs3SoSeluYo=;
        b=jVlIfnWoT+93GZAO+GQjfxmhQ5Sr8Lp+niJf6ztYyng6W2MmikN5I4WQoVHBi0gcPG
         VWfZVEvbYszX+vWTwNGJ9qHC4bdIvfNYZEGWluobJP65GbRJ+h3PYLQ7OLyB+JHXHERL
         hlqg2CqteXVn0O9E6al3v23XNIGzRYDJHOXGL6CqsdT3HuRredZpM/nch4PZD+u4vE62
         hhFFlFLDJR8NZG3oEsIKOJUTdMw4NkKkAXUlPJkq0TxWy+wSsFZpSnqv5jG/E/JQczde
         0Bnzn8qHtxrpgJas0g2pcePyxg9gq4ufp0Pk+Jv26LqCiEEQseI+HGQBbl9vYBfVrjVm
         VFOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3gq+iUtQa6efRuq5IykUtTZbAO8xczWC7T3uKXEFFFZCVpYxFPOgfR33f9hz8uFbBm+0TOo1+W6pPFls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLPuNioa/zodhI/vQm/MRm3oOs4qI7lAeeU6/zOQYMOM38t1ix
	LAV+lExf20AceBGwCjJtw+oYVo4WSLFxT++st3lD9u3RakJYOoNO8JYB0MwnMgjYH3RisjWSPPD
	1LXbmGnTpesS99pcGEkUzdkzgutZSbC9lWMwq
X-Google-Smtp-Source: AGHT+IE3ddjL/98cW3bmFZBiENn51OdQF1VuQX1l5+I9V/EbjVG0MUNhZ3cqYvzZ/l0Kgv0GxU+0oUz964FnKhrD3ek=
X-Received: by 2002:a05:6a20:914b:b0:1db:eb82:b22f with SMTP id
 adf61e73a8af0-1dc832e988bmr1681164637.5.1731566231332; Wed, 13 Nov 2024
 22:37:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGETcx830PZyr_oZAkghR=CLsThLUX1hZRxrNK_FNSLuF2TBAw@mail.gmail.com>
 <CAKfTPtCjax48zq3dzuupfrz52Q5TVF=kYSm0t35kT=E4QJGQ7w@mail.gmail.com>
In-Reply-To: <CAKfTPtCjax48zq3dzuupfrz52Q5TVF=kYSm0t35kT=E4QJGQ7w@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 13 Nov 2024 22:36:31 -0800
Message-ID: <CAGETcx_nVKYMhCmC6BPNVxLfDaz=uoSsk1WOs-aX=M03Ew2qTA@mail.gmail.com>
Subject: Re: Very high scheduling delay with plenty of idle CPUs
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, 
	Thomas Gleixner <tglx@linutronix.de>, efault@gmx.de, 
	K Prateek Nayak <kprateek.nayak@amd.com>, John Stultz <jstultz@google.com>, 
	Vincent Palomares <paillon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ugh... just realized that for a few of the emails I've been replying
directly to one person instead of reply-all.

On Fri, Nov 8, 2024 at 1:02=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 8 Nov 2024 at 08:28, Saravana Kannan <saravanak@google.com> wrote=
:
> >
> > Hi scheduler folks,
> >
> > I'm running into some weird scheduling issues when testing non-sched
> > changes on a Pixel 6 that's running close to 6.12-rc5. I'm not sure if
> > this is an issue in earlier kernel versions or not.
> >
> > The async suspend/resume code calls async_schedule_dev_nocall() to
> > queue up a bunch of work. These queued up work seem to be running in
> > kworker threads.
> >
> > However, there have been many times where I see scheduling latency
> > (runnable, but not running) of 4.5 ms or higher for a kworker thread
> > when there are plenty of idle CPUs.
>
> You are using EAS, aren't you ?
> so the energy impact drive the cpu selection not cpu idleness
>
> There is a proposal to change feec to also take into account such case
> in addition to the energy impact
> https://lore.kernel.org/lkml/64ed0fb8-12ea-4452-9ec2-7ad127b65529@arm.com=
/T/
>
> I still have to finalize v2

Anyway, I tried this series (got it from
https://git.linaro.org/people/vincent.guittot/kernel.git/log/?h=3Dsched/rew=
ork-eas)
and:
1. The timing hasn't improved at all compared to not having the series.
2. There's still a lot of preemption of runnable tasks with some empty CPUs=
.

For example:
https://ui.perfetto.dev/#!/?s=3D955ff7e73edf32dab27501025211fa2ce322f725

Thanks,
Saravana


>
> >
> > Does async_schedule_dev_nocall() have some weird limitations on where
> > they can be run? I know it has some NUMA related stuff, but the Pixel
> > 6 doesn't have NUMA. This oddity unnecessarily increases
> > suspend/resume latency as it adds up across kworker threads. So, I'd
> > appreciate any insights on what might be happening?
> >
> > If you know how to use perfetto (it's really pretty simple, all you
> > need to know is WASD and clicking), here's an example:
> > https://ui.perfetto.dev/#!/?s=3De20045736e7dfa1e897db6489710061d2495be9=
2
> >
> > Thanks,
> > Saravana

