Return-Path: <linux-kernel+bounces-262208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 840B893C280
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401F8281DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CAB19AD60;
	Thu, 25 Jul 2024 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nNZWCSoc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83219AD55
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721912024; cv=none; b=BigJaN5TAOZ/8RJBbB5XIjK3psfdlc2xTnfW92X5OU1TWnt7pOifzmLKrUTVCxbgAMw+yggbVh7z7x3y6z72IaZkxsk2jpYIDeCth0nA49hHHrSwVZOEaTnH2uXfntv46z5s/YfhR1B3jD/ImOSGjtjuZxVAHnsjSTm/dIzafMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721912024; c=relaxed/simple;
	bh=2UffoEiNBWDblLyslL59SF/aWp4Er5kqWkgWv0Hb1uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+4BofkDvGub2c0xzOZ7V5e0oHOUUNQEpVHvs/KnGU1Z3UeJiwwgGS94Pf75AqWrRhueKZgX5K20RuSxKLGjus3o7k0w26UtlyUzyJU5zctgD0+d/C1I/+cX8iOdrMGoCEYld7c9KfJXdiMavYVsbtyLDHn5JATgOSJdzC617Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nNZWCSoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747B1C116B1;
	Thu, 25 Jul 2024 12:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721912023;
	bh=2UffoEiNBWDblLyslL59SF/aWp4Er5kqWkgWv0Hb1uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nNZWCSocAz3kZUQxt34wd42l42BTMcjuwrcVmgIKB7i49qBxMgEb3fqB6vh1nyZMv
	 weV3ywMrt0V3Mlon8e1LzQj2yvtycJANyaI4CySeV3xPgAE0CKkd08WN+ByKxtsoyE
	 vmqavXAmrZOZl7f3cVVoPd/t6Og02ya8qUZaYI8o=
Date: Thu, 25 Jul 2024 14:52:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: remove tracing_is_on export
Message-ID: <2024072506-aghast-appointee-7f83@gregkh>
References: <2024072508-freefall-headstand-7d47@gregkh>
 <20240725083102.38950c1c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725083102.38950c1c@gandalf.local.home>

On Thu, Jul 25, 2024 at 08:31:02AM -0400, Steven Rostedt wrote:
> On Thu, 25 Jul 2024 11:36:08 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > The function tracing_is_on() is only called by in-kernel code, not by
> > any modules, so no need to export it as a symbol at all.
> 
> Hmm, this is part of the debugging code along with:
> 
>  tracing_on();  tracing_off();
> 
> I had it exported in case a module needed to use it in debugging.

What module?  There is no in-kernel user of it as a module that I could
find, what am I missing?

thanks,

greg k-h

