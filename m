Return-Path: <linux-kernel+bounces-276763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D0A94981A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40FF1F22A3C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D835F80024;
	Tue,  6 Aug 2024 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDoSr4xP"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EDD40856
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722971853; cv=none; b=by6Bc4yIF8V11GkhRw73ZxWHOxGxcPfxIXqmExFIUQwOPwewk27dKva+6SZqimHHiRAAyvjlcnZ1I3vaan87ydtWR8jzVwTSrxREwknbfttYJuHpWr9oFrRGW7j+SyIEYXTFrd5PzB1S96/mquPr8I06z4fFxVXlF+YsHsprZ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722971853; c=relaxed/simple;
	bh=k6PSehkdiekouwi0jbRRKrJgrcWxts9+VUKJBDpGaF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFydiPvGzhzwu7S2URQPqIdS9gUP1c1B7ds0y6S5xeAQ5lNqcTnUaX2C6i0V26UOhOxA/b7YK0rgIrtXaPAVCoh8DdDe/TATSZWlRrTaLmpIKcRmZ0bNipxaxrW2HYzz/+1xBdIWTtMZloOskbZCIIhmVEqeXjIqQvuYQ++BIHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDoSr4xP; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cfd1b25aaaso708701a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 12:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722971850; x=1723576650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMfaU94uS/PR2ce3hWrBFv7L3Kbrx21yZuXtJnLkfas=;
        b=TDoSr4xPajhyD7yjUDWbKiUMojJnObxetTR4Bho0Ae+muiw/l9QrWoYDQjdixCdjkh
         x9uAbIu/6XDTs7BQXRexny5uKZxgOoV1u6CsrxqDHj7q8ICZ5j6IrbIz4Z0wFv46QW4y
         v3DUbZPsdtCFCJVFgIUShFu6BJkMlqIVjs/g5DhOA4XuKwk3Oa02eNOZXwlojyY4YVwP
         2Ss2KYNGiRKgnwveX1jpjd9cxO5LImTV9bZix2MR1yQawpapWa4esT7/lJNeS2SEg9wE
         P1vB1kaHP8aYKUipLndQ1cPB/9sNEBOD/vscikZOVo8MamoKHh6Z8O6ng1/katd8KAJM
         YHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722971850; x=1723576650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMfaU94uS/PR2ce3hWrBFv7L3Kbrx21yZuXtJnLkfas=;
        b=cuww8HcdwRqZGOp4GWnq9DjCmmIt0jcJ3Gz3cnqwsUgEYHA05cI01604cDCkxd3ZnB
         N7LN3OiWzEXF/yPHv01EI2A37FX8iQkk6/E236w/lm5BMXLYPQiPgFpfKnjAbf0B7Iub
         Eki9lRNdWJMVi74RTg9UwoaDKsLjJ+7sof1QYq884p+o9lqC2eMjLEgCtDSkSRIQE2PL
         fck4u8mYn3ww3oO7FL3R2/jl0MWnzZ6ji0YTwUrSX1yowm6ssGSbkuLE6CifYRGkdH31
         LqamZbaD817YSzj5OD9QxSvnZ51HGYwtvAs+l4Z22AwB5HnWrZ5U3LNBFOT1Fa2QGxuh
         IJgA==
X-Forwarded-Encrypted: i=1; AJvYcCXRyGzincRTg8YnaaLNorDhoRw2YjjnCEdS2W/1s3jyBa1SPIwQGKtoNSXAzOwQAZ97KN4DcZaliMhly492R4J5IgN4K/cDLdv/azNa
X-Gm-Message-State: AOJu0YxqTL1EzdKi+b6+/UEL7owtrw5IF7hL+cvKpFHuxfncHSCCHhrc
	Ma8Q1wqqTxR90ITwgLQJV7cF+VvV3xmcLHdZYj1/Ptsbpwt3GX5Y
X-Google-Smtp-Source: AGHT+IHxg0EHuAI0Mmmg1UPApTGLG3VZ3ZLce217EYOByru0vFJnpe6Z79rZB0ES8QrAuPSXizUo1A==
X-Received: by 2002:a17:90b:3882:b0:2cf:cbc7:91f8 with SMTP id 98e67ed59e1d1-2cff9444f4bmr15004352a91.19.1722971850151;
        Tue, 06 Aug 2024 12:17:30 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc42f9bcsm12956173a91.19.2024.08.06.12.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 12:17:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 6 Aug 2024 09:17:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <ZrJ2yKrKuWOscRpf@slm.duckdns.org>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240723163358.GM26750@noisy.programming.kicks-ass.net>
 <20240802122034.GZ12673@noisy.programming.kicks-ass.net>
 <Zq0p154ndOtU9Ypu@slm.duckdns.org>
 <20240806082716.GP37996@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806082716.GP37996@noisy.programming.kicks-ass.net>

Hello,

On Tue, Aug 06, 2024 at 10:27:16AM +0200, Peter Zijlstra wrote:
...
> > When !CONFIG_PREEMPTION, double_lock_balance() seems cheaper than unlocking
> > and locking unconditionally. Because SCX schedulers can do a lot more hot
> > migrations, I thought it'd be better to go that way. I haven't actually
> > measured anything tho, so I could be wrong.
> 
> So I think the theory is something like this.
> 
> If you take a spinlock, you wait-time W is N times the hold-time H,
> where the hold-time is avg/max (depending on your analysis goals) time
> you hold the lock for, and N is the contention level or number of
> waiters etc.
> 
> Now, when you go nest locks, your hold-time increases with the wait-time
> of the nested lock. In this case, since it's the 'same' lock, your
> hold-time gets a recursive wait-time term, that is: H'=H+N*H.
> 
> This blows up your wait-time, which makes contention worse. Because what
> was W=N*H then becomes W=N*(N*H).

Thanks for the explanation. Much appreaciated.

> Anyway, at the time we saw great benefits from moving away from the
> double-lock thing, it might be worth looking into when/if you see
> significant lock contention; because obviously if the locks are not
> contended it all doesn't matter.

I think we *may* have seen this in action on a NUMA machine running a
scheduler which doesn't have topology awareness and thus was migrating tasks
across the boundary frequently. I'll see if I can reproduce it and whether
getting rid of the double locking improves the situation.

Thanks.

-- 
tejun

