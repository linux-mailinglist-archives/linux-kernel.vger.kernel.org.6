Return-Path: <linux-kernel+bounces-347908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3192498E031
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B5C1C25583
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79141D0E3A;
	Wed,  2 Oct 2024 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XVVaixFJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276EA1D0DD9;
	Wed,  2 Oct 2024 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885241; cv=none; b=OkKZMcil/lTEiEhviVTp4eEOV+UkCzetlg5gRf2luyXE9/tGzLTCL/Rio/EQCXR27X3fmCSYWOBEvCCmlQnSgDUEcnX4HtjEGZG80SsLVUGsoUQAFdIvg8pX7xCIS7LfMf8u3fMRmhO7wg1BumHb8swiW0LVAIDD39dJTmdCUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885241; c=relaxed/simple;
	bh=xxoO6obPk6pPBO3Ma2SHz0w0v/xHJSERq29P05tDduk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FacCjZdtnkpgM08JhUFggwUMu9ljK8iOJ21GBvG65SGes4tWksr0MRx5cmOmDknZp5LWvuYoFkXQtAZgBgKctAlP7YRvEVw2YbzWkHlhH+2SjD+PRXJX3buUmKgRy83uEd5Tbwov7Ee8gp8ErdRNwFmAjIEDvb4qo8odLpqojHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XVVaixFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D24AC4CEC2;
	Wed,  2 Oct 2024 16:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727885240;
	bh=xxoO6obPk6pPBO3Ma2SHz0w0v/xHJSERq29P05tDduk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XVVaixFJR+GG2EBbZrHxtXiV5fgDF9tDRytAfdujIPxnNyw4MztvMG+zET+vxRE8L
	 39ogVZOM2RXhJP/qbQij3a3xV/7WyItdYvBhoQLcoyoc1yRsE1mZpzmrDAopdS6o/a
	 pqAoUH4/a0D3ULJ5esmGyzxQWTkj9CP/93A4huQQ=
Date: Wed, 2 Oct 2024 18:07:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>, rafael@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	aliceryhl@google.com, mcgrof@kernel.org, russ.weight@linux.dev,
	dakr@redhat.com, a.hindborg@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: device: change the from_raw() function
Message-ID: <2024100240-wrangle-condiment-3f0c@gregkh>
References: <20241001205603.106278-1-trintaeoitogc@gmail.com>
 <Zv1RhZpQGkVBlLCU@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv1RhZpQGkVBlLCU@pollux>

On Wed, Oct 02, 2024 at 03:58:29PM +0200, Danilo Krummrich wrote:
> On Tue, Oct 01, 2024 at 05:56:03PM -0300, Guilherme Giacomo Simoes wrote:
> > The function Device::from_raw() increments a refcount by a call to
> > bindings::get_device(ptr). This can be confused because usually
> > from_raw() functions don't increment a refcount.
> > Hence, rename Device::from_raw() to avoid confuion with other "from_raw"
> > semantics.
> > 
> > The new name of function should be "get_device" to be consistent with
> > the function get_device() already exist in .c files.
> > 
> > This function body also changed, because the `into()` will convert the
> > `&'a Device` into `ARef<Device>` and also call `inc_ref` from the
> > `AlwaysRefCounted` trait implemented for Device.
> > 
> > Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> 
> Acked-by: Danilo Krummrich <dakr@kernel.org>

Thanks for the review, and Guilherme, for all of the revisions.  I'll
queue this up for this release soon so we don't get any code building on
the old api.

thanks,

greg k-h

