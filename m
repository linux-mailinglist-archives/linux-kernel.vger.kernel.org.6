Return-Path: <linux-kernel+bounces-385411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2509B36DA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF57F1C22114
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD311DEFE7;
	Mon, 28 Oct 2024 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVjNZgn2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A6E1DE8AA
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133691; cv=none; b=D8Yz9xa5GdORv8BisEeEpKOd+oOtdWE48wzy88MjcMcJiJDNnmxRRM51wfXsBNzYcAGckJRu3LIJuBOooYoFI0jAknW49RVf65jOeYhQyyoevd1mMi13L0ly0nXlL9lS5PPIkt45uSvhOLaoYnRM5i5ZLu63/Vzug/+o+MGxroU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133691; c=relaxed/simple;
	bh=B4oB+FNa7mrAonbfQzqwsVGJ6I/lQD0mexpFz6uiXTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOgHxZ5MCLeHAUBkD4Ad7QrTebAEwyvJxsno20gliy4SRE+8KDfxaol8jyuhBuTp4qKpwlJQwX7CIMps+llvffyapB1FW2nWEFWbuV9sh6RbDB2/ii1f57XAHXdDpKfLVA6oLMJoLKIMPT18EcmsXlaLLrFuthPl+AUqxAzOvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVjNZgn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49217C4CEC3;
	Mon, 28 Oct 2024 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730133690;
	bh=B4oB+FNa7mrAonbfQzqwsVGJ6I/lQD0mexpFz6uiXTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MVjNZgn2G/PfOqfRF005VcRxpefUgBHwOykTsUj/dg5eXwQpU5MsLGCMdF3PVG82x
	 KsxyT8Y/0LbX2rZ8lL2bXBINxEIrkfIfSivdLo9ClpJTD98np2gmQD9drzQ8DCro6G
	 it3QXLzwfeLwKpBjsl/wZenfGDZhfOgJdQLuapgZl4qrMUZSvNxvpCMC5Thnt/NK6p
	 DlGT1MMEk1t0owPJWT+gVxrv0M7uqTBxNRt43d09jitt+kF0E3nQMHYj9AFXkJEtS9
	 w7i4p6yOHbexQuvABOQRCjLVw3mrpDsiY43Riy53tPhFdqrqF8rM1eLnF6bnoUrzgw
	 uGUIzcFJdIn3A==
Date: Mon, 28 Oct 2024 17:41:27 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 12/26] signal: Split up __sigqueue_alloc()
Message-ID: <Zx--t23RDsIc0qVq@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.971100589@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083835.971100589@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:16AM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> To cure the SIG_IGN handling for posix interval timers, the preallocated
> sigqueue needs to be embedded into struct k_itimer to prevent life time
> races of all sorts.
> 
> Reorganize __sigqueue_alloc() so the ucounts retrieval and the
> initialization can be used independently.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

