Return-Path: <linux-kernel+bounces-181361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED218C7AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6A71F21EED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88BD156238;
	Thu, 16 May 2024 17:18:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09001429E
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879930; cv=none; b=WmL6DW20zo91bPlBiGJP24UusYu/p2iZFqWtb5YKY7HgoW5OeJ8rFk8yZ3UepJLQ9qZHXI77iNC+Y0PU0h4ZL8CUWtXUEqWg1IvSuy0Os1XTkuK2O+0mmkkzks9ipodLmG7l9NktY5ti8KJ2yUljH8TyqbbxK4XIBWYQynGmWCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879930; c=relaxed/simple;
	bh=A7jD0x16kHayI04EdOsyg94SPS2TMDLYLkBaZV8SR88=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qjUgfj+USiiLgHBz/gKs0bJKc8pcPUmOp8N4kwr/o1WfrYHuSeqxaJgkIBpOs8vhL6fRMLEg0EaTuceZTyXU4SV/2R9Qc63NTBpnfhwbYeGkHNjfg/j3Ybk5h1ubyeunpJHs1787ZfAkin9vuGMD+s4Q4jT2TGIlQI1bCH2KemA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1s7ekb-00077U-3t; Thu, 16 May 2024 19:18:41 +0200
Message-ID: <57ea9084c792f642ea25d96d40c4425de061a3ef.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] drm/etnaviv: Turn etnaviv_is_model_rev() into a
 function
From: Lucas Stach <l.stach@pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>, Russell King
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 16 May 2024 19:18:40 +0200
In-Reply-To: <20240125-etnaviv-npu-v2-2-ba23c9a32be1@pengutronix.de>
References: <20240125-etnaviv-npu-v2-0-ba23c9a32be1@pengutronix.de>
	 <20240125-etnaviv-npu-v2-2-ba23c9a32be1@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Am Donnerstag, dem 25.01.2024 um 12:07 +0100 schrieb Philipp Zabel:
> Turn the etnaviv_is_model_rev() macro into a static inline function.
> Use the raw model number as a parameter instead of the chipModel_GCxxxx
> defines. This reduces synchronization requirements for the generated
> headers. For newer hardware, the GCxxxx names are not the correct model
> names anyway. For example, model 0x8000 NPUs are called VIPNano-QI/SI(+)
> by VeriSilicon.
>=20
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

