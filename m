Return-Path: <linux-kernel+bounces-344442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D56C98A9A8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B445DB229AC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557E31922DA;
	Mon, 30 Sep 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N5riAqBg"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9824C1E507
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713447; cv=none; b=NZxgrsBCAiA8tb+qIuNY+baeBLGoP6siEld4jL0HXXEvxK2UqFgV4ToWt9UARH/7hwYkbob4OwSbm5h1M4ixuxGL1u+Sm317mXEYSl+bhWMD0Te7m+gSMveDNXI1oI1ZNzfNkVeph1d8qWPCXDIvli14vHUzugqHkropI/diucM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713447; c=relaxed/simple;
	bh=g/QhmkA7NXpDT5r4yt+p0U8vsb2G9Di+xgayB02aKY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h8/1rQ6RXGJ0bplloD5nK3iuJ2fM3l3EVPrbAdQbv8SS2cmHEsBWtxCEteiZu3UqQqFmUKRC59fRaNeZqDTjR3xE6BJI33BjA0vjqdagE2qPRvZd2IJ8aNuvpjxRsQ6cOJE3Y6WM2nwELQK6/AZA/vnHZgnoZjqVkFzz59DFQZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N5riAqBg; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AD5FEE0004;
	Mon, 30 Sep 2024 16:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727713443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ak/OpaHZla/c5uUaOqdAyJ559kbBrFZymGfhIpH/FxU=;
	b=N5riAqBg5lyO1VUxKxPagcwP2FZzNvzdMFcKizPj+jDk0tofSyjgNg2xdso0NxS/uQe/qk
	ylcLtuChL/mF9pp9os7j3nPbhcIfMERAt9Uf9y0kpf8e38O7CTfgnU8bHa+Vvckb43MmgQ
	qQytaOBRZNO31P3uurZsEI8XFAbr3dE0ZCRbKsnvglGTrR0METsx8JAIFh9/cPo3tOVnMf
	YZEO0N8xPkjCHRM8amWhfnpNMVNZSNsHzKeYD1mzdQULVRXR0lOl1SoqUvSRRhUzyE+Gd0
	K8wxLHahoXSNIK+Oco0JEQ3Vbo9Z6tAe05Knrl0xmILzqOzwy/W4fxV5TcBggw==
Date: Mon, 30 Sep 2024 18:24:01 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Qiang Zhao <qiang.zhao@nxp.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: fsl: cpm1: qmc: Do not use IS_ERR_VALUE() on error
 pointers
Message-ID: <20240930182401.3dd15aaa@bootlin.com>
In-Reply-To: <8b113596b2c8cdda6655346232cc603efdeb935a.1727708905.git.geert+renesas@glider.be>
References: <8b113596b2c8cdda6655346232cc603efdeb935a.1727708905.git.geert+renesas@glider.be>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Geert,

On Mon, 30 Sep 2024 17:08:31 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> ppc64_book3e_allmodconfig:
> 
>     drivers/soc/fsl/qe/qmc.c: In function ‘qmc_qe_init_resources’:
>     include/linux/err.h:28:49: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>        28 | #define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
> 	  |                                                 ^
>     include/linux/compiler.h:77:45: note: in definition of macro ‘unlikely’
>        77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
> 	  |                                             ^
>     drivers/soc/fsl/qe/qmc.c:1764:13: note: in expansion of macro ‘IS_ERR_VALUE’
>      1764 |         if (IS_ERR_VALUE(info)) {
> 	  |             ^~~~~~~~~~~~
> 
> IS_ERR_VALUE() is only meant for pointers.  Fix this by checking for a
> negative error value instead, which matches the documented behavior of
> devm_qe_muram_alloc() aka devm_cpm_muram_alloc().
> While at it, remove the unneeded print in case of a memory allocation
> failure, and propagate the returned error code.
> 
> Fixes: eb680d563089e55b ("soc: fsl: cpm1: qmc: Add support for QUICC Engine (QE) implementation")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.
> ---
>  drivers/soc/fsl/qe/qmc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 

Thanks for the patch.
Works on my side, no regressions found on my MPC8321 system.
Tested-by: Herve Codina <herve.codina@bootlin.com>

And of course:
Acked-by: Herve Codina <herve.codina@bootlin.com>

Sorry for this mistake.
Best regards,
Hervé

