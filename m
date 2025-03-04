Return-Path: <linux-kernel+bounces-544434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B01FDA4E11F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3E119C08AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F08253F2F;
	Tue,  4 Mar 2025 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f54Samq2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C2B253F1B;
	Tue,  4 Mar 2025 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098657; cv=none; b=nZ55Y2WLqXRucbGxg82dPeLShxct9o47Mxv7jhdQiU16+4Gga4135EIImth0LLnkN3zvJ6tZOZHSKZO+MA7WDUX53QHTN2YNdfjwkYVrbKpt0ZujJmuAvZvOcNVu0kA2l4v+3cj5kL0BfLuynDWn5yjTgmN6Rxi3gro8OuUit+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098657; c=relaxed/simple;
	bh=+bcl3HGDoc9IqaZsMJSKegqvSclSq4gfCFg0kcJllNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaj1V4lhm2bIfJCbhq0x2tUsG6Bu3CW5kO5eHRfW/wV7PhE/yC3rD06iuIGTgmebjISi7yhyu4A87OgFs2jSCVZXrP9MgjpwtdHP18N7rQ5liQvbHH8mBLmHqsjenGwE3wCEoOgozHIIcRpd7rhJnmD6VSaVQwrSgM3q/qkGXag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f54Samq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C9DC4CEE5;
	Tue,  4 Mar 2025 14:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741098657;
	bh=+bcl3HGDoc9IqaZsMJSKegqvSclSq4gfCFg0kcJllNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f54Samq2ENCyCzuTHGR/tYVZKiwx076XuyVyuDVLnKmBwmBZLrrFDqh/SJuc8H2A8
	 QK/pOjMHQD2Zr1heHM8PR9WQZ9EqTc3k0MqkEQip4O0NsOspaS2Tn9LQvf1skBxKrN
	 xLtT3Cn2+850TS7nTuTHGzQSRtU3CAqvIeCuNRcYiVNQbYsRIrOGi8IztoA9X0FxeJ
	 JyWCMgeVgiQshwxCL02k7yH3iIhj9wr24Epn30wWdi02sU++HLb0uy1n5bZG+ArkTW
	 a5Pkoyizp8l35EIyOFSmuLNWE16gROFxnX4oLq1YO0hUmND3VXceKOodcfD3Nkrk1R
	 oRkGgycHf/kDQ==
Date: Tue, 4 Mar 2025 15:30:48 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, ajanulgu@redhat.com, lyude@redhat.com,
	pstanner@redhat.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	mcgrof@kernel.org, russ.weight@linux.dev,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	Nouveau <nouveau-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 5/6] gpu: nova-core: add initial driver stub
Message-ID: <Z8cOmISkQNcFdcvm@cassiopeiae>
References: <20250226175552.29381-1-dakr@kernel.org>
 <20250226175552.29381-6-dakr@kernel.org>
 <D87JQ69QA6F0.184YR2BTJB0IT@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D87JQ69QA6F0.184YR2BTJB0IT@nvidia.com>

On Tue, Mar 04, 2025 at 11:19:49PM +0900, Alexandre Courbot wrote:
> On Thu Feb 27, 2025 at 2:55 AM JST, Danilo Krummrich wrote:
> 
> > +// TODO replace with something like derive(FromPrimitive)
> > +impl TryFrom<u32> for Chipset {
> > +    type Error = kernel::error::Error;
> > +
> > +    fn try_from(value: u32) -> Result<Self, Self::Error> {
> > +        match value {
> > +            0x162 => Ok(Chipset::TU102),
> > +            0x164 => Ok(Chipset::TU104),
> > +            0x166 => Ok(Chipset::TU106),
> > +            0x167 => Ok(Chipset::TU117),
> > +            0x168 => Ok(Chipset::TU116),
> > +            0x172 => Ok(Chipset::GA102),
> > +            0x173 => Ok(Chipset::GA103),
> > +            0x174 => Ok(Chipset::GA104),
> > +            0x176 => Ok(Chipset::GA106),
> > +            0x177 => Ok(Chipset::GA107),
> > +            0x192 => Ok(Chipset::AD102),
> > +            0x193 => Ok(Chipset::AD103),
> > +            0x194 => Ok(Chipset::AD104),
> > +            0x196 => Ok(Chipset::AD106),
> > +            0x197 => Ok(Chipset::AD107),
> > +            _ => Err(ENODEV),
> > +        }
> > +    }
> > +}
> 
> I know this is probably temporary anyway, but since there is a macro now you can simplify this implementation by making part of it:
> 
> 		impl TryFrom<u32> for Chipset {
> 				type Error = kernel::error::Error;
> 
> 				fn try_from(value: u32) -> Result<Self, Self::Error> {
> 						match value {
> 								$( $value => Ok(Chipset::$variant), )*
> 								_ => Err(ENODEV),
> 						}
> 				}
> 		}
> 

Sure, that's a good suggestion, will do.

With that changed, may I add your RB? I'd like to land this series in the next
merge window.

