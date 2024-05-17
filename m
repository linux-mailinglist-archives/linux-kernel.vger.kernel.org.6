Return-Path: <linux-kernel+bounces-182326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DD58C89B4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7455EB217FB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7DA12F5AC;
	Fri, 17 May 2024 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YdRKqHrb"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D0A12D20C
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715961566; cv=none; b=Sib7KbbBNApfJ/moPpiJ8oonC+QB+xEPXZ0GLyijamCLZUHbcqCBe9UV5yDD9KhpE62kO/FDDBcSsLo74/RtcJgMOKLqsO8HX/ArkOQksO6q1YR2gDvJLmMXZfXkcslyABl3fX7ozYOiVEZdi9bdGTpAhSfL8148mKiybiz0HiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715961566; c=relaxed/simple;
	bh=nZo1ezQwgzkz2ktTDyvZlEAx/7HJ9OOhGINJKIrvysc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+qf7H3dvIQNLrXwaqqOMAuw05iwBuM2Vt7juOxCmRG4Vf5om618AWLXS0Bkckb8HyP0WUZALD2f0F/rZv+TGLkCkP+sjQCNV5o4/Bq0S8GBkZPb+Qdgs9TYmTHJb3GG0IFXLxYYumeR6E+TN0Shzy/pNvuQIVJd6LppNtzZ6+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YdRKqHrb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3219440E023A;
	Fri, 17 May 2024 15:59:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0uFdlsZhgbxb; Fri, 17 May 2024 15:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715961558; bh=hOyx/EihvgqsW8aos4tSF8YAoqZcNUDe+O1fUCBVb5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YdRKqHrbxKQ3ln5ZlmKMzEP5uJLmDLNZQZxYa2USdLjBTxOw7rCSXctq0fx7/Dkyn
	 ZtwLXjftsqLqORPnoTwLAv0qXpuqKZUOU/xMVXbBhm8xMjqPeJRf8V1eVdMkoqeu2P
	 5Gq6JiapWoStnN0wgWrEH76ROZo1KVsqFrUFdy12L7joHph2nlmnnLFHUBhw4ECyhv
	 U8ySw9vW9timgUiubo5wIg2MS59hDvZTa+NQX5QkHZfYgpZjmfx1mbUvaJCJkhrJI+
	 GZD6nb3Khh/O8D32SnXFdmCvFAHFBmm2SrfII8gDOkMdJW/ofX7uxZHUCTrWERCR70
	 WXLtvsAyFaUTgDMKf8YNKCXbJThUfxiPqY8KTtpiv+D7UxgjtS6Qfqw0cypBME8wF0
	 hWmYEFgmPaQc7Wi7KDPb2EZ1KykkuLBaUKqBnfp9PvoXVMp0QRbfsmL3Js9lHHImmR
	 9EpG2PeeK7ydvISaBzwi1ez/ULmNvFGjbbc+fS0Xeum226ygXAFaFF7lMUlADTQX8S
	 CkkM4UzY6LnKF3Ib25SKLPoY45Pq57RCJooEZbovfmoiZ4F323Q4xMIAvVCIZQq45c
	 qoIds/N3YzfsJJJFp1WSzl4R8leDxeOYbgEd/t8rroVVGA0EMSLQ/XUXWXWyTurIkT
	 SeuyUn9uOJ7XClGWXKvAQkYA=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D547A40E01E8;
	Fri, 17 May 2024 15:59:03 +0000 (UTC)
Date: Fri, 17 May 2024 17:58:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v4 04/15] x86/sev: Check for the presence of an SVSM in
 the SNP Secrets page
Message-ID: <20240517155858.GDZkd-wkWmYegos-eT@fat_crate.local>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <6cf54cac47f212f4c2b59b123855d8c183989022.1713974291.git.thomas.lendacky@amd.com>
 <20240502093520.GRZjNeWLXU5j2UMOAM@fat_crate.local>
 <66928741-aa5c-4bbb-9155-dc3a0609c50a@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66928741-aa5c-4bbb-9155-dc3a0609c50a@amd.com>

On Thu, May 02, 2024 at 10:29:02AM -0500, Tom Lendacky wrote:
> PAGE_ALIGNED and IS_ALIGNED are from two separate header files (mm.h and
> align.h) which seems like a lot of extra changes for just one check.

No, pls put them in a single shared/mm.h header. And no, those are not
a lot of extra changes - those are changes which are moving the code in
the right direction and we do them sooner rather than later, otherwise
they'd pile up and we'll never be able to find time to do them - sev.c
movement attempt case-in-point.

> Not sure I agree. I'd prefer to keep the comment here because it is
> specific to this rmpadjust() call. See below.

Just don't replicate some versions of the same comment all over the
place. Do one big comment which explains which RMPADJUST has to do with
VMPL levels - perhaps over the insn - and then refer to it from the
other places after adding the specific explanations for them.

> Right. Not sure about the "cannot", more like "must not." The specification
> states that the guest should run at a VMPL other than 0. If an SVSM starts
> the guest at VMPL0, then the SVSM would not be protected from guest.

Yeah, well, you do terminate the guest if it is running at VMPL 0 *in*
the presence of a SVSM so it is a "must not". Ok.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

