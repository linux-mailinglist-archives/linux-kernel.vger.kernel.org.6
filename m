Return-Path: <linux-kernel+bounces-283030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB14094EC2A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9E82823D3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52C91779BB;
	Mon, 12 Aug 2024 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9v3pRrq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB63114EC53
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723463872; cv=none; b=BD1DTZm0xZiR3YoT4kw+2V8bMDSsCoKW/knRM1r6ofqDqWVxi/Ld2fpZmNUcu6NsJPDJ8hdSaihO8stw2rP6PnDQo1FcP7PmrWpTfMT8WGZPke29esbjJeO2qLfRT6N9rXZCMEnJ+C69tVrUxiFCqIbhYBKC/J6rbqf5JAPyLc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723463872; c=relaxed/simple;
	bh=D7QbvmiEPoFstypzdIaQh9RC3kieLO+YfCjReE5a9IM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWWH8IfVJEOmg29kuXUkNyMwFnIbWBOWAuKrvVudd+nbfvGmAT743FtgVjSgRuB7HOAOVguYP7w81arFg/Hba/f30T40ryozKu7NiIypLsM8olhyyqByGt4r10OTXwRXsxn9TOM3MMcdbYttBu4kjDDrkTXCdmYERLyWDD7W0n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f9v3pRrq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723463869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SpJndEgom61tK7M4GAuqbEtbuGe7It7d4qf5OxcAq8U=;
	b=f9v3pRrqvxIaeu0d9wK3dW90zcev6TChQjH1VW/LA+8qy4nrJALg9DBOHFZwyYHpBYzRoL
	bH9xytv1BxEfal/Zav4VYrBT7SaGVy45ViEC5KfB3x6UWrtKONJjQ4BUI0RIyKP0nAb4sm
	R7xW3NJFl5GNk2PBhdNp6zhANms/OQs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-e7ZKGvK7MvCqRZPhIz-J3A-1; Mon, 12 Aug 2024 07:57:48 -0400
X-MC-Unique: e7ZKGvK7MvCqRZPhIz-J3A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280f233115so29186965e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 04:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723463867; x=1724068667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpJndEgom61tK7M4GAuqbEtbuGe7It7d4qf5OxcAq8U=;
        b=LUvAMnAn9yfLMuWWQOmd4cDhrgPhaMbbvoTgiSW5kxHAtKeIpe9mhGGmMOsoiMxPS5
         qy1s83zN7kfJQ7eAOvrd6kgih8e+dADYNziEROfkuHJu20/+IMT4bZDUE3JPQDjZZZHm
         0d4I26Be2o15AWs5FwUGzRgAVmggp17ryf+Qggx1xa5R0S2IDTtyGnEqVs75V2PbL8y6
         6z3CuI4HVdg3j6qJG8sIMpmrLsbYN0mZdx3I8mCv2om09FPgYkKmCD68SItzzgvCM1aF
         eH5AFEuCiTpkltN8im3XMfM4PJNshHrTbjwhhz5FQENlxlL3DXUev59IbNyr/uQi5iTm
         lh6w==
X-Forwarded-Encrypted: i=1; AJvYcCVKnzh7SSRW/ryG2oZNKsnYM3cC3aMab9zkGgoPZmCvFakYq+6d8snfdPkQcX0F2Q1AGiC7utP8ANF+e4I+L/8gI+o8wjlEaoUD83EX
X-Gm-Message-State: AOJu0YxXlAshQkxuCWmxjEFkVD+BBVZxlmMRZv8HnPjkiWCMPcYHlDNz
	oLaRkx56Ly73xyRIrr++Tw6zcK8VaUYmLcfGl2jp/sBwgozKXMKVkAJTm1JbGvsMCLXnEeadxBp
	B8m6ec2kNNNlWtRqTErzSEl2YmeuuJ0+GNd/BE4AAzl9fa1hIUbQvyzL4LBg8Cg==
X-Received: by 2002:a05:600c:1e2a:b0:426:593c:9351 with SMTP id 5b1f17b1804b1-429d47f7044mr1143155e9.6.1723463866809;
        Mon, 12 Aug 2024 04:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbOH34v3VEOn6QS/EhIQpUgtEPbst67Vw1IN6JOWDjpCL0mrQ5nSf1+YlWJIeTbBCPIOUglw==
X-Received: by 2002:a05:600c:1e2a:b0:426:593c:9351 with SMTP id 5b1f17b1804b1-429d47f7044mr1142955e9.6.1723463866312;
        Mon, 12 Aug 2024 04:57:46 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c751a554sm102720295e9.22.2024.08.12.04.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 04:57:45 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:57:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 04/10] qapi/ghes-cper: add an interface to do generic
 CPER error injection
