Return-Path: <linux-kernel+bounces-284265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB90A94FF1D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C3F1F239A3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E10524B0;
	Tue, 13 Aug 2024 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H288B9Pa"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FEE446B4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723535661; cv=none; b=QDKnYmjil2qwuZM/Rm+itk3oWkYAVNUGFyzMSdj2GQc64Kf+B28zeA8o8OZmacvBCBEpDd+xVoXodQXXFa/NuHpZoJBIUodti4pp3ZSW2IvytScO0lQ4pVneyKhgN3LW/kTo3pKjKOpksfkt32Ts0C6j7cNlZbJM7CYCEa0FUXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723535661; c=relaxed/simple;
	bh=Tagmd0ZHFfAZHe1r1Mr1oZyeFx8z9898PM42DLkVG04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3tqPPmrv9t2h1YLYUxcbaQAfP+oDplj/+rvwTMEavL6Z3DzdAajUPL7YmLPwYop1uRIOsSpdCxH855hBHy1AA1+bGSjyVySM6vMS8asb/q2LXzdrpupIyA3M07W6u4nVGRy9fKRqqIOQuj00b8o4PfT3yMDSCr82UfJFjlvtJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H288B9Pa; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cb7cd6f5f2so4028804a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 00:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723535660; x=1724140460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=quunBnpR+uyAazpYXeUKYV/u6uqA7jUaGY1RNyrzJvk=;
        b=H288B9Pa2ncrbNPkFbSWzfldBmbSIMQmZzXSzvr5jlLsuBUGP4RK97HKVX6XYtzt2p
         me/kmcVraJqZt3wq9G/p9ya/fwe0vSgbQggYhL21Gj4kZ1+aAoUOsDPonuY3cdc/ssX8
         i9jZC6033cwkXY3zBsG62Jx4l9luC+E1k3/SFEKt62Qy98hxr2KkCH2GwA0mPWDdSJtq
         cHlsLA2PFL/gHjRFqRZTV7T0AbJlwoHNlOkLkKsdNhSfROqyjG4BxO87SabE5Wm9Pv5y
         PpZS+G396f8D4nvp7hFGAwdqsrl4S+jmUf3MpRrvZGgoz6iIu/L/Oj/5WhoPyniCgaNg
         mV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723535660; x=1724140460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quunBnpR+uyAazpYXeUKYV/u6uqA7jUaGY1RNyrzJvk=;
        b=BKfaAa2NZB8/Vo4v8MXYWcNyw0y0N7DIBOQoNHg46a4GfxjJEbz5GBVR+qC5BGQ7x2
         Ot0HCnIgSc8rogjpvQXJKgI21czNshAEY8iO4jUPB4dVeIcmhOaOFFfGI1nirWbJUHH1
         0tMJVnYSi2cCMo1NxeJY83rgewYdnsEWSEjhzL3wYVYgMhVuCtVq59FMBiIzbdngwPmW
         te97TyU3VqMvq2neAYYbq+kalp1j0Du5pVIPdL20dx7wBg25DcOJqfIpLtPQ7eSajs8A
         8P1L7FAG7YwsSdAOHi5qder5C1BlPGE6cpSUYB0yNigjU1l30g3XLtSX/YcjqoeRQYJv
         Eb2w==
X-Forwarded-Encrypted: i=1; AJvYcCXwY+w3SYQ9Rapt4Z4BWQcFBz+8pVSZ+k8/kQLoPif6fxwgeQVwJwPlMKHImp8zV1rocjcK064dcuMS1js7CxdbHwO9cn/1ktBtx1IX
X-Gm-Message-State: AOJu0YzQTNYsZTHqhO96M53jTHeQ7WCM2kxo98xasG+FXLtt19GAfbyv
	DcoxRS/su9emcNpbkU+QPYxlbN/8cQDHR4zt84FCUVuumecnoyulous3jPAvXVpJ+203k7Qa22m
	0nG9G2bNMfVAPvZiC3lJ8PRgDdXw6w+omRima5g==
X-Google-Smtp-Source: AGHT+IGjquCO6vuNugRLHkV98nNv6JV31HDxkHG2BV4oq9FFnH3FXSVBipvECEDVXrTZNgI3x5FxnIOGlvzKaRohCqw=
X-Received: by 2002:a17:90a:6785:b0:2cb:4bed:ed35 with SMTP id
 98e67ed59e1d1-2d39269da03mr2808886a91.41.1723535659547; Tue, 13 Aug 2024
 00:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3c726cf5-0c94-4cc6-aff0-a453d840d452@arm.com> <20240809012410.marjxrio3sjequnn@airbuntu>
 <ZrXIb7BFOWY11DKt@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <ZrXIb7BFOWY11DKt@jlelli-thinkpadt14gen4.remote.csb>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 13 Aug 2024 09:54:08 +0200
Message-ID: <CAKfTPtD_QzYVeTbQ-j2mOsKmCcjUaxo403M_HYCWbT2RjjGb7w@mail.gmail.com>
Subject: Re: [PATCH] sched/cpufreq: Use USEC_PER_SEC for deadline task
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Aug 2024 at 09:42, Juri Lelli <juri.lelli@redhat.com> wrote:
>
> On 09/08/24 02:24, Qais Yousef wrote:
> > Adding more sched folks to CC
> >
> > On 08/06/24 14:41, Christian Loehle wrote:
> > > Convert the sugov deadline task attributes to use the available
> > > definitions to make them more readable.
> > > No functional change.
> > >
> > > Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> > > ---
> > >  kernel/sched/cpufreq_schedutil.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index eece6244f9d2..012b38a04894 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -654,9 +654,9 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
> > >              * Fake (unused) bandwidth; workaround to "fix"
> > >              * priority inheritance.
> > >              */
> > > -           .sched_runtime  =  1000000,
> > > -           .sched_deadline = 10000000,
> > > -           .sched_period   = 10000000,
> > > +           .sched_runtime  = USEC_PER_SEC,
> > > +           .sched_deadline = 10 * USEC_PER_SEC,
> > > +           .sched_period   = 10 * USEC_PER_SEC,
> >
> > I think NSEC_PER_MSEC is the correct one. The units in
> > include/uapi/linux/sched/types.h is not specified. Had to look at
> > sched-deadline.rst to figure it out.
>
> In practice it's the same number :). But, you are correct, we want
> 1ms/10ms and unit is nanoseconds, so NSEC_PER_MSEC.

Yes NSEC_PER_MSEC is the correct unit

>

