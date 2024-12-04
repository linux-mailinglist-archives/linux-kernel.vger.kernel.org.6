Return-Path: <linux-kernel+bounces-430729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CED8B9E356A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A22DB2903A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BC3190662;
	Wed,  4 Dec 2024 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4Bm708a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5550718E359
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298733; cv=none; b=X0weWv6pA7YTYLPZXlsfwcnvj4te1i+8+X7HaZlUwNymJD/xNPhlmWztkhjEihbk7OOQo3J1t+3tXPIiV+TX+ofV8Z2Jx37JXLWa4hs2Nj0aQv0QrMLnLp+S93kYpUdQpR0a87V3XkXQsHyyDwi/RG4lyF98kxfPKRThVmLWBDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298733; c=relaxed/simple;
	bh=6rcAR5fx634iJHuLmG3RpP1qjECcf4AuZFK+vo0BkYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAeWTFejnuYnve5XZZ224LxyInt+ukUthoiJJJgc3mkFJX0CENxPcnZ7PmhaADD//gjtAy+5h/pMv4guppYJJOAReNq0LOuJiIwnDhWFz46PP0YypKmNQTXhmHSr2EJPuGWUgPnzQXYAsvPTgCLy5YmxQC2peBZZOwTdwxcr33I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4Bm708a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28C5C4CED1;
	Wed,  4 Dec 2024 07:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733298732;
	bh=6rcAR5fx634iJHuLmG3RpP1qjECcf4AuZFK+vo0BkYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h4Bm708aGOwWi+sLdeoBl9r2YU87vdRoZ6A1uP2smaNA3Ov57u+rvrYCzwOWjEoA0
	 Pn3BCI79QhR+EMfVLApskVeRtEPCKYPLLJfBJRM5Jp+b+eZ9JOs5NkT23zZShE/YX5
	 kX/pMa8uti42JCL9M1ZXQ4DUPFg9CWPt1Wc8r+0DbXzSHFqdjD6ot+99Myl115VWJC
	 YyPCHgYmzH4F3kNXuyDwv7+BY+OULBQ9tuJpgxQ0DpmK+yJspBTHlq31UfFkXJHvBl
	 1P9o2RchNryrXJoBYXlTm5heVJZ2jskqdxyXtvp39YYocn/kff7Y9WfaM2gbXkOdt7
	 BE5ElJxo6oXKA==
Date: Wed, 4 Dec 2024 08:52:07 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 08/15] acpi/ghes: make the GHES record generation
 more generic
Message-ID: <20241204085207.0ecae6ae@foz.lan>
In-Reply-To: <20241125115643.00002923@huawei.com>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
	<b3845a8c78ef36c633d5e20af868de4ed16650a4.1732266152.git.mchehab+huawei@kernel.org>
	<20241125115643.00002923@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 25 Nov 2024 11:56:43 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:

> On Fri, 22 Nov 2024 10:11:25 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Split the code into separate functions to allow using the
> > common CPER filling code by different error sources.
> > 
> > The generic code was moved to ghes_record_cper_errors(),
> > and ghes_gen_err_data_uncorrectable_recoverable() now contains
> > only a logic to fill the Generic Error Data part of the record,
> > as described at:
> > 
> > 	ACPI 6.2: 18.3.2.7.1 Generic Error Data
> > 
> > The remaining code to generate a memory error now belongs to
> > acpi_ghes_record_errors() function.
> > 
> > A further patch will give it a better name.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> One trivial follow up that is enabled by the change you are discussing with Igor.
> Up to you that one.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > +
> > +int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> > +{
> > +    /* Memory Error Section Type */
> > +    const uint8_t guid[] =
> > +          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
> > +                  0xED, 0x7C, 0x83, 0xB1);
> > +    Error *errp = NULL;
> > +    int data_length;
> > +    GArray *block;
> > +
> > +    if (!physical_address) {
> > +        error_report("can not find Generic Error Status Block for source id %d",
> > +                     source_id);
> > +        return -1;
> > +    }  
> 
> With this error check gone (as per discussion with Igor) you could use
> g_autofree to deal with freeing block.
> 
> That would bring the errp check right next to the call that would result
> in errp potentially being set and slightly improve readability.
> 
> Mind you there are no uses of this in hw/acpi currently so maybe this
> isn't a good time to start :)

Yeah, I prefer to not do such cleanup now. As you said, this isn't used
right now at ghes, and there are still two series on the top of it.

IMO, such kind of change should happen afterwards, and checking on
other places were memory is allocated in the driver.

Thanks,
Mauro

