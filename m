Return-Path: <linux-kernel+bounces-401066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 333D19C158E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575F31C21865
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE01194A68;
	Fri,  8 Nov 2024 04:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1hJcQ8f"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE20322E;
	Fri,  8 Nov 2024 04:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731040653; cv=none; b=MDnO2ryZ5cHB2DHY4PNR2NlvcR5vO8RpqZUCaVboMk8SOX65HKj6jnT0TxFvjQlNOEVEc/1CTiu6S/42fmc1SSn1/PtpVdu1dVbd++DQ2ZgwnnCQpBLy+R7+j+uqR56aflCAAeUbHG5Sq5l2CMH0po0Zv9ZHx/ndNu+/D2WUFHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731040653; c=relaxed/simple;
	bh=po1qy1utAu+0nnVoWzfXbPIoHNcTde/hq4s8y1Zm1dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuTcI2lXiYSLwvKen158VI1Yjs7rNAtjzBw+teTWV1bmXMOe0xpBIlhvGC7RU2/PBxsALSy5aZCuPx4z8or9FNU9s2yYk/2MKBnhOqreKNX0ZTE1g0cDK8scjqNsNZu6AKm/NbtAGAg1LrYYTXrF/3vVi+CdAytP7OI4f/1fPRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1hJcQ8f; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb5743074bso14642181fa.1;
        Thu, 07 Nov 2024 20:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731040649; x=1731645449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcKSOGfYZJL+StkfOdUbsXUXePDfExi+8RQpvO/dDiY=;
        b=m1hJcQ8fOQKe2XbMR25u7+P7SHntL4fwS9nuQznVX0b5VpgBUx+stwvL3+B/dUUksj
         da4BJfBC7LoboB5UhvQV2+yzCs9KorLQXKfHIVzuD58MsfqPI1B4gBqULQ0VfCHTIx6O
         OixaZXIExoG5/tAu6oSFDNUUR9otO8fZc9wB3ySCap7FrdgOn4jf00xByluU+907awH8
         +c4GwysKU56h6cDJKXt6G6V0VkSNsyXkEZSdRWF1mD4jzARpxXk7C1+EqwHBGABSMKT8
         IbeMFnYTFs6l878I4Ypqboa0NXmleLNOhigqcMcSJ0hIENwWOjx/9vvs3VSgZZvDOLJy
         qR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731040649; x=1731645449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcKSOGfYZJL+StkfOdUbsXUXePDfExi+8RQpvO/dDiY=;
        b=Ud51No9z5MdWref3+KeT5HLZErp27n/A7WMVYq7pwI/r0DScadPLN5sYsqHIfO+eYW
         lPyHtbr5nr/FlWf1bma27N7kKtht2aDGOsx+LLso/4WEyefqreKtTh4LacRkc6oOAlJA
         fSVgFkHI92ezT/IlDoldZz1OAUOsdjsMeznZ/aKbpxXtmHu64y8UDSIMQBefPPKNYmOT
         loSBS7U8uP1KERsXt7B+YEJqUfJns4WsHPJ8ZCsl8QmeTyfWOWP+GpaaaWtlF2mbMpxf
         /udtg5HYL09QhvwkjnUc9GIlzb8JWluEgjuRQQ+WfAaFtiWyaSjDOYgJs6ZLJYmNRg9u
         EKeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4n+/PiPvLsJMQJvRPDdFhfQR7oT0aEiLXCF+XKfgX6OFxqAQKKvP/MonwVLC1HvjFHMe4yd8whwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbReEsokjgpTruSP08CRzuUSlpAO2DB/OHE9JgCHmgZXYD1Tjg
	JtG3VsfjqMgNmoAf6wxrw8MzdhBNOwLq3AjGE7eBkqopqKjRsxmTNU0Zt+CABv8rR/mCKEJ3bjF
	8Xu1+oy49F/74Clam7cF0Ejn8jaA=
