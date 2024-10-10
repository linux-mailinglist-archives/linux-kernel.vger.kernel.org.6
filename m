Return-Path: <linux-kernel+bounces-358638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EBA9981D9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32FDF283FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82D31C68AB;
	Thu, 10 Oct 2024 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z5/nM39f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HomfR7za"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21C91BDA98
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551611; cv=none; b=BOrGT8T2qBGEmiVHc/fEkdxHjPgWoON1Zk2PPthwqiKyWXG9IAhWjnEpV74eDYaOelfkkfXDJdged8HsBaNTP98JflNvCprD6VLAfKUS/079i1YtSwPZ7GLA2dAOUQ1zfZwsgXmpKO9JyMUXiW0dbE45IZef+NiN2GKrZQiocmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551611; c=relaxed/simple;
	bh=v2qXdRGywrmWAUi3XQxVEjXlgJEp01Vr0m2ptLfaqhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jbu8yEGwhg+E0ISm2KqB9OdpK2nFH/MVDFfsqt6H1gLGXtnKIk3qwDMJg6qXZ9VemK7CGJ20MSo+hGAtNZsLSQ548Q7dVTCx9fRkSpKrmiIiDNDM2BhByR7LMOapseTbiJ0RM0GZqyjbtlujd/lyGmlRs6ASchuKqPPY84WvhFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z5/nM39f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HomfR7za; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Oct 2024 11:13:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728551608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGa9y3s0wFvlJXErQMI3rTU53Ymge+HcjW28OLuLTVs=;
	b=Z5/nM39flAiidwxl2IIZzS2DkVMUtWWCxl4b4llU7zQ3cS8NsdX0VZ/WMw7mXYHNUjPJzO
	Wq6eQVJZjqHQO8hmCdOD5GyXWTyduZuTEf8a89DuIuiwigULTEN079L72bMPlBsRyysoLa
	VCINz0FtpBh6nGf3g5cAgFA3D0aQyo3dNbN+t3HW0ikvjlcwiPRIocc3r5QRDSwY6NbME2
	PjhHD9IS12WLCmLzYRBS3g27zjmxuGE2klvmm1HJURs7HVf92u1T8HB/O70GdBlpCPF+6w
	wwNRoguo4lxiZ3n4GkK2Ga4ujsjyL4tKLerq2Y2VnpZvGMZIa7HVERaYQvxohQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728551608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGa9y3s0wFvlJXErQMI3rTU53Ymge+HcjW28OLuLTVs=;
	b=HomfR7zaDMngqxLVb+qS8lXlCC94rfh/UWBMDCjnIroJdXonI0F//kCSSrx6RyF3WjEv7+
	k7uFdD50tyhrG8Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
	efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <20241010091326.nK71dG4b@linutronix.de>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-3-ankur.a.arora@oracle.com>
 <20241009180117.GS17263@noisy.programming.kicks-ass.net>
 <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>
 <20241010063207.xIrynIqO@linutronix.de>
 <20241010081032.GA17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241010081032.GA17263@noisy.programming.kicks-ass.net>

On 2024-10-10 10:10:32 [+0200], Peter Zijlstra wrote:
> On Thu, Oct 10, 2024 at 08:32:07AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2024-10-09 11:24:09 [-0700], Paul E. McKenney wrote:
> > > In order to support systems that currently run CONFIG_PREEMPT=3Dn that
> > =E2=80=A6
> > > Or am I once again missing your point?
> >=20
> > The change is:
> > | config PREEMPT_RCU
> > |        bool
> > |-       default y if PREEMPTION
> > |+       default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
> >=20
> > Now:
> > - CONFIG_PREEMPT select PREEMPT_BUILD
> > - PREEMPT_RT select CONFIG_PREEMPTION
> > - PREEMPT_DYNAMIC selects PREEMPT_BUILD
> >=20
> > and PREEMPT_BUILD select CONFIG_PREEMPTION
> >=20
> > so in the end, this change is a nop, right?
>=20
> PREEMPT_RT selects PREEMPTION *and* has one of PREEMPT / PREEMPT_LAZY /
> PREEMPT_DYNAMIC, all of which in turn select PREEMPT_BUILD, which
> selects PREEMPTION.
>=20
> (arguably we can remove the select PREEMPTION from PREEMPT_RT)
>=20
> The proposed change is not a nop because the config: PREEMPT_LAZY=3Dy
> PREEMPT_DYNAMIC=3Dn will result in false, while it will have PREEMPTION.

I have a config with PREEMPT_LAZY=3Dy PREEMPT_DYNAMIC=3Dn  and
CONFIG_PREEMPT_RCU=3Dy.

I can't deselect CONFIG_PREEMPT_RCU=3Dy. This is because LAZY selects
PREEMPT_BUILD and PREEMPT_RCU selects itself once PREEMPTION is on.

> That said, I really do not agree with the change, it makes the condition
> complicated for no reason.

Sebastian

