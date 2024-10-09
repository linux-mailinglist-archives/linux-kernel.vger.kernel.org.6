Return-Path: <linux-kernel+bounces-357706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AC2997437
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F174F1F22959
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453BF1E1C25;
	Wed,  9 Oct 2024 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="zvPbp9qZ"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B61E47A9
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497249; cv=none; b=sUJ7b2/2VDHUzE14HE1mxHatrHe4KN68EmWB3Xsf/dDlot/2QNXRGbBBRMn5PhR3MoMIhRSEo2kmpoaZHJRqQUWsJYnOCDoQFbKwo8vHVaydR/UANSlEt7REjRHbfjZtSaBnlfSfQKlyEg/e3ulW5ZFB8+jB5Ye7GRvL4cwxNlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497249; c=relaxed/simple;
	bh=EEA9n8EKVuqwjoaU8xFSnE5n9WHqzdY3/Ze8q36DibQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiI5fPdEQM0pautA0XCPgSxyXxucGqHFzjXD9rH77ZbaIffJ8n7mP8djIG61oz+ppBKIsWLI8g+B2XeL7+32I7c3sqNrRiAlQbBSOUJoV/0e3R56wRQkbC42gWEniX/WZvuIpazn4jm7f+foKePToOEcLlPgutrUUds1ylG4M8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=zvPbp9qZ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b02420b600so2675185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1728497245; x=1729102045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VcKIKjFFXK/pS61017tWFdVnKhermK+qoG7rd4+wtqU=;
        b=zvPbp9qZHJqjMb3GJgqWZA9gRC3q/rsb+siweQ/zXeQFs4C+j+f7i3VFvalPfmDdLO
         gjBQEP1B83QGD0L77+jbbi+JnVaYr248BJex7NDwIlZ7UGczzNsy0HDp1zHt0qbRyFp/
         tn1RZoi9CHvpVISM7C0NVdkUl736ypHYDiJFAq8H4OJleuQxV5ZbX0oYxt+F8/wva9gX
         ZRX1KSgCgdpRnnu6de61d92xHKdGu57+P5l2nnuoCdr8fMEhrFjTSD8WFt1K7EvsUgBC
         1RhunHciUEghtA+1OIhdkNO7jeltUUT7iy5DHs/BxjpkpqpIf7KrfNOsdM6rzcX7dg5I
         fLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728497245; x=1729102045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcKIKjFFXK/pS61017tWFdVnKhermK+qoG7rd4+wtqU=;
        b=rZDZsMTgEBZb2+WGc80sjvKaV5YJf5EQjOoJt7BFDtUw60mF/htBvd6h7B7rvN2lKT
         CESGkM/qXYwSVMn1YBdukZZHgjujHjpz2JcIWkAoFF3woGGFhdW4IieTu0IICbuCYdVD
         6WGourI+NLfxFN44FkSyMV6wlw9BI+1JUFcN+4x71858rljepUf0GxsPnVGCmoZ27sBz
         hkHvaj4BME5Csk9qPeIycFjj5a7FyGDGLNy3I8Xfn0+Qv37T1ROq8Wr1NG1TG2xtIZPq
         7i7N+LSt1RcQynFb+QlbBi87b+7pX0sNNtxxdp+Zrgzv2nAFb0vtxGfa/kHtO2TwZQT+
         ybLw==
X-Forwarded-Encrypted: i=1; AJvYcCXVvMy3fGxvBS4CnbTB3mHiSklVlKMnjx9dbHTxCjY6/BFkw7bAoF0At1HxIIqS0LehXbXqR/L3YnJNnqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuDW6khXb5HxZ+si/Hr/jrmPdle4WgTW/gma3WxtZAdbGUwhGP
	o7W7RJ0ruCmpM9dfxolMDhrdxtd39U98Kdje1MdLsStCEGlC75LCCNmzq/42370=
