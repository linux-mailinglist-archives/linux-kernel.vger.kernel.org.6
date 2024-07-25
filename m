Return-Path: <linux-kernel+bounces-262186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBADE93C216
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749F0281977
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4F526281;
	Thu, 25 Jul 2024 12:30:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173C31E480
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910643; cv=none; b=njwafVQuija2xoLDPDUmW0MqR6NhgbHYXGTcTgiFzDAxNoOg8DzUYEmeuv5sAK0r7a8ahtgJdZjYPAXiog/6tTIegmpJJGZUnq9KLSfLriy0pYjMlHRFgqSJVjNhN/ww8qkOf1A8P/x5KsfB4xC+NVZpJtbsBanSAAeK1jz9AvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910643; c=relaxed/simple;
	bh=XP9rW2+e+Nqz7pDwL3QGvPhKPmIpxD9FzoUAx2B1v8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7aWb2JwRf3eCaAjxIpKyAec1rOQBADrkGLiHvfFW33Gykvg4bD1Cqjsq3BTpGENCIka/HGBlaFajcbIp1bUYBRhb02LBnmKUn3iWLaZ1tZFmuUzU+5/3w8WZJomLd5yfKYedf53lwb6msEHljcCpopAzCAGf8hYrErrM48Ls80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269E1C116B1;
	Thu, 25 Jul 2024 12:30:42 +0000 (UTC)
Date: Thu, 25 Jul 2024 08:31:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: remove tracing_is_on export
Message-ID: <20240725083102.38950c1c@gandalf.local.home>
In-Reply-To: <2024072508-freefall-headstand-7d47@gregkh>
References: <2024072508-freefall-headstand-7d47@gregkh>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 11:36:08 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> The function tracing_is_on() is only called by in-kernel code, not by
> any modules, so no need to export it as a symbol at all.

Hmm, this is part of the debugging code along with:

 tracing_on();  tracing_off();

I had it exported in case a module needed to use it in debugging.

-- Steve


> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  kernel/trace/trace.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 578a49ff5c32..d09f2effa7a9 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1612,7 +1612,6 @@ int tracing_is_on(void)
>  {
>  	return tracer_tracing_is_on(&global_trace);
>  }
> -EXPORT_SYMBOL_GPL(tracing_is_on);
>  
>  static int __init set_buf_size(char *str)
>  {


