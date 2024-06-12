Return-Path: <linux-kernel+bounces-212302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28664905E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8991F22F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900E0127E0F;
	Wed, 12 Jun 2024 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="upSGIncV"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E98231A67
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718229518; cv=none; b=lPX7c2p3ym06x2QrHmVEcdZtV67qafbzDU0eaWq87SDaaSuKwdFQRPZNmskNQlyImLTS6huL/QQ5XOj3eg9VL2UUj6yfWbDtaLGMnqOpaKA3HHsk4pod0bkawlak5rtT6NLQGyRsPXS16GA6hACWwe/fM67PrVfTerZ0ydj2kkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718229518; c=relaxed/simple;
	bh=khrDNDWmeGqGZrOXj4qoCzqppIXgw1A4jRwrqwCdU8I=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=JiQ5tE5kaEkV0ooZMkT1GAdk7Eb+qAX/m1eg03abRhWInTI/TqojmKolP8Q0ZqXEHLYhNaQzp7spxpvSanZO7I5kY5NgBSWMzikl2qfYG7ck9r77kA8GTMfoMwklV2eHvSKl3gyNrWv/99kLNpDHhcz/sHBOia2rHJqItEi2YdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=upSGIncV; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70421e78edcso283825b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1718229516; x=1718834316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eb1Tdmuo2+DL2sMCGsEjLYo7CfSSy+N0ra/0HS1hBn4=;
        b=upSGIncVzEiKempUdbqo4sFE1wX8kQVVTRZs7aoMNutt5DLfLVOSOfksXjl//FkHaG
         FveZn7mpSszihqO/p1fRtYxY9VSN0ETANIehjVqsSlWib+6bia8z9QjUuI3+RyJn7gYk
         AlNtQXlDYw8XtU4Su8jljDMlYGpIP1Pw3Zk2+2yfVrLs0x+KnnDYg15BN+lGApg1BU4o
         sbIUGkhU6jXFvpL16mlubhHAnv01/o7soszCDexYrhfLnifRYoj1tkMm8vxeRIZYXe5x
         U8SUxZBY7W4SWS8G+7LSmBk6aUqB4425aBFBIo37LDKJMVjQRP9L7VZhABhtQIcEMk6z
         Yjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718229516; x=1718834316;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eb1Tdmuo2+DL2sMCGsEjLYo7CfSSy+N0ra/0HS1hBn4=;
        b=FHWiYNKB5LXZhe24TpYME3ml/cWljx8rStRNdYoPJqwV0qKkqJygif2nDc+HLlogzL
         lP4JEKFgbopPJEYbMs92FPtKcnaocb59CN0yhDxQXZddHeoigvlUU9S/QwcrAzN2rh7m
         6aC80S78+BhSQQxo6TCymrKjnbkaNAbWwd7MwVEDPtsV8Eydc0YzxjrxKIyh3Q5qFQd1
         R773C1AJJI6MajCb7/qzbz3UuR8jYkR+u+hUHwWKkNZMkYCflmjNz68cIMKKoJz+/FSM
         gig9FNHk4jOd5y2bC5B9nJ+Cbva2q1igfLN+nR6fzMTy62cSe59ZC0k2MmjPhceF0id+
         GJIg==
X-Forwarded-Encrypted: i=1; AJvYcCVquJZPJ/wsoC278srCdJhi/72//pb1Y/ienaFOc6EsNxF8M+ZSDW3DJtkBC5uhg/ylgRsXcr9pRbTL9eW9MeWZjlCDSyE5k1R0eZia
X-Gm-Message-State: AOJu0YwB/pCYc/MNugK3TAfo9v8bRTd0CqfOXwL1Dn37PRnjPnithPEM
	49vbzVLUD13wD8JYnN6mPdMmL8qNw2MS2Odj1BPLMj+XgWAy0JTDLj5As7H6gQxICO2MCAdPVhZ
	k
