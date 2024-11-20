Return-Path: <linux-kernel+bounces-415985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A17D59D3EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676D9281FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE811C4A35;
	Wed, 20 Nov 2024 15:09:33 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E8D1AB508
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732115373; cv=none; b=WjiyjIot3XtHLVevWrxZ1rKvufhA9zAKiQNCA6yJ0wGogrTivGmYTj8c1NdnV/PxDcYtY5KjP1PtWywok/il59VPLKMKAm+l82YL0YfOvEZoD5KhAw3avkQnr4kkna4NsbWv6lbXoLcEpBrsp6S/LmHdoGW87dyEWEZ3N6tGDTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732115373; c=relaxed/simple;
	bh=TluUCMCw7yENRRFhV7x4IWhesvbQbZK9ddgdERckE7M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcnjf7piCrI9l6Z9jTvsCeyK4a1f3UBmU1hU4Qide6nLSjr251cq8Uea3tplkWuut9wI6ClD55McFflvrjxZdXlpo4+7TsSy+8CYmJgbI6KzYZvESeNFh7gztZxscA2FhlThIL0cm/ArVcT4Z4kFPbNxYeg3Zb2Y541A0TbNNa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XtlBV2KDdz6LD78;
	Wed, 20 Nov 2024 23:09:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id ED86C140D26;
	Wed, 20 Nov 2024 23:09:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 20 Nov
 2024 16:09:28 +0100
Date: Wed, 20 Nov 2024 15:09:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Da?=
 =?ISO-8859-1?Q?ud=E9?= <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>, "Eduardo Habkost"
	<eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter
 Maydell <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
	Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
	<linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
	<qemu-devel@nongnu.org>
Subject: Re: [PATCH 6/6] acpi/generic_event_device: add logic to detect if
 HEST addr is available
Message-ID: <20241120150926.00003db6@huawei.com>
In-Reply-To: <92fdd4cbfb0b52450cd0a2abac0a3227458c9618.1731486604.git.mchehab+huawei@kernel.org>
References: <cover.1731486604.git.mchehab+huawei@kernel.org>
	<92fdd4cbfb0b52450cd0a2abac0a3227458c9618.1731486604.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 13 Nov 2024 09:37:03 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Create a new property (x-has-hest-addr) and use it to detect if
> the GHES table offsets can be calculated from the HEST address
> (qemu 9.2 and upper) or via the legacy way via an offset obtained
> from the hardware_errors firmware file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Comments inline.

Nice work hammering all this into shape.

Thanks,

Jonathan

> ---
>  hw/acpi/generic_event_device.c |  1 +
>  hw/acpi/ghes.c                 | 27 ++++++++++++++++++++-------
>  hw/arm/virt-acpi-build.c       | 30 ++++++++++++++++++++++++++----
>  hw/core/machine.c              |  2 ++
>  include/hw/acpi/ghes.h         |  1 +
>  5 files changed, 50 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index c1116dd8d7ae..df6b4fab2d30 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -318,6 +318,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>  
>  static Property acpi_ged_properties[] = {
>      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> +    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.hest_lookup, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 9ee25efe8abf..2d34a6ddf133 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -365,6 +365,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>  {
>      AcpiTable table = { .sig = "HEST", .rev = 1,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
> +    AcpiGedState *acpi_ged_state;
> +    AcpiGhesState *ags = NULL;
>      int i;
>  
>      build_ghes_error_table(hardware_errors, linker, num_sources);
> @@ -385,10 +387,19 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>       * tell firmware to write into GPA the address of HEST via fw_cfg,
>       * once initialized.
>       */
> -    bios_linker_loader_write_pointer(linker,
> -                                     ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> -                                     sizeof(uint64_t),
> -                                     ACPI_BUILD_TABLE_FILE, hest_offset);
> +
> +    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> +                                                       NULL));
> +    if (acpi_ged_state) {

Won't fail, but if it did (And given you have a check you are assuming
it might).

> +        ags = &acpi_ged_state->ghes_state;
> +    }
> +
Then ags is NULL and boom.

> +    if (ags->hest_lookup) {
> +        bios_linker_loader_write_pointer(linker,
> +                                         ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> +                                         sizeof(uint64_t),
> +                                         ACPI_BUILD_TABLE_FILE, hest_offset);
> +    }
>  }

> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 40f66792570c..930ba9e0a14c 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -893,6 +893,10 @@ static const AcpiNotificationSourceId hest_ghes_notify[] = {
>      {ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA},
>  };
>  
> +static const AcpiNotificationSourceId hest_ghes_notify_9_1[] = {
> +    {ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA},
{ ACPI...
> +};


