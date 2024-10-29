Return-Path: <linux-kernel+bounces-387023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1359B4ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B34D28497A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358F1206046;
	Tue, 29 Oct 2024 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2ViYC/I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D0220262A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730208328; cv=none; b=ZxcygsN2EGWfe9m/0kGazsiJ88zMP+f+U6/RwzZEI7WpmD2vaNJyXGg7kwGo2V5dtfy3KhcmVjUeV1bnjU+6GRAkM7UEYxnntkLGVTnWXq5IsGfLLFglDoLQKKkNxnqi+eNzgKp486FEeRBDuC7dXSRhgyuquhP8wPtCK/1gCWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730208328; c=relaxed/simple;
	bh=GOjJ3ghAxRH72DkpOJCBtp69b/B0NpORcs7/kwmGGzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sn0iiO7jO3bg69sS+xSl3P8HUjd2JN8Dd4QDCBJjaZM+yybgIIln/nwsoJ01HnGv+AiRB/l4/6FRXZsK5SP21zF6bpKqW6JL2xCTPTrOUKdK6kn/8KXMMJ3ZdilBi93djzRz8U36cqfJbO+TzWDMYfiC13pX/pqLPepcovxY2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2ViYC/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F918C4CECD;
	Tue, 29 Oct 2024 13:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730208328;
	bh=GOjJ3ghAxRH72DkpOJCBtp69b/B0NpORcs7/kwmGGzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2ViYC/IeDoX6GQ+EP9VQYCZDuA9VtArurGPtK+o9DXHXHJj37cmNnDS9oThwdKFn
	 tOY/blRAKqmuaVc35Wb6GkmCyFMczAUgsACkwROBG0cX8Dkd6kPRvmW0Q4b5op+r8P
	 Qp/dhIEK4122wetf0qQAT2DmQnb1Isoy0e7/A8zSNbodH0CusaELqz5q+fb+N/D1LE
	 OV1LZh4ilBtbK4BQTKQ12EhDg/p5AZGdODuziSO/xhqWa3A/dXl3WVtJGrHRUWMvw+
	 lt6ZGARK/QPI6CXOn2J+rguNX+bGXNMJuP1dc4soRcOZOMwuEg9pG/zShbjuum9VNR
	 uqBm+8A430dbA==
Date: Tue, 29 Oct 2024 14:25:25 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 13/26] signal: Provide posixtimer_sigqueue_init()
Message-ID: <ZyDiRSEqJgoCQXRz@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.031093453@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083836.031093453@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:17AM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> To cure the SIG_IGN handling for posix interval timers, the preallocated
> sigqueue needs to be embedded into struct k_itimer to prevent life time
> races of all sorts.
> 
> Provide a new function to initialize the embedded sigqueue to prepare for
> that.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

