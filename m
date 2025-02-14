Return-Path: <linux-kernel+bounces-515411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBAFA36481
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0773B4B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16CC268C71;
	Fri, 14 Feb 2025 17:21:47 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C138C267F4A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553707; cv=none; b=u2XXStSQQ49fUGOnG58SrmDdtT3LJecwBrGSu1KWCVyZ46zWFDhzFu2+4DaeKZ5awRvjEtHMPdHpmNtR6vfCDjIHsGOzgAWLhxsdEJ6WtXip9bwu+x5XnXdICH7Pt2CIxHEwmOYB07e+WTJAgZddEY2mZEqBL5ieDSOjUWVQkKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553707; c=relaxed/simple;
	bh=TOL6koKzoZj0grh9Pr0n6iccLhOBG0/43NlkNNhI43k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ig5I014gtLjcSvZ1Cf/eTiaKoFH1l+iVCD+HVPhshtDbMkK8ovKyAUTuUyY89hnpHb8NDgiX9jGlDCJ9o7tCijeEZ1RtQNrErLzG1RHbU/If1g1C6cRCqx/gSnBCU4anyAwIiQJTgwL/+YMYUGeYhRQK1fG0zrYACRP7iNvS3C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7ee6f54faso268295266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:21:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739553704; x=1740158504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixEWdkwMU4zD/s1haC4UL9Xf1aLUzJqzLyYSOlInL5I=;
        b=dZpeOpVVhrmAhR+OairRd3Is+5aAelTvdHwIfZDgOk4Ns2bKEbzQfQKYWS8Y0VSVMK
         ZjxTN0eMHESEozpXKAHY+EMF3lYalORcS4EE2Upj0+GSoxEiXaBQFAM+I7OojRnlgrhD
         S3BiTRTp5wXhk2ATSl1B0Ae+40ytoanx2uoG+FqMjWEfKAGtQNfOgWZKeil2U9WkcwJK
         lNs3zb2DFt+RKnFkhzgSTw8gZcmvpj8sJcx+49zLBS91fFqFobv+kgR/OEfr1svSIwl1
         WpYEldT7Lakyx2MMvW+sPDTL/CMLmf+R9sMoSjyVX1H9pvylW2HDaPWKTPcFgu1x3YTf
         zMVA==
X-Forwarded-Encrypted: i=1; AJvYcCW+sHV6IqtgkwiLpeX+BOvMd1hKg/v+mkkfVfdwii9kcJC7OjP2yi2OJEBzmIAn46rzqx5kvMXLIWiH2D4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdcPSMNrM6sPKlEze7+MVM7qo9qPLe2ots4EzMXVr2Up6Z5Tv/
	cNVFZSTNnOiEWNpvH/BblN4ef32jrhLuDQ+Fmbb7qgz9q0L8KBF9
X-Gm-Gg: ASbGncvmdgftyuSCR3DLNgqYeKMdaj2U7KUrs3js/wXbCm/pf5cUGafZ/4AUqn5ATu9
	oLaTJGfZtFn863LsAXP+evuuegFFSPJFEaS3XM8SrscFocVoQ6UWrjzO2F2NLLWUP9C3COWl1z3
	kfMlUFXNqX22vu1WPJd/nVqfQfaH5vhVX9ciIQAraFzxT/xUH2dPwXavsc1QYPM41Ke0F5SofaE
	l+YoP99PsenR/BR/8byOO8sTzVZfSOtoYsJ4UihAe1uhshgwxkRBzVvo2rDvl+h/ynQ6tQgwPSJ
	fBxOcg==
X-Google-Smtp-Source: AGHT+IEuGhV2i8f6wK3EowSDdboD4lp+PcmEyMlRnn/ximlM2zAnGPP8DSgXkHv7a2yEZLh/urcc9g==
X-Received: by 2002:a05:6402:27d3:b0:5dc:74fd:abf1 with SMTP id 4fb4d7f45d1cf-5e036061d44mr578332a12.15.1739553703636;
        Fri, 14 Feb 2025 09:21:43 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533bfaabsm377297666b.181.2025.02.14.09.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:21:42 -0800 (PST)
Date: Fri, 14 Feb 2025 09:21:40 -0800
From: Breno Leitao <leitao@debian.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
	qyousef@layalina.io, chris.hyser@oracle.com,
	patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
	qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
	timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
	youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
	tglx@linutronix.de
Subject: Re: [PATCH 03/15] sched/fair: Add lag based placement
Message-ID: <20250214-charming-tapir-of-education-03eb8b@leitao>
References: <20230531115839.089944915@infradead.org>
 <20230531124603.794929315@infradead.org>
 <20250207-petite-eminent-husky-7d1704@leitao>
 <20250207111141.GD7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207111141.GD7145@noisy.programming.kicks-ass.net>

On Fri, Feb 07, 2025 at 12:11:41PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 07, 2025 at 02:07:18AM -0800, Breno Leitao wrote:
> > Hello Peter,
> > 
> > On Wed, May 31, 2023 at 01:58:42PM +0200, Peter Zijlstra wrote:
> > >
> > >  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
> > >  {
> > <snip>
> > > -		vruntime -= thresh;
> > > +		lag *= load + se->load.weight;
> > > +		if (WARN_ON_ONCE(!load))
> > 
> > I have 6.13 running on some hosts, and in some cases, where the system
> > is getting some OOMs, I see the following stack:
> > 
> >           WARNING: CPU: 29 PID: 593474 at kernel/sched/fair.c:5250 place_entity+0x199/0x1b0
> > 
> >            Call Trace:
> >             <TASK>
> >             ? place_entity+0x199/0x1b0
> >             reweight_entity+0x188/0x200
> >             enqueue_task_fair.llvm.15448040313737105663+0x28c/0x560
> >             enqueue_task+0x30/0x120
> >             ttwu_do_activate+0x99/0x230
> >             try_to_wake_up+0x25a/0x4a0
> >             ? hrtimer_dummy_timeout+0x10/0x10
> >             hrtimer_wakeup+0x25/0x30
> >             __hrtimer_run_queues+0xf1/0x250
> >             hrtimer_interrupt+0xfb/0x220
> >             __sysvec_apic_timer_interrupt+0x47/0x140
> >             sysvec_apic_timer_interrupt+0x35/0x80
> >             asm_sysvec_apic_timer_interrupt+0x16/0x20
> > 
> > I am sorry for not decoding the stack, but I am having a hard time
> > decoding the stack properly. The values I got was misleading, and I am
> > working to understand what is happening.
> > 
> > Anyway, I don't have a reproducer and this problem doesn't happen
> > frequent enough. I have 1K hosts with 6.13 and I saw it 5 times in the
> > last week.
> 
> Weird. Would you mind trying with the below patch on top?

Tested for a 3 days in ~1k hosts and the warning is gone.

Tested-by: Breno Leitao <leitao@debian.org>

Thanks!
--breno

