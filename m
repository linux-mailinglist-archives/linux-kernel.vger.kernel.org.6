Return-Path: <linux-kernel+bounces-390272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BB09B77C6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6E6281BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00500196D98;
	Thu, 31 Oct 2024 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABLZT2rp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580CC17B436;
	Thu, 31 Oct 2024 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367879; cv=none; b=BtP1xTEUb3QdJlopH/sDHn6TC/8Gcx5NueZRryLENRAIlrAZ9+clmZx4M3JwePnuk5u7NSTfjt6ddfux3Mg5ZmpZNpUQqlbAuWdPRu5QL2TEsW02m7s2mTIQ7wiKOrkqRDFSMEiHSJaCNxUTF+xF3Bwc73dwXMRUuUx7Jmks6Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367879; c=relaxed/simple;
	bh=5hr1IO9b1QJPUj0GISxhuSispy0SGwK34xbuVh1pl+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbKjNcB0BFgblOUa6iJmYi73+iyyJSL4+Y8u8fiM3pKBTM8n+XKXZchtL25Sa1+qSa6r3su4723jbpypr9soEf6yoOqHCCdQ0IVUapbEA6yVfDuvlse9Vm0mP85pL11dtKEcPoN5G2JLhBKf9kzr82kreKuem2OxaWfP9Ok89xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABLZT2rp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87749C4CED0;
	Thu, 31 Oct 2024 09:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730367878;
	bh=5hr1IO9b1QJPUj0GISxhuSispy0SGwK34xbuVh1pl+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABLZT2rpHAIGds7f9myX6uZvADX7oSJAyTjn6uJyrqpPj4MVNMHNF1ssLIBwNeWbe
	 XR04ofbe5+c6BwWrZd8X6hBzvEfkIkNvb0hVY4RKvJ7uEudzEH24cZLb2Yv4xHqxve
	 GMh4OFaKMCt1CN4IEYTPv9KGkNRaxsV4mSz2HeNvegl8Oy81GJDe3+7i/ofCgUf3MQ
	 nS151V123CPVWHBRxjaLC/jUMM8q9E4cPhXKrYzqCTV8ZnO4wlv1tomC0+UI1ITzen
	 XKtSFXbFYcQ6cMn8pvU5FAEs5A1j0IHyQIdWG0N4sH/7mIuRwqQM6pHDmVHeT8VyiK
	 0hqMp7Qiks+9A==
Date: Thu, 31 Oct 2024 10:44:35 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel test robot <oliver.sang@intel.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org
Subject: Re: timers: Add missing READ_ONCE() in __run_timer_base()
Message-ID: <ZyNRg/fAJKY2h9ql@lothringen>
References: <202410301205.ef8e9743-lkp@intel.com>
 <87a5emyqk0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5emyqk0.ffs@tglx>

On Wed, Oct 30, 2024 at 08:53:51AM +0100, Thomas Gleixner wrote:
> __run_timer_base() checks base::next_expiry without holding
> base::lock. That can race with a remote CPU updating next_expiry under the
> lock. This is an intentional and harmless data race, but lacks a
> READ_ONCE(), so KCSAN complains about this.
> 
> Add the missing READ_ONCE(). All other places are covered already.
> 
> Fixes: 79f8b28e85f8 ("timers: Annotate possible non critical data race of next_expiry")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Closes: https://lore.kernel.org/oe-lkp/202410301205.ef8e9743-lkp@intel.com

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

