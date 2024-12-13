Return-Path: <linux-kernel+bounces-444897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C402E9F0E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9950116194C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6F11E0DB5;
	Fri, 13 Dec 2024 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ii+ysA+J"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3051DF261
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734098401; cv=none; b=ojcGzTc1ZSamEzcBsEfajiop3fLqNQKxgvFSUNvPwgy9rRNNf5V4j0uH296iRg5Up+56Lycjan1jJDCl20XeW/mEQe92bdpODfvYwySzN0Nke0KYSRGlb6S6257SRtokobGetBZXj3+17XOS9Z2Aawcg+mhWuDLUi9edjJFDtqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734098401; c=relaxed/simple;
	bh=nRUSe8N0VA3TMWzHYlRaz9miwJX6/Q4vB8Kwwp/0dsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRJ8q7DotS7G+AXXpf98Mg4G/SoXNZEmEkX6r5yjKQ13UkNPsSaM3j8J2zYjlbO41lyEXCu1GymEX72Uk1OLeY2FqPl/k/vMPGxIYZPjMlhZa7gAJgjhgxwLtDx3dgnsCccyPXcxnC4I8QMJbagUuQOiNW11jL/eQkVxO9mZwk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ii+ysA+J; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xF2iST7mu9iMOj03ULCOuMhmH29HnPZfnFmY94Etvtw=; b=Ii+ysA+JQWtQ/niEISIXMQARwR
	9CLZPQs9rc9civzBHHsdh4UrptaGuXfMqJnBIMlqLv5gxBZTH+jXZknH279QNbDER88Un3Qec4zLH
	hA2aSJKXD20iVF4OkKEyqfoZdKczbjrZjcPBZbnvVyaIuXR1hXIbcubkGcdKOpMO66PbRHnXSX2ud
	TqeuInBOSbqeF5L2ynpXrAb4jWhMJ4fIz/8Q11fo9Cy+dNJI0dQaJYwGyOnu3CwlhVNiFG011T9uK
	tmEi1746akg/U1sYhuQHfeHTBgz9PXT5ugMfZ3KTaZTxS4+HL5ux8vhs/gotszzoSYdo4p7Nuqkqe
	VKywad/A==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tM6Cx-00000004Hpp-0Fd7;
	Fri, 13 Dec 2024 13:59:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6528F30049D; Fri, 13 Dec 2024 14:59:54 +0100 (CET)
Date: Fri, 13 Dec 2024 14:59:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bert Karwatzki <spasswolf@web.de>, kernel-team@android.com
Subject: Re: [RFC][PATCH] locking/rtmutex: Make sure we wake anything on the
 wake_q when we release the lock->wait_lock
Message-ID: <20241213135954.GD12500@noisy.programming.kicks-ass.net>
References: <20241212222138.2400498-1-jstultz@google.com>
 <20241213124614.GA12338@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213124614.GA12338@noisy.programming.kicks-ass.net>

On Fri, Dec 13, 2024 at 01:46:15PM +0100, Peter Zijlstra wrote:

> +#define WRAP_WAKE(_stmt, _q) \

Realized that those are the wrong way around, this needs to be:

#define WRAP_WAKE(_q, _stmt...)	\

to deal with all the ',' in things like:

> +		WRAP_WAKE(res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx, wake_q), wake_q);

Anyway, still not sure its worth the trouble.

