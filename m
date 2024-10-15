Return-Path: <linux-kernel+bounces-366139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF3199F14E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353C41F243A9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DF71B395C;
	Tue, 15 Oct 2024 15:34:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5D1CB9E2
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006462; cv=none; b=JRyN9q6PRX2cKios0zRRxk2xajmHrEfEh57dlq+oWiksasN5YMT8WcN52ua6TmcJmRGN4zwU9LUWsTbuC18IunFcgznhHoQRKl2VtXAZRcuf90mBbzwHWB4hKmvufPrd8HM4gxcYv8q+3zYyuxE+C+1MKxMH2EukhIt0uDaPRI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006462; c=relaxed/simple;
	bh=oRgJAbDSgR6EbOgBByxkswIJqnKwwxqWoo5vTOYlPyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbG2n/Yc3xi+2vY0WCztbhwBPejXCKOmKrasGmpilw6JCNl10WeNTHsJPq7YsC0FKIcWyvSkRH+7ZHWIjqVV3pJtCxrMzCANxrrO2T/rkAQVzfIRyBQ03W6gNJg4elVWvzJjG0EZVvqkKOJHuTwaAZboe+SHagEkKSBYXJM7Ie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FABC4CEC6;
	Tue, 15 Oct 2024 15:34:20 +0000 (UTC)
Date: Tue, 15 Oct 2024 11:34:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 0/2] ring-buffer: Fixes for v6.12
Message-ID: <20241015113439.2f8155ac@gandalf.local.home>
In-Reply-To: <20241015153105.843619901@goodmis.org>
References: <20241015153105.843619901@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 11:31:05 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> ring-buffer: Fixes for v6.12
> 
> - Fix ref counter of buffers assigned at boot up
> 
>   A tracing instance can be created from the kernel command line.
>   If it maps to memory, it is considered permanent and should not
>   be deleted, or bad things can happen. If it is not mapped to memory,
>   then the user is fine to delete it via rmdir from the instances
>   directory. But the ref counts assumed 0 was free to remove and
>   greater than zero was not. But this was not the case. When an
>   instance is created, it should have the reference of 1, and if
>   it should not be removed, it must be greater than 1. The boot up
>   code set normal instances with a ref count of 0, which could get
>   removed if something accessed it and then released it. And memory
>   mapped instances had a ref count of 1 which meant it could be deleted,
>   and bad things happen. Keep normal instances ref count as 1, and
>   set memory mapped instances ref count to 2.
> 
> - Protect sub buffer size (order) updates from other modifications
> 
>   When a ring buffer is changing the size of its sub-buffers, no other
>   operations should be performed on the ring buffer. That includes
>   reading it. But the locking only grabbed the buffer->mutex that
>   keeps some operations from touching the ring buffer. It also must
>   hold the cpu_buffer->reader_lock as well when updates happen as
>   other paths use that to do some operations on the ring buffer.

Oops, used the wrong script. This was supposed to be "for-linus" not "for-next".

Oh well.

-- Steve

