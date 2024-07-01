Return-Path: <linux-kernel+bounces-236226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 397C291DEFA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A67A5B20938
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A2214AD0D;
	Mon,  1 Jul 2024 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="ZS/7SXOb"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB9E149E0E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836506; cv=none; b=cbbSoz7HXTU4PndgIPKcIyirKB2g8KZF9JU99rv7c9V0iCHNNn+yOAN4oHMDERUwc1AST2uC09UgCqNsojlKR0afN+JMZksGzVctd7XNk3Kj698rQCrzg07nxjzzCCfHkMhD4exDx94kUchGz1tsTTq0w+bipDpO6BwcNU/yrHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836506; c=relaxed/simple;
	bh=+J2IBLaBKX5l2s0Z1YTDttEfoJxmlswkvP9IFVxSF8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmJnH/KQufY7OrLWacn7rJ3bFba4WPcflVL0vof/q2OXOseHM+tySsw7PN9avxEXbGOQXXA/q/4gNBj5PLIyfpyjZjSSBcG3PXL8XgVKckWnTM9L2WM46vutZ6zdmPiZU3zpMyJnXjj4GqeyB9t2iGumSm6If05iJXfAPe78Wyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=ZS/7SXOb; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7f3cd2c0a79so101757739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 05:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1719836503; x=1720441303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2I2phX5SfphrD8mFq4Dsh1jNhCFM+axrPQ2YhWzmtM=;
        b=ZS/7SXObBKC7n/rBbQBk5mWZEBURhW8kOGvtQhKmHVBaVwSPJtVFPbr29iwpsrbVjz
         z2T1zt18sfMBk2X6XmPq1Zxnx6pyDwUDQTAJ6OnUpUUFzOzx0Jb7ei0HzH/OXKp4uXHb
         SIIAXNAhE7x1pjO5rlmjiuB2ONj47s4lC2r3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719836503; x=1720441303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2I2phX5SfphrD8mFq4Dsh1jNhCFM+axrPQ2YhWzmtM=;
        b=bsfNQr3Gfm/AGi8JVJOXcIAaDn5WrNM6dLG0Uo12Eoc680Sd94luwlAcWBsG8tVyUK
         Uy72CZ3UPUo6jR5zAnFDJbWDw23QrpF/neI+loHrPnoKsovY3DP29ergbMmyLrdh+LtR
         SUlozINLzRn+STJjeCuCSx6v0svCAy+667llw+m7+S0+a0dZpXZAKQzyg+8odQEUE0XE
         L18xrH04jk3kZl1pe+BtYDP/RppwkZcxXNZkA2/75ZVd2YrILjjAIaQLBhF0y02hF5Mx
         n/jjJjOLaU+kyrrlkXM9VGuTt8HJuL9w7EHQfPohqTL+6zLxmLEPZljrMfW33rMADBpJ
         vbWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWPSi9OTr169YLBBBnV+YMM+ed3+HT+w2mQ40EkgaTwsBfjfPaeJU6rj6oxulLIa2RIzw6ICsN2kZbnFCgNzIk0Gn50n0NfJAZcrI3
X-Gm-Message-State: AOJu0YySLBz5fQWJycNPqUW96+od+c26HH7rj2OjD9tWxZsmLT1/ErjY
	x62f2JisJG793f8Eqt+xknMRVLL8Jm3DY0yb4KlpBDHsNzXoAy/X+a0jTquUfSwQhVCsiRDD2h8
	=
X-Google-Smtp-Source: AGHT+IEHlBSVoLAGLT0QUYynI3xiB+zHclOFUEHcOlZZxJvXOc4pAC8Rk19w6m43Kv5g+TnB9p0PJg==
X-Received: by 2002:a5d:8453:0:b0:7f3:d649:9fff with SMTP id ca18e2360f4ac-7f62ed4c918mr606786839f.0.1719836502924;
        Mon, 01 Jul 2024 05:21:42 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4bb73dd7c44sm2167926173.69.2024.07.01.05.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 05:21:42 -0700 (PDT)
Message-ID: <58a73e70-565e-45e3-a1b5-3163978b7cea@ieee.org>
Date: Mon, 1 Jul 2024 07:21:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [greybus-dev] [PATCH] driver core: have match() callback in
 struct bus_type take a const *
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
References: <2024070136-wrongdoer-busily-01e8@gregkh>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <2024070136-wrongdoer-busily-01e8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/24 7:07 AM, Greg Kroah-Hartman wrote:
> In the match() callback, the struct device_driver * should not be
> changed, so change the function callback to be a const *.  This is one
> step of many towards making the driver core safe to have struct
> device_driver in read-only memory.
> 
> Because the match() callback is in all busses, all busses are modified
> to handle this properly.  This does entail switching some container_of()
> calls to container_of_const() to properly handle the constant *.
> 
> For some busses, like PCI and USB and HV, the const * is cast away in
> the match callback as those busses do want to modify those structures at
> this point in time (they have a local lock in the driver structure.)
> That will have to be changed in the future if they wish to have their
> struct device * in read-only-memory.
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

