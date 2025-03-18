Return-Path: <linux-kernel+bounces-566105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BDBA67333
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9DBF16932D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5341420B1EA;
	Tue, 18 Mar 2025 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHwP5uUi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E683FC2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298917; cv=none; b=K5XL3GvFuetPivE+Nc1SZZDhPuOxudKlS0qVwLQcmUHKv271X2dnp3vsm7CfiJQl10z4Vo3cx3w5kdeYmxN1o9ibuXd7ilM0LGDpv1umLajOJta0K1aBo4iC9A8JZpYJDb7a4nEUCBsYn+nXdY2g7SQnaXK0unmJnbBTHdG+aBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298917; c=relaxed/simple;
	bh=c7HkstpGcO2Wz74+bpx8LysnUsjVS4dlbYlt46NYQcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm3dHkoB8kBbeASbP5k6WL2meysvkVKOgoZt6KRMNmDSoO4USaUEkILlwYCdamDYA9pWSEnc331iwVxjVld5pe7oj+Q4rCvgSyG7xh/WPpb9/+ohx931ReaI7mt+SBnhyN3JW6mmLFqrd6sRPN8ecAqi9diqi6kmQUgaX1iPYxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHwP5uUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92771C4CEDD;
	Tue, 18 Mar 2025 11:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742298914;
	bh=c7HkstpGcO2Wz74+bpx8LysnUsjVS4dlbYlt46NYQcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tHwP5uUiopYx6H8h8DgdaOXeXsClbY7+73Yg9HHNJ40YVfhLxp/XB+JNkRLFBFBTX
	 OZ7+auybdL5SMXFHTJuMEP4HrIoIVmArbIOyf5h4Kzpbvf8GPODjMP2rRpVWiK58aU
	 k56o9qofo3bWSY02GQIcBoIMCpaxAf0LGOBeoSAQ0pWvNaTnJphYDt4PA6aNqP1lel
	 1lFYiF7XIM/PB0LsyiyrKt+hZZwMoLJUMWYPLS/h9fgqA7X6oRZyRL1ZcoMXzOxdXa
	 sfpA5ryanupMyY/zMtdVjRTHppz0u5TFG1FGBiHuiCj9LUz4XMZePzRCX8+7QOOwNR
	 Prw49yJ+Z+SkA==
Date: Tue, 18 Mar 2025 12:55:09 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/5] x86/cpu: Introduce <asm/cpuid/types.h> and
 <asm/cpuid/api.h> and clean them up
Message-ID: <Z9lfHeB6JnzQpfU7@gmail.com>
References: <20250317223039.3741082-1-mingo@kernel.org>
 <Z9lbieqhnsVsAf4J@lx-t490>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9lbieqhnsVsAf4J@lx-t490>


* Ahmed S. Darwish <darwi@linutronix.de> wrote:

> Hi,
> 
> On Mon, 17 Mar 2025, mingo@kernel.org wrote:
> >
> > From: Ingo Molnar <mingo@kernel.org>
> >
> > This series contains Ahmed S. Darwish's splitting up of <asm/cpuid.h>
> > into <asm/cpuid/types.h> and <asm/cpuid/api.h>, followed by a couple
> > of cleanups that create a more maintainable base.
> >
> > [ This is a resend with a proper SMTP setup. Apologies for the duplication. ]
> >
> 
> Thanks a lot!
> 
> Just a small hint that I see this PQ in tip/master, merge commit
> b8fefef00c0d ("Merge branch into tip/master: 'x86/cpu'"):
> 
>    # New commits in x86/cpu:
>       ba501f14e1e6 ("x86/cpuid: Use u32 in instead of uint32_t in <asm/cpuid/api.h>")
>       aec28d852ed2 ("x86/cpuid: Standardize on u32 in <asm/cpuid/api.h>")
>       f2f828b547ab ("x86/cpuid: Clean up <asm/cpuid/api.h>")
>       67a7ae050e7c ("x86/cpuid: Clean up <asm/cpuid/types.h>")
>       02b63b33dfc9 ("x86/cpuid: Refactor <asm/cpuid.h>")
> 
> But for some reason the above 5 commits are not yet pushed to x86/cpu.

Yeah, that was a temporary status until a bit more testing could be 
done - I've pushed it out now.

Thanks,

	Ingo

