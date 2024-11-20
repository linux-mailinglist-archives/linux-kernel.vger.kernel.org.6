Return-Path: <linux-kernel+bounces-415884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821709D3D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FAE31F2227B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776941A2C0B;
	Wed, 20 Nov 2024 14:29:38 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF10174EDB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732112978; cv=none; b=j4DpZD8poKpK9ZQEKt+oxvgizIv7FRSa6CJp5cAflsSBCWC6J4VYu5qfrI59xPgsylwdoAuCaZXFa93Q15DMGEqrGT+ZWpU73o0viFpzIkswYhz4BTEHrdc9sSwSAE3gquVDGLnbOWXziTADxEBwWFfLllkUtTwpWlQRSJRLVr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732112978; c=relaxed/simple;
	bh=AnbgXn1iRAyZ2Ce6MENFBQF1R+azdtndo1TcjGJg70s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szZHMqwNPjVUpu5KzOeeIXf9jYeF+phSflQL0REZSH+Gdyp2YitDMCcUXmN0By9KPdEMmbur/qP1CsuAPHOVg88V06Am027YpnpWNm0sXgjsA+NJAh3Rc3brPayfVSwfK6sRaOxfrAS/ftAi8Mjz6XhllIJ4IEGjwMrDAjEw/tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XtkDp1MCqz6J6nG;
	Wed, 20 Nov 2024 22:26:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B0F6F140119;
	Wed, 20 Nov 2024 22:29:33 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 20 Nov
 2024 15:29:33 +0100
Date: Wed, 20 Nov 2024 14:29:31 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
	<peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
	<linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
	<qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/6] acpi/ghes: Prepare to support multiple sources on
 ghes
Message-ID: <20241120142931.00006b63@huawei.com>
In-Reply-To: <3f6b7e8499bf5911de9b1533e4b2a4addc207536.1731486604.git.mchehab+huawei@kernel.org>
References: <cover.1731486604.git.mchehab+huawei@kernel.org>
	<3f6b7e8499bf5911de9b1533e4b2a4addc207536.1731486604.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 13 Nov 2024 09:36:58 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The current code is actually dependent on having just one
> error structure with a single source.

Trivial: Very short line wrap of the description. Maybe more
than 60 chars?

> 
> As the number of sources should be arch-dependent, as it
> will depend on what kind of synchronous/assynchronous
> notifications will exist, change the logic to dynamically
> build the table.
> 
> Yet, for a proper support, we need to get the number of
> sources by reading the number from the HEST table. However,
> bios currently doesn't store a pointer to it.
> 
> For now just change the logic at table build time, while
> enforcing that it will behave like before with a single
> source ID.
> 
> A future patch will add a HEST table bios pointer and
> change the logic at acpi_ghes_record_errors() to
> dynamically use the new size.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Took a fresh look. One trivial comment.


> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index e059317b002e..40f66792570c 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -889,6 +889,10 @@ static void acpi_align_size(GArray *blob, unsigned align)
>      g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
>  }
>  
> +static const AcpiNotificationSourceId hest_ghes_notify[] = {
> +    {ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA},

    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
seems to be local style.

> +};
> +
>  static
>  void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  {
> @@ -944,6 +948,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      if (vms->ras) {
>          acpi_add_table(table_offsets, tables_blob);
>          acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
> +                        hest_ghes_notify, ARRAY_SIZE(hest_ghes_notify),
>                          vms->oem_id, vms->oem_table_id);
>      }


