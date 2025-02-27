Return-Path: <linux-kernel+bounces-536414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA686A47F54
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164E716BA55
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAB722F397;
	Thu, 27 Feb 2025 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0MKc0GM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBAF22D7A0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663199; cv=none; b=QR9hveUtoU2vs9a7v/loa8aexONANZK8wiMk54Y57XHjFvy/nC1fp1d1ZAg73kQUijoBNvtvHNPiAAs4CCBEeGtAITIHRPw7oIr20V2va6e/mRYmIL/yXOZqWe0HSAVeUQrO5/DGe+0jWYe4lhLvywvKrWhA04cvbPURZlrHWYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663199; c=relaxed/simple;
	bh=lOpCXcRYmYAD5QBYw6EKl6FiA+uMvbhAIXGt1ezWlMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ui1iAV9gmW7XOY3WfgW51OltxMVWVjI76dQhvF8iBNY2vvlJrdAEWqDoscSzM6ABJXH3fI7V5/U0au2foXNR+zoSd8CLnPpCPpRDA4v76jZQuJt+5BJvU5FgbOmYAFyhNYkOuuFHDnbD1foykNqsyGKl1dwlwTw+7mWMdLHEBPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0MKc0GM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740663195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuW0BIbjNJWghJa21XE54H5m1b+Yluf4uBw+NY/1p34=;
	b=S0MKc0GMHmat4pszZAw83BLkTnSEPd0xWvLoqrpObLEeta0+8MZMsIZuPr2C+GSLTIVbFK
	yR/PWIwn3QYmPwEaMxKysflqWzIU9y/TDWucJ+jmXSYUjjTM9IapLcgRpQSg9jTKFqm4r+
	A9Bm8C2jkffOlo6xZUhKBheoqkwBGZs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-RATGjmvGNIGrE9fjJcuD3Q-1; Thu, 27 Feb 2025 08:33:13 -0500
X-MC-Unique: RATGjmvGNIGrE9fjJcuD3Q-1
X-Mimecast-MFC-AGG-ID: RATGjmvGNIGrE9fjJcuD3Q_1740663192
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-abb61c30566so88337466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:33:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740663192; x=1741267992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HuW0BIbjNJWghJa21XE54H5m1b+Yluf4uBw+NY/1p34=;
        b=MIPpo0obPRy2Wp8gyrCySJUOelUg3am1+ZmFaX7rq/WKecodg6NWIfyz9tfO7z2I0L
         p+2zQIlLcJXsRO+PCNss50hVisQXer0oQDjPzOqdY2EMhDk/j7UdYyloYPqY1O2Fwp6M
         Di5OUQS8R6mUmbmsiT4GZFR1xBG42+qxlaPYGg0yD6KJ/dBYST3don6TYotjKPGZG20n
         aBwhCS5PTWsi/QJPdUKpf7rQW1Xl6n8fkxh5epftVEtYdE7hwV9l/LbsaQ9NXBdO+zb7
         RnJvBwRBaPswGbXO4WIlPW0g9KsMl78jkI+FywtHEDO0pKav6ygFPtk07UsOZRtHFBC+
         8xMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgp2XwOi1bGDFvEbKK5B+AcCCr0kiBuQ5aJGx/VewJit6ZL+Ec6dUgKzJjl720DIxJtyzxBrlnoRsKWtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6S4H1qWRrS/+I0D+n1OPo6N0lJaTT3CI+ySW57QHZ9gjgkak
	ecj/CsjJEWbCqRpR+2Mg+CyoMXoL+qpwfZYgTT72iFGCAhXWhgLbn44cdaGlcaUCHjhg0vdFrna
	kvE022sGa2efNg7Xxvry+i3u58PwrEvnJfqACZh3g+ofx1Bb8ImOwNkLmfvSaJw==
X-Gm-Gg: ASbGncsRd08T6ABJt7A25eFTrDphbuiurflR4T1MDLP827EZqPG/LbVCqh/UKgK6I9I
	zj2xt/J30jTlHnX+/VHxXvy5LRMZcXgstGyebGvLTeAvhP+ba7wenP+d34/tWinYsFTgaZn5qVZ
	sElu/5pw0qVglFcR3ihEFWaGu1ZRd0wRksFS9YoC4PssCTJubRNTyXr/9OQh5bNoK/MvJaHkB+R
	EoF7HFhjEv6qdSkRTC0g7zhiongxbwyhT7BpAfSWWum6B4z35eCJ7W86nV8zhvTYCWABH8R0bgh
	QryI5laMhpsQhNj0ID7PENEtlx88yncAJc6H/fkX5PMPPqE9XAAp/J7Zc+klhzY=
