Return-Path: <linux-kernel+bounces-328984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9633C978BB9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 01:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467BE1F26238
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A0A17C9B2;
	Fri, 13 Sep 2024 23:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHw8P9Wk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82D0126F02
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 23:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726269074; cv=none; b=e0s1gWHdN3uTiJg+7xo859b823GBc24AKUy96+zbaycEx0WgTGilDvfVOt/xeVM65P39UEvgbCv+5jy8+fXXqFs8aU+OyzINT9V7u4Ymw6hn9YS+CTJ5yEAL7tBXHQ34jBVeBcbacmjggDkqO196VQSF0vPThDI3BIuTWLRVh6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726269074; c=relaxed/simple;
	bh=3QxjOH1AZgktwHabVfjOSEItCq8kTJ/bVSbUBT+bR1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCwv6UywerYw1wSMiqHUbaxTiOaiUUipn24foxZUyaUdlHMYXkZ600EaK+jr+mbomt+9avk0Mk7QikO28taHsNBMHXlxf7K16pssy0Ss6AmcLEYMDGJo1wi+bdZNVzSb0JrY9VV+15o/ZaBjMkVzxui70ohKEka6QU0iCr83bpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHw8P9Wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5598C4CEC0;
	Fri, 13 Sep 2024 23:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726269074;
	bh=3QxjOH1AZgktwHabVfjOSEItCq8kTJ/bVSbUBT+bR1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHw8P9Wkjsmw/I+dcznASd/+Z9B5uQ7UFIHzPBvizHJoVvcBBev5g1eZhvjIAjWEw
	 VYeITJxj3dU0ipv90yIVXqbv40Dp8K3LQiQtTcfKE+GB4rRW7BYfNlQE7w/Y80rvWU
	 zH/fUaQWSVH5XhXCTtBtNUprL6utlkNdcs5E/1Eejt+4x1k2jMqyPLSum2QKPL/Z0+
	 vd2qoGx6Cb8DQw5t5c5pGmNqyo4WR+LT782DS+ERD9OV2nnaRb+UwUG6c4A7HUo1+P
	 asgOdWIKvSc5UgAFk/MawQvMT3GfF6qmk0+8BWzjcc/TISol0gsPP2sHUCXB0zW42T
	 g7KF6y6QqfakA==
Date: Fri, 13 Sep 2024 16:11:08 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Zheng Yejian <zhengyejian@huaweicloud.com>
Cc: peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	brgerst@gmail.com, samitolvanen@google.com, kees@kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/unwind/orc: Fix unwind for newly forked tasks
Message-ID: <20240913231108.a3ukhoyhp2xactdq@treble>
References: <20240913024501.1337327-1-zhengyejian@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913024501.1337327-1-zhengyejian@huaweicloud.com>

On Fri, Sep 13, 2024 at 10:45:01AM +0800, Zheng Yejian wrote:
> When arch_stack_walk_reliable() is called to unwind for newly forked
> tasks, the return value is negative which means the call stack is
> unreliable. This obviously does not meet expectations.
> 
> The root cause is that after commit 3aec4ecb3d1f ("x86: Rewrite
>  ret_from_fork() in C"), the 'ret_addr' of newly forked task is changed
> to 'ret_from_fork_asm' (see copy_thread()), then at the start of the
> unwind, it is incorrectly interprets not as a "signal" one because
> 'ret_from_fork' is still used to determine the initial "signal" (see
> __unwind_start()). Then the address gets incorrectly decremented in the
> call to orc_find() (see unwind_next_frame()) and resulting in the
> incorrect ORC data.
> 
> To fix it, check 'ret_from_fork_asm' rather than 'ret_from_fork' in
> __unwind_start().
> 
> Fixes: 3aec4ecb3d1f ("x86: Rewrite ret_from_fork() in C")
> Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>

Thanks!

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

