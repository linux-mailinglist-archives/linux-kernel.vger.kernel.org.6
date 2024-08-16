Return-Path: <linux-kernel+bounces-289682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1CC954923
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E1F283A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D581B3F0B;
	Fri, 16 Aug 2024 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+aK3wDg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1705617BED6
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812652; cv=none; b=YFoFTpZFDSrFZlzMhLj1fScEmS6PB7iXbHTh1d8BrHXSXRSkO+xMaAZGBzzZR4xGfnC7lt/W1GhZtT2UMEzQhwdzLCVQQM4+3X3Ns+N25icYjhEkktsvJKwdP3LXAB/+fkLsq8e4kMqs4gONJAumCQeuznPlFAf4Y0u+QUjJZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812652; c=relaxed/simple;
	bh=2DMTk7qGgUKI7Tv0hzxQBy5VlW/I6NlUyU61m2aEN58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+CRBZEGXKhcmdkop6mDrWVSAV0lFzCJd61Yf0+1QyGPcrlmljoCcyTJ3uCMfuvyJITs4NbzNUas9PUijLmYIf01tLVZHhR4DQZYVL3EZYyJFwVrnr5E7tOCA6MV+0eQnx1R86fvc1c/lKr5Cjiw9IAyb55mXhSSgcUspg2+/q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+aK3wDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A716C4AF0C;
	Fri, 16 Aug 2024 12:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723812651;
	bh=2DMTk7qGgUKI7Tv0hzxQBy5VlW/I6NlUyU61m2aEN58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i+aK3wDgKpiJUy6k+LLuZupYdDTKkPb8wB4O/6KgdsrjeP2OfESSkBP+TqrSGRJ9l
	 s7m7WLq8NjC9pUXVo4V5IOfB4NDz4gDMp1vV79BYgL185VLdaG+knu/347jX2+v1/j
	 jeyJID5fWGek2r0/y6llilUDpaTGqAP8dzx4b62d7Etz6oIe771aXflZJEXg+h74it
	 nXoETBntsIy61Z1d8XHq0JQF+fU1a0/GAXxs6hbdIbCE/YDZB73TwWM4AVdaal9Yzh
	 vS5pxQuxFAqLh0drRlB8yakahT+f76xkahz6lDpIsaJJ4X8RpS+8/4tFgGEbOSydlA
	 s1zKVLcfw8Phw==
Date: Fri, 16 Aug 2024 13:50:46 +0100
From: Will Deacon <will@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	John Stultz <jstultz@google.com>
Subject: Re: [PATCH] Revert "scripts/faddr2line: Check only two symbols when
 calculating symbol size"
Message-ID: <20240816125046.GA24389@willie-the-truck>
References: <20240812230121.2658059-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812230121.2658059-1-cmllamas@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Aug 12, 2024 at 11:01:20PM +0000, Carlos Llamas wrote:
> This reverts commit c02904f05ff805d6c0631634d5751ebd338f75ec.
> 
> Such commit assumed that only two symbols are relevant for the symbol
> size calculation. However, this can lead to an incorrect symbol size
> calculation when there are mapping symbols emitted by readelf.
> 
> For instance, when feeding 'update_irq_load_avg+0x1c/0x1c4', faddr2line
> might need to processes the following readelf lines:
> 
>  784284: ffffffc0081cca30   428 FUNC    GLOBAL DEFAULT     2 update_irq_load_avg
>   87319: ffffffc0081ccb0c     0 NOTYPE  LOCAL  DEFAULT     2 $x.62522
>   87321: ffffffc0081ccbdc     0 NOTYPE  LOCAL  DEFAULT     2 $x.62524
>   87323: ffffffc0081ccbe0     0 NOTYPE  LOCAL  DEFAULT     2 $x.62526
>   87325: ffffffc0081ccbe4     0 NOTYPE  LOCAL  DEFAULT     2 $x.62528
>   87327: ffffffc0081ccbe8     0 NOTYPE  LOCAL  DEFAULT     2 $x.62530
>   87329: ffffffc0081ccbec     0 NOTYPE  LOCAL  DEFAULT     2 $x.62532
>   87331: ffffffc0081ccbf0     0 NOTYPE  LOCAL  DEFAULT     2 $x.62534
>   87332: ffffffc0081ccbf4     0 NOTYPE  LOCAL  DEFAULT     2 $x.62535
>  783403: ffffffc0081ccbf4   424 FUNC    GLOBAL DEFAULT     2 sched_pelt_multiplier
> 
> The symbol size of 'update_irq_load_avg' should be calculated with the
> address of 'sched_pelt_multiplier', after skipping the mapping symbols
> seen in between. However, the offending commit cuts the list short and
> faddr2line incorrectly assumes 'update_irq_load_avg' is the last symbol
> in the section, resulting in:
> 
>   $ scripts/faddr2line vmlinux update_irq_load_avg+0x1c/0x1c4
>   skipping update_irq_load_avg address at 0xffffffc0081cca4c due to size mismatch (0x1c4 != 0x3ff9a59988)
>   no match for update_irq_load_avg+0x1c/0x1c4
> 
> After reverting the commit the issue is resolved:
> 
>   $ scripts/faddr2line vmlinux update_irq_load_avg+0x1c/0x1c4
>   update_irq_load_avg+0x1c/0x1c4:
>   cpu_of at kernel/sched/sched.h:1109
>   (inlined by) update_irq_load_avg at kernel/sched/pelt.c:481
> 
> Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
> Cc: John Stultz <jstultz@google.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  scripts/faddr2line | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Will Deacon <will@kernel.org>

I'm assuming that Josh will pick this up.

Cheers,

Will

