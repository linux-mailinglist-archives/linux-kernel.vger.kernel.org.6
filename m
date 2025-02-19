Return-Path: <linux-kernel+bounces-521769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF428A3C212
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8FF1725C6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11CA1EB9E5;
	Wed, 19 Feb 2025 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QhtzV8qq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595A81DFE25
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975130; cv=none; b=Bf07YolQ8gV7F+BKYfy7on9Fn54lChTSBJNo1fX0jLoxNxUpcF0J/iGSD3b1Wg6AfQfMzz1ih9z/jezsGPlg+5C0nV0T0ONgmHHLpLvHkDgcTC6TuuF5up3liYaH62WUJljLYpBkUXZrtWX07p7hmX7i2WlbFWx2OopQJwCA41s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975130; c=relaxed/simple;
	bh=zDMhoXicGLI2a+X0sHz8W0ODc2KcBPFmXjR0R0QbK4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/nPmmitTTlTE427RMGozS0hp5y/XyhH/x9ghe1iDM0Bon81B+wIP0sIE32SRKqKPoWLLBB+PtRYa/n+x+NYdac0TDTqEin439ohHI2tYZFBmiyl82JIIgVQ6ohg3BwKy3tJO6Nk9PBpJ3pQLT0OoPS0mzHReT8EovE/RY13/9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QhtzV8qq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A6EC4CED1;
	Wed, 19 Feb 2025 14:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739975129;
	bh=zDMhoXicGLI2a+X0sHz8W0ODc2KcBPFmXjR0R0QbK4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QhtzV8qqPiWVa4VZ4TgWZZGka88JCzRR8m28CrX/NSNipKtciRZSUVYu+RBkHlTOz
	 Si0xjsOP2NYfN+Glx4GwoMP+uDVkbWIccTLLetCiayRX8xoSKHmH/gq7twJWLyTeDf
	 FlSSaLgYJpKUatdvQFlFTDDdY7m+V4bqmiPXoeLI=
Date: Wed, 19 Feb 2025 15:25:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	wine-devel@winehq.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ntsync: Check wait count based on byte size.
Message-ID: <2025021906-retainer-trustless-bd1d@gregkh>
References: <20250219001920.210847-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219001920.210847-1-zfigura@codeweavers.com>

On Tue, Feb 18, 2025 at 06:19:20PM -0600, Elizabeth Figura wrote:
> GCC versions below 13 incorrectly detect the copy size as being static and too
> small to fit in the "fds" array. Work around this by explicitly calculating the
> size and returning EINVAL based on that, instead of based on the object count.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502072019.LYoCR9bF-lkp@intel.com/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> 
> --
> 
> Suggested-by as per Arnd's request, but the only thing I changed was preserving
> array_size() [as noted by Geert in the linked thread]. I tested and found no
> regressions.

You forgot to sign-off on this commit :(

Can you resend it please with that fixed?

thanks,

greg k-h

