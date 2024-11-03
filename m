Return-Path: <linux-kernel+bounces-393680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 529829BA3F8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 05:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3DE1F214D3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 04:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031B012B143;
	Sun,  3 Nov 2024 04:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqWweniy"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BCB320B;
	Sun,  3 Nov 2024 04:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730609403; cv=none; b=L5K4I9bjHsPx+HmgdGsjoQID+Gmmv3nz9ZFhbK5v0W2mDvbudUP+mH2vxs5KtXpA1pDpJNb14ksabVaN3O5qGzdDMQIdNoV1TiBKNwtbbircqev8RCS0Dqr/qiesTzOw9BYoojQRclvKyBxMuw0jcxK0mRzYvKd70oab9JtX6/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730609403; c=relaxed/simple;
	bh=ShtYHLi/X+3YSnxDBeeYSHf94uf1mV67g62pb3RNrNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgJlTWrZCidgqrrWQb769c2aAKs0yeO7Vz7X4yrOVkgH9dINAUJ5XCuXES8bZD59uvMSzjqT+64tN8Tu5H8Lf7MeBLkZDF6YXVIOUd8BNA1MQ6MKU9JdXiGH3aMULJde4fVYBEqbM2j+8VGtWQ9dtaJB+vEVhMkjEcAMuxoObO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqWweniy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cd76c513cso24743175ad.3;
        Sat, 02 Nov 2024 21:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730609401; x=1731214201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7wVzn+xb+2YuoTCQxzodJrFp6+yc8HkfMHpVQTbRuQc=;
        b=AqWweniy5WkdRtpnCgQ5ucajwvTrxmfmxn265NfLHkLUWdr9UaoBxvARCM1LZyghl/
         xwuCGTOmd0yt+9xGgckGZyXZJtr/Xh6gyUkuao+68YTjkiXMEQelgAIJUuxPMrQQn3fd
         +hDi4mB9dY3wSmEadVQhUGUmlLoPlpVP1Vx8vNMwom6dLZtzZy95a4tj3jzlZGLT5ywc
         gnIFdLZb1UebvYwrqhqrZHPe5QrV2zChl0Xh0TRvduLy99RBW7lT5jDsJP2PbggNnSM5
         p55tg0x2JEa4+wVIhL1ulgmlWHQxwkGKCsiC+4rztNbPb4cAkd9qP+DqNbabLs8Idi0A
         bJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730609401; x=1731214201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wVzn+xb+2YuoTCQxzodJrFp6+yc8HkfMHpVQTbRuQc=;
        b=ELEe0yoYW3zzI8XIjqSRklScgzKYPJ6Gn9M5g0qOKqh43sLxXTDJ2gCqiXrX+UBqTa
         rVWXCcp67Mo/3V1g/AssO2Jou+OQVBVbWiklMzbEwjfyfsmMj8fXaOIBLjUxzphI+OvG
         ATGGcBoWqVuR+TLIVeV1MqHQkgEsuocqcx2RY4Cpf8nffrg1NHKvHhHqrpY0k4R5WdNK
         hBodfOH4CI15Cab/EWBjG8CnpJAj47cwOf0CiJsO4heT3VaSZU2ynv9fTeNXZnUvIBB8
         +YWE3KiCWU1OHp7RpR1UtNu3Ofy4cAwd+OpSEehThwK5J04gg+jq6pNcV0m/t/Kry4Bj
         nA4g==
X-Forwarded-Encrypted: i=1; AJvYcCU7kcbzyyLl17meBUuESaHFqWklmGfJdMGW00aB93jFHvOGcly1YTysydRqMWFMQVmxRhPgHuxXtkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqffL5h1+1yBvB7Jcv71fFsI4KZfYev0OK2c+T7Mpj7SNU47w4
	pX7qZOdMutzSWzAhxx9V66RDpBlrLy/HdETq62uY/Pr34Si4j16Q
X-Google-Smtp-Source: AGHT+IEgSjmnbPh1cCqltPGtq6HnexOGphtkG2tMQLh7GgaGPJpOwUadSzwlX3R2QXCSQtxk7r0lNw==
X-Received: by 2002:a17:902:d511:b0:20c:bea0:8d10 with SMTP id d9443c01a7336-210f751ae6emr238976195ad.20.1730609400782;
        Sat, 02 Nov 2024 21:50:00 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a67f4sm40960165ad.171.2024.11.02.21.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 21:49:59 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 717564207D11; Sun, 03 Nov 2024 11:49:57 +0700 (WIB)
Date: Sun, 3 Nov 2024 11:49:57 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: anish kumar <yesanishhere@gmail.com>, myungjoo.ham@samsung.com,
	cw00.choi@samsung.com, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: extcon: add documentation for Extcon
 subsystem
Message-ID: <ZycA9fxqYqnHdTns@archie.me>
References: <20241103025436.69196-1-yesanishhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="euYsDYEvoHUQmZcF"
Content-Disposition: inline
In-Reply-To: <20241103025436.69196-1-yesanishhere@gmail.com>


--euYsDYEvoHUQmZcF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 02, 2024 at 07:54:36PM -0700, anish kumar wrote:
> The Extcon (External Connector) subsystem driver lacked proper
> documentation. This commit adds comprehensive documentation
> explaining the purpose, key components, and usage of the Extcon
> framework.

"Document the external connector subsystem. This includes ..."

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
> +   devices are connected or disconnected, and potentially identifying the
> +   type of device (e.g., gaming console, set-top box, Blu-ray player).

List items are outputted as long-running paragraphs instead, so I have to
add appropriate blank line separators:

---- >8 ----
diff --git a/Documentation/driver-api/extcon.rst b/Documentation/driver-api=
/extcon.rst
index d3217b9cdcd575..9e36dc5c1b66c0 100644
--- a/Documentation/driver-api/extcon.rst
+++ b/Documentation/driver-api/extcon.rst
@@ -23,27 +23,33 @@ types of connectors, including:
 Real-world examples:
=20
 1. Smartphone USB-C port:
+
    A single USB-C port on a smartphone can serve multiple functions. Extcon
    can manage the different states of this port, such as:
+
    - USB data connection
    - Charging (various types like fast charging, USB Power Delivery)
    - Audio output (USB-C headphones)
    - Video output (USB-C to HDMI adapter)
=20
 2. Laptop docking station:
+
    When a laptop is connected to a docking station, multiple connections a=
re
    made simultaneously. Extcon can handle the state changes for:
+  =20
    - Power delivery
    - External displays
    - USB hub connections
    - Ethernet connectivity
=20
 3. Wireless charging pad:
+
    Extcon can manage the state of a wireless charging connection, allowing
    the system to respond appropriately when a device is placed on or remov=
ed
    from the charging pad.
=20
 4. Smart TV HDMI ports:
+
    In a smart TV, Extcon can manage multiple HDMI ports, detecting when
    devices are connected or disconnected, and potentially identifying the
    type of device (e.g., gaming console, set-top box, Blu-ray player).

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

Can you explain in detail steps on the usage example above?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--euYsDYEvoHUQmZcF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZycA9QAKCRD2uYlJVVFO
o3QZAQCUU/S0S+aGlM4Er4C8xMsJo2tzHw5Q3fbMV5alaPWWCwD9HfShXBGqFlRz
i15gG8FYU6gnhd/rC8TFhBfdVhc/7gE=
=a9bx
-----END PGP SIGNATURE-----

--euYsDYEvoHUQmZcF--

