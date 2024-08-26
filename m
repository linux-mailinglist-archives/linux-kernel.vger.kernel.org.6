Return-Path: <linux-kernel+bounces-302016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651B495F8BB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1941128213F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C13198E78;
	Mon, 26 Aug 2024 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="X8EC1OnI";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="NSIOLCp7"
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488A210E9
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.134.29.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724695450; cv=none; b=roAl7GGnjbhFHh+Jh3AxYaDGg32nTH9B8TYfht+axEZG52o2dTQBrLqdTZBh0JOBx8/SBLcCEn4psKIop9I6PmXw9Zxge+JFsfzvVxx5babDvKf3caH3lE4omCNjwtANbb/0cpRSO4NQXScwIOH6VAAGqCAESb/Gfq0BtMiUhs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724695450; c=relaxed/simple;
	bh=w2NohdGsHE7UuVvNyUIet5xboNMEuVw8vNSv42GIyco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRxuELOv3uhcwfnM/D88XgMhZGLZsIC9hPTJCzh2Gq4fNMAPgEgNB+b/43CYDMJBf8HSndW633x8zmTzEoaavOBG+enhPvv1TZd35uR2cESiZYP+MHIa5e6v9Ig1iwnzTk8hTdtaxgYFjHatxg4DmRzpdEYCYJlguVfS9/aeW/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org; spf=pass smtp.mailfrom=sigxcpu.org; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=X8EC1OnI; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=NSIOLCp7; arc=none smtp.client-ip=24.134.29.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigxcpu.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1724695437; bh=w2NohdGsHE7UuVvNyUIet5xboNMEuVw8vNSv42GIyco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X8EC1OnIgXRJWvQug5TUsDcfsPT7RGt37xENs5hsudAbQyMn9tomEzbYz4nqOEpGJ
	 Hl6Odo0Lw7OaDXb5hkesdJP8o1SDto8XXqnUMiI1utcVee3pegwPfyka5ZVGO4XUD0
	 vTgeH2reDxV7JRtP6V3W0EfKApTjwfBl8PmqqwmHj2g6IE4D0SOTyE3+eG0ly+EWuL
	 bRywGSLU1dgKyNBjsVqxOc8fBixlSeKB3+HoW/Lwwa7jj3lGkVS7psxJRhEEeD2ecq
	 1h0AKrg7lcr37vbJiI7y8APqQr33K3+qXr/d8Tes7w2Br1ZMg2VGhd9hRnAo3Yx4IT
	 DcgrSnTbS3RGw==
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id D657CFB03;
	Mon, 26 Aug 2024 20:03:57 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4KBdoFnrlicg; Mon, 26 Aug 2024 20:03:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1724695436; bh=w2NohdGsHE7UuVvNyUIet5xboNMEuVw8vNSv42GIyco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSIOLCp7MTG8rtp/EBWKcFDUcrlyU2tAz/6NdG0kXbdW9OcbF2UUKq0Wai9Tk2U4t
	 k80gjOigWjyqzm1e+joRpaTiF46SC7CCBOs4N7NpgJwtFXBV6s/yAs1AbsZsN8CCbe
	 2kYK2KANqOTDhfmG2pkKG3vH5fkG0GE8TeTd70O6UV//aBujCCzHo4KSgjSFPqoOJn
	 BlwP7tsjpev1WOkIDo5TtmfRJ+XAji+2mjJkUsTqKJBMCC1qi7sc8wDW8GTWEYbiSY
	 CFsjzNNUYgWVnUWTvBFEz60M048C6A8bpGVtUTNqqeon4jXMyjQLr1HLSIcYZnhNWl
	 OLwRA7GB9Ybuw==
Date: Mon, 26 Aug 2024 20:03:54 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: kernel@puri.sm, neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	quic_jesszhan@quicinc.com, skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: mantix: Transition to multi-context write
 sequence
Message-ID: <ZszDipyk1Ey8M0JZ@qwark.sigxcpu.org>
References: <20240826160328.12685-1-abhishektamboli9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826160328.12685-1-abhishektamboli9@gmail.com>

Hi Abhishektamboli,

I think this was already handled in

https://lore.kernel.org/dri-devel/20240820091556.1032726-2-tejasvipin76@gmail.com/

and applied

https://lore.kernel.org/dri-devel/172414629205.2571141.13215409630895562248.b4-ty@linaro.org/#t

Cheers,
 -- Guido

On Mon, Aug 26, 2024 at 09:33:28PM +0530, Abhishek Tamboli wrote:
> Replace deprecated 'mipi_dsi_generic_write_seq()' macro
> to 'mipi_dsi_generic_write_seq_multi()' macro in mantix_init_sequence
> function.
> 
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> ---
>  .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> index ea4a6bf6d35b..f276c65cc9bb 100644
> --- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> +++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> @@ -49,22 +49,25 @@ static int mantix_init_sequence(struct mantix *ctx)
>  {
>  	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
>  	struct device *dev = ctx->dev;
> +	struct mipi_dsi_multi_context dsi_ctx = {
> +		.dsi = dsi
> +	};
> 
>  	/*
>  	 * Init sequence was supplied by the panel vendor.
>  	 */
> -	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A);
> 
> -	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_INT_CANCEL, 0x03);
> -	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x03);
> -	mipi_dsi_generic_write_seq(dsi, 0x80, 0xA9, 0x00);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MANTIX_CMD_INT_CANCEL, 0x03);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x03);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x80, 0xA9, 0x00);
> 
> -	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x09);
> -	mipi_dsi_generic_write_seq(dsi, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x09);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
>  	msleep(20);
> 
> -	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_SPI_FINISH, 0xA5);
> -	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2F);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MANTIX_CMD_SPI_FINISH, 0xA5);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2F);
>  	msleep(20);
> 
>  	dev_dbg(dev, "Panel init sequence done\n");
> --
> 2.34.1
> 

