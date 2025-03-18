Return-Path: <linux-kernel+bounces-566613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AA2A67A86
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD6D188ED93
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C1E2116E7;
	Tue, 18 Mar 2025 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZy1bBNE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AAC1991C9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318072; cv=none; b=O9t5y5UF++jdWQJPL42+aYHTLgjK4dN5ql/Z1h9kPuTKsm5MDqJG4J3PkbMNG+GTbsqXQCwvYZ72sU/KBlFcA9OkaIajn6Nt+UDf+LVjpip4wtwsA/3k+SOd3mwk7wyB8Ro2Ofg7zZeag1E489VWgU4l/IUgGMCaniooryHRrfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318072; c=relaxed/simple;
	bh=FdmeE5UpNTG7ZD9/uFOLcJYqB/eNRc5dbBERnws9X0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ha/Pw4akS5a4CByTna9Ae1ypLz8ErmgYfcGhQgin0an7f96HYQCHAG1eLFiCsrhLp5LPBCdi3Z1AhaHggf5eCVA61pMYFNcc+0y8yflgMKo+bIseruYyM9VcBdBt2y+7dpUgMfU2e58hWCxcsWVC7kUQpU0+Pn0j4pKoKx2zWPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZy1bBNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8E9C4CEE3;
	Tue, 18 Mar 2025 17:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318072;
	bh=FdmeE5UpNTG7ZD9/uFOLcJYqB/eNRc5dbBERnws9X0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KZy1bBNEehY+76p+JpVHAWgQfv6e31/k/jm8FqzUbSiA5prxPX0aTI02U1HVmU5iW
	 rXuRDwcXhLhmj3JvhJzuIze4DAixbJOzn0AMYE3G0JivOmqST+bYtjeRpKpd5CEUjT
	 4thVUCZz2Jxdd+Pyhil2NuExioXt1zAC7MYgxMLj8Q9oMHoI4BjvpauUhWPL51EotK
	 +uwzBR1M7Ntn/FbaRAMreXrkscnUsFc5rMlFYrQPEqmLyp38ZCi/8mtZx0HbJ1ngma
	 FWZHvCX3UYLZcJk33r+qLYm64LsLGDdtB66OASQJ0wAkv8lhPLe9ck0G8XYhBvh+2g
	 VezSPuCoxwsiw==
Date: Tue, 18 Mar 2025 10:14:29 -0700
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
Message-ID: <awucsfjn475mvwg7xhihexln2hfbtvrie2uv333u7awtkz4mrf@t57pi7jibytc>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
 <20250312144257.2348250-9-dwmw2@infradead.org>
 <ra6zlx2iz7eks3y4ymoi6mn7o6rvnjc3lnjoaadf3szaocbkae@yg2lyjzlnqdn>
 <c2471b0a81ebd183d32e76f995a70b7912c1d4a1.camel@infradead.org>
 <7tq4tti5pv7fjboiapuglkcsodl4nsk53rj36skg4xb2bkysei@ncoz2ztiddm7>
 <970a4932cb95bc8934dc2ad15e8e84a2a51d2232.camel@infradead.org>
 <wzc2owczflbhfho6xcgnl3mnrutdvmqz46xgo54g2ahorhpo5l@rykdsdkjw4fd>
 <6swzz4732x5kfeg3qsif2r5s5ado3nbweznm6alsxvniy4xq6a@z6foorhlhelj>
 <9c41ab61efc573e3ab5a75b6e4031f81db84a846.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c41ab61efc573e3ab5a75b6e4031f81db84a846.camel@infradead.org>

On Tue, Mar 18, 2025 at 03:56:36PM +0000, David Woodhouse wrote:
> But on the whole, I'm not sure the CFI check is worth it.
> 
> CFI checks that the caller and callee agree about the prototype of the
> function being called. There are two main benefits of this:
> 
>  • to protect against attacks where function pointers are substituted
>    for gadgets.
> 
>  • to protect against genuine bugs, where the caller and the callee
>    disagree about the function arguments.

AFAIK the first one is the main point of CFI.

> For the relocate_kernel() case I don't think we care much about the
> first. Without a CFI prologue, no *other* code can be tricked into
> calling relocate_kernel()

But for FineIBT the hash is checked on the callee side.  So it loses
FineIBT protection.

> — and besides, it's in the kernel's data
> section and isn't executable anyway until the kexec code copies it to a
> page that *is*.

Does the code get copied immediately before getting called, or can it be
initialized earlier during boot when kdump does its initial setup?

-- 
Josh

