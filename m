Return-Path: <linux-kernel+bounces-227929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1210191582E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4040C1C2352F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3251F1A08B1;
	Mon, 24 Jun 2024 20:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtg3yhfL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7631934CDD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261760; cv=none; b=kpzgbBnb8C5bpCeE49rr8WXNSpeupncdphsT3Y+gEULEAF1H+IMwV3qbPE4tAXTepNBzBlkzce8AaB2M6Kgj8boMQnbPfGWurX0w0vx3r5e58Kgzjko6G7ZMVG1K02QWzSJvGBe6QlXvw9+1zZcNlr21e3/p+XOuADRMz29stC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261760; c=relaxed/simple;
	bh=dVNWw7bYh14JFkIYcIyxlf/t6xd0npPsATaO9j0uo0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmywcbEVTPXTkZ8eCNbX/xFdClkV7KX8K/EqJ8VmEQbv44w7an7uqZQb3cuTpHmSpEtwz7mJhXHbF6gpsKYdOYFymShEB9GFhZXueklAf2gttzTp5Y1ddPX0CguVvAq/mSvvZunM+lnc7pseNLZRSYQbexsjO8HG5ShnkRBCcVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtg3yhfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD42C2BBFC;
	Mon, 24 Jun 2024 20:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719261759;
	bh=dVNWw7bYh14JFkIYcIyxlf/t6xd0npPsATaO9j0uo0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtg3yhfLRjYeUhHcDZHguHkeQquZ6EuDCucFAUJqchXT9FjezaMpeNc0VLQJ0ezzL
	 6V6fq1sb6zggHLgMYyrU2nhnF498g+jWCGXOFgqwmraE4yG1pThVzy2+YHlR6rzQlQ
	 v4cN0VUZeyLlBnsikf4NllMuJlqrlnVEXmcCQLrOX1pnQS0biUFMZfeOcdh0jj1Zez
	 Iqg6TchgvmMHqkfntWQZlJuWgnvBrZV56/h6XrEsPOLgx8W8P3kElhOvOmEoamkQuN
	 axju5kxAU5xzBdz9leTVgHStgjYU0ozL3xyDN+3ZjsIwhYgWMPLKVNYaGRsY47XJO1
	 1CykUG3LmOrcQ==
Date: Mon, 24 Jun 2024 22:42:37 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] timer_migration: Split out state update of
 tmigr_active_up()
Message-ID: <ZnnaPW-PCbw3CL-i@pavilion.home>
References: <20240624-tmigr-fixes-v2-0-3eb4c0604790@linutronix.de>
 <20240624-tmigr-fixes-v2-3-3eb4c0604790@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240624-tmigr-fixes-v2-3-3eb4c0604790@linutronix.de>

Le Mon, Jun 24, 2024 at 04:53:55PM +0200, Anna-Maria Behnsen a écrit :
> The functionality of the state update is split into __tmigr_active_up() to
> be reusable by other callsites.
> 
> This is a preparation for a fix of a potential race when a CPU comes online
> the first time and creates a new top level.
> 
> No functional change.
> 
> Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

