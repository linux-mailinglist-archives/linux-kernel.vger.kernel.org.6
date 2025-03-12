Return-Path: <linux-kernel+bounces-557684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0A2A5DC65
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0390B7A27A8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1A5237172;
	Wed, 12 Mar 2025 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0VIEs6N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9981A1917F4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781780; cv=none; b=MV+HX+BColTp++04ba5vYvisO6WPVzDgvKySi8ndd5SI8mTY4N8bBAS067DKYkkIpGHTNc32ZmeaPwk0ic7r1K9TRvnjfBZZFgn9UR6UdQe1HnxbcCVSkbWKOhotmBKtt2zNXYAzO65faP5y6N2CPBxsE0u9P00/Y3N0LjZiv/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781780; c=relaxed/simple;
	bh=WP7W8TkyxSjYpb9S53qQy6XokTru+8sCcVwWi0oGSEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Li7gO0SeVCyYShRytuNRKHPfTEcftNQTu5+HCkNZ/YjFHQG/PzfljcPmAo3iBetywC6XP2wM9zpEmQrTevT/vlwdS85bYn5aNF9BulNd/t8kCueyfYNMf8rc+vSSDr6t212hySnWKOzD/tiK6Hh75ls//nzATtFzgqrz4WGf5BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0VIEs6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C18C4CEE3;
	Wed, 12 Mar 2025 12:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741781779;
	bh=WP7W8TkyxSjYpb9S53qQy6XokTru+8sCcVwWi0oGSEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B0VIEs6NRgNO7pWMqwILX1l58PzZUe9WAkvDpqxFpdKvBarbDVd9ZP8Vvgr4jvLas
	 yQ/AzO2syflyvkJnIvNZr7elI0PL7KuIt9vy1e3rwPdg9H8fBOYuDgNSZEYLxvWatR
	 vUp2B7mauweEO5ok0htEWMvO/B2M/IyL5vchfrNB86UOnmyNtxLeb7q8foAKHcLxbd
	 bv9w1XI71jC+SKw6rgXpJ+nFC28mLELe6NpVN4lPox88UjtMm9H8fZwJbdXvCn0+Gl
	 /BGq7wuudLzG5N3GsyjOJQgRCQcck6sUDXCcUM4LIBPY/+Dvbpzs9YiLqVxN0eiz36
	 OFi1MP/FQ3H8Q==
Date: Wed, 12 Mar 2025 13:16:14 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2] x86/hweight: Fix and improve __arch_hweight{32,64}()
 assembly
Message-ID: <Z9F7DoCQsIcf7MLe@gmail.com>
References: <20250311150745.4492-1-ubizjak@gmail.com>
 <Z9F5h7cEiV55dWMB@gmail.com>
 <CAFULd4bir3v7heqdUtPEFGEY66SwqxNkmRXy=uhB_3popS3zDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4bir3v7heqdUtPEFGEY66SwqxNkmRXy=uhB_3popS3zDQ@mail.gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> On Wed, Mar 12, 2025 at 1:09 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > > a) Use ASM_CALL_CONSTRAINT to prevent inline asm that includes call
> > > instruction from being scheduled before the frame pointer gets set
> > > up by the containing function. This unconstrained scheduling might
> > > cause objtool to print a "call without frame pointer save/setup"
> > > warning. Current versions of compilers don't seem to trigger this
> > > condition, but without this constraint there's nothing to prevent
> > > the compiler from scheduling the insn in front of frame creation.
> > >
> > > b) Use asm_inline to instruct the compiler that the size of asm()
> > > is the minimum size of one instruction, ignoring how many instructions
> > > the compiler thinks it is. ALTERNATIVE macro that expands to several
> > > pseudo directives causes instruction length estimate to count
> > > more than 20 instructions.
> > >
> > > c) Use named operands in inline asm.
> >
> > I think this should be a 3-patch series. While it all modifies the same
> > code, each change could introduce separate issues, so it's better to be
> > individually bisectable IMO ...
> 
> Ok, will split and send separate series.

Thanks!

	Ingo

