Return-Path: <linux-kernel+bounces-518326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C04A38D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E97F7A2C03
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED4C238D3B;
	Mon, 17 Feb 2025 20:29:46 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0861C18C907
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 20:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739824186; cv=none; b=J0wqjxZzPAzWshVDTnpxhUY/l9qX0Ef7ZInPVTuI0ePZykNOYR1aCGIgGal4Gg5BUA6nVH3BwtOAYmd2ixhwNWwNG9KrPDc5WJPFOwmjbAfxbDp/q+FmNIBm7owTGOocx0DxqzUi5bnOlDqe4IM0uEW56S8a5kj/y0iy5S6ZQb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739824186; c=relaxed/simple;
	bh=7/tkDJZ9ZybcmZHWmM5zv/YdxlQUxK7ZO5bAtX5158I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ln9vzBXBPjqRP2p0pKJYBeNd47lSwD3Gfp3or2Xv6tDJ0NfvKLVixwbHbTjgRScMzAlRYcpxvZ81l71YATRqAF1WVLJxMPJ9h/5V2r2//ZnylwZvwgpy1xii8/L4pejV+FPPnE7rHyAxfaQIPHIf6xf3oEPPH+vRsyMYL+5mH+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B824C4CED1;
	Mon, 17 Feb 2025 20:29:45 +0000 (UTC)
Date: Mon, 17 Feb 2025 12:29:43 -0800
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2] compiler: remove __ADDRESSABLE_ASM{_STR,}() again
Message-ID: <20250217202943.p57k76tpwpx7aw6q@jpoimboe>
References: <945716d2-4dd4-4d38-b732-41ab8b27c5ee@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <945716d2-4dd4-4d38-b732-41ab8b27c5ee@suse.com>

On Mon, Feb 17, 2025 at 05:40:09PM +0100, Jan Beulich wrote:
> __ADDRESSABLE_ASM_STR() is where the necessary stringification happens.
> As long as "sym" doesn't contain any odd characters, no quoting is
> required for its use with .quad / .long. In fact the quotation gets in
> the way with gas 2.25; it's only from 2.26 onwards that quoted symbols
> are half-way properly supported.
> 
> However, assembly being different from C anyway, drop
> __ADDRESSABLE_ASM_STR() and its helper macro altogether. A simple
> .global directive will suffice to get the symbol "declared", i.e. into
> the symbol table. While there also stop open-coding STATIC_CALL_TRAMP()
> and STATIC_CALL_KEY().
> 
> Fixes: 0ef8047b737d ("x86/static-call: provide a way to do very early static-call updates")
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Cc: stable@vger.kernel.org
> ---
> v2: Drop constructs instead of fixing them. Use STATIC_CALL_KEY().
> ---
> Whether the "ADDRESSABLE" in __ADDRESSABLE_xen_hypercall is still
> meaningful to keep I'm uncertain about. The situation, as said, is quite
> different in assembly, compared to C's requirements.

The .global still makes it "addressable", so IMO it's named
appropriately.

Thanks!

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

