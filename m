Return-Path: <linux-kernel+bounces-341780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E20D988613
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7E01F2120E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 13:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31AF18D620;
	Fri, 27 Sep 2024 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/z164nN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52013189502
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727442491; cv=none; b=pCLfg0yr1HB9naK6qK60dfxUXOujVga/Bz5DndKonmjbLGukrRaypW/f1vwPke8jfRpYiqcdqkC3+2xcBTA5n5aB1xjsd6LXFWrdoLLJIxbME5UsErERBlMY+YqdVNJETnspWLqf56nRxIvqh1RdqmNNxwnj0/GryInDeJ4Q69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727442491; c=relaxed/simple;
	bh=zZgnnnbsa4z/oy8HsRKQ5k9yoqyB40AEylEuJ+FCItM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITRNNGquMd46vj0TI9MVF75RLsTw8hdxepi0FpWHjq7rHk+ztqXNU0Opf8orsNlOozqkkTg9Y2cJptWE1MLJC6LiDjsr6q64FINNOVZcnMGvbhnAEzVmsN+d9LDNGqtWkW6ZZTFwABl3hGEUjBgqqRlPPs0Tt8U1wAImSwCHZvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/z164nN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23ADBC4CEC4;
	Fri, 27 Sep 2024 13:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727442490;
	bh=zZgnnnbsa4z/oy8HsRKQ5k9yoqyB40AEylEuJ+FCItM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/z164nNQmTIqDRqisxwo8W22kEZ//V3EjOerAGllwLc9otnRuoxH4BrfYeICSEBa
	 Rrk67ekN+rc4ikY6NTvcio2fkkhaCXZZSna5KEudR/vD0VYCPCD71uTMYxbGOxoA6Z
	 GxFRL6f69dgUD1JVZytVz3KGWjKPd1kdW52Kfpj4Rn3TvG3TmHSu6sExrF1vS+q5Qn
	 3ebd9S4/kMcGQPLWEYrgO0U+IVs7stL6TvJO1yO2CNso5UdQue74/zzyA4NtVVrPLv
	 nYC6EYk+ZElf93qpHFE7+ur9XOeu414eznBO5IWQCaf6bXpizOyXeurWSDEALZV9lo
	 PZGdzddztbwJQ==
Date: Fri, 27 Sep 2024 15:08:07 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch v4 03/27] signal: Get rid of resched_timer logic
Message-ID: <ZvauNx_6ecMrnwCH@localhost.localdomain>
References: <20240927083900.989915582@linutronix.de>
 <20240927084817.077215973@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240927084817.077215973@linutronix.de>

Le Fri, Sep 27, 2024 at 10:48:42AM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> There is no reason for handing the *resched pointer argument through
> several functions just to check whether the signal is related to a self
> rearming posix timer.
> 
> SI_TIMER is only used by the posix timer code and cannot be queued from
> user space. The only extra check in collect_signal() to verify whether the
> queued signal is preallocated is not really useful. Some other places
> already check purely the SI_TIMER type.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

