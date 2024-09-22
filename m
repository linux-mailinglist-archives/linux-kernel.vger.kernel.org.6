Return-Path: <linux-kernel+bounces-335184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B5C97E257
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 17:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D601F213A8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 15:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9264F9D6;
	Sun, 22 Sep 2024 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N76Ty0t7"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8514263D
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727019942; cv=none; b=h1ruF1jU7zQ4vRSaBpPEH5rZ5huSUIFpu2xc10vCqvhk8sOqYieXLMHf9j3fTeO3ARw0aP26vOljgK24lFz++TW3lrD+vwMqq7Sz2qeTMld3xBPVpUNHniRgTRv8zE2EWxfoxnwNcIKRPwkGc7xOSOm31CBpUJ0neuylYWVxFUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727019942; c=relaxed/simple;
	bh=5cm00P7/duSL5FVyVdO+2yozFQLDsetKduqrGv58/Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFxJWUSlPGtjyqUUEy59+Q43dz6SR0uS+xAMFESyNQ/TfPpmi7YADV7ilxstJRn8LyiutOb/xyXRrxQEqM2EDE0x/ygnW7WSwga577rfgtNX3tct13C2Yil2F0SBm8bZxJt0NnUFkf0VNPBv5jLAI2dpn808MT+uemgVWO8FNMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N76Ty0t7; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d43657255so567391866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 08:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727019939; x=1727624739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cqw6BNVWvQvc7Ot8kytEoiRSWngnKP58LN6xDZxWNDA=;
        b=N76Ty0t7v+VmjJqFhgkRUFzJH98DolIglslX7DTzwgOu61oT5QlUVF26ORGlvCJTq+
         nky2PvRXeXf0KsoOk2EOJb5uJ2ON6cr1sPq92cLpptY3wCSGEHdZyv6NCbvbiTXfOn+l
         A8d8RK28Ipvt/10+6kCR5zffEu4F+Q2sxruPfROJ7EEeLGkXdaKeIvpITerZGpu9v8qE
         U5cj3BZ0KRRjrQpdWXp9Thex7K5pSz01TAa99XyjVC5eM+9/e+1BNiyvNWJF+Bwy4YdP
         yp1dJeDLjHKmwTh7QfEXZKqC3OU28cM/xyyDNe8EVUfC4Etuuuh/Bksah3NNJ9zYvgfA
         +6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727019939; x=1727624739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqw6BNVWvQvc7Ot8kytEoiRSWngnKP58LN6xDZxWNDA=;
        b=vJ0DWmKwxieEq49TxBdzXbShZoJeek04xxJuNODDaszbeu8xcu4lCYDvNGX7dCGn4f
         CtWi448HGahcnE50+5lQl7YeZODYJdt4uHR/onVZgF1hIe6qRu822Ms+NOk88/JQwieC
         +a0W+7iXcoIhycwh/9HEDHH26o4MLAsutnUe+n++3oGJhw493pABtIYdbRVCuH7zAKfL
         B6M1Zg3WiTdr0lP6i9XDvDAp/rd9pI6/8uae3VS3m/Rm+HsXvhILQnu6izzZ5AWQWNJb
         HsHt+zv2N62D77rjjwslnsjH0YkI9Dq8sBC6qFZLpFDg3dI9FthYl4YTc3j1isWfRRl8
         8M6w==
X-Gm-Message-State: AOJu0YzI/9y5yJsi5MPcc9i/20nthG9Kp1IaoXq7ikubFcoMQMQCVXcy
	mwjSWTumKVgddiZ4T6xWYb7nwR0W9F54HkxYBSkPnBK6cUgxrbwd
X-Google-Smtp-Source: AGHT+IEZ1mrt+u2uEuHyatCd9rqHewYXgMoORyuyZ9Y4CUaDm0YCEh1Lmi0FQiTXW0q4Tr7xri3XbA==
X-Received: by 2002:a17:907:7e8b:b0:a86:789f:c756 with SMTP id a640c23a62f3a-a90d50fd4aamr984027566b.53.1727019938615;
        Sun, 22 Sep 2024 08:45:38 -0700 (PDT)
Received: from debian.local ([2a0a:ef40:c56:fd01:3715:1975:8d7:6033])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b3833sm1098163166b.128.2024.09.22.08.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 08:45:38 -0700 (PDT)
Date: Sun, 22 Sep 2024 16:45:35 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, bsegall@google.com,
	dietmar.eggemann@arm.com, efault@gmx.de, juri.lelli@redhat.com,
	kprateek.nayak@amd.com, mgorman@suse.de, mingo@redhat.com,
	rostedt@goodmis.org, tglx@linutronix.de, vincent.guittot@linaro.org,
	vschneid@redhat.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, spasswolf@web.de,
	regressions@lists.linux.dev
Subject: [REGRESSION] Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Message-ID: <ZvA7n9GNoD-ipjkj@debian.local>
References: <20240830123458.3557-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830123458.3557-1-spasswolf@web.de>

On Fri, Aug 30, 2024 at 02:34:56PM +0200, Bert Karwatzki wrote:
> Since linux next-20240820 the following messages appears when booting:
> 
> [    T1] smp: Bringing up secondary CPUs ...
> [    T1] smpboot: x86: Booting SMP configuration:
> [    T1] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #14  #1
> This is the line I'm concerend about:
> [    T1] psi: inconsistent task state! task=61:cpuhp/3 cpu=0 psi_flags=4 clear=0 set=4
> [    T1]   #3  #5  #7  #9 #11 #13 #15
> [    T1] Spectre V2 : Update user space SMT mitigation: STIBP always-on
> [    T1] smp: Brought up 1 node, 16 CPUs
> [    T1] smpboot: Total of 16 processors activated (102216.16 BogoMIPS)
> 
> I bisected this to commit 152e11f6df29 ("sched/fair: Implement delayed dequeue").
> Is this normal or is this something I should worry about?
> 
> Bert Karwatzki

I am also getting a similar error on boot, and bisected it to the same commit:

[    0.342931] psi: inconsistent task state! task=15:rcu_tasks_trace cpu=0 psi_flags=4 clear=0 set=4

#regzbot introduced: 152e11f6df293e816a6a37c69757033cdc72667d

