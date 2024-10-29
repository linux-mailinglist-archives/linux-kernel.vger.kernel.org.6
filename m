Return-Path: <linux-kernel+bounces-386252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7733D9B4101
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B43328370A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DD61F9A99;
	Tue, 29 Oct 2024 03:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKqwQsWK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53D71D5AC7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730172457; cv=none; b=Oxh1tuEZ+X1g7EbIsn5wT66kopjycuvJttjIlZgUGjXZIMcQ0aEbfJaRwebzzpPbAiApB687ZOSTM7ghO7rDZ6jfjtUluhm/NfCUMkIjFZdcJ6aU1yYDmXP0eqzpetAUYocyRp3oS8jl9bje1hlAqelQF77WZ65np3/cBcKuaV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730172457; c=relaxed/simple;
	bh=mmgwq8y3H0kMOzRaYgyB6yY10fO8ugLNPAT4h3PEtek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnZmXkUy6+zjKa11ZfO/Wmv34/Qg/rufUSeZ3hvefaN8wf/s5XkuX2KWjGNKtKR+i5XanrWN0vePyU0EYXBh6tDCFeC+D3Oe9xUyLoBa6MKCrkwc0GpnQoknbBUZ7mIVzahfdHpkSIktKT0SpvaMg0a/uorC7NASQ4NX/OG8AFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKqwQsWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5F1C4CECD;
	Tue, 29 Oct 2024 03:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730172457;
	bh=mmgwq8y3H0kMOzRaYgyB6yY10fO8ugLNPAT4h3PEtek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tKqwQsWK8xbZYGTRWXUkQED0JusaOi4QrZEdimc93gx83rU0tjHZvEgZ5V87w4c86
	 XiCkpIScVa5jRj0wUc2kfckBINapFTMSWyRk2+5X3bXrdBm+KkaNdKvgwqBUezifI+
	 sr2mUaQk/OTI++5xcVYC9U6Tz4iEIf4NcSFGna4A2+oz1vd4ciRWqE+xJkE1n8RW3j
	 0O3YTYbTPP18CQcj6UySqY5/ER7PZ+1h/duYfCP2WjKuDyXBD63jaWb0HR2Mi4ufTP
	 eT4y9G52GAOSohCYt7OZw/aum6LJncFJhQBVA/DgSi/BCotLJES/D5MIyQFIO469ca
	 PqTDGfz47RZkQ==
Date: Mon, 28 Oct 2024 20:27:35 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Waiman Long <longman@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 2/6] x86/uaccess: Avoid barrier_nospec() in 64-bit
 __get_user()
Message-ID: <20241029032735.pw3bg64bpneqnfhk@treble.attlocal.net>
References: <cover.1730166635.git.jpoimboe@kernel.org>
 <82cbb9983fef5ecf6f1cb33661e977172d40a7e6.1730166635.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82cbb9983fef5ecf6f1cb33661e977172d40a7e6.1730166635.git.jpoimboe@kernel.org>

On Mon, Oct 28, 2024 at 06:56:15PM -0700, Josh Poimboeuf wrote:
> The barrier_nospec() in 64-bit __get_user() is slow.  Instead use
> pointer masking to force the user pointer to all 1's if a previous
> access_ok() mispredicted true for an invalid address.

Linus pointed out that __get_user() may be used by some code to access
both kernel and user space and in fact I found one such usage in
vc_read_mem()....

So I self-NAK this patch for now.

Still, it would be great if patch 1 could get merged as that gives a
significant performance boost.

-- 
Josh

