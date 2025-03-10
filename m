Return-Path: <linux-kernel+bounces-555068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D4BA5A52A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C803AD383
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7551DEFD4;
	Mon, 10 Mar 2025 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFp2fjwl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A7D17BA5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639327; cv=none; b=kTpgkegWF9aJ41bN4CQbfl3I+J5RIoW6TmQpmwtpZMC9ZxjE0gnExPTw9xDX4/8i0IUsx9/cj7vy/36RLmx+JF7Du3H9IJSN9kZP/GI5VPiAYuyIhukl1E0tdm1lu7KAoezQuiFq/2pQJ6/qrtImHQuwlGsnRcAJOIg4URckmUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639327; c=relaxed/simple;
	bh=z7Qh6hatydvwGrHSzsuo8r/QUB8upnDv8OgSuNImcRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnMJ31VskHCmk+FXKU3a2Y1dvPqG1jdSj9owV/05VnKyIzFvwVCkSdUh+eGFgPyFec5frwEx3hp42KDfDkAOspJl7yYjl8IOD9kS1Mahpy5Ayf3E9f+kCay4elDXYQc10ntChPkgfCQixvBDNUFXBGIoyLnSLnyNbmHU0Ayki/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFp2fjwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E629C4CEE5;
	Mon, 10 Mar 2025 20:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741639326;
	bh=z7Qh6hatydvwGrHSzsuo8r/QUB8upnDv8OgSuNImcRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFp2fjwluFjPWlldVEH4DW1ukwuVQE79XEgX2qtecRDy/l7Xf2cgZ8q5H0y9NolPW
	 V3XJ/G5Wi3rDsZ0SfvFGbLCyykaWpEW8qMgSPCu/ZDLbsHUoLxIH7AKy9WJ4LFtW3S
	 HxzoLptRpoH5ZU7T07/51D4C2Bw+LZ7bgl3s3scWx/mME1WXQNFZJmxk7OXaG5NrtM
	 iOZCFtiWeW/pxmYkgfbDgks/cwvORZ661ilYJqmc/0RdCn/bSECDzhmZo73dehyv4T
	 BzIguU211dUv5WBgDl/3cFvwgF8IAqMNT+er8Xgo42tEr1Qw4MXqWy9ZBkVIk7fHzH
	 7pI3h+NTo5F+g==
Date: Mon, 10 Mar 2025 21:42:01 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/hweight: Fix and improve __arch_hweight{32,64}()
 assembly
Message-ID: <Z89OmbYzIE2xyAD4@gmail.com>
References: <20250310200817.33581-1-ubizjak@gmail.com>
 <20250310201227.GXZ89Hq5LVWKHjHBeO@fat_crate.local>
 <CAFULd4ZCc08kJU+3ZVdyWhO4s5fu0Y-RDPS-Y-_sPB1R0KrnoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4ZCc08kJU+3ZVdyWhO4s5fu0Y-RDPS-Y-_sPB1R0KrnoA@mail.gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> On Mon, Mar 10, 2025 at 9:12 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Mon, Mar 10, 2025 at 09:08:04PM +0100, Uros Bizjak wrote:
> > > a) Use ASM_CALL_CONSTRAINT to prevent inline asm that includes call
> > > instruction from being scheduled before the frame pointer gets set
> > > up by the containing function, causing objtool to print a "call
> > > without frame pointer save/setup" warning.
> >
> > The other two are ok but this is new. How do you trigger this? I've never seen
> > it in my randconfig builds...
> 
> It is not triggered now, but without this constraint, nothing prevents
> the compiler from scheduling the insn in front of frame creation.

Please add:

 'Current versions of compilers don't seem to trigger this condition,
  but without this constraint there's nothing to prevent the compiler
  from scheduling the insn in front of frame creation.'

Thanks,

	Ingo

