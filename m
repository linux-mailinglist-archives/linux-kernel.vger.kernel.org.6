Return-Path: <linux-kernel+bounces-286542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DF8951C49
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464F71C214B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCCE1B1406;
	Wed, 14 Aug 2024 13:53:30 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53881B0126
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723643610; cv=none; b=CpyhbAFP0onR33BA5m8fshnhlQaIOYmmSMiq9LRMZlrfIhLwGsJApA+5jqyVBs8bYm40Pq7p7RIu9pvVDflNm6Po0KZ6CfAs+UPe3qcYnBzpL3+1LO5kp9ZV+7vQN4h9JTaTEhxbdLhp11HgzDCytdCbEL4loudGxTDdCXbZerg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723643610; c=relaxed/simple;
	bh=4nLAUq5Wbs/w8LUTj/K9xp3NXFMBG/xWFnlIk9pIwnU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CG2OnFv0tzeFYm/2TNyoZzmGs1eeQxrrw94bJfm49EdIOuIZY5a+9Z6HVo7/by0iB18NFNNkBfrZmyKCPOdtjhLfKOr8QGfadOcumERlENnc6Vn4HVZ7OoDoA7TWHHNwiL18OdGFcv9T92z3vCOpo+99pp+iyN5Hg9AiqKXbG+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WkV5L2JYbz6JBCj;
	Wed, 14 Aug 2024 21:50:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 99BFE140B33;
	Wed, 14 Aug 2024 21:53:24 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 14:53:24 +0100
Date: Wed, 14 Aug 2024 14:53:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric
 Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	<linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
	<qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 04/10] qapi/acpi-hest: add an interface to do generic
 CPER error injection
Message-ID: <20240814145322.00002dcb@Huawei.com>
In-Reply-To: <c44e6c39e6cf95a738999b721cdf71e4887258a9.1723591201.git.mchehab+huawei@kernel.org>
References: <cover.1723591201.git.mchehab+huawei@kernel.org>
	<c44e6c39e6cf95a738999b721cdf71e4887258a9.1723591201.git.mchehab+huawei@kernel.org>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 14 Aug 2024 01:23:26 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Creates a QMP command to be used for generic ACPI APEI hardware error
> injection (HEST) via GHESv2.
> 
> The actual GHES code will be added at the followup patch.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A few trivial things from a quick glance at this
(to remind myself of how this fits together).

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

> +#include "qapi/qapi-commands-acpi-hest.h"
> +#include "hw/acpi/ghes.h"
> +
> +void qmp_ghes_cper(const char *qmp_cper,
> +                   Error **errp)
That's a very short line wrap.

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

> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 419a97d5cbd9..99d12d69c864 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -23,6 +23,7 @@
>  #define ACPI_GHES_H
>  
>  #include "hw/acpi/bios-linker-loader.h"
> +#include "qapi/error.h"
Odd to have an include added with no other changes in file?
Wrong patch maybe?  Or should it be included by a c file instead?
>  #include "qemu/notify.h"
>  
>  extern NotifierList acpi_generic_error_notifiers;
> diff --git a/qapi/acpi-hest.json b/qapi/acpi-hest.json



