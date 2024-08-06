Return-Path: <linux-kernel+bounces-276813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AE29498B4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108A01C21748
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0A6154C11;
	Tue,  6 Aug 2024 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cd5nExca"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47271509A5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722974200; cv=none; b=sFbllOy56aRm3WI1koAMUHodS/5MMPggXqrv1cmJLEmntQg/0MJNRKI+zhAtjpq8vA8asxVGvlEY1f8rGr85kJU7hzSFVrDCBOEDzM68OAZBeR2SxeEz4bMPuA66ASXOkLtiM9OmTz/xNh/c2f4JsCrhBqpjx4Bx+39umG0AK5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722974200; c=relaxed/simple;
	bh=HKZbMCOIwSQKSdFzlrROMbmcSs4mOU0ZS3p84kQh67k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O522XpzN5NnIij05rK4TPvTto0ExUY8gPyGytOqMBYENT8jN6f+VUjcrb4k5QHofplfsfyX8LWrLNQm5q5tdiMD9KYWmr2mMp5BB2jRlRDcWVwZhKCDGI5lCJQB6FYga+DBo8y3hSydt3ba5qFYHaSAiPokD59w5rJmzUWVsrQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cd5nExca; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cfec641429so859983a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 12:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722974198; x=1723578998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6pR6VILnrsNI+V4gm9kLkUYCGd49prM/MIHXwLUDm4=;
        b=cd5nExcaEhwkUxmFuEKXSyh9unzyaTNyO0zTC6Bw4UVsAcH5ytz3Me6DBPKnkqUkQO
         T8gOkg5jxIDI4obYr/474GBQgiHfVByN9gTuZbqdC7Y84TMRttoxqU6B7knTngSTWGSG
         1QrBvM6GRlbeaNQYQKjWjo3wM15UhNxNs4+QdoZvxw884EEMsRPHqztxCX24Ap3hRIvW
         GPo3vsjBVlFGk9IE4o0T+3EbofIWE8Obd0SSo0CGWnnnv9G9Tk5AhW7CGj9fj6XMI6Hs
         0DxZpu8+9ybxzIueetDCdRuE3VEfhqPvIo5owdshxBcCc5lQ4WRQ53Y6AsO/3wQES2dZ
         y2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722974198; x=1723578998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6pR6VILnrsNI+V4gm9kLkUYCGd49prM/MIHXwLUDm4=;
        b=SRR9rb2CffeVKNs5Cmo0FM34TlHT+piFP4qcRcx0P3XVBnmhSZX/x9Usu4JXQN0lNC
         NLA08aaNH8asOk5sl+uI7byHS8YlTJsuhLLGFKPnX/oDC6c/eV7YeXJL7+73bHvMRWfj
         C+H2nFTyCrf+1rQQ7dgeGr+8ipX/jeAJYMz9zFzv/ERrealmHw0r1m+1Rm6ooklFaDup
         sLvPHEOyjy9rcFWLRezAM/cSW+w1jwXKV/ijUFbaV+BkzZDZ7srgUbtfCCJpxWeX/Qq8
         ySFhA5ozy2E18jvpC3eG40qXp0CLAnjHlGvYde+nMCcqxlVvp+ggpkyei8J/gxDgDwP+
         rTEg==
X-Forwarded-Encrypted: i=1; AJvYcCXCoUgX1+JHmJvwLUCe/mvcPR7X5o2+i2wvFIhrohkGH/wETh1CaY/wPDQvygDtXRUBb5dYgh8Prm8hH6D/eAZyqLuWcwJBfrPJuxoZ
X-Gm-Message-State: AOJu0YwgSER0WUXbjVPxo5dDB7G0QVrdI/kSw75PkSWctFMP2mWAChO5
	JDEZwxSpJLLUxq8FatBOhseCy2zKySDvTJTRmnJrVGRzRT00BToM
X-Google-Smtp-Source: AGHT+IFJrJphO3XbLVc576veL85uvGOA4deVYLBr2Klu1ylDwrMO01tmr8EFGGlDqoRcfHQHammR4w==
X-Received: by 2002:a17:90b:1a87:b0:2cd:2f63:a447 with SMTP id 98e67ed59e1d1-2cff95696cbmr14428633a91.36.1722974197876;
        Tue, 06 Aug 2024 12:56:37 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffaf9b54fsm9584476a91.20.2024.08.06.12.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 12:56:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 6 Aug 2024 09:56:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <ZrJ_9OF3TaXA3xtp@slm.duckdns.org>
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

Hello, Peter.

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

I haven't applied the patch to make balance_fair() test
sched_fair_runnable() instead of rq->nr_running yet but after that I think
all review points that you raised should be addressed except for the above
pick_task() conversion. If you want to go ahead with this change, please do
so. I'll pull in tip/sched/core and update accordingly. AFAICS, it doesn't
make any significant difference to SCX one way or the other and I think
updating shouldn't be too painful.

Thanks.

-- 
tejun

