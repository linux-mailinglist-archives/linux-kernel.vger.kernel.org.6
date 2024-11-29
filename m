Return-Path: <linux-kernel+bounces-425595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9B29DE77F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56CC6281713
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AD919F128;
	Fri, 29 Nov 2024 13:26:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9C319884C;
	Fri, 29 Nov 2024 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886811; cv=none; b=rwWwQfTfUQ6LAhfj14x/ie3GU83M0Vl3VcF0bruSJha8XXDJpH7dWp+LpK49advP5a+0q/XdnEIaU0QEsIGkziaRpgo592OO3DXMBk+2nMuIXoB0ltajR3l7RT+2C9bYfJbKQVSuTpaBu6WpHN6RJsgeSbt5IfXOWUqDq59x+WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886811; c=relaxed/simple;
	bh=OegK0/G3eIRaNtgrqBcY9CrE2TZCsJiPnlMplzLsJrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcBdK6smEblnF2qwSAWndbdjMgTEongOClh+AYopkLBZ5tzgeWJC1UjLQX2/kchxrTsQq59fZrniEzWIEqQlJhGvad6Cjl9NBEPcsf0R3bBJznIQ1kaicTEBubbun3pLrdT78KQSWbf2LfybXVYWzckpjH36BpikiJl+RDnpSOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6B2C4CECF;
	Fri, 29 Nov 2024 13:26:47 +0000 (UTC)
Date: Fri, 29 Nov 2024 08:26:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, <rust-for-linux@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Justin Stitt <justinstitt@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] tracing: More updates for 6.13
Message-ID: <20241129082646.1341af16@rorschach.local.home>
In-Reply-To: <193780f6880.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
References: <20241127131941.3444fbd9@gandalf.local.home>
	<CAHk-=wgwQ5gDdHgN54n8hsm566x5bauNPsdZPXm6uOCFvPA1+Q@mail.gmail.com>
	<20241128155120.6e6cd300@rorschach.local.home>
	<20241128182435.57a1ea6f@gandalf.local.home>
	<CALOAHbBB-__eyERw82QnS3Wmgi7_BpPaacY2urVmpWX3ZkVtvQ@mail.gmail.com>
	<193780f6880.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Nov 2024 08:14:56 -0500
Paul Moore <paul@paul-moore.com> wrote:

> > The issue appears to be a known GCC bug, though the root cause remains
> > unclear at this time.
> >
> > A potential workaround has been proposed, which you can find here:
> > https://lore.kernel.org/linux-hardening/202410171059.C2C395030@keescook/
> >
> > However, it seems that the patch has not yet been accepted into the mainline.  
> 
> I didn't pull that into the audit tree because it isn't a real patch. 
> Looking at it again on my phone before today's holiday stuff kicks off, I 
> don't have a problem with the workaround, but i do need to see it as a 
> proper patch with a commit description, sign off, etc. before I can merge it.

Yeah, from the comment I was expecting to see a proper patch.

> 
> For anyone who is going to put together a patch, please make it clear that 
> it is a compiler bug and provide the associated bug report links.

If it matters, with that patch applied, all my tests were able to
complete with success.

Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

