Return-Path: <linux-kernel+bounces-273228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE00E946611
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 01:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CCE1F22CDE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F112913A404;
	Fri,  2 Aug 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSqLimTO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B55258;
	Fri,  2 Aug 2024 23:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722640038; cv=none; b=Q9oQrcbB8evpkJNf506eMfgK0A6M16CxxeJ56W8h2c8rM5Vwwi0aqu2XCkZjmkpqCj3clxdy+Uzxv484IcudIox7UHRNYvBz3AtInKEwEMxbMswEjt8tVTly4qAKpgeu8g2T83kr+4TO8mfQMfXvWdYFeYPacWdu1sCHLXh9zHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722640038; c=relaxed/simple;
	bh=bc/jPOXqEBJsFaUc3DCiNN63Sw3ffR3ayB1AQ2jpfKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4c0sFBDuPFyD3Ki+dG+2b7wm/9K8qAzScMGkl4RwmciUtwBHaR2ElOGZb6eQLik5yCRWASdyU40ZQCa0DIWeF1AdxnS4RDvF93U6w7RCbw/W9OTjMeVTikJuSh7pFdOiwRN4MKUYcBPcfl8ew2psoeJd3XFpwnsXjUMeeom7Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSqLimTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AC1C32782;
	Fri,  2 Aug 2024 23:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722640037;
	bh=bc/jPOXqEBJsFaUc3DCiNN63Sw3ffR3ayB1AQ2jpfKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qSqLimTOQVOmSqPtBkKip4BolRiy+JPqr8fLxl9s9O0SZG/Xf+KTfjpCw18Mu5kQY
	 Ue+Ac5IZ2oVamtmjWlrUidZ0njVDxpeg7GSVaTgEeVBUB+Kq2m9m6h94o8tBqOwp8S
	 CsrkR1IF0nPSiSk2VytDJY1fVoB/3LOdF/WAw5i2xyFTTJyosVFYPq+tV5i5KFFO8x
	 S6KDH1f94qJSjv7nnkTb5Tz8APZwpV90dyMotcQ8Yq1RYV8A2FKLpjirOxMiHJmrNo
	 sTtfyuiMmyXj/b3ABz/Pb8H+Rm3WRPbltb4TfoQ1VEVnqmCVHx/PF9Ub0e1avLpSvm
	 QAtLVCZwX0mLg==
Date: Fri, 2 Aug 2024 16:07:15 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>, llvm@lists.linux.dev,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 1/4] find: Switch from inline to __always_inline
Message-ID: <20240802230715.GA959572@thelio-3990X>
References: <20240719005127.2449328-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719005127.2449328-1-briannorris@chromium.org>

Hi Brian,

On Thu, Jul 18, 2024 at 05:50:37PM -0700, Brian Norris wrote:
> From: Yury Norov <yury.norov@gmail.com>
> 
> 'inline' keyword is only a recommendation for compiler. If it decides to
> not inline find_bit nodemask functions, the whole small_const_nbits()
> machinery doesn't work.
> 
> This is how a standard GCC 11.3.0 does for my x86_64 build now. This patch
> replaces 'inline' directive with unconditional '__always_inline' to make
> sure that there's always a chance for compile-time optimization. It doesn't
> change size of kernel image, according to bloat-o-meter.
> 
> [[ Brian: split out from:
>       Subject: [PATCH 1/3] bitmap: switch from inline to __always_inline
>       https://lore.kernel.org/all/20221027043810.350460-2-yury.norov@gmail.com/
>    But rewritten, as there were too many conflicts. ]]
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Co-developed-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Kees Cook <kees@kernel.org>

Sorry for taking some time to review this. Overall, this seems
reasonable, especially given the numbers that you provided in the third
patch. I would expect the compiler to be able to optimize better at some
callsites with this.

