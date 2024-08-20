Return-Path: <linux-kernel+bounces-293094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AF0957AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB35A1F239AC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B01EAE7;
	Tue, 20 Aug 2024 01:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5DPEbaY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5360C8E9;
	Tue, 20 Aug 2024 01:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724115814; cv=none; b=DSZM/Gp9Gkmy+/5SWkVBZLQvz1l93Wt9/H5fDQ4QCV+XCYjNXjITtm9RjPe5T59H8lL7IuCFqdfAhSqBzviNPuSsWi26z52Jv8eJ26UEWBKPXjUu86wzR9O+wbnJtZU5DcbBEyfZ602I7fuJ/RjEp9NS1e822JqJrnYSjpMIOIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724115814; c=relaxed/simple;
	bh=bHwB8woq171ocGEAt7CR2Rff4p/eO/+blo/nvtKNxCw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BfI5lM/1KmMUCSm/+9ahGoeTz+8ORWeJPt5tlY/sWWoKWzjrU1VUX7Vqb2O485M3uMQcXAqS7/uiTTIbdahL1BqDp9//oS9sZ0Z977J2ZZclDeQiPFritUJccH1DNoybZCdd+qWadogRgotQXm0X0FX5RvT8I16SbLCEz1STXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5DPEbaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4D9C32782;
	Tue, 20 Aug 2024 01:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724115813;
	bh=bHwB8woq171ocGEAt7CR2Rff4p/eO/+blo/nvtKNxCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q5DPEbaY/sMzOAqdG3f7qWNadVId+pEelt6j0Tdrt5gCV1o5hAsvXSAJhjuS4Z7Da
	 M65n7IspELZLom5MIFYsLfVcZpLKyGhPIt4tFFj4oONoa9SHrmhvmQg/Oe8GuaNRbk
	 EfAMLf1ipbXgOcUQVQoz0Tyx2Ka4+GyhNFAwBnooEYhCR76atLcpEbq7WKJZzhzBH1
	 qzh6MVvI4+cekyWW0yTrnKWUxd47u9bheiiBUp349/Pbwhncc/E5iAwGpfS3EDNKdr
	 78ne0uOzUcp/auIy7UlkHaYmnFLSL2b5iD42ymu893lEV6MsZfmx9qT5hEEdOuK7sk
	 bzZ2iQnWqBN+A==
Date: Tue, 20 Aug 2024 10:03:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [BUG] tracing: dynamic ftrace selftest detected failures
Message-Id: <20240820100330.9ee6f3d51f22bb9bab7c4b83@kernel.org>
In-Reply-To: <20240819120244.5657eb2f@gandalf.local.home>
References: <20240819171152.12f05e0ae5c9472004d1b00a@kernel.org>
	<20240819112902.11451fe8@gandalf.local.home>
	<20240820005649.dd019cfa70a8955d91cf85a0@kernel.org>
	<20240819120244.5657eb2f@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 12:02:44 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 20 Aug 2024 00:56:49 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> > > 
> > > We may need to add "noinline" or something to make sure those functions
> > > don't get inlined for LTO.  
> > 
> > Yeah, we need such option at least for function call test.
> 
> Could you add the noinline, and if it fixes the issue send a patch?

I found the target function already has "noinline". I tried to add noinline
to the testing function (callsite), but it also did not work.
I think "noinline" is for the compiler, but LTO is done by the linker.

I found a discussion similar to this problem, but it seems very hacky.

https://groups.google.com/g/llvm-dev/c/6baI9LISmSU/m/uEeY_CRbBQAJ?pli=1

Thank you,

> 
> Thanks,
> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

