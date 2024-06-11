Return-Path: <linux-kernel+bounces-209741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC36903A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB952823D9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8737F17B42D;
	Tue, 11 Jun 2024 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAPR5LKt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C376317545;
	Tue, 11 Jun 2024 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718105503; cv=none; b=GNawT66ikNgNY8fhyQ0wkmHwcVFLnSO2qWJMIcEKNzNibjceab/Ny6beSLfNZLzT1SFrirCdrAzUSaqITkHtINdsHpRiRH/dE4w+jn6WlIw3/kTwUvE2xIkN0PsYMa9s+8TFZxLUfBCRL7DtaayTFq+eCYvaKwdr/Ec5vo7q2KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718105503; c=relaxed/simple;
	bh=OnCmFVAhBCd6GUVnj8XGIwoQY2qJ3+hZAJEHD8rdoAw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=MSSso5T1XCXGeepABz4u/fW9f5V4ktpqFSgM72FpuAbwHqsIupDcAbjHOBZxso4n4GM59VyFiG84Mr2lEnhDoVNA5o9p/RA9DnkZF7wpNqM8DxlbUWQrPBC92VcFMjwVuCR7U3XpQiORtj3+6SkKaXawGr0QGATEX3wg6WBUG7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAPR5LKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D952C2BD10;
	Tue, 11 Jun 2024 11:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718105503;
	bh=OnCmFVAhBCd6GUVnj8XGIwoQY2qJ3+hZAJEHD8rdoAw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=VAPR5LKtdZJ6ltEsaabGN+ZyGfFgpu+JS10QeGq3FnDRMjJ2/hX3jobTHRnsIn1RT
	 vPf5p22bqGFbojZ9HcMlb1sxHIag/WuW1y7fk58G0YX7HaBTw+BX1yvq96yE7Bc4Hl
	 SKizL1thSGFnmhmiktsJ/NaoWPiCCjopEGaVm+sxBTxX59fQkCp2vdH2YH2sDfQ18J
	 lHdh3C8qQfbvUL6VWpNnZW9AF636vlKCHwWvuKVOOpg9ob8f3ilfE4EJ8OZWbj7RRU
	 +NfW1ubhfQMgnpZmj0OSbzoPwMAmUpUtOTPxgS7G8SfF9Z+rcWA2DIblkXjZvyrU/g
	 5xneH846+zizw==
Date: Tue, 11 Jun 2024 05:31:42 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: Takashi Iwai <tiwai@suse.com>, Russell King <linux@armlinux.org.uk>, 
 Jaroslav Kysela <perex@perex.cz>, Michael Ellerman <mpe@ellerman.id.au>, 
 Vladimir Zapolskiy <vz@mleia.com>, Chancel Liu <chancel.liu@nxp.com>, 
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, 
 alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
In-Reply-To: <20240611094810.27475-2-piotr.wojtaszczyk@timesys.com>
References: <[PATCH] ASoC: fsl: Add i2s and pcm drivers for LPC32xx CPUs>
 <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com>
 <20240611094810.27475-2-piotr.wojtaszczyk@timesys.com>
Message-Id: <171810550202.1047088.17292010858616719651.robh@kernel.org>
Subject: Re: [Patch v2 2/2] ASoC: dt-bindings: lpc32xx: Add lpc32xx i2s DT
 binding


On Tue, 11 Jun 2024 11:47:52 +0200, Piotr Wojtaszczyk wrote:
> Add nxp,lpc3220-i2s DT binding documentation.
> 
> Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> ---
> Changes for v2:
> - Added maintainers field
> - Dropped clock-names
> - Dropped unused unneded interrupts field
> 
>  .../bindings/sound/nxp,lpc3220-i2s.yaml       | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.example.dtb: i2s@20094000: 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/nxp,lpc3220-i2s.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240611094810.27475-2-piotr.wojtaszczyk@timesys.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


