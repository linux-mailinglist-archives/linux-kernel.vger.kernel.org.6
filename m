Return-Path: <linux-kernel+bounces-292004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3DA9569F5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03529286378
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4671F16727B;
	Mon, 19 Aug 2024 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4aFxqTN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E35015B119
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068461; cv=none; b=sgG5Ys5PudfXLRCTpvLS6kEqYgskHnCziYdZMiszkVQDfZGBxaxa+ZiNiUr2KsY9mmh3E7TLUci9/6QflT2J34XuOfHdIGDjR5yGR1sCPdc9FKyaWOq/4XBi5QQNx0r7oZgRGvr0ZVK66smYSagdO2vPU0TWjyUpwJ9aZKDXMY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068461; c=relaxed/simple;
	bh=lmYQZbR+amxssN+NwgaUrKvo4A8lEFiPv2wZYsxJd88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9CaruSAwFHURFM55DnJE5ylGmmTtQmxOrcICYzlGhfJYrZNPmyYvYVW18H17P3Hr1uI7dvIFObtQYK0g4xnRToMg6GRjLnuFTWgT8PsNcPyHV3F3lAgDcclWvoPb7fZT1QNnvn6QUURmbYzzEQccifCoGgPzypRctMlvAnMX5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4aFxqTN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724068458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQ4480T+9sAW/+BlCugiW96Q9+2PBOd5re6lznyZPSo=;
	b=K4aFxqTN0H1+d9kWKjZvhttGRlcajPzcsoHSHpNVj2FMMBkG7yXOBtEzTOh8fUOV5erSzx
	9dSrEk5LULHwrUWpIvncr3adqTaRIfxPQqhFxzh5XnMNAVxcn5mbibisUMLOGysmKWFvSF
	R8Jx/N1X2X5eVyrN1B6AC4UqHfu0Rg0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-RBltchJ-N3-uk3Ou-9CLwA-1; Mon, 19 Aug 2024 07:54:17 -0400
X-MC-Unique: RBltchJ-N3-uk3Ou-9CLwA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280a39ecebso26220335e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724068456; x=1724673256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQ4480T+9sAW/+BlCugiW96Q9+2PBOd5re6lznyZPSo=;
        b=du3c+Z5BkYPvaKdVzJC5v3HMyY/ViJPaTpopEMOGRT9IjA1GUx3MonRNtm7pUtUN3i
         nPyD017XzN+rGiVWjCLdDpxKXthlxBqpLHDKSL52twrPCeYO+qjCL/kHHQxl9JYie6BK
         TLYrb2EN3ZpWz8JGc4bPbBBQftBwBSHIRLAJ/TuQrjc1w4PmlDcsKIN0JsTQxXfUcwlP
         mgtXwgqfx0aVpn5gZgErLupxtMTkGenih/OsK+rkqkBZVQNsmwjdBew4s2IDnFpAVntJ
         HQDXq7hzukR0MC13Cy4WQT5D9Kx6pgPEkPlzr1sT7+0II3sZ1ce/Hfe47L986GlLbGu4
         opJg==
X-Forwarded-Encrypted: i=1; AJvYcCWPYLqdMwZQJSpykf5zc3Ps2eIYfgF0rZTW6HZImth5oGK65wfKsMbxkItRRpxy9m9mcGVtqQ8enwnj7mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR8Ekl5ArV0+fBAT5i8l0dDWWrhxh6VbeC5h7fNF0K64xzjCQt
	BG/1FX60ANOlIotzl8oa02E/93HPGLfl+abys4DbqAncO6kPvZP/csQKYy/b81mv6XGP7I1p/1X
	rvDOwugaHDWApAkQxvoU/4DA6zewVuQ6WzdXN8GOx3LxmGE9gzrsfK13IM7KEzw==
X-Received: by 2002:a05:600c:4e91:b0:426:64c1:8388 with SMTP id 5b1f17b1804b1-429eda23e74mr60067395e9.17.1724068455871;
        Mon, 19 Aug 2024 04:54:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvndoydJLrcmx2YYteeIpr3SyROz/F/iRjrkwJ3YAd/EcJZc9t43sl7IXIix5TpJ3EILYtcw==
X-Received: by 2002:a05:600c:4e91:b0:426:64c1:8388 with SMTP id 5b1f17b1804b1-429eda23e74mr60067165e9.17.1724068455266;
        Mon, 19 Aug 2024 04:54:15 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded29303sm159631645e9.15.2024.08.19.04.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 04:54:14 -0700 (PDT)
Date: Mon, 19 Aug 2024 13:54:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 04/13] qapi/acpi-hest: add an interface to do generic
 CPER error injection
Message-ID: <20240819135414.7608c519@imammedo.users.ipa.redhat.com>
In-Reply-To: <f25af812712304aa754103250ee45bfcdd8314ce.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
	<f25af812712304aa754103250ee45bfcdd8314ce.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 09:37:36 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Creates a QMP command to be used for generic ACPI APEI hardware error
> injection (HEST) via GHESv2.
> 
> The actual GHES code will be added at the followup patch.

