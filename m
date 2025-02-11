Return-Path: <linux-kernel+bounces-510193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAA7A31990
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB067167B98
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAC21F76C0;
	Tue, 11 Feb 2025 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFcAL+yN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A7527291F;
	Tue, 11 Feb 2025 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739316658; cv=none; b=umqhIlkhSoOU+eQ4z5B0BA34XEXGRcJ4ZKe2Fx/bg1JFwCCfgLGMHVDlF+YxyXM49FMyLN9DzoCwRPGioHoYS8PsquorRkBca0spxkDct9F49YfQdyzEPICInbsTtjxpTjXxSjbBBxGBnv4rQySC0/spucxJ+ye4fjdwcbrl8jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739316658; c=relaxed/simple;
	bh=NClWj+hoesfa5XuCbBYDAKUXJXVXFF21o0ZpYn2FjQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZpGg9bZIpehDfhrPHfAd2QeT8JA5DbEVkorQ4r/Qvu9rrrwI+RcUoraNNsKKtw7vw8LQxRgMWvUWyuEDO6aLR1o/upwsXbLpLN0EUiOJBIX6I2laeW2T3lTDDh8dOEADn7syXFJFmDRa7GbxuM2jFfnu1N8aw1li4ypKSxOTos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFcAL+yN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC51AC4CEDD;
	Tue, 11 Feb 2025 23:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739316657;
	bh=NClWj+hoesfa5XuCbBYDAKUXJXVXFF21o0ZpYn2FjQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFcAL+yNXznuxsj7iLlv0H1VTSeqTvbKk5iFryb9sKY5pB/PuVnp6b3jmd8soRAYe
	 GRj9G62yEpaDWWtSjdOP/NXlmMZ8M45PoqkoqupSvjRWyp5QgFKZPYM4yNAiEB0M/A
	 T5y4o1T++Kk+L04A5Mzyb0KEHw3M9UJ5m/YrJT0YD7QKlWbjTWw1/fIbEWnvoxPdWE
	 B3vWQGHu9r9c5PSEvwOmz+53pfd/bz1ahN3Stwf8fSRQjpKLk3GM2O4Nns8Hx2m3D6
	 FObZgpQQQBPlF+v5dh5/e64KEVVEe0kG1wP4WOvgEu3JkUNUom4B9q7x07nJAZRmTV
	 rbYWrebC38+HA==
Date: Tue, 11 Feb 2025 15:30:56 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/9] Add jump table support for objtool on LoongArch
Message-ID: <20250211233056.q47mp5askk7qrxcp@jpoimboe>
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
 <ef1e3e7c-0117-175c-5a85-091382696748@loongson.cn>
 <20250115013444.anzoct6gvs56m225@jpoimboe>
 <4612bfd8-442e-fecb-240f-46e735b48540@loongson.cn>
 <20250210212653.oidcl4aqyrcu3yzi@jpoimboe>
 <CAAhV-H7MVDj0CbXfwveb7GDn+D=O4N6oUT6rpGrbGmYPLPpRPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7MVDj0CbXfwveb7GDn+D=O4N6oUT6rpGrbGmYPLPpRPg@mail.gmail.com>

On Tue, Feb 11, 2025 at 07:59:57PM +0800, Huacai Chen wrote:
> Hi, Josh,
> 
> On Tue, Feb 11, 2025 at 5:26 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > On Mon, Feb 10, 2025 at 02:07:43PM +0800, Tiezhu Yang wrote:
> > > On 01/15/2025 09:34 AM, Josh Poimboeuf wrote:
> > > > On Sat, Jan 11, 2025 at 02:57:42PM +0800, Tiezhu Yang wrote:
> > > > > Hi Josh and Peter,
> > > > >
> > > > > On 12/17/2024 09:08 AM, Tiezhu Yang wrote:
> > > > > > This version is based on tip/tip.git objtool/core branch [1], add some weak
> > > > > > and arch-specific functions to make the generic code more readable, tested
> > > > > > with the latest upstream mainline Binutils, GCC and Clang.
> > > > >
> > > > > ...
> > > > >
> > > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=objtool/core
> > > > > >
> > > > > > Tiezhu Yang (9):
> > > > > >   objtool: Handle various symbol types of rodata
> > > > > >   objtool: Handle different entry size of rodata
> > > > > >   objtool: Handle PC relative relocation type
> > > > > >   objtool: Handle unreachable entry of rodata
> > > > > >   objtool/LoongArch: Add support for switch table
> > > > > >   objtool/LoongArch: Add support for goto table
> > > > > >   LoongArch: Enable jump table for objtool
> > > > > >   LoongArch: Convert unreachable() to BUG()
> > > > > >   drm/amd/display: Mark dc_fixpt_from_fraction() noinline
> > > > >
> > > > > Are you OK with the first 8 patches?
> > > > > What's the merge plan for this series?
> > > >
> > > > Sorry, my inbox is still reeling from the holidays.  I will review this
> > > > soon.
> > >
> > > What are the status of the first 8 patches?
> > > What is the next step? Is there anything else to be done here?
> > > I would really appreciate any advice on how to get this merged.
> >
> > Please post a new revision rebased on tip/master, with patch 4 dropped,
> > and I'll queue them up for -tip.  Thanks for your patience.
> You will queue the whole series, or the first 5 patches, or the first 3 patches?

The new series now has 7 patches:

Tiezhu Yang (7):
  objtool: Handle various symbol types of rodata
  objtool: Handle different entry size of rodata
  objtool: Handle PC relative relocation type
  objtool/LoongArch: Add support for switch table
  objtool/LoongArch: Add support for goto table
  LoongArch: Enable jump table for objtool
  LoongArch: Convert unreachable() to BUG()

I was planning on queueing all 7.

In particular, patch 6 should stay with the objtool patches since
they're directly related.

But I was also just going to grab 7 as well.

Please let me know if you disagree.

-- 
Josh

