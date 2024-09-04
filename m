Return-Path: <linux-kernel+bounces-315896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7368496C84E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29EE11F22F99
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63461482E7;
	Wed,  4 Sep 2024 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzKhke+K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E071448E4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481393; cv=none; b=K17pIwlVYGufJx7I1IgXOSbokwkJSu0BdStgHA/rCsGVYqZAWwFamEgapaqQOhF/k1JswOiPTgmMg0UIErCMWbDuS+N8oXj6PG8xjPh9rCpB4ZWuJZ3fP0BEQqF+joFGblwEZvo6M0Q22Be1vHT5W1Srk7H3zLD3VFay/WpnR4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481393; c=relaxed/simple;
	bh=3Z5Z0J1ZhylaB1/TBVZ4A7jhfDLus4WEoNkPWSoDwQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpG5WeUcSYV0aHPkVRwvXlrcl2EwsBQl80pQzQGQaEkL3WH9ad/4nZWj7TBDsTZ6OODh5y4zn/b8aXGeJBYBNe21YG25KtuMxl352YMn2pjb3DKAewIfF+rJbUoNfsadx67M9Q1M0LzQ59gz1dHX7V+J0sgUW5Kbm9YDIF1NrlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzKhke+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8E5C4CEC2;
	Wed,  4 Sep 2024 20:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725481392;
	bh=3Z5Z0J1ZhylaB1/TBVZ4A7jhfDLus4WEoNkPWSoDwQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VzKhke+KWpPQUMiWvWIwKIGLZb0GFcw0wyzTD4TwQF8NcNuImTR5r0X1os1xRIrwQ
	 ukW7IWjpZ7D6A2QmlsvCSgENfO2GsC23AcZrED7KGGpHq49z0kQ/rLg1D3CK79JEXK
	 M6J8V7+FzUleKttTeIrQNhm2mahu81zi8JRpao+1BVd4nrQ5DlNwzF9bwNXGHi3KJR
	 phgnV16t5H1LW5jMeJXwtp4PLePi2GoDOuGDQesdnZ9RJHq/9PmUEDCb1t+jKm6MWy
	 dozXw213JCqsb/FyEJHcmDEJp2rZA6t4XPMxSL6116sr0K/ldeetIqS+DHVodIK05x
	 gmEb0EDYsXkCA==
Date: Wed, 4 Sep 2024 10:23:11 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Andrea Righi <andrea.righi@linux.dev>
Subject: Re: [PATCH sched_ext/for-6.12] sched_ext: TASK_DEAD tasks must be
 switched out of SCX on ops_disable
Message-ID: <ZtjBrxdWJzMBjTxW@slm.duckdns.org>
References: <ZtJZaKxg39SkQtMA@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtJZaKxg39SkQtMA@slm.duckdns.org>

On Fri, Aug 30, 2024 at 01:44:40PM -1000, Tejun Heo wrote:
> scx_ops_disable_workfn() only switches !TASK_DEAD tasks out of SCX while
> calling scx_ops_exit_task() on all tasks including dead ones. This can leave
> a dead task on SCX but with SCX_TASK_NONE state, which is inconsistent.
> 
> If another task was in the process of changing the TASK_DEAD task's
> scheduling class and grabs the rq lock after scx_ops_disable_workfn() is
> done with the task, the task ends up calling scx_ops_disable_task() on the
> dead task which is in an inconsistent state triggering a warning:
> 
>   WARNING: CPU: 6 PID: 3316 at kernel/sched/ext.c:3411 scx_ops_disable_task+0x12c/0x160
>   ...
>   RIP: 0010:scx_ops_disable_task+0x12c/0x160
>   ...
>   Call Trace:
>    <TASK>
>    check_class_changed+0x2c/0x70
>    __sched_setscheduler+0x8a0/0xa50
>    do_sched_setscheduler+0x104/0x1c0
>    __x64_sys_sched_setscheduler+0x18/0x30
>    do_syscall_64+0x7b/0x140
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   RIP: 0033:0x7f140d70ea5b
> 
> There is no reason to leave dead tasks on SCX when unloading the BPF
> scheduler. Fix by making scx_ops_disable_workfn() eject all tasks including
> the dead ones from SCX.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Applied to sched_ext/for-6.12.

Thanks.

-- 
tejun

