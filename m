Return-Path: <linux-kernel+bounces-314221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CFE96B02C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 06:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 510EDB21243
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA1C823AF;
	Wed,  4 Sep 2024 04:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMWDferd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6365635;
	Wed,  4 Sep 2024 04:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725425524; cv=none; b=a6hCEuCLEhMUxongSq4EcA0MUbIYI/sLFXaEEBskvC0hoHFzUBSbRpZliM423o2gK2fYIdKj0HALARsff23wrd6iuEw/foUNCbngQyJitd5PGyFttJAmmh0uLX9z7zs1fZ5ZFFBllh7dA64NeLrH4DV8+3vDhUimUPfiN4BDKSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725425524; c=relaxed/simple;
	bh=T5layT+NLsjmVL8XZR8JWrqV++qdP3sdX2dEWb7Fyas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGuMRC5wsMB8u3HslT7Vmt7mMtgscaJiQDj8pquHhmCyJMFZRKnvkvBsBHvzuf6uxv+tkfPYlH7bb+0hrlI5IcYhk8En4koGNuPVlHC+3IASFGunGMIH+/9Do0Q9xFkSCs5NAChGFXRkxfAMb7mMT9f5ymXpJAx6jbAnrD7smSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMWDferd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05625C4CEC2;
	Wed,  4 Sep 2024 04:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725425523;
	bh=T5layT+NLsjmVL8XZR8JWrqV++qdP3sdX2dEWb7Fyas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iMWDferdl5jXJkd+Rw4yERqb5w43SHdubt4tWIU/3p5NAFAE9fkP+AjyeJuri/mRT
	 llfZ41uD4eP8+xpNzOJgP7+kC9klygKt+EGCt9nN4+moqORzDEOp9XC1qidrlP9NUP
	 0PIcczt0opaDo1VB6RwxPN7jtKV7ylygku5/lCm94Lf2BzupSsodxbVd8DDOlRpTW8
	 Emont3SF/MasuH8sgDpcxt3i6xg7ttNW1Zd4LQKpslSynkf1/a4M66MxpQRduLQJ6X
	 HJa0H94MB+cwM7AAgKdj8SgMEGchlDQJvbooAdBwiwMCHFipD3ERbU8UcVi5juaJby
	 SEZ3c7KAezkfg==
Date: Tue, 3 Sep 2024 21:52:01 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Gergo Koteles <soyer@irl.hu>, Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ike Panhc <ike.pan@canonical.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] platform/x86: ideapad-laptop: Make the
 scope_guard() clear of its scope
Message-ID: <20240904045201.v3mp4u7pcqj7qrdp@treble>
References: <20240829165105.1609180-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829165105.1609180-1-andriy.shevchenko@linux.intel.com>

On Thu, Aug 29, 2024 at 07:50:32PM +0300, Andy Shevchenko wrote:
> First of all, it's a bit counterintuitive to have something like
> 
> 	int err;
> 	...
> 	scoped_guard(...)
> 		err = foo(...);
> 	if (err)
> 		return err;
> 
> Second, with a particular kernel configuration and compiler version in
> one of such cases the objtool is not happy:
> 
>   ideapad-laptop.o: warning: objtool: .text.fan_mode_show: unexpected end of section
>
> I'm not an expert on all this, but the theory is that compiler and
> linker in this case can't understand that 'result' variable will be
> always initialized as long as no error has been returned. Assigning
> 'result' to a dummy value helps with this. Note, that fixing the
> scoped_guard() scope (as per above) does not make issue gone.

I'm not sure I buy that, we should look closer to understand what the
issue is.  Can you share the config and/or toolchain version(s) need to
trigger the warning?

-- 
Josh

