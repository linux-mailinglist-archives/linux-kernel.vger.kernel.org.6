Return-Path: <linux-kernel+bounces-202617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 340418FCEB0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DA1287D31
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22C419922B;
	Wed,  5 Jun 2024 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjHeks8r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2274B199226;
	Wed,  5 Jun 2024 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717590883; cv=none; b=iYFW6mEo3AC0wcljevNWuJdttZVibWbyaLJx+vPTqCrlkdsuLlBbiky1k1VyeyemNwBsiHP46aWYbPOnOZxfR/YRsbWCFxUXemjsY3eJ45rngn+L99PEIHoHeXMi8iLBQPCfUx/lsRO1eKPIKdqZPxu06wgjM5Vl3n6SKstMJ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717590883; c=relaxed/simple;
	bh=pNDoDNrZ3B1jVzbxPDtsTQTkg5Yf7y5alzwsLd7nATY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XI/E+/+94QdzfVeam34nJU73WvFmgO0q2Qo3X5tMFOQa/A4jLTgQRBXTRw0tZ/uGtuW72pfurmi4bsAy/CTKjjHuWvJuixeFAVB91VDSynk4fvgtoC4t9olqSAyiXxYKtoHAYv3nZMB4407WjDAUHrq6YrQvQzIWd5msV1N4/fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjHeks8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A994FC3277B;
	Wed,  5 Jun 2024 12:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717590882;
	bh=pNDoDNrZ3B1jVzbxPDtsTQTkg5Yf7y5alzwsLd7nATY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VjHeks8rM0Vyb1HBC3lHJS7ZDLtV9+7yyNju/hRuQoRjaNfgMnSeEWcKm0moeHdkv
	 gVE9ViubqElB+28i+G/Fwh3L1fYZBpYJjXCmbkWX7V0ibSY0q8dBlXkqLwm0a0S2cf
	 XVJtrQVtzYhXt+2jTu4V9exwQzPLSAbFy30bfFOQ2gNb6Izun9or3RcxcAys+KEyuO
	 Ueg1or2myKmucEc80obTYj1WY+EHhylIPU8UcmyL0TI244VlpfwDM+Z+HVGDKC8K0V
	 tf9q+2NLKh3OAWWUKYEoPgytoR8A6b/gr7lhAFgh23P+xQ9dDDXWxr4QfKFKEolBec
	 tEyEsmCOyLBzQ==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arnd Bergmann <arnd@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] [v3] arm64/io: add constant-argument check
Date: Wed,  5 Jun 2024 13:34:32 +0100
Message-Id: <171758272445.3626757.4886694115081361174.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240604210006.668912-1-arnd@kernel.org>
References: <20240604210006.668912-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 04 Jun 2024 22:59:57 +0200, Arnd Bergmann wrote:
> In some configurations __const_iowrite32_copy() does not get inlined
> and gcc runs into the BUILD_BUG():
> 
> In file included from <command-line>:
> In function '__const_memcpy_toio_aligned32',
>     inlined from '__const_iowrite32_copy' at arch/arm64/include/asm/io.h:203:3,
>     inlined from '__const_iowrite32_copy' at arch/arm64/include/asm/io.h:199:20:
> include/linux/compiler_types.h:487:45: error: call to '__compiletime_assert_538' declared with attribute error: BUILD_BUG failed
>   487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |                                             ^
> include/linux/compiler_types.h:468:25: note: in definition of macro '__compiletime_assert'
>   468 |                         prefix ## suffix();                             \
>       |                         ^~~~~~
> include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
>   487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>       |                     ^~~~~~~~~~~~~~~~
> arch/arm64/include/asm/io.h:193:17: note: in expansion of macro 'BUILD_BUG'
>   193 |                 BUILD_BUG();
>       |                 ^~~~~~~~~
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/io: add constant-argument check
      https://git.kernel.org/arm64/c/5c40e428aea6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

