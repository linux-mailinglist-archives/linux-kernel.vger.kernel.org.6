Return-Path: <linux-kernel+bounces-314534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE4C96B49F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1773F1F29252
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F281CB53D;
	Wed,  4 Sep 2024 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eGVbKqY1"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFF81917DF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438801; cv=none; b=tBzEb5vGkmMGzXQ54n5CgDAlVa0smu0FmDmzA6BuObzjMwhrnBhGOPtXXYr2DjSJUVHTJiayxwRmFcywzo4pye+SSKC0QkA4rZKGrP6T8/VIuWwuGntkMHvoKxk/LLyWb7XMA03hEy7XMsMJJr2sxSaLpWxs2K1/zWV5P0LG7Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438801; c=relaxed/simple;
	bh=boAOEMCSocyxTuJmJQuOFNET1Pgfg6ztfmjcoE8YGoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLzhgNwQIT4fWnoujsg7CKJ9kW+Lcf2dK3fvhWjqGH09DrFDlM5UNAE41hQmr7tMRbFdguBUHiesNra2RUyEnEjD5yW6rdPOCOEe1JMM8T6DayqBn3dktShYUu/7+c4cAxqNj2p2yW8KhvCbvAwtMKJkGHX06uc3s8GCVvb4zg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eGVbKqY1; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A26AE0002;
	Wed,  4 Sep 2024 08:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725438797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TUGv9wHevgRZb5cc15QcdSSIcNgojKzy+jo82zKMyNc=;
	b=eGVbKqY1J+/gbeDzfyyEbvjwQtZ/8Gz6/IvBdLy9Z7ZMyo/3mmyPyiQYv+f7P0fCtK50AL
	ji6uVTvvZ8lZPOjkb8l9US43KD7pugQf+XszbkD2i73SKjZsy3DIuETg2t0ry/4CmFyQRq
	aOFJl1rYEQ3v4xXsLClVU/Qvev41Dklh/Zi7lJl31HcrTz9tytd8d6xGS2rUP1ZqajP2bP
	czUUX6rmfRRlnk7QK5ndVnndzHCG2v0w4xvzSNJzEKvAxI3EfD6Wd45jS1B6dIAXe0o+Aj
	g7IO5Tmm9H9cc91OU5zUkSkwPBLhf97o6taIa+QkbuBk5rx5j7h86NNoZgq6AQ==
Date: Wed, 4 Sep 2024 10:33:13 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Qiang Zhao <qiang.zhao@nxp.com>
Subject: Re: [PATCH] soc: fsl: cpm1: qmc: Fix dependency on fsl_soc.h
Message-ID: <20240904103313.21aed2de@bootlin.com>
In-Reply-To: <fcca0369d0bcd527aa77bccdfc0894faa029cead.1725431771.git.christophe.leroy@csgroup.eu>
References: <fcca0369d0bcd527aa77bccdfc0894faa029cead.1725431771.git.christophe.leroy@csgroup.eu>
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

Hi Christophe,

On Wed,  4 Sep 2024 09:51:09 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> QMC driver requires fsl_soc.h to use function get_immrbase().
> This header is provided by powerpc architecture and the functions
> it declares are defined only when FSL_SOC is selected.
> 
> Today the dependency is the following:
> 
> 	depends on CPM1 || QUICC_ENGINE || \
> 		   (FSL_SOC && (CPM || QUICC_ENGINE) && COMPILE_TEST)
> 
> This dependency tentatively ensure that FSL_SOC is there when doing a
> COMPILE_TEST.
> 
> CPM1 is only selected by PPC_8xx and cannot be selected manually.
> CPM1 selects FSL_SOC
> 
> QUICC_ENGINE on the other hand can be selected by ARM or ARM64 which
> doesn't select FSL_SOC. QUICC_ENGINE can also be selected with just
> COMPILE_TEST.
> 
> It is therefore possible to end up with CPM_QMC selected
> without FSL_SOC.
> 
> So fix it by making it depend on FSL_SOC at all time.
> 
> The rest of the above dependency is the same as the one for CPM_TSA on
> which CPM_QMC also depends, so it can go away, leaving only a simple
> dependency on FSL_SOC.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/lkml/20240904104859.020fe3a9@canb.auug.org.au/
> Fixes: 8655b76b7004 ("soc: fsl: cpm1: qmc: Handle QUICC Engine (QE) soft-qmc firmware")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Thanks for this patch!

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

