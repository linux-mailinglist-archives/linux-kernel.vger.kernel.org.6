Return-Path: <linux-kernel+bounces-555254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E8DA5AA01
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD0C1715D8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B83D1F78F3;
	Mon, 10 Mar 2025 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5Sc5yHY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1D21CDA0B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 22:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741647475; cv=none; b=JsnGkzIdt5JOdcmRR5XI/Ci5sF4OEuj/j6d1FUQTyeSMHsCVuKBB++oD9Yc+VD5MKHM8aObT52ZZI/1sZS5olYvQ7nFKc2SS7vzkwAg3QfaOiEOlTqbaZk3uH+3A1+dhscFtU4jjSmdECPX+QXnrxPgE26dTOwuD7Sx35orLBJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741647475; c=relaxed/simple;
	bh=mS7Ni7eXtV8MarYMhspnYPpvMyPdagPovr6nXzMI8Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1DAmS2xY8zfOyG16RDbrOjUyDQaXeyK2/5lWKIlY+pXhQOIqLt1sMwRfEcafxCVp1J2tiwwpHaeA9bZsuaoqhp+eReUeURVcJIbx79Lx6BLnHVBZ5DUb5BJNaRBfcFx3sn2T2PTcJJj9XPBr6yt7ijTBe84m+SCuKIB9uB/zpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5Sc5yHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B78C4CEE5;
	Mon, 10 Mar 2025 22:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741647475;
	bh=mS7Ni7eXtV8MarYMhspnYPpvMyPdagPovr6nXzMI8Dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5Sc5yHYo/8xLPZAVQs/QXjp4GkzstWI7cnfrym0f15u1yZYNiQvQpjSWvKMlKSaB
	 EjeimzXMcijWOwsPSwIztlIbMOdQtOq14k7eg3YQP//HZRqD8c8mjaRlGtRHWmg/uy
	 BARtJcARf0c4AJ289rZJ9aDbFsoWUMsjYqIPvZjEPzxReG6udQailR7VfRCpaOMnLE
	 t/Mz8VsnjRCcsbhTh9XmUdJxocapKsCINrGhFwyGQbXBAAhINR2TjuWMzinw9F741Y
	 etbtV6yD25ph+dcObL05l5N9+cHXw7dXhnLMJS4FNxWXUg86G7+ia9iPeZlTltv3Iv
	 Yf4Rgxaj8TRCQ==
Date: Mon, 10 Mar 2025 23:57:52 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [patch V3 11/18] posix-timers: Make signal_struct::
 Next_posix_timer_id an atomic_t
Message-ID: <Z89ucAl6n4uuPu1E@pavilion.home>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.151545978@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250308155624.151545978@linutronix.de>

Le Sat, Mar 08, 2025 at 05:48:36PM +0100, Thomas Gleixner a écrit :
> From: Eric Dumazet <edumazet@google.com>
> 
> The global hash_lock protecting the posix timer hash table can be heavily
> contended especially when there is an extensive linear search for a timer
> ID.
> 
> Timer IDs are handed out by monotonically increasing next_posix_timer_id
> and then validating that there is no timer with the same ID in the hash
> table. Both operations happen with the global hash lock held.
> 
> To reduce the hash lock contention the hash will be reworked to a scaled
> hash with per bucket locks, which requires to handle the ID counter
> lockless.
> 
> Prepare for this by making next_posix_timer_id an atomic_t, which can be
> used lockless with atomic_inc_return().
> 
> [ tglx: Adopted from Eric's series, massaged change log and simplified it ]
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/all/20250219125522.2535263-2-edumazet@google.com

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

