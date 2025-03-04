Return-Path: <linux-kernel+bounces-545424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A500A4ECF5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4B6189033A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EC7253B75;
	Tue,  4 Mar 2025 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5Mwzih5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B11F419A;
	Tue,  4 Mar 2025 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115693; cv=none; b=g/qWMT+u+wZnB0CLZSl+KzdqbceZ7+9sYPbPyGn1ZXYCABQ+CJF4Hbw9Dp3v5NalRQ4hU+ggD4/HX3awB8vPljNhoOxUc4TcFcsdZ4BGtlAeGJvh77GhC/rbbVDtLPO32ni9a4hkL/tFqHB+1uz8ZiKI2bJNPdOZ3ykyzKtwkbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115693; c=relaxed/simple;
	bh=Cf5Pkr2I4+xpU+XK6bETQuRHM1hQiPVBfroY8069cYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xlatnmolpu+tQ3jw7jFUA0km5rHnWJL3edeUDozLnobH6y6D9v9fT1Pit/l+nwjXcUD7tSFChDjqizmzQgDdoTIBU0DdXo2zbJ9DLMML1Z5mrXCRt3iGG2m6iTFL0Md78mKYpGxxbJLeF3X0RevoiJBw7UW6Wy6WpvRPyPnuuNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5Mwzih5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC7EC4CEE8;
	Tue,  4 Mar 2025 19:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741115692;
	bh=Cf5Pkr2I4+xpU+XK6bETQuRHM1hQiPVBfroY8069cYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G5Mwzih5cN1AbdqvYxxUDI/zFB/PKTtEQeBZdxAOAjafd+UCsJO2wPN9UnHKzSU0O
	 nMWhYJzUlUS1b9DTnV1FB+6Dl+0XSLAvjkHRdceuUtnbH7R1wIenIF4qM++rV3vbac
	 iF2yrZZQPbmmf8PQdIxm4zQcWgiTpb1wfjJdtCC/dJtqcwwtl0RdGLBQDADe8xWeVx
	 baotdAG6pik9G6nWoKa7QUn4j1jZeBMmNbcVZOQ2nRqLOJOxLX1ZtVZTjXumeWlo92
	 Oqqr3Sv373/p2UbPZYIsE8HCiUJj0KwHOw2TQphYb/E9egc70kZlerGrhb78GRgNvK
	 +q9Qu52NUocjw==
Date: Tue, 4 Mar 2025 21:14:48 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, ajanulgu@redhat.com, lyude@redhat.com,
	pstanner@redhat.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	gregkh@linuxfoundation.org, mcgrof@kernel.org,
	russ.weight@linux.dev, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 1/5] rust: module: add type `LocalModule`
Message-ID: <Z8dRKDHI7loVA78O@kernel.org>
References: <20250304173555.2496-1-dakr@kernel.org>
 <20250304173555.2496-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304173555.2496-2-dakr@kernel.org>

On Tue, Mar 04, 2025 at 06:34:48PM +0100, Danilo Krummrich wrote:
> The `LocalModule` type is the type of the module created by `module!`,
> `module_pci_driver!`, `module_platform_driver!`, etc.
> 
> Since the exact type of the module is sometimes generated on the fly by
> the listed macros, provide an alias.
> 
> This is first used by the `module_firmware!` macro introduced in a
> subsequent patch.

So generally speaking for any patches, they are not patches once they
land to the Git and theoretically you cannot presume any order.

So cut out hairs the last sentence should be just:

"The first use for this will be module_firmware!"


> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

You can speak about subsequent patches here but not in the commit
message.

>  rust/macros/module.rs | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index cdf94f4982df..6ba9210677c5 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -228,6 +228,8 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
>                  kernel::ThisModule::from_ptr(core::ptr::null_mut())
>              }};
>  
> +            type LocalModule = {type_};
> +

nit:

I'd document this as:

// The `LocalModule` type is the type of the module created by `module!`,
// `module_pci_driver!`, `module_platform_driver!`, etc.

;-)


>              impl kernel::ModuleMetadata for {type_} {{
>                  const NAME: &'static kernel::str::CStr = kernel::c_str!(\"{name}\");
>              }}
> -- 
> 2.48.1
> 
> 

BR, Jarkko

