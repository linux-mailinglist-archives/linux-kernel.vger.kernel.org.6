Return-Path: <linux-kernel+bounces-420663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A979E9D8123
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49784162F17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F054B18FC85;
	Mon, 25 Nov 2024 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtIvGtk1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1D518F2EF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525648; cv=none; b=VwxVDNi+JPAIYXnNMW9gd5J2BN8eDZhMVJedKwVMUmnaCj3sbvVLF+oNy1svFiADU+H/k74dhTUvjqxu+gC0WlW/2M8p1QcNmz1bHDJ5QgN+6fTny6QEANymMh2w4k6uKxfafv4mf3I7iThTcK50XdIfzGiRGtax0Sr765PKJ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525648; c=relaxed/simple;
	bh=R6EdTAkMojh3t+tto6JjnQYd86D3CRQOZWADFpnQRZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFyq26u8MrquTTmilS2nt/wbynZsB/KKdsm6b3HrcgPa7Ep2dKhQ2OnrvT7+RnPh0+Y50/4kN/Dlof1peQF1sMdLGHLr1Q74/RxsT3bWAXR+KEcPnORo1aLU9bJU2/EX68Sxbc8CVZeu0gwWTQGbRpwdnsJ2kUB1Pvu4ia8iPD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtIvGtk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EB9C4CED1;
	Mon, 25 Nov 2024 09:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732525647;
	bh=R6EdTAkMojh3t+tto6JjnQYd86D3CRQOZWADFpnQRZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UtIvGtk1rlivkU8NaLX4PtpaxwK2F41S8P9qd/jcBYkTaiYtZ/lUe7Yzokndp3pOX
	 wOAMA7KqaD8Qc1UKmgrCO95wTHiaZ++Lm5i8Vpp1X20VoQXNL7xc7vhwVYcupl3Lc9
	 Bar7gY077OHqwfmfpddo5wpK4Ei+DWQ1ymKqfBmACCps+JT9Tm36AlgoK9d4tm1Y+K
	 jpsNdzAz28kVe+/lmRVV/nZQ02g7nQffmyJ1+enr+sxN9hnb5cot6WXn5Bt778MITU
	 n0xOmGf7yqWGJF+jMzYYrBGjL/JdnzVhyVM9SSLvCDLBNAtJbp8rKzvJCCpfSJYHSi
	 dcuzNRIDuP15w==
Date: Mon, 25 Nov 2024 10:07:24 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org, bp@alien8.de,
	x86@kernel.org
Subject: Re: [PATCH v2 1/2] x86/ioremap: introduce helper to implement
 xxx_is_setup_data()
Message-ID: <Z0Q-TAbXPSwFXWPI@gmail.com>
References: <20241118010819.46602-1-bhe@redhat.com>
 <20241118010819.46602-2-bhe@redhat.com>
 <7cc5e26c-42fc-a700-ae19-608920cafe44@amd.com>
 <Zz2dEcLrCtXEq4cg@gmail.com>
 <b49096ad-fbfd-393f-9f35-944eeecd91db@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b49096ad-fbfd-393f-9f35-944eeecd91db@amd.com>


* Tom Lendacky <thomas.lendacky@amd.com> wrote:

> On 11/20/24 02:25, Ingo Molnar wrote:
> > 
> > * Tom Lendacky <thomas.lendacky@amd.com> wrote:
> > 
> >>>  /*
> >>>   * Examine the physical address to determine if it is boot data by checking
> >>>   * it against the boot params setup_data chain.
> >>>   */
> >>> -static bool memremap_is_setup_data(resource_size_t phys_addr,
> >>> -				   unsigned long size)
> >>> +static bool __ref __memremap_is_setup_data(resource_size_t phys_addr,
> >>
> >> Oh, I see why the __ref is needed now, because this calls an __init
> >> function based on the early bool.
> >>
> >> While this nicely consolidates the checking, I'll let the x86
> >> maintainers decide whether they like that an __init function is calling
> >> a non __init function.
> > 
> > So why would it be a problem? Only non-__init calling __init is a bug, 
> > because __init functions cease to exist after early bootup. Also, 
> > calling certain kernel subsystems too early, before they are 
> > initialized, is a bug as well.
> 
> I brought it up because that is what could happen if the wrong boolean
> value is supplied to the helper function. The helper function is marked
> non-__init but calls a __init function if the boolean value is true, hence
> the need for the __ref tagging.

Oh, so I misunderstood your point, because you typoed the direction:

  > >> While this nicely consolidates the checking, I'll let the x86 
  > >> maintainers decide whether they like that an __init function is 
  > >> calling a non __init function.

The problem is the inverse: that a non-__init generic facility may be 
calling an __init function if the wrong flag is supplied. As you wrote 
a sentence earlier, but I only responded to this paragraph :-/

So yeah, that's a fragility indeed - which happens sometimes when 
generic MM facilities share code (I think 
mm/sparse.c::section_deactivate() is similar), but I tend to agree that 
this pattern could perhaps be improved:

+                       if (early)
+                               early_memunmap(data, SD_SIZE);
+                       else
+                               memunmap(data);

Could we perhaps un-__init early_memunmap(), and call memunmap() if 
it's in a late context? (Also early_memremap_decrypted().)

That way this code could just use early_memunmap() and 
early_memremap_decrypted() and skip the boolean complication?

> But, I don't anticipate that this helper will be called by anything 
> else than what is currently calling it and the proper boolean values 
> are set on those calls.
> 
> I just wanted to raise awareness. I'm ok with using __ref, just 
> wanted to make sure everyone else is, too.

It's a fair argument I misunderstood :-)

Thanks,

	Ingo

