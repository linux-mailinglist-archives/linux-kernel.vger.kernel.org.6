Return-Path: <linux-kernel+bounces-534050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AE5A4621D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5705C17A22C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2335B21CC44;
	Wed, 26 Feb 2025 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVcnoHyt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7C6191F6A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579424; cv=none; b=LKRLp4uSTbfPVexvREOLm9BDG7P3V6LNR72SvEfT9mVkgfny/gVf0r0Gg3D4FTQ7Htl2dvBq1Pe+B5HwR4+nCF5ze+2nGGC1MMSnLEUoG47/oT/MPAWbsAbWKhranzSQnJM+ctE+FC5JvLDBpq80FyOu/zv7yrm+qRYHCKQ8qGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579424; c=relaxed/simple;
	bh=tHXWRUcfC/Uu4A9QJGcvpZQXhOm64uKap9xDNT5NsNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJ6plkEpo4y8qxKLlqokOQiFISfF7NrU5ALllbAwkGaKgjwE+M+8sOHIM7rh9vuVfA8SC4mW3g28I9pI68A/VUzquszUI9QsfsHC67tfNwILXK9tMT/XBOWnv6cxGMjHDboNAXAl0Yja1ZxzKMZ10zYlUHnLYuZP3bjz6aEvmPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OVcnoHyt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740579421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U47VA7bQAyReFmXTz+SvCcW2YjnEudaZ9f05EVRkBHw=;
	b=OVcnoHyt0ec6xHiN1RUFJmZlzyeHGE7rzfByghIMmyykydOHk/Rmado59zAadYY+nds1lL
	Ei1q3PGRHbQy5POCEppJ9SXEgKUHSck7I+aCNki73tqAPcmfXIcZGJr1QnWeDvmqEJ/OQb
	jzThAkTvvnl/ft+/sHstW+2zwjePUrY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-eWb-gutpO56V_A2Hj_ke_A-1; Wed, 26 Feb 2025 09:16:59 -0500
X-MC-Unique: eWb-gutpO56V_A2Hj_ke_A-1
X-Mimecast-MFC-AGG-ID: eWb-gutpO56V_A2Hj_ke_A_1740579418
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f34b3f9f1so4714631f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740579418; x=1741184218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U47VA7bQAyReFmXTz+SvCcW2YjnEudaZ9f05EVRkBHw=;
        b=H+bHZPxCztI1YA846vuEieOSQ5/fevK6R6OEp69rm0J7TaGVCKrVcwjfPM/PVcjVbT
         kzajcmct10bvXWh5LAtlifkPJsKzr9E3D+z4k5ETBnke5+e+CNBayQMSu6Ry4wZ1DAT0
         L/aJKt0Pg/mviyWkfO5ik8bLt40u6v6Fd/x4O6v8fU7/gsF8SNcZotC0fLz1Jd2k/N/F
         10Q7LP97i4Z2mtgSSwVntjE40mI3l3O34W4OXSrpSi6eMJAMteTEO6A9CQuK0Cnx97N7
         rLsz/STYCGmNwy2Y6ikRd22DYPLOkXoxqddva945e6eZRjlvP8x3K0bFDhTDLcIfeM71
         gGew==
X-Forwarded-Encrypted: i=1; AJvYcCUSt8mxhBEBKx3oqUl6v1fVITblsqf0A78LXzCpi/Em2z+ZUjI2LVQX16G3/55uB5tE/7zpVKn+4zEkk/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzggTRwJGIkg6vYEmWMuQyqHomzLzrZSRzzubKncF+RnKr31O/t
	1yAxKSWEc9w0YuX1nBM/YuNLYxiPstepIgfUwtKNA3AlkSOh3OJUth6EHE9pRTrBoprxGZEMaM2
	1UxHUfoND6d5BeWY1jQo6rUKm2dhEx1L/6yXpRok05t9RIzvUrddDwRf3xR+Bdw==
X-Gm-Gg: ASbGnct5RybcRu1fNdowkFQrDK6V3wJIgIuMtZ0HKeyL/U9YupPUI0D79n+TPmRnYDr
	buPsB1+MA5+zOXI6hATrEQwo4tkd6XSZxll1r8wZNRqVqsmB5KCssF+/N5ochGHqKr7J1+6JVDm
	Qm3ztKZ5ivZdaO1+WuP0QELObHPDalveDTCodJ82z41KSNQAKtTtlGgNcfmD3OpP7B6PqDenl9Q
	pfz3IFBPec7oAhgkF1EPkEpVAG2Pi9mMZ4xCfk2P7YJpLc4i6ju/dPgmQELD+/ucL172+q3pKQA
	6XnaOxapGRMgES/mafe8NNPTMhS1xbD195+jGVEbTkfy3IbPiaD+lThNPiZSY1A=
X-Received: by 2002:a05:6000:1ac8:b0:38f:39e5:6b5d with SMTP id ffacd0b85a97d-390d4f8b64bmr2980512f8f.44.1740579418275;
        Wed, 26 Feb 2025 06:16:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpbWVd48qhAy+RqiOR6hOvkRh0yJcnowd3kVeAC9R1PEvlXonoM8kmft0OL4NXIEZaESe9oA==
