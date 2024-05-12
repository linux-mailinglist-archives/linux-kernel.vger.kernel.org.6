Return-Path: <linux-kernel+bounces-177000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073EA8C385A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 22:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D2E28157B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 20:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0725B537E7;
	Sun, 12 May 2024 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogbRgsH9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8B710949
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715545398; cv=none; b=hbA41ZwOFTPUVZGAQWzHpk3YcEXmHoxjUHNqGW3XaHyg7wn4zbZWbMSSyPajJpmFPFDDgUidoqv2zrRGrD/Fbu1kPYZobvJAwDZLuDDa0ofvwgdqV8uyKjki17qMQMD0i63LTgXtxnZPH0T9yF3YH7DcRcAQpEHeZBddTU/ixbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715545398; c=relaxed/simple;
	bh=RnIpQ8Mc6XKFlcXZ/Etdg8chW5qvoLKfj4r+c2WSPnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8f1zdO5wBd20DmgQznhob6TML7CT0++AvVVAPgQCn2INNVg0GkXVVacOifCqpApWmbudne9Y9XwGPzRh+9XKl8vqQ5jgiCqkW1Kf6KPrY7GrDjV7Pm6ee9UneppDMxPuupk3u5In67GB54aWTH2eP9n4Y+L9vaRMAhq+MHkDCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogbRgsH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE33C116B1;
	Sun, 12 May 2024 20:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715545397;
	bh=RnIpQ8Mc6XKFlcXZ/Etdg8chW5qvoLKfj4r+c2WSPnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ogbRgsH9gSeXeijruRkYvWjWfKKgtYPmWSdOFQZsNR7+LSvHZDt4tmtN158u+Nqb3
	 vCV/9JZ3NzC5o3t4xBhGhNR3Hz+TD/sAOLqZL2KFuplqpkHY2x7aHDXqeHrExKd4rU
	 luqKZAFlBzE0pVk0bPEfax2pCZXp+f5Wsz4BU1+73yAOELlshMa4U+lt9OhjxU0UpX
	 L5q9aUZNrQW0LNZOk/wFt9nJZA/QD6yV8adRVUCi28XGuTD3pQeQR37FRsyGBf+YDU
	 EAbib4Rk7lgX2vUEeEPMvqocZPt2jLFw5rfckJsplJy0xZFlBcWlXES0UBufbLWhu2
	 rE3RQG+Aa9uKw==
Date: Sun, 12 May 2024 16:23:15 -0400
From: Paul Gortmaker <paulg@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: Intermittent Qemu boot hang/regression traced back to INT 0x80
 changes
Message-ID: <20240512202315.GA79225@kernel.org>
References: <20240424185806.GB101235@kernel.org>
 <20240424195157.GGZili3b-AxmUDlipA@fat_crate.local>
 <20240426122402.GA36092@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426122402.GA36092@kernel.org>

[Re: Intermittent Qemu boot hang/regression traced back to INT 0x80 changes] On 26/04/2024 (Fri 08:24) Paul Gortmaker wrote:

> [Re: Intermittent Qemu boot hang/regression traced back to INT 0x80 changes] On 24/04/2024 (Wed 21:51) Borislav Petkov wrote:
> 
> > On Wed, Apr 24, 2024 at 02:58:06PM -0400, Paul Gortmaker wrote:
> > ...
> > > pci 0000:00:1d.0: [8086:2934] type 00 class 0x0c0300 conventional PCI endpoint
> > > pci 0000:00:1d.0: BAR 4 [io  0xc080-0xc09f]
> > > pci 0000:00:1d.1: [8086:2935] type 00 class 0x0c0300 conventional PCI endpoint
> > > pci 0000:00:1d.1: BAR 4 [io  0xc0a0-0xc0bf]
> > > pci 0000:00:1d.2: [8086:2936] type 00 class 0x0c0300 conventional PCI endpoint
> > > <hang - not always exactly here, but always in this block of PCI printk>
> > 

[...]

> So I owe you guys an apology for pointing the finger at INT80.  I still
> don't understand how the pseudo bisect on v6.6-stable seems so
> "concrete".  The v6.6.6 worked "fine" (it seemed) and v6.6.7 died fairly
> quickly.  The revert of INT80 on v6.6.7 seemed to "fix" it - but if so,
> it was only because it perturbed something else.

With hindsight, it is pretty clear the kernel image changes/alignment
were doing exactly that - triggering a dormant issue in QEMU.

> I want to try some of these things, but I also don't want to
> accidentally lose the reproducer I have.  Maybe I'll see if I can
> reproduce it at home, since I'll lose use of the current box in a week
> anyoway...

So I did reproduce it at home, and once I got off the shared server and
onto my own stuff, I could prove Boris was right in suspecting QEMU.

> Again, sorry for the false positive.  I let the v6.6-stable testing bias
> my mainline conclusions to where I didn't test underneath INT80.  I'll
> follow up with more details once (if?) I manage to properly sort this.

Turns out, with my own stuff, and dmesg not being locked down (annoying)
I found that there was a 1:1 correlation between a PCI hang and this:

qemu-system-i38[758683]: segfault at 7f7378b02 ip 0000557a5051cec4 sp 00007f7383dfe0e0 error 4 in qemu-system-i386[557a5019e000+5b0000]
Code: 84 00 00 00 00 00 41 55 49 89 cd 41 54 49 89 d4 55 48 89 fd 53 44 89 c3 48 83 ec 08 48 8b 07 48 85 c0 74 22 48 3b 47 38 74 1c <48> 83 78 08 00 48 8b 10 75 1e 48 8b 48 28 48 39 ce 0f 83 a5 

..appearing in the dmesg output.  Pretty hard to argue against letting
non-KVM QEMU own 100% of the blame for this one.

Paul.
--

