Return-Path: <linux-kernel+bounces-363836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F59A99C7B3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E571C2308C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FA719D07D;
	Mon, 14 Oct 2024 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M1mIna2J"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488C01957F9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903218; cv=none; b=G1oZ66Efrkb3t91v4m+itz4UqhSO2ZigUUVXl3GEeZyL8p1bbUz2aWg86+7qnAjOolcFPRBfUy+A1cTPZimmMlN5H3doaVqVXyiOcHLztXDRg3llLaIB4UBTP/0CMB0my3spAI3UsXUgZsje04g66aPUoIlgB+l2PxMZ5xKJCfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903218; c=relaxed/simple;
	bh=awFmbp8ux6IZfJSM6Dj6QSmiZuzb9JVeGHc7XW71Xt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwxrr5LGst3giwCnHq/K7nvI/YHO5p7ZORu4SLN/u3MW+/6p8Bp7cCY8gJ9/stn2TleJfIGhJ+uEvKQxhlJMz67QJD/yCnmsvzQn7pNgw+1w5I0U0Ms5QHewpjDFv8s7kts8G/0msnBx30kMFWaEztTiSUMDk3/+wzxQrFE+uZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M1mIna2J; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=awFmbp8ux6IZfJSM6Dj6QSmiZuzb9JVeGHc7XW71Xt0=; b=M1mIna2J7Pk4vGdTHlm1u2QhSd
	PLXntp8w7Ut/aEW7lIh0/t+LwWoaLdAhfcm6bjtDWRp9B/e04kY6zEO/GyEgfqhruv8ESztot+OfC
	z2YOT6gSbJlEjF8v6uYEgx/+MEfLuNmBWWKIx6bP90ToxoTUBGUTEr9MGjizHr7UcfnqcSN67ZVgH
	Qo+SJg9Yu8x/Ja23OcKLWks8go5KBSsriRVPuUk+rO8mq1X6TZmP/vT9dxIG4WfTJ68uTScydQB2X
	Cznm/0xTnSYFbwuRlF2J5WILN74XvFPHe2iW4fnLhU2GoEIN0H8vhjuhn+F5lwU9DW75PgNdCkh+7
	1t8oGz1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t0IhY-00000001PD5-2ftM;
	Mon, 14 Oct 2024 10:53:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 25346300ABE; Mon, 14 Oct 2024 12:53:24 +0200 (CEST)
Date: Mon, 14 Oct 2024 12:53:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	Metin Kaya <metin.kaya@arm.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] locking: Fix warning from missing argument documentation
Message-ID: <20241014105323.GA16066@noisy.programming.kicks-ass.net>
References: <202410121433.jYN4ypTb-lkp@intel.com>
 <20241012165523.2856425-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012165523.2856425-1-jstultz@google.com>

On Sat, Oct 12, 2024 at 09:54:37AM -0700, John Stultz wrote:
> The kernel test robot complained the commit 8d8fcb8c6a67
> ("locking/mutex: Remove wakeups from under mutex::wait_lock"),
> currently only in Peter's git tree, didn't update the kernel doc
> for the new wake_q argument added.

I have folded this and a fix for the i386-randconfig build problem, and
pushed out again.

