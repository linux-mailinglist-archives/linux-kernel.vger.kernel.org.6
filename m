Return-Path: <linux-kernel+bounces-511145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DBFA32690
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C86616648E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5415D20E314;
	Wed, 12 Feb 2025 13:07:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F39020E034
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365651; cv=none; b=ZyEl0qnMwnoL6jHXmwgXCiUuHjdWWXDZfRNtxoIGg75gsC+A+JNY7SaZrJkG6L6Nf0ARxwHukJ/sKDmq/E6xX50dXNHOseprPrLpBXgPs6OiTR/FrSc9KhsI552s9ykiwwaJa6ClSvE5WJWRYeRoG9+79mQHofWOuLYNXrq9UUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365651; c=relaxed/simple;
	bh=Nc6kHxgd5rT4q/4TTWwdYzQ4G7JkQxYNNC4yPWLfsIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDxSm4gtGvozX2Hj0UmrZkyVBH2z9blkJGKZqurqUXqqHkLgGU/a8oot51xmj/XXCnh7WPOGAT6Eo6My12ufznEldqN5s266ehujFietjNpMjD7l6OXQmVqFOKrC8Ci4uFXO+soXin0hDm1vUvUx2F/BvAzLz/liWrA5eEENpc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A18212FC;
	Wed, 12 Feb 2025 05:07:50 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDEE83F58B;
	Wed, 12 Feb 2025 05:07:26 -0800 (PST)
Date: Wed, 12 Feb 2025 13:07:24 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: debug_exception_enter() disables preemption and may call
 sleeping functions on aarch64 with RT
Message-ID: <Z6ydDD5uMMgLi2RO@J2N7QTR9R3>
References: <Z6YW_Kx4S2tmj2BP@uudg.org>
 <Z6n16cK85JMyowDq@J2N7QTR9R3>
 <Z6tf8iDhNriSGjeC@uudg.org>
 <Z6vs3IWxUxhIDBBO@uudg.org>
 <Z6yWwRcPvVGk2EyC@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6yWwRcPvVGk2EyC@J2N7QTR9R3>

On Wed, Feb 12, 2025 at 12:40:33PM +0000, Mark Rutland wrote:

> * In entry-common.c, add new el{1,0}_step() functions. Each of
>   el1h_64_sync_handler(), el0t_64_sync_handler(), and
>   el0t_32_sync_handler() should be updated to call those rather than
>   el{1,0}_dbg() for the corresponding EC values.
> 
>   In el0_step() it shouldn't be necessary to disable preemption, and
>   that should be able to be:
> 
>   | static void noinstr el0_step(struct pt_regs *regs, unsigned long esr)
>   | {
>   |         enter_from_user_mode(regs);
>   |         local_daif_restore(DAIF_PROCCTX);
>   |         do_el0_step(regs, esr);
>   |         exit_to_user_mode(regs);
>   | }
> 
>   In el1_step(), I'm not *immediately sure* whether it's necessary to
>   disable preemption, nor whether we need to treat this and use
>   arm64_enter_el1_dbg() and arm64_exit_el1_dbg() rather than
>   entry_from_kenrel_mode() and exit_to_kernel_mode().

From another look, some care will need to be taken around
reinstall_suspended_bps(), which will also need to be reworked. That
definitely needs preemption disabled when poking the HW breakpoints, and
today those can't change under our feet between entry and handling, so
we'll need to think very hard about how that needs to work.

Note that care needs to be taken with *any* approach that doesn't
disable preemption.

Mark.

