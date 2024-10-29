Return-Path: <linux-kernel+bounces-387047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E96D9B4B28
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503D01C22503
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9EF205E3F;
	Tue, 29 Oct 2024 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkx9P7bZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059BE20110B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209581; cv=none; b=IfOvghVFAxbdW/8ca00x7DE6WLzQfFPmo+Nk2h7u83ozO/lbNcD6ts7b1cRRAFHQbhw2EhiuRu3jQhSlC6qx3hnGO5bMmj38cj8ucwJvjl42G2z1VtB8Y3mvqxGeEQ2fHApqnqbamysbUcHdjwCSf7QVU+46cw4pSfVGxnktpU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209581; c=relaxed/simple;
	bh=qT2oNxyK6MWD5NUw79HHClW4BtAND8ckQ+wU2Eqy8rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8JwgSiCuAzNggbOjoBrmYj9gbUct5iN3zG/EX/ERvTuDeOFz4QfKf2xMtH5w0r31gi403WLuinGZbf8/0s9eO8VX/eOGMRTIYmwFIqQPjYsHSRZ2OzwvSDFSbfzpvhtjqZyUiLHO+C14oJibdz+T7k3/7trmNgicdI1RquEKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkx9P7bZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4869BC4CECD;
	Tue, 29 Oct 2024 13:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730209580;
	bh=qT2oNxyK6MWD5NUw79HHClW4BtAND8ckQ+wU2Eqy8rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkx9P7bZJ4lxzHNAnQDV068yXEYcqBUCZHbDtZFCQk6Ncv0DDs2AziImkmopifVKa
	 MlP9sAyqPpqab+sRsC4707gIwWRel4jM1HOakgAwJighyaty2/g6YP5fRPCslNcd2p
	 NurlPaw7PSnHF4yprAQVQcRUgW5rrb3ZZ5blJPM3nc0zs/NGVCLUFzUUpWkgHFZbpN
	 AZFMp0EFMJCYf2z/NsRCvQE64daB/QaqPZeJOrmuQj7HJJOtYplP1apIIgTijDVcfe
	 9zLoywDSM165EjB5zQ/WXIvwMtfedypv491xnt6xSpnXdzEjoKwOYSARUbR+fSypoT
	 af+NC7oAwlClg==
Date: Tue, 29 Oct 2024 14:46:17 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 14/26] posix-timers: Store PID type in the timer
Message-ID: <ZyDnKY38s9LPhuHH@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.102492808@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083836.102492808@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:19AM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> instead of re-evaluating the signal delivery mode everywhere.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

