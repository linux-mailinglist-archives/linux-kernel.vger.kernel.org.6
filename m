Return-Path: <linux-kernel+bounces-535944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DF4A479A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08E6168590
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89462229B02;
	Thu, 27 Feb 2025 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8GuJKX3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050BD225A34
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740650102; cv=none; b=gjts2nki/CeQ78AzzBIk4Lxg16Zq+xeOFOltsK08XbN07rx7qygwjhcy+IjjkudUyebDXwIOvnuAcoFbVLhHltumsRMHLCXFy6yXfBEDIb3D2zPjA9hNOI052CDP4EnnLUgJqWuZ6k7f0DepFvqMFZElS9/2LUfzIkffYyKIRrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740650102; c=relaxed/simple;
	bh=nNy/XI7LSsI3A4lshOd/X1+NFMLZUoE26TwjOAgGz+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOpiHBrLXL9lFIPofZDiTNc66UkJd+GFjzI/uazv+weZYHs5K9UL2hlTBUrePN9bAYDCRkqYGS7MM/eKVa9NTFGUXdpuMOCYHwk6ECQuwyBafSD+QLxOBMvnv2PcZPWLz1NXvGnwB5/1KUpVjatiS3dvYE/StHXSAwW+D6OUCJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8GuJKX3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740650099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sM37GoCBrelHpecugQ7DvbegVqt19Ri+N9wNIK8C7vQ=;
	b=M8GuJKX3sDHIaSPqAS44CoCvvNXVTIilEeRydVo0fBwrrc7bzJEZc1KOp7xe1xHj4SfIPu
	MAUTdIl2h1vkJBnsDrekNKxJ2pIZKsQeoMOuyXvXyS0Pnfrfu4yhVPIskA7ewP7kqYENHv
	1/bEm5ae9YFDeAlg3dXVLpBHm9wjJQQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-N8VOd9fJNh6zyvu2hjCy7g-1; Thu, 27 Feb 2025 04:54:58 -0500
X-MC-Unique: N8VOd9fJNh6zyvu2hjCy7g-1
X-Mimecast-MFC-AGG-ID: N8VOd9fJNh6zyvu2hjCy7g_1740650097
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4394c489babso3696975e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:54:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740650097; x=1741254897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sM37GoCBrelHpecugQ7DvbegVqt19Ri+N9wNIK8C7vQ=;
        b=MoE8y8sNDeiWRPXa5Fw587Dcj+ZJ15n7NiFggyGlWe9CpolChLSr5eZpXgcFBbftt5
         WOfTMm7rHS59IZGBAmb9zu9feYkiMI8A9a2U+s72F64jX0ZffXWFcKbivGob9ioXwSLx
         hM3+RZ8nOaaUXQJ4ITQHMfmQcQyX+Dj/GIvMLYRvuplCNME+GzOhRZjbXJ2aXInOGQla
         7ww9PXd/EHhKuSFv7eZZvndzzuDC9XY/4xBlSQiJtv8AKdca0df8Z0/V4t1GY213bpDd
         CBmhi/mKBEcVzGCe93SbZ6aVDf0IlPR2JZEpHbpCxhE4QOTEqiw34fk0dRWpZ1HVJ0F+
         rvhw==
X-Forwarded-Encrypted: i=1; AJvYcCWRH8Lg6GmWz32KBznfO3VZfC7QxPitlC80cyAnfzfRO26X7I7hcuIldLqsqPFcnhbpuRFXwqOD7Oa5kSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyEzUL18K3ozrgESIGdnNxY+27N9XrCWGH2RMfa7ekkqnj+hR7
	EctKJaYyFfR3PPLDUPNqUl1trZJOtglaOoDTgfaViZGMoEZ2Fpafam1gqz55S61TAYooaKW3hkv
	pwEMo6A4UPRkuqsWONBdKafJ8/B5KMw0k53FOr3aTPZDULRy4fzYKs2QKF1NGCw==
X-Gm-Gg: ASbGncv+M2l8vOjOUkuEoy/KzjTplw4mWAIii4RjQMUzBIhJbmyOngWDtEIq/jX/hlj
	r6QTmzZjg0KI2AXYOKsScEKhy3gvpgrsDSpnrfOXLRUW+xrf4Sz72YyHOn6K79Y/tzJLR89TCpv
	0ILCnNMw86jbuw1x904mF2jDpOxHq2fR9RhcYZ9ny1TzLRJjNElJB+o+nSwe18vsnbFzfc88kRE
	NliFKsP/CuT6x6KvB7evUQitHyflvvb6H5mfHBnH4tZmabZgJoJ3NSPyimK+Nc9tmxVYPfxouMP
	hfLp8gZTJWC9xh7h3+knqHZhmk0kjj34IxBXMy91vOJ5Rtj0Io6XZ8mtZM2ubh4=
X-Received: by 2002:a05:600c:b97:b0:43b:8198:f6fc with SMTP id 5b1f17b1804b1-43b8198f8efmr17561875e9.11.1740650096846;
        Thu, 27 Feb 2025 01:54:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIPu5VQ/hiL8z8t1cKtb2pjMgTWX7upe4WwktQRFRpTNjOGTmG0PLGgfQJU7qJUE349QFvTg==
X-Received: by 2002:a05:600c:b97:b0:43b:8198:f6fc with SMTP id 5b1f17b1804b1-43b8198f8efmr17561605e9.11.1740650096489;
        Thu, 27 Feb 2025 01:54:56 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73718e2asm17268555e9.21.2025.02.27.01.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 01:54:55 -0800 (PST)
Date: Thu, 27 Feb 2025 10:54:54 +0100
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
Message-ID: <20250227105454.69e3d459@imammedo.users.ipa.redhat.com>
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

once you enable, ras in tests as 1st patches and fixup minor issues
please try to do patch by patch compile/bios-tables-test testing, to avoid
unnecessary respin in case at table change crept in somewhere unnoticed. 


