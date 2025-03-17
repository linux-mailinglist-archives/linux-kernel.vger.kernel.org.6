Return-Path: <linux-kernel+bounces-565171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 652A6A66250
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2050189E895
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C53204C16;
	Mon, 17 Mar 2025 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9mJQBBX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F001B0F17
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742252447; cv=none; b=aWp1JJNvEBOH0gbbIDxILy2u8hG7s1WzKLpfRGF4pSh/u3Zjw6Is7AaRiqKN9fW91uFutfeWJ+8mZaOe9tZcLOMVBJbJ/KWuy1MzATmOEG7u4DRacVTFqhbA5UsBYryuQiRFgALXuiyleBeKne3rGK+vUdQLqCBzwk0ei/WGeG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742252447; c=relaxed/simple;
	bh=POjYshRG5W+ISO8gu4ii0Xj8fY1na8RP0iynC+UVP7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeOij6ZSsvdTcNzCpbY8tcblfuuH6oGE/P2RiIPzNrkW3rcxXmVDo+S3RlQTWWeQjjxAqje7DySPJH76/VkzydAZ26xAO6ly90od/JDIYshx9yY8vmrLkdtLiuBQkekRuJ9gb9JpGDxMKR9U7y7BIfzlxRnyBHUPpAuptZbIGtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9mJQBBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BA1C4CEE3;
	Mon, 17 Mar 2025 23:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742252446;
	bh=POjYshRG5W+ISO8gu4ii0Xj8fY1na8RP0iynC+UVP7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9mJQBBXIesIxZO6kAotyk7Dm9tb7NovV1AlIW9uPOyrGCzhiTDgZQkLENDpjQ4cF
	 K8fob+d+SXo48wRvYsJMuj1TMuP4V127AXiSBF2jeWl/TjGH1Qw1utkKYtEONRxpBZ
	 UtB3mE1AeLNvsfmqh9zuKTWhqixGBm8Y10mIqAZ+KctOElHwAd7cRPSjnwx1ZzzGYO
	 40V3AO2dzoaA170QzU9eNjam2hZyk3ClxcAdNcBx6nh80YbScwRSTD+C9rOm3t2Q7f
	 sp4E2fp8LFtZIkJM4PA4w5QfM0CY4cD22kRogS5NaJ6wdL2npCMWkvdWVFMqv/6EPL
	 KNCx0Vp0BtARQ==
Date: Tue, 18 Mar 2025 00:00:41 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/5] x86/cpu: Introduce <asm/cpuid/types.h> and
 <asm/cpuid/api.h> and clean them up
Message-ID: <Z9ipmWO5zA5phS1s@gmail.com>
References: <20250317223039.3741082-1-mingo@kernel.org>
 <CAHk-=whBoNCepPiOv8V-D8xcBW3O+SG1cs5ARMwvW_n5SEXMxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whBoNCepPiOv8V-D8xcBW3O+SG1cs5ARMwvW_n5SEXMxg@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 17 Mar 2025 at 15:30, <mingo@kernel.org> wrote:
> >
> > [ This is a resend with a proper SMTP setup. Apologies for the duplication. ]
> 
> Yes, now it looks correct from a DKIM standpoint.
> 
> But please still fix your name. Now your "From" line is just this:
> 
>     From: mingo@kernel.org
> 
> rather than your previous series, that had a much more legible
> 
>     From: Ingo Molnar <mingo@kernel.org>
> 
> in it.
> 
> No need to re-send, but for next time...

Oh, that's probably the result of me copy-pasting the documentation:

    # https://korg.docs.kernel.org/mail.html

    [sendemail]
            smtpserver     = mail.kernel.org
            smtpserverport = 465
            smtpencryption = ssl
            from           = [username]@kernel.org
            smtpuser       = [username]

Which I did as:

            from           = mingo@kernel.org

... while it should probably be:

            from           = Ingo Molnar <mingo@kernel.org>

I just did a test-send to myself, and this appears to have done the 
trick.

So maybe the mail.html documentation should be updated to say:

            from           = "Your Real Name" <[username]@kernel.org>

or so?

Thanks,

	Ingo

