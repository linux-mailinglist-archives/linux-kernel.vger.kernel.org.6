Return-Path: <linux-kernel+bounces-522102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E74CA3C5F4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFC316B8EC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A28D20FA85;
	Wed, 19 Feb 2025 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXI18d0F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D0C8F58
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985578; cv=none; b=I1hqp8+9V4V8x0t+lzACpmtJjIH9ySUPMlDOKVW8GS806HjizTua+2+cBvE3zcsOM4mML7nR2+uL8r2/6kn+SFYGmLoctElmNoEefGdbUjUv0b7nS/F4087sTWymJsipE2GJSqetgFe6l3DX32oKD/k/Bh1xdq2zVGxpU8PSHLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985578; c=relaxed/simple;
	bh=jRaaaPzgZngfk9sFey0Anhz6QM5JDJJWTP/YbpTvGWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfe6W4uaVubAZ4Qnn6nMYvcxro734RP3e8M8AhEA1aswMx/qPHyNrrusi9tOVvooy3MPGZ9WQRsUDsqoxwFWjbx7C3IygbIBsBCDM4M6nYZ6JBjw16v06rl/lDkx3xP5CGZDCsc5QZs9RueQfmeCrCUo0iitDul3qDs/nzTJph4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXI18d0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45555C4CED1;
	Wed, 19 Feb 2025 17:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739985578;
	bh=jRaaaPzgZngfk9sFey0Anhz6QM5JDJJWTP/YbpTvGWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXI18d0Fx16fHHcafXC2fk4JSnbA+/iz1jk8ot0FOsaI5CmPkJIIKqEjJg7FXAv+r
	 dsZivjl6gD4vJ9zn7sq2c2gRuGkhAujdr9SQqQr+eNXs0oVo4EbsytfhRlMkqy61hK
	 wgN5h+sif/UxhhhBKWfJgkiSP9pr/uMjUHiCkfBdYXB2r+YuMrHG/rq3i/kcZXaHjC
	 BVWMxZxJciTnpQ2W0bqOlPnf6UYkmBiMZi94zqPV38uXBv5McKvsEFdDBm8VojRIyA
	 hqjey8kPiRzXvh+mmFJuZHq5M2TahIsEq/W4renhohYXDWImt5y/24EyWpVlMPFc23
	 dbJxrWWCIxz5A==
Date: Wed, 19 Feb 2025 09:19:34 -0800
From: Kees Cook <kees@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
	peterz@infradead.org, gregory.price@memverge.com,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests: Fix errno checking in
 syscall_user_dispatch test
Message-ID: <202502190917.5A3251484@keescook>
References: <cover.1739894594.git.dvyukov@google.com>
 <d83f45b96a9c8d3c1a20a4ff518cf4c13bcacbe4.1739894594.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d83f45b96a9c8d3c1a20a4ff518cf4c13bcacbe4.1739894594.git.dvyukov@google.com>

On Tue, Feb 18, 2025 at 05:04:35PM +0100, Dmitry Vyukov wrote:
> Successful syscalls don't change errno, so checking errno is wrong
> to ensure that a syscall has failed. For example for the following
> sequence:
> 
> 	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0xff, 0);
> 	EXPECT_EQ(EINVAL, errno);
> 	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, &sel);
> 	EXPECT_EQ(EINVAL, errno);
> 
> only the first syscall may fail and set errno, but the second may succeed
> and keep errno intact, and the check will falsely pass.
> Or if errno happened to be EINVAL before, even the first check may falsely
> pass.
> 
> Also use EXPECT/ASSERT consistently. Currently there is an inconsistent mix
> without obvious reasons for usage of one or another.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>

Reviewed-by: Kees Cook <kees@kernel.org>

Yeah, these all look good to me.

-- 
Kees Cook

