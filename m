Return-Path: <linux-kernel+bounces-533597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4829A45C77
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272733A6D91
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE28019C54E;
	Wed, 26 Feb 2025 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N0u7EtvL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361605383;
	Wed, 26 Feb 2025 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567767; cv=none; b=dlfHsZDHXY5vgV07tY+AridgWCi143pZA9JG1WrmSTer2ZzYrbS32OlCVCsKfj3VndS4BHrL7s2U3Mv2+E6bi7icsd7D4heIHLPow0dm2FT+oi1zmZCtOvF1gVE5Xyxh3B3dAAarfmndHxgsNa8VFsO3jbDURw0cHVbPzhZ1DBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567767; c=relaxed/simple;
	bh=iSD4Z5lcR52lioqNrIqieEQJwLbz630xNMhePckaLms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLogmYY+h/oS1kPqqPfHxV+uKEmTXpJRiaDWVYsxqoG8egFa2yRgWuifAk8adLxyQIEvsYJ/4kDjScXduNEBCpEQ86OQn2m/qI+jSJkt2wdGSbsQc0liZiBhcSySa5Nv5eysj1wAZ47n3iCEGbyhaNomDTAhwGwVApSrIgZ/sZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N0u7EtvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903B6C4CED6;
	Wed, 26 Feb 2025 11:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740567766;
	bh=iSD4Z5lcR52lioqNrIqieEQJwLbz630xNMhePckaLms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0u7EtvLiBTOBi4xcuGleuhWPBwSzJl3tDCE7L7s2awTX1EQ1DWMpgXqsO8ONFicr
	 vng2B5I1kg4qZGGBbcciNoHFa9smzNVmbpY5vDelrcFfxZdLkkHGr0ivmIoFdK3Kuq
	 ej4a5lyuOO8nU/RlyF8oQ7uN6rCJlSZRBGseWTlo=
Date: Wed, 26 Feb 2025 12:01:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, kernel@dakr.org,
	a.hindborg@kernel.org, alex.gaynor@gmail.com,
	benno.lossin@proton.me, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, gary@garyguo.net,
	linux-kernel@vger.kernel.org, lyude@redhat.com,
	mairacanal@riseup.net, ojeda@kernel.org, rafael@kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH 2/2] rust/faux: Add missing parent argument to
 Registration::new()
Message-ID: <2025022609-hamper-paging-8761@gregkh>
References: <ea2466c4d250ff953b3be9602a3671fb@dakr.org>
 <20250226092339.989767-1-aliceryhl@google.com>
 <Z77iHj56551mDybd@pollux>
 <2025022659-spray-treble-759f@gregkh>
 <Z77vYxUYVyFtW2lG@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z77vYxUYVyFtW2lG@cassiopeiae>

On Wed, Feb 26, 2025 at 11:39:31AM +0100, Danilo Krummrich wrote:
> > > I think if we want to add something to the safety comment, it should be somthing
> > > along the line of "the type of `parent` implies that for the duration of this
> > > call `parent` is a valid device with a non-zero reference count".
> > 
> > I don't understand the need for any safety comment about the parent
> > here.  Again, as long as it is valid when the call is made, that is all
> > that is needed.
> 
> Right, and we could mention that in the safety comment that something of the
> type `&device::Device` is indeed valid by definition and hence fullfills the
> requirement of faux_device_create() to get a valid pointer (or NULL).

Agreed.  I'll go apply patch 1 of the series now and wait for a new
version of 2/2.

thanks!

greg k-h

