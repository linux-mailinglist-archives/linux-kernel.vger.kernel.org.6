Return-Path: <linux-kernel+bounces-404534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1F69C44EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0885B31545
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414CA1BE239;
	Mon, 11 Nov 2024 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ToJj3OgE"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8CD1AB501
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731349067; cv=none; b=QeYbNAuKh7+aGZHFhpxIREa3aL7ZAwegRNWo7Yu+M10vaQqEcIAUkBwGjRJfO1+mmpD1mpcQmVqgs/26DEYUad3N07FFea1Yt+luB6x0LLDIl2+YyttlS+hJ42SZcC4CxkJMokOUZHEItguaiKDwzbcNvwBoNFnJX/FiyisU46c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731349067; c=relaxed/simple;
	bh=ai1xx9ogu52gttg36YBadu22Lodd2SqvkmJ9DqLGZgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxgNKl+c8fiZr527syPRxZlQs6UysDUmRnLd3xIAYS8mrRjnC86+I7iUwwh0CldHfZZc2sFANe2WL1oDU7Lp1lPCmRvXuoBcLLC77yOrGxC0cS4GmNgOro1nsnj+GHrarxaHfBQAhftqpbc5+WC8hD9ajBZbeY83noKHAoaoV8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ToJj3OgE; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so3479405a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731349063; x=1731953863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ai1xx9ogu52gttg36YBadu22Lodd2SqvkmJ9DqLGZgE=;
        b=ToJj3OgEADe8RvfifIYZwAxecJYqQfuKHkKrGa3tVocIW+6FUaRYah/X1V/65FKVLh
         nhsfrVuG/3vILuU7lmZtq5n8Ffqc0ju8HzRQJTWfPuqUPeCcxvv5P22C4mNNNrmQ0ljq
         iWSYCee0hcA9GtWxNWtxPQLsbCAwovd8xHu08cT/A1fuismgBU0rz0NdaZWaUBhcMXY5
         QU+LFmWE4w5iio+CV4xuvKfQabtfts1qD8vmp3iBpQAG9b41m5DjzvH6JiRUlTIruojI
         w7Z8pFHNUwlRylBp7CfeYXND8B07rE3ayXXzNfeb6OYSxob0dtBx5uzEyCtElJIfiSN5
         iamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731349063; x=1731953863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ai1xx9ogu52gttg36YBadu22Lodd2SqvkmJ9DqLGZgE=;
        b=S9SWGP4XZpnD3d90eTPEZml3RlQgW6LoU/zZ1JhBSbfIljHOFTd9aYxT6p+dYJuAG+
         jvgv9XVzVihHYq5TANeGxvRRX3UokHTVm2mV/co8o4/DWCp1xzuu3e7lGTZinfpEUIlg
         HPOs3JrX22XYKmpC3Z2c4T/7KaaJF41Qy39UXTzZS3iHuL/tTnEZKeiO0UYZiWagdSyw
         CSQm7ZmqPmSP0aAlE2NH1EY/3HEqaUhnwAXaNEF6Ksto5IqPz/KuNSLgZwAasZJ5rVuc
         7YZihGNMcl2N901TmkahqKf2mtg79ERL8S6k/xzYVrs/Au61H7YMuB+lCJmU5hKGmENo
         qftg==
X-Forwarded-Encrypted: i=1; AJvYcCW0/qL4E9kw/cCgB7SbVTNgeV2iGJkgnAXo4OsUKQAD4Mjn7dN9ph046wEnGP0A/JWEoawnBP4N1/9vK+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhi/3+0zj39Ci1JDDF/pe1VyWbPFVbECQ4npoZKbjzIbzPCjbF
	AUEAZdFt3SqNuRpOOlTHXocXplMAifGGIyzxMd4FpgiSNLMhwNG/7UY2Lr/BQoPaCWqUlUq3v3x
	P/8eRRI8Db5aWnP2uH44p/y2VE/zKheNcTk/5
