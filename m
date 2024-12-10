Return-Path: <linux-kernel+bounces-439456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AD99EAF95
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A657188C34B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC6D212D99;
	Tue, 10 Dec 2024 11:11:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AB2212D9C;
	Tue, 10 Dec 2024 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829111; cv=none; b=u7bc5LbCOW1qWPcjHDANJVSx8EQxkIqH8YJWK8m4nFqGYP1gs1YvAEOmPtXFaNgbcnpnzTHdsrTvQc4uX5gqDe0b4sOsd7kt2pzattcR4xYoAvzunYu9aTCyJMIB1zmMJSbM5/wUKPcLywbuXod5vBHltuk3cb6rt8wcp9VPNcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829111; c=relaxed/simple;
	bh=tpSmYyqjcqV4Zvsd/DrO5YNisxgIYx7Wfs8XYoCMSFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIBLGn2P42GUJ5YXjbJaQPasJkR4pMaea6DRnJNlJk19NpQSJEuVaImIocUHzKmmEmCAd7XgkR6olv5vR1WncsphuH0EnEr7+vXl2wwpRBWSoT/GNvNFBlUCTD/cWadVEyY/TZy+uCbOXZcwLOLyZPZrVfn7YvyXtnuFGKsC8Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD33DC4CED6;
	Tue, 10 Dec 2024 11:11:49 +0000 (UTC)
Date: Tue, 10 Dec 2024 11:11:47 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Subject: Re: arch/arm64/kernel/signal.c:1046:36: sparse: sparse: cast removes
 address space '__user' of expression
Message-ID: <Z1gh809HUGRZI258@arm.com>
References: <202412082005.OBJ0BbWs-lkp@intel.com>
 <Z1cOs2sGff1_TtQZ@arm.com>
 <c8379d04-420b-4039-99ce-5a462d820685@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8379d04-420b-4039-99ce-5a462d820685@sirena.org.uk>

On Mon, Dec 09, 2024 at 04:11:00PM +0000, Mark Brown wrote:
> On Mon, Dec 09, 2024 at 03:37:23PM +0000, Catalin Marinas wrote:
> > On Mon, Dec 09, 2024 at 12:47:33PM +0800, kernel test robot wrote:
> > > eaf62ce1563b85 Mark Brown      2024-10-01  1014       unsigned long __user *gcspr_el0;
> > 
> > I think we should keep this as u64 since it's a sysreg.
> 
> Do you mean pointer to u64 or plain u64? 

Plain u64.

> The value we get from the
> sysreg is a pointer so it makes the uses of the value clearer if we keep
> it as a pointer in C code, it seems to be defeating the point of doing
> static analysis to discard the pointerness to make it happier.

We have other cases where we treat a reg as u64 and convert it to
pointer as needed. While not a sysreg, the pt_regs::sp is u64 and we end
up treating it as a pointer eventually for writing the signal stack.
Another case is user_insn_read(). It's bit of bikeshedding around the
primary use in this function, do we need more conversions one way or the
other? In general I'd consider a sysreg read to be u64, especially as
the architecture has a habit of adding bits around the actual address
occasionally.

> > > eaf62ce1563b85 Mark Brown      2024-10-01  1051  	if (ret != 0)
> > > eaf62ce1563b85 Mark Brown      2024-10-01  1052  		return -EFAULT;
> > > eaf62ce1563b85 Mark Brown      2024-10-01  1053  
> > > eaf62ce1563b85 Mark Brown      2024-10-01  1054  	write_sysreg_s(gcspr_el0 + 1, SYS_GCSPR_EL0);
> 
> > And this would be +8 I guess.
> 
> The variable is a pointer so we're doing pointer arithmetic here not
> working directly with the value, unless we change the value to be purely
> a u64 with no pointer in which case we would need the case above.

That's what I meant, if we go for u64 we'll need a +8 here.

Anyway, I'd like to silence sparse on this. The u64 (non-pointer) has
some precedence in the arm64 code but, if you want, I'm happy to keep it
as a pointer (and maybe just rename it to shadow_stack or something that
does not imply a sysreg). I think for the actual warning, we can
probably fix it with a __force to silence sparse on conversion to u64.

-- 
Catalin

