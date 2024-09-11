Return-Path: <linux-kernel+bounces-325435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D819759A1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4284282472
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014281B29B9;
	Wed, 11 Sep 2024 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="F5yJnBKr"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0AB58AC4
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076476; cv=none; b=LR9cNCQB860v64KejTh0rTOonD3Yq/s6QI1E0cruibgzc1LK+38AfKauKth+rpZrMw7VaAdJsbo3VJUulZ7NLX+yIfAmF5MBKhvFsiTLGQ8jOZgpMOlARc4aRxIUANInCLS+bYQkMw1BFLQ0PACdDkBknzKyhxozpa60hHeSLsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076476; c=relaxed/simple;
	bh=cQed1RagomsB4pW3TZd+PomVJ7/ECeY+ZQu6GcwL91Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TEZw6Me39UM6nNmh8n5jW37C3YwaCVpGePu9XIHNTHSvMMVk+beUHycDG9kJBfVNKbcFCj9Dfe6aqHCNnEAscyvo+wDQmRyjf5dQeg00VWNCdNYn9LiinnG6MFyT9F66w2bjGOqMUV+htZl9THQrGm9P6g7SvvedpwqXjInUpOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=F5yJnBKr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id CBE6F20B9A7E;
	Wed, 11 Sep 2024 10:41:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CBE6F20B9A7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726076467;
	bh=ccjuu9d1VVmzU5IdpmuPhoU304YmRiuN/csmG5NSstA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F5yJnBKrRPbybDtoGWtUXF5lyNKmgfHJjzD87wmm+9u4SsrzvugarFYsv9jqgEBHt
	 2MXYchrcIftcwcdW4XTt2RbN95rxvKsHrG9T3WPfuEaVsqCk4JQ38WmE6o3FFbGBYp
	 mWepWbiu4uscUzoFEn6PJmT4OlMtdTCe1orfy3sI=
From: Roman Kisel <romank@linux.microsoft.com>
To: oleg@redhat.com
Cc: akpm@linux-foundation.org,
	apais@microsoft.com,
	benhill@microsoft.com,
	ebiederm@xmission.com,
	linux-kernel@vger.kernel.org,
	romank@linux.microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	torvalds@linux-foundation.org,
	vdso@hexbites.dev,
	workingjubilee@gmail.com
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc FS
Date: Wed, 11 Sep 2024 10:41:07 -0700
Message-Id: <20240911174107.1217693-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911144412.GA16954@redhat.com>
References: <20240911144412.GA16954@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 09/11, Oleg Nesterov wrote:

> On 09/10, Roman Kisel wrote:
> >
> > On 09/09, Oleg wrote:
> >
>
> > > Yet another thing in this discussion I can't understand... sorry, I tried.
> > > You do not need to teach, say, gdb to recognize this pattern. You can just do
> > >
> > > 	$ gdb -ex 'b please_insert_the_breakpoint_here' ...
> > >
> > > Nevermind, as I have already said you can safely ignore me. I still do not
> > > see any "real" use-case for breakpoint_if_debugging(), but I guess that is
> > > due to my ignorance and lack of imagination.
> >
> > I've started this so let me butt in and take up the gaunlet.
> >
> > Lambda's would be the most prominent example to me[1]. The toolchain
> > doesn't give them the user-accesible type and the name as it does for
> > the functions.
> 
> And?
>

You wanted an example of '"real" use-case for breakpoint_if_debugging()':

> > > Nevermind, as I have already said you can safely ignore me. I still do not
> > > see any "real" use-case for breakpoint_if_debugging(), but I guess that is
> > > due to my ignorance and lack of imagination.

I have provided them, and illustrated how it is tiresome to set the breakpoint
in the debugger in these cases so can add a call to breakpoint_if_debugging()
to these places instead.

> Once again, what I tried to suggest is a single "nop" function,
> "void please_insert_the_breakpoint_here()" which simply does asm("ret") and
> 
> 	#define breakpoint_if_debugging()	\
> 		please_insert_the_breakpoint_here()
> 
> Or, to make it more cheap,
>
> 	#define breakpoint_if_debugging()	\
> 		asm volatile ("call please_insert_the_breakpoint_here" : ASM_CALL_CONSTRAINT);
> 
> so that compiler will know that breakpoint_if_debugging() doesn't change the regs.
> 
> Again, again, I am not saying that this is necessarily the best solution.
> Just I fail to understand your email, sorry.

No worries, appreciate your willingness to help!

>
> Oleg.

Roman

