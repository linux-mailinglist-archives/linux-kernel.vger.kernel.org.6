Return-Path: <linux-kernel+bounces-561920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C461A6189C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920E33B1242
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095F62040B5;
	Fri, 14 Mar 2025 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POkAVb8U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BF9202C48
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974776; cv=none; b=U/Nz55nr9sWtXu8UrVfnzIBTly35rARunx1Ox0AUEx70mh4Zb+wvuGIWxLsvhEEX5IRm5WspQ/6AH8S5sHPsNKN3suIITZ6EWoQBk55QTQ55h5IgB1Z1ydUIyo4jQNsCveaQZTH8pGKg+dSHye0r2G5BHOdo3VPZvtrJBYHPwJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974776; c=relaxed/simple;
	bh=5g8HVlEZNBZf95r55n45O6hgoNz0UUSUIU9ZhFx25DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnQoTZLtBQz2R40HHPlkCIhm8gMEgI1HVzj9hsjmhf6qZNta1falF2w3V9KRtiuYDRECFbxhWIpBedIgVFS+6k6Xwm0K2Gyg2JrEsHHcNF1UieSKH9Qd/zy8K3EimU3A7wzf0VvG5ps0b23vurV6sxpP+wk09r8PSZ3xa3uuo+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POkAVb8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66CCC4CEE3;
	Fri, 14 Mar 2025 17:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741974775;
	bh=5g8HVlEZNBZf95r55n45O6hgoNz0UUSUIU9ZhFx25DE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=POkAVb8U62Loy7N6T3lCrkfQxTNhGrLfAYVnSbSFHz08vRAvlkHmDn9omL1T5YJvw
	 +2vIlLjsYRmWUSkDlp6fp9Dlt7NfkXa427L3Es/QFetlbitu1S5szwcdiPabQh7z6T
	 PW3R9G82ujHmdQVnzmaghWjhTMXHEan9tiVw22XfUgTx7rrPN76OcEVNPgzphhYnzv
	 WwJVdI5Be4C7qUVXbec7o0BLkmXNTPvpIUwEr/P850OSWxkzwqXuv+JMAmdCouZfqj
	 QyN4RCyRuwHV+nX85g+J9lu/M9NCywGo2+tc+wAc7BdRdTWoP46HmC0tSQygh+OEMJ
	 X70Yxoo33CArw==
Date: Fri, 14 Mar 2025 10:52:53 -0700
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
Message-ID: <7tq4tti5pv7fjboiapuglkcsodl4nsk53rj36skg4xb2bkysei@ncoz2ztiddm7>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
 <20250312144257.2348250-9-dwmw2@infradead.org>
 <ra6zlx2iz7eks3y4ymoi6mn7o6rvnjc3lnjoaadf3szaocbkae@yg2lyjzlnqdn>
 <c2471b0a81ebd183d32e76f995a70b7912c1d4a1.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2471b0a81ebd183d32e76f995a70b7912c1d4a1.camel@infradead.org>

On Fri, Mar 14, 2025 at 05:23:15PM +0000, David Woodhouse wrote:
> ISTR this version is OK with Clang and CONFIG_CFI_CLANG but with GCC I
> get this:
> 
> vmlinux.o: warning: objtool: relocate_kernel+0x69: unsupported stack register modification
> 
>         /* setup a new stack at the end of the physical control page */
>         lea     PAGE_SIZE(%rsi), %rsp
>   79:   48 8d a6 00 10 00 00    lea    0x1000(%rsi),%rsp
> 
> 
> Maybe the answer is to put the UNWIND_HINT_FUNC into #ifdef
> CONFIG_CFI_CLANG but that seems wrong.

The UNWIND_HINT_FUNC definitely looks wrong, why would Clang need it?

> I'll have another look at putting it in the data section, and see if I
> can remember why I didn't want to do that before (and if that's still
> relevant now).

IIRC, the reasons were the patched alternative, and also you wanted to
disassemble (but note that's still possible with gdb).

Here was a patch to make it work:

  https://lore.kernel.org/20241218212326.44qff3i5n6cxuu5d@jpoimboe

-- 
Josh

