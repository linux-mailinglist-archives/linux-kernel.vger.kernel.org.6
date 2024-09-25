Return-Path: <linux-kernel+bounces-339204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9A598615E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E8E1F28B16
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790CC1922E2;
	Wed, 25 Sep 2024 14:09:44 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870F1181334
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273384; cv=none; b=rOiUBEzGWvDuwRfJY+ptCUYx1N3q8P0+cXMeQwVhwtwPh4/Cz/5VKRVFBPH8XPEtG2XWMxeyI+4bw7Uo2wYGZ7DVymXjgIampZEh8Kci3DuXCWKELp2VbGhknkKLJHuvhg6xymHQ6wEW2RNFcnSvDndkJEXRnXKCw1x51HSRxM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273384; c=relaxed/simple;
	bh=DGHiXvzQMRFCDzpgzmClzbYpKThl8klnczixHZk5YOM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szoxerKA14R2UA/6+elQ061UaKcRYIMpKTU7bcaP0WXuRahspMWgSC+RlZJw5BiuHwBvc9z1Oxlw55tZ0lsf28H59x+AuAaJpBrR1GekO1uUn70juWmIcyq3Xvs0AVg9DivPDRsCVyOpsCnkRJvzvK0KZBelHe7ScBcp4ofKRmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XDJR53vnjz6D8gq;
	Wed, 25 Sep 2024 22:05:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E119140B39;
	Wed, 25 Sep 2024 22:09:35 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Sep
 2024 16:09:34 +0200
Date: Wed, 25 Sep 2024 15:09:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
	<qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 02/15] acpi/ghes: simplify acpi_ghes_record_errors()
 code
Message-ID: <20240925150933.0000373d@Huawei.com>
In-Reply-To: <45dcc7644e2b2a04645a37e561ed7294482b0744.1727236561.git.mchehab+huawei@kernel.org>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
	<45dcc7644e2b2a04645a37e561ed7294482b0744.1727236561.git.mchehab+huawei@kernel.org>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 25 Sep 2024 06:04:07 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Reduce the ident of the function and prepares it for
> the next changes.
> 
> No functional changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Some of the alignment doesn't seem to match local style which
is either align after ( or align 4 spaces in from line above for
multiple line argument lists.

Code is fine as I guess the later structure is to prepare
for additions that prevent early returns being sensible.

With that in mind.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  hw/acpi/ghes.c | 56 ++++++++++++++++++++++++++------------------------
>  1 file changed, 29 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index dc217694deb9..dacbd4d0c093 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -402,40 +402,42 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>  
>      start_addr = le64_to_cpu(ags->ghes_addr_le);
>  
> -    if (physical_address) {
> +    if (!physical_address) {
> +        return -1;
> +    }
>  
> -        if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
> -            start_addr += source_id * sizeof(uint64_t);
> -        }
> +    if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
> +        start_addr += source_id * sizeof(uint64_t);
> +    }
>  
> -        cpu_physical_memory_read(start_addr, &error_block_addr,
> -                                 sizeof(error_block_addr));
> +    cpu_physical_memory_read(start_addr, &error_block_addr,
> +                                sizeof(error_block_addr));
>  
> -        error_block_addr = le64_to_cpu(error_block_addr);
> +    error_block_addr = le64_to_cpu(error_block_addr);
>  
> -        read_ack_register_addr = start_addr +
> -            ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> +    read_ack_register_addr = start_addr +
> +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
>  
> -        cpu_physical_memory_read(read_ack_register_addr,
> -                                 &read_ack_register, sizeof(read_ack_register));
> +    cpu_physical_memory_read(read_ack_register_addr,
> +                                &read_ack_register, sizeof(read_ack_register));

Alignment looks fishy plus maybe move &read_ack_register up a line.


>  
> -        /* zero means OSPM does not acknowledge the error */
> -        if (!read_ack_register) {
> -            error_report("OSPM does not acknowledge previous error,"
> -                " so can not record CPER for current error anymore");
> -        } else if (error_block_addr) {
> -            read_ack_register = cpu_to_le64(0);
> -            /*
> -             * Clear the Read Ack Register, OSPM will write it to 1 when
> -             * it acknowledges this error.
> -             */
> -            cpu_physical_memory_write(read_ack_register_addr,
> -                &read_ack_register, sizeof(uint64_t));
> +    /* zero means OSPM does not acknowledge the error */
> +    if (!read_ack_register) {
> +        error_report("OSPM does not acknowledge previous error,"
> +            " so can not record CPER for current error anymore");
I guess later changes make it unwise to just return -1 here.	

> +    } else if (error_block_addr) {
> +        read_ack_register = cpu_to_le64(0);
> +        /*
> +         * Clear the Read Ack Register, OSPM will write it to 1 when
> +         * it acknowledges this error.
> +         */
> +        cpu_physical_memory_write(read_ack_register_addr,
> +            &read_ack_register, sizeof(uint64_t));
>  
> -            ret = acpi_ghes_record_mem_error(error_block_addr,
> -                                             physical_address);
> -        } else
> -            error_report("can not find Generic Error Status Block");
> +        ret = acpi_ghes_record_mem_error(error_block_addr,
> +                                            physical_address);
or return here.
> +    } else {
> +        error_report("can not find Generic Error Status Block");
>      }
>  
>      return ret;