modulo inconsistency in comments (see below), LGTM

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  MAINTAINERS              |  7 +++++++
>  hw/acpi/Kconfig          |  5 +++++
>  hw/acpi/ghes_cper.c      | 33 +++++++++++++++++++++++++++++++++
>  hw/acpi/ghes_cper_stub.c | 19 +++++++++++++++++++
>  hw/acpi/meson.build      |  2 ++
>  hw/arm/Kconfig           |  5 +++++
>  include/hw/acpi/ghes.h   |  3 +++
>  qapi/acpi-hest.json      | 36 ++++++++++++++++++++++++++++++++++++
>  qapi/meson.build         |  1 +
>  qapi/qapi-schema.json    |  1 +
>  10 files changed, 112 insertions(+)
>  create mode 100644 hw/acpi/ghes_cper.c
>  create mode 100644 hw/acpi/ghes_cper_stub.c
>  create mode 100644 qapi/acpi-hest.json
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3584d6a6c6da..1d8091818899 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2077,6 +2077,13 @@ F: hw/acpi/ghes.c
>  F: include/hw/acpi/ghes.h
>  F: docs/specs/acpi_hest_ghes.rst
>  
> +ACPI/HEST/GHES/ARM processor CPER
> +R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +S: Maintained
> +F: hw/arm/ghes_cper.c
> +F: hw/acpi/ghes_cper_stub.c
> +F: qapi/acpi-hest.json
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
> index 000000000000..92ca84d738de
> --- /dev/null
> +++ b/hw/acpi/ghes_cper.c
> @@ -0,0 +1,33 @@
> +/*
> + * CPER payload parser for error injection
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
> +#include "qapi/qapi-commands-acpi-hest.h"
> +#include "hw/acpi/ghes.h"
> +
> +void qmp_ghes_cper(const char *qmp_cper,
> +                   Error **errp)
> +{
> +
> +    uint8_t *cper;
> +    size_t  len;
> +
> +    cper = qbase64_decode(qmp_cper, -1, &len, errp);
> +    if (!cper) {
> +        error_setg(errp, "missing GHES CPER payload");
> +        return;
> +    }
> +
> +    /* TODO: call a function at ghes */
> +}
> diff --git a/hw/acpi/ghes_cper_stub.c b/hw/acpi/ghes_cper_stub.c
> new file mode 100644
> index 000000000000..36138c462ac9
> --- /dev/null
> +++ b/hw/acpi/ghes_cper_stub.c
> @@ -0,0 +1,19 @@
> +/*
> + * Stub interface for CPER payload parser for error injection
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
> +#include "qapi/qapi-commands-acpi-hest.h"
> +#include "hw/acpi/ghes.h"
> +
> +void qmp_ghes_cper(const char *cper, Error **errp)
> +{
> +    error_setg(errp, "GHES QMP error inject is not compiled in");
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
> index 419a97d5cbd9..b977d65564ba 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -23,6 +23,7 @@
>  #define ACPI_GHES_H
>  
>  #include "hw/acpi/bios-linker-loader.h"
> +#include "qapi/error.h"
>  #include "qemu/notify.h"
>  
>  extern NotifierList acpi_generic_error_notifiers;
> @@ -77,6 +78,8 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
>  int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
> +void ghes_record_cper_errors(const void *cper, size_t len,
> +                             enum AcpiGhesNotifyType notify, Error **errp);
>  
>  /**
>   * acpi_ghes_present: Report whether ACPI GHES table is present
> diff --git a/qapi/acpi-hest.json b/qapi/acpi-hest.json
> new file mode 100644
> index 000000000000..91296755d285
> --- /dev/null
> +++ b/qapi/acpi-hest.json
> @@ -0,0 +1,36 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +
> +##
> +# = GHESv2 CPER Error Injection
> +#
> +# Defined since ACPI Specification 6.2,
> +# section 18.3.2.8 Generic Hardware Error Source version 2. See:
earliest definition, I've found was 6.1, so this should be fixed up here

> +#
> +# https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#generic-hardware-error-source-version-2-ghesv2-type-10
make it consistent with above spec version

> +##
> +
> +
> +##
> +# @ghes-cper:
> +#
> +# Inject a CPER error data to be filled according to ACPI 6.2
ditto

> +# spec via GHESv2.
> +#
> +# @cper: contains a base64 encoded string with raw data for a single CPER
> +#     record with Generic Error Status Block, Generic Error Data Entry and
> +#     generic error data payload, as described at
> +#     https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#format
> +#
> +# Features:
> +#
> +# @unstable: This command is experimental.
> +#
> +# Since: 9.2
> +##
> +{ 'command': 'ghes-cper',
> +  'data': {
> +    'cper': 'str'
> +  },
> +  'features': [ 'unstable' ]
> +}
> diff --git a/qapi/meson.build b/qapi/meson.build
> index e7bc54e5d047..35cea6147262 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -59,6 +59,7 @@ qapi_all_modules = [
>  if have_system
>    qapi_all_modules += [
>      'acpi',
> +    'acpi-hest',
>      'audio',
>      'cryptodev',
>      'qdev',
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index b1581988e4eb..baf19ab73afe 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -75,6 +75,7 @@
>  { 'include': 'misc-target.json' }
>  { 'include': 'audio.json' }
>  { 'include': 'acpi.json' }
> +{ 'include': 'acpi-hest.json' }
>  { 'include': 'pci.json' }
>  { 'include': 'stats.json' }
>  { 'include': 'virtio.json' }