X-Google-Smtp-Source: AGHT+IHdWtZXE7g8JFOmVWyYlE+tt2UXzb1/L0Go8cued0BEV1AAC//p6AvA+JpBtVIcL2VzATgcrMaVUu6tEruscmQ=
X-Received: by 2002:a2e:bc8b:0:b0:2fa:faed:e86b with SMTP id
 38308e7fff4ca-2ff20981669mr3605541fa.13.1731040649112; Thu, 07 Nov 2024
 20:37:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241103025436.69196-1-yesanishhere@gmail.com>
In-Reply-To: <20241103025436.69196-1-yesanishhere@gmail.com>
From: anish kumar <yesanishhere@gmail.com>
Date: Thu, 7 Nov 2024 20:37:17 -0800
Message-ID: <CABCoZhANKY5wjc=NqAd64Fhmdjx1k-x=zVkU+ySRDRvK0Gj2iw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: extcon: add documentation for Extcon subsystem
To: myungjoo.ham@samsung.com, cw00.choi@samsung.com, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Myungjoo/Chanwoo,

Wondering if you have any comments?

On Sat, Nov 2, 2024 at 7:54=E2=80=AFPM anish kumar <yesanishhere@gmail.com>=
 wrote:
>
> The Extcon (External Connector) subsystem driver lacked proper
> documentation. This commit adds comprehensive documentation
> explaining the purpose, key components, and usage of the Extcon
> framework.
>
> The new documentation includes:
> - An overview of the Extcon subsystem
> - Descriptions of key structures
> - Explanations of core functions
> - Information on the sysfs interface
> - A usage example for driver developers
>
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---
>  Documentation/driver-api/extcon.rst | 255 ++++++++++++++++++++++++++++
>  Documentation/driver-api/index.rst  |   1 +
>  MAINTAINERS                         |   1 +
>  3 files changed, 257 insertions(+)
>  create mode 100644 Documentation/driver-api/extcon.rst
>
> diff --git a/Documentation/driver-api/extcon.rst b/Documentation/driver-a=
pi/extcon.rst
> new file mode 100644
> index 000000000000..d3217b9cdcd5
> --- /dev/null
> +++ b/Documentation/driver-api/extcon.rst
> @@ -0,0 +1,255 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Extcon Device Subsystem
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Extcon (External Connector) subsystem provides a unified framework f=
or
> +managing external connectors in Linux systems. It allows drivers to repo=
rt
> +the state of external connectors and provides a standardized interface f=
or
> +userspace to query and monitor these states.
> +
> +Extcon is particularly useful in modern devices with multiple connectivi=
ty
> +options, such as smartphones, tablets, and laptops. It helps manage vari=
ous
> +types of connectors, including:
> +
> +1. USB connectors (e.g., USB-C, micro-USB)
> +2. Charging ports (e.g., fast charging, wireless charging)
> +3. Audio jacks (e.g., 3.5mm headphone jack)
> +4. Video outputs (e.g., HDMI, DisplayPort)
> +5. Docking stations
> +
> +Real-world examples:
> +
> +1. Smartphone USB-C port:
> +   A single USB-C port on a smartphone can serve multiple functions. Ext=
con
> +   can manage the different states of this port, such as:
> +   - USB data connection
> +   - Charging (various types like fast charging, USB Power Delivery)
> +   - Audio output (USB-C headphones)
> +   - Video output (USB-C to HDMI adapter)
> +
> +2. Laptop docking station:
> +   When a laptop is connected to a docking station, multiple connections=
 are
