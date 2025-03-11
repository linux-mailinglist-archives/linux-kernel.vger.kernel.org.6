Return-Path: <linux-kernel+bounces-556228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69403A5C2E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52302176BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9933F1C9DC6;
	Tue, 11 Mar 2025 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0EnLtd0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DC91917F4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700470; cv=none; b=TTfsLVdzSg4FoVYo9ptB7CWqcHQojbUVHLvd51DvqxROui7QvQv3CNYKiBApcaa4P/tJiNhPq3E8euLi/zSmVuBJM1SkWXpEkDhggBolYsmpfO6e/ehiY0JR/z/oP36jVPMzjZTj1HWLrDwVQEHiP2J6w5uctcVmSw+1+PWlFyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700470; c=relaxed/simple;
	bh=Chh8DcIQeY7FNPlnkdwb8y4rimYXCFqGsE4KPdr8QjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJ5L+jseTIGxw7KfanLulYCOyT+BSXe8wCJhbaPiwpT08Vgb8Qr+MiSGKOt1xkG5eEFlFBDnUIP+AOcnmFDCwnJ6r0hLFDReeLi2CDnEBwc7/rFuvRO1f1icP5zrFcoSAStI05bUn4OipTOwcwYwDh+/07HW7oTBeAdv1z85aCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0EnLtd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0414CC4CEE9;
	Tue, 11 Mar 2025 13:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741700469;
	bh=Chh8DcIQeY7FNPlnkdwb8y4rimYXCFqGsE4KPdr8QjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G0EnLtd0N4mYipYIGTC6Xpx1RKK04QN9EPvqwNoa41DjeQ86hgFwU7pEE0lkaroVu
	 8/Dq5T85JkrBeyNtXP2rGNlwPcMR31IUzox/Ti6wKB8+6gx+8ZuLRUVVPhvxMa2uGT
	 I/RdQyqUbDsWSvwR42BIEoFxHPk21EXHefzH2ZKqQtTKb+Yr1t999ufRdYxu6ptMaa
	 Xvp87RUnLbQ+a/Z8Gy0Ir+UUNUBjCjvj8vKhbN3IinYSU+0is1UfAeZN47HiqiPTXl
	 mO9CwGY0ecZ00YEwWE4+aoTLMJK+TgMtfM51Ou/5Af2UeCuUtUlhjIuPNXQ9o6b428
	 eCNT/dQgQtAow==
Date: Tue, 11 Mar 2025 14:41:06 +0100
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
Message-ID: <Z9A9ci9kh55q-ax_@localhost.localdomain>
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

Acked-by: Frederic Weisbecker <frederic@kernel.org>

