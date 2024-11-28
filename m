Return-Path: <linux-kernel+bounces-424078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61799DB069
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81EE1B215B1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B137BEEDD;
	Thu, 28 Nov 2024 00:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLUCNKXA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8A6DDAB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732755208; cv=none; b=gL/fUWYumM9/BbJk0RbzT1XDcpWbjgeGpoFxWQTz2ciWSnXlNM8DYzAQmId42qxDDNvnulX87z2TsEDieKRt20k7Xhb9UMF84IzA7mB8+8zs/+EcJpZl2raPYVlDyfP02Ur1iZGMag0kUyWK/HePBy6v/eDiinkEfgR5YKRgTQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732755208; c=relaxed/simple;
	bh=AJBQHBhXRk7DOvdIivUV3Vdc1xCL1nhDtumcQlVshbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2nIrY4Q4ethTxIuMwbq3avkzwSLDmtInmS0EDx+3T4GvgPvmmp6IcnLSpKWjBn4WxuaFvDrU/k9p4Bgbw2fZXThJ+dJTQCF4CBviaiOXZeOGqAErCbmvHSnEeA2x94NU3ZeIOeCeSlANIt/u0TPwxibpO0q7ty2aHj/OS8un5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLUCNKXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD70C4CECC;
	Thu, 28 Nov 2024 00:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732755207;
	bh=AJBQHBhXRk7DOvdIivUV3Vdc1xCL1nhDtumcQlVshbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gLUCNKXASBRkFGqCphhvqefG+udA2KQkb0f/sH1BnuBl6FCa56bD7s/wCRSUccEfv
	 mvxeh5DYH+OvSOAF5b0yHi3ZVKGT7aX/P4oX3SYsGv0UAA0ZlyGaOPcrx8NbpjhrDk
	 FxsepcQqEf2x09XZoMURNLjFCsMAtgDXktEMFw1bv78NRhyKAXw6DcqBIIe5mwQlpf
	 vZemt+KyTuhmH80BIEohsgiwvFKnNHfzkLruK+mLV3IvF841wBguilviWvaZ2zW22K
	 1Q9spZuAjJkoSq3AVq8UfP1uInGmVHEfCuFZ9VRHHS2z8qUkJIrNwEmFSy8aHUENJ+
	 ZxtC55AX8Dsaw==
Date: Wed, 27 Nov 2024 16:53:23 -0800
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Nir Lichtman <nir@lichtman.org>,
	Tycho Andersen <tandersen@netflix.com>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1 (take 2)
Message-ID: <202411271645.04C3508@keescook>
References: <202411210651.CD8B5A3B98@keescook>
 <CAHk-=wjMagH_5-_8KhAOJ+YSjXUR5FELYxFgqtWBHOhKyUzGxA@mail.gmail.com>
 <05F133C4-DB2D-4186-9243-E9E18FCBF745@kernel.org>
 <CAHk-=wgEjs8bwSMSpoyFRiUT=_NEFzF8BXFEvYzVQCu8RD=WmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgEjs8bwSMSpoyFRiUT=_NEFzF8BXFEvYzVQCu8RD=WmA@mail.gmail.com>

On Tue, Nov 26, 2024 at 12:11:06PM -0800, Linus Torvalds wrote:
> And it looks like __set_task_comm() is actually buggy right now,
> because while we have a comment in linux/sched.h that says
> 
>  *   The strscpy_pad() in __set_task_comm() can ensure that the task comm is
>  *   always NUL-terminated and zero-padded.
> 
> that isn't actually true, because it looks like sized_strscpy()
> actually adds the final NUL at the end. I think that's because Andrew
> only merged a partial patch series.

Oh ew, yes, it looks like it copies the last byte, checks if it was NUL,
and then NULs it if it ran out of space. Ugh.

Before for comm we used strlen + memcpy, and so the trailing NUL was
always present. Grumble grumble. I'll look at your patch and will dig
around and see what works best. I'm on vacation currently, so there will
be some latency...

On a related note, what do you think of using execveat's "pathname"
argument as "comm" if AT_EMPTY_PATH is set? That'll give process
launchers control over comm (which is what they want), and we can keep
the dentry name fallback as proposed too?

-Kees

-- 
Kees Cook

