Return-Path: <linux-kernel+bounces-199742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6D98FA373
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71FE11F26420
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B58923A6;
	Mon,  3 Jun 2024 21:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyTJedcN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA8313957B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 21:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717451117; cv=none; b=rgvR2lzI9QmMxwtpBXNVrcj4k1WEF56OVo2CzvOsy1yPrDfmddu9PG0Q8vAc4CuB6yQVocVLxRQIPl2atR6fqE06Squ8u0TQ9376r6WHvTxVqMLzbTj7cvJK9hxjs4UJfQay6O/FLcLap53fCEZG67HoQlwaQi8lx1Uqe8Yb4wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717451117; c=relaxed/simple;
	bh=ZEwg74hF/bbOKKTVOBmAMdDaEHpa0tnTObwAd6aAfTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCoSgsIMrSA+zdrCMkLNNuI701S4NohVRTCJGZZo3PDCsT5vxIvi+OJQjZN/mOUpfEC9CrCqoPZGJpTPI4XttkIxrVOlONrLgBbV1VcAzPq4Hx0xUUtZ8F32LfZaAE/BStzwQCRiHR3l8iawAHZQZkfdhSo+VMujBBTZx0xaJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyTJedcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C194DC2BD10;
	Mon,  3 Jun 2024 21:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717451117;
	bh=ZEwg74hF/bbOKKTVOBmAMdDaEHpa0tnTObwAd6aAfTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nyTJedcN0wcdQlZtaglvj6tqjf3TzPs5Ln4IOYxI89P2Ely0CPFW1v8702BW5jV/1
	 6zJKzO+9ph+S4X/EWWKTYMhGNGMj/yYDbl0IioekiiBuSqaoOifHE+pbikLzabFDMi
	 12hCjVP0QyxkzVmCdPMEwWVSmG2yjyMU7AACd4vq1pguPytgEe+ZBgNXalY2vrOwjf
	 BFikIa0hNYAv06Oq+Xh5U+wwMtTbSzmkFhj5v1ImtnFceQum+6QDHpGwELuhW4kyr1
	 6PeWynX3bo0wpM/IkDqxlaZNiymBX9CmRarSr6MakLR3XoEi9WwCeolL1LIG7drQ9l
	 2tacZY9Rhn4VQ==
Date: Mon, 3 Jun 2024 23:45:14 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick/nohz_full: don't abuse smp_call_function_single()
 in tick_setup_device()
Message-ID: <Zl45anHuse49j2Wy@pavilion.home>
References: <20240522151742.GA10400@redhat.com>
 <20240528122019.GA28794@redhat.com>
 <ZliSt-RDyxf1bZ_t@localhost.localdomain>
 <20240601140321.GA3758@redhat.com>
 <ZlzkJGPEIfWC3Ue1@pavilion.home>
 <20240603154133.GC388@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240603154133.GC388@redhat.com>

Le Mon, Jun 03, 2024 at 05:41:33PM +0200, Oleg Nesterov a écrit :
> On 06/02, Frederic Weisbecker wrote:
> >
> > I guess the static version above should work to remove the ifdef. And yes on top is fine.
> 
> OK, I've sent v2.
> 
> But again, I won't argue if you prefer to keep tick_do_timer_boot_cpu and add
> WARN_ON_ONCE(tick_cpu != tick_do_timer_boot_cpu) before WRITE_ONCE(tick_do_timer_cpu).
> In this case another patch makes no sense, I'll update this one.
> 
> Just tell me what you like more. Sorry for the chaotic emails.

I'm fine with the last one posted :-)

Thanks.

