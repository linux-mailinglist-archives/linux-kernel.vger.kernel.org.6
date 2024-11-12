Return-Path: <linux-kernel+bounces-406091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99B49C5AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFAE281D65
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5F91FEFA8;
	Tue, 12 Nov 2024 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F1B6DnyH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sKKYrTPv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6574C13F435
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422926; cv=none; b=IU+3Wrb55WSpRz8CIJAyyhTvBznV+trsHsZSZ5qZyqi1zoCidLGJoiiC4mBUIeI4g4tbFGakrVPV/I0D1L+rJp7sKvElJ2lt2SDg5eXYWqtRnM+Fas62OjWqeSRwAng4xg+2h5CWkdCmiM3KPSK8VuPq216qsKKNYLfTbmiF+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422926; c=relaxed/simple;
	bh=D61eWjOrFwpgEFmkwTFdnMMEWAwxYM8vo6p7qTrJLoo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YZgDUrdD1whsSgr9ECkQLkYaMec4oIdNENcO60zwxuQDOBpFAvmwq9d2GoXTJ2AzFIvWRMSf4B8TKxNtKgfYM4dUVe76JiCalUi+nHbP/fQ251sB/vYuIJkmYEninY2Uj+CGwx6KK1+qFwCwDYRM9kDBO1Z8p0OWGOIOPmuVYlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F1B6DnyH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sKKYrTPv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731422919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwdFJEsHTVikOnAMWlThCtaM9ig0AlTkkrxPLwh79S8=;
	b=F1B6DnyHBcOeFoSpLz6a11tktazX2qCPB4z7i0+Js4oPjybyj07gKBlXK6fMjWGDHyPBap
	88T3caRR34Ps3P0kF80WU0qKE/+Wot8VaM+//yRibCBp7oBrJwOdeeP5EVlZqpgKkL58Sj
	fAHbO0UYMiEvkfnBqFv5v8MjQrozGTJoF6Ntvyd5Xi4QH3rl2JCs0kdnb7qHX4bfOFrEnE
	v3EVZrlgbbc9R3wqysXkQcfOCWWhUF39PNiHjhtJictJHg7feRMPUV4dcHWEqFQ3Iqp8CL
	voBVH/u47QZnbG0HSDfDZD1e/tNSDOElLOfhAYgoGi/kGcJaHl8NZRhBKzIaxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731422919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwdFJEsHTVikOnAMWlThCtaM9ig0AlTkkrxPLwh79S8=;
	b=sKKYrTPvI5stYDSsj/LgJmZNDhL+U3P2w25SVv0kCXkpnoKJeK8Bfs+QbQuc7Epudv/DJi
	4D6fc9n2r2e4jFAQ==
To: Joel Fernandes <joel@joelfernandes.org>, linux-kernel@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC 3/3] tick-sched: Replace jiffie readout with idle_entrytime
In-Reply-To: <20241110225545.GA1579217@google.com>
References: <20241108174839.1016424-1-joel@joelfernandes.org>
 <20241108174839.1016424-4-joel@joelfernandes.org>
 <20241110225545.GA1579217@google.com>
Date: Tue, 12 Nov 2024 15:48:43 +0100
Message-ID: <87y11omrsk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Nov 10 2024 at 22:55, Joel Fernandes wrote:
>
> +       /*
> +        * There is some time that passes between when clocksource starts and the
> +        * first time tick device is setup. Offset basejiff by that.
> +       */
> +       basejiff -= DIV_ROUND_DOWN_ULL(tick_first_period, TICK_NSEC);

We clearly need yet another division here. Especially as that division
results in the exactly same value every time.

