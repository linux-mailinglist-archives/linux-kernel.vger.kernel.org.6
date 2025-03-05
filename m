Return-Path: <linux-kernel+bounces-547099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 757CBA5030A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6968E188A5AD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A75624EF71;
	Wed,  5 Mar 2025 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAqxKavF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C926424C068
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186585; cv=none; b=liw3vlUeJTNUsOty4eud/h+hgh1RcfoM8BcnygWaXnFNtaRVz8iOtSN2aTWZA+lRD4Ip+FjaGETiDIA3Ea5R5Pn7Cc4aFNox+dlcazNJuPzWp4/1nUj4U5ZMpfCs82AjlmX3GuMJZDaRh/CIdcMJFPSx70Sc5aV18DhpPNyLwpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186585; c=relaxed/simple;
	bh=bD9VTv+58/iJVOusGC9jN7C/vDW0cSocU1ZfwHNXqEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SN7vsRK1cpzTmG4WvNC6WxCo+hgm6ipr2USSPpHV0KFQc9lWaaAVdsORbR/ka4w1V6L+ZPJTRYKkZLnyl7thk1d9oa3rzjlTzQwRx0InABpxLo3TQaX4094UsRYp7aFPtn95/KeRd7AE/CFcB0AARX6X0tiuyK/RlZej//FhQaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAqxKavF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F5AC4CEE2;
	Wed,  5 Mar 2025 14:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741186585;
	bh=bD9VTv+58/iJVOusGC9jN7C/vDW0cSocU1ZfwHNXqEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VAqxKavFqWdQy/oqyxjx2c+WpHYgIGqo5p58iOFGiak+RQhAGQTDHsgmqt0cxRIR7
	 mxPpeheOLL8rNPl+B8ctiq6sz4yp1KSqTBZ45cQadPwTNwu0FQoNFNfWcuQ5J9mbGV
	 +hNQPn6dZUpwNkHMfHoITLluuJLUDvIMh8fEL+dpZtIqJmNoVsLGdnfceqnwXPpg4+
	 bdz46I5Ax90JuLjm2S4A1ZB3t8fLaooxDzSMphCx4B+E70uWJewmHXXbs512cTU7qx
	 aZ90YX4VEr4nmwJd/rLkiGW1CsmSvhq2mgHmKZq64G8MJqm0vSa/SGn87F1ysrGP/L
	 RTxWKXFtRS8ow==
Date: Wed, 5 Mar 2025 15:56:22 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Oleg Nesterov <oleg@redhat.com>, Yi Lai <yi1.lai@linux.intel.com>,
	syzbot+3c4321e10eea460eb606@syzkaller.appspotmail.com
Subject: Re: [PATCH] perf: Fix hang while freeing sigtrap event
Message-ID: <Z8hmFhg5g7n3JKXP@localhost.localdomain>
References: <20250304135446.18905-1-frederic@kernel.org>
 <20250305081907.xHiR7jy0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305081907.xHiR7jy0@linutronix.de>

Le Wed, Mar 05, 2025 at 09:19:07AM +0100, Sebastian Andrzej Siewior a écrit :
> On 2025-03-04 14:54:46 [+0100], Frederic Weisbecker wrote:
> > Perf can hang while freeing a sigtrap event if a related deferred
> > signal hadn't managed to be sent before the file got closed:
> …
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Both of the test cases pass… This looks way simpler than the initial
> attempts, why didn't we go with this initially?

Because I was afraid that a pending perf signal queued before or during
exec may be delivered later to an suid process. But eventually I don't see
anything that prevented from that even before this patch.

Thanks.

