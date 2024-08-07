Return-Path: <linux-kernel+bounces-277479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C97B594A1F7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B79B2215E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4891B1C57A0;
	Wed,  7 Aug 2024 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9hnoPSN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6BC18D651
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723016876; cv=none; b=m7V+5Ikd8H9WhlFE9GPIXPfGXtx+Cd9p025SCUYqawSyppvdo9Rl4E4dJYqaKZSKV8lTIG+RXQHbNdCBxsAgPThqoEoLujyrV4zmghi6a/qJaOL3W4AMaRtSpkJtZjEbSEBShen1xlmnazZaVRCu2HFPLsEUtuutyOm/de57Kgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723016876; c=relaxed/simple;
	bh=vMJRjUr+IGJwQB4Bc82HwUmW7kTM7dx26RqISOvFuQg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jfRBGB6UZwX+ovnuYshB1Ux5bzQLK1Xapu03Ncau4OCMBy+2UVVqSPeYyPXt2TzSFskzA5us6EC+vTd+s3ikuY+dybP0x3eqwddEdJ4c4QhofN3QXo/5VcIfBS6aMlzcgNqlLcqY9sw/wt1eey3v3makCx6O0ssPBxcdtMPXUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9hnoPSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BD6C32782;
	Wed,  7 Aug 2024 07:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723016876;
	bh=vMJRjUr+IGJwQB4Bc82HwUmW7kTM7dx26RqISOvFuQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k9hnoPSNWVEgoVVKxSjZQBXnWpmRUrvBduGM/EgPlF2EEX3STtKbgQShMkvk2IPxh
	 +gdV+81avdU0j2Aka6I2ymQ44Tsa9b5HRgU+eckgGpJf4SuZYPHZTisaZbzaaXDwD9
	 fmCYme9+2g88ZebMPJ0NYdGdndmo+Q3aaaP2dxKIsiopWkmAeG4Gam5pC7NKFBa573
	 mcjEZ+B+iSCV9xGalM2LDUxa0HuesYBtM5vQoDLN8P8oo8vITlMh/VlE+9hFKojREV
	 H2nsuQoEK98S1/Tr1rTnIKURbjWQOG0gYLY72mMNQ7cLdsYMPtx97X3Wj6gKYhmrt2
	 +/aohjP/se5xA==
Date: Wed, 7 Aug 2024 09:47:50 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240807094750.6414fb2f@foz.lan>
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

> PS:
> looking at the code, ACPI_GHES_MAX_RAW_DATA_LENGTH is 1K
> and it is the total size of a error block for a error source.
> 
> However acpi_hest_ghes.rst (3) says it should be 4K,
> am I mistaken?

Maybe Jonathan knows better, but I guess the 1K was just some
arbitrary limit to prevent a too big CPER. The 4K limit described
at acpi_hest_ghes.rst could be just some limit to cope with
the current bios implementation, but I didn't check myself how
this is implemented there. 

I was unable to find any limit at the specs. Yet, if you look at:

https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section

The processor Error Information Structure, starting at offset
40, can go up to 255*32, meaning an offset of 8200, which is
bigger than 4K.

Going further, processor context can have up to 65535 (spec
actually says 65536, but that sounds a typo, as the size is
stored on an uint16_t), containing multiple register values
there (the spec calls its length as "P").

So, the CPER record could, in theory, have:
	8200 + (65535 * P) + sizeof(vendor-specicific-info)

The CPER length is stored in Section Length record, which is
uint32_t.

So, I'd say that the GHES record can theoretically be a lot
bigger than 4K.	

Thanks,
Mauro

