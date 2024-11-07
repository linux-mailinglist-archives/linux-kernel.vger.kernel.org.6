Return-Path: <linux-kernel+bounces-399553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4216F9C00A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5758C1C20CF4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C26A1DDC24;
	Thu,  7 Nov 2024 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lN1n+s+X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E1C1DE2D5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969797; cv=none; b=GCxEmehNnkkCzb0YxE4mq2H1w0405HT0KghG9npis2i6ajfvGGkgjUCO5npXWNms2AWInTD5ZYCbRca5AONhEnVvAbtAZ+IjD8+l4hHxhm6ji4sPqyqyqM6rUxyg8vqJn/vEctr5ro5OKrr6uRflTwaLdmu8633MnmQ6q5kKTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969797; c=relaxed/simple;
	bh=Ndk1Xpza1igrge8/sdvz9ytJHyDP4td9d7QRiYLFNXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2sJz/w12YdxaPM4ewz9Wrw5ukiDtTWstKjW3u53EbU+46khjfixcglapi6+pj2M+JwsVZ/25fP8bpzPcVmy4WonIsEOVmtAJfPw79Ow7M7TUDXZ1XEUuRa+2Ppi0xn5pFhvoDGQyyEkFQZ42iaLZHGfqeOE3DbxtwQbjZLGF9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lN1n+s+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77982C4CECC;
	Thu,  7 Nov 2024 08:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730969797;
	bh=Ndk1Xpza1igrge8/sdvz9ytJHyDP4td9d7QRiYLFNXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lN1n+s+X2ahGADGvmFqgaMuurdd4oP4WNB4g9A+8QvBVRYab7QcolrihqBXizOn3M
	 soAvZA0YPGJehDKBWffE4IB+haqHtFDznjiEwPJa9CsI639u+/MUhd+LO6XaOERHuB
	 MC91DmCLdwuJ+KlKkbfogZsziPer5u+sbkekAX4Y=
Date: Thu, 7 Nov 2024 09:56:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH v2 1/8] Revert "binder: switch alloc->mutex to spinlock_t"
Message-ID: <2024110742-setup-clothing-44b8@gregkh>
References: <20241107040239.2847143-1-cmllamas@google.com>
 <20241107040239.2847143-2-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107040239.2847143-2-cmllamas@google.com>

On Thu, Nov 07, 2024 at 04:02:23AM +0000, Carlos Llamas wrote:
> This reverts commit 7710e2cca32e7f3958480e8bd44f50e29d0c2509.
> 
> In preparation for concurrent page installations, restore the original
> alloc->mutex which will serialize zap_page_range_single() against page
> installations in subsequent patches (instead of the mmap_sem).
> 
> Cc: Mukesh Ojha <quic_mojha@quicinc.com>
> [cmllamas: fix trivial conflict due to 2c10a20f5e84a]

Nit, commits have the full name in them as well, not just the sha1 one,
i.e.:
	2c10a20f5e84 ("binder_alloc: Fix sleeping function called from invalid context")

thanks,

greg k-h

