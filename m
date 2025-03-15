Return-Path: <linux-kernel+bounces-562767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740DAA6329A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 22:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1383B5964
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 21:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897AA1A23A1;
	Sat, 15 Mar 2025 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbYyKALW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A21376
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742074172; cv=none; b=YGllGS3fm7HDXQkw7zugv/cRf9oRJ3dJDl+bWzYRufUP/o9MK2hrMgpNlrHaeUBplGEQDGpHpq5p3yt2/YzoiRQXGqFngIKvla/B7UaoIuxjfbLuZ9hUvTS9LAJQERor5fFzE4IXF5tPB0nWmR6n3jXnP0wP3XJfY/PKbUaBcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742074172; c=relaxed/simple;
	bh=CUd5Qe+mzYnqZF5hfgXVhMqUIxBGwVT/lW1fPvadvnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGXWScp+l/KLwNwWwCU3l/U0V64e6TT30rn7Yp0Fk8W5lQeIeORJpzYRyPet7RKtmQR02su0p5uPcmLXgdOeVP2iKf5jd7gNMDSR94RXXk+tiuV/sXJOBvIqBwNLXAqRsWFdHJSWdeLKYwjovVEMyzRWTOQikGKYZLldM2s9kUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbYyKALW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971D7C4CEE5;
	Sat, 15 Mar 2025 21:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742074170;
	bh=CUd5Qe+mzYnqZF5hfgXVhMqUIxBGwVT/lW1fPvadvnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XbYyKALW1wgkVTIhAly8AslILMJHmsQkvkfYgm+UHF/Y6wh/Tj9cFzsC2BiGhlaWN
	 U0Hj/cGHsyLNfT7Mc00As3PnGzNexS+J+tTYgkALwgB23HaVrPpUvr78jGb1+QbO0s
	 0Jw0ZM3WO1+XHe/v90RYMuq8kh3cdf6I30C2cCncE08cNt0y8Ldph351pkCXiN/RXB
	 S8ja22Y2pV0A0E/Uh8han6Z7bCuQoQtmzRSHOOAybNMdIkU6MjXRmmpe4J3v1CItzi
	 xOPNfmLRoMVngXhRRqihGw9+KF9U7kK4gfPzauo3N3DkX4OU2fuuJeetryyHt4IjoC
	 7vTCgeg0Pvd+w==
Date: Sat, 15 Mar 2025 22:29:25 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/asm: Use alternative_input() in amd_clear_divider()
Message-ID: <Z9XxNbdLCZFiK1NG@gmail.com>
References: <20250314081453.565859-1-ubizjak@gmail.com>
 <20250314112018.GAZ9QQ8hPXt2Mk22cG@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314112018.GAZ9QQ8hPXt2Mk22cG@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Mar 14, 2025 at 09:14:38AM +0100, Uros Bizjak wrote:
> > Use higher-level API to declare assembly with alternatives.
> > 
> > bloat-o-meter reports no code size changes.
> > 
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > ---
> >  arch/x86/include/asm/processor.h | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> I'm getting tired of patches which cause unnecessary code churn. Please stop
> this. If it ain't broke, it doesn't need fixing!

So why does the higher level alternative_input() API exist? If it 
shouldn't exist then we should remove it. If it exists, we should use 
it consistently instead of open-coding its equivalent.

Cleanups like this, especially if they are clearly part of an effort to 
improve x86 code generation in this area, are not 'code churn', why 
would they be?

Thanks,

	Ingo

