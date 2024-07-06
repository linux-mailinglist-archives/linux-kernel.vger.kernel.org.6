Return-Path: <linux-kernel+bounces-243394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1F99295BA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 00:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C431C20FDB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 22:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3462436139;
	Sat,  6 Jul 2024 22:52:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0BD1CD1F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 22:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720306364; cv=none; b=GyZNFtvXyNJUITCIFQT8osPFVxYiFB1JoL7AFgTxc1yaKhesiXZNPuwbvKwof6H/PhuMKSIHN3qxLIYGD96A8GX5uDsZRjQ0X1yCrhSUkGoqOXVlKV2CgpHVQcL+tiikjyBYDMWBEXsWZPj9WeaCvyB2HfqC9aRl8s0oM6b24ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720306364; c=relaxed/simple;
	bh=ZK90u5RYphGiY8mFBPfe6XQyxZbvTFXAPWCE9dNGt4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHjnsK6GMHns23VZ3HgqImwc8X0/btdCTrAqzOOt17li0CQ2S1ysW4eQUlie8sXAfoDt2mJ6tMxlllSQRZVoUze8i0CANlQj+EMv40TaZoylu9qReKj9myD4ZLGgREv/Vmi8xSAB3vCbIi6zpCs+ApVe81/0UsSt5QmvCOuQetc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A667BDA7;
	Sat,  6 Jul 2024 15:53:05 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82D2F3F762;
	Sat,  6 Jul 2024 15:52:39 -0700 (PDT)
Date: Sat, 6 Jul 2024 23:50:41 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: sunxi: sram: Constify struct regmap_config
Message-ID: <20240706235041.1c5181b8@minigeek.lan>
In-Reply-To: <20240705-sunxi-sram-const-regmap_config-v1-1-1b997cd65d0f@gmail.com>
References: <20240705-sunxi-sram-const-regmap_config-v1-1-1b997cd65d0f@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 05 Jul 2024 12:52:27 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> `sunxi_sram_regmap_config` is not modified and can be declared as const
> to move its data to a read-only section.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  drivers/soc/sunxi/sunxi_sram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
> index 71cc377b5e24..2781a091a6a6 100644
> --- a/drivers/soc/sunxi/sunxi_sram.c
> +++ b/drivers/soc/sunxi/sunxi_sram.c
> @@ -344,7 +344,7 @@ static void sunxi_sram_unlock(void *_lock)
>  	spin_unlock(lock);
>  }
>  
> -static struct regmap_config sunxi_sram_regmap_config = {
> +static const struct regmap_config sunxi_sram_regmap_config = {
>  	.reg_bits       = 32,
>  	.val_bits       = 32,
>  	.reg_stride     = 4,
> 
> ---
> base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
> change-id: 20240705-sunxi-sram-const-regmap_config-d05d1bb0583c
> 
> Best regards,


