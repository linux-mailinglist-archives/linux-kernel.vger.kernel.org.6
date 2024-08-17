Return-Path: <linux-kernel+bounces-290843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD17495596A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 21:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B526282D0D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 19:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A4D15534E;
	Sat, 17 Aug 2024 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akigKAij"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9001D84A51;
	Sat, 17 Aug 2024 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723923049; cv=none; b=kcQ7hGkF2tP5eHqtA7txtzfLzRXtjDYkoGqHcH9irLXg8SoVPrGbopyI496tF5+pYTOX4zUqmqK3EhEE0/1dFopeFi/7SOtmTKsnGS8cWnPTkSTkGx1sclwm86CepQ5VnZNfmFVkWqRw1/Adjxw9PJkWcUoKGiYqE8QYi2iPJmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723923049; c=relaxed/simple;
	bh=Pm4Ytukf0XTma7RZxCSO7MjTvY62x2OWfUIv9D282CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWeJtyFzBH6gvPi9SwSzE/8+7CNUcqrfczBkKUPe+jf4aYdunf006ssc0a7GHsjcxOgdbdor0jXTE/xutWEwAkjmwih8kDP06CMAK8tBff9i6+dsZPyLsz01EWWbd/nO3MCZV+iwWjQTxSl3iXaBnae90vqgmjw7TidvC46tq3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akigKAij; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5beb6ea9ed6so2997768a12.1;
        Sat, 17 Aug 2024 12:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723923046; x=1724527846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJC795JTs2Ekt9gDVD2gEbeCAt29WPxzke9UPmqpJtU=;
        b=akigKAijAvyuXVxTubnmeiP3huoHG5WRhZbNkJrvLgIzNXxmBoxA7YXbHG5ZsaRtgi
         vI3pZ2Ggd4sByMyfotNVDdeCkXVMY1rsbS1OP911rkgdmV85GMeKKSMqzHkfKCmhEO6B
         fcF5sDYlhYNXDxS9Fos5piMiBdFtsoZnBjLQj9dspl3STy/Eny/Vcv6pPMNcsvLBSLeA
         hZRLNKloNeSKjwHmzh10aeORyMhnkupf0WX0DwLdOrG1WyTQ2wV3H2PL7Jq8hol09ClY
         uLcyztmsvVhzG2DAnr2ZQkCEv+3skDvQzDEnNmwpA5qGqfQVN0MsY36TT1ggQLEmxA+3
         T+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723923046; x=1724527846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJC795JTs2Ekt9gDVD2gEbeCAt29WPxzke9UPmqpJtU=;
        b=c3Z37XTb5pAwMaJP2Fk+o7fbmIIMKusKWgAT0hEpV6yX5hIRmSdNZqZ8xbTkFhq1jv
         GYT3Qq4TqYzDHjpaiwhm8zKbSVG2tuJ8MKgF5W8Rrg2+cRVTQMc7a5ftCUkL1MuEUd8x
         KJC2VeMj7+k7ljjNSR9vcxnpJz7mjCBTlvOoSoiiguaStMXURbA38ZSfFSG3dwj1zIMb
         z99TmP0x5KS+zvh9JOewXDkuqOd9PJd2IByKzEtVNTdD9xkus/+elt9dsvZieRUpjGRK
         rSYir6C+WAgswfWJKvR+Q/epTsFyWdUUMgKFoKdLtGOv9t/jnP7gyErNb6CFH3uTGldt
         nAzg==
X-Forwarded-Encrypted: i=1; AJvYcCVLZ6uIGtHERlUaLw+pIUx52PHdqjL7cfTIFpPXVrQ8JerOAOPESmm1ZALkC5GXvgunWQ1jXqT96ad8a9KC6fhpEqfnDCZTZk8W46DzdunkCFGnQWT4B2oASGkYnsHkAePV48SfFIobjg==
X-Gm-Message-State: AOJu0YxJEm6D/QIX+NNNESiw9JJ7jsrf/pxCUVayj1FaGY+Aut82iQi/
	LCT+g505lka8H+k5jDmB9VsSxidNpPtZL81Wgk/z8dVmomaXcvyjqvVHayIFJFyqKwKeygp1XOG
	bQyuchSQBgaxBIioRqy5cDVJrHg==
X-Google-Smtp-Source: AGHT+IFbUR16kAsVyKpURPOC69k6sALRGq1kb8PlxvVjzFANtYa6tdmHkwMpCTolk7kRmB7moSOMuF6h0epC6JVlrkY=
X-Received: by 2002:a17:906:d265:b0:a7d:3a85:7a3e with SMTP id
 a640c23a62f3a-a8392a494a3mr425085466b.59.1723923045436; Sat, 17 Aug 2024
 12:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817124140.800637-1-erezgeva@nwtime.org>
