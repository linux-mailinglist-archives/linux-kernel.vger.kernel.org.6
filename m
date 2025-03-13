Return-Path: <linux-kernel+bounces-560053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1939CA5FD09
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B223AF267
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150C615747D;
	Thu, 13 Mar 2025 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htfqBc1o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CBA250EC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885618; cv=none; b=hXs8hJsPAI1laAJoU/bLu6uk204Jx0cb5ZktwmP/wkNEB2y6goMw/9kMNgj6C/NV2rXwcmpMSZ39gCx6K/0slOK2b7fXnT/dyfhZNqBEgsyvrnDYmj/lpDYcoM0w8NQiUBW2u2rt9VivKlohI/qGwh+oaVaAX8VCP2QhPq2+Gx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885618; c=relaxed/simple;
	bh=Nz9EEbxa96ubbGlmtt8GqUKsPrxRe7iBnOqLJfXPMJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orkTB3kcpQsUnBqlUBr9U1K2eh3PKikZmCylJ0waBdnzrQQ9xeeA4AK7ONxbmpatlCh38B7cuzrKYqBtFntUlx48Mp84dE3vtjUtVy9xLIp2SRYjo+srRR3vUGPN9ofTnHUbWXeU0c/34PdkZ7wGsobajmWsW5e6bbFeMbZwEUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htfqBc1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B38C4CEDD;
	Thu, 13 Mar 2025 17:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741885617;
	bh=Nz9EEbxa96ubbGlmtt8GqUKsPrxRe7iBnOqLJfXPMJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=htfqBc1o8KoQCwCwBsyUS+lFslHdDQBvQ/yEkPjM1sTnEJcMgDfXOvgdt59jsYUcN
	 Gmdept+WN/OWh+7QkJJMtNeolAhvIExamo2gd/8+l57Z01YE1OIUsAH3jOY3YBQabT
	 YcdgxGAeVJZSIA/uDNdrLZCkVBhzFiXZNMwEb5M39mv1qaRft43K6seXa0/MNDxBZo
	 F7LfgVtdZTprlAzjNezH55eTHVSSXadrSGMJ0VC9jx5ExJIfa9264HvannO42xloRg
	 Wqc7vZ0b0ggO/jjd4XuLbA/Afq3L7KocRL3GW5Exe91i2O0Q9knH+YBxTUe33yXlcA
	 NRNRjf3rMF+rw==
Date: Thu, 13 Mar 2025 18:06:49 +0100
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
Subject: Re: [PATCH v7 7/8] [DO NOT MERGE] x86/kexec: Add int3 in kexec path
 for testing
Message-ID: <Z9MQqYbGBAvTz4Ox@gmail.com>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
 <20250312144257.2348250-8-dwmw2@infradead.org>
 <Z9K3GXSaZUcVr8cb@gmail.com>
 <0CDE8ED7-D8D2-4053-AE4B-4CFF59DB56F7@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0CDE8ED7-D8D2-4053-AE4B-4CFF59DB56F7@infradead.org>


* David Woodhouse <dwmw2@infradead.org> wrote:

> The exception handler already returns if the exception was int3, but 
> not for anything else. Less so the "print something warm and fuzzy" 
> part; it just does the same register dump. But we could change that.
> 
> I'm less keen on making it unconditional though. Kexec is a 
> performance-critical path when every millisecond is perceived as 
> guest steal time, and the serial output should only happen in 
> production if something goes *wrong*.
> 
> And besides, most kexec users don't have early_printk enabled anyway 
> so if we break them, this idea doesn't help.

So this check would only cause any real overhead if serial debugging is 
enabled - in which case there's already substantial overhead due to the 
serial console overhead (virtual or otherwise).

As to not printing anything unless the early serial console is enabled 
- that's fine, we'd still *break* if something doesn't work in this 
code path, so at least the exception handling machinery is kept 
well-tested. :-)

Thanks,

	Ingo

