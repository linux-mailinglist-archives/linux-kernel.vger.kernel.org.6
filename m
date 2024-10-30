Return-Path: <linux-kernel+bounces-388800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C52799B6489
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F4A1F21964
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5771E1E8852;
	Wed, 30 Oct 2024 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgW8R+hX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22812EB02
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295932; cv=none; b=PUiQYpyek3QzNhmWl4a3JgxnPQ/oXH9sQe7L53F/sL/Rd711uzK4BN/aGHBBQcAP1nGFAYpAP3sEZVYHu8TZZxWdZonm1N5Zq3bqgtgvRVxz2zXF+6LqHcyym5xNnkN616K13qm2n4KfOeyLu/g5ZPPEo+3SmHtCJ30aBPh2Nvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295932; c=relaxed/simple;
	bh=7Bxt9L9WVuyMEm/Nk2GL/sQJDsMYOACIhygsoXfiub8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRNDe34rO9tUhkniCJl+x1j2E2RRTB/d8EEOWt43oYRRuIO7Z/UnzXvHbKKC9veTMkzokFSsDGA3Kw3A9dhBAh9eZXNkIM3uJoiIbTRJt2k1Oe0MSUceaY4TQNMshMDMbzn3SZhAO0Fr2AYl09S3P6geWLQ+YYRbNIRWBL+mxYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgW8R+hX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29EBC4CEE3;
	Wed, 30 Oct 2024 13:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730295932;
	bh=7Bxt9L9WVuyMEm/Nk2GL/sQJDsMYOACIhygsoXfiub8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgW8R+hXPKWGYEAF/i6jaW4933OCOxb6QwrO1fy3KmNfPSIaMhAxLDNnLzARWjlg7
	 RdbcQRrfY0S4DAOpbI0nLX/B5QQdH1nGrC9IOvlXioRR52gAIs7N1bQ6wq9tbCRLf+
	 3tjQQth1HOSM93PRVpvdwEsKH2gX9COOd2QhgJ+uSLQIreMWn6acUAIHDpYAGuyBJH
	 WYWMvd3Vb3I+1pM+zmXBDJuUCefOIwR+5oR4rZ9t1v2nXVo9M93koIMTj5z1pl4QTr
	 TfUN/1PrGjax96VnaV6n3ffX+dZ8B4QxZPbbZsoTpgePArIQtKyPphcSRYcsc6XYFh
	 5ZKKm9GahfYCA==
Date: Wed, 30 Oct 2024 14:45:29 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 19/26] posix-timers: Move sequence logic into struct
 k_itimer
Message-ID: <ZyI4eYlhYXXIJff6@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.396279339@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083836.396279339@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:26AM +0200, Thomas Gleixner a écrit :
> The posix timer signal handling uses siginfo::si_sys_private for handling
> the sequence counter check. That indirection is not longer required and the
> sequence count value at signal queueing time can be stored in struct
> k_itimer itself.
> 
> This removes the requirement of treating siginfo::si_sys_private special as
> it's now always zero as the kernel does not touch it anymore.
> 
> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

