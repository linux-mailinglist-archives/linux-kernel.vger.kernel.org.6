Return-Path: <linux-kernel+bounces-276179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDFB948F81
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F70A281E42
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989241C2321;
	Tue,  6 Aug 2024 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsAdljBd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A06F1DFC7
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948726; cv=none; b=N5Q5EP3+4w86qsw1JGgwGQQWpCuGTddWXC5PL31cqvhX1Mkqi0QDdXfdDo3/yVZVFpzL0PqNFom5L+p5RVHVkQUroo5GHMq4Km/61QAFXIeujTJFeioCisN+QxvU1eVj5SnsAS5YnQ+bu81c0WN8bn9KdG+vPZF2t8UGFohQrms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948726; c=relaxed/simple;
	bh=lMOoUzoz4oH3DT0lTWCjYIcenk+UkbbOcjpeP0GuKSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jARWatGYLvO3VChr1D6wl4RnSyIK08pUUriZl7WgYGl3l9eMNoWMs/YFENczUiI30B+eBsaTseSLjenATuwNsiIPERGfQxGzgBK68P0rhFC3qKKo4htM1IE8rrLz5vdQ9Ae/TKNOhifRQ9ETIvKvQ+qwgvpQpgMyjd3570v3a/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KsAdljBd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722948723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RcCqYXLbfyl8NrZROynzZEyLhQLUtE5aTO6tsO3xOlo=;
	b=KsAdljBdjE46qtlsB/0MiUWND3pM2Me1aTv6H4Tt57YetSyxdBNqKGIwIUnbXUfOsD1ydi
	EKQtb69JzjUvZHZMh2Qcs/mTuX6IhCZZ61eFjn3JMqeQFF5FUyaHIbSJUEYm/cymJgqvQr
	L5cZzU5cqS1N4kCGtkfRDUcZDeOawTo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-7xrDbrfKOdafZu5JT-7aqQ-1; Tue, 06 Aug 2024 08:51:58 -0400
X-MC-Unique: 7xrDbrfKOdafZu5JT-7aqQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280a434147so5026255e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 05:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722948717; x=1723553517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcCqYXLbfyl8NrZROynzZEyLhQLUtE5aTO6tsO3xOlo=;
        b=XhOuH7iP2LsbvBI6JkvXakUFgznMRUdB/ntvXak9CiC3kEJybFRdu0fnNgqxjG9Q0i
         u4BwPNNzIK2bqFx/zLZVy/bLLj6Lt7jaQOcFGFh7PVKdxJzwtQntoaaVu661QTXTZ5cs
         eesKXKE38HSnSjFmGu9xC2wJBLYagpK/4Oa9YQwvdK23rmc5dnrRoCboVU29r8bU38HV
         FXOf2QxeHE/E7ZqokL2X2a7OejumYzsWJLdNIMf8P/DEyBNX474aK6PW2xK6a2a/R3oD
         0FKVu9PpbTTPP4SLoq3zE4qzfj3fF3iPCTLHp5zYBYYJOvbJep37rYhMFUsTVXAL5EmW
         WhMA==
X-Forwarded-Encrypted: i=1; AJvYcCWihYt0bAn7dwIIciPwxsHE2HzjvtGz2iTpwoInKqPzNLPkez3GeYiXHwOw1o6JW+VMfF4oV6jWQcx/5IGHRf9KSY9ntW/+S//1WV9q
X-Gm-Message-State: AOJu0YzOSslm+UK5Gjk5wAffo443I7sgcsWdwppmR6MafCMbqM6kOj2x
	H9YrtZsa14FQvE5tCRmE9PeCPI4Ho3tglpaCprkFUy6Wayr+jXyitBZYo0V3gIlhG5cjh6wThq5
	r6eWJdrWQ5VJYlwZ7F5fkN7yEgOfdCC+0Z0jFbiahEKUDoDg0lwLkavvmXTBD/Q==
X-Received: by 2002:a05:600c:1c14:b0:427:985b:178b with SMTP id 5b1f17b1804b1-428ea0fd693mr84412365e9.16.1722948717067;
        Tue, 06 Aug 2024 05:51:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETUDRBH0w8TmSPjUX+r9AIm9FcNwAIyhG6KkOo2oT8gRKN8FIq07Xl4DFhVVvA6RFoMIbqtQ==
