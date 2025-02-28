Return-Path: <linux-kernel+bounces-538287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65719A496AD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA7F3B5749
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA780264A87;
	Fri, 28 Feb 2025 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhW8r5hn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3639F25D1F2;
	Fri, 28 Feb 2025 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737245; cv=none; b=SThY4lPouDkE5UoZinRQ4LHDL1jGNo+oL1G+xSjcokP/unTaHRTbLqhUF0JFPeSoU61oEzHWkUq3wd3eS9VrIRySQRKpMLoyVPL2aAn1XvSNe3fzajCDvxCJ2NP44lks/ZOddkuC2msAs+DBwhZ7EgXznDljM0xs0L6OXHfHV4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737245; c=relaxed/simple;
	bh=x1cKyeaIVIgjeWHsX5Z1LYYOPIaS5AKHdehywA2BHHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hs+ZqBm4U431+lqvfCTvKcFp1i/sHMrrHCR3cWbiuk2WNW4rpRkmTFovXvKdJ6jLyHyAHDGRxTTvUkC/OFH9Zf9qJyPnMg99SpXps3jr2NbH60KJw9yqI5sBJmw8x/1STkJSpCMacjU8TZkIC7hYwcXaQz6aQGPFbkUKWdGP8Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhW8r5hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BBCC4CED6;
	Fri, 28 Feb 2025 10:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740737244;
	bh=x1cKyeaIVIgjeWHsX5Z1LYYOPIaS5AKHdehywA2BHHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XhW8r5hn+jBRN7HvPYUlH40MsOgOmOm343ImfzpHgNR0Xck2w+kaXCw0yenhDOl+c
	 nYbRUuSdOj9ddawGAappMhqu5layPUbl/FD72QW+rKGp5ebJ5c0KE1CZTZUBLDZQAv
	 JSkXZGZZsHCNHiQGuT5T4LwqlUgqACRrizL6uc07ymY64Jat/sjc17XhDQeNxZkmGd
	 UDHYdqeVybNHhj8XqhEuMXCmyaeXrCciT8KGR4/qxbqr1xdvTHzFN+0QjDSHTw4w1Z
	 V92e2G1VEvCwwDb/N0MB7N5+ToSNV03xhXxiwPPEMfN70N6O/L62ckDc3psemfOtxE
	 CBwCfY3W2x+7g==
Date: Fri, 28 Feb 2025 11:07:19 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] x86/cpu: Add facility to force-enable CPU caps
 and bugs
Message-ID: <Z8GK10q_ouii0O5F@gmail.com>
References: <20241220-force-cpu-bug-v2-0-7dc71bce742a@google.com>
 <CA+i-1C2dB94t7nDEd-41MgLeHMYGN2oQJyQE8qnkcx+xYdHfpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+i-1C2dB94t7nDEd-41MgLeHMYGN2oQJyQE8qnkcx+xYdHfpA@mail.gmail.com>


* Brendan Jackman <jackmanb@google.com> wrote:

> Hi folks, happy new year. I hope this ping isn't too aggressive given
> the season - please let me know if it is.
> 
> Any new thoughts on this?

Sorry, this series got lost in the holiday season (apparently you 
weren't nearly pushy enough to breach the maintainer patch-detection 
noise/signal level :-), and this functionality is definitely useful and 
the series looks good to me.

Integration with clearcpuid= is so much more generic than the original 
variant and reuses a lot of that logic, so that's a big plus.

I've applied it to the x86 tree under the tip:x86/cpu branch and if 
everything goes fine in testing it should hit v6.15 in a couple of 
weeks.

One additional thing - which I'd suggest we make a 4th patch, because 
it affects the existing clearcpuid= behavior - is to extend 
set/clearcpuid= with a bit more boot time verbosity, right now it 
taints the kernel:

                                /* empty-string, i.e., ""-defined feature flags */
                                if (!x86_cap_flags[bit])
                                        pr_cont(" " X86_CAP_FMT_NUM, x86_cap_flag_num(bit));
                                else
                                        pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));

                                if (set)
                                        setup_force_cpu_cap(bit);
                                else
                                        setup_clear_cpu_cap(bit);
                                taint++;


I'd suggest we do what PeterZ suggested back in December: in addition 
to the tainting, also emit an informative pr_warn() for every CPU 
feature bit enabled/disabled over what was present, and maybe make a 
bit of a distinction between 'feature' and 'bug' feature bits.

Thanks,

	Ingo

