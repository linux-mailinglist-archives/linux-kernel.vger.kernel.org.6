Return-Path: <linux-kernel+bounces-525062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB0AA3EA51
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56CA17178B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A30157A72;
	Fri, 21 Feb 2025 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYEnPgL0"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D654A04
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102434; cv=none; b=h9UdVguMQNfmiuRc1/gAQ0XJ9f9cE/CldiiVCvzNz+0rIStllt0QITeeMtS+dcz8hZ8Pl2IrTHvlqf+sMCiuSq4vRzONceAuML9pF85ynSyLIoSxoA/C60ZCaucKcjlQoi90dSPP2Lg169nakmPrPv3mb2Z6AFkSv/uO3B3R7u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102434; c=relaxed/simple;
	bh=AxP4mDhXQ6eQLbNXshX2q5bR/60iXZdBH6WA2FW2R1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdQmImEfSkeBXMH/aOAYU1HANmHLF9eR8P4M04KzzmM70Q71tHkD88BNxuMpWy3kalk0D5TB20GZ72UsyfxnEjNLOoQvn+oysTRHHIiLhHA5v9SBloR9Vu6YnfTy9Osu/GLkfDCwRcyJm7w+rWX1ajOchKVkR7lgdxE5SKRfHpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYEnPgL0; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-472098e6e75so85521cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740102432; x=1740707232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxP4mDhXQ6eQLbNXshX2q5bR/60iXZdBH6WA2FW2R1E=;
        b=bYEnPgL0hd8wVmFg+PPwlWYPLHxX44fmzyVv1z//cvma+f9ZgOCKoZ7cuVcSLdi9mF
         hjVWcC3LhO1ni+h/w/G259RS9DApH8LqXRv+kgUXBQPjHUNGrr+hMWnhfFCnUJViWL4I
         hrTqXsIaGgl7qG8czcb0DefPtBCjwjhHcD/PJK5LdX3wtE63O98m44/efo/izGQtTRzO
         rKSSHV/w8yonMNhvmXhHPRSdEAycKTk0JKE4m4YOOgXSJRS15sAZ66MHLVCh6HGaJQvw
         0+H6kOI9ceS/koWjAUwZIl/CnjkRHQUsOkqU292IyqBN4f8sovqcR730VY/WaqJl9CZM
         63Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740102432; x=1740707232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxP4mDhXQ6eQLbNXshX2q5bR/60iXZdBH6WA2FW2R1E=;
        b=aM5M3aMOQ8fxKOsB44X4hhXERbryogN3+ismlDrjWh3rIv6afaIu0mLwYeYjdvcVES
         KydXvtxsBu9a30XFKQlD8UH7+23lMGxOxeVP9xFa7W41eU7M3AZyegkXRixVy+xHh96S
         9AXsRF7w5nFAvspRPps+eH2zo5n9CWzPdra1SiqylkZx0jCZ389PO9PrcJpY/aHDruGZ
         uCBEPw5N8ExwNkd7cXgF3SEedfW5l9azwr/dZZw6ivFjdvwMfW+TaED6jjGtvFen3qxu
         cUBxBkRtzHbw+e8wqZiELezRZeKMmWUajiff5i7uN4qJI6DztueLbVrXFj+v/sPafz1A
         yZBg==
X-Forwarded-Encrypted: i=1; AJvYcCWE73PRtlE2TULbH/6iDeeeiTLTJHbt83tHcnn0FkgXKk3WKP96SbeADT28LI0tM+klRDFhh2HnzcmcSKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHH/vVcl6ZITARvnQ3IsrD4osHGVMVHUmuHiK/zanuoWqMxQ4M
	ismskQtqDS7nT3oVBlqOTkoyOCQO2x23tKMRHzlnJKXkMEcI3p7PrShIa3oeq0+UqHpp2CnH+V4
	LD+lOoTNID54VTLpGL+MLOO0P+mM4yhGrwYsQ
X-Gm-Gg: ASbGncv/9oEjMS4ysFCwymQZC9CjKUgpDcM5A9NaRtKvZ1ACnNYaJB+dGmCeUCBMeWu
	200v2V6ugm4rNOG+CYJx9CBO/BKYMigc8UyY5H3Vzy1waaX0psYrZWwA2jAQ8437nvycofq4xbY
	lOoEOjTpEU
X-Google-Smtp-Source: AGHT+IF771EPpHVaPndwMZB6cwQRtnKdAJc5IswuEkn4dCv7rTHZtXiV/I4ftzRKDItiiUhIX6hiqTMbelJFcmlHw94=
X-Received: by 2002:ac8:7d4c:0:b0:46e:2561:e8a9 with SMTP id
 d75a77b69052e-4722374c0cbmr1803021cf.2.1740102432029; Thu, 20 Feb 2025
 17:47:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220093257.9380-1-kprateek.nayak@amd.com> <20250220105558.GJ34567@noisy.programming.kicks-ass.net>
 <b2386349-2879-4dce-afb0-f6486c24c117@amd.com> <20250220113227.GL34567@noisy.programming.kicks-ass.net>
 <xhsmhikp44oan.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmhikp44oan.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Josh Don <joshdon@google.com>
Date: Thu, 20 Feb 2025 17:47:00 -0800
X-Gm-Features: AWEUYZmsiOapix8_7R9IjhNGiB94oqz3kpsgk9TTlDu-2fIKI3PlXsj4YcPwTgs
Message-ID: <CABk29NsCqkOVXHfu1=ir9nhKiy2PVsONdZm29qXdbJX8LrfCNA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/22] sched/fair: Defer CFS throttling to exit to
 user mode
To: Valentin Schneider <vschneid@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Ben Segall <bsegall@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mel Gorman <mgorman@suse.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev, 
	Tejun Heo <tj@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Barret Rhoden <brho@google.com>, 
	Petr Mladek <pmladek@suse.com>, Qais Yousef <qyousef@layalina.io>, 
	"Paul E. McKenney" <paulmck@kernel.org>, David Vernet <dvernet@meta.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 7:40=E2=80=AFAM Valentin Schneider <vschneid@redhat=
.com> wrote:
...
> As pointed by Ben in [1], the issue with the per-task approach is the
> scalability of the unthrottle. You have the rq lock held and you
> potentially end up unthrottling a deep cgroup hierarchy, putting each
> individual task back on its cfs_rq.
>
> I can't find my notes on that in a hurry, but my idea with that for a nex=
t
> version was to periodically release the rq lock as we go up the cgroup
> hierarchy during unthrottle - the idea being that we can mess with part o=
f
> hierarchy, and as long as that part isn't connected to the rest (i.e. it'=
s
> not enqueued, like we currently do for CFS throttling), "it should be
> safe".

Can you elaborate a bit more? Even if we periodically release the
lock, we're still spending quite a long time in non-preemptible kernel
context, and unthrottle is also driven by an hrtimer. So we can still
do quite a lot of damage depending on how long the whole loop takes.

