Return-Path: <linux-kernel+bounces-294618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 235C2959045
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2701F23B87
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4481C7B69;
	Tue, 20 Aug 2024 22:10:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A063C158A37;
	Tue, 20 Aug 2024 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191843; cv=none; b=Vx4bWAtp8VxyD//yL3YdOrGPspKAhjz/Rn6aYiXVg9qbKpC/CnIkduOOSXdjIJjci63WTsQhWM6tpRcMt97Xci6WEtpaGpCljcQIIOZro00vNukj2Qpm0zRqWcjVnadk3wWhRDk2TLSAELKu1krTm/sPAC+BgVEJfd69XWQ92hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191843; c=relaxed/simple;
	bh=GeGnXAbPkrNlGGqFsTuYIhb+LAUzOSx4oNiA55XCwcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIYKfFz/fr5y9Hk5NqJnzCnCZOp+/ituRUrxyyciCMomTiBvsB7cdXc4SQW6UFo6zUhwPnfjq/gZIO7DiF1yN4NF5+sYthq3+Ky5j2M+otkPrfaFm9Z3KuI1V60cdHVCvtsSz6Cy4PYCJGrdrDGQcLRR/nXmzQEJb9YSBzGEOjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AC0C4AF09;
	Tue, 20 Aug 2024 22:10:42 +0000 (UTC)
Date: Tue, 20 Aug 2024 18:11:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Mark Rutland
 <mark.rutland@arm.com>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kernel@vger.kernel.org,
 clang-built-linux <llvm@lists.linux.dev>, Nathan Chancellor
 <nathan@kernel.org>
Subject: Re: [BUG] tracing: dynamic ftrace selftest detected failures
Message-ID: <20240820181109.4203158d@gandalf.local.home>
In-Reply-To: <20240821070539.981b42e5f3b939c5ce5e3a71@kernel.org>
References: <20240819171152.12f05e0ae5c9472004d1b00a@kernel.org>
	<20240819112902.11451fe8@gandalf.local.home>
	<20240820005649.dd019cfa70a8955d91cf85a0@kernel.org>
	<20240819120244.5657eb2f@gandalf.local.home>
	<20240820100330.9ee6f3d51f22bb9bab7c4b83@kernel.org>
	<ZsR0Z6DxSHOI-wNj@J2N7QTR9R3>
	<CABCJKueKhDVarco4mgNeR0hkAhxDtxBjdpu=QaYVi+TGoiqd2g@mail.gmail.com>
	<20240821070539.981b42e5f3b939c5ce5e3a71@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 07:05:39 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:


> Does the noinline attribute prevent embedding callsite too? I mean
> 
> extern callee()
> 
> noinline callee()
> {
> ...
> }
> 
> caller()
> {
> 	callee() // (*)
> }
> 
> In this case, does noinline prevent LTO to embed the callee at the callsite(*)
> or prevent LTO remove the callee() symbol?
>

Even though we have it passed as a parameter, I think the compiler and
linker is smart enough to see that and notice its use, and that the
function passed in is a nop, which doesn't break the flow.

Can you add the __used and see if it fixes it?

-- Steve