In-Reply-To: <20240817124140.800637-1-erezgeva@nwtime.org>
From: Erez <erezgeva2@gmail.com>
Date: Sat, 17 Aug 2024 21:30:08 +0200
Message-ID: <CANeKEMO+8=fVx9EXpPoXaLPen79W=7kBTghw3L+9dLwOFOWWoQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Add support for SPI-NOR Macronix OTP
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Rob Herring <robh@kernel.org>
Cc: linux-mtd@lists.infradead.org, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Looking in Documentation/devicetree/bindings/mtd/mtd.yaml

I see you are defining OTP in a different way, as partitions.
Each partition is an OTP region which can be user or factory mode
(since many chips do not define or enforce it).

While I try to define the OTP parameters.

I wonder what you think?
Should the parameter be in the partitions?
Do we wish to support asymmetric OTP?
I only found asymmetric OTP (OTP with different region sizes) with old
chips. But perhaps I missed it.

Erez


diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 6e3afb42926e..5fde51309b93 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -90,6 +90,47 @@ properties:
       the SRWD bit while writing the status register. WP# signal hard
strapped to GND
       can be a valid use case.

+  opt_n_regions:
+    type: u32
+    description:
+      Some flash devices need OTP parameters in the device tree.
+      As we can not deduce the parameters based on JEDEC ID,
+       or SFDP.
+      This parameter indicates the number of OTP regions.
+      The value must be larger than 1 and mandatory for OTP.
+
+  otp_len:
+    type: u32
+    description:
+      Some flash devices need OTP parameters in the device tree.
+      As we can not deduce the parameters based on JEDEC ID,
+       or SFDP.
+      This parameter indicates the size (length) in bytes of an OTP region.
+      Currently the driver supports symmetric OTP,
+       which means all regions must use the same size.
+      The value must be positive and mandatory for OTP.
+
+  otp_offset:
+    type: u32
+    description:
+      Some flash devices need OTP parameters in the device tree.
+      As we can not deduce the parameters based on JEDEC ID,
+       or SFDP.
+      This parameter indicates the offset in bytes of
+       an OTP region relative to its previous.
+      User can omit it if the offset equals the length.
+      Or in case we have a single OTP region.
+
+  otp_base:
+    type: u32
+    description:
+      Some flash devices need OTP parameters in the device tree.
+      As we can not deduce the parameters based on JEDEC ID,
+       or SFDP.
+      This parameter indicates the base in bytes of the first OTP region.
+      User can omit it if the base is zero.
+      I.e. the address of the first OTP region starts from 0.
+
   reset-gpios:
     description:
       A GPIO line connected to the RESET (active low) signal of the device.



On Sat, 17 Aug 2024 at 14:42, Erez Geva <erezgeva@nwtime.org> wrote:
>
> From: Erez Geva <ErezGeva2@gmail.com>
>
> Add support for SPI-NOR Macronix OTP.
> And add MX25L12833F with OTP.
>
> TODO:
> - Test OTP with 'flash_otp_write' and 'flash_otp_lock'
> - Question: Do we need documentation on new DT OTP parameters?
>
> v2:
> Improve description of mx25l12833f.
> Add note about mx25l12833f using the same JEDEC ID as mx25l12805d.
>
> v3:
> Improve description.
> Rename _nor_send_cmd() to spi_nor_send_cmd_internal()
> Remove MX25L12833F specific changes.
> Add reading SFDP to all Macronix chips.
> Add support of reading OTP parameters from device tree.
> Reorgenize patches to 2 SPI-NOR patches and 2 Macronix patches
> Testing with MX25L3233F using BeagleBone Black.
> Test results are in "mtd: spi-nor: macronix: add manufacturer flags" patch
>
> Erez Geva (4):
>   mtd: spi-nor: core: add manufacturer flags
>   mtd: spi-nor: core: add generic functions
>   mtd: spi-nor: macronix: add support for OTP
>   mtd: spi-nor: macronix: add manufacturer flags
>
>  drivers/mtd/spi-nor/core.c     | 166 ++++++++++++++++++++++-------
>  drivers/mtd/spi-nor/core.h     |  34 ++----
>  drivers/mtd/spi-nor/macronix.c | 186 +++++++++++++++++++++++++++++++++
>  drivers/mtd/spi-nor/otp.c      |   6 +-
>  drivers/mtd/spi-nor/winbond.c  |   2 +-
>  include/linux/mtd/spi-nor.h    |  10 ++
>  6 files changed, 336 insertions(+), 68 deletions(-)
>
> --
> 2.39.2
>

