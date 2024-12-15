Return-Path: <linux-kernel+bounces-446431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78409F243F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40431642F4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA9618DF86;
	Sun, 15 Dec 2024 13:50:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3D91487D5
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734270641; cv=none; b=QVd3fiw9qWFALbAOnTsCCNHHUp/QImNmTVWWq9AEDEnfC0fMdiNW/q8Bp/esq/UlSpXY4e5f2rUztiiNUPPMQ89pXcUr1QDVpewHG7fwWlaGfGlwclWlkLb+AjXfnNBnkseNDqpD6ClPTgRz2FsGFag2RDyTGrioS7wkO3Gm6ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734270641; c=relaxed/simple;
	bh=8lWvN57ddExe2F6IisvmZXAGR5lkslaGsVwGqwA/seI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQLRnCY1FfpI39l+AZobjXn+e7dJUV0ESCjmuUXhmUoYYJ5tMvWkoSSfJNzXSIIBT4lPYN1BAhm+OCz4f5vfjf0ShGjtPX4IS9LMNOm/as6qBrmA1WgebHehO0wNIn7FxsOjuPRA8D6vVxnQs8XkfoYgXPrYD3teHs0Ez7pKHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBC7C4CECE;
	Sun, 15 Dec 2024 13:50:38 +0000 (UTC)
Date: Sun, 15 Dec 2024 08:51:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
Message-ID: <20241215085109.546a9b8c@gandalf.local.home>
In-Reply-To: <20241215050517.050e9d83@gandalf.local.home>
References: <20241214182138.4e7984a2@batman.local.home>
	<CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
	<20241214220403.03a8f5d0@gandalf.local.home>
	<20241214221212.38cc22c3@gandalf.local.home>
	<CAHk-=wiSdtNvq_wUtq7f3oO7S7BYCeXh7a707HKvK9nVkxR=jQ@mail.gmail.com>
	<CAHk-=wh3cUC2a=yJv42HTjDLCp6VM+GTky+q65vV_Q33BeoxAg@mail.gmail.com>
	<20241214233855.46ad80e0@gandalf.local.home>
	<CAHk-=wh3uOnqnZPpR0PeLZZtyWbZLboZ7cHLCKRWsocvs9Y7hQ@mail.gmail.com>
	<20241215050517.050e9d83@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Dec 2024 05:05:17 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Honestly, I did not like this code when I wrote it, but I have no idea how
> to stop the "%s" bug from happening before it gets out to production. This
> worked. Do you have any suggestions for alternatives?

My mind wouldn't stop thinking about this all night, and I think I found an
alternative.

The test_event_printk() catches everything but the "%s" issue, only because
we allow events to print to static strings and not have to copy them into
the ring buffer. But that function also has access to the event fields. It
can figure out which field is being printed by "%s", and flag it. Then on
output, it can check that the field is going to be printed before the
vsnprintf() is called on the TP_printk() format.

If it is a bad field, it can inject into the trace that the field is bad,
not print the event at all, and trigger a WARN_ON_ONCE().

Hmm,

-- Steve