X-Received: by 2002:a17:906:c102:b0:abf:692:40bd with SMTP id a640c23a62f3a-abf069269e7mr507685066b.43.1740663192441;
        Thu, 27 Feb 2025 05:33:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/90eOgmTyscXKI0cIupAmIcBT4EO6X1+/bdOFr1HCGTM4DVJjj7JL05WdQvhP1cwBDPTntw==
X-Received: by 2002:a17:906:c102:b0:abf:692:40bd with SMTP id a640c23a62f3a-abf069269e7mr507680666b.43.1740663191987;
        Thu, 27 Feb 2025 05:33:11 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf1bef130esm57685066b.40.2025.02.27.05.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 05:33:11 -0800 (PST)
Date: Thu, 27 Feb 2025 14:33:10 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan
 Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 12/21] acpi/generic_event_device: add logic to detect
 if HEST addr is available
Message-ID: <20250227143310.3df0687f@imammedo.users.ipa.redhat.com>
In-Reply-To: <73e0b70ed4125dc07a85fb43281a7731f452750e.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
	<73e0b70ed4125dc07a85fb43281a7731f452750e.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 12:03:42 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Create a new property (x-has-hest-addr) and use it to detect if
> the GHES table offsets can be calculated from the HEST address
> (qemu 10.0 and upper) or via the legacy way via an offset obtained
> from the hardware_errors firmware file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

with checkpatch issues fixed
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/generic_event_device.c |  1 +
>  hw/arm/virt-acpi-build.c       | 18 ++++++++++++++++--
>  hw/core/machine.c              |  2 ++
>  3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 5346cae573b7..14d8513a5440 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -318,6 +318,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>  
>  static const Property acpi_ged_properties[] = {
>      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> +    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.use_hest_addr, false),
>  };
>  
>  static const VMStateDescription vmstate_memhp_state = {
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index af5056201c22..03ee30b3b3f0 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -897,6 +897,10 @@ static const AcpiNotificationSourceId hest_ghes_notify[] = {
>      { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
>  };
>  
> +static const AcpiNotificationSourceId hest_ghes_notify_9_2[] = {
> +    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
> +};
> +
>  static
>  void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  {
> @@ -951,6 +955,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  
>      if (vms->ras) {
>          AcpiGedState *acpi_ged_state;
> +        static const AcpiNotificationSourceId *notify;
> +        unsigned int notify_sz;
>          AcpiGhesState *ags;
>  
>          acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> @@ -958,9 +964,17 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>          ags = &acpi_ged_state->ghes_state;
>          if (ags) {
>              acpi_add_table(table_offsets, tables_blob);
> +
> +            if (!ags->use_hest_addr) {
> +                notify = hest_ghes_notify_9_2;
> +                notify_sz = ARRAY_SIZE(hest_ghes_notify_9_2);
> +            } else {
> +                notify = hest_ghes_notify;
> +                notify_sz = ARRAY_SIZE(hest_ghes_notify);
> +            }
> +
>              acpi_build_hest(ags, tables_blob, tables->hardware_errors,
> -                            tables->linker, hest_ghes_notify,
> -                            ARRAY_SIZE(hest_ghes_notify),
> +                            tables->linker, notify, notify_sz,
>                              vms->oem_id, vms->oem_table_id);
>          }
>      }
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 02cff735b3fb..7a11e0f87b11 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -34,6 +34,7 @@
>  #include "hw/virtio/virtio-pci.h"
>  #include "hw/virtio/virtio-net.h"
>  #include "hw/virtio/virtio-iommu.h"
> +#include "hw/acpi/generic_event_device.h"
>  #include "audio/audio.h"
>  
>  GlobalProperty hw_compat_9_2[] = {
> @@ -43,6 +44,7 @@ GlobalProperty hw_compat_9_2[] = {
>      { "virtio-balloon-pci-non-transitional", "vectors", "0" },
>      { "virtio-mem-pci", "vectors", "0" },
>      { "migration", "multifd-clean-tls-termination", "false" },
> +    { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
>  };
>  const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
>  


