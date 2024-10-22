Return-Path: <linux-kernel+bounces-375543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18B99A9728
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512C51F22278
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B68113A3FF;
	Tue, 22 Oct 2024 03:36:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E339C12E1CA;
	Tue, 22 Oct 2024 03:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568159; cv=none; b=CJ0HtXCIPlkpP7KEOFuSNnmbJPhASU0DlPKNmm/JDt2P4/XKtEYh1mVfkQyjT2JUH+8EQkcjhFjqNBFu4yro69vgbFHxvXSpmQVPiKT8BMExcOMF7meW17kINvFrBSW3/hg6h07+IgbQUzBPr/NqZQ3pdhggTRT9L8HCxutd1gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568159; c=relaxed/simple;
	bh=K+vjaqwAPjLf9VJ3/xPLj8PYjIGgIDJyTnutxu/NoAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+Fqno62Xwkkd5M3lTj+5d33A5GkOjVukKuQKjPSh/YhmeL/T59lNc+uASsau3P0Zx9pe6IrFkSndMvQcuk6RlsHR2kB3ghsNVvoPQuh2bjIDrJCe2Bp2oUrgeNM1I4fxT+pv0KOKfAFZRPFyC7cL3YUeB23aKZyeQMTO0ixKMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADA6C4CEC3;
	Tue, 22 Oct 2024 03:35:58 +0000 (UTC)
Date: Mon, 21 Oct 2024 23:35:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] fgraph: Use CPU hotplug mechanism to initialize idle
 shadow stacks
Message-ID: <20241021233555.47001ddd@rorschach.local.home>
In-Reply-To: <20241021145810.9a9daec35cb83a04fe10208a@kernel.org>
References: <20241018214300.6df82178@rorschach>
	<20241021145810.9a9daec35cb83a04fe10208a@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 14:58:10 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > +	if (!fgraph_initialized) {
> > +		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph_idle_init",  
> 
> Nit: Maybe it is better to call it as "tracing/fgraph:online" ?

Ah this already went upstream. But yeah, I can rename it for the merge
window.

-- Steve

