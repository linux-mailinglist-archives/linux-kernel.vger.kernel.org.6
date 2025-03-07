Return-Path: <linux-kernel+bounces-552059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB37A574CE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E6617556D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880B91A0BC5;
	Fri,  7 Mar 2025 22:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jT71TCLQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D961F94C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385768; cv=none; b=OYWhcbRcFsn5/R4fZv1baSvZ70gokXw5HsnFPbaRZ7g8uqaaUxrHHvDQvRaoEg04j8QlC8DTpH8lKkOkSEOBo2ryPjChrz0XbzuBJJmT4nTEq/6SOc5pmb90jhVkiCGoKSeBkbFwreI6hyEHF/CC+9xXkBHclAY2N/HUev0r8Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385768; c=relaxed/simple;
	bh=tfjO0wLc/sY0wUsPLXOAszI/hnr/k/6TVIxNQkkddp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VukeMl6bgCN7SSysv8b9U1onoGBTqJgAlM5t8W5FSJn+dNGX14FH2tNjQk7WKkJ0ktDV149fPrUzvjjOZSPmPlipKF2Udtbf4DPrQ9yBXbgdP/vRj9rE3n8D5qp1tRhhHYhg/oquI/BsB7rAToDFbccZxLCFPWE7eWua8YzCLBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jT71TCLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F0AC4CED1;
	Fri,  7 Mar 2025 22:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741385767;
	bh=tfjO0wLc/sY0wUsPLXOAszI/hnr/k/6TVIxNQkkddp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jT71TCLQ/ofLsANiDQ7d/9BaltnW6/9ecifsnZxLsLB+CybQfdyL2Wr8VJ7kzuq8k
	 9/DMf7rhDIe0iifdgBN7TU+L737oPhXItvSG+rl/VdUVho7jxS4kR8+1pRJyYa14XY
	 zw47HM2nQ2qfLOYUnSiB2qERf6yx3C3mlNI1Z0DEY5DskGjKBGPba1d82/ks6LLjmz
	 ijhDiTQv+WO1cGGwBEcbft55jo+EUKx2aet9DyJxqz/axuWWIPeTthxP4kyM9MfRkt
	 SVF9RAROBxgRpS7tKuqvg1zsK+LWXruXSrdwGbgba9sm3VF46yTqpoUMGnMHy6qAcn
	 G4DUIpYmVybNA==
Date: Fri, 7 Mar 2025 23:16:04 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 07/17] posix-timers: Simplify lock/unlock_timer()
Message-ID: <Z8twJAGEZs0kiYtz@pavilion.home>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.354754536@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250302193627.354754536@linutronix.de>

Le Sun, Mar 02, 2025 at 08:36:54PM +0100, Thomas Gleixner a écrit :
> Since the integration of sigqueue into the timer struct, lock_timer() is
> only used in task context. So taking the lock with irqsave() is not longer
> required.
> 
> Convert it to use spin_[un]lock_irq().
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

