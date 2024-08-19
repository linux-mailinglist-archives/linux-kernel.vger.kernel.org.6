Return-Path: <linux-kernel+bounces-292007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DC6956A03
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0BC81F245B6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC66516727B;
	Mon, 19 Aug 2024 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5Ka342Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE74169397;
	Mon, 19 Aug 2024 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068573; cv=none; b=S2UTLngYRR00208W/rzBV/t8aKqbDl9mnV/+BvxVwuGPJ5JJL3TxzDXXYLZiSs1nPzzYIFW75D6qiuVmB4podHGIMFuWFjBMT688jd1D0bm5MiZi7sOivLhjTyAESpTj68eSFPLxqpZEaAtfWp4GhRPV0Yn7UaxFmP6zfPFGYBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068573; c=relaxed/simple;
	bh=0+bJyI2if9hUxromHqaWXaxVsRw9UqVdM4W1z9O0p2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwyqMPB+QQmpw5j4ytiG6IQCTlVswwAPgekHEOcinu15IhYHhJeYW37nW49+rP1lMNvZB9RKU/3O5vvmS/ffE8DEtA+K4PYBTUIgxguU1C7vXZv25nh+LCoBInFQHD7roCXgmhwIRkawqC7NDvNbCmg/rnK5/oGhx32us3DuMwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5Ka342Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79678C4AF12;
	Mon, 19 Aug 2024 11:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724068572;
	bh=0+bJyI2if9hUxromHqaWXaxVsRw9UqVdM4W1z9O0p2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5Ka342QT7MMFT4VHoBHGw2KWzngs3FNWUZk+HXO0tvSAyzJMFFTLpuoZPutMbJbY
	 c08jHOTRsHoplL7lFrEGYK4qsdkYQdHtjg5ELr5mQ9CSkn9BY8Xm+z1svEsInJSQtj
	 wIb3U0nNO6zIpX0r7A7VW9Zrwrf2esv4cij/x1OMLDffNEEi8re1eWVZlJHgs6pez/
	 sejV8VTMMX0jILhtodz5igEst7P3uFDixIt96KzbMzE3xurBohAOuf2D4TywF09R7k
	 HBayOgYH7rqj4nM1hh+ixqEmJ3ferxFzh4h7MuptqQVUN3QvP8tiHuNYwRRFvAlaAK
	 kl35CkvuYpVww==
Date: Mon, 19 Aug 2024 13:56:05 +0200
From: Alexey Gladkov <legion@kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuan Yao <yuan.yao@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Nikunj A Dadhania <nikunj@amd.com>, cho@microsoft.com,
	decui@microsoft.com, John.Starks@microsoft.com
Subject: Re: [PATCH v3 04/10] x86/insn: Read and decode insn without crossing
 the page boundary
Message-ID: <ZsMy1YaHI4gaN703@example.org>
References: <cover.1722862355.git.legion@kernel.org>
 <cover.1723807851.git.legion@kernel.org>
 <9704da6a35d62932d464d33b39953fc5b2fd74ea.1723807851.git.legion@kernel.org>
 <3xcmaxmpoemmotdqhtr5fu52wyssixyvnmirqbbnvhwpcuss5z@sayg725h5wcz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3xcmaxmpoemmotdqhtr5fu52wyssixyvnmirqbbnvhwpcuss5z@sayg725h5wcz>

On Mon, Aug 19, 2024 at 01:48:11PM +0300, Kirill A. Shutemov wrote:
> On Fri, Aug 16, 2024 at 03:43:54PM +0200, Alexey Gladkov wrote:
> > From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> > 
> > In case the instruction is close to the page boundary, reading
> > MAX_INSN_SIZE may cross the page boundary. The second page might be
> > from a different VMA and reading can have side effects.
> > 
> > The problem is that the actual size of the instruction is not known.
> > 
> > The solution might be to try read the data to the end of the page and
> > try parse it in the hope that the instruction is smaller than the
> > maximum buffer size.
> > 
> > Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
> 
> I think this and 3 next patches do not belong to this patchset. They
> address separate issue that is orthogonal to the patchset goal.

Should I drop them from this patchset and send them after this patchset as
a separate change ?

-- 
Rgrds, legion


