Return-Path: <linux-kernel+bounces-444966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E949C9F0F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086C0164870
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AA21E1A35;
	Fri, 13 Dec 2024 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ1hhwwf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB31E1A08
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100484; cv=none; b=RpEs2jdN00SenTSrZ+XtczJ6kozHPqcRASl+jw57QkIvSCD/87NSFbdsjpYRiCAD1AGPXnxkQ85eL7XKg0QJsq9eiHrbfVNhNOYw7c+Wel2pvHH4+4rseBXl8ZI2eFsu9iYufEYlfWnSxIq/8qGtj/oyNvIzEEwEQUIJTIpHu58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100484; c=relaxed/simple;
	bh=WmozSn24zm/qMbPlMDouk38wksQoEG3qEiOEDvjbk3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLQEcYNx6CwBbYK016MuvwaISaqId7QRRdEY4fhC0jqyjLNRfypNVaSZpTzcfseOiJjvKaHT8VgSy/0RCC2MvoQ+5IPbpWqgEftdloF1+LGJYVvX5N01qUpeYkC+E87lYms3JiLBbzZcodZOOjfyBR2puu6Xt3MMnKN/N+S4ano=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZ1hhwwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973C0C4CED6;
	Fri, 13 Dec 2024 14:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734100483;
	bh=WmozSn24zm/qMbPlMDouk38wksQoEG3qEiOEDvjbk3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZ1hhwwfsyrP7+f8z6dU5nfKq0B5HaDlxmkTLe+jHmrypG4eZt2UJU83IUaSqk4kz
	 cU1+/5JqGkCG+0SQMyRvB+uzu0n4wQyVn2DkOVIywNgv3hs+np8BloWQIBP9iZ1Bfx
	 chUhpQSHh17Oz3XY6mkZ4w6q7yku7qI+EMfpVsT6NGaevsHd1NF8Ro8ocKZueAn8ed
	 h1h+J8GodqZr1wdJZYlOJOQrXSB2S6T/59B4/IYxj/ULR4tLLN9SZGLokgykQd8axZ
	 JIMIxwzUwNxHfoSAKmTel3MvxC3h1XkOJqu9mXmeZw6iPh0tdfevtLM77ARr79qzxg
	 v+4lOnbC6NBWg==
Date: Fri, 13 Dec 2024 15:34:41 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, bigeasy@linutronix.de,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [PATCH v3 6/7] osnoise: provide quiescent states
Message-ID: <Z1xGAYQbn4yKy3MC@localhost.localdomain>
References: <20241213040658.2282640-1-ankur.a.arora@oracle.com>
 <20241213040658.2282640-7-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241213040658.2282640-7-ankur.a.arora@oracle.com>

Le Thu, Dec 12, 2024 at 08:06:57PM -0800, Ankur Arora a écrit :
> To reduce RCU noise for nohz_full configurations, osnoise depends
> on cond_resched() providing quiescent states for PREEMPT_RCU=n
> configurations. For PREEMPT_RCU=y configurations -- where
> cond_resched() is a stub -- we do this by directly calling
> rcu_momentary_eqs().
> 
> With (PREEMPT_LAZY=y, PREEMPT_DYNAMIC=n), however, we have a
> configuration with (PREEMPTION=y, PREEMPT_RCU=n) where neither
> of the above can help.
> 
> Handle that by providing an explicit quiescent state here for all
> configurations.
> 
> As mentioned above this is not needed for non-stubbed cond_resched(),
> but, providing a quiescent state here just pulls in one that a future
> cond_resched() would provide, so doesn't cause any extra work for
> this configuration.
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

