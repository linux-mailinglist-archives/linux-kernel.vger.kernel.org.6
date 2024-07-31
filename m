Return-Path: <linux-kernel+bounces-268398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 690B294242E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3181F284CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AE7C2FD;
	Wed, 31 Jul 2024 01:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5jDQBuF"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6445E747F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722389791; cv=none; b=Vc3DKSF3TslA6dQyDV3DLL37CrNgPfXrKG0KSM5KzMwBoha1Y5KvwAcngjYDjyPDEL/n4JpEqCQgWRXMKK1p0E2BUmE+VVgCNL/FVJ8oW/ECW/ixgu1UCtOCRVVyjjuOmWfrBOI91SnaIPNhIl6ORFsj5krUWF/t94VpauXrjos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722389791; c=relaxed/simple;
	bh=eSzJfzUYnKqe36BXtfv5ZvpHrJeSlTrH1eHLlWfoDOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnz4mNq+7+9MMs3i+wm5o0rkTNNcuo2D6uGZT03y0jEqeQPqCLa5IdLInnRKr0Cdn+xDAAh6GkTVj50/7eX2HfCsoYUxA4DXRMski7CL3MsDbYED/zwNj+i28zM+US84bAarcRYHHb03GlFLI0wkEM2ZpeHzGoRVQrt1RG1GPoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5jDQBuF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d2d7e692eso4182135b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722389790; x=1722994590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwjtumsy+UxHmt2SoXzIudT1ss3Em21PFEzhVzZB/tw=;
        b=h5jDQBuFsngRNSfGCOTjv5ASityvxHdWxCOkXLdFIZH6rElhDCnALftsxgfyE6rZjs
         zdVfeObqxG2lvxxGDqeq7erE+YTN0blJRZL+GJhF3SWugaz/F4H+ju3kYv+CgAeSVVsG
         TfUFKJn7bFG+5AX/MjZ7zaYxafraNuu/KfoDdCf71PyedGRCy7K8exg76PQQanBgCH37
         EwJAYGajlt69CYEviKuR7BXJa8cnDtqQ6g2bYQkqQXXCPpC43UpjJKp7oi1IQCs4AR30
         NSkVB555g8JG4Z6TGUfiHZQwrrUGMImMUoPVVsjxvlbdnI9QouwIJJ+KwzvEnFfsTo0s
         cbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722389790; x=1722994590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwjtumsy+UxHmt2SoXzIudT1ss3Em21PFEzhVzZB/tw=;
        b=l7AA4QxftnzMrD9YHatN7QV46jBvUDDPUMshQ7f9NFZVNRdCVamJP4o/7HFW9R2ktY
         OG4+TLMtnGNXlgkH/Ri/ekmfgjKnXnr3g5nwRt72JS/BXChd67cUfBAGsBhrPdDd2Vpv
         pAjz2N9Dj1YPTFtzhYJ+NekCQGgT9ES1mUmLOjk+RUX9g65bDuYmly9uIM23MXOr4Xt2
         cn0BmpbQLU+0aP+F8Q28qvVjFKLMyL7mFGBMarIUFdoSSobxrDnpwqjo50ynePMw2H0+
         O29hF2Kgg2mq9keeNCm9aT+jXGt5YZuxr+jaI0iK0vhQCGbOv7xKTKdBYNncJ6Pv+ZCb
         IT6w==
X-Forwarded-Encrypted: i=1; AJvYcCXkrcRcliq9uL31eT3i9O2+anqJ4LqMoFE8mrvd3xOooLRR8vBc4IYHSfjeJgWOl7WNnsg6lc5NzcK44Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCX+gfqFGFOyH6ER9M69GUA8fz6TxvSjeYVLgJZ7L3djqGxxyS
	b1BEp4sj04VYqdagf6kO4SJNxzDaaYc45aITttukM3h8/PXRKwH4
X-Google-Smtp-Source: AGHT+IGsBp+s7v3vzAlJAZSt65IVOhX1pdbnhROQD7WQbmHTJTAKib9LG14nVWLIySTryJ1l5o6orQ==
X-Received: by 2002:a05:6a00:6f5b:b0:70d:2ae2:ceed with SMTP id d2e1a72fcca58-70ecea1ae3dmr9756911b3a.7.1722389789524;
        Tue, 30 Jul 2024 18:36:29 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70eeac70b21sm3695138b3a.51.2024.07.30.18.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 18:36:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jul 2024 15:36:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <ZqmVG9ZiktN6bnm0@slm.duckdns.org>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240723163358.GM26750@noisy.programming.kicks-ass.net>
 <ZqAFtfSijJ-KMVHo@slm.duckdns.org>
 <20240724085221.GO26750@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724085221.GO26750@noisy.programming.kicks-ass.net>

Hello,

On Wed, Jul 24, 2024 at 10:52:21AM +0200, Peter Zijlstra wrote:
...
> So pick_task() came from the SCHED_CORE crud, which does a remote pick
> and as such isn't able to do a put -- remote is still running its
> current etc.
> 
> So pick_task() *SHOULD* already be considering its current and pick
> that if it is a better candidate than whatever is on the queue.
> 
> If we have a pick_task() that doesn't do that, it's a pre-existing bug
> and needs fixing anyhow.

Right, I don't think it affects SCX in any significant way. Either way
should be fine.

...
> > Yeah, this came up before. On UP, SCX either needs to call the balance
> > callback as that's where the whole dispatch logic is called from (which
> > makes sense for it as dispatching often involves balancing operations), or
> > SCX itself needs to call it directly in a matching sequence. Just enabling
> > balance callback on UP && SCX would be the cleanest.
> 
> Or make scx hard depend on SMP? Are there really still people using !SMP
> -- and I suppose more importantly, do we care?
> 
> I mean, they could always run an SMP kernel on their UP potato if they
> *really* feel they need this.

Maybe, but at the same time, it's also just some isolated cruft that enables
UP support, so both sides of the scale seem similarly light-weight? I lean
towards "why not support it?" but don't feel particularly strongly about it.

Thanks.

-- 
tejun

