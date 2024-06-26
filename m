Return-Path: <linux-kernel+bounces-230204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 029E59179CA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180C41C228E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF03A15AADB;
	Wed, 26 Jun 2024 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jRmuZoG4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F02158211
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387224; cv=none; b=EVujdPW+jRNWv2Tatf3y5rXD2Qsg+1kh/ERGxTQXF7r9LiTPzQrJNr6EMfKIF2GW054QuS+crZyM8HXskEjzLeqYwpuvDNuT6IDOFoy8ZJ5U4c23f8PI5pvSKbM4dyzA80+eWizvr76puRMlVfPtW5F+uuDiO/wxpIGZsFHNgvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387224; c=relaxed/simple;
	bh=wPzsEzLW/y0/CAK+M0gjKKmd3K+XoLl9m8kHKZeDqtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdgRqZLIwK8hus83Eetn4WLPLilGRobSTfOCnueK3NrBMADZ4ZLB0m2A3peFi9eTRbP8svLX9risjYeeVPxQY9ZMa3bbSswRFgQXuUFzeQOPlFB8XDX8C5dk4YFyemTPdgPRkoXM88225O4gpLJGm4+Bae7Vp6OLREHyOQ7kgpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jRmuZoG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4208C2BD10;
	Wed, 26 Jun 2024 07:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719387223;
	bh=wPzsEzLW/y0/CAK+M0gjKKmd3K+XoLl9m8kHKZeDqtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jRmuZoG4eY7Po9SYBXlSVLysiKIEI9iY2C3wo8sw/ERorjlgUSORP9qjbySo7Gtq1
	 lfENvHF0uYZThtZK6jmbSHxLtucdB7GpPpepzlaoMYfrDkDhb4ifJieAyfzz7ZWmuj
	 kEvMF4uO5EQDNVc3APRGToHGxEmYCiT1ua7ritHk=
Date: Wed, 26 Jun 2024 09:33:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v6 1/3] x86/syscall: Mark exit[_group] syscall handlers
 __noreturn
Message-ID: <2024062633-musky-balcony-bdd0@gregkh>
References: <cover.1719381528.git.jpoimboe@kernel.org>
 <5d8882bc077d8eadcc7fd1740b56dfb781f12288.1719381528.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d8882bc077d8eadcc7fd1740b56dfb781f12288.1719381528.git.jpoimboe@kernel.org>

On Tue, Jun 25, 2024 at 11:02:00PM -0700, Josh Poimboeuf wrote:
> The direct-call syscall dispatch function doesn't know that the exit()
> and exit_group() syscall handlers don't return, so the call sites aren't
> optimized accordingly.
> 
> Fix that by marking the exit syscall declarations __noreturn.
> 
> Fixes the following warnings:
> 
>   vmlinux.o: warning: objtool: x64_sys_call+0x2804: __x64_sys_exit() is missing a __noreturn annotation
>   vmlinux.o: warning: objtool: ia32_sys_call+0x29b6: __ia32_sys_exit_group() is missing a __noreturn annotation
> 
> Fixes: 7390db8aea0d ("x86/bhi: Add support for clearing branch history at syscall entry")
> Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> Closes: https://lkml.kernel.org/lkml/6dba9b32-db2c-4e6d-9500-7a08852f17a3@paulmck-laptop
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/entry/syscall_32.c            | 10 ++++++----
>  arch/x86/entry/syscall_64.c            |  9 ++++++---
>  arch/x86/entry/syscall_x32.c           |  7 +++++--
>  arch/x86/entry/syscalls/syscall_32.tbl |  6 +++---
>  arch/x86/entry/syscalls/syscall_64.tbl |  6 +++---
>  arch/x86/um/sys_call_table_32.c        | 10 ++++++----
>  arch/x86/um/sys_call_table_64.c        | 11 +++++++----
>  scripts/syscalltbl.sh                  | 18 ++++++++++++++++--
>  tools/objtool/noreturns.h              |  4 ++++
>  9 files changed, 56 insertions(+), 25 deletions(-)


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

