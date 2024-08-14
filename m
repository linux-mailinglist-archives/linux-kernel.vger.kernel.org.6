Return-Path: <linux-kernel+bounces-286831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8955F951FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F84B2A2F4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244311B9B2C;
	Wed, 14 Aug 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWJ8FVhj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655A31B86D2;
	Wed, 14 Aug 2024 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651877; cv=none; b=r5kHDZHqbhf1M7PCe1c/OdDyTpjRh5cV0qMTFptNaE49hKAQImAc03rwAk7tFqMKFgyRnuywvqhUu2uloLspl0c5rZH5wMn1+6EJqYwdW4z09DdbhClJPBsugGPd5QF7dVdtsNG0W11X0Vi4BLuZPnu5M4bDPDypa/pC1LPvf/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651877; c=relaxed/simple;
	bh=xQGMhe8UU3rB9hjtZ+6qhiVkVFT1Lntea1bjy2W26PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hW7e/mepBxLuBscLqCrl3UHSTE/ZfBYo8hx7/xUAMa+269D1yXVyAGEB5cpgCqz5siEcvLJKbXucraEkXvcQIUe5x72vG4pBv2LskD26XmZGkbYUydVM91BXyakXryQ573RzBO7btU4hsFfnQV81fq7PPwW4WY+tY2Z+Fta4g54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWJ8FVhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E49C4AF0A;
	Wed, 14 Aug 2024 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723651876;
	bh=xQGMhe8UU3rB9hjtZ+6qhiVkVFT1Lntea1bjy2W26PM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWJ8FVhjuOhdC/3vSOh/Df4f7fSyTrX56EDo/GnQ5aG3I5GTX9apy2OKS5qW0xWuq
	 7Ft5efvuhWnVyt2ZpOPfBiIJDj1na5td3h4ju9lAwEC67dBuewXM3F3T4VmaAy4Glj
	 s+moWgzvN56CPZ96HJXrISNMbTTFxTJFY0SjbShwpOLJ2HgNRZSsMzsTR/NDI7n8D+
	 d7NQAms64qgsHv1OZsEysfTg2BAGcqZs1eYse1L6thFndfmftn6RzwfXosHXUwxhZT
	 gwy/yvzz8tIcKwlVhc9ZdRHeQG5gMAzZ544/c3tPhnka4W5WcZiPXQmuWakTEsSXmV
	 fCmCBb5fTg/Hg==
Date: Wed, 14 Aug 2024 16:11:14 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs: Use sysfs_emit_at() to simplify code
Message-ID: <ZrzXIlJvWsOu2IIP@google.com>
References: <0afb817e75a84859e1a86e1a7ba2041a9b852b6e.1723117820.git.christophe.jaillet@wanadoo.fr>
 <99199c2a-1dbf-439c-ad24-68ed8844e096@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99199c2a-1dbf-439c-ad24-68ed8844e096@kernel.org>

Sorry, could you please post the patch to the mailing list again?
I don't see the first patch.

Thanks,

On 08/14, Chao Yu wrote:
> On 2024/8/8 19:50, Christophe JAILLET wrote:
> > This file already uses sysfs_emit(). So be consistent and also use
> > sysfs_emit_at().
> > 
> > This slightly simplifies the code and makes it more readable.
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,