X-Google-Smtp-Source: AGHT+IE/j+4d7FHnlcoohRhlgM/YdQ8LBklp8fIcTkFBaILoNa/Uog3LxfP7hfz5dJceQin4WVmRZHEy3zXjJprsLgE=
X-Received: by 2002:a17:90b:1a87:b0:2e2:c6c2:b3d5 with SMTP id
 98e67ed59e1d1-2e9b168141dmr17469897a91.9.1731349062465; Mon, 11 Nov 2024
 10:17:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGETcx830PZyr_oZAkghR=CLsThLUX1hZRxrNK_FNSLuF2TBAw@mail.gmail.com>
 <20241108083133.GD38786@noisy.programming.kicks-ass.net> <CAGETcx-CvWVc=TP5OmUL_iF7fSb1awJB1G8NghM1q_6dYKXkQQ@mail.gmail.com>
 <cc8831c7-8ea2-0ee7-061f-73352d7832ad@amd.com> <CAGETcx9qDK+QUiP8z1iNYXwjHz39oZzOZmhj4p=icU1BuVtcug@mail.gmail.com>
 <20241111104054.GE22801@noisy.programming.kicks-ass.net> <CAKfTPtBHRdHJaT_bjx1RF8bJ8Vc2s582VXMACPyjOno8zE_g=Q@mail.gmail.com>
In-Reply-To: <CAKfTPtBHRdHJaT_bjx1RF8bJ8Vc2s582VXMACPyjOno8zE_g=Q@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 11 Nov 2024 10:17:01 -0800
Message-ID: <CAGETcx9i4t_5Yt48Nfg=nSpZcPXZnPtSJtotUU7gt37wKpF6Vg@mail.gmail.com>
Subject: Re: Very high scheduling delay with plenty of idle CPUs
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, 
	Thomas Gleixner <tglx@linutronix.de>, efault@gmx.de, John Stultz <jstultz@google.com>, 
	Vincent Palomares <paillon@google.com>, Tobias Huschle <huschle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 3:15=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Mon, 11 Nov 2024 at 11:41, Peter Zijlstra <peterz@infradead.org> wrote=
:
> >
> > On Sun, Nov 10, 2024 at 10:15:07PM -0800, Saravana Kannan wrote:
> >
> > > I actually quickly hacked up the cpu_overutilized() function to retur=
n
> > > true during suspend/resume and the threads are nicely spread out and
> > > running in parallel. That actually reduces the total of the
> > > dpm_resume*() phases from 90ms to 75ms on my Pixel 6.
> >
> > Right, so that kills EAS and makes it fall through to the regular
> > select_idle_sibling() thing.
> >
> > > Peter,
> > >
> > > Would you be open to the scheduler being aware of
> > > dpm_suspend*()/dpm_resume*() phases and triggering the CPU
> > > overutilized behavior during these phases? I know it's a very use cas=
e
> > > specific behavior but how often do we NOT want to speed up
> > > suspend/resume? We can make this a CONFIG or a kernel command line
> > > option -- say, fast_suspend or something like that.
> >
> > Well, I don't mind if Vincent doesn't. It seems like a very
> > specific/targeted thing and should not affect much else, so it is a
> > relatively safe thing to do.
>
> I would like to understand why all idle little cpus are not used in
> saravana's example and tasks are packed on the same cpu instead.

If you want to try this on your end and debug it further, it should be
pretty easy to reproduce on a Pixel 6 even without my suspend/resume
changes.

Just run this on the device to mark all devices as async
suspend/resume. This assumes you have CONFIG_PM_DEBUG enabled.

find /sys/devices/ -name async | while read -r filename; do echo
enabled > "$filename"; done

And look at the dpm_resume_noirq() phase. You should see some kworkers
that are runnable but not running for a while while a little CPU is
idle. It should happen within a few tries. You need to unplug the USB
cable to let the device suspend and wait at least 10 seconds after the
screen goes off.

But even if you fix EAS to pick little CPUs, I think we also want to
use the mid and big CPUs. That's not going to happen right?

-Saravana

> >
> > Perhaps a more direct hack in is_rd_overutilized() would be even less
> > invasive, changing cpu_overutilized() relies on that getting propagated
> > to rd->overutilized, might as well skip that step, no?

