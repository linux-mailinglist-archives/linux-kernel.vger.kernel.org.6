Return-Path: <linux-kernel+bounces-243122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF17929216
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBCF51F224C2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 09:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0B41B963;
	Sat,  6 Jul 2024 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eu4AkdnC"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05BA1CD02
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720256495; cv=none; b=b0igdgAfsMdtCl4v5hb0h28mA4HoQ91TX3NKMavWWmNfPZCU9N6661/qPX9cNsMnR1oXaRI1vW6GS7Q9+vAI5lVzSytDlrLBYt+8WqXXNktHuAuQ9S0UcL1CLv7+K97RRjRdE3B2NSbdLrooZKt8/D0hy+Yw3+FgLXjq6+q2bHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720256495; c=relaxed/simple;
	bh=1fRFmAeRWbbnc4czXB4S/CavZUJLftpdm/WT09pQpNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHutRglR433fAIq79RDJKMwwOg8euYR8GvUJ5798qLsQjCmD75b5b0avfOX0/ArDIEviSl679Md6skjypiF23IV9NEVVNEvhoA+g6ItC1TaZQD0KHpiZVl+ZY6KiHOiXb1zHbE5pkYGDuizca077+TK0VE1JlD/C6rXh/XOuVhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eu4AkdnC; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c927152b4bso1602565a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 02:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720256493; x=1720861293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YsTvMvZcSY2ZSuC20nkSArsNjYonbkAEsOeFY8Okpok=;
        b=eu4AkdnCiTbZh8l5A/5blAaLvBwmdD5rR4E29RTRCXsRejuVYNUryD1xHVU+4NK7Bl
         w39EaEwQH+iwxEr80ft+DXAXhOQderRybbDfDzNI7YHgFEggmjKAKyuzT1Vc4tHEOjMd
         C0/A63HQALCcwmRmPUfSkxfPf45hRxObrxnToyq87J4ANhpuTRMliWmekXrlaJSbjKpc
         wAqmintgVNak4XuHdfipJSMde6ngnicEROM86BfkUbjymdPKXLKPe//Fz8in3ji37H8E
         8b9yetqb/Xj1UpCupn8yGKOwH7SWXLRszycfvd0DqFbUyWNJDka7MyCYl2P9yDxDQXap
         AIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720256493; x=1720861293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YsTvMvZcSY2ZSuC20nkSArsNjYonbkAEsOeFY8Okpok=;
        b=Ij6Rn5xG0SZV7pGh18NVLWPqtvvfqeUAACqipXf7XWxzZpFVvamIy0/fvyad5HE9TT
         L3g1qpLyiCpg/EVbS3dA1GwksuCtPHkqY+tQsyOkoBJxlvomprUogvbNaFp1HNsSwV6m
         5uFVAFuFAKQDtqiv9MH/H/Lnc4yNzMSY3nLrEUQFtw/P5/bmRtFstK0/wOhAPOvZ+iiK
         iCPPuvXYxVC8Lb+JyLtlPly0eKkI69QM5KIQsOvv0YqEG4RvEhg8KBxz6kNcOQvpWQ8i
         yguC1sbdsmTuvIAhzsOBUTXl/QH/O4fHqDp0+K6e0rhbjsV8AZfztMwfMsfwdJ+Ochtp
         UmPA==
X-Forwarded-Encrypted: i=1; AJvYcCWSbFAIK5BjTYcl1FdnVDoYM6ps05T5SsTTWtKGnga7f6/CKmCAQyYflKCTRtNMuMlKzbdnaK1YDIvcvtG54358FYLYG0SO2VWlt4OF
X-Gm-Message-State: AOJu0Yw1+b9dVGLX+F262FFksGMVZk4l23pqBeRzgkm0l5yyTHEaNET1
	rWlqUF/PvLrDgE5GylYj47GP1YqW61STpfJ10NNPQfEM1B1PS0qVG6or7Pob7ZL21nsRE7eCq0s
	LGdf62rvl2QrA0lkyx4xDvTY6cLDRkpCxhPpz/g==
X-Google-Smtp-Source: AGHT+IEOJzFvfwtnv8PFmSEqRUOVNxWPl2o9EsvkfSUtSg2DcWgK+yBNAYbmlEl+DFaAdUH76t9Z24PkqOc4gdMEQv0=
X-Received: by 2002:a17:90a:1286:b0:2c7:7e23:63d8 with SMTP id
 98e67ed59e1d1-2c99c6d0e09mr5072946a91.44.1720256493164; Sat, 06 Jul 2024
 02:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619031250.2936087-1-tj@kernel.org> <20240619031250.2936087-3-tj@kernel.org>
 <ZnM2ywDVRZbrN6OC@slm.duckdns.org> <CAKfTPtBPObGdcaQF5nKqr4042f-+5obTMm_S6S+=3_Ct33ZMyw@mail.gmail.com>
 <Zog5-Yd5wV0-Y76y@slm.duckdns.org>
In-Reply-To: <Zog5-Yd5wV0-Y76y@slm.duckdns.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sat, 6 Jul 2024 11:01:20 +0200
Message-ID: <CAKfTPtDeA4OTPJmEHd-wKToYwDVizcny-_qxEuDUA-OcaVm2Uw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Add cpuperf support
To: Tejun Heo <tj@kernel.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	mingo@redhat.com, peterz@infradead.org, David Vernet <dvernet@meta.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jul 2024 at 20:22, Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Vincent.
>
> On Fri, Jul 05, 2024 at 02:41:41PM +0200, Vincent Guittot wrote:
> > >  static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
> > >  {
> > > -       unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
> > > +       unsigned long min, max, util = scx_cpuperf_target(sg_cpu->cpu);
> > >
> > > +       if (!scx_switched_all())
> > > +               util += cpu_util_cfs_boost(sg_cpu->cpu);
> >
> > I don't see the need for this. If fair is not used, this returns zero
>
> There's scx_enabled() and scx_switched_all(). The former is set when some
> tasks may be on sched_ext. The latter when all tasks are on sched_ext. When
> some tasks may be on sched_ext but other tasks may be on fair, the condition
> is scx_enabled() && !scx_switched_all(). So, the above if statement
> condition is true for all cases that tasks may be on CFS (sched_ext is
> disabled or is enabled in partial mode).

My point is that if there is no fair task, cpu_util_cfs_boost() will
already return 0 so there is no need to add a sched_ext if statement
there

Vincent

>
> Thanks.
>
> --
> tejun

