Return-Path: <linux-kernel+bounces-293806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 517D995851F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0827C1F21C18
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DBC18CC1F;
	Tue, 20 Aug 2024 10:48:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBAD178376;
	Tue, 20 Aug 2024 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150897; cv=none; b=WG5hafdLfnDxv7G4SR6AZvGLYdzwDq+zQYm9KsZzYaj4bE9M8Dn1xbcjMk8Y8zTcygHjYoxrK/jlDtajTC0ryxg/BjIAZvFfgJbbzvUkWVC8GSpkiuKG1ZIzw9JepLhjZb2yQnJW4sKRdmzCqjU0V2/7k7vB2Y16S+XvzsrguN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150897; c=relaxed/simple;
	bh=gkS8J5vowsW0bbUGawWegE8tMjNCg3bYnyGP8vozkrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1kLYfMDJbvp7oMLSRNCljbbu2KXhkukA01WlJ5NlrcGeLTEyjlnve1SRWnB93eIe8u6yskb+HLnvGRcJOBnOdkfgKOudxU7cKF34qSEYtE5KWIjCS8eSXUd5aQNBvdm9PwxjgN9cWWS4ZVh5LOa7Af8ad8XRjqT+YdvcC+Yar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80F27DA7;
	Tue, 20 Aug 2024 03:48:37 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DB933F66E;
	Tue, 20 Aug 2024 03:48:10 -0700 (PDT)
Date: Tue, 20 Aug 2024 11:48:07 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] tracing: dynamic ftrace selftest detected failures
Message-ID: <ZsR0Z6DxSHOI-wNj@J2N7QTR9R3>
References: <20240819171152.12f05e0ae5c9472004d1b00a@kernel.org>
 <20240819112902.11451fe8@gandalf.local.home>
 <20240820005649.dd019cfa70a8955d91cf85a0@kernel.org>
 <20240819120244.5657eb2f@gandalf.local.home>
 <20240820100330.9ee6f3d51f22bb9bab7c4b83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820100330.9ee6f3d51f22bb9bab7c4b83@kernel.org>

On Tue, Aug 20, 2024 at 10:03:30AM +0900, Masami Hiramatsu wrote:
> On Mon, 19 Aug 2024 12:02:44 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 20 Aug 2024 00:56:49 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > 
> > > > 
> > > > We may need to add "noinline" or something to make sure those functions
> > > > don't get inlined for LTO.  
> > > 
> > > Yeah, we need such option at least for function call test.
> > 
> > Could you add the noinline, and if it fixes the issue send a patch?
> 
> I found the target function already has "noinline". I tried to add noinline
> to the testing function (callsite), but it also did not work.
> I think "noinline" is for the compiler, but LTO is done by the linker.

If LTO is breaking noinline, then that has much larger implications for
noinstr code and similar, and means that LTO is unsound...

> I found a discussion similar to this problem, but it seems very hacky.
> 
> https://groups.google.com/g/llvm-dev/c/6baI9LISmSU/m/uEeY_CRbBQAJ?pli=1

Thanks for the link!

Mark.

