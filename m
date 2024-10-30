Return-Path: <linux-kernel+bounces-388837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A36E59B6518
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F971C20A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFC71EB9FC;
	Wed, 30 Oct 2024 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ur5Pbmco"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4F83D551
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296930; cv=none; b=lKnwwL24TTbMzPyV404bXVu7jRcAjnqOLk9aSGe+ZBqq40KlxB6W5q7jfj94ZQfkkBZ75CRs1+ZZK7atfnHQF3sWqGx3ZOBRxhbi6PsOxKZ5iq9byuy0JIprtlrHsr005My9ZNpy5vAxkR0eufOLPqI5rUGnSPYNQHxGVLoe9lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296930; c=relaxed/simple;
	bh=LhBFZOh8XS86M0e5F5YCCYNoaS/3CCvZYJBw+QEDre0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuGKwkrP4x8mkNOFT+7+H+gAKJA1dfk1/q/eSHzrnPCkKCBoaGj3zzUDJRl/kcfHHdcMmq9vB5OWQSTzFHgffadFHkMod5jVp0mHif0YviVkmhQ9xVN50DBHWm33JTd+azPBRzcbjBpF6pzasYfdy3UdT4l8Is3ApJ0clYm10A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ur5Pbmco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3808FC4CECE;
	Wed, 30 Oct 2024 14:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730296929;
	bh=LhBFZOh8XS86M0e5F5YCCYNoaS/3CCvZYJBw+QEDre0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ur5PbmcoYqOAJCBE5daVUCBRulUnT5l9d5DMo2Ma7aXnA8HwaN01J2x1SdjG1KTQ/
	 T7L2nUnQl0acT+isx+hXb1U8GiZdF183XaOrk2cH+VwnXs8Ox3+Lzq3CPB/TV1qFJe
	 DrzQmZj36G9f4Dpj+V/11mLpw4t1puinVcZy/vA/oxKNziG/MEvGlHtY8p4wZk1i85
	 l4DWXOpt/y4XEflQnE29N+x7lPJOgwwehRltFuEKTAC2hp2H+EygozaK4eBrCY8lhb
	 9cfAbV9i9Whou43X9myHRcRVPK5ZPXQoO34XwTL4G0TWaVuqOzYlfyhX9A37rpto7g
	 aMyBXNKMt/czA==
Date: Wed, 30 Oct 2024 15:02:06 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 20/26] signal: Provide ignored_posix_timers list
Message-ID: <ZyI8XugbXdiSrS50@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.455949409@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083836.455949409@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:27AM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> To prepare for handling posix timer signals on sigaction(SIG_IGN) properly,
> add a list to task::signal.
> 
> This list will be used to queue posix timers so their signal can be
> requeued when SIG_IGN is lifted later.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

