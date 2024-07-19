Return-Path: <linux-kernel+bounces-257590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F17F937C57
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AAA328331C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1C4146D57;
	Fri, 19 Jul 2024 18:17:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF2DDB2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721413024; cv=none; b=iw9RZgWrwZwaP2VOjWrYlkj6wawXM3QRiEb6bo1oNN7ngI2+JQmux2QUnJufqvHnrXTZu2ZZTqBeNIa6SP1xFMz51GivsNgzPDeZJ80DpRhhl3iiTmFMmwPyypuBy7zfI2OkCPVtpRgQNQey2FTOHn4WjcLcH32vnmQni/Qg3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721413024; c=relaxed/simple;
	bh=CQAEtPx28M34+BhMfPFhFzuHSIBkOqj1u8n1DvS80Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fuuTtJ/AtNSckVdKCUWyeaEfDyuPGNcZKrDUk6PrHjMgJaBlaw0BWihpuu/rS0RXogRYJLuCRhoLymysFL8B6wKq24SzuPWevTZhlFE6fXzn5tnA9SPjS6e/k6PIDbbnjegrDA714TSXBid5o0+m26hLsfMWpZ6Ui3N37X2SQTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E32C32782;
	Fri, 19 Jul 2024 18:17:01 +0000 (UTC)
Date: Fri, 19 Jul 2024 14:16:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, Thorsten Blum
 <thorsten.blum@toblux.com>
Subject: Re: [GIT PULL] ring-buffer: Updates for 6.11
Message-ID: <20240719141658.485e7167@rorschach.local.home>
In-Reply-To: <76333f65-c2c0-47bc-94f7-8f18e60def30@efficios.com>
References: <20240716155118.152dea35@rorschach.local.home>
	<a71100aa-ffe4-477e-814a-1564e00cb067@efficios.com>
	<20240719103218.6c1eedfc@rorschach.local.home>
	<7e29c303-c91f-4229-9b9d-b60d8a60c38b@efficios.com>
	<20240719121940.5ce9a90a@rorschach.local.home>
	<76333f65-c2c0-47bc-94f7-8f18e60def30@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jul 2024 14:05:39 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> The whole justification for adding this feature *is* keeping a ring
> buffer around across kernel reboots. If it's just a way to let the
> kernel specify where to place the ring buffer in memory, then what
> is the use-case justifying its integration ?

Yes, but this is broken up into two parts. With this release you have to
know the memory layout and add it explicitly per machine. This takes
quite a bit of knowledge to get right and that's for every individual
system. It's not going to happen for some general application. You have
to know your memory layout and adding this is an advanced operation.
If you are doing this, you should already know what to expect.

When I add the: reserver_mem=12M:4096:trace trace_instance=bootmap@trace
which will allow for a much more generic operation, then yes. I'll be
adding a bunch more documentation and will add the limitations of this.
But that's for the next merge window. This merge window was just to get
the functionality there and a way to test it. But honestly, the
hardcoding of the address is already a high bar and one that even I can
only use on my own machines (that's not going out to chromebooks). For
the more broader audience, I need the reserver_mem option available.
And then I agree that people need to know the limitations of that, as
that *is* a generic operation that can go out into the field.

For now, this is just the infrastructure with a very specific way to
even use it (you need to know the layout of your individual machines).
I don't want to add documentation about rebooting yet, because then the
next merge window is just going to rewrite it.

-- Steve

