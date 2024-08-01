Return-Path: <linux-kernel+bounces-271267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CD8944BCF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375031C241A4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5762C1A08A4;
	Thu,  1 Aug 2024 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJmYrJzN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A002C208D1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517003; cv=none; b=uZUMeN8b9lRUlpR956hwsNNEtIksoNiwQhXljTUEWyGkmfv8sm5j95Ye3I04vghR4EDErNOrI2m4ZwCf3CyC1sryfKp4R640+4oMYiWT8xVmRzowBdt79kz1K3+y2msLS9gBFfUStyC7f7ewi5O2I0pn5zkgowzVBFYNh6K0SFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517003; c=relaxed/simple;
	bh=yUOmIatsa2JxbuH+5SkDj8HGMvb+bCebLi05n30xnAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDMIKollwGkxN0bOTchJE1ub6cb65CL7acEW8X3TVOVUUB4CPvwCRv6yW9TgB5UxapTQC93vYbpw7TsZTcMfCDZG5zdkbGnBIST+gEXdBSo4gPVmaH71rTrq8THCTt7rxNoPtOOqYNNm5RMLs9kQpZWyMLmAIvW8YHLeRJuIDLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJmYrJzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A953C4AF09;
	Thu,  1 Aug 2024 12:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517003;
	bh=yUOmIatsa2JxbuH+5SkDj8HGMvb+bCebLi05n30xnAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZJmYrJzN4tAnymj5rYqbuo7vESrmbmpWK93FqK7UY+T3aU26iBz1tMvEvtdWu7pKY
	 4X/yWHt8lYHKWrsYo1KkRgrJdjgf8buhYSDnaQXlrKKo6zbugs3y5VigRBUHW51ebi
	 mxRlWMz+PgMR1sXXNSPjEv+Y0GEznSW3qxvgA3BAehJ95JMwUaXTn6kW4Z9VG+4u1x
	 2SMSbY2fRmUT7vAJUEwUqkG5avwLE4gRGo9iIgNC7CPysortKI2QHMxXEwQpIXcNVE
	 pqDo2XyZSu7PbNzke8huMKfs2YIsmEGIdfj5JiHf0MhY+mvr88DR3g5j0WKtLLiikm
	 X9E67YJQ5n8PQ==
Date: Thu, 1 Aug 2024 14:56:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/7] acpi/ghes: Support GPIO error source.
Message-ID: <20240801145637.03c34fd3@foz.lan>
In-Reply-To: <20240730104028.4f503d91@imammedo.users.ipa.redhat.com>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
	<64a31a09fe6b11bebad1c592ad20071a9d93fee5.1721630625.git.mchehab+huawei@kernel.org>
	<20240730104028.4f503d91@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 30 Jul 2024 10:40:28 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> > index 674f6958e905..4f1ab1a73a06 100644
> > --- a/include/hw/acpi/ghes.h
> > +++ b/include/hw/acpi/ghes.h
> > @@ -58,6 +58,7 @@ enum AcpiGhesNotifyType {
> >  
> >  enum {
> >      ACPI_HEST_SRC_ID_SEA = 0,
> > +    ACPI_HEST_SRC_ID_GPIO = 1,  
> is it defined by some spec, or just a made up number?

I don't know. Maybe Jonathan or Shiju knows better, as the original patch
came from them, but I didn't find any parts of the ACPI spec defining the
values for source ID.

Checking at build_ghes_v2() implementation, this is used on two places:

1. as GHESv2 source ID:
    /*
     * Type:
     * Generic Hardware Error Source version 2(GHESv2 - Type 10)
     */
    build_append_int_noprefix(table_data, ACPI_GHES_SOURCE_GENERIC_ERROR_V2, 2);
    /* Source Id */
    build_append_int_noprefix(table_data, source_id, 2);
    /* Related Source Id */
    build_append_int_noprefix(table_data, 0xffff, 2);

as an address offset:

    address_offset = table_data->len;
    /* Error Status Address */
    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
                     4 /* QWord access */, 0);
    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
        address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
        ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));

So, if I had to guess, I'd say that this was made up, in a way that
the size of the table will fit just two sources, starting from zero.

So, I'll change the code to just:

	enum {
            ACPI_HEST_SRC_ID_SEA = 0,
            ACPI_HEST_SRC_ID_GPIO, 
	    /* future ids go here */
	    ACPI_HEST_SRC_ID_RESERVED,
	};

To remove the false impression that this could be originated from the
spec.

Thanks,
Mauro