For the series:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
> Changes in v3:
>  - newly split out in v3
> 
>  include/linux/find.h | 50 ++++++++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/find.h b/include/linux/find.h
> index 5dfca4225fef..68685714bc18 100644
> --- a/include/linux/find.h
> +++ b/include/linux/find.h
> @@ -52,7 +52,7 @@ unsigned long _find_next_bit_le(const unsigned long *addr, unsigned
>   * Returns the bit number for the next set bit
>   * If no bits are set, returns @size.
>   */
> -static inline
> +static __always_inline
>  unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
>  			    unsigned long offset)
>  {
> @@ -81,7 +81,7 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
>   * Returns the bit number for the next set bit
>   * If no bits are set, returns @size.
>   */
> -static inline
> +static __always_inline
>  unsigned long find_next_and_bit(const unsigned long *addr1,
>  		const unsigned long *addr2, unsigned long size,
>  		unsigned long offset)
> @@ -112,7 +112,7 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
>   * Returns the bit number for the next set bit
>   * If no bits are set, returns @size.
>   */
> -static inline
> +static __always_inline
>  unsigned long find_next_andnot_bit(const unsigned long *addr1,
>  		const unsigned long *addr2, unsigned long size,
>  		unsigned long offset)
> @@ -142,7 +142,7 @@ unsigned long find_next_andnot_bit(const unsigned long *addr1,
>   * Returns the bit number for the next set bit
>   * If no bits are set, returns @size.
>   */
> -static inline
> +static __always_inline
>  unsigned long find_next_or_bit(const unsigned long *addr1,
>  		const unsigned long *addr2, unsigned long size,
>  		unsigned long offset)
> @@ -171,7 +171,7 @@ unsigned long find_next_or_bit(const unsigned long *addr1,
>   * Returns the bit number of the next zero bit
>   * If no bits are zero, returns @size.
>   */
> -static inline
> +static __always_inline
>  unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
>  				 unsigned long offset)
>  {
> @@ -198,7 +198,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
>   * Returns the bit number of the first set bit.
>   * If no bits are set, returns @size.
>   */
> -static inline
> +static __always_inline
>  unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
>  {
>  	if (small_const_nbits(size)) {
> @@ -224,7 +224,7 @@ unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
>   * Returns the bit number of the N'th set bit.
>   * If no such, returns >= @size.
>   */
> -static inline
> +static __always_inline
>  unsigned long find_nth_bit(const unsigned long *addr, unsigned long size, unsigned long n)
>  {
>  	if (n >= size)
> @@ -249,7 +249,7 @@ unsigned long find_nth_bit(const unsigned long *addr, unsigned long size, unsign
>   * Returns the bit number of the N'th set bit.
>   * If no such, returns @size.
>   */
> -static inline
> +static __always_inline
>  unsigned long find_nth_and_bit(const unsigned long *addr1, const unsigned long *addr2,
>  				unsigned long size, unsigned long n)
>  {
> @@ -276,7 +276,7 @@ unsigned long find_nth_and_bit(const unsigned long *addr1, const unsigned long *
>   * Returns the bit number of the N'th set bit.
>   * If no such, returns @size.
>   */
> -static inline
> +static __always_inline
>  unsigned long find_nth_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
>  				unsigned long size, unsigned long n)
>  {
> @@ -332,7 +332,7 @@ unsigned long find_nth_and_andnot_bit(const unsigned long *addr1,
>   * Returns the bit number for the next set bit
>   * If no bits are set, returns @size.
>   */
> -static inline
> +static __always_inline
>  unsigned long find_first_and_bit(const unsigned long *addr1,
>  				 const unsigned long *addr2,
>  				 unsigned long size)
> @@ -357,7 +357,7 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
>   * Returns the bit number for the first set bit
>   * If no bits are set, returns @size.
>   */
> -static inline
> +static __always_inline
>  unsigned long find_first_and_and_bit(const unsigned long *addr1,
>  				     const unsigned long *addr2,
>  				     const unsigned long *addr3,
> @@ -381,7 +381,7 @@ unsigned long find_first_and_and_bit(const unsigned long *addr1,
>   * Returns the bit number of the first cleared bit.
>   * If no bits are zero, returns @size.
>   */
> -static inline
> +static __always_inline
>  unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
>  {
>  	if (small_const_nbits(size)) {
> @@ -402,7 +402,7 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
>   *
>   * Returns the bit number of the last set bit, or size.
>   */
> -static inline
> +static __always_inline
>  unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
>  {
>  	if (small_const_nbits(size)) {
> @@ -425,7 +425,7 @@ unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
>   * Returns the bit number for the next set bit, or first set bit up to @offset
>   * If no bits are set, returns @size.
>   */
> -static inline
> +static __always_inline
>  unsigned long find_next_and_bit_wrap(const unsigned long *addr1,
>  					const unsigned long *addr2,
>  					unsigned long size, unsigned long offset)
> @@ -448,7 +448,7 @@ unsigned long find_next_and_bit_wrap(const unsigned long *addr1,
>   * Returns the bit number for the next set bit, or first set bit up to @offset
>   * If no bits are set, returns @size.
>   */
> -static inline
> +static __always_inline
>  unsigned long find_next_bit_wrap(const unsigned long *addr,
>  					unsigned long size, unsigned long offset)
>  {
> @@ -465,7 +465,7 @@ unsigned long find_next_bit_wrap(const unsigned long *addr,
>   * Helper for for_each_set_bit_wrap(). Make sure you're doing right thing
>   * before using it alone.
>   */
> -static inline
> +static __always_inline
>  unsigned long __for_each_wrap(const unsigned long *bitmap, unsigned long size,
>  				 unsigned long start, unsigned long n)
>  {
> @@ -506,20 +506,20 @@ extern unsigned long find_next_clump8(unsigned long *clump,
>  
>  #if defined(__LITTLE_ENDIAN)
>  
> -static inline unsigned long find_next_zero_bit_le(const void *addr,
> -		unsigned long size, unsigned long offset)
> +static __always_inline
> +unsigned long find_next_zero_bit_le(const void *addr, unsigned long size, unsigned long offset)
>  {
>  	return find_next_zero_bit(addr, size, offset);
>  }
>  
> -static inline unsigned long find_next_bit_le(const void *addr,
> -		unsigned long size, unsigned long offset)
> +static __always_inline
> +unsigned long find_next_bit_le(const void *addr, unsigned long size, unsigned long offset)
>  {
>  	return find_next_bit(addr, size, offset);
>  }
>  
> -static inline unsigned long find_first_zero_bit_le(const void *addr,
> -		unsigned long size)
> +static __always_inline
> +unsigned long find_first_zero_bit_le(const void *addr, unsigned long size)
>  {
>  	return find_first_zero_bit(addr, size);
>  }
> @@ -527,7 +527,7 @@ static inline unsigned long find_first_zero_bit_le(const void *addr,
>  #elif defined(__BIG_ENDIAN)
>  
>  #ifndef find_next_zero_bit_le
> -static inline
> +static __always_inline
>  unsigned long find_next_zero_bit_le(const void *addr, unsigned
>  		long size, unsigned long offset)
>  {
> @@ -546,7 +546,7 @@ unsigned long find_next_zero_bit_le(const void *addr, unsigned
>  #endif
>  
>  #ifndef find_first_zero_bit_le
> -static inline
> +static __always_inline
>  unsigned long find_first_zero_bit_le(const void *addr, unsigned long size)
>  {
>  	if (small_const_nbits(size)) {
> @@ -560,7 +560,7 @@ unsigned long find_first_zero_bit_le(const void *addr, unsigned long size)
>  #endif
>  
>  #ifndef find_next_bit_le
> -static inline
> +static __always_inline
>  unsigned long find_next_bit_le(const void *addr, unsigned
>  		long size, unsigned long offset)
>  {
> -- 
> 2.45.2.1089.g2a221341d9-goog
> 

