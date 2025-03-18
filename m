Return-Path: <linux-kernel+bounces-566983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCBDA67F55
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE499167F81
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA812066DD;
	Tue, 18 Mar 2025 22:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1kkpYDG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABAC2063EB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335667; cv=none; b=PrQJkTwh2KPeMsn0kAg2Nk6PjCfcVgUW3le6YGa29Wq40ns5snFnkTkAq7qsLkyoch7uXoTfkgf+bgsBp7dclfHGD/WkaFXIr/VxM56IQXgdzbDMnCe8dSOrosfuC8RZF2bWL5PrfStLqfeQHuHLVU9nOwj8/sP9mw4zUb6oOVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335667; c=relaxed/simple;
	bh=eQZsm1l3fF/gIv7zUS6r3BXlBNxNs9du/5xrzEX6534=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B38CCSDcRSQUlfaYv3KkQs2bf9NviGmiAl3Kd8n5FXCFtTMEmLyexXpRke6jazX0iWx4uAfmvuzADc+bBAJoT/o5xHQKNQYqrMbvpoZVCW7Bsxz//lmoMZJ42y9I6Na/jeMnYi6OsmUTzXSTmr+4UnUf9pyVSpc3HlgEgGCgMEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1kkpYDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF2FC4CEDD;
	Tue, 18 Mar 2025 22:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742335665;
	bh=eQZsm1l3fF/gIv7zUS6r3BXlBNxNs9du/5xrzEX6534=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g1kkpYDG+ScJPxsTmMJbZ7XssCBW3RhKTEHx+Z76a4dYE44G7Nv32uZDNPjcSZ1vt
	 wWckBKIX41wguqzj/VASKskm/QIh7mc6IskQWSIiJRBpXKtc8rDIL0tyvYmXxRDoOx
	 2p0leoXAdz7g4ZbiKZzi65vQrPDHVhZEY+d3zc/uwvlZGq0H2LKUZxH+CInasmEp6X
	 JET2H+rJ7AtvbkzCZda6csm5Am1Z8DDOf2ywcUDcgKWMa99oB8/vpqayyoymdBGYsm
	 NiEf63Czg8DPAT2uch09epHRBNaGQKxs2xxA2sSouKrTY763U2zT3iMJOUQiIovq63
	 KcK+ng7VqVsEQ==
Date: Tue, 18 Mar 2025 15:07:42 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, "Ahmed S . Darwish" <darwi@linutronix.de>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, John Ogness <john.ogness@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH] compiler/gcc: Make asm() templates asm __inline__() by
 default
Message-ID: <5if6tsm26vyprchmx2ohki2hkzwur2skjykvqitazvqdlovdua@kouzjteilzsf>
References: <20250317221824.3738853-1-mingo@kernel.org>
 <5A417EE0-8DF3-4C6E-A7E9-9EE6705282F1@zytor.com>
 <Z9m1rtmlk1PxGIQA@gmail.com>
 <CAHk-=whAUHyXM29_9w_T26=15D1KZnuR3R+f4MT9f-C89oukvA@mail.gmail.com>
 <Z9m_kUqxqMPfU8Fl@gmail.com>
 <Z9nTfFiPv0-Lxm-_@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9nTfFiPv0-Lxm-_@gmail.com>


On Tue, Mar 18, 2025 at 09:11:40PM +0100, Ingo Molnar wrote:
>  #ifdef CONFIG_CC_HAS_ASM_INLINE
>  # define asm_inline __asm__ __inline
>  # define asm(...) asm_inline(__VA_ARGS__)
>  #else
>  # define asm_inline asm
>  #endif

Nice, I'd been wanting to do that for a while.

> And I fixed up the places where this isn't syntactically correct:
> 
>  35 files changed, 82 insertions(+), 79 deletions(-)
> 
> I haven't looked at code generation much yet, but text size changes are 
> minimal:
> 
>       text	   data	    bss	     dec	    hex	filename
>   29429076	7931870	1401196	38762142	24f769e	vmlinux.before
>   29429631	7931870	1401200	38762701	24f78cd	vmlinux.after
> 
> Which is promising, assuming I haven't messed up anywhere.

Unfortunately "size" can be misleading:

  - Inexplicably, "text" includes a lot of non-executable sections, many
    of which have sizes which are directly affected by actual .text
    changes.

  - CONFIG_MITIGATION_SRSO adds ~2MB padding between entry code and the
    rest of the runtime text, though this is not much of a concern for
    comparing apples to apples as it only hides the size of the entry
    text which is tiny.

This was discussed before (and yes "objtool size" would be nice
someday).

  https://lore.kernel.org/20231012013507.jrqnm35p7az6atov@treble

I think this should work decently enough:

  $ readelf -WS vmlinux | grep " .text" | sed 's/\[ //' | awk '{printf("0x%s\n", $6)}'
  0x5588b08

-- 
Josh

