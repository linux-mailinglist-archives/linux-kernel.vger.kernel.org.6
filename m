Return-Path: <linux-kernel+bounces-199740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D628FA2BA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D451E1F26420
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8185713C80A;
	Mon,  3 Jun 2024 21:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EU5xtlkY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C739B4F1EE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717451052; cv=none; b=LDfz0Bx29AhzPHOW8Mh7Pc0jDgfeBVzASUBgJ54+jNVbPUVdzdRmx2/L+5rlvW+GfNckcSxR7Fbiidk+0bsZrInwaJ6cX8v79wBVnZXH5aaNWKj4nP1gDMtVLrTMyF7LZT2QKc5NMhuWmWJ/NwcPoUgBEA3Z0VAbun8vEXeQRTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717451052; c=relaxed/simple;
	bh=1wWn3DeKnFYXq+bWI3B8dKrzW7BjjRMkl5tKJbI1vmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miuYNWtLUozcmUowVWeAjmQ9Q4mVKbCsw1qoCI7bftpiwAhPb8hISZCotiMeWUNR/ikjs43chy2R12PKNHkzLZpGGuEcS7fbgGQNHSVzpnl0TDyjBj3G82MubDuPP66kpzim33byXp4PFgHgNtyUwJ1rE7g9TqBHdtOnAIyfLqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EU5xtlkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC809C2BD10;
	Mon,  3 Jun 2024 21:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717451052;
	bh=1wWn3DeKnFYXq+bWI3B8dKrzW7BjjRMkl5tKJbI1vmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EU5xtlkYxJJ/N4iCX4sVyeJ8MBymKwTe64Ne2LXZ0OqsC0Gfhr4GcNZ1I4fnPcGsw
	 TnV4q4yr1vY7iwqGfM4frQocC5j+jDYbOQ6ilYXYh4EJQ6nsJ9GGITnacqvDsKRBIN
	 7yI8alDxcXU4cLYyn833iYUZYgYNTb2iCiZHABrCt9XE+s+4K1sWqeP9PqoF8lCXSz
	 ycOsihdndBd7cYgU8exAVotkcdyh3mEFNuZoIIafbVN2z6NuipMscLtubdIitM9JFw
	 PcD82GCukN/un6qZQNnrZj9VmZoLYtsDPnDzyuS2iU9IP/7ymqTXzkrxg79QZ8uHH/
	 wxknuvFAPuBQg==
Date: Mon, 3 Jun 2024 23:44:09 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tick/nohz_full: turn tick_do_timer_boot_cpu into
 boot_cpu_is_nohz_full
Message-ID: <Zl45Kc_c-ro41cYs@pavilion.home>
References: <20240522151742.GA10400@redhat.com>
 <20240528122019.GA28794@redhat.com>
 <20240530124032.GA26833@redhat.com>
 <20240603153557.GA8311@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240603153557.GA8311@redhat.com>

Le Mon, Jun 03, 2024 at 05:35:57PM +0200, Oleg Nesterov a écrit :
> We don't need to record the cpu number of the nohz_full boot CPU, a simple
> boolean is enough. We could even kill it, the "else if" branch could check
> tick_nohz_full_cpu(tick_do_timer_cpu) && !tick_nohz_full_cpu(cpu).
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

