Return-Path: <linux-kernel+bounces-275038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3DC947FDE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E0C2840CD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5352615ECF6;
	Mon,  5 Aug 2024 17:03:36 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2CE15ECCA
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877415; cv=none; b=IFwJGokCPTjy19QJnyHsa8puWOmo3cq8FqOJmZkeh/R4gRG0LQ2zpVjI7eEMwbzSxlOWgB+staf7Q7dC75AFiFoCRWfzoPRcEd+h0YynrZk5ijyuPCIcipQqPLYrJpUY++ky0MumRCf4iKn3/j5OM03OLg36sDDasgnhOWEs3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877415; c=relaxed/simple;
	bh=Dn2k5qh3qBvNIHK1xSaAQ0OAAUVlMKuU+Zr79+pBPFI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adIVmXQoG8IdcCfBeXRqNhVLaxs4zdRj2MuhMSS26jTyqEXDxh8O5Wk/BRwkJM1UI/D2czCxG3LQohnxrXyHgDveIjxDlM5kKLA/1lD5R7R0Y/GD6jzwaaYuLKMKK7wZLx6lstiVbuKDGT8PE64cZPJuJYhjggzyciIlhDueULI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wd2lJ1Jw9z6K5Tg;
	Tue,  6 Aug 2024 01:01:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C3DE140A87;
	Tue,  6 Aug 2024 01:03:30 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 5 Aug
 2024 18:03:29 +0100
Date: Mon, 5 Aug 2024 18:03:28 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Igor
 Mammedov <imammedo@redhat.com>, <linux-kernel@vger.kernel.org>,
	<qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240805180328.00003a82@Huawei.com>
In-Reply-To: <20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri,  2 Aug 2024 23:44:01 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Provide a generic interface for error injection via GHESv2.
> 
> This patch is co-authored:
>     - original ghes logic to inject a simple ARM record by Shiju Jose;
>     - generic logic to handle block addresses by Jonathan Cameron;
>     - generic GHESv2 error inject by Mauro Carvalho Chehab;
> 
> Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Looks fine to me.
Feel free to put in my SoB on the resulting co-auth
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
if appropriate?  Does this work same as kernel co-developed-by?

> +void ghes_record_cper_errors(AcpiGhesCper *cper, Error **errp,
> +                             uint32_t notify)
> +{
> +    int read_ack = 0;
> +    uint32_t i;
> +    uint64_t read_ack_addr = 0;
> +    uint64_t error_block_addr = 0;
> +    uint32_t data_length;
> +    GArray *block;
> +
> +    if (!ghes_get_addr(notify, &error_block_addr, &read_ack_addr)) {
> +        error_setg(errp, "GHES: Invalid error block/ack address(es)");
> +        return;
> +    }
> +
> +    cpu_physical_memory_read(read_ack_addr,
> +                             &read_ack, sizeof(uint64_t));
> +
> +    /* zero means OSPM does not acknowledge the error */
> +    if (!read_ack) {
> +        error_setg(errp,
> +                   "Last CPER record was not acknowledged yet");
> +        read_ack = 1;
> +        cpu_physical_memory_write(read_ack_addr,
> +                                  &read_ack, sizeof(uint64_t));
> +        return;
> +    }
> +
> +    read_ack = cpu_to_le64(0);
> +    cpu_physical_memory_write(read_ack_addr,
> +                              &read_ack, sizeof(uint64_t));
> +
> +    /* Build CPER record */
> +
> +    /*
> +     * Invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
> +     * Table 17-13 Generic Error Data Entry
> +     */
> +    QemuUUID fru_id = {};
> +
> +    block = g_array_new(false, true /* clear */, 1);
> +    data_length = ACPI_GHES_DATA_LENGTH + cper->data_len;
> +
> +    /*

Odd formatting.

> +        * It should not run out of the preallocated memory if
> +        * adding a new generic error data entry
> +        */
> +    assert((data_length + ACPI_GHES_GESB_SIZE) <=
> +            ACPI_GHES_MAX_RAW_DATA_LENGTH);
> +
> +    /* Build the new generic error status block header */
> +    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
> +                                    0, 0, data_length,
> +                                    ACPI_CPER_SEV_RECOVERABLE);
> +
> +    /* Build this new generic error data entry header */
> +    acpi_ghes_generic_error_data(block, cper->guid,
> +                                ACPI_CPER_SEV_RECOVERABLE, 0, 0,
> +                                cper->data_len, fru_id, 0);
> +
> +    /* Add CPER data */
> +    for (i = 0; i < cper->data_len; i++) {
> +        build_append_int_noprefix(block, cper->data[i], 1);
> +    }
> +
> +    /* Write the generic error data entry into guest memory */
> +    cpu_physical_memory_write(error_block_addr, block->data, block->len);
> +
> +    g_array_free(block, true);
> +
> +    notifier_list_notify(&generic_error_notifiers, NULL);
> +}
> +
>  bool acpi_ghes_present(void)
>  {
>      AcpiGedState *acpi_ged_state;



