Return-Path: <linux-kernel+bounces-177510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DAD8C3FF1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3E71C22B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A42B14D2B2;
	Mon, 13 May 2024 11:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OENpK6ku"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD5914D29E
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715600267; cv=none; b=jlxO6fAUG2+cgIXaeedHXgRX5QL2XTCJz+Li/q4TgD5MBZel4X8+W4FQP1mEnsj0fnw4acHDkWf8VHQenws9FtKVfk2iH11Q1TSFX1eSiDepT6IaGJ4oLRSR5NWqLX88DjYqqjExN55BX5iDtUtPLVwSRY0htIReztfjJA35XqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715600267; c=relaxed/simple;
	bh=Eca3qKrgFW3uoU28P8SQGN+UHQcj/KFsS9W44wZBdgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuaDSBK/cauTiuLLucswNXCKGVVLijG6V3CqXjJLq8iLX5Zhy9jAoKL1kbAqzcw2TJr02/z4SYp2huehfn746lJrPChsK0iHgGWtUYBcYhtcq6At6TYqUBwKUpwXgKnr1xahfYVN/7tmJKICrbzHZ6QOcJmGSrGczUGfMsVf2Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OENpK6ku; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f4178aec15so3636961b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 04:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715600265; x=1716205065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wJNijDxTKHvffjgs00F+cVR0bs0XSFTpjOvWGpfHFDA=;
        b=OENpK6kuIcs7iE6ks//R32sB7n1yvfYIumtTrtCimjDqzzbrcHSmGa5UtVZasbG8R/
         1yh+oioYz4qTZ/PZKbWiznK8aRnDSMYqVa8aEuXXYjGVijFZRrIkKdtbmE3N7eI1PUJr
         Pj4HvOnqCrkZbjpEKOLLZ1o4g3hfSoQzdlgHlekYXNvQ9Z7RueaUQ788nrDu2fo9VYzB
         zc0LB9PF1Wxyr3AOHwPB/rOOIhDzWRQgwkXoI157P8Ieh2sH7/k5VMLdfVWEok+Gi2DO
         /nmxiLUaIPVOrc+fBXH6jdC1YTE0sB2LmvdRKInbd9adnPGAWCMXZ/bHdJAjFgQbUMid
         yVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715600265; x=1716205065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJNijDxTKHvffjgs00F+cVR0bs0XSFTpjOvWGpfHFDA=;
        b=UnfUshc3t40n3f2CxFJnG1S2ZHPPJr6IjUC4oEL3OdE8CQdmzKpbHL2CFuNgfbvs3D
         4UmIj0zrNEaTtrZTr+5HZbCZ+A/cHrIWb/bqQsJmY7G4oePYcFyL7XTI7cN8Qez6rnPv
         EmyQrecw/CoGlqyV5+qYvvfQ3E1+Vjv7gTLMQoSyG5Uxv/kIIizSoXt6tANawt70u5PO
         IYcQCa57fTpRegCzgdW2ffcAtYyBxiw2a76LFYYBITxqrKCee15G3O2qR2Nw3Tx4G544
         NLazMvO/N/VFP+CQ29UvX7agCRom4VYxuI5R2iQ0Q9ZqYZfnPkaGUqS0keCBj4XLwaA7
         PsQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIILq06DpGlfUCo9e97oPnLwn0OLEnsCxAkf6D+xUgBSrrTqINFYLPLZFtDHJWcz8OEda//ckz17OXrkWBjWH73EbELtB9kvJw4G0k
X-Gm-Message-State: AOJu0YzER9q1G+487F5W/ceiH55nT0Svw83juwd/8qsKFTfjxr8cxkQy
	h+ptEPcHV6cFP1oFd0PwLeBuSM9d2vAmBAb6Fg/84955C1YYTXNvyajDE/9l697L+kGuG3R3ZEa
	hwr18MYLPRi0coo9va/rnc9QdMEuSlIozYWlvqw==
X-Google-Smtp-Source: AGHT+IEVzNrMXcgD5CWNkj7tP9MS+M7RDbgLjmZNx6vsjHe05rfGkR0jAl+LiZH50mdHVDoKj6LzeljS3HqWuGTzTRc=
X-Received: by 2002:a05:6a20:d493:b0:1af:f497:8230 with SMTP id
 adf61e73a8af0-1aff4978855mr2636018637.24.1715600265516; Mon, 13 May 2024
 04:37:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZkG0nxxBPB/03Q/l@gmail.com> <CAKfTPtB01UKskH_a1h1LtjoRq6O3NnqQuuh1L50O-yHRLQm-iw@mail.gmail.com>
 <ZkHY42pybndB1K+J@gmail.com>
In-Reply-To: <ZkHY42pybndB1K+J@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 13 May 2024 13:37:34 +0200
Message-ID: <CAKfTPtAqBXeWn=Lad2MybarQR-B9qHS4mGWCdQ7=r0KiPdt3zw@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.10
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 May 2024 at 11:09, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> > Hi Ingo,

..

> > >
> > > Vincent Guittot (6):
> > >       sched/fair: Fix update of rd->sg_overutilized
> > >       cpufreq: Add a cpufreq pressure feedback for the scheduler
> > >       sched/cpufreq: Take cpufreq feedback into account
> > >       thermal/cpufreq: Remove arch_update_thermal_pressure()
> > >       sched/cpufreq: Rename arch_update_thermal_pressure() => arch_update_hw_pressure()
> >
> > There is a fix for the one above:
> >  https://lore.kernel.org/lkml/20240425073709.379016-1-vincent.guittot@linaro.org/
>
> So this is a cleanup in essence, so I delayed it for the next sched/urgent
> pile - will apply it once Linus pulls sched/core.

Ok
Thanks

>
> Thanks,
>
>         Ingo

