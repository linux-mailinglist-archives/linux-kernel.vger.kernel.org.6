Return-Path: <linux-kernel+bounces-285399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC07C950CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2011C237CC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0751A3BDA;
	Tue, 13 Aug 2024 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bycpHs3A"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FDF1BF53
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576462; cv=none; b=DcH8Of2Ay/Znf5v4Q88VYE3/Ca38JzgF33bS1n6QNDdNNlV8ulkR98ZdDWc+0g9TwABQRe5rZvXFBBgwFs5AnZA2hPI7zn1Tm2kQY3+LsADTvqjAvCqV4jJcJOGGo2/Rw/aTcPnpOjfnwJEeQUYlTtR2mOZ+eTwaKwrP3uC3tWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576462; c=relaxed/simple;
	bh=Z4hPRLCyJ1fuVYVx1YTdeynkvH3nZxkn8qeVvlftpho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvLQjK1fBdlK9a3BG60oP0/XzXUn33rxpwzUqPLwcRQnpY4Nga8RC2wX6DehU85kP63dVROBru8faqfb6CpOekNQ+SDuzOMabYtQY04padxO9V90RPtKUUKbxwmzNzc0cachZWI5y493u0/Yoy+9TQy6xtkjAX9HHQdw+AU9/8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bycpHs3A; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc566ac769so52138635ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723576460; x=1724181260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kk1dkwlW2hC9K1+JmluU1TFqxsdzK0jmaUfE0EFr25c=;
        b=bycpHs3AF+6HPc/vmq3NVpMx7CJ2BlLl5G0fgItksCkQvdfzPdpy1jc/0Cz57CcuJC
         FJWqH+IjCDnrjCPN1FHAeGk263cc906so7/RWzINbnCZLA/HuVtJkjesbrxyrzx9VfMf
         XBwbDxnbhjdqiQKJUjXgn6y5XXyGQqWcUVjFCzBvYCh80nlfDPqaF+xg7+Sp5sPxR2nU
         7Ux/NV7cvmvTnmkAL0EfK53EF1ez0wz70YcNksQrdz7YfIYGrleO5jcvfKMyThhftdJa
         b4zzQCIRb0Yh7qGvX6EJ7U3wXrSHX99Q1k5p0Xj5ePTyTkLvftnVSPAiUWlXuAzOGOUC
         fUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576460; x=1724181260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kk1dkwlW2hC9K1+JmluU1TFqxsdzK0jmaUfE0EFr25c=;
        b=mOQTZD/SdM3kDkuiQPj0fMDVDlL3fJL9iTHtFkHXPal5XN48kiqXLBaLF1btnz5iA9
         xAiZOLhfwiGZ9jEXYVsrHwm7lc1dxIbTLkQw5q7ZAtLvBsW3MNAAHRTTkZw3tSfDt8/O
         TrvvK+Oq/u4qRmgJ969BimogNOzMaer6syshuQw9u38Na8CwnhwE2FFkUBLM+zUQbZat
         EhTZgIQS38onVJRO6nwp8HzI7OyS3E/SD29of91WUNA+OjhpwOiYew25AYE+gj/9UzPa
         ogMD3PkI4LhHbpi2Cj8wxdDrXjlyQCgQBr5JtDAieohJ8c/TorCma9feZirFH3Ga6VuI
         oLSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA4+eya9vr06NdvOcoZrckHgqb9yf+R/8NtjT5G/7Ums7kPuFbiYcW48ZI7t9tUfKTwGryaMt7o/nI2ztwp4/3toTx7Qfjh9x2pgKn
X-Gm-Message-State: AOJu0Yz6soCkJH784fKtoISJ9lVsZipLrsI2WoC9bRQHRWZv6R16pOXD
	EQzT8eWm5YoA9yxlxp5UsSJLUwentFzSAfuBbMp78L30rEsLdk23
X-Google-Smtp-Source: AGHT+IFzrTEx/oFhW/dv85qL35d8I06sSC2BVqI1ByoN11J4CV0eVl6kh6yBsyPr184O4XjGWk9E5A==
X-Received: by 2002:a17:902:c40c:b0:1fc:86cc:4267 with SMTP id d9443c01a7336-201d644d7b2mr5286465ad.36.1723576459861;
        Tue, 13 Aug 2024 12:14:19 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1cfe71sm16888035ad.285.2024.08.13.12.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:14:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 13 Aug 2024 09:14:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <Zruwioj86jQz8Oq6@slm.duckdns.org>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240723163358.GM26750@noisy.programming.kicks-ass.net>
 <ZqAFtfSijJ-KMVHo@slm.duckdns.org>
 <20240724085221.GO26750@noisy.programming.kicks-ass.net>
 <ZqmVG9ZiktN6bnm0@slm.duckdns.org>
 <20240806211002.GA37996@noisy.programming.kicks-ass.net>
 <ZrKW2wZTT3myBI0d@slm.duckdns.org>
 <20240806215535.GA36996@noisy.programming.kicks-ass.net>
 <ZrKfK1BCOARiWRr0@slm.duckdns.org>
 <20240810204542.GA11646@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810204542.GA11646@noisy.programming.kicks-ass.net>

Hello, Peter.

On Sat, Aug 10, 2024 at 10:45:42PM +0200, Peter Zijlstra wrote:
...
> > It is tricky because the kernel part can't make assumptions about whether
> > two tasks are even on the same timeline. In the usual scheduling path, this
> > isn't a problem as the decision is made by the BPF scheduler from balance()
> > - if it wants to keep running the current task, it doesn't dispatch a new
> > one. Otherwise, it dispatches the next task.
> 
> But I have a question.. don't you clear scx.slice when a task needs to
> be preempted? That is, why isn't that condition sufficient to determine
> if curr has precedence over the first queued? If curr and it is still
> queued and its slice is non-zero, take curr.

scx.slice is used a bit different from other sched classes mostly because
there are two layers - the SCX core and the BPF scheduler itself. The BPF
scheduler uses scx.slice to tell the SCX core to "don't bother asking about
it until the current slice has been exhausted" - ie. it's a way to offload
things like tick handling and preemption by higher priority sched classes to
SCX core. When scx.slice expires, the BPF scheduler's dispatch() is called
which can then decide whether to replenish the slice of the current task or
something else should run and so on.

Thanks.

-- 
tejun

