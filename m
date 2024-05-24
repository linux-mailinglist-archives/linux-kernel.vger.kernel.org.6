Return-Path: <linux-kernel+bounces-189034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC36C8CEA22
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7311F2147C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1095642072;
	Fri, 24 May 2024 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pH0rEgdg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396452C6B6;
	Fri, 24 May 2024 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716577247; cv=none; b=I7RhPR9e54veNiM6dEthHMH2/wOfcPLfqtLFB6qt1YJkG6CrEUIKlb/xmaEtfHRi0qgFqmQXG472Omhlyl+gVGcCGhiUMe2rR7b5MmKZowClJgljeKr3tCEu/esYSuRWME29iTpkshlGZxP1IJ236wdEBYcD6vDrOKde7z4V2tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716577247; c=relaxed/simple;
	bh=VyzR2s6C8P2vLomjsBBd3QvXEWZ/mkRDvK+dqfX0+/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjTXmxdAep+nUHkU4GUdU7mXtVwq6oRkFQYBbzcM0x03Exk6tFq2VxQ/zYqooniUtRoatF8E5wR1veBvV35QCjDNjk8Clq0Qfz4KsLYD0P15FgCFTI5VhhpPz6BQ1BFGQ5PUQCRZXjSdED6w+LKLbX9mDcAcD5SYBDrP6AA2Z3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pH0rEgdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCA1C2BBFC;
	Fri, 24 May 2024 19:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716577246;
	bh=VyzR2s6C8P2vLomjsBBd3QvXEWZ/mkRDvK+dqfX0+/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pH0rEgdgVzpDKKX9puQlG7rfJY33T+gFeYjZDHCfaNoWD4sD+BC8ntl0sDpXZoUCq
	 5ysmt3ex7iuR4uTZ58vuVgr3qPJiEs7afUAL1ScHfN759SIw2bmZHhXJkmFx8y2CT8
	 gKjfKBZemhwWvdthMfvjg4twakye93/yjSSBgA3Rt+Z4iW8M7k3zSJ7Fz50uK+bK1G
	 ogkuHlJwuPrwmKTtCvsnc59C9kpZB6lASGWGZBkUlwsOqFD4sIrDCHanzBTwfmcYW3
	 iTWvInG+/Z60Mwdx/ex7qqCpas6WNjGgQ8H9YT1zjESTTocW2ls6qrf83m3gVNe6LA
	 A1frRObBmUwRg==
Date: Fri, 24 May 2024 20:00:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Sebastian Ene <sebastianene@google.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, will@kernel.org,
	maz@kernel.org, Rob Herring <robh+dt@kernel.org>,
	Dragan Cvetic <dragan.cvetic@xilinx.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 2/2] misc: Register a PPI for the vcpu stall detection
 virtual device
Message-ID: <20240524-joyous-fantastic-2747ab94e83d@spud>
References: <20240523160413.868830-1-sebastianene@google.com>
 <20240523160413.868830-3-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U4biA59HViDJpe97"
Content-Disposition: inline
In-Reply-To: <20240523160413.868830-3-sebastianene@google.com>


