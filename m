Return-Path: <linux-kernel+bounces-367473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F098B9A02C2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED9D1C23101
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D631C07E3;
	Wed, 16 Oct 2024 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lskX0/py"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC911BA89C;
	Wed, 16 Oct 2024 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064320; cv=none; b=rtCnwBx/cXq16Q/aRBfZXzV+zL32AMzkHxGVCZN0nuWywSbhx7PXaBJWflquRpWpb8zn7jPnB8fdcTNm9FCLLLRp+Tme4QFvJnI1UCDfUTOc4sCdtbxw8ydPHET0SxrKGo1fhgpZTT/YkLDbl2HugfgYCHTHkE4ZPIrY2H7Vmh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064320; c=relaxed/simple;
	bh=nnBaSE0XKjTCJMTMQlfX2Sg9F/Q3C9ovc8AzfvebKk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABPpcPTGlHtA78m4bQvYJRMzjtjg1VV86QfAala+J4LB/DIPJtovBhuGXa7J/OQWW5IkiLEedO2SZYAAEgxAKfYu5wE9QCcH+OErXXiNw9RqktckBdWe/b6eeh1/6ROy+KyeH5Yj1jUqVt/wd2dp2qVncO87RWRwgfRY+cr6BJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lskX0/py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA6BC4CEC5;
	Wed, 16 Oct 2024 07:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729064319;
	bh=nnBaSE0XKjTCJMTMQlfX2Sg9F/Q3C9ovc8AzfvebKk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lskX0/py2lBXTjZ5x8GkrH0ekq6anBdTa6qPqoHlxjV8faPslfuxojktqVLEULzMA
	 R7Mh7BToM9cx7M+g8aO2P6CP34bRbWMZydnoODaIX30USp38lj5v9EqJgFsjuzeVeC
	 dpcLrhCZXK1oKIwlhGueEwl0MJjxjaJsZVgtLNbk=
Date: Wed, 16 Oct 2024 09:38:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: dpenkler@gmail.com, skhan@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gpib: Remove a dead condition in if statement
Message-ID: <2024101621-oxymoron-tipping-199b@gregkh>
References: <20241015200655.17444-1-everestkc@everestkc.com.np>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015200655.17444-1-everestkc@everestkc.com.np>

On Tue, Oct 15, 2024 at 02:06:47PM -0600, Everest K.C. wrote:
> The variable `residue` is an unsigned int, also the function
> `fluke_get_dma_residue` returns an unsigned int. The value of
> an unsigned int can only be 0 at minimum.
> The less-than-zero comparision can never be true.
> Fix it by removing the dead condition in the if statement.
> 
> This issue was reported by Coverity Scan.
> Report:
> CID 1600782: (#1 of 1): Macro compares unsigned to 0 (NO_EFFECT)
> unsigned_compare: This less-than-zero comparison of an unsigned value
> is never true. residue < 0U.
> 
> Fixes: 55936779f496 ("staging: gpib: Add Fluke cda based cards GPIB driver")

Again, a code cleanup does not deserve a "Fixes:" tag, sorry.

thanks,

greg k-h

