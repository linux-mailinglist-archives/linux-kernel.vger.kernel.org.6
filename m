Return-Path: <linux-kernel+bounces-315578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C581296C464
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CCC1F23CB2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E191E00AD;
	Wed,  4 Sep 2024 16:49:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66971773D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468541; cv=none; b=m83KGxfHu5MyfDVFhtgG8H0lLMTuIFkn1MHG+pG5oimu3SKuH3Rhr9aNooKJG2XSp6g8W96MZWbFpIQ53vqBkefjMg5JMohJZoTXNPkFU6OEtCQctiBCcWH7LSW05ohkPWGiufgoqaJ1fnwKBWYN3Z4JkzhtJ/HHtwhlWCyqMyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468541; c=relaxed/simple;
	bh=tmyfYK848FsG4YOdUzySy14eRYBo306wyehKsCQKxd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+jl8qJVYPwym5no+/MbAMoKpQeqSmkRiWCjr0EegA6hblqwfrqlomsiXRqU8b5NBrObJprggYnvXn03c1jGNkvEslwxV15LLNw2522NmgvWeHMDCMJT6VWpPuUGwFn3vhfF69+uS4YAhwrbyyEsB+aWEWDuKOIEvvYXTejkHvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFDCC4CEC2;
	Wed,  4 Sep 2024 16:49:00 +0000 (UTC)
Date: Wed, 4 Sep 2024 12:50:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, "Madhavan T. Venkataraman"
 <madvenka@linux.microsoft.com>, Kalesh Singh <kaleshsingh@google.com>,
 chenqiwu <qiwuchen55@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, puranjay12@gmail.com
Subject: Re: [PATCH] arm64: stacktrace: fix the usage of
 ftrace_graph_ret_addr()
Message-ID: <20240904125000.4261b234@gandalf.local.home>
In-Reply-To: <20240903160751.702f1f91@gandalf.local.home>
References: <20240618162342.28275-1-puranjay@kernel.org>
	<ZnHHHmEv-oqaXmq0@J2N7QTR9R3>
	<20240619124318.GA3410@willie-the-truck>
	<20240624161741.2a16d904@gandalf.local.home>
	<ZtCz2IiskUTVu6Xu@J2N7QTR9R3>
	<20240903160751.702f1f91@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Sep 2024 16:07:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 29 Aug 2024 18:54:01 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > Hi Steve,
> > 
> > On Mon, Jun 24, 2024 at 04:17:41PM -0400, Steven Rostedt wrote:  
> > > On Wed, 19 Jun 2024 13:43:18 +0100
> > > Will Deacon <will@kernel.org> wrote:
> > >     
> > > > > Catalin, Will, do you have any preference?      
> > > > 
> > > > I think it makes most sense if this patch travels together with
> > > > 29c1c24a2707 ("function_graph: Fix up ftrace_graph_ret_addr()"), so that
> > > > would be via Steve's tree. In which case:    
> > > 
> > > That makes sense to me. I'll go around pulling in all the updates to the
> > > arch code here (with the respective acks).    
> > 
> > Are you still planning to pick this up? On next-20240829 the ftrace
> > tests blow up (as below) due to having the core ftrace change to
> > ftrace_graph_ret_addr() but lacking the arm64 fix.
> > 
> > Splat on next-20240829:  
> 
> Ah, I didn't check to see if it was sent to linux-trace-kernel, so it
> wasn't in patchwork, hence I forgot :-p
> 
> I can add it this week.
> 

Actually, the code is in Linus's tree now, so it's probably better if it
goes through your tree.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

