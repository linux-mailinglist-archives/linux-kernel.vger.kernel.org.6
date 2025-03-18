Return-Path: <linux-kernel+bounces-565220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9168A6639E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C22117904D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45918C2EF;
	Tue, 18 Mar 2025 00:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fux+aLOT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4649C2C8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257452; cv=none; b=u34k6hiz9YiiFLp2xq76ojDOKEgtvAZOjIxV2OwoZlUsxMxZDRD+Cqkltw3KOPL+0qMrACQAf/APbLv6wMzjuIWpyv8s+lngTZUP1f5L1SVbeUGwTILrkoVT6mmGMk0cHE82FoU9gEib5qhfqvbaKAa0hAsp8zApUuOLGIY3Qk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257452; c=relaxed/simple;
	bh=ig9ih0A11KohCT91l/yVMWlq4EmXyFnYoyq69nfYDl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lh3/boHYQs4dgm8eK/pnJfo5SKxdhrDySYQ6/PVgn0IievOFGFsLg9jthJs1U7+h/tI+7wOf+O6nb7fGWCwtJqUBf8WKRzP24yE18LtMR3iHteaDUAKdq1Ea/6QhB0XESzOt3RTFW0w5juT23hwRbY9a1OMS3oOp5X13wOp954g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fux+aLOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEA3C4CEE3;
	Tue, 18 Mar 2025 00:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742257452;
	bh=ig9ih0A11KohCT91l/yVMWlq4EmXyFnYoyq69nfYDl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fux+aLOT/wJw4GJHH1d2iSwMLHDlXGeKF2TA8+UZeIRyLosEB+8mSymv5GMzid6Dw
	 QyXNCsl1tE5E8z+hPVlEYtpCCh7yhDkeGo86nHD0aHx+CBpLxtH5FRze2RLekk+RRQ
	 5x3AA5h8q2/8W6pGx7FW2a17WbfHZVFeNwec2+dSSBgbsgheLqy43ytIlT2RQB86rj
	 BBCCqLfpz9lPlxSf4GKmJypBb1Cykm/xXXYh/AcUBO3QtwVfT8rvB9VkGhViIakhuE
	 nOcIEITcmrROaB5tuVCPONdTfmMrr0zYEhBiJ+qnJP668pGKuSlhmeL+RgJZs99vK/
	 iIUAT8tpr93Xg==
Date: Mon, 17 Mar 2025 17:24:09 -0700
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
Message-ID: <6swzz4732x5kfeg3qsif2r5s5ado3nbweznm6alsxvniy4xq6a@z6foorhlhelj>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
 <20250312144257.2348250-9-dwmw2@infradead.org>
 <ra6zlx2iz7eks3y4ymoi6mn7o6rvnjc3lnjoaadf3szaocbkae@yg2lyjzlnqdn>
 <c2471b0a81ebd183d32e76f995a70b7912c1d4a1.camel@infradead.org>
 <7tq4tti5pv7fjboiapuglkcsodl4nsk53rj36skg4xb2bkysei@ncoz2ztiddm7>
 <970a4932cb95bc8934dc2ad15e8e84a2a51d2232.camel@infradead.org>
 <wzc2owczflbhfho6xcgnl3mnrutdvmqz46xgo54g2ahorhpo5l@rykdsdkjw4fd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <wzc2owczflbhfho6xcgnl3mnrutdvmqz46xgo54g2ahorhpo5l@rykdsdkjw4fd>

On Mon, Mar 17, 2025 at 05:17:24PM -0700, Josh Poimboeuf wrote:
> On Mon, Mar 17, 2025 at 12:40:14PM +0000, David Woodhouse wrote:
> > On Fri, 2025-03-14 at 10:52 -0700, Josh Poimboeuf wrote:
> > > 
> > > IIRC, the reasons were the patched alternative, and also you wanted to
> > > disassemble (but note that's still possible with gdb).
> > 
> > It's meaningful output from 'objdump -S' that I miss. But OK.
> 
> FYI, this works:
> 
>   objdump -Srw -j .data..relocate_kernel vmlinux.o

... but I see now that it doesn't intersperse the source.  Never mind...

-- 
Josh