Message-ID: <20240812135744.644deaa9@imammedo.users.ipa.redhat.com>
In-Reply-To: <87799362699e4349ce4a44f3d25698d5764735c6.1723119423.git.mchehab+huawei@kernel.org>
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
	<87799362699e4349ce4a44f3d25698d5764735c6.1723119423.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu,  8 Aug 2024 14:26:30 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Creates a QMP command to be used for generic ACPI APEI hardware error
> injection (HEST) via GHESv2.
>=20
> The actual GHES code will be added at the followup patch.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  MAINTAINERS              |  7 +++++
>  hw/acpi/Kconfig          |  5 ++++
>  hw/acpi/ghes_cper.c      | 45 ++++++++++++++++++++++++++++++++
>  hw/acpi/ghes_cper_stub.c | 19 ++++++++++++++
>  hw/acpi/meson.build      |  2 ++
>  hw/arm/Kconfig           |  5 ++++
>  include/hw/acpi/ghes.h   |  7 +++++
>  qapi/ghes-cper.json      | 55 ++++++++++++++++++++++++++++++++++++++++
>  qapi/meson.build         |  1 +
>  qapi/qapi-schema.json    |  1 +
>  10 files changed, 147 insertions(+)
>  create mode 100644 hw/acpi/ghes_cper.c
>  create mode 100644 hw/acpi/ghes_cper_stub.c
>  create mode 100644 qapi/ghes-cper.json
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10af21263293..a0c36f9b5d0c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2077,6 +2077,13 @@ F: hw/acpi/ghes.c
>  F: include/hw/acpi/ghes.h
>  F: docs/specs/acpi_hest_ghes.rst
> =20
> +ACPI/HEST/GHES/ARM processor CPER
> +R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +S: Maintained
> +F: hw/arm/ghes_cper.c
> +F: hw/acpi/ghes_cper_stub.c
> +F: qapi/ghes-cper.json
> +
>  ppc4xx
>  L: qemu-ppc@nongnu.org
>  S: Orphan
> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
> index e07d3204eb36..73ffbb82c150 100644
> --- a/hw/acpi/Kconfig
> +++ b/hw/acpi/Kconfig
> @@ -51,6 +51,11 @@ config ACPI_APEI
>      bool
>      depends on ACPI
> =20
> +config GHES_CPER
> +    bool
> +    depends on ACPI_APEI
> +    default y
> +
>  config ACPI_PCI
>      bool
>      depends on ACPI && PCI
> diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
> new file mode 100644
> index 000000000000..7aa7e71e90dc
> --- /dev/null
> +++ b/hw/acpi/ghes_cper.c
> @@ -0,0 +1,45 @@
> +/*
> + * ARM Processor error injection
> + *
> + * Copyright(C) 2024 Huawei LTD.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qemu/base64.h"
> +#include "qemu/error-report.h"
> +#include "qemu/uuid.h"
> +#include "qapi/qapi-commands-ghes-cper.h"
> +#include "hw/acpi/ghes.h"
> +
> +void qmp_ghes_cper(CommonPlatformErrorRecord *qmp_cper,
> +                   Error **errp)
> +{
> +    int rc;
> +    AcpiGhesCper cper;
> +    QemuUUID be_uuid, le_uuid;
> +
> +    rc =3D qemu_uuid_parse(qmp_cper->notification_type, &be_uuid);
> +    if (rc) {
> +        error_setg(errp, "GHES: Invalid UUID: %s",
> +                   qmp_cper->notification_type);
> +        return;
> +    }
> +
> +    le_uuid =3D qemu_uuid_bswap(be_uuid);
> +    cper.guid =3D le_uuid.data;
> +
> +    cper.data =3D qbase64_decode(qmp_cper->raw_data, -1,
> +                               &cper.data_len, errp);
> +    if (!cper.data) {
> +        return;
> +    }
> +
> +    /* TODO: call a function at ghes */
> +
> +    g_free(cper.data);
> +}
> diff --git a/hw/acpi/ghes_cper_stub.c b/hw/acpi/ghes_cper_stub.c
> new file mode 100644
> index 000000000000..2358e039b181
> --- /dev/null
> +++ b/hw/acpi/ghes_cper_stub.c
> @@ -0,0 +1,19 @@
> +/*
> + * ARM Processor error injection
> + *
> + * Copyright(C) 2024 Huawei LTD.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-ghes-cper.h"
> +#include "hw/acpi/ghes.h"
> +
> +void qmp_ghes_cper(CommonPlatformErrorRecord *cper, Error **errp)
> +{
> +    error_setg(errp, "GHES QMP error inject is not compiled in");
> +}
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index fa5c07db9068..6cbf430eb66d 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -34,4 +34,6 @@ endif
>  system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-b=
uild-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
>  system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridg=
e-stub.c'))
>  system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
> +system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
> +system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.=
c'))
>  system_ss.add(files('acpi-qmp-cmds.c'))
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 1ad60da7aa2d..bed6ba27d715 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -712,3 +712,8 @@ config ARMSSE
>      select UNIMP
>      select SSE_COUNTER
>      select SSE_TIMER
> +
> +config GHES_CPER
> +    bool
> +    depends on ARM
> +    default y if AARCH64
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index ce6f82a1155a..a7a18c7b50cf 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -23,6 +23,7 @@
>  #define ACPI_GHES_H
> =20
>  #include "hw/acpi/bios-linker-loader.h"
> +#include "qapi/error.h"
>  #include "qemu/notify.h"
> =20
>  extern NotifierList acpi_generic_error_notifiers;
> @@ -78,6 +79,12 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgSta=
te *s,
>                            GArray *hardware_errors);
>  int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr=
);
> =20
> +typedef struct AcpiGhesCper {
> +    uint8_t *guid;
> +    uint8_t *data;
> +    size_t data_len;
> +} AcpiGhesCper;
> +
>  /**
>   * acpi_ghes_present: Report whether ACPI GHES table is present
>   *
> diff --git a/qapi/ghes-cper.json b/qapi/ghes-cper.json
> new file mode 100644
> index 000000000000..3cc4f9f2aaa9
> --- /dev/null
> +++ b/qapi/ghes-cper.json
> @@ -0,0 +1,55 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=3Dpython
> +
> +##
> +# =3D GHESv2 CPER Error Injection
> +#
> +# These are defined at
> +# ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
> +# (GHESv2 - Type 10)
> +##
> +
> +##
> +# @CommonPlatformErrorRecord:
> +#
> +# Common Platform Error Record - CPER - as defined at the UEFI
> +# specification.  See
> +# https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.ht=
ml#record-header
> +# for more details.
> +#
> +# @notification-type: pre-assigned GUID string indicating the record
> +#   association with an error event notification type, as defined
> +#   at https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Reco=
rd.html#record-header
> +#
> +# @raw-data: Contains a base64 encoded string with the payload of
> +#   the CPER.
> +#
> +# Since: 9.2
> +##
> +{ 'struct': 'CommonPlatformErrorRecord',
> +  'data': {
> +      'notification-type': 'str',

like was mentioned at v5 review,
you only need this for setting cper notification type if you are (re)using

  acpi_ghes_generic_error_status() && acpi_ghes_generic_error_data()

however while doing this in (6/10), you are also limiting what
could be encoded in headers to some hardcoded values.

Given QEMU doesn't need to know anything about notification type,
modulo putting it data block header, it would be beneficial
to drop 'notification type' from QAPI interface, and include
error status block and error data headers in raw-data.

This way it should be possible to change headers within python script
without affecting QEMU and QAPI interface. On top of that
ghes_record_cper_errors() could be simplified by dropping (in 6/10)
   acpi_ghes_generic_error_status() && acpi_ghes_generic_error_data()
and just copying raw-data as is directly into error buffer (assuming
script put needed headers cper data).

=46rom fusing pov it's also beneficial to try generate junk error status
block headers, for which python script looks like ideal place to put
it in.

> +      'raw-data': 'str'
> +  }
> +}
> +
> +##
> +# @ghes-cper:
> +#
> +# Inject ARM Processor error with data to be filled according with
> +# ACPI 6.2 GHESv2 spec.
> +#
> +# @cper: a single CPER record to be sent to the guest OS.
> +#
> +# Features:
> +#
> +# @unstable: This command is experimental.
> +#
> +# Since: 9.2
> +##
> +{ 'command': 'ghes-cper',
> +  'data': {
> +    'cper': 'CommonPlatformErrorRecord'
> +  },
> +  'features': [ 'unstable' ]
> +}
> diff --git a/qapi/meson.build b/qapi/meson.build
> index e7bc54e5d047..bd13cd7d40c9 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -35,6 +35,7 @@ qapi_all_modules =3D [
>    'dump',
>    'ebpf',
>    'error',
> +  'ghes-cper',
>    'introspect',
>    'job',
>    'machine-common',
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index b1581988e4eb..c1a267399fe5 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -75,6 +75,7 @@
>  { 'include': 'misc-target.json' }
>  { 'include': 'audio.json' }
>  { 'include': 'acpi.json' }
> +{ 'include': 'ghes-cper.json' }
>  { 'include': 'pci.json' }
>  { 'include': 'stats.json' }
>  { 'include': 'virtio.json' }


