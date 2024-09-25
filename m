Return-Path: <linux-kernel+bounces-339212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFF3986169
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB951C2579C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944BA192B9D;
	Wed, 25 Sep 2024 14:15:09 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707EC192B78
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273709; cv=none; b=RpSWxIk/RT7kvyDogQ0WDHBB9bm66yFMA8DT563aUgL7+t0yEC0Chj/qu7ZnbP/iO3LE0Wa7BKOhRPPT/LsI1S9Y8HTevva6uxOb1V1U7ba+TP7+aF3s38BQDI92uX924dxLzDO4q+wrKq0MFNxZDImqWAk/S7EE5CNPaNsIzJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273709; c=relaxed/simple;
	bh=oj1+0FlpaH/MgJ8gZUHKFWJ5VxGsNV3vRB+rQbUZ6Ug=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZmyPpOM9ivNs254ielpqCspuXN2g3ODub7QpHVMXYy76eGuSXDNzamG0742e6FYA/K2++xge7Ej+ZNrZEFvlkwTvyNlqr8SWgsuPiUGlvexqQFj9U4/1oZ2xBSfEwFe72cbjowmUji4AYkInzoOSsffRiNKRihNTwKx+v9tCTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XDJYR2JCyz6D91w;
	Wed, 25 Sep 2024 22:11:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 48ABC140736;
	Wed, 25 Sep 2024 22:15:05 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Sep
 2024 16:15:04 +0200
Date: Wed, 25 Sep 2024 15:15:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
	<qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 05/15] acpi/ghes: Fix acpi_ghes_record_errors() argument
Message-ID: <20240925151503.00000b1d@Huawei.com>
In-Reply-To: <58444cff65cc5b9164f47db4685910a2602b7d13.1727236561.git.mchehab+huawei@kernel.org>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
	<58444cff65cc5b9164f47db4685910a2602b7d13.1727236561.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 25 Sep 2024 06:04:10 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The first argument is source ID and not notification type.
Maybe call out that the header already differs from the two
implementations in naming this parameter. This just corrects
that.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> 
> Changes from v8:
> - Non-rename/cleanup changes merged altogether;
> - source ID is now more generic, defined per guest target.
>   That should make easier to add support for 86.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  include/hw/acpi/ghes.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 20016c226d1f..50e3a25ea384 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -73,7 +73,7 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> -int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
> +int acpi_ghes_record_errors(uint8_t source_id, uint64_t error_physical_addr);
>  
>  /**
>   * acpi_ghes_present: Report whether ACPI GHES table is present


