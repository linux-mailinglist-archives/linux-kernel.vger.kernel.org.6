Return-Path: <linux-kernel+bounces-523921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E123A3DCE0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762FA4222F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F05D1F5408;
	Thu, 20 Feb 2025 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2f6YbUQK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CDCA29
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061874; cv=none; b=NJlfGknmK5Tzp4U6uU5XvuOLYic3fW/Lgmf9GoHvr2YnMzUbCDMlKzaQ3yvAEbgsodHDY2t5LnmlFa71rBH4+bm3LJHoS1q6qKiogEciHzue3mZiIPuN+PtkmGbZSdpPjvgbHccAwhIk+pcEczE5/OP8AQBvejG57d60e85q2k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061874; c=relaxed/simple;
	bh=vUCuyv9Uk3UgdDmsH/fqTMimiEhd9YBCtbYz+cEeDT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iryShfFrrAntvpbDtNPAgagU1SXVyVg9l8inJec2xlGFJuzgT9oeV5lCP2FdoHnFMz4zGtY14vESWwqaVIdJ6J5BA9BIS0Tc01nUWTh2ns+xbPe24PXBzXiaQSEPleGRlVJksRVR25IyTKT3UqeBfLc8xRO+9lLRIxTWDgx6C2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2f6YbUQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0879C4CED1;
	Thu, 20 Feb 2025 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740061874;
	bh=vUCuyv9Uk3UgdDmsH/fqTMimiEhd9YBCtbYz+cEeDT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2f6YbUQK2F3KKTlKtJA2g3lYo3kuXpxFISdmkHQ2xHWX59Q5oCnq31QWIJbfF47HG
	 /QoDkRzFZ79Ad8Ry8i/a717KjXpaAV7CmG8ETyWmCnmBs2hkpFBTFm3ZGe/6oX2fNU
	 4dopnRPpf3/B87yWTWaM1Vrh6zcprZ4uOkaCHYso=
Date: Thu, 20 Feb 2025 15:31:11 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dirk VanDerMerwe <dirk.vandermerwe@sophos.com>,
	Vimal Agrawal <vimal.agrawal@sophos.com>, kernel-dev@igalia.com
Subject: Re: [PATCH 3/4] char: misc: restrict the dynamic range to exclude
 reserved minors
Message-ID: <2025022007-rudder-refocus-5d45@gregkh>
References: <20250123123249.4081674-1-cascardo@igalia.com>
 <20250123123249.4081674-4-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123123249.4081674-4-cascardo@igalia.com>

On Thu, Jan 23, 2025 at 09:32:48AM -0300, Thadeu Lima de Souza Cascardo wrote:
> When this was first reported [1], the possibility of having sufficient
> number of dynamic misc devices was theoretical.
> 
> What we know from commit ab760791c0cf ("char: misc: Increase the maximum
> number of dynamic misc devices to 1048448"), is that the miscdevice
> interface has been used for allocating more than the single-shot devices it
> was designed for.

Do we have any in-kernel drivers that abuse it this way?  If so, let's
fix them up.

> On such systems, it is certain that the dynamic allocation will allocate
> certain reserved minor numbers, leading to failures when a later driver
> tries to claim its reserved number.
> 
> Fixing this is a simple matter of defining the IDA range to allocate from
> to exclude minors up to and including 15.
> 
> [1] https://lore.kernel.org/all/1257813017-28598-3-git-send-email-cascardo@holoscopio.com/
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>  drivers/char/misc.c        | 4 +++-
>  include/linux/miscdevice.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> index 2cf595d2e10b..7a768775e558 100644
> --- a/drivers/char/misc.c
> +++ b/drivers/char/misc.c
> @@ -68,8 +68,10 @@ static int misc_minor_alloc(int minor)
>  	int ret = 0;
>  
>  	if (minor == MISC_DYNAMIC_MINOR) {
> +		int max = DYNAMIC_MINORS - 1 - MISC_STATIC_MAX_MINOR - 1;
>  		/* allocate free id */
> -		ret = ida_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - 1, GFP_KERNEL);
> +		/* Minors from 0 to 15 are reserved. */
> +		ret = ida_alloc_max(&misc_minors_ida, max, GFP_KERNEL);
>  		if (ret >= 0) {
>  			ret = DYNAMIC_MINORS - ret - 1;
>  		} else {
> diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
> index 69e110c2b86a..911a294d17b5 100644
> --- a/include/linux/miscdevice.h
> +++ b/include/linux/miscdevice.h
> @@ -21,6 +21,7 @@
>  #define APOLLO_MOUSE_MINOR	7	/* unused */
>  #define PC110PAD_MINOR		9	/* unused */
>  /*#define ADB_MOUSE_MINOR	10	FIXME OBSOLETE */
> +#define MISC_STATIC_MAX_MINOR	15	/* Top of first reserved range */

I don't understand, why is 15 the magic number here?  All of those
"unused" values can just be removed, all systems should be using dynamic
/dev/ now for many many years, and even if they aren't, these minors
aren't being used by anyone else as the in-kernel users are long gone.

So why are we reserving this range if no one needs it?

confused,

greg k-h