X-Received: by 2002:a05:6000:1ac8:b0:38f:39e5:6b5d with SMTP id ffacd0b85a97d-390d4f8b64bmr2980477f8f.44.1740579417874;
        Wed, 26 Feb 2025 06:16:57 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390de5a5b5esm1102094f8f.89.2025.02.26.06.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:16:57 -0800 (PST)
Date: Wed, 26 Feb 2025 15:16:56 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Eric Blake
 <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/14] Change ghes to use HEST-based offsets and add
 support for error inject
Message-ID: <20250226151656.10665bc9@imammedo.users.ipa.redhat.com>
In-Reply-To: <cover.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 15:35:09 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Now that the ghes preparation patches were merged, let's add support
> for error injection.
> 
> On this series, the first 6 patches chang to the math used to calculate offsets at HEST
> table and hardware_error firmware file, together with its migration code. Migration tested
> with both latest QEMU released kernel and upstream, on both directions.
> 
> The next patches add a new QAPI to allow injecting GHESv2 errors, and a script using such QAPI
>    to inject ARM Processor Error records.

please, run ./scripts/checkpatch on patches before submitting them.
as it stands now series cannot be merged due to failing checkpatch

> 
> ---
> v4:
> - added an extra comment for AcpiGhesState structure;
> - patches reordered;
> - no functional changes, just code shift between the patches in this series.
> 
> v3:
> - addressed more nits;
> - hest_add_le now points to the beginning of HEST table;
> - removed HEST from tests/data/acpi;
> - added an extra patch to not use fw_cfg with virt-10.0 for hw_error_le
> 
> v2: 
> - address some nits;
> - improved ags cleanup patch and removed ags.present field;
> - added some missing le*_to_cpu() calls;
> - update date at copyright for new files to 2024-2025;
> - qmp command changed to: inject-ghes-v2-error ans since updated to 10.0;
> - added HEST and DSDT tables after the changes to make check target happy.
>   (two patches: first one whitelisting such tables; second one removing from
>    whitelist and updating/adding such tables to tests/data/acpi)
> 
> 
> 
> Mauro Carvalho Chehab (14):
>   acpi/ghes: prepare to change the way HEST offsets are calculated
>   acpi/ghes: add a firmware file with HEST address
>   acpi/ghes: Use HEST table offsets when preparing GHES records
>   acpi/ghes: don't hard-code the number of sources for HEST table
>   acpi/ghes: add a notifier to notify when error data is ready
>   acpi/ghes: create an ancillary acpi_ghes_get_state() function
>   acpi/generic_event_device: Update GHES migration to cover hest addr
>   acpi/generic_event_device: add logic to detect if HEST addr is
>     available
>   acpi/generic_event_device: add an APEI error device
>   tests/acpi: virt: allow acpi table changes for a new table: HEST
>   arm/virt: Wire up a GED error device for ACPI / GHES
>   tests/acpi: virt: add a HEST table to aarch64 virt and update DSDT
>   qapi/acpi-hest: add an interface to do generic CPER error injection
>   scripts/ghes_inject: add a script to generate GHES error inject
> 
>  MAINTAINERS                                   |  10 +
>  hw/acpi/Kconfig                               |   5 +
>  hw/acpi/aml-build.c                           |  10 +
>  hw/acpi/generic_event_device.c                |  43 ++
>  hw/acpi/ghes-stub.c                           |   7 +-
>  hw/acpi/ghes.c                                | 231 ++++--
>  hw/acpi/ghes_cper.c                           |  38 +
>  hw/acpi/ghes_cper_stub.c                      |  19 +
>  hw/acpi/meson.build                           |   2 +
>  hw/arm/virt-acpi-build.c                      |  37 +-
>  hw/arm/virt.c                                 |  19 +-
>  hw/core/machine.c                             |   2 +
>  include/hw/acpi/acpi_dev_interface.h          |   1 +
>  include/hw/acpi/aml-build.h                   |   2 +
>  include/hw/acpi/generic_event_device.h        |   1 +
>  include/hw/acpi/ghes.h                        |  54 +-
>  include/hw/arm/virt.h                         |   2 +
>  qapi/acpi-hest.json                           |  35 +
>  qapi/meson.build                              |   1 +
>  qapi/qapi-schema.json                         |   1 +
>  scripts/arm_processor_error.py                | 476 ++++++++++++
>  scripts/ghes_inject.py                        |  51 ++
>  scripts/qmp_helper.py                         | 702 ++++++++++++++++++
>  target/arm/kvm.c                              |   7 +-
>  tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5240 bytes
>  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5326 bytes
>  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6601 bytes
>  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7723 bytes
>  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5442 bytes
>  29 files changed, 1677 insertions(+), 79 deletions(-)
>  create mode 100644 hw/acpi/ghes_cper.c
>  create mode 100644 hw/acpi/ghes_cper_stub.c
>  create mode 100644 qapi/acpi-hest.json
>  create mode 100644 scripts/arm_processor_error.py
>  create mode 100755 scripts/ghes_inject.py
>  create mode 100755 scripts/qmp_helper.py
> 


