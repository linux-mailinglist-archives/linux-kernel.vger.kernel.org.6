Return-Path: <linux-kernel+bounces-565098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C70A660D7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3FD189D41F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601752036FD;
	Mon, 17 Mar 2025 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+AO+nz7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7301FECD3;
	Mon, 17 Mar 2025 21:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247738; cv=none; b=qY+HA6Njn8JwefjnARLfqrQo6l7TpzOAUe9SPE4cvFSKHvuoEWMJEqjnIVAV92AHMLmm97hcbsr8hSMsEdSzpG742hCcp0mvkAFWM6pytPJeJbyiRHb2ptHwkPpqqyv+NZmaVaTKNa5X3eHF2wz8p22Uwv8gc3CxKVvYbw/YmuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247738; c=relaxed/simple;
	bh=mY7RfZWyLTbZ10ruqlYa7fd0uG+Pi3VTrAf/skYbvd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tm3oGNYZwM6yrFlMbdTqcXHgeWi4E3hm5jJxwup2o+oh0aVbb9jMnaYe5Og3CeY9UN3vOIrz7cgFu3p8aoU6KNEGUV2lCYiKk/O/6SWajIUYZ1pLb+ju+chUe2vUpCb8bUVwIoC1wxGRVbxzP1mI4w5YZbhyIHW4PzEUI/cVNbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+AO+nz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4CDC4CEE3;
	Mon, 17 Mar 2025 21:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742247735;
	bh=mY7RfZWyLTbZ10ruqlYa7fd0uG+Pi3VTrAf/skYbvd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l+AO+nz7hTJzhReGp+qKtYe3lClYByMUfgnoSX700R21p4GblS5xGXgW8ZPjHZ2Nh
	 UONdmssuvKzZV+0rlHSfrcM3PMyJVtTsLKcwWi9jwzy/mJhACn2qir2+fkx6QZJs55
	 DqKKyojqw5twQqZutl5iSANSPBBwwTLUyYv8I4jEysCglrcPlmGE+/bwkVjFUqtWia
	 V4PmO1X1YR3JNgUPkRRcANKAvHNzw5/eAT+xuOkAqghWbCUgkcYoud74yh1n4mx8FN
	 mMFAPfGfQaLTwkOi5RqEuGVapwOpaRVLznVKYT3Dw+Ef9BYWgpWtfeLkppHUi77e9Q
	 bBR8TSBBN9utA==
Date: Mon, 17 Mar 2025 22:42:09 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/29] x86: treewide: Introduce
 x86_vendor_amd_or_hygon()
Message-ID: <Z9iXMTIcz5xmqax1@gmail.com>
References: <20250317164745.4754-1-darwi@linutronix.de>
 <20250317164745.4754-2-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317164745.4754-2-darwi@linutronix.de>


* Ahmed S. Darwish <darwi@linutronix.de> wrote:

> -	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
> -	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
> +	if (!x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor))
>  		return -ENODEV;

Could we just not do this?

The above vendor check may or may not be equivalent X86_FEATURE_ZEN1, 
which we could first assert via a single boot-time check:

	WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_ZEN1) !=
			((boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
			  boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)));

And then replace all the above with the much simpler construct of:

	if (!boot_cpu_has(X86_FEATURE_ZEN1))
		return -ENODEV;

But I'd suggest keeping this patch at the tail of the series, because 
if it regresses it would be easier to drop/revert.

Thanks,

	Ingo