For drivers/greybus/core.c, drivers/staging/greybus/gbphy.c, and
include/linux/greybus.h:

Reviewed-by: Alex Elder <elder@kernel.org>

> ---
>   - cc: list suppressed as it just touches too many different subsystems
>     at once, sorry.  I tried to hit all of the mailing lists as a bcc:
>     hopefully they don't reject it...
> 
>   arch/arm/common/locomo.c                      |  4 ++--
>   arch/arm/include/asm/hardware/locomo.h        |  2 +-
>   arch/parisc/include/asm/parisc-device.h       |  2 +-
>   arch/parisc/kernel/drivers.c                  |  4 ++--
>   arch/powerpc/include/asm/ps3.h                |  6 +-----
>   arch/powerpc/include/asm/vio.h                |  6 +-----
>   arch/powerpc/platforms/ps3/system-bus.c       |  4 ++--
>   arch/powerpc/platforms/pseries/ibmebus.c      |  2 +-
>   arch/powerpc/platforms/pseries/vio.c          |  6 +++---
>   arch/s390/include/asm/ccwdev.h                |  2 +-
>   arch/sparc/include/asm/vio.h                  |  6 +-----
>   arch/sparc/kernel/vio.c                       |  4 ++--
>   drivers/acpi/bus.c                            |  4 ++--
>   drivers/amba/bus.c                            |  6 +++---
>   drivers/base/auxiliary.c                      |  2 +-
>   drivers/base/base.h                           |  3 +--
>   drivers/base/cpu.c                            |  2 +-
>   drivers/base/isa.c                            |  2 +-
>   drivers/base/platform.c                       |  2 +-
>   drivers/bcma/main.c                           |  6 +++---
>   drivers/bus/fsl-mc/fsl-mc-bus.c               |  4 ++--
>   drivers/bus/mhi/ep/main.c                     |  4 ++--
>   drivers/bus/mhi/host/init.c                   |  4 ++--
>   drivers/bus/mips_cdmm.c                       |  6 +++---
>   drivers/bus/moxtet.c                          |  4 ++--
>   drivers/bus/sunxi-rsb.c                       |  2 +-
>   drivers/cdx/cdx.c                             |  4 ++--
>   drivers/cxl/core/port.c                       |  2 +-
>   drivers/cxl/cxl.h                             |  5 +----
>   drivers/dax/bus.c                             | 17 +++++++----------
>   drivers/dma/idxd/bus.c                        |  6 +++---
>   drivers/eisa/eisa-bus.c                       |  4 ++--
>   drivers/firewire/core-device.c                |  6 +++---
>   drivers/firmware/arm_ffa/bus.c                |  2 +-
>   drivers/firmware/arm_scmi/bus.c               |  6 +++---
>   drivers/firmware/google/coreboot_table.c      |  6 +++---
>   drivers/fpga/dfl.c                            |  4 ++--
>   drivers/fsi/fsi-core.c                        |  4 ++--
>   drivers/gpio/gpiolib.c                        |  2 +-
>   drivers/gpu/drm/display/drm_dp_aux_bus.c      |  2 +-
>   drivers/gpu/drm/drm_mipi_dsi.c                |  2 +-
>   drivers/gpu/host1x/bus.c                      |  2 +-
>   drivers/greybus/core.c                        |  4 ++--
>   drivers/hid/hid-core.c                        |  2 +-
>   drivers/hid/intel-ish-hid/ishtp/bus.c         |  2 +-
>   drivers/hsi/hsi_core.c                        |  2 +-
>   drivers/hv/vmbus_drv.c                        |  8 ++++----
>   drivers/hwtracing/intel_th/core.c             |  4 ++--
>   drivers/hwtracing/intel_th/intel_th.h         |  2 +-
>   drivers/i2c/i2c-core-base.c                   |  4 ++--
>   drivers/i3c/master.c                          |  4 ++--
>   drivers/input/gameport/gameport.c             |  4 ++--
>   drivers/input/rmi4/rmi_bus.c                  |  6 +++---
>   drivers/input/rmi4/rmi_bus.h                  |  2 +-
>   drivers/input/rmi4/rmi_driver.c               |  2 +-
>   drivers/input/rmi4/rmi_driver.h               |  2 +-
>   drivers/input/serio/serio.c                   |  4 ++--
>   drivers/ipack/ipack.c                         |  6 +++---
>   drivers/macintosh/macio_asic.c                |  2 +-
>   drivers/mcb/mcb-core.c                        |  4 ++--
>   drivers/media/pci/bt8xx/bttv-gpio.c           |  4 ++--
>   drivers/media/pci/bt8xx/bttv.h                |  2 +-
>   drivers/memstick/core/memstick.c              |  7 +++----
>   drivers/mfd/mcp-core.c                        |  2 +-
>   drivers/misc/mei/bus.c                        |  4 ++--
>   drivers/misc/tifm_core.c                      |  6 +++---
>   drivers/mmc/core/sdio_bus.c                   | 10 +++++-----
>   drivers/most/core.c                           |  2 +-
>   drivers/net/phy/mdio_bus.c                    |  4 ++--
>   drivers/net/phy/mdio_device.c                 |  4 ++--
>   drivers/net/phy/phy_device.c                  |  4 ++--
>   drivers/ntb/ntb_transport.c                   |  2 +-
>   drivers/nvdimm/bus.c                          |  6 +++---
>   drivers/nvmem/layouts.c                       |  4 ++--
>   drivers/pci/endpoint/pci-epf-core.c           |  4 ++--
>   drivers/pci/pci-driver.c                      |  8 ++++----
>   drivers/pcmcia/ds.c                           |  2 +-
>   drivers/peci/core.c                           |  4 ++--
>   drivers/peci/internal.h                       |  5 +----
>   drivers/platform/surface/aggregator/bus.c     |  4 ++--
>   drivers/platform/x86/wmi.c                    |  9 +++------
>   drivers/pnp/driver.c                          |  6 +++---
>   drivers/rapidio/rio-driver.c                  |  4 ++--
>   drivers/rpmsg/rpmsg_core.c                    |  4 ++--
>   drivers/rpmsg/rpmsg_internal.h                |  2 +-
>   drivers/s390/cio/css.c                        |  4 ++--
>   drivers/s390/cio/css.h                        |  2 +-
>   drivers/s390/cio/device.c                     |  4 ++--
>   drivers/s390/crypto/ap_bus.c                  |  4 ++--
>   drivers/s390/crypto/ap_bus.h                  |  2 +-
>   drivers/scsi/fcoe/fcoe_sysfs.c                |  2 +-
>   drivers/scsi/scsi_sysfs.c                     |  6 +++---
>   drivers/scsi/scsi_transport_iscsi.c           |  2 +-
>   drivers/sh/maple/maple.c                      |  4 ++--
>   drivers/siox/siox-core.c                      |  2 +-
>   drivers/slimbus/core.c                        |  4 ++--
>   drivers/soc/qcom/apr.c                        |  4 ++--
>   drivers/soundwire/bus_type.c                  |  6 +++---
>   drivers/spi/spi.c                             |  2 +-
>   drivers/spmi/spmi.c                           |  2 +-
>   drivers/ssb/main.c                            |  4 ++--
>   .../staging/fieldbus/anybuss/anybuss-client.h |  6 +-----
>   drivers/staging/fieldbus/anybuss/host.c       |  4 ++--
>   drivers/staging/greybus/gbphy.c               |  2 +-
>   .../interface/vchiq_arm/vchiq_bus.c           |  2 +-
>   drivers/staging/vme_user/vme.c                |  2 +-
>   drivers/tc/tc-driver.c                        |  6 +++---
>   drivers/tee/tee_core.c                        |  2 +-
>   drivers/thunderbolt/domain.c                  |  8 ++++----
>   drivers/tty/serdev/core.c                     |  2 +-
>   drivers/tty/serial/serial_base_bus.c          |  2 +-
>   drivers/usb/common/ulpi.c                     |  2 +-
>   drivers/usb/core/driver.c                     |  2 +-
>   drivers/usb/gadget/udc/core.c                 |  2 +-
>   drivers/usb/serial/bus.c                      |  2 +-
>   drivers/usb/typec/bus.c                       |  2 +-
>   drivers/vdpa/vdpa.c                           |  2 +-
>   drivers/vfio/mdev/mdev_driver.c               |  2 +-
>   drivers/virtio/virtio.c                       |  2 +-
>   drivers/xen/xenbus/xenbus.h                   |  2 +-
>   drivers/xen/xenbus/xenbus_probe.c             |  4 ++--
>   include/acpi/acpi_bus.h                       |  2 +-
>   include/linux/arm_ffa.h                       |  2 +-
>   include/linux/cdx/cdx_bus.h                   |  2 +-
>   include/linux/device/bus.h                    |  2 +-
>   include/linux/dfl.h                           |  2 +-
>   include/linux/eisa.h                          |  2 +-
>   include/linux/fsi.h                           |  2 +-
>   include/linux/fsl/mc.h                        |  2 +-
>   include/linux/gameport.h                      |  2 +-
>   include/linux/greybus.h                       |  2 +-
>   include/linux/hyperv.h                        |  6 +-----
>   include/linux/i2c.h                           |  2 +-
>   include/linux/i3c/device.h                    |  5 +----
>   include/linux/maple.h                         |  2 +-
>   include/linux/mcb.h                           |  5 +----
>   include/linux/mdio.h                          | 19 ++++++-------------
>   include/linux/mhi.h                           |  2 +-
>   include/linux/mhi_ep.h                        |  2 +-
>   include/linux/moxtet.h                        |  9 ++-------
>   include/linux/nd.h                            |  6 +-----
>   include/linux/pci-epf.h                       |  3 +--
>   include/linux/pci.h                           |  6 ++----
>   include/linux/phy.h                           |  2 +-
>   include/linux/pnp.h                           |  2 +-
>   include/linux/rio.h                           |  2 +-
>   include/linux/scmi_protocol.h                 |  2 +-
>   include/linux/serio.h                         |  2 +-
>   include/linux/slimbus.h                       |  2 +-
>   include/linux/soc/qcom/apr.h                  |  2 +-
>   include/linux/soundwire/sdw_type.h            |  2 +-
>   include/linux/spi/spi.h                       |  6 ++----
>   include/linux/ssb/ssb.h                       |  2 +-
>   include/linux/tc.h                            |  2 +-
>   include/linux/tee_drv.h                       |  2 +-
>   include/linux/virtio.h                        |  5 +----
>   include/scsi/scsi_transport_iscsi.h           |  2 +-
>   include/sound/ac97/codec.h                    |  5 +----
>   include/xen/xenbus.h                          |  5 +----
>   net/iucv/iucv.c                               |  2 +-
>   sound/ac97/bus.c                              |  4 ++--
>   sound/core/seq_device.c                       |  4 ++--
>   sound/hda/hda_bus_type.c                      |  2 +-
>   163 files changed, 268 insertions(+), 338 deletions(-)
> 

