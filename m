Return-Path: <linux-kernel+bounces-424133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D199DB0EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407AE166A4F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C889D19AD8B;
	Thu, 28 Nov 2024 01:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnluSisq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3209C19ABB6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757710; cv=none; b=jWd5OH7FeiP7i49Sdf68EhU2+s52T7EobpUVWuxMZXHoq1tKGcOUIub3e8J/qIQhjKUsZ4ijblb8cuTK5iXRXcstzXskSnbleUA7CH+sWlpCQ3zyIqg08C6Silsgq4zz5Hzj/2M5PuufD/2IA0E6VVuwN9tTBWMTvYXgB5pg+fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757710; c=relaxed/simple;
	bh=o/u0qx0BQAUn2N4usF/gKAkEE5x2De1zCCN/M4LTn/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTR9VeRUx8znC9yFZueHCDvCtGXYlXCSzETNQnamrGBMupEOqM/EAZV2h5nmgiBkNavZEAnAqxByHDJlOCCLCUfrPmD0IIqEnEE+PUHL3p+d+dNVH/9ZwC1tXhc8bLxgi8l2MvXv8awE6b18OuHgRhavCFi8kxjpLL/XmTsby0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnluSisq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9B7C4CED2;
	Thu, 28 Nov 2024 01:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732757709;
	bh=o/u0qx0BQAUn2N4usF/gKAkEE5x2De1zCCN/M4LTn/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DnluSisqnyTwRZaYd0d8+u97lE+0JguWZIz500B3eHaDxeQ5OdWea6Hz7TstbDays
	 ByNHXciia2ExfnPuODMyqKCjXWa6v3nqGutqcQiKHerO39S8UfQpzCnD98ZzD6U1Bf
	 Ne/C4c88QIJtE8BGeb7+Cjcak70iIF4qxmc3neCCBzInInyqHGRQsei6wP6HOFxwlq
	 T5BFz114HhyrNf7h2GKKd+5jNJ6/HpFBhCv6Gvg/jqPqQB0jITS2mLRPoLgeP0IA9w
	 vtW/JFNdK8Jr2jvHfooTsTeDMkPzqOR27FrQifo5+v5MFT1Jg3SIYQaktiGGk01Ru8
	 moQ8MWMxaIsGw==
Date: Wed, 27 Nov 2024 17:35:07 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/3] objtool: noinstr validation for static
 branches/calls
Message-ID: <20241128013507.6um4vkfz2ojqwnoz@jpoimboe>
References: <cover.1732682344.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1732682344.git.jpoimboe@kernel.org>

On Tue, Nov 26, 2024 at 08:47:39PM -0800, Josh Poimboeuf wrote:
> v2:
> - Add some fixes reported by kbuild.
> 
> 
> FWIW, this reports the following static keys:
> 
>   - sched_clock_running
>   - __sched_clock_stable
>   - mds_idle_clear
>   - vmx_l1d_flush_cond
>   - stack_erasing_bypass

    - perf_lopwr_cb

> and the following static calls:
> 
>   - pv_sched_clock
>   - x86_idle

-- 
Josh

