Return-Path: <linux-kernel+bounces-262278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E14B393C365
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F7A1C21D41
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C500819B5BC;
	Thu, 25 Jul 2024 13:52:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFE219B3F9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915568; cv=none; b=cA618vWpfE+QFWzzqzEkyc25ndPBrl6tIAHvd7n2w56DK/E32VzXjCocjEdAZv69eqpIvl75Q8eV0R7LUqFLWAbreP0F2nJRck6GdssLG8nL7irEkW7zwoSIRaNz2gBb5MzzIBPEy1WnGWvRHIGwINoWd/NkaDV2zQMPOJkbzgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915568; c=relaxed/simple;
	bh=JwEGpyG4brPKJsWxoACp+pgp0iFkZhxnE/sWlKdjrvA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YsnWAUMcl5G1/WK3V+tP2qzt+7tEfwpI+scHSsv2212M3eBJHlQA3RPpHd/uPKAE3wS7YMM37057EmnhW/WuP7E5dR8BFyijuP6xk6IfQvuemeBg1b8tBTtqcKqmXekwgdhBftuqH9AVOeQ47qgkCiiuBarlJPPMxTPpF/lU18k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5051EC116B1;
	Thu, 25 Jul 2024 13:52:47 +0000 (UTC)
Date: Thu, 25 Jul 2024 09:53:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: remove tracing_is_on export
Message-ID: <20240725095307.3067329f@gandalf.local.home>
In-Reply-To: <2024072525-declared-yam-0cad@gregkh>
References: <2024072508-freefall-headstand-7d47@gregkh>
	<20240725083102.38950c1c@gandalf.local.home>
	<2024072506-aghast-appointee-7f83@gregkh>
	<20240725092609.1441788d@gandalf.local.home>
	<2024072525-declared-yam-0cad@gregkh>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 15:35:00 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> Generally, we don't allow symbols that are not actually being used in
> the kernel tree?  tracing_is_on() is a "code flow" type of thing, where
> code can operate differently if it is enabled or not.
> 
> And I would argue that tracing_on() and tracing_off() should also not be
> allowed to be in a module, why would you want that?  Just enable/disable
> it from userspace when doing your testing, IF you have permission to do
> so.

tracing_off() is key to development, and one that I would argue very much
against removing. The other two are more just for "completeness".

It usually is used by adding a bunch of trace_printk(), and then:

	if (condition) {
		trace_printk("Condition hit!\n");
		tracing_off();
	}

And then you run your kernel until you noticed that something weird
happened. Then look at the trace file, and it will have all the events that
happened up to the anomaly condition, and you don't have to worry about the
ring buffer overflowing and losing your data.

This workflow is used by many developers.

-- Steve



