Return-Path: <linux-kernel+bounces-556240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8421EA5C309
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD6EB7A2522
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9DB1D5ABA;
	Tue, 11 Mar 2025 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Or/gVPnq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFDC38F9C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701202; cv=none; b=plwBohSrRgKU92mHYdyLs55aBNRhJJn2fobx/Lfs7aP/wP2RLhjduyk4sTqy4rMpC+Z4cr3s31csyfQ0h2AgKwfjonqTcK1O1AJ9MFDk7sMBrczunSQPweAJnF//A7PbAPVZPbVu8Lf90SRrd49oWy9MlbWAKf6o3JXK5Ii97z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701202; c=relaxed/simple;
	bh=PHV8IjUkkiY81QLM8n4aT8xD/wqL83Usp+RFEZCA7pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMIh1e33SpvncOSPLpH/bJ5yvHSEeCMAYfzU/QA6gJ/c9ahlSJr0G10M7vowYMnh3EZQPG0SjutSKrfu4BXi/TGpf9GfmWBcHOA1GPkoZ5C5q0qbvu3V6zHLkVL70nSIq/IOKyGyvpr0g4A3BUzBCPVOLgLl+lwyIq7ASrlmrdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Or/gVPnq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EC3C4CEE9;
	Tue, 11 Mar 2025 13:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741701201;
	bh=PHV8IjUkkiY81QLM8n4aT8xD/wqL83Usp+RFEZCA7pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Or/gVPnqTYZtjUnV5r1De2+LZBv/k2AhmvVYF4Z7Z5I8FfvLlAQYFxbbgG2Eykjyo
	 8Mr0BujSiVK40pfzz3tWUNtjbWizQ919zgdystKQiq8xWCkYCAokSQCDezkP6szPv3
	 0fZkXYaHzQNg4eIAxSUlaWAM4acrYJLXTNhsDsfbGdbHiN51FoHlDYZOyzq8QnhCQd
	 ifvQKm6rJc7wFhKG+4cJUiyf10aLj+vSBOWPy53/dxJEpXSxF4dUpSb04CsAfvAVJN
	 UCHo/y5HK36ceiR/96R/e7sQL/iTZ0MzbRIcxWuksXyMn7rUz/SMgeAh70ixChKWZN
	 za8G72Rksg4Yw==
Date: Tue, 11 Mar 2025 14:53:18 +0100
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
Subject: Re: [patch V3 14/18] posix-timers: Avoid false cacheline sharing
Message-ID: <Z9BATkiH4LLpt1C6@localhost.localdomain>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.341108067@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250308155624.341108067@linutronix.de>

Le Sat, Mar 08, 2025 at 05:48:42PM +0100, Thomas Gleixner a écrit :
> struct k_itimer has the hlist_node, which is used for lookup in the hash
> bucket, and the timer lock in the same cache line.
> 
> That's obviously bad, if one CPU fiddles with a timer and the other is
> walking the hash bucket on which that timer is queued.
> 
> Avoid this by restructuring struct k_itimer, so that the read mostly (only
> modified during setup and teardown) fields are in the first cache line and
> the lock and the rest of the fields which get written to are in cacheline
> 2-N.
> 
> Reduces cacheline contention in a test case of 64 processes creating and
> accessing 20000 timers each by almost 30% according to perf.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Impressive what a fields reshuffle and alignement can achieve!

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

