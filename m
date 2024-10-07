Return-Path: <linux-kernel+bounces-352991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2C29926FD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E2331C2231D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A80818B491;
	Mon,  7 Oct 2024 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0FSRGBYr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D9016849F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728289736; cv=none; b=g+1HhiORPBE3NhOI6xMR3nGh5ojMTCEgvSswUv+pxtsXaFKuzngCqlH3A1Uk6T0t7NrxefNZbaewa/DaLwmJs7PvtxV9EIsOWW7SHgJfH+VabTU5IorwuLQlAgTpIMutZPpOB2TlUFR69bsDpsIvYAoMHjuYVEtPCCAyooJPHJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728289736; c=relaxed/simple;
	bh=RVCxKzh4+uad97uPiRFC2x5cSWzlfqtGkfVHkugzk9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2dsUUq5IVjrfOAjTZ+DEn9shf+ccC2jGbbKYacOYbo3uojWFUiWyc5/QbNia0a+tnHkpcJtXwnhn5GCV1fqSBI7trr62cNWZW3jkGSdx2T0MyjMRMh6WOT0/ag6o1KCGYiMsBE8gXGi2EHD2pCSA4J1DzAIXDGeLDmwacDO83k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0FSRGBYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACB4C4CEC6;
	Mon,  7 Oct 2024 08:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728289736;
	bh=RVCxKzh4+uad97uPiRFC2x5cSWzlfqtGkfVHkugzk9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0FSRGBYrY2Gu2fH+wITOElqXWC4zAZdjxs4kFXi6KiTvFQ7pIe40edth1T5H26GNf
	 CxrF3ttHYEfzede9h0XamZTG6sN7/bAgwa8ziF84cG0yXC+NVgGwMbgDOWUGS9Hw9j
	 KOqriSG23VFd8wKgHjfs56qREuQqwDUyrGrJgrRA=
Date: Mon, 7 Oct 2024 10:28:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vimal Agrawal <avimalin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	Vimal Agrawal <vimal.agrawal@sophos.com>
Subject: Re: misc_deregister() throwing warning in ida_free()
Message-ID: <2024100732-debtor-panther-4a75@gregkh>
References: <CALkUMdT_Q9o-NDKhAk=v_ARSe541y6yeg8hacYJ2iZ5PGjjRVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALkUMdT_Q9o-NDKhAk=v_ARSe541y6yeg8hacYJ2iZ5PGjjRVw@mail.gmail.com>

On Mon, Sep 16, 2024 at 06:56:18PM +0530, Vimal Agrawal wrote:
> Hi Scott/ Greg and all,
> 
> We recently upgraded kernel from 6.1 to 6.6.49 and started seeing
> following WARNING during misc_deregister():
> 
> ------------[ cut here ]------------
> 
> WARNING: CPU: 0 PID: 159 at lib/idr.c:525 ida_free+0x3e0/0x41f
> ida_free called for id=127 which is not allocated.
> <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> Modules linked in: ust(O-) [last unloaded: fastpath_dummy(O)]
> CPU: 0 PID: 159 Comm: modprobe Tainted: G        W  O     N 6.6.49+ #11
> Stack:
> 818bfb70 6093f8d3 0000020d 61381660
> 61381630 60c1ee6a 00000001 60068c0f
> 818bfbb0 60983ee6 60983e5c 61381680
> Call Trace:
> [<60973831>] ? _printk+0x0/0xc2
> [<6004b2e6>] show_stack+0x35c/0x382
> [<6093f8d3>] ? dump_stack_print_info+0x1af/0x1ec
> [<60068c0f>] ? um_set_signals+0x0/0x43
> [<60983ee6>] dump_stack_lvl+0x8a/0xa9
> [<60983e5c>] ? dump_stack_lvl+0x0/0xa9
> [<60068c0f>] ? um_set_signals+0x0/0x43
> [<60983f32>] dump_stack+0x2d/0x35
> [<60983f05>] ? dump_stack+0x0/0x35
> [<6007aad8>] __warn+0x20c/0x294
> [<60068c0f>] ? um_set_signals+0x0/0x43
> [<60971d98>] warn_slowpath_fmt+0x164/0x189
> [<60222128>] ? __update_cpu_freelist_fast+0x96/0xbc
> [<60971c34>] ? warn_slowpath_fmt+0x0/0x189
> [<6022d2fe>] ? __kmem_cache_free+0x16a/0x1be
> [<60068c4a>] ? um_set_signals+0x3b/0x43
> [<60941eb4>] ida_free+0x3e0/0x41f
> [<605ac993>] misc_minor_free+0x3e/0xbc
> [<605acb82>] misc_deregister+0x171/0x1b3
> [<81aa7af2>] ustdev_exit+0xa8/0xc1 [ust]
> 
> basic code of calling misc_register()/misc_register() is following:
> 
> static struct miscdevice ust_dev = {
>         0,
>         "ustdev",
>         &ustdev_ops,
> };

Nit, use named-identifiers pleaase so we know what is being set and what
isn't.

> int ustdev_init(void)
> {
>         misc_register(&ust_dev);
>         return 0;

This can be just one line, you are ignoring if misc_register() fails :(

> }
> 
> void ustdev_exit(void)
> {
>         misc_deregister(&ust_dev);
> }
> 
> Note that this was working fine without any warning earlier on kernel 6.1.
> 
> I suspect it is due to
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.6.51&id=ab760791c0cfbb1d7a668f46a135264f56c8f018.
> It seems misc_register() is not calling any ida_allocxxx() api for
> static minor value of 0 but misc_deregister() for the same is calling
> ida_free() and hence ida_free() is warning in our case.
> 
> Please let me know if I am missing something or some of our
> assumptions are not valid anymore in newer kernel versions.

Can you submit a patch that works for you to resolve this issue?

thanks,

greg k-h

