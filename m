Return-Path: <linux-kernel+bounces-289014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE120954149
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EF93B23B75
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104097DA98;
	Fri, 16 Aug 2024 05:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhiRtDoL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53740770F1
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787073; cv=none; b=MEEqtn57877AXLXqD9Wrm5Y08xyzIE/54DB6keIW+UhR9iq6B3I5U/WsS8wHDfP4sQ2pc3dEjrxN3zsTONBq2wxHD31sKLvDG0QQZKFTBmvAcFMl8SEXFHkuxJWPBipGtoQzcPqOcrXR+va4eK+vKh2TMNLauoCzJyaW1Hv/yBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787073; c=relaxed/simple;
	bh=o6LQ3/gXegMy3cUs5qQqcnaVukWZ6nZIPla8WlD0N+s=;
	h=Date:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sK5WF7Ei5Y6GwFDa9PC17jSlgiShUJXvwAanVS/96VuA6xgPm/KCqaV1itDoLslTqqNZfPGf9dZuW9aqI7S5m9q8eTRItZG2lgCqBwf3FKKI+o56/Flxb48SAUT+0yWXQE3OZuFEmLh8RDKSAfeDXytAdxVrQZNuwjoJhTncMqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhiRtDoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C248BC32782;
	Fri, 16 Aug 2024 05:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723787073;
	bh=o6LQ3/gXegMy3cUs5qQqcnaVukWZ6nZIPla8WlD0N+s=;
	h=Date:From:Cc:Subject:In-Reply-To:References:From;
	b=IhiRtDoLKm8lZjTy9j5xvhz+Mhi9jLbiqV55O5b4PAMebp2zW9lInqoI76EkGsFai
	 8p/hWCuV4rjtZnpN/TZTpnLpaQhEi6I2OqFsagmSQLCKSj7wpIPNevwiPZJWWWVpP7
	 ZyGEaCAK4p7RdwIeNsdEWBsjPOXwhxilMrOXB7y/DMJAkkMNWZ3bJKKw2QK+oUKdf6
	 N7PVBaVrv0ni0PLufC0oALoj49Pi2uAYl8Oy7N9Ba0ZXe2D+/QnJKHr8XXf1+YHf0h
	 qtGSjAQgcKS2cfKUKCovMCJ3SAgCUpQpEZcAAZRBc3GW8jZdjmd5Oc5bnMXyqKTt77
	 VrVELMRT8Mz1g==
Date: Fri, 16 Aug 2024 07:44:27 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Igor Mammedov
 <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon
 Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v7 05/10] acpi/ghes: rework the logic to handle HEST
 source ID
Message-ID: <20240816074427.2c7ae7d9@foz.lan>
In-Reply-To: <9f5843c6f774035e80a7a19e0091c347edff9d02.1723591201.git.mchehab+huawei@kernel.org>
References: <cover.1723591201.git.mchehab+huawei@kernel.org>
	<9f5843c6f774035e80a7a19e0091c347edff9d02.1723591201.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 14 Aug 2024 01:23:27 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

This hunk is wrong:

> @@ -350,9 +380,10 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>      build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
>                       4 /* QWord access */, 0);
>      bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> -        address_offset + GAS_ADDR_OFFSET,
> -        sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
> -        (ACPI_GHES_ERROR_SOURCE_COUNT + source_id) * sizeof(uint64_t));
> +                                   address_offset + GAS_ADDR_OFFSET,
> +                                   sizeof(uint64_t),
> +                                   ACPI_BUILD_TABLE_FILE,
> +                                   address_offset + GAS_ADDR_OFFSET);
>  
>      /*
>       * Read Ack Preserve field

It should be, instead:

    /*
     * Read Ack Register
     * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source
     * version 2 (GHESv2 - Type 10)
     */
    address_offset = table_data->len;
    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
                     4 /* QWord access */, 0);
    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
                                   address_offset + GAS_ADDR_OFFSET,
                                   sizeof(uint64_t),
                                   ACPI_HW_ERROR_FW_CFG_FILE,
                                   (ACPI_HEST_SRC_ID_COUNT + source_id) *
                                   sizeof(uint64_t));

Funny enough, even with this problem, error injection was working.

I'll be preparing a v8 with such fix applied.

I'll also add an optional patch at the end to double-check if the
links are properly generated, using an abort() in case something
ever goes wrong.

Regards,
Mauro

