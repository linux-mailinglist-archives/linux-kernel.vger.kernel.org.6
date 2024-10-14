Return-Path: <linux-kernel+bounces-364433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5934D99D49A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60259B2700B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6FA1B85D2;
	Mon, 14 Oct 2024 16:25:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDCF1B4F04
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923153; cv=none; b=bzMFffKogCy/RfHoUnb8x0CyQVu0rIeoLD2hymifWr0ewYUmqYklJASdTbXMscIZLV1Ix+6mfvZkqcwxulQxWES7EIxA2JNhMtxiCzJFBNCD5cMGPTj6SgDKb4nqDkOQYYPCbprg7sfIz3f+Iy3J6RsV9KRF84RjW4mA6yBwxdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923153; c=relaxed/simple;
	bh=VE9iTW10eGidapN0EMFnqrTCy6e3wZyUyWOGxeRsxY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pz6U2CcFPTct1nKO9+1iXJpybe/ojnqzDndjeWrLoP+VWMbghb/FFjJ+OzLiDAjsDvwsQ7btvWaMF43l2A4eY+YyKhzQiv8kNRgZeATSJrTDoyrGBlz2pMd4ZKVaiRuPe7iO1dLRveb6rGpe9AZ7U7vfBoaWOgl6/dPX0tIz9Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F51E1007;
	Mon, 14 Oct 2024 09:26:19 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89B493F71E;
	Mon, 14 Oct 2024 09:25:48 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:25:45 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ryabinin.a.a@gmail.com, glider@google.com,
	kasan-dev@googlegroups.com, Andrey Konovalov <andreyknvl@gmail.com>,
	syzbot+908886656a02769af987@syzkaller.appspotmail.com
Subject: Re: [PATCH] kasan: Disable Software Tag-Based KASAN with GCC
Message-ID: <Zw1GCeNTnbbHE_Bb@J2N7QTR9R3>
References: <20241014161100.18034-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014161100.18034-1-will@kernel.org>

On Mon, Oct 14, 2024 at 05:11:00PM +0100, Will Deacon wrote:
> Syzbot reports a KASAN failure early during boot on arm64 when building
> with GCC 12.2.0 and using the Software Tag-Based KASAN mode:
> 
>   | BUG: KASAN: invalid-access in smp_build_mpidr_hash arch/arm64/kernel/setup.c:133 [inline]
>   | BUG: KASAN: invalid-access in setup_arch+0x984/0xd60 arch/arm64/kernel/setup.c:356
>   | Write of size 4 at addr 03ff800086867e00 by task swapper/0
>   | Pointer tag: [03], memory tag: [fe]
> 
> Initial triage indicates that the report is a false positive and a
> thorough investigation of the crash by Mark Rutland revealed the root
> cause to be a bug in GCC:
> 
>   > When GCC is passed `-fsanitize=hwaddress` or
>   > `-fsanitize=kernel-hwaddress` it ignores
>   > `__attribute__((no_sanitize_address))`, and instruments functions
>   > we require are not instrumented.
>   >
>   > [...]
>   >
>   > All versions [of GCC] I tried were broken, from 11.3.0 to 14.2.0
>   > inclusive.
>   >
>   > I think we have to disable KASAN_SW_TAGS with GCC until this is
>   > fixed
> 
> Disable Software Tag-Based KASAN when building with GCC by making
> CC_HAS_KASAN_SW_TAGS depend on !CC_IS_GCC.
> 
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/000000000000f362e80620e27859@google.com
> Link: https://lore.kernel.org/r/ZvFGwKfoC4yVjN_X@J2N7QTR9R3
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218854
> Signed-off-by: Will Deacon <will@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks for putting a patch together!

Mark.

> ---
>  lib/Kconfig.kasan | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> While sweeping up pending fixes and open bug reports, I noticed this one
> had slipped through the cracks...
> 
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 98016e137b7f..233ab2096924 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -22,8 +22,11 @@ config ARCH_DISABLE_KASAN_INLINE
>  config CC_HAS_KASAN_GENERIC
>  	def_bool $(cc-option, -fsanitize=kernel-address)
>  
> +# GCC appears to ignore no_sanitize_address when -fsanitize=kernel-hwaddress
> +# is passed. See https://bugzilla.kernel.org/show_bug.cgi?id=218854 (and
> +# the linked LKML thread) for more details.
>  config CC_HAS_KASAN_SW_TAGS
> -	def_bool $(cc-option, -fsanitize=kernel-hwaddress)
> +	def_bool !CC_IS_GCC && $(cc-option, -fsanitize=kernel-hwaddress)
>  
>  # This option is only required for software KASAN modes.
>  # Old GCC versions do not have proper support for no_sanitize_address.
> @@ -98,7 +101,7 @@ config KASAN_SW_TAGS
>  	help
>  	  Enables Software Tag-Based KASAN.
>  
> -	  Requires GCC 11+ or Clang.
> +	  Requires Clang.
>  
>  	  Supported only on arm64 CPUs and relies on Top Byte Ignore.
>  
> -- 
> 2.47.0.rc1.288.g06298d1525-goog
> 

