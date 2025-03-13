Return-Path: <linux-kernel+bounces-559270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8FDA5F19C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47243B3A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EC2265CB7;
	Thu, 13 Mar 2025 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nc6M6+cG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D8A265610
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863251; cv=none; b=DWL+ovhnMLRhiREsQHrpZN6zni9516kOG0LJbD8T67+blXqz2PJA5BuUgViIsGQiKOHhoY6b2vGd2CKcWxBs3m88UEtC7nfj2DgTtihL+32KOILk0Bb19ZAR3tja1jcXIdQV0PVcKErLiw4SgHV3RAtRWbHQYafCe6SDOy9SYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863251; c=relaxed/simple;
	bh=PhG3T14xmNLJ2igVUO8SEMpUDPPBIMEnhLKBsTJGWEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ff/Nqe3BESMkI5XwekiFfmQfyHM0ZyOGmcKSfhOrqoAU2EyuvKBo4jQ9XQ/A8/ujSLcrxOsYm1lcqIefOpV3GIUeyAx2vwmWOjc67Xk15g67VRnGgrvnRA5/BLfFgYiLuQj5PiH++Yl5XYzvp99Im0BrB0Y+u4u0t6AyisL0zsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nc6M6+cG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6F3C4CEDD;
	Thu, 13 Mar 2025 10:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741863251;
	bh=PhG3T14xmNLJ2igVUO8SEMpUDPPBIMEnhLKBsTJGWEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nc6M6+cGMmfjfPl6mygKyLqcLK7ngvetUYGX4u8WNzZdEBMPSoyJ/UDkORp4TSrJS
	 oDTxoCHVhy1GmkJDOWw1iGFdlFW0Y3JpkxXQdkoO5DUXoBdZ2qiZh33RTwFRAKEfuM
	 aLBqBfdVhNJYmup2tUhyo2oLEFduJNwmANjZ/2TIKHS2b61pJqY/i2MPlI984yjnSE
	 ZkfmWMk/nIqJQZzb88L+jQJmRom8MJgeVJL9KiM9WoFdJ2I8RwYQx34MO56o0f4z8O
	 5CWMZCUPzXQgReTO6BahpIuQmIvWMhLp8fZzqGeNQ/+czi2r2HSKgOk4ADz6L5LnAX
	 iKOMi8fbSYDUQ==
Date: Thu, 13 Mar 2025 11:54:04 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org,
	bsz@amazon.de
Subject: Re: [PATCH v7 0/8] x86/kexec: Add exception handling for
 relocate_kernel
Message-ID: <Z9K5TGMvmS1ApBCW@gmail.com>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
 <Z9K3dcMAgu3cot85@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9K3dcMAgu3cot85@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> I applied the first 3 patches to tip:x86/boot for 
> phased-risk-reduction reasons, and because I had some questions and 
> suggestions starting at patch #4.

So there's a new objtool build warning from the new exc_handler code:

 vmlinux.o: warning: objtool: exc_handler+0xe: early indirect call

That's with a x86-64 defconfig + KVM enablement.

Thanks,

	Ingo