. . .

> diff --git a/drivers/greybus/core.c b/drivers/greybus/core.c
> index 95c09d4f3a86..c5569563bd03 100644
> --- a/drivers/greybus/core.c
> +++ b/drivers/greybus/core.c
> @@ -90,9 +90,9 @@ greybus_match_id(struct gb_bundle *bundle, const struct greybus_bundle_id *id)
>   	return NULL;
>   }
>   
> -static int greybus_match_device(struct device *dev, struct device_driver *drv)
> +static int greybus_match_device(struct device *dev, const struct device_driver *drv)
>   {
> -	struct greybus_driver *driver = to_greybus_driver(drv);
> +	const struct greybus_driver *driver = to_greybus_driver(drv);
>   	struct gb_bundle *bundle;
>   	const struct greybus_bundle_id *id;
>   

. . .

> diff --git a/drivers/staging/greybus/gbphy.c b/drivers/staging/greybus/gbphy.c
> index d827f03f5253..fe4f76da7f9c 100644
> --- a/drivers/staging/greybus/gbphy.c
> +++ b/drivers/staging/greybus/gbphy.c
> @@ -117,7 +117,7 @@ gbphy_dev_match_id(struct gbphy_device *gbphy_dev,
>   	return NULL;
>   }
>   
> -static int gbphy_dev_match(struct device *dev, struct device_driver *drv)
> +static int gbphy_dev_match(struct device *dev, const struct device_driver *drv)
>   {
>   	struct gbphy_driver *gbphy_drv = to_gbphy_driver(drv);
>   	struct gbphy_device *gbphy_dev = to_gbphy_dev(dev);

. . .

> diff --git a/include/linux/greybus.h b/include/linux/greybus.h
> index 634c9511cf78..4d58e27ceaf6 100644
> --- a/include/linux/greybus.h
> +++ b/include/linux/greybus.h
> @@ -64,7 +64,7 @@ struct greybus_driver {
>   
>   	struct device_driver driver;
>   };
> -#define to_greybus_driver(d) container_of(d, struct greybus_driver, driver)
> +#define to_greybus_driver(d) container_of_const(d, struct greybus_driver, driver)
>   
>   static inline void greybus_set_drvdata(struct gb_bundle *bundle, void *data)
>   {

. . .


