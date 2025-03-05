Return-Path: <linux-kernel+bounces-546564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9C6A4FC3E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EEA47A25EB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E43207E1D;
	Wed,  5 Mar 2025 10:31:06 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5DC2E337F;
	Wed,  5 Mar 2025 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170665; cv=none; b=rNgLawWXTCmBrvH6tPNL0dzscUHQsdoN1UMsgzytvn1UQ9adgkRqfHm/zGjhLtb21xfm4wU10v0/YsMBntbPru8byBOueS9pkK1rGB0x9gRtPpDMq1hZ6tO6M0/VQuXWAVg69mcft19fs+hF7N/1lFscwJxLg6eW3pO69KpGqzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170665; c=relaxed/simple;
	bh=RcZtDEPIr7npynhNkRSf7ZIYwzevdo5E5GPwmnke3Kg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=ljKQPB7IhzJ5wOK9/fUVmNyuOwSt7XY84RaCqrscMRA1eaPiKC2VGLUxGF9ah5XgFFZL4fqEuy/fDH+VbmXMemc0c8NSluM0YRprGcuKFSbGdjw1FFj8ECh7CW2tNx9lvbTZabd60Q0FH4nUMW/G/BdDGz9KCadEDG3AOrsaOwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id CB5C648D;
	Wed,  5 Mar 2025 11:24:47 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Mar 2025 11:24:47 +0100
Message-Id: <D889CRJC6W19.2LDQCDVG7BLNG@kernel.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: sst: register SFDP region into NVMEM
 framework to read MAC Address
Cc: "Varshini Rajendran" <varshini.rajendran@microchip.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Manikandan Muralidharan" <manikandan.m@microchip.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <claudiu.beznea@tuxon.dev>, <tudor.ambarus@linaro.org>,
 <pratyush@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
 <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>
X-Mailer: aerc 0.16.0
References: <20250305100134.1171124-1-manikandan.m@microchip.com>
In-Reply-To: <20250305100134.1171124-1-manikandan.m@microchip.com>

On Wed Mar 5, 2025 at 11:01 AM CET, Manikandan Muralidharan wrote:
> From: Varshini Rajendran <varshini.rajendran@microchip.com>
>
> EUI identifier and the MAC Address of the Ethernet Interface is stored
> after the SFDP table of contents starting at address 0x260 in the
> QSPI memory.
> Register the entire SFDP region read by the spi-nor (nor->sfdp) into the
> NVMEM framework and read the MAC Address when requested using the nvmem
> properties in the DT by the net drivers.
>
> In kernel the Ethernet MAC address relied on U-Boot env variables or
> generated a random address, which posed challenges for boards without
> on-board EEPROMs or with multiple Ethernet ports.
> This change ensures consistent and reliable MAC address retrieval from QS=
PI,
> benefiting boards like the sama5d29 curiosity and sam9x75 curiosity.
>
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> [manikandan.m@microchip.com: Integrate the nvmem->read callback framework=
]
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  drivers/mtd/spi-nor/sst.c | 62 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
> index 175211fe6a5e..a0abf201ad41 100644
> --- a/drivers/mtd/spi-nor/sst.c
> +++ b/drivers/mtd/spi-nor/sst.c
> @@ -5,6 +5,7 @@
>   */
> =20
>  #include <linux/mtd/spi-nor.h>
> +#include <linux/nvmem-provider.h>
> =20
>  #include "core.h"
> =20
> @@ -13,6 +14,8 @@
> =20
>  #define SST26VF_CR_BPNV		BIT(3)
> =20
> +#define SST26VF_SFDP_EUI48	0x30
> +
>  static int sst26vf_nor_lock(struct spi_nor *nor, loff_t ofs, u64 len)
>  {
>  	return -EOPNOTSUPP;
> @@ -56,8 +59,67 @@ static int sst26vf_nor_late_init(struct spi_nor *nor)
>  	return 0;
>  }
> =20
> +/**
> + * sst26vf_sfdp_mac_addr_read() - check if the EUI-48 MAC Address is pro=
grammed
> + * and read the data from the prestored SFDP data
> + *
> + * @priv: User context passed to read callbacks.
> + * @offset: Offset within the NVMEM device.
> + * @val: pointer where to fill the ethernet address
> + * @bytes: Length of the NVMEM cell
> + *
> + * Return: 0 on success, -EINVAL  otherwise.
> + */
> +static int sst26vf_sfdp_mac_addr_read(void *priv, unsigned int off,
> +				      void *val, size_t bytes)
> +{
> +	struct spi_nor *nor =3D priv;
> +	struct sfdp *sfdp =3D nor->sfdp;
> +	loff_t offset =3D off;
> +	size_t sfdp_size;
> +
> +	/*
> +	 * Check if the EUI-48 MAC address is programmed in the next six addres=
s
> +	 * locations.
> +	 * @off is programmed in the DT and stores the start of MAC Address
> +	 * byte, (off - 1) stores the bit length of the Extended Unique
> +	 * Identifier
> +	 */
> +	if (SST26VF_SFDP_EUI48 !=3D *((u8 *)sfdp->dwords + (offset - 1)))
> +		return -EINVAL;

What happens if you read at a different offset? You're exposing
the entire SFDP region. What happens if there is a 0x30 at a
different location?

> +
> +	sfdp_size =3D sfdp->num_dwords * sizeof(*sfdp->dwords);
> +	memory_read_from_buffer(val, bytes, &offset, sfdp->dwords,
> +				sfdp_size);
> +	return 0;
> +}
> +
> +static struct nvmem_config sst26vf_sfdp_nvmem_config =3D {
> +	.word_size =3D 1,
> +	.stride =3D 1,
> +};
> +
> +static int sst26vf_nor_post_sfdp(struct spi_nor *nor)
> +{
> +	struct nvmem_device *nvmem;
> +
> +	sst26vf_sfdp_nvmem_config.dev =3D nor->dev;
> +	sst26vf_sfdp_nvmem_config.size =3D nor->sfdp->num_dwords * sizeof(*nor-=
>sfdp->dwords);
> +	sst26vf_sfdp_nvmem_config.priv =3D nor;
> +	sst26vf_sfdp_nvmem_config.reg_read =3D sst26vf_sfdp_mac_addr_read;
> +
> +	nvmem =3D devm_nvmem_register(nor->dev, &sst26vf_sfdp_nvmem_config);
> +	if (IS_ERR(nvmem)) {
> +		dev_err(nor->dev, "failed to register NVMEM device: %ld\n", PTR_ERR(nv=
mem));
> +		return PTR_ERR(nvmem);

I don't think it makes sense to have this one-off in a particular
driver. If at all, this should be handled in the core. Sorry, but
this really looks like an ugly hack.

-michael

> +	}
> +
> +	return 0;
> +}
> +
>  static const struct spi_nor_fixups sst26vf_nor_fixups =3D {
>  	.late_init =3D sst26vf_nor_late_init,
> +	.post_sfdp =3D sst26vf_nor_post_sfdp,
>  };
> =20
>  static const struct flash_info sst_nor_parts[] =3D {


