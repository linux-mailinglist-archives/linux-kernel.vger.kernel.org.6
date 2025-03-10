Return-Path: <linux-kernel+bounces-554919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B421FA5A361
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD8718880F5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8A123535B;
	Mon, 10 Mar 2025 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaLA9vnl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1C72343C5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 18:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632314; cv=none; b=t1fER3bzNdSNF5L3lYBRhXPjWT4ptgZFse+gDK1NC573PVkWn0+oKlpkJGNBhjDRuGcXJFZm1uj0MWO4ZwSa2Wq0oDDZHNThjIuHVvxnIEkSFE05lF0i/MSYXtTlAlm6gplxXFVjIf47hqdvUTjayo+HRbE7vW13SaAvc3LZTr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632314; c=relaxed/simple;
	bh=7FPAzGqZy2TLKJqMBcbEUoMukMbrxm/iu9MkBKevEfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkqR48fJxlOluQXZ7RsFhAAQegtHd3iOJQCdz6nAPKb95EHNplSAf+UyDCaL5rrusOesI35DnbdFoEGT3IY0lZEH3q/SvczSq6YjrLPemRVgIESwE3tTQE8Ir3hjvD6GPABbk9fvSI+EKfMFwe0d68Ee/eYLfbtg8m6Mp8mmBiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaLA9vnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C6AC4CEE5;
	Mon, 10 Mar 2025 18:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741632313;
	bh=7FPAzGqZy2TLKJqMBcbEUoMukMbrxm/iu9MkBKevEfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oaLA9vnlXYAdPxY8kcmyHAHLHMLCho7l8X8plzFtLsz7R56687cda7N8XAq2hXvYn
	 swgdKixY76+M/6jXrbSLXzpDj9djeOl0YCqqcTbj/Sg18P6wNkUQA+LF0WAR25Qr4z
	 KwT7wwS1KMyvKOSoy5I+EOAti3UODim1yJeN7pzzgpN5Yt1WZEeE6kAd804TQNMjv+
	 mHF2bqtujPhGr758jHVZ5noMuUhldecfWJq2om9UjcLxLb8HEzKSWrL8lOoNIzx8qK
	 yqwqXInAVwk8SUyQvOu0RXc0xleExFs+Tb9kn++g9r4uKZ8ojsC6PzefUKy2waVgUj
	 8SqZ+yebpTEdA==
Date: Mon, 10 Mar 2025 19:45:07 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: Re: [PATCH v4 00/36] Attack vector controls
Message-ID: <Z88zM52t8b1oSfr2@gmail.com>
References: <20250310164023.779191-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310164023.779191-1-david.kaplan@amd.com>


* David Kaplan <david.kaplan@amd.com> wrote:

> David Kaplan (36):
>   x86/bugs: Restructure mds mitigation
>   x86/bugs: Restructure taa mitigation
>   x86/bugs: Restructure mmio mitigation
>   x86/bugs: Restructure rfds mitigation
>   x86/bugs: Remove md_clear_*_mitigation()
>   x86/bugs: Restructure srbds mitigation
>   x86/bugs: Restructure gds mitigation
>   x86/bugs: Restructure spectre_v1 mitigation
>   x86/bugs: Only allow retbleed=stuff on Intel
>   x86/bugs: Restructure retbleed mitigation
>   x86/bugs: Restructure spectre_v2_user mitigation
>   x86/bugs: Restructure bhi mitigation
>   x86/bugs: Restructure spectre_v2 mitigation
>   x86/bugs: Restructure ssb mitigation
>   x86/bugs: Restructure l1tf mitigation
>   x86/bugs: Restructure srso mitigation
>   Documentation/x86: Document the new attack vector controls
>   cpu: Define attack vectors
>   x86/Kconfig: Arch attack vector support
>   x86/bugs: Determine relevant vulnerabilities based on attack vector
>     controls.
>   x86/bugs: Add attack vector controls for mds
>   x86/bugs: Add attack vector controls for taa
>   x86/bugs: Add attack vector controls for mmio
>   x86/bugs: Add attack vector controls for rfds
>   x86/bugs: Add attack vector controls for srbds
>   x86/bugs: Add attack vector controls for gds
>   x86/bugs: Add attack vector controls for spectre_v1
>   x86/bugs: Add attack vector controls for retbleed
>   x86/bugs: Add attack vector controls for spectre_v2_user
>   x86/bugs: Add attack vector controls for bhi
>   x86/bugs: Add attack vector controls for spectre_v2
>   x86/bugs: Add attack vector controls for l1tf
>   x86/bugs: Add attack vector controls for srso
>   x86/pti: Add attack vector controls for pti
>   x86/bugs: Print enabled attack vectors
>   cpu: Show attack vectors in sysfs

Just an overall meta comment: could you please capitalize all the 
acronyms properly and consistently in titles, changelogs and the code 
itself:

  s/mds
   /MDS

  s/srso
   /SRSO

etc. For single patches we maintainers will routinely fix such issues, 
but for a 36-patch series it's rather tedious ...

Also, please put no periods into titles, and titles should begin with a 
verb.

Thanks,

	Ingo