X-Google-Smtp-Source: AGHT+IGXngKYT3dFEA0sPgqcLJmf5vE14K+Prq/oZohyFklv4PBlQGh/cKRA9mAbjHHwCZUeGMk5GA==
X-Received: by 2002:a05:620a:460b:b0:7ae:5c5b:a3e8 with SMTP id af79cd13be357-7b07954f02amr378290285a.34.1728497244587;
        Wed, 09 Oct 2024 11:07:24 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7afceb513b4sm132146785a.19.2024.10.09.11.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 11:07:23 -0700 (PDT)
Date: Wed, 9 Oct 2024 14:07:19 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Klaus Kudielka <klaus.kudielka@gmail.com>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	linux-kernel@vger.kernel.org, bsegall@google.com,
	dietmar.eggemann@arm.com, efault@gmx.de, juri.lelli@redhat.com,
	mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
	tglx@linutronix.de, vincent.guittot@linaro.org, vschneid@redhat.com,
	wuyun.abel@bytedance.com, youssefesmat@chromium.org,
	spasswolf@web.de, regressions@lists.linux.dev,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [REGRESSION] Re: [PATCH 17/24] sched/fair: Implement delayed
 dequeue
Message-ID: <20241009180719.GD6937@cmpxchg.org>
References: <20240830123458.3557-1-spasswolf@web.de>
 <ZvA7n9GNoD-ipjkj@debian.local>
 <1ee5f5828e2021bf1051dc1f9b6f01a8c061ffb1.camel@gmail.com>
 <2128d714-90f7-1598-b32b-559206fce5de@amd.com>
 <20241004123506.GR18071@noisy.programming.kicks-ass.net>
 <20241004135744.GB1658449@cmpxchg.org>
 <fae14e09-cd35-5feb-c3b4-8318a76b26a3@amd.com>
 <c97da254-9add-85bb-cd46-7c0d5ac77548@amd.com>
 <f82def74-a64a-4a05-c8d4-4eeb3e03d0c0@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f82def74-a64a-4a05-c8d4-4eeb3e03d0c0@amd.com>

On Tue, Oct 08, 2024 at 09:54:52PM +0530, K Prateek Nayak wrote:
> From 2e15180e18b51e9a2bc0d7050e915a70d2673a06 Mon Sep 17 00:00:00 2001
> From: K Prateek Nayak <kprateek.nayak@amd.com>
> Date: Fri, 4 Oct 2024 15:24:35 +0000
> Subject: [RFC PATCH] sched/psi: Fixup PSI accounting with DELAY_DEQUEUE
> 
> After the merge of DELAY_DEQUEUE, "psi: inconsistent task state: warning
> were seen early into the boot. The crux of the matter is the fact that
> when a task is delayed, and the delayed task is then migrated, the
> wakeup context may not have any idea that the task was moved from its
> previous runqueue. This is the same reason psi_enqueue() considers
> only ...
> 
>      (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED)
> 
> ... as a wakeup. In case of a wakeup with migration, PSI forgoes
> clearing the TSK_IOWAIT flag which seems to be the issue I encountered
> in my splat previously.
> 
> With that said, the below diff, based on Peter's original approach
> currently seems to work for me in the sense that I have not seen the
> inconsistent state warning for a while now with my stress test.
> 
> Two key points of the approach are:
> 
> o It uses "p->migration_flags" to indicate a delayed entity has
>    migrated to another runqueue and convey the same during psi_enqueue().
> 
> o It adds ENQUEUE_WAKEUP flag alongside ENQUEUE_DELAYED for
>    enqueue_task() in ttwu_runnable() since psi_enqueue() needs to know of
>    a wakeup without migration to clear the TSK_IOWAIT flag it would have
>    set during psi_task_switch() for blocking task and going down the
>    stack for enqueue_task_fair(), there seem to be no other observer of
>    the ENQUEUE_WAKEUP flag other than psi_enqueue() in the requeue path.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Tested-by: Johannes Weiner <hannes@cmpxchg.org>

It fixes the warning and bogus pressure values after stressing it for
an hour or so with tons of cpu contention and cgroup movements.