> +   made simultaneously. Extcon can handle the state changes for:
> +   - Power delivery
> +   - External displays
> +   - USB hub connections
> +   - Ethernet connectivity
> +
> +3. Wireless charging pad:
> +   Extcon can manage the state of a wireless charging connection, allowi=
ng
> +   the system to respond appropriately when a device is placed on or rem=
oved
> +   from the charging pad.
> +
> +4. Smart TV HDMI ports:
> +   In a smart TV, Extcon can manage multiple HDMI ports, detecting when
> +   devices are connected or disconnected, and potentially identifying th=
e
> +   type of device (e.g., gaming console, set-top box, Blu-ray player).
> +
> +The Extcon framework simplifies the development of drivers for these com=
plex
> +scenarios by providing a standardized way to report and query connector
> +states, handle mutually exclusive connections, and manage connector
> +properties. This allows for more robust and flexible handling of externa=
l
> +connections in modern devices.
> +
> +Key Components
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +extcon_dev
> +----------
> +
> +The core structure representing an Extcon device::
> +
> +    struct extcon_dev {
> +        const char *name;
> +        const unsigned int *supported_cable;
> +        const u32 *mutually_exclusive;
> +
> +        /* Internal data */
> +        struct device dev;
> +        unsigned int id;
> +        struct raw_notifier_head nh_all;
> +        struct raw_notifier_head *nh;
> +        struct list_head entry;
> +        int max_supported;
> +        spinlock_t lock;
> +        u32 state;
> +
> +        /* Sysfs related */
> +        struct device_type extcon_dev_type;
> +        struct extcon_cable *cables;
> +        struct attribute_group attr_g_muex;
> +        struct attribute **attrs_muex;
> +        struct device_attribute *d_attrs_muex;
> +    };
> +
> +Key fields:
> +
> +- ``name``: Name of the Extcon device
> +- ``supported_cable``: Array of supported cable types
> +- ``mutually_exclusive``: Array defining mutually exclusive cable types
> +  This field is crucial for enforcing hardware constraints. It's an arra=
y of
> +  32-bit unsigned integers, where each element represents a set of mutua=
lly
> +  exclusive cable types. The array should be terminated with a 0.
> +
> +  For example:
> +
> +  ::
> +
> +      static const u32 mutually_exclusive[] =3D {
> +          BIT(0) | BIT(1),  /* Cable 0 and 1 are mutually exclusive */
> +          BIT(2) | BIT(3) | BIT(4),  /* Cables 2, 3, and 4 are mutually =
exclusive */
> +          0  /* Terminator */
> +      };
> +
> +  In this example, cables 0 and 1 cannot be connected simultaneously, an=
d
> +  cables 2, 3, and 4 are also mutually exclusive. This is useful for
> +  scenarios like a single port that can either be USB or HDMI, but not b=
oth
> +  at the same time.
> +
> +  The Extcon core uses this information to prevent invalid combinations =
of
> +  cable states, ensuring that the reported states are always consistent
> +  with the hardware capabilities.
> +
> +- ``state``: Current state of the device (bitmap of connected cables)
> +
> +
> +extcon_cable
> +------------
> +
> +Represents an individual cable managed by an Extcon device::
> +
> +    struct extcon_cable {
> +        struct extcon_dev *edev;
> +        int cable_index;
> +        struct attribute_group attr_g;
> +        struct device_attribute attr_name;
> +        struct device_attribute attr_state;
> +        struct attribute *attrs[3];
> +        union extcon_property_value usb_propval[EXTCON_PROP_USB_CNT];
> +        union extcon_property_value chg_propval[EXTCON_PROP_CHG_CNT];
> +        union extcon_property_value jack_propval[EXTCON_PROP_JACK_CNT];
> +        union extcon_property_value disp_propval[EXTCON_PROP_DISP_CNT];
> +        DECLARE_BITMAP(usb_bits, EXTCON_PROP_USB_CNT);
> +        DECLARE_BITMAP(chg_bits, EXTCON_PROP_CHG_CNT);
> +        DECLARE_BITMAP(jack_bits, EXTCON_PROP_JACK_CNT);
> +        DECLARE_BITMAP(disp_bits, EXTCON_PROP_DISP_CNT);
> +    };
> +
> +Core Functions
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. kernel-doc:: drivers/extcon/extcon.c
> +   :identifiers: extcon_get_state
> +
> +.. kernel-doc:: drivers/extcon/extcon.c
> +   :identifiers: extcon_set_state
> +
> +.. kernel-doc:: drivers/extcon/extcon.c
> +   :identifiers: extcon_set_state_sync
> +
> +.. kernel-doc:: drivers/extcon/extcon.c
> +   :identifiers: extcon_get_property
> +
> +
> +Sysfs Interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Extcon devices expose the following sysfs attributes:
> +
> +- ``name``: Name of the Extcon device
> +- ``state``: Current state of all supported cables
> +- ``cable.N/name``: Name of the Nth supported cable
> +- ``cable.N/state``: State of the Nth supported cable
> +
> +Usage Example
> +-------------
> +
> +.. code-block:: c
> +
> +    #include <linux/module.h>
> +    #include <linux/platform_device.h>
> +    #include <linux/extcon.h>
> +
> +    struct my_extcon_data {
> +        struct extcon_dev *edev;
> +        struct device *dev;
> +    };
> +
> +    static const unsigned int my_extcon_cable[] =3D {
> +        EXTCON_USB,
> +        EXTCON_USB_HOST,
> +        EXTCON_NONE,
> +    };
> +
> +    static int my_extcon_probe(struct platform_device *pdev)
> +    {
> +        struct my_extcon_data *data;
> +        int ret;
> +
> +        data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +        if (!data)
> +            return -ENOMEM;
> +
> +        data->dev =3D &pdev->dev;
> +
> +        /* Initialize extcon device */
> +        data->edev =3D devm_extcon_dev_allocate(data->dev, my_extcon_cab=
le);
> +        if (IS_ERR(data->edev)) {
> +            dev_err(data->dev, "Failed to allocate extcon device\n");
> +            return PTR_ERR(data->edev);
> +        }
> +
> +        /* Register extcon device */
> +        ret =3D devm_extcon_dev_register(data->dev, data->edev);
> +        if (ret < 0) {
> +            dev_err(data->dev, "Failed to register extcon device\n");
> +            return ret;
> +        }
> +
> +        platform_set_drvdata(pdev, data);
> +
> +        /* Example: Set initial state */
> +        extcon_set_state_sync(data->edev, EXTCON_USB, true);
> +
> +        dev_info(data->dev, "My extcon driver probed successfully\n");
> +        return 0;
> +    }
> +
> +    static int my_extcon_remove(struct platform_device *pdev)
> +    {
> +        struct my_extcon_data *data =3D platform_get_drvdata(pdev);
> +
> +        /* Example: Clear state before removal */
> +        extcon_set_state_sync(data->edev, EXTCON_USB, false);
> +
> +        dev_info(data->dev, "My extcon driver removed\n");
> +        return 0;
> +    }
> +
> +    static const struct of_device_id my_extcon_of_match[] =3D {
> +        { .compatible =3D "my,extcon-device", },
> +        { },
> +    };
> +    MODULE_DEVICE_TABLE(of, my_extcon_of_match);
> +
> +    static struct platform_driver my_extcon_driver =3D {
> +        .driver =3D {
> +            .name =3D "my-extcon-driver",
> +            .of_match_table =3D my_extcon_of_match,
> +        },
> +        .probe =3D my_extcon_probe,
> +        .remove =3D my_extcon_remove,
> +    };
> +
> +    module_platform_driver(my_extcon_driver);
> +
> +This example demonstrates:
> +---------------------------
> +
> +- Defining supported cable types (USB and USB Host in this case).
> +- Allocating and registering an extcon device.
> +- Setting an initial state for a cable (USB connected in this example).
> +- Clearing the state when the driver is removed.
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-ap=
i/index.rst
> index 7f83e05769b4..16e2c4ec3c01 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -86,6 +86,7 @@ Subsystem-specific APIs
>     dmaengine/index
>     dpll
>     edac
> +   extcon
>     firmware/index
>     fpga/index
>     frame-buffer
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c27f3190737f..7a8739ed9d46 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8572,6 +8572,7 @@ L:        linux-kernel@vger.kernel.org
>  S:     Maintained
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.=
git
>  F:     Documentation/devicetree/bindings/extcon/
> +F:     Documentation/driver-api/extcon.rst
>  F:     Documentation/firmware-guide/acpi/extcon-intel-int3496.rst
>  F:     drivers/extcon/
>  F:     include/linux/extcon.h
> --
> 2.39.3 (Apple Git-146)
>

