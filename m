Return-Path: <linux-kernel+bounces-339232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7146D98618A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35415287E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348E318952F;
	Wed, 25 Sep 2024 14:23:40 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA681898F3
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274219; cv=none; b=RlIPh+Qdd3rV2A5Sij3/a6jfs1T43rpsvmRFHBaa+37dUyjWLQiUwS5RFZs0U/emujNccGGRA4sWwQUrVUtz14aJ9KtCBA1qdDm1bUJXiRMXDAeZGFUIkkgDyd1vj7C7+f7Vj7mfHjuTY2iuUS72mNMRL/LDtAMiJM/qPnKveXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274219; c=relaxed/simple;
	bh=ZNdmXSJ6ORvtYsZFqqe9goSbjFnSSPQiCvw4tqyEhN0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mr5KH6nY2387VCEAG8xfOuH1Q2pICSnW0RUPOBbi1rAV8NCMYShLzpLPIZIb44yHG+Cl0KqXbKlRJOcWbVI2bY4hvePMQl9V7qJIm6ThevzjXnrWysdckVTA88WO8LJuUs1klAqFzf9FxBrbxXzXUQCT4PK1r4Opw67hCvRgw9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XDJqC0lDhz6G9Pm;
	Wed, 25 Sep 2024 22:23:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B45E140736;
	Wed, 25 Sep 2024 22:23:35 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Sep
 2024 16:23:34 +0200
Date: Wed, 25 Sep 2024 15:23:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
	<peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
	<linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
	<qemu-devel@nongnu.org>
Subject: Re: [PATCH 08/15] acpi/ghes: Prepare to support multiple sources on
 ghes
Message-ID: <20240925152333.0000110d@Huawei.com>
In-Reply-To: <05fb5c6a7d26eeb730bf5fe1f67bb6581ec6d730.1727236561.git.mchehab+huawei@kernel.org>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
	<05fb5c6a7d26eeb730bf5fe1f67bb6581ec6d730.1727236561.git.mchehab+huawei@kernel.org>
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

On Wed, 25 Sep 2024 06:04:13 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The current code is actually dependent on having just one
> error structure with a single source.
> 
> As the number of sources should be arch-dependent, as it
> will depend on what kind of synchronous/assynchronous
> notifications will exist, change the logic to dynamically
> build the table.
Not really arch dependent.  Depends on both arch and some
firmware implementation choices, but I guess that detail
doesn't matter here.

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
Trivial comment inline
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> @@ -335,9 +346,10 @@ static void build_ghes_v2(GArray *table_data,
>      build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
>                       4 /* QWord access */, 0);
>      bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> -        address_offset + GAS_ADDR_OFFSET,
> -        sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
> -        (ACPI_GHES_ERROR_SOURCE_COUNT + source_id) * sizeof(uint64_t));
> +                                   address_offset + GAS_ADDR_OFFSET,

I'd prefer if we avoided realigning unless absolutely necessary or
that it is split into a separate patch.
Makes things a tiny bit harder to review.

> +                                   sizeof(uint64_t),
> +                                   ACPI_GHES_ERRORS_FW_CFG_FILE,
> +                                   (num_sources + index) * sizeof(uint64_t));
>  


