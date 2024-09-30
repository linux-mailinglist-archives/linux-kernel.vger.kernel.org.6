Return-Path: <linux-kernel+bounces-344474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807C698AA27
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40841C219A7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FB3196C86;
	Mon, 30 Sep 2024 16:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="BXZ90UMo"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CD5193417
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714641; cv=none; b=KcAU+8O48pt1DdOBdcTILMyGiOBOwXxmqQmZ7/Bf2aU04POMtWqJ/h4FtB15S9Hc1KQG/1cMaPVcd2xFFBNhFO/uGXTY+Xxs21uR689VGQZEsMMItwYlnKpq+56H7OMmVERDRAMf/BAkrLXTdvWrbS1yBV1gQbJH2iO1Ln+onts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714641; c=relaxed/simple;
	bh=QKNtRSc2cNCYGCwqn1eTBhtDpFJPYjvSXYdly8vAgBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hY/Pt0rFXuygJ98EzmKtju7TepWqz/aYcvSoK6E8jdmMaV7xYc8ra99k0n48u3G+x0S7DnvxCX2hw4FYTNHDxlUEI4w8BqFE0gC3RkM5dZkcbBDR1u6EuZ5rHEsDcPv4olrJcxwIZc8WTopjxNQ+BvcJGEYL/q9wLz5eU4DhSqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=BXZ90UMo; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a9ab8e5f96so387662485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1727714638; x=1728319438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cOmsLRCNGVCtqpLkiEPmqmMJ6TKdIvwB/jyhOC3obpY=;
        b=BXZ90UMoVbSfcEije5PHCh9lYSbeUp9RHVRf1AnqVcMiuVdzkppOj4GZksH4ktGK7M
         /+mcxAWrrYJIegmP5mXr9h3tym1R4inOcrPq/5rKLskUFhc9vbCIxWqosXxRCvfS+IzX
         Hkwb6FY0HMh34NDFgoju+CK0GgELer1bMOxkunPoUNQQIu2y7x9swZxGYslmgTVLiXpd
         6J/w8vLvEuzi0/XjLUODYF0OPka7Gw6L9yY22/qxgHQQhdrH6oT7k5El24aNOFtgohKv
         8SMHZhNOJquSG7JmkHSOB/Jz50TDAU+df+3KoOjGDvl5bSWAzlJyMAErXQ1VSQGAQbQC
         bh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727714638; x=1728319438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOmsLRCNGVCtqpLkiEPmqmMJ6TKdIvwB/jyhOC3obpY=;
        b=qoYXlVnlEN9XalMv5GtdCe8zYFstt4f/zm6bhorMU4MfgVzWbvXgIIjus/tVMuImnr
         5nV9GqWGxKgSUg6J0AclKCGuRCpnxad5oLD/JGdRXGQVQwUQ3gc/4Rh5eTf5bCD+12kT
         KfISJP6TQUxcxMR8eyyWfP6QROAMdA4IRVDHl9PMm7kOAD5OBVO4c4hb8sDr27+ZkCvG
         ZEbpCyxiufrd9ZtZXMVsy2pzaHr763Sil9J1DTnjvmzsicRMgg3cvfnR9nRlK8n1TGO+
         NX3YUmJ2ZdZsFura7qJugQXUCnNuOLJ0IFcCfSim5ciJzEtKyS5A84gmtC6rLeVL1Pz0
         GsBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxm+VKLmfvpY6pWI3jARFpJiYckOcqn+hPrpokInrN8PffiUhCSslJI8RUV2UKgR/x3I6WG+Tz9Z0/vuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNsIh/kLfwbK7FcsvM74pxK/++LBv3UucpmfJM6KL9QwH5D+PW
	VC+1YugcoSoL/MVEYy/Cqw7nBdC0nhwftiP/TcFqno85llgXrUlooPwUeBCdEw==
X-Google-Smtp-Source: AGHT+IHsEwT5syMe6xjkTSTWIhlO/HTJ7JUiinZyPraGC1x0RYXykQwqYqv5YwDs8lui9gvfUyrG4w==
X-Received: by 2002:a05:620a:6002:b0:7a9:c129:4e5d with SMTP id af79cd13be357-7ae3b23c2d9mr1634819485a.62.1727714638513;
        Mon, 30 Sep 2024 09:43:58 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::5638])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3783fdd8sm426543185a.102.2024.09.30.09.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:43:57 -0700 (PDT)
Date: Mon, 30 Sep 2024 12:43:53 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>, Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
Message-ID: <2cdda043-1ad9-40cf-a157-0c16a0ffb046@rowland.harvard.edu>
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
 <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
 <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
 <9539c551-5c91-42db-8ac1-cff1d6d7c293@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9539c551-5c91-42db-8ac1-cff1d6d7c293@huaweicloud.com>

On Mon, Sep 30, 2024 at 01:26:53PM +0200, Jonas Oberhauser wrote:
> 
> 
> Am 9/28/2024 um 4:49 PM schrieb Alan Stern:
> > On Sat, Sep 28, 2024 at 09:51:27AM -0400, Mathieu Desnoyers wrote:
> > > Compiler CSE and SSA GVN optimizations can cause the address dependency
> > > of addresses returned by rcu_dereference to be lost when comparing those
> > > pointers with either constants or previously loaded pointers.
> > > 
> > > Introduce ptr_eq() to compare two addresses while preserving the address
> > > dependencies for later use of the address. It should be used when
> > > comparing an address returned by rcu_dereference().
> > > 
> > > This is needed to prevent the compiler CSE and SSA GVN optimizations
> > > from replacing the registers holding @a or @b based on their
> > 
> > "Replacing" isn't the right word.  What the compiler does is use one
> > rather than the other.  Furthermore, the compiler can play these games
> > even with values that aren't in registers.
> > 
> > You should just say: "... from using @a (or @b) in places where the
> > source refers to @b (or @a) (based on the fact that after the
> > comparison, the two are known to be equal), which does not ..."
> 
> I should also point out that it is not enough to prevent the compiler from
> using @a instead of @b.
> 
> It must also be prevented from assigning @b=@a, which it is often allowed to
> do after finding @a==@b.

Wouldn't that be a bug?  Consider this litmus test:

int x = 0;
int y = 45;
int z = 0;

void P0(int *x, int *y, int *z) {
	int r1, r2;

	r1 = READ_ONCE(*x);
	r2 = READ_ONCE(*y);
	if (r1 == r2) {
		WRITE_ONCE(*z, 1);
		// L1: WRITE_ONCE(*y, r1);
	}
}

void P1(int *x, int *y) {
	int r3;

	WRITE_ONCE(*x, 45);
	WRITE_ONCE(*y, 56);
	r3 = READ_ONCE(*y);
}

exists (z=1 /\ 1:r3=45)		(* Not allowed *)

If the compiler were to make the extra assignment (basically, 
uncommenting the line marked L1) then the exists clause could be 
satisfied.  That would indicate there's a bug in the compiler.

Alan