I've applied the series to the etnaviv/next branch. I had to alter
$subject patch to fix the conflict with d7a5c9de99b3a ("drm/etnaviv:
fix tx clock gating on some GC7000 variants").

Regards,
Lucas

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 66 ++++++++++++++++++-----------=
------
>  1 file changed, 34 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etna=
viv/etnaviv_gpu.c
> index 9b8445d2a128..c61d50dd3829 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -172,10 +172,12 @@ int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, =
u32 param, u64 *value)
>  	return 0;
>  }
> =20
> +static inline bool etnaviv_is_model_rev(struct etnaviv_gpu *gpu, u32 mod=
el, u32 revision)
> +{
> +	return gpu->identity.model =3D=3D model &&
> +	       gpu->identity.revision =3D=3D revision;
> +}
> =20
> -#define etnaviv_is_model_rev(gpu, mod, rev) \
> -	((gpu)->identity.model =3D=3D chipModel_##mod && \
> -	 (gpu)->identity.revision =3D=3D rev)
>  #define etnaviv_field(val, field) \
>  	(((val) & field##__MASK) >> field##__SHIFT)
> =20
> @@ -281,7 +283,7 @@ static void etnaviv_hw_specs(struct etnaviv_gpu *gpu)
> =20
>  	switch (gpu->identity.instruction_count) {
>  	case 0:
> -		if (etnaviv_is_model_rev(gpu, GC2000, 0x5108) ||
> +		if (etnaviv_is_model_rev(gpu, 0x2000, 0x5108) ||
>  		    gpu->identity.model =3D=3D chipModel_GC880)
>  			gpu->identity.instruction_count =3D 512;
>  		else
> @@ -315,17 +317,17 @@ static void etnaviv_hw_specs(struct etnaviv_gpu *gp=
u)
>  	 * For some cores, two varyings are consumed for position, so the
>  	 * maximum varying count needs to be reduced by one.
>  	 */
> -	if (etnaviv_is_model_rev(gpu, GC5000, 0x5434) ||
> -	    etnaviv_is_model_rev(gpu, GC4000, 0x5222) ||
> -	    etnaviv_is_model_rev(gpu, GC4000, 0x5245) ||
> -	    etnaviv_is_model_rev(gpu, GC4000, 0x5208) ||
> -	    etnaviv_is_model_rev(gpu, GC3000, 0x5435) ||
> -	    etnaviv_is_model_rev(gpu, GC2200, 0x5244) ||
> -	    etnaviv_is_model_rev(gpu, GC2100, 0x5108) ||
> -	    etnaviv_is_model_rev(gpu, GC2000, 0x5108) ||
> -	    etnaviv_is_model_rev(gpu, GC1500, 0x5246) ||
> -	    etnaviv_is_model_rev(gpu, GC880, 0x5107) ||
> -	    etnaviv_is_model_rev(gpu, GC880, 0x5106))
> +	if (etnaviv_is_model_rev(gpu, 0x5000, 0x5434) ||
> +	    etnaviv_is_model_rev(gpu, 0x4000, 0x5222) ||
> +	    etnaviv_is_model_rev(gpu, 0x4000, 0x5245) ||
> +	    etnaviv_is_model_rev(gpu, 0x4000, 0x5208) ||
> +	    etnaviv_is_model_rev(gpu, 0x3000, 0x5435) ||
> +	    etnaviv_is_model_rev(gpu, 0x2200, 0x5244) ||
> +	    etnaviv_is_model_rev(gpu, 0x2100, 0x5108) ||
> +	    etnaviv_is_model_rev(gpu, 0x2000, 0x5108) ||
> +	    etnaviv_is_model_rev(gpu, 0x1500, 0x5246) ||
> +	    etnaviv_is_model_rev(gpu, 0x880, 0x5107) ||
> +	    etnaviv_is_model_rev(gpu, 0x880, 0x5106))
>  		gpu->identity.varyings_count -=3D 1;
>  }
> =20
> @@ -351,7 +353,7 @@ static void etnaviv_hw_identify(struct etnaviv_gpu *g=
pu)
>  		 * Reading these two registers on GC600 rev 0x19 result in a
>  		 * unhandled fault: external abort on non-linefetch
>  		 */
> -		if (!etnaviv_is_model_rev(gpu, GC600, 0x19)) {
> +		if (!etnaviv_is_model_rev(gpu, 0x600, 0x19)) {
>  			gpu->identity.product_id =3D gpu_read(gpu, VIVS_HI_CHIP_PRODUCT_ID);
>  			gpu->identity.eco_id =3D gpu_read(gpu, VIVS_HI_CHIP_ECO_ID);
>  		}
> @@ -368,7 +370,7 @@ static void etnaviv_hw_identify(struct etnaviv_gpu *g=
pu)
>  		}
> =20
>  		/* Another special case */
> -		if (etnaviv_is_model_rev(gpu, GC300, 0x2201)) {
> +		if (etnaviv_is_model_rev(gpu, 0x300, 0x2201)) {
>  			u32 chipTime =3D gpu_read(gpu, VIVS_HI_CHIP_TIME);
> =20
>  			if (chipDate =3D=3D 0x20080814 && chipTime =3D=3D 0x12051100) {
> @@ -387,15 +389,15 @@ static void etnaviv_hw_identify(struct etnaviv_gpu =
*gpu)
>  		 * Fix model/rev here, so all other places can refer to this
>  		 * core by its real identity.
>  		 */
> -		if (etnaviv_is_model_rev(gpu, GC2000, 0xffff5450)) {
> +		if (etnaviv_is_model_rev(gpu, 0x2000, 0xffff5450)) {
>  			gpu->identity.model =3D chipModel_GC3000;
>  			gpu->identity.revision &=3D 0xffff;
>  		}
> =20
> -		if (etnaviv_is_model_rev(gpu, GC1000, 0x5037) && (chipDate =3D=3D 0x20=
120617))
> +		if (etnaviv_is_model_rev(gpu, 0x1000, 0x5037) && (chipDate =3D=3D 0x20=
120617))
>  			gpu->identity.eco_id =3D 1;
> =20
> -		if (etnaviv_is_model_rev(gpu, GC320, 0x5303) && (chipDate =3D=3D 0x201=
40511))
> +		if (etnaviv_is_model_rev(gpu, 0x320, 0x5303) && (chipDate =3D=3D 0x201=
40511))
>  			gpu->identity.eco_id =3D 1;
>  	}
> =20
> @@ -630,14 +632,14 @@ static void etnaviv_gpu_enable_mlcg(struct etnaviv_=
gpu *gpu)
>  		pmc |=3D BIT(15); /* Unknown bit */
> =20
>  	/* Disable TX clock gating on affected core revisions. */
> -	if (etnaviv_is_model_rev(gpu, GC4000, 0x5222) ||
> -	    etnaviv_is_model_rev(gpu, GC2000, 0x5108) ||
> -	    etnaviv_is_model_rev(gpu, GC2000, 0x6202) ||
> -	    etnaviv_is_model_rev(gpu, GC2000, 0x6203))
> +	if (etnaviv_is_model_rev(gpu, 0x4000, 0x5222) ||
> +	    etnaviv_is_model_rev(gpu, 0x2000, 0x5108) ||
> +	    etnaviv_is_model_rev(gpu, 0x2000, 0x6202) ||
> +	    etnaviv_is_model_rev(gpu, 0x2000, 0x6203))
>  		pmc |=3D VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_TX;
> =20
>  	/* Disable SE and RA clock gating on affected core revisions. */
> -	if (etnaviv_is_model_rev(gpu, GC7000, 0x6202))
> +	if (etnaviv_is_model_rev(gpu, 0x7000, 0x6202))
>  		pmc |=3D VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_SE |
>  		       VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_RA;
> =20
> @@ -690,14 +692,14 @@ static void etnaviv_gpu_setup_pulse_eater(struct et=
naviv_gpu *gpu)
>  	 */
>  	u32 pulse_eater =3D 0x01590880;
> =20
> -	if (etnaviv_is_model_rev(gpu, GC4000, 0x5208) ||
> -	    etnaviv_is_model_rev(gpu, GC4000, 0x5222)) {
> +	if (etnaviv_is_model_rev(gpu, 0x4000, 0x5208) ||
> +	    etnaviv_is_model_rev(gpu, 0x4000, 0x5222)) {
>  		pulse_eater |=3D BIT(23);
> =20
>  	}
> =20
> -	if (etnaviv_is_model_rev(gpu, GC1000, 0x5039) ||
> -	    etnaviv_is_model_rev(gpu, GC1000, 0x5040)) {
> +	if (etnaviv_is_model_rev(gpu, 0x1000, 0x5039) ||
> +	    etnaviv_is_model_rev(gpu, 0x1000, 0x5040)) {
>  		pulse_eater &=3D ~BIT(16);
>  		pulse_eater |=3D BIT(17);
>  	}
> @@ -718,8 +720,8 @@ static void etnaviv_gpu_hw_init(struct etnaviv_gpu *g=
pu)
>  	WARN_ON(!(gpu->state =3D=3D ETNA_GPU_STATE_IDENTIFIED ||
>  		  gpu->state =3D=3D ETNA_GPU_STATE_RESET));
> =20
> -	if ((etnaviv_is_model_rev(gpu, GC320, 0x5007) ||
> -	     etnaviv_is_model_rev(gpu, GC320, 0x5220)) &&
> +	if ((etnaviv_is_model_rev(gpu, 0x320, 0x5007) ||
> +	     etnaviv_is_model_rev(gpu, 0x320, 0x5220)) &&
>  	    gpu_read(gpu, VIVS_HI_CHIP_TIME) !=3D 0x2062400) {
>  		u32 mc_memory_debug;
> =20
> @@ -745,7 +747,7 @@ static void etnaviv_gpu_hw_init(struct etnaviv_gpu *g=
pu)
>  		  VIVS_HI_AXI_CONFIG_ARCACHE(2));
> =20
>  	/* GC2000 rev 5108 needs a special bus config */
> -	if (etnaviv_is_model_rev(gpu, GC2000, 0x5108)) {
> +	if (etnaviv_is_model_rev(gpu, 0x2000, 0x5108)) {
>  		u32 bus_config =3D gpu_read(gpu, VIVS_MC_BUS_CONFIG);
>  		bus_config &=3D ~(VIVS_MC_BUS_CONFIG_FE_BUS_CONFIG__MASK |
>  				VIVS_MC_BUS_CONFIG_TX_BUS_CONFIG__MASK);
>=20