--U4biA59HViDJpe97
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 04:04:13PM +0000, Sebastian Ene wrote:
> Request a PPI for each vCPU during probe which will be used by the host
> to communicate a stall detected event on the vCPU. When the host raises
> this interrupt from the virtual machine monitor, the guest is expected to
> handle the interrupt and panic.
>=20
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  drivers/misc/vcpu_stall_detector.c | 41 ++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/misc/vcpu_stall_detector.c b/drivers/misc/vcpu_stall=
_detector.c
> index e2015c87f03f..c580cd7fd225 100644
> --- a/drivers/misc/vcpu_stall_detector.c
> +++ b/drivers/misc/vcpu_stall_detector.c
> @@ -32,6 +32,7 @@
>  struct vcpu_stall_detect_config {
>  	u32 clock_freq_hz;
>  	u32 stall_timeout_sec;
> +	int ppi_irq;
> =20
>  	void __iomem *membase;
>  	struct platform_device *dev;
> @@ -77,6 +78,12 @@ vcpu_stall_detect_timer_fn(struct hrtimer *hrtimer)
>  	return HRTIMER_RESTART;
>  }
> =20
> +static irqreturn_t vcpu_stall_detector_irq(int irq, void *dev)
> +{
> +	panic("vCPU stall detector");
> +	return IRQ_HANDLED;
> +}
> +
>  static int start_stall_detector_cpu(unsigned int cpu)
>  {
>  	u32 ticks, ping_timeout_ms;
> @@ -132,7 +139,7 @@ static int stop_stall_detector_cpu(unsigned int cpu)
> =20
>  static int vcpu_stall_detect_probe(struct platform_device *pdev)
>  {
> -	int ret;
> +	int ret, irq, num_irqs;
>  	struct resource *r;
>  	void __iomem *membase;
>  	u32 clock_freq_hz =3D VCPU_STALL_DEFAULT_CLOCK_HZ;
> @@ -169,9 +176,32 @@ static int vcpu_stall_detect_probe(struct platform_d=
evice *pdev)
>  	vcpu_stall_config =3D (struct vcpu_stall_detect_config) {
>  		.membase		=3D membase,
>  		.clock_freq_hz		=3D clock_freq_hz,
> -		.stall_timeout_sec	=3D stall_timeout_sec
> +		.stall_timeout_sec	=3D stall_timeout_sec,
> +		.ppi_irq		=3D -1,
>  	};
> =20
> +	num_irqs =3D platform_irq_count(pdev);
> +	if (num_irqs < 0) {
> +		dev_err(&pdev->dev, "Failed to get irqs\n");

platform_irq_count() either returns a number or EPROBE_DEFER, I don't
think emitting an error on deferred probe is the correct thing to do
here?

> +		ret =3D num_irqs;
> +		goto err;
> +	} else if (num_irqs > 1) {
> +		dev_err(&pdev->dev, "Multipple irqs detected\n");

Typo. I don't really see why you're going to this level of complexity
though, why aren't you just doing a single get_irq_optional()?

> +		ret =3D -EINVAL;
> +		goto err;
> +	} else if (num_irqs =3D=3D 1) {
> +		irq =3D platform_get_irq(pdev, 0);
> +		if ((irq > 0) && irq_is_percpu_devid(irq)) {
> +			ret =3D request_percpu_irq(irq,
> +						 vcpu_stall_detector_irq,
> +						 "vcpu_stall_detector",
> +						 vcpu_stall_detectors);
> +			if (!ret)
> +				vcpu_stall_config.ppi_irq =3D irq;
> +
> +		}
> +	}
> +
>  	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>  				"virt/vcpu_stall_detector:online",
>  				start_stall_detector_cpu,
> @@ -184,6 +214,9 @@ static int vcpu_stall_detect_probe(struct platform_de=
vice *pdev)
>  	vcpu_stall_config.hp_online =3D ret;
>  	return 0;
>  err:
> +	if (vcpu_stall_config.ppi_irq > 0)
> +		free_percpu_irq(vcpu_stall_config.ppi_irq,
> +				vcpu_stall_detectors);
>  	return ret;
>  }
> =20
> @@ -193,6 +226,10 @@ static void vcpu_stall_detect_remove(struct platform=
_device *pdev)
> =20
>  	cpuhp_remove_state(vcpu_stall_config.hp_online);
> =20
> +	if (vcpu_stall_config.ppi_irq > 0)
> +		free_percpu_irq(vcpu_stall_config.ppi_irq,
> +				vcpu_stall_detectors);
> +
>  	for_each_possible_cpu(cpu)
>  		stop_stall_detector_cpu(cpu);
>  }
> --=20
> 2.45.1.288.g0e0cd299f1-goog
>=20
>=20

--U4biA59HViDJpe97
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlDj2gAKCRB4tDGHoIJi
0pKCAQCh1w4ktNbvOBnvKlPyT8kVEaqv6qVAvawgu15jGC1guwEAoBW32iJ63XM/
ox+um5tZltvEvtfyuCM4wVclCNrmHwI=
=dzas
-----END PGP SIGNATURE-----

--U4biA59HViDJpe97--

