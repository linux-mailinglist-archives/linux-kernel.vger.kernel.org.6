Return-Path: <linux-kernel+bounces-293658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BCD9582D5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03BC1C22FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCF318C351;
	Tue, 20 Aug 2024 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="iB8SKQno";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="F9ZYNlh2"
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCC618A6CE
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.134.29.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146685; cv=none; b=u0zHImbh+hKH8s8CxMCVxQTtsgLj6CR/Rik5cITmFQvihXZx3Pp+7iTf6YbqeD4iQjeLThGiBBySO3Ea+5ddL6H2lVSxa+oF/JLCyZGNeUCD4m2zCVHPs78mW7eZt2Io8xI65VPYaoK/IlVRk5BSObYVe8GJmocCD2qBECzHRRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146685; c=relaxed/simple;
	bh=jPGG/a/zhAKpjsY8pe/7xA2GurPE0F1jHaVRYfIHzcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=medu04/ie6rG4H25e+thSxP23Lj0gt/ahnkj0tVjawzxqfwPZlTCCLqKPU2psWDhqxzx8thdc1ETkPESOQUHvI4qkikSZ0xvc07dL5cQNKE9ovVRFeXoRCBwi6ZvWoXJGCcxKJlupopTpQIYpH1Crqo5JqQPJUj574n1Vlm/erY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org; spf=pass smtp.mailfrom=sigxcpu.org; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=iB8SKQno; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=F9ZYNlh2; arc=none smtp.client-ip=24.134.29.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigxcpu.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1724146678; bh=jPGG/a/zhAKpjsY8pe/7xA2GurPE0F1jHaVRYfIHzcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iB8SKQno1xOFtpP08RD4ydBwRm/5u2V2Y9ZPhGw9uEebBfyA2KWQcrarvwI5GQzTD
	 la4XoXVj6mfAbwaLxUBucQdaMykbEnbfCse4u/pg+a4cp/zfDud7yR2VQaU3RiRLLQ
	 UNRAdBLOtB50IhAHO9Lo5GxQH5uXmrWgo1kNyzjbf2XwV51R5MBCrisFluxc8nOaB7
	 aospHpuBnpT205wgczOHeMIK+Jmb6i3Fwl31ZOB4lUhgdYriz6U44wE6/QkOyVSTwK
	 ZcXKcsTd1GQf9RtbDfIidfRpxIQpcR70AvG2G3Ywoc+1kaLVUbWhszjRL1u0QVw+PF
	 IjV7UJeJfCOjg==
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id 734D6FB03;
	Tue, 20 Aug 2024 11:37:58 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5k0b3mmUCL5j; Tue, 20 Aug 2024 11:37:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1724146677; bh=jPGG/a/zhAKpjsY8pe/7xA2GurPE0F1jHaVRYfIHzcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F9ZYNlh2veNbwouKioDxQtER7zoZzfhTS9EBCEwyKXe5TwdTsVhC1U2iZcsaCap1a
	 f1oMBnuwq86FwCcdEyP/plxNWkypF0aP3RMFHUs0i0ZL8ah2n210zDY0aI8taBhdkd
	 pTMKPRi9TOAy6cMYNnNvkYvhRcd6Xrn5t2zRY+TVeLnXPleLAaN3BviVOYSWqCagb8
	 EIpj/3S+OoxKciRY1Co7EG7HThWlhi9Mr9NTIMSOjKdzc8nLxi4qyNLxAxFmc1zEVW
	 S4OhGxkkCVbvPzKXwvlzQ/PZ1ZvFgDSIt5Bo9VL6G4ovQhFG8cs0QEngCua9CYkDER
	 i+/PSm8duClRg==
Date: Tue, 20 Aug 2024 11:37:54 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: kernel@puri.sm, neil.armstrong@linaro.org, dianders@chromium.org,
	quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/panel: mantix-mlaf057we51: write hex in
 lowercase
Message-ID: <ZsRj8i_tOw9BfxNB@qwark.sigxcpu.org>
References: <20240820091556.1032726-1-tejasvipin76@gmail.com>
 <20240820091556.1032726-3-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240820091556.1032726-3-tejasvipin76@gmail.com>

Hi,
On Tue, Aug 20, 2024 at 02:45:54PM +0530, Tejas Vipin wrote:
> Converts uppercase hex to lowercase hex for cleanup.
> 
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> index 2a365eaa4ad4..4db852ffb0f6 100644
> --- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> +++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> @@ -23,7 +23,7 @@
>  
>  /* Manufacturer specific Commands send via DSI */
>  #define MANTIX_CMD_OTP_STOP_RELOAD_MIPI 0x41
> -#define MANTIX_CMD_INT_CANCEL           0x4C
> +#define MANTIX_CMD_INT_CANCEL           0x4c
>  #define MANTIX_CMD_SPI_FINISH           0x90
>  
>  struct mantix {
> @@ -50,18 +50,18 @@ static void mantix_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
>  	/*
>  	 * Init sequence was supplied by the panel vendor.
>  	 */
> -	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5a);
>  
>  	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_INT_CANCEL, 0x03);
> -	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x03);
> -	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x80, 0xA9, 0x00);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5a, 0x03);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x80, 0xa9, 0x00);
>  
> -	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x09);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5a, 0x09);
>  	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
>  	mipi_dsi_msleep(dsi_ctx, 20);
>  
> -	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_SPI_FINISH, 0xA5);
> -	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2F);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_SPI_FINISH, 0xa5);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2f);
>  	mipi_dsi_msleep(dsi_ctx, 20);
>  }

Reviewed-by: Guido Günther <agx@sigxcpu.org>

Cheers,
 -- Guido

>  
> -- 
> 2.46.0
> 

