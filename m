Return-Path: <linux-kernel+bounces-277010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 024DC949AFB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FB7EB249DB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE7716DEB6;
	Tue,  6 Aug 2024 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFyZWDZX"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A22165F08
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 22:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982190; cv=none; b=Tny/nKNP1d6JO9ilOUXSddy4pkcVk+Eav0trR2sd6RwGN1iJmaIPoOs36Yia4APAlm6/sX+kNtSV4P3xg0yXmx9QirucXYXbWgSjmUfof1emhyld2IAOVgAgSWhoWTRc72IGZO9H+uY/d80Nk/xO6KiCgdpO6HrTlBM/IScHsRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982190; c=relaxed/simple;
	bh=kGQAqWoBhsjhQXSsXAT36+mb3JTOzpol8nyFl6n83gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNktJKkzEyPhQYOyt/bOQJUAOw1b5xfNQB5SFd2RfTg9m/Tgm2udtIgdl324fHdzttV0tbZddptealwchrFxZiiJ2v/uCwPUkMz8Fu33SYzdlba4ZKUgdR+kPJYuJQnYVFiEVnfic2o49hBLnjUECMvr1hjQL4orIA7DQEsZCCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFyZWDZX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fec34f94abso11090105ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 15:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722982189; x=1723586989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PB7ByubhUWp4LbhxkdQRptLMcm+jvxKJAH3iDeFCGVU=;
        b=iFyZWDZXv3/LEJE3GgYFjBNIVrgUGZ0CrdRbs8OPS62mqiHphssjaslXQCGRhr+jC3
         mmIAg5e6Aje4GZsUqdhDkVb67pJRHrzcCac8pqr1KEA5+JYrWFmXcB1po0mze6ec7sml
         A8yT4L8ABHVrObxPaiciFWHOsihG6kvpBwU5MXBd6zjzBx8jtr7uQRQ3ARZE6Hir7eAP
         aXEhM6xTUt1n2s+uGIhJnURoiU974HALyh2i7gp27E6xmCE2G88gx0coILuPt9hW3TXx
         XINm5O9ShAHlu/zKYsUhIFwGQHZV/mW83GjbYeQXDnhT1uwXTlaL5YSTSJFnzdSl4fFE
         0YZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722982189; x=1723586989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PB7ByubhUWp4LbhxkdQRptLMcm+jvxKJAH3iDeFCGVU=;
        b=wSy9RFdQ9Rlc+cJOYIO+T+GkZLkook6uc/fLZf+rQ/VTDx/soPmDCpB9mWZDNY7Qcw
         7z3PpGV0DGDB6SsHEe2w9bcMHkpCp4wxnaT8QdDCVgwqNqUL2WHpZBoHdaRPvCXMOcNf
         7gQ4uSE4ovp40mfGICfWgi9fafaLib3N8LposIAjC77rdrvJvnLe8YvjAQz7FMo2426X
         f6WPeLx2cjSAVnx6JA1TjN3uON3FyoFa2Eq5NTNFF6s+TCBWZUx2h82aYdjNYxu/iA9a
         JVlEIKBJU9AsoNW/FrEFUhqPzUXyXJiYHGrkrbm16WlKF6TT6EVmm3o+0Abaxma0+rih
         dEDw==
X-Forwarded-Encrypted: i=1; AJvYcCVhj2gWHPVRn3Vp95C1g6SE3a9a0Eo092tXzserjxIPacdGTj/39fL0o++wD6uwwicloCPeyLJ3Bji4v5Aa5jPAAl8LEmjoGwBJfhce
X-Gm-Message-State: AOJu0YyuNopLPtiPm4H2kfryg41v/HRR75X78X3IDUXLlhXDu5ZQqlBo
	U+1jhk/IFT2vOkvprXerkpwJtOOWUpHAEvt116ruHdiEnCArHSHL
X-Google-Smtp-Source: AGHT+IHbnczokXlnFLy5xqzF4Qr214VrjUX7vZcz8g8MFj9yTemo+XxyG7CZJXhD9bdruipYl0oSsw==
X-Received: by 2002:a17:902:e552:b0:200:7d10:b88a with SMTP id d9443c01a7336-2007d10ba7cmr25669155ad.56.1722982188557;
        Tue, 06 Aug 2024 15:09:48 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5916e836sm92477705ad.184.2024.08.06.15.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:09:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 6 Aug 2024 12:09:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <ZrKfK1BCOARiWRr0@slm.duckdns.org>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240723163358.GM26750@noisy.programming.kicks-ass.net>
 <ZqAFtfSijJ-KMVHo@slm.duckdns.org>
 <20240724085221.GO26750@noisy.programming.kicks-ass.net>
 <ZqmVG9ZiktN6bnm0@slm.duckdns.org>
 <20240806211002.GA37996@noisy.programming.kicks-ass.net>
 <ZrKW2wZTT3myBI0d@slm.duckdns.org>
 <20240806215535.GA36996@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806215535.GA36996@noisy.programming.kicks-ass.net>

Hello,

On Tue, Aug 06, 2024 at 11:55:35PM +0200, Peter Zijlstra wrote:
...
> > > And the above condition seems a little core_sched specific. Is that
> > > suitable for the primary pick function?
> > 
> > Would there be any distinction between pick_task() being called for regular
> > and core sched paths?
> 
> There currently is not -- but if you need that, we can definitely add a
> boolean argument or something. But I think it would be good if a policy

Yeah, SCX might need that.

> can inherently know if curr is the better pick.
> ISTR you having two queue types, one FIFO and one vtime ordered, for
> both I think it should be possible to determine order, right?

It is tricky because the kernel part can't make assumptions about whether
two tasks are even on the same timeline. In the usual scheduling path, this
isn't a problem as the decision is made by the BPF scheduler from balance()
- if it wants to keep running the current task, it doesn't dispatch a new
one. Otherwise, it dispatches the next task.

For core sched, once dispatched, global (or rather core-wide) ordering is
established according to the wallclock dispatch order. I don't think always
following that order will break anything for scheds that support core-sched
but it is an unnecessary thing to do in the non-core-sched path.

Thanks.

-- 
tejun

