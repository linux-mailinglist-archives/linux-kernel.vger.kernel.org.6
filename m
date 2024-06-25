Return-Path: <linux-kernel+bounces-229799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10F4917454
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A8D4B23836
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FA517F374;
	Tue, 25 Jun 2024 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lENp0ou5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D1B149C6E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719355013; cv=none; b=GOQoiacdk7PGbnEOL4wSlKpUWUpMrPRxE9bU1RpuhMBOx5hnzKcQBF35dHtzLppDt6lblr8pUN1ZSs1EI/wfvsQPFShuHLhpFq3bpud/Wim6SMw+uNPnprLm5dBsCXZMBTzO9ZBfWk55b0iQdFb+PLCFVnCcvyIIt2OidkWjWQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719355013; c=relaxed/simple;
	bh=V/yWMHliahuKyTKYbyYrNVisnOUTuFBEFP85pVG5mIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZE8J/FM+r7FZT3tPCWSvmZc9X7p7YY/EscI9/sHNi+hW7H/Bf6w0VQ7szYmxgnlsS0xVsxzoboToB1/5mbgXsNFbb4CCEoOrQYvx9mzg7wLjIS2s0IWilfRkZFEdF6tE6AKLNUFPzFq7xN1KkIscS3LO8mrZWMS86LjKtk1sI90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lENp0ou5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D779CC32781;
	Tue, 25 Jun 2024 22:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719355013;
	bh=V/yWMHliahuKyTKYbyYrNVisnOUTuFBEFP85pVG5mIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lENp0ou5RpmZOfDoFPybEZZDUPB8irVL2ihkjundcI7BqA8OxMLPljG3dWryce5l4
	 Hn3F0evj60plagavBW0bDu1KuiDTwi9nQUPrt3rYN3rWx/CzT7+fRwX371EkmPch7b
	 CK4QwkhJYVwBUzzBWkp4A20X7lWXVgQS+wJCaB9xu6IJ6lUzTuGbmeI9y249UEWaXt
	 pMU4GIbl4jvTqpoQuAX2sdvtcydhMmdMaugIjt1B/pst8jvhfPGmuPoSE+mv2LnajG
	 ByJ+O1yQm2sBMIx5RVQxDM42kHfTBlUuk93zC60EicsURd3wZpj/wL23ltJGHIdhfn
	 ki+kTVdjijxrg==
Date: Wed, 26 Jun 2024 00:36:50 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V3 21/51] posix-cpu-timers: Make k_itimer::it_active
 consistent
Message-ID: <ZntGgulhIS5-LvBO@pavilion.home>
References: <20240610163452.591699700@linutronix.de>
 <20240610164026.806827615@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610164026.806827615@linutronix.de>

Le Mon, Jun 10, 2024 at 06:42:31PM +0200, Thomas Gleixner a écrit :
> Posix CPU timers are not updating k_itimer::it_active which makes it
> impossible to base decisions in the common posix timer code on it.
> 
> Update it when queueing or dequeueing posix CPU timers.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

