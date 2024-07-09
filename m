Return-Path: <linux-kernel+bounces-246497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B1E92C2A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08271F25480
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAE717B023;
	Tue,  9 Jul 2024 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQSIo0lM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4DB1B86F8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546886; cv=none; b=n2oq5F/KukkbOCk9rN7WdEahgPIfS6X/Vuq5NY17u/tlREziaw5+BDwTA/Ag3ox/A3AYiTajA2HbyLUK6UllEL1i+38C0nlnni7KRO9HQlVZiIu1FaIcMmP9OD9oTUQ/Wrs0rTS11b+qp9LN41AMJ9w6+BCFM319GWU94fEYb2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546886; c=relaxed/simple;
	bh=dpQsM70QaCOUDwXwlC9bFXL1a5ELhi8e4N588OPS+A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8xI+lCvZD/iB6+7lN4TcW1PmZaIW3njTjnkirasztp5WYGqfe9VYwkcuaoEb7FgjUxGYwg1CS6tuY5VGBXKoIHElrkWmaQGn9Fwerp7cW5brreXdPr3BYVrTPG16JmER7ruVxfgKu+MvtRRYgrWES/f6nPk4eHKp+mZc6Zv3lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQSIo0lM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38938C3277B;
	Tue,  9 Jul 2024 17:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720546886;
	bh=dpQsM70QaCOUDwXwlC9bFXL1a5ELhi8e4N588OPS+A8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=FQSIo0lMFPeVg0Md/0gxAj8VEYa+PtL7VpVpA4QPyPDI7OMwEgpRC+v8JOSJFdA6I
	 Odnfo/djM8+S8dxurJ0Cy/PGpYYDRqeo/LbvfXn5/eZLrzsezVtQLmlUmvQ/8c50ga
	 IM0Fhq6B0aCPlRKNpMFBWjHzLjQMFDE2akzBP2xj+QCKYPYHnEkzEw7IJEw9J3tpOG
	 3/9mxiV922eUnREFsJgYiR0ioUa86ItMBiDOOMg2tHOaTDWs0otj5ScNDRKcDaGawB
	 eAraQJD3aAeGljjB7XpnIy5pK3L60JMLVmKoc6iPNq0ink3H+IiSL/OnLGK7pedesK
	 mG4bUHYv++0zw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CCC9ACE0A45; Tue,  9 Jul 2024 10:41:25 -0700 (PDT)
Date: Tue, 9 Jul 2024 10:41:25 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: imran.f.khan@oracle.com, tglx@linutronix.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smp: Fix missed destroy_work_on_stack() calls in
 smp_call_on_cpu()
Message-ID: <4673661c-b6c0-4188-a98c-83dfdda48a13@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240704065213.13559-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704065213.13559-1-qiang.zhang1211@gmail.com>

On Thu, Jul 04, 2024 at 02:52:13PM +0800, Zqiang wrote:
> For builts with CONFIG_DEBUG_OBJECTS_WORK=y kernels, the sscs.work
> defined using INIT_WORK_ONSTACK() will be initialized by
> debug_object_init_on_stack() for debug check in __init_work().
> This commit therefore invoke destroy_work_on_stack() to free
> sscs.work debug objects before smp_call_on_cpu() returns.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

I have queued this for testing.  My guess is that it should go to
mainline some other way, so:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/smp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index cc13e73a887c..61f10f982341 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -1135,6 +1135,7 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
>  
>  	queue_work_on(cpu, system_wq, &sscs.work);
>  	wait_for_completion(&sscs.done);
> +	destroy_work_on_stack(&sscs.work);
>  
>  	return sscs.ret;
>  }
> -- 
> 2.17.1
> 

