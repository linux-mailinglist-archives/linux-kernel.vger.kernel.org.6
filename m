Return-Path: <linux-kernel+bounces-425205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4107F9DBED7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C93B21A93
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 03:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEB715380A;
	Fri, 29 Nov 2024 03:04:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF2B13F42A;
	Fri, 29 Nov 2024 03:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732849464; cv=none; b=h/xvzW1vaPmJI5K3TWhl3N7LOGpKTGXinCp55tPw0APG4Wyary7DDlnjc+kHhF7LJGHRZvCuW5gftc/IK9F4chM8I9yVeWre8DswO3D6F+GQusSLA1oZ8B3Q4/v7Ao0EV9m+QKQjF1+3oEc6SSZAafM3y5+54gmpIPBT9at7XaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732849464; c=relaxed/simple;
	bh=MOufZdl89X3FSEHAZ+ouhKzwUDYscQkyxZU8NxuMNZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VdqcHfOOMr+2h99C/KGggwGzriGvuVnJRME3AYEZKJzGcOyAUp3g8btsx9rrve2Wh6W5gP6/dsEaliMgfatAsvbdGbJvMdSg7e3BIWPXFTSI8WIRIHp3XarE3O28z5jDGVqRIz3xuOAdlgJUoPZB+gl7iDiSVFyI7F0rUmco56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B72C4CECE;
	Fri, 29 Nov 2024 03:04:21 +0000 (UTC)
Date: Thu, 28 Nov 2024 22:04:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, Justin
 Stitt <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>
Subject: Re: [GIT PULL] tracing: More updates for 6.13
Message-ID: <20241128220420.6196a937@rorschach.local.home>
In-Reply-To: <CALOAHbBB-__eyERw82QnS3Wmgi7_BpPaacY2urVmpWX3ZkVtvQ@mail.gmail.com>
References: <20241127131941.3444fbd9@gandalf.local.home>
	<CAHk-=wgwQ5gDdHgN54n8hsm566x5bauNPsdZPXm6uOCFvPA1+Q@mail.gmail.com>
	<20241128155120.6e6cd300@rorschach.local.home>
	<20241128182435.57a1ea6f@gandalf.local.home>
	<CALOAHbBB-__eyERw82QnS3Wmgi7_BpPaacY2urVmpWX3ZkVtvQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Nov 2024 10:16:54 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> The issue appears to be a known GCC bug, though the root cause remains
> unclear at this time.
> 
> A potential workaround has been proposed, which you can find here:
> https://lore.kernel.org/linux-hardening/202410171059.C2C395030@keescook/
> 
> However, it seems that the patch has not yet been accepted into the mainline.

Thanks, I applied that to my "fixes" patch that is used to fix other
issues that are not related to my code so that I can continue testing.

I just kicked off my tests again with that applied.

-- Steve

