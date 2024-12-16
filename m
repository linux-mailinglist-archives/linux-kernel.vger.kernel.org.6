Return-Path: <linux-kernel+bounces-447691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFB29F3609
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D5027A39A2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27FC2063EA;
	Mon, 16 Dec 2024 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1pttnR9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AA7200A0;
	Mon, 16 Dec 2024 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366525; cv=none; b=fgsZF4Lbr4oOOnl06yDUVGEA06RRXE9AMCVe0Ws94kQ/K73Y+Sqcsa2hXFNI7H0o7p2yY+LnI2P2cQxL9qaJZ9ugukVm5vCA64qwkfLEqoN7jAmnoZ+wYgndqa1pyXSETvgAlPYvS4cc+05qHjCPCsDSbGTEaFi8JpqXs5fNcsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366525; c=relaxed/simple;
	bh=Fdb/urKOQXVjpK4B9+81dr1LSIs+ZuFuYxv0uOLwtB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHEUHxryYP6HX+fDodwSJFtW1aKoYy0AujVjrw7vkLXgiQL1DG45zMbmjnKZ9izN/lTg+TI/tgPi9pI888JOKWUz5bICesxHS1QwGuvrnpYmkbKYDBGzwrbA5fB5lqlExp5uCIEg9jx6eZXwIgS/CtyHtF4Yy13EcHUGtCbnE6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1pttnR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EDDC4CED0;
	Mon, 16 Dec 2024 16:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734366524;
	bh=Fdb/urKOQXVjpK4B9+81dr1LSIs+ZuFuYxv0uOLwtB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d1pttnR9ZYYpTvFqLCqbWzPIPtTblaborWZYSvyReadaXs57Ut7lgb8igwVLMEpWg
	 otzgmS4HrqfCovS/rYbHyE8ebW+gtsk+4KVNerwq9fFSedxwwT2yvz8MnszpztksbE
	 fWtvWynXSS83Uv87MJLPb5dXaGFi9r6abm1GyuzfYCaB6XekttUMt+I5RlG5g+sg/F
	 pd+gBtjHYrb8wfLgcmd7S0tIUW1kgjZFjWrboOzo0MAYjt98WjYGQbMPL4W4i+7GR4
	 V40gJG0Gs0PC8zomPMiM3ugSqxDq6+uBEXtebXT5cs9jrB7RI5bSp7VgYvv0WdfCF4
	 qBlq4rFSuhz9A==
Date: Mon, 16 Dec 2024 21:58:41 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Yu Jiaoliang <yujiaoliang@vivo.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ALSA: compress_offload: avoid 64-bit get_user()
Message-ID: <Z2BVOUAPIr0+q0Fu@vaman>
References: <20241216093410.377112-1-arnd@kernel.org>
 <20241216093410.377112-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216093410.377112-2-arnd@kernel.org>

On 16-12-24, 10:33, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On some architectures, get_user() cannot read a 64-bit user variable:
> 
> arm-linux-gnueabi-ld: sound/core/compress_offload.o: in function `snd_compr_ioctl':
> compress_offload.c:(.text.snd_compr_ioctl+0x538): undefined reference to `__get_user_bad'
> 
> Use an equivalent copy_from_user() instead.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

