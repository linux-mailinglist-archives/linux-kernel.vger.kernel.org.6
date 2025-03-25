Return-Path: <linux-kernel+bounces-576200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5320A70C55
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED283AA8D1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C209266B55;
	Tue, 25 Mar 2025 21:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR3UcB0D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D32F179A3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742939013; cv=none; b=pXmKtuVRUJyqKQJ1syXC2qloOf2N8BpIhMpH8HGm6qZ/VnD4BpyJzC6Fqm/8IsvG+QiWdY2zTp/7Y4OVLng4O+mMY9BtbqZqCq8PoeRMjPMJQTvlQwNaT0mCL3uEginethJ3zZDq+iojbyyHX7o2xIMuKxzM5b712+gvK5otdoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742939013; c=relaxed/simple;
	bh=RNHwOYSkoVY2aSbHmiY3Gp4SUvKjRpsjpk/4O/oHg2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyHSuKePJTNJ/8ebV2QspKLWC88PXmApaVNxRFVJ61gcYAU7nZdj+CGCvmHT+R1QS1bYtAGDIpwFF4Cw3Mjg216jtQc7kZG643WVlVL8e47LTNMlyaWiITHsvlyZ+NGglMZsJ60XzE0ApiEz/BC8EFcHKq2B8LhKgWbtpgAzaYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mR3UcB0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1D2C4CEE4;
	Tue, 25 Mar 2025 21:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742939013;
	bh=RNHwOYSkoVY2aSbHmiY3Gp4SUvKjRpsjpk/4O/oHg2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mR3UcB0DuU3LZGM4Uk9KQmpgle1Ez4+DLps72+7df8yUlRPsfGTxiRZ7/R9BRB/zr
	 XFmtmKzE6jC2FFBG9ctXXZQeU2sSVSdtHXcvEWrfwdJ3xEneFYQ/2b4RNIBXMjIG4k
	 xgvolSc8z2LkN9RgvePwp6x/qDBf4CEWriNmYulsiRHTYMPAw/g3SCscjknO5/1GQV
	 rmLbUAgcJ7TpxXu55tMRioErtqVY/3rj8Z+Gt0d/rsieZ9BX7+5MRw8uQouOqszSQ9
	 VeWuxXJ5cGis4k1dEYVm7OhWeFcNzpCNpmk6ML8xwffc9rlRMJPgA+WHlzgNGYuvpH
	 lo5SK1+wlNnyw==
Date: Tue, 25 Mar 2025 22:43:28 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/2] x86/bitops: Fix false output register dependency of
 TZCNT insn
Message-ID: <Z-MjgKSzJKIVooFI@gmail.com>
References: <20250325175215.330659-1-ubizjak@gmail.com>
 <20250325175215.330659-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325175215.330659-2-ubizjak@gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> On Haswell and later Intel processors, the TZCNT instruction appears
> to have a false dependency on the destination register. Even though
> the instruction only writes to it, the instruction will wait until
> destination is ready before executing. This false dependency
> was fixed for Skylake (and later) processors.
> 
> Fix false dependency by clearing the destination register first.
> 
> The x86_64 defconfig object size increases by 4215 bytes:
> 
> 	    text           data     bss      dec            hex filename
> 	27342396        4642999  814852 32800247        1f47df7 vmlinux-old.o
> 	27346611        4643015  814852 32804478        1f48e7e vmlinux-new.o

Yeah, so Skylake was released in 2015, about a decade ago.

So we'd be making the kernel larger for an unquantified 
micro-optimization for CPUs that almost nobody uses anymore.
That's a bad trade-off.

Thanks,

	Ingo

