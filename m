Return-Path: <linux-kernel+bounces-279418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF98494BD13
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7477828A173
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDDA18CC16;
	Thu,  8 Aug 2024 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY5IkJAR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C2B18CBE6
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119081; cv=none; b=RZqR1JGxPUBpU+N8iv2uhYzAWo+ff3H4dW3Ne1Kaqr3XvyEGOgojO5R039qgNImcKzK7fxVWj7lllW+DFrVMAqMFDLY8m9tV9LFWpWy95XHuTH/949sjBh/NJcjTYSJGjhEZMIZVhrZzXjeD0o+gNR7fKdYN18yXmOLvl2OpoJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119081; c=relaxed/simple;
	bh=okDt0GF8kFCoft7LCpimb0DlLgYHkqdTo2/807i2Izk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TG7Wh143TLdk/24GE73chJFT6KiApWaNh75uNYiAqELeIb1NHLwt/wANDMYCm3jL6ALClXlOehvrmlgsNCJIpWUZtjWhF7KGmMWcRIpS3TcS03o+cfYfZOp6jNBrk9CtjeuZtbir3sdZH8kINyc+csJW5UJsJI0/jT8LXZO3fnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY5IkJAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B0DC4AF10;
	Thu,  8 Aug 2024 12:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723119080;
	bh=okDt0GF8kFCoft7LCpimb0DlLgYHkqdTo2/807i2Izk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eY5IkJARG4aA/YFX2VkVMgRviMYbTYcnncqt4Al0e87J3bJPWSZCs+elDKgmYOAIC
	 cdUXuDTislz46dDFhM4mOzRm74/CWxkVsuMLrTX9v1gTKXTDgMOonjjPaETlrooKK+
	 E7Did2Cxy4wAQa9MaGwCujgwPVc8OugUizkFvZ8j3pRGF388GDiPGsiY0nk2a7vib5
	 1H8DL2+zY1Iajvup3N+uT0GyQDDoASreEpRit4UrQt1l6QuDRbU046SXyg4D8oPC0k
	 krIP9LyhZZu5PwpUcl9ECVpbieBU+iJZltj6ilOoSY0nbT+3CBRTNuLcXI6KSKhC66
	 aYup7vo7S0EeA==
Date: Thu, 8 Aug 2024 14:11:14 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240808141114.3b021f80@foz.lan>
In-Reply-To: <20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
	<20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 6 Aug 2024 16:31:13 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > +    /* Could also be read back from the error_block_address register */
> > +    *error_block_addr = base +
> > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > +        error_source_to_index[notify] * ACPI_GHES_MAX_RAW_DATA_LENGTH;
> > +
> > +    return true;
> > +}  
> 
> I don't like all this pointer math, which is basically a reverse engineered
> QEMU actions on startup + guest provided etc/hardware_errors address.
> 
> For once, it assumes error_source_to_index[] matches order in which HEST
> error sources were described, which is fragile.
> 
> 2nd: migration-wive it's disaster, since old/new HEST/hardware_errors tables
> in RAM migrated from older version might not match above assumptions
> of target QEMU. 
> 
> I see 2 ways to rectify it:
>   1st: preferred/cleanest would be to tell QEMU (via fw_cfg) address of HEST table
>        in guest RAM, like we do with etc/hardware_errors, see
>             build_ghes_error_table()
>                ...
>                tell firmware to write hardware_errors GPA into
>        and then fetch from HEST table in RAM, the guest patched error/ack addresses
>        for given source_id
> 
>        code-wise: relatively simple once one wraps their own head over
>                  how this whole APEI thing works in QEMU
>                  workflow  is described in docs/specs/acpi_hest_ghes.rst
>                  look to me as sufficient to grasp it.
>                  (but my view is very biased given my prior knowledge,
>                   aka: docs/comments/examples wrt acpi patching are good enough)
>                  (if it's not clear how to do it, ask me for pointers)

That sounds a better approach, however...

>   2nd:  sort of hack based on build_ghes_v2() Error Status Address/Read Ack Register
>         patching instructions
>                bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,                
>                    address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),                      
>                    ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
>                                                  ^^^^^^^^^^^^^^^^^^^^^^^^^
>         during build_ghes_v2() also store on a side mapping
>              source_id -> error address offset : read ack address
> 
>         so when you are injecting error, you'd at least use offsets
>         used at start time, to get rid of risk where injection code
>         diverge from HEST:etc/hardware_errors layout at start time.
> 
>         However to make migration safe, one would need to add a fat
>         comment not to change order ghest error sources in HEST _and_
>         a dedicated unit test to make sure we catch it when that happens.
>         bios_tables_test should be able to catch the change, but it won't
>         say what's wrong, hence a test case that explicitly checks order
>         and loudly & clear complains when we will break order assumptions.
> 
>         downside:
>            * we are are limiting ways HEST could be composed/reshuffled in future
>            * consumption of extra CI resources
>            * and well, it relies on above duct tape holding all pieces together

I ended opting to do approach (2) on this changeset, as the current code
is already using bios_linker_loader_add_pointer() for ghes, being deeply 
relying on the block address/ack and cper calculus.

To avoid troubles on this duct tape, I opted to move all offset math
to a single function at ghes.c:

	/*
	 * ID numbers used to fill HEST source ID field
	 */
	enum AcpiHestSourceId {
	    ACPI_HEST_SRC_ID_SEA,
	    ACPI_HEST_SRC_ID_GED,
	
	    /* Shall be the last one */
	    ACPI_HEST_SRC_ID_COUNT
	} AcpiHestSourceId;

	...

	static bool acpi_hest_address_offset(enum AcpiGhesNotifyType notify,
        	                             uint64_t *error_block_offset,
                	                     uint64_t *ack_offset,
                        	             uint64_t *cper_offset,
                                	     enum AcpiHestSourceId *source_id)
	{
	    enum AcpiHestSourceId source;
	    uint64_t offset;

	    switch (notify) {
	    case ACPI_GHES_NOTIFY_SEA:      /* Only on ARMv8 */
	        source = ACPI_HEST_SRC_ID_SEA;
	        break;
	    case ACPI_GHES_NOTIFY_GPIO:
	        source = ACPI_HEST_SRC_ID_GED;
	        break;
	    default:
	        return true;
	    }

	    if (source_id) {
	        *source_id = source;
	    }

	    /*
	     * Please see docs/specs/acpi_hest_ghes.rst for the memory layout.
	     * In summary, memory starts with error addresses, then acks and
	     * finally CPER blocks.
	     */

	    offset = source * sizeof(uint64_t);

	    if (error_block_offset) {
	        *error_block_offset = offset;
	    }
	    if (ack_offset) {
	        *ack_offset = offset + ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
	    }
	    if (cper_offset) {
	        *cper_offset = 2 * ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t) +
	                       source * ACPI_GHES_MAX_RAW_DATA_LENGTH;
	    }

	    return false;
	}

I also removed the anonymous enum with SEA/GPIO source IDs, using
only the ACPI notify type as arguments at the function calls.

As there's now a single point where the offsets from
docs/specs/acpi_hest_ghes.rst are enforced, this should be error
prone.

The code could later be changed to use approach (2), on a separate
cleanup.

Thanks,
Mauro

