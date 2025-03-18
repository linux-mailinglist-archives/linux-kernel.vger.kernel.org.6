Return-Path: <linux-kernel+bounces-567018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E518A67FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B393ABC97
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F091B20765F;
	Tue, 18 Mar 2025 22:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzvPDZdS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0CF2066D4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742337707; cv=none; b=e5z7Cf9mbxppaxkE81iYOJMv1+AQnjMmeUzmfsuuTDE85QTJg2R89iosYsHxCNmX35kcbj+s523ZjvrGtlH06DLyBPXHu/MOt8YQfllL4oZdC84QSDv9xkrqij8QCqEiIpZW0RQMrXziT1OsXpn3YNxzM7vQ10yexzIbxetSt+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742337707; c=relaxed/simple;
	bh=MlZnSdtmYtlbROC1AkQXerbxO3/nmB10SHRGM5Kp1PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrHVwwWqea1lPae5kh0fDxJNGmMpbzSZxSaIwWZCsOSNS2ziurRWoIxtMiPixlZ3EgTkCLpWrCqiUPuACvcwIaXLzuxzthHlUGGziV4mR2fBBV4sMQNaOHgl2OGVwUYh7h1At+TKltrHmEnJrw5qjxoj9u/EEvD+BUaU3ZiL17E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzvPDZdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E15C4CEDD;
	Tue, 18 Mar 2025 22:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742337705;
	bh=MlZnSdtmYtlbROC1AkQXerbxO3/nmB10SHRGM5Kp1PM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EzvPDZdSElDHFT8DaTJnJBTNqxnpm+MLnvx5+Txq0bJJMl/h5RzXnBm22UmnhBIdx
	 uIWXaWW//yYr7VzrSI3PDG8EJ906Q5FK7H76VquFBscNkbHa4DREWOj9luxXI9Mm77
	 /pae93lcO4FHRjlq5jlMvjF6/4Bz0Un38y4OjnqfVFu3y4/hIDbIV6GCxnebGdxTqN
	 rEnJYVNYrgMutoNWQJpoEJbhgEzImHOC2qiz0agZPLz1ytXdtICCbMqA25ZnjicvtD
	 mamEVXWjBnbU3u+Qb0uQDeee6dVWg3WKsg1JdLinmVGxgpAYrEC093LkGQZNh4YBq9
	 rbwbskpeXgXxg==
Date: Tue, 18 Mar 2025 15:41:43 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de
Subject: Re: [PATCH v7 8/8] [DO NOT MERGE] x86/kexec: Add CFI type
 information to relocate_kernel()
Message-ID: <orpk67p2yolcb4gi462wqwphaaio6ivny2gcfcw4jna3uyaak5@oty7arlxxykl>
References: <20250312144257.2348250-9-dwmw2@infradead.org>
 <ra6zlx2iz7eks3y4ymoi6mn7o6rvnjc3lnjoaadf3szaocbkae@yg2lyjzlnqdn>
 <c2471b0a81ebd183d32e76f995a70b7912c1d4a1.camel@infradead.org>
 <7tq4tti5pv7fjboiapuglkcsodl4nsk53rj36skg4xb2bkysei@ncoz2ztiddm7>
 <970a4932cb95bc8934dc2ad15e8e84a2a51d2232.camel@infradead.org>
 <wzc2owczflbhfho6xcgnl3mnrutdvmqz46xgo54g2ahorhpo5l@rykdsdkjw4fd>
 <6swzz4732x5kfeg3qsif2r5s5ado3nbweznm6alsxvniy4xq6a@z6foorhlhelj>
 <9c41ab61efc573e3ab5a75b6e4031f81db84a846.camel@infradead.org>
 <awucsfjn475mvwg7xhihexln2hfbtvrie2uv333u7awtkz4mrf@t57pi7jibytc>
 <e48391c54a4ba27795919099f8ea25c29d868000.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e48391c54a4ba27795919099f8ea25c29d868000.camel@infradead.org>

On Tue, Mar 18, 2025 at 09:06:58PM +0000, David Woodhouse wrote:
> On Tue, 2025-03-18 at 10:14 -0700, Josh Poimboeuf wrote:
> > On Tue, Mar 18, 2025 at 03:56:36PM +0000, David Woodhouse wrote:
> > > For the relocate_kernel() case I don't think we care much about the
> > > first. Without a CFI prologue, no *other* code can be tricked into
> > > calling relocate_kernel()
> > 
> > But for FineIBT the hash is checked on the callee side.  So it loses
> > FineIBT protection.
> 
> Right now the relocate_kernel() code doesn't even have an endbr, does
> it? So it isn't a useful gadget?

In that case wouldn't IBT explode when you indirect call it?  Or is IBT
getting disabled beforehand?

> > > — and besides, it's in the kernel's data
> > > section and isn't executable anyway until the kexec code copies it to a
> > > page that *is*.
> > 
> > Does the code get copied immediately before getting called, or can it be
> > initialized earlier during boot when kdump does its initial setup?
> 
> It's initialized earlier, in machine_kexec_prepare(), and then the page
> is set ROX.

If that happens during boot (like for kdump init) then it'll be in text
the whole time after boot, right?

-- 
Josh