X-Received: by 2002:a05:600c:1c14:b0:427:985b:178b with SMTP id 5b1f17b1804b1-428ea0fd693mr84412085e9.16.1722948716471;
        Tue, 06 Aug 2024 05:51:56 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e329b6sm178988095e9.20.2024.08.06.05.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:51:55 -0700 (PDT)
Date: Tue, 6 Aug 2024 14:51:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 5/7] qapi/ghes-cper: add an interface to do generic
 CPER error injection
Message-ID: <20240806145153.0e1a70a9@imammedo.users.ipa.redhat.com>
In-Reply-To: <51cbdc8a53e58c69ee17b15c398feeeeeeb64f34.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<51cbdc8a53e58c69ee17b15c398feeeeeeb64f34.1722634602.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Aug 2024 23:44:00 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Creates a QMP command to be used for generic ACPI APEI hardware error
> injection (HEST) via GHESv2.
> 
> The actual GHES code will be added at the followup patch.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  MAINTAINERS              |  7 +++++
>  hw/acpi/Kconfig          |  5 ++++
>  hw/acpi/ghes_cper.c      | 45 ++++++++++++++++++++++++++++++++
>  hw/acpi/ghes_cper_stub.c | 18 +++++++++++++
>  hw/acpi/meson.build      |  2 ++
>  hw/arm/Kconfig           |  5 ++++
>  include/hw/acpi/ghes.h   |  7 +++++
>  qapi/ghes-cper.json      | 55 ++++++++++++++++++++++++++++++++++++++++
>  qapi/meson.build         |  1 +
>  qapi/qapi-schema.json    |  1 +
>  10 files changed, 146 insertions(+)
>  create mode 100644 hw/acpi/ghes_cper.c
>  create mode 100644 hw/acpi/ghes_cper_stub.c
>  create mode 100644 qapi/ghes-cper.json
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 98eddf7ae155..655edcb6688c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2075,6 +2075,13 @@ F: hw/acpi/ghes.c
>  F: include/hw/acpi/ghes.h
>  F: docs/specs/acpi_hest_ghes.rst
>  
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
>  
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
> +    rc = qemu_uuid_parse(qmp_cper->notification_type, &be_uuid);
> +    if (rc) {
> +        error_setg(errp, "GHES: Invalid UUID: %s",
> +                   qmp_cper->notification_type);
> +        return;
> +    }
> +
> +    le_uuid = qemu_uuid_bswap(be_uuid);
> +    cper.guid = le_uuid.data;
> +
> +    cper.data = qbase64_decode(qmp_cper->raw_data, -1,
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
> index 000000000000..7ce6ed70a265
> --- /dev/null
> +++ b/hw/acpi/ghes_cper_stub.c
> @@ -0,0 +1,18 @@
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
> +}
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index fa5c07db9068..6cbf430eb66d 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -34,4 +34,6 @@ endif
>  system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
>  system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
>  system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
> +system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
> +system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))
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
> index 33be1eb5acf4..06a5b8820cd5 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -23,6 +23,7 @@
>  #define ACPI_GHES_H
>  
>  #include "hw/acpi/bios-linker-loader.h"
> +#include "qapi/error.h"
>  #include "qemu/notify.h"
>  
>  extern NotifierList generic_error_notifiers;
> @@ -78,6 +79,12 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
>  int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
>  
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
> +# vim: filetype=python
> +
> +##
> +# = GHESv2 CPER Error Injection
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
> +# https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#record-header
> +# for more details.
> +#
> +# @notification-type: pre-assigned GUID string indicating the record
> +#   association with an error event notification type, as defined
> +#   at https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#record-header
> +#
> +# @raw-data: Contains a base64 encoded string with the payload of
> +#   the CPER.
> +#
> +# Since: 9.2
> +##
> +{ 'struct': 'CommonPlatformErrorRecord',
> +  'data': {

> +      'notification-type': 'str',

this should be source id (type is just impl. detail of how QEMU delivers
event for given source id)
unless there is no plan to use more sources,
I'd just drop this from API to avoid confusing user.

Since the patch comes before 5/7, it's not clear how it will be used at this point.
I'd move the patch after 5/7.

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
> @@ -35,6 +35,7 @@ qapi_all_modules = [
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