X-Google-Smtp-Source: AGHT+IEJhUslG+KXH+FRzbl+rnNWPz4a9aFQN8ML87y8Vr+1JNHaUcsU3bWw/7YAi/1ijZiJFiXyTQ==
X-Received: by 2002:a05:6a00:1704:b0:705:9abf:a41d with SMTP id d2e1a72fcca58-705bce0a2cbmr3903937b3a.10.1718229515532;
        Wed, 12 Jun 2024 14:58:35 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3cdacsm27295b3a.132.2024.06.12.14.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 14:58:35 -0700 (PDT)
Date: Wed, 12 Jun 2024 14:58:35 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jun 2024 14:58:32 PDT (-0700)
Subject:     Re: [PATCH v3] riscv: defconfig: Enable StarFive JH7110 drivers
In-Reply-To: <20240605071701.13737-1-hal.feng@starfivetech.com>
CC: Conor Dooley <conor.dooley@microchip.com>, emil.renner.berthing@canonical.com,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, hal.feng@starfivetech.com,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: hal.feng@starfivetech.com
Message-ID: <mhng-e2ae02b6-ac36-40cf-aa44-79ab8a625885@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 05 Jun 2024 00:17:01 PDT (-0700), hal.feng@starfivetech.com wrote:
> Add support for StarFive JH7110 SoC and VisionFive 2 board.
> - Cache
> - Temperature sensor
> - PMIC (AXP15060)
> - Ethernet PHY (YT8531)
> - Restart GPIO
> - RNG
> - I2C
> - SPI
> - Quad SPI
> - PCIe
> - USB & USB 2.0 PHY & PCIe 2.0/USB 3.0 PHY
> - Audio (I2S / TDM / PWM-DAC)
> - MIPI-CSI2 RX & D-PHY RX
>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>
> As more drivers of StarFive JH7110 VisionFive 2 board are upstream,
> add support for them in riscv defconfig.
>
> Changes since v2:
> - As the JH7110 PCIe driver was accepted, add CONFIG_PCIE_STARFIVE_HOST=m.
> - Add CONFIG_MOTORCOMM_PHY=m, which supports the ethernet phy chips
>   on the board.
> - Rebase on the -next branch.
>
> Changes since v1:
> - Drop CONFIG_STAGING=y, CONFIG_STAGING_MEDIA=y,
>   CONFIG_V4L_PLATFORM_DRIVERS=y, CONFIG_VIDEO_STARFIVE_CAMSS=m.
> - Change CONFIG_SENSORS_SFCTEMP as a module.
> - Drop CONFIG_CLK_STARFIVE_JH7110_*=y, because they are not critical to boot.
> - Update the commit message.
>
> History:
> v2: https://lore.kernel.org/all/20240506034627.66765-1-hal.feng@starfivetech.com/
> v1: https://lore.kernel.org/all/20240403060902.42834-1-hal.feng@starfivetech.com/
>
> ---
>  arch/riscv/configs/defconfig | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 12dc8c73a8ac..6e10039c5c42 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -110,8 +110,10 @@ CONFIG_PCIEPORTBUS=y
>  CONFIG_PCI_HOST_GENERIC=y
>  CONFIG_PCIE_XILINX=y
>  CONFIG_PCIE_FU740=y
> +CONFIG_PCIE_STARFIVE_HOST=m
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
> +CONFIG_SIFIVE_CCACHE=y
>  CONFIG_MTD=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_CFI=y
> @@ -143,6 +145,7 @@ CONFIG_RAVB=y
>  CONFIG_STMMAC_ETH=m
>  CONFIG_MICREL_PHY=y
>  CONFIG_MICROSEMI_PHY=y
> +CONFIG_MOTORCOMM_PHY=m
>  CONFIG_CAN_RCAR_CANFD=m
>  CONFIG_INPUT_MOUSEDEV=y
>  CONFIG_KEYBOARD_SUN4I_LRADC=m
> @@ -155,24 +158,35 @@ CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
>  CONFIG_VIRTIO_CONSOLE=y
>  CONFIG_HW_RANDOM=y
>  CONFIG_HW_RANDOM_VIRTIO=y
> +CONFIG_HW_RANDOM_JH7110=m
> +CONFIG_I2C=y
>  CONFIG_I2C_CHARDEV=m
> +CONFIG_I2C_DESIGNWARE_PLATFORM=y
>  CONFIG_I2C_MV64XXX=m
>  CONFIG_I2C_RIIC=y
>  CONFIG_SPI=y
> +CONFIG_SPI_CADENCE_QUADSPI=m
> +CONFIG_SPI_PL022=m
>  CONFIG_SPI_RSPI=m
>  CONFIG_SPI_SIFIVE=y
>  CONFIG_SPI_SUN6I=y
>  # CONFIG_PTP_1588_CLOCK is not set
>  CONFIG_GPIO_SIFIVE=y
> +CONFIG_POWER_RESET_GPIO_RESTART=y
> +CONFIG_SENSORS_SFCTEMP=m
>  CONFIG_CPU_THERMAL=y
>  CONFIG_DEVFREQ_THERMAL=y
>  CONFIG_RZG2L_THERMAL=y
>  CONFIG_WATCHDOG=y
>  CONFIG_SUNXI_WATCHDOG=y
>  CONFIG_RENESAS_RZG2LWDT=y
> +CONFIG_MFD_AXP20X_I2C=y
>  CONFIG_REGULATOR=y
>  CONFIG_REGULATOR_FIXED_VOLTAGE=y
> +CONFIG_REGULATOR_AXP20X=y
>  CONFIG_REGULATOR_GPIO=y
> +CONFIG_MEDIA_SUPPORT=m
> +CONFIG_VIDEO_CADENCE_CSI2RX=m
>  CONFIG_DRM=m
>  CONFIG_DRM_RADEON=m
>  CONFIG_DRM_NOUVEAU=m
> @@ -184,6 +198,10 @@ CONFIG_SOUND=y
>  CONFIG_SND=y
>  CONFIG_SND_SOC=y
>  CONFIG_SND_SOC_RZ=m
> +CONFIG_SND_DESIGNWARE_I2S=m
> +CONFIG_SND_SOC_STARFIVE=m
> +CONFIG_SND_SOC_JH7110_PWMDAC=m
> +CONFIG_SND_SOC_JH7110_TDM=m
>  CONFIG_SND_SOC_WM8978=m
>  CONFIG_SND_SIMPLE_CARD=m
>  CONFIG_USB=y
> @@ -197,6 +215,11 @@ CONFIG_USB_OHCI_HCD_PLATFORM=y
>  CONFIG_USB_RENESAS_USBHS=m
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_UAS=y
> +CONFIG_USB_CDNS_SUPPORT=m
> +CONFIG_USB_CDNS3=m
> +CONFIG_USB_CDNS3_GADGET=y
> +CONFIG_USB_CDNS3_HOST=y
> +CONFIG_USB_CDNS3_STARFIVE=m
>  CONFIG_USB_MUSB_HDRC=m
>  CONFIG_USB_MUSB_SUNXI=m
>  CONFIG_NOP_USB_XCEIV=m
> @@ -246,6 +269,9 @@ CONFIG_RZG2L_ADC=m
>  CONFIG_RESET_RZG2L_USBPHY_CTRL=y
>  CONFIG_PHY_SUN4I_USB=m
>  CONFIG_PHY_RCAR_GEN3_USB2=y
> +CONFIG_PHY_STARFIVE_JH7110_DPHY_RX=m
> +CONFIG_PHY_STARFIVE_JH7110_PCIE=m
> +CONFIG_PHY_STARFIVE_JH7110_USB=m
>  CONFIG_LIBNVDIMM=y
>  CONFIG_NVMEM_SUNXI_SID=y
>  CONFIG_EXT4_FS=y

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

