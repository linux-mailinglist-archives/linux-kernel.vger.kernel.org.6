Return-Path: <linux-kernel+bounces-380522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F12109AF041
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C67BB21E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A86215F79;
	Thu, 24 Oct 2024 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtWwph3O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8FB2101BC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796177; cv=none; b=ft2QBlqBQ1ygPCp8onKAunXaQmP6i4Am5uYdCCQA8pk/nxsOWp/NuqIfNDrhnwUKNaVaj/VGzgSg/GUto4IDdbVl24VpK6rca09WbuheJE37KLsI8EU9H0/UOMnIsPvU23VkBi+v0rMIfNHeXcMKk1aTaJKdhyJIzj8zzoYjhJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796177; c=relaxed/simple;
	bh=E4XmmyC8mZy9ddoYetj7v9b0ZFybn3eTHJUa4mE18o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B14VtJCPnmpVszAimBNP/TGNESR0lBtphLHZo+Qnvi0BOTbZemu8FRZNNirFRAVg0SJKFaAHDOn7mICm8GlYPqtN1SrfCGW4geWUsxu6R1CWQ2boLrZhEgmrG6ho9IHAy41KLxuuOF9IJ0JEjuw2DtpaQ9yBkoQsrl2L13JAiq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtWwph3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB20C4CECD;
	Thu, 24 Oct 2024 18:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729796176;
	bh=E4XmmyC8mZy9ddoYetj7v9b0ZFybn3eTHJUa4mE18o8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UtWwph3Ow9jiJR7pi1CpDbYrLm13Fhuqr3gx/4mG/dt7Xq3P5/jtswgl2N2ICimE/
	 488cJBHvDHCdVeat5S30Ee3t7eNXnM0F72mHgGd1TlF7eXi3uOdNnKdY4GSfgQKWYI
	 6/jXrDWfenxSR+cREJO0xRzngW5gy+0YIM7VTjIEFVWZPowEQrIPPYmsTi8Etlcuq2
	 6NpfmeDKi204LT2bwwYyFo+EPnUAaai22VhV1RgW29CfOPPHtEYQgEGeOtxkR46rYE
	 w1LRvBTc8aTs1ci+jkgckMq5w7RykxJ9XuWx+NwugDAJ5CRmyy0/ubw0SzWGXNg4Ze
	 zkmwwJPtpRFiw==
Date: Thu, 24 Oct 2024 08:56:15 -1000
From: Tejun Heo <tj@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: jiangshanlai@gmail.com, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, jack@suse.cz, david@fromorbit.com,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: workqueue lockup debug
Message-ID: <ZxqYT9RfTBebgIIc@slm.duckdns.org>
References: <70cb224f-a468-40a0-82c7-735c590bdb43@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70cb224f-a468-40a0-82c7-735c590bdb43@oracle.com>

Hey, John.

On Thu, Oct 24, 2024 at 04:49:40PM +0100, John Garry wrote:
> Hi workqueue and scheduler maintainers,
> 
> As reported in https://lore.kernel.org/linux-fsdevel/df9db1ce-17d9-49f1-ab6d-7ed9a4f1f9c0@oracle.com/T/#m506b9edb1340cdddd87c6d14d20222ca8d7e8796,
> I am experiencing a workqueue lockup for v6.12-rcX.
> 
> At the point it occurs, the system becomes unresponsive and I cannot bring
> it back to life.
> 
> Enabling /proc/sys/kernel/softlockup_all_cpu_backtrace does not give
> anything extra in the way of debug. All I get is something like this:
> 
> Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
> Oct 24 15:34:02 ...
>  kernel:watchdog: BUG: soft lockup - CPU#29 stuck for 22s! [mysqld:14352]
> 
> Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
> Oct 24 15:34:02 ...
>  kernel:BUG: workqueue lockup - pool cpus=4 node=0 flags=0x0 nice=0 stuck
> for 30s!
> 
> Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
> Oct 24 15:34:02 ...
>  kernel:BUG: workqueue lockup - pool cpus=31 node=0 flags=0x0 nice=0 stuck
> for 49s!
> ^C
> 
> Can you advise on a robust method to get some debug from this system?
> 
> Maybe this is a scheduler issue, as Dave mentioned in that same thread.

So, while the symptom *could* be a workqueue bug, wq lockups are usually
more a side-effect of some other problem. All that wq is saying is that some
work item hasn't made forward progress for too long. Given that there are
soft lockup messages, which can't be caused by wq lockups but can definitely
trigger wq lockups, I'd start with debugging what's happening with the CPU
that triggered soft lockup. Soft lockups are nice in that they're
synchronous failures, so probably start with the backtrace?

Thanks.

-- 
tejun

