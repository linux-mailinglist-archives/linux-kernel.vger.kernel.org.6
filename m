Return-Path: <linux-kernel+bounces-277943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E3994A87D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71FF71F23B93
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89B41E7A47;
	Wed,  7 Aug 2024 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SF+ZF/7T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5EA1BC08C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037043; cv=none; b=EwMLMtY0lLYWlvNhUrB0jsQrPSAyGt/g3WWeGWw7hhySABU1eFqecPx5XhZxAeeOkGJk46birmfeIdBRz55gYmQxOrG8YwbzPNq621aPL1q/aE9zwYsp1+1Az8nQkwfy6T9sJ0snuGOGPLEwHyfkVuwJUS96FgIh7MKOoeZ+Wcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037043; c=relaxed/simple;
	bh=IJWsnY/NFxnESGFOLGzPavd3GqiqGQL1qkUbbESjJaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7kP9MlQsci2XVTLo3wAvB41gfGEdhHhvHE0u8tcLNCSQXmUn2/d5fkWOhhDqieYSdiZvS8Hv3w+gt1YceuSnRZDMlx6qvlrqXBvd7gxJwA2gVy6KyjI98V1hgN1wQJLpWCqdCgpH0fnY/0vzJ2CYEb04jvgs1hH5BcQbbBPOOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SF+ZF/7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAA8C32782;
	Wed,  7 Aug 2024 13:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723037042;
	bh=IJWsnY/NFxnESGFOLGzPavd3GqiqGQL1qkUbbESjJaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SF+ZF/7T0ixwlBKAQctHdY+NLgJLFBBrgwBjoyzZuVq2OMWttiwJX2pCvZF+wGFiW
	 PT730MaCfbYhUqasVtP4WvtEt13DvxcBgZkegjJo8tX/xa0WgcifvuRPIdKS2ycnIE
	 J+zty3zM7tuZudJ9DFoG9PpkG5K9vHlCBKnWsX5RdXxJczvWXe8l494Yt8u7pj213E
	 1wgfDf11xXhd11ccvMsgbYrzxQHSwztTOOseWMa1krTfFjot31EiqJMF+gXSQ0GHei
	 s7h+6mXScDFikvSN7HPkTwZf22bfanSbL6m1FyYvtTvAGBAOByXbAKMmIxWnAu4rWD
	 ra8rfKYHo86kw==
Date: Wed, 7 Aug 2024 15:23:57 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240807152357.0d2dc466@foz.lan>
In-Reply-To: <20240807103436.000013fc@Huawei.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
	<20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
	<20240807094750.6414fb2f@foz.lan>
	<20240807103436.000013fc@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 7 Aug 2024 10:34:36 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Wed, 7 Aug 2024 09:47:50 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Em Tue, 6 Aug 2024 16:31:13 +0200
> > Igor Mammedov <imammedo@redhat.com> escreveu:
> >   
> > > PS:
> > > looking at the code, ACPI_GHES_MAX_RAW_DATA_LENGTH is 1K
> > > and it is the total size of a error block for a error source.
> > > 
> > > However acpi_hest_ghes.rst (3) says it should be 4K,
> > > am I mistaken?    
> > 
> > Maybe Jonathan knows better, but I guess the 1K was just some
> > arbitrary limit to prevent a too big CPER. The 4K limit described
> > at acpi_hest_ghes.rst could be just some limit to cope with
> > the current bios implementation, but I didn't check myself how
> > this is implemented there. 
> > 
> > I was unable to find any limit at the specs. Yet, if you look at:
> > 
> > https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section  
> 
> I think both limits are just made up.  You can in theory log huge
> error records.  Just not one does.

If both are made up, I would sync them, either patching the
documentation or the ghes driver.

> 
> > 
> > The processor Error Information Structure, starting at offset
> > 40, can go up to 255*32, meaning an offset of 8200, which is
> > bigger than 4K.
> > 
> > Going further, processor context can have up to 65535 (spec
> > actually says 65536, but that sounds a typo, as the size is
> > stored on an uint16_t), containing multiple register values
> > there (the spec calls its length as "P").
> > 
> > So, the CPER record could, in theory, have:
> > 	8200 + (65535 * P) + sizeof(vendor-specicific-info)
> > 
> > The CPER length is stored in Section Length record, which is
> > uint32_t.
> > 
> > So, I'd say that the GHES record can theoretically be a lot
> > bigger than 4K.	  
> Agreed - but I don't think we care for testing as long as it's
> big enough for plausible records.   Unless you really want
> to fuzz the limits?

Fuzz the limits could be interesting, but it is not on my
current plans.

Yet, 1K could be a little bit short for ARM CPER.

See: N.26 ARMv8 AArch64 GPRs (Type 4) has 256 bytes for
registers, plus 8 bytes for the header. So, a total size of
264 bytes, for a single context register dump. I would expect
that, in real life, type 4 to always be reported on aarch64,
on BIOS with context register support. Maybe other types could
also be dumped altogether (like context registers for EL1, 
EL2 and/or EL3).

If just one type 4 context is encoded, it means that, 1K has 
space for 23 errors (of a max limit of 255).

Just looking at the maximum number, my feeling is that 1K
might be too short to simulate some real life reports,
but that depends on how firmware is actually grouping
such events.

So, maybe this could be expanded to, let's say, 4K, thus
aligning with the ReST documentation.

Regards,
Mauro

