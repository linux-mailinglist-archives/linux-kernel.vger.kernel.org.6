Return-Path: <linux-kernel+bounces-444167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7439F0252
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 02:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533B528528D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 01:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC06022338;
	Fri, 13 Dec 2024 01:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3JwfwRX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44315DDDC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 01:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734053968; cv=none; b=PTJFOesGedqgP5MhONFtdWnIqBRrI2/l3Z9543ML9fLUYB3nYfj+uEg2Df38JgyyW7wp0d8pnvFqHk8QrDr+oi8uJPCM9dMhOBWQrnhXwfW92ZLDaG3iYI9WQGwKb+zqXom8rE//ZXAyFKrJQ77tiIqEBVRZlB0KLuPMOw506Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734053968; c=relaxed/simple;
	bh=Ra1VxdQ/8TTZ3X+c+TRhwdx4G2iTjHWTA1/OfqsPyjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gie4VTX/j2bHdshO+bLhw7ozEwYCv72eoTiaMvHt6Zo1kA4H0gBthxwPxYW+oxpkUJXilrXd3ra1FUVeeaWd9xhbC5bdtEJWkTltpNyC9bRFfjEYFXdb+PZ/xOKixmcjqkGHI2MQ88K5X1xVpOgNte+hIRXzmD5REXLUJzp5Pb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3JwfwRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F0DC4CECE;
	Fri, 13 Dec 2024 01:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734053968;
	bh=Ra1VxdQ/8TTZ3X+c+TRhwdx4G2iTjHWTA1/OfqsPyjo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z3JwfwRX6jNTUf4Z3ox6fIBTKaOeclJYu3kuES5HJjZPz3ZAX7YCEpjZho+EJzP7a
	 GPxsAA3tcIJ+wVvR9aZuYZu4h2w+4PaEQ54qu6c8LeEuwsVv514Tdkqju7swD0LaWR
	 oRcWt5KPiztBdbDMhOAqU/DzHyuqdfx85eRfvamUPNXL4O0L+/0p//RORhrw7tLyEj
	 R+pFLxoFowDOG7exMMbL20biJuuu1WtqzfOKqqrBthe+Ync8h9XaN4aeR7kKrw/pQR
	 FuMtouxSbaQCSEjdc0KvZR7ryp96zgpwfige+3S02GPzITFRpl0mVR+ELSJlBuZa6t
	 258hnWHe7/zSg==
Message-ID: <61367642-43a6-46e9-a231-dbb178fd304e@kernel.org>
Date: Thu, 12 Dec 2024 17:39:26 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARC: build: Try to guess GCC variant of cross compiler
To: Leon Romanovsky <leon@kernel.org>, Vineet Gupta <vgupta@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <00d3173fe207ab9ba85dc974777a6ccb4656b03c.1733229205.git.leonro@nvidia.com>
From: Vineet Gupta <vgupta@kernel.org>
Content-Language: en-US
In-Reply-To: <00d3173fe207ab9ba85dc974777a6ccb4656b03c.1733229205.git.leonro@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/3/24 04:37, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>
> ARC GCC compiler is packaged starting from Fedora 39i and the GCC
> variant of cross compile tools has arc-linux-gnu- prefix and not
> arc-linux-. This is causing that CROSS_COMPILE variable is left unset.
>
> This change allows builds without need to supply CROSS_COMPILE argument
> if distro package is used.
>
> Before this change:
> $ make -j 128 ARCH=arc W=1 drivers/infiniband/hw/mlx4/
>   gcc: warning: ‘-mcpu=’ is deprecated; use ‘-mtune=’ or ‘-march=’ instead
>   gcc: error: unrecognized command-line option ‘-mmedium-calls’
>   gcc: error: unrecognized command-line option ‘-mlock’
>   gcc: error: unrecognized command-line option ‘-munaligned-access’
>
> [1] https://packages.fedoraproject.org/pkgs/cross-gcc/gcc-arc-linux-gnu/index.html
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Added to for-curr.

Thx,
-Vineet

> ---
>  arch/arc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arc/Makefile b/arch/arc/Makefile
> index 2390dd042e36..fb98478ed1ab 100644
> --- a/arch/arc/Makefile
> +++ b/arch/arc/Makefile
> @@ -6,7 +6,7 @@
>  KBUILD_DEFCONFIG := haps_hs_smp_defconfig
>  
>  ifeq ($(CROSS_COMPILE),)
> -CROSS_COMPILE := $(call cc-cross-prefix, arc-linux- arceb-linux-)
> +CROSS_COMPILE := $(call cc-cross-prefix, arc-linux- arceb-linux- arc-linux-gnu-)
>  endif
>  
>  cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__


