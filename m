Return-Path: <linux-kernel+bounces-286958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4371D9520D5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F3D289036
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAD61BC082;
	Wed, 14 Aug 2024 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfzfbRKD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAC41BC068
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655713; cv=none; b=drp9YotBJO5r1ZgoRrVuNsdFvEhku31LWfv55eac4AImq9g+U1yy7OIUfUoYXG+fBPLtPPWzIfgMKtVx4/4+um8EoxhF4dq3dUv94eQy67j1P37LqoPV8KZF81zhZ92Tb9LCltniM5PxHELv1SffPbJ5+ZpRnRg5OoQ28KiufwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655713; c=relaxed/simple;
	bh=CNLvWdFSpWetfnrk3/sCACP6QDOdIi1nd9Px9y/UFMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DM/pocHu/Onjfeg/p0cyT4YZ5XQZN+D55E5Tl3eTQ7daDSgiD4NY/6J4qC+AaClMjHvhqbuuCgtJ36h4p42FYnyFEMCfzhb5ZZ4HTKKJoruhJ3DNPw3Y14SzxTWlSLfxkJAiWPZuk3dyGJufN1uq8PSgbct5N5pW9d9jPrXZ3EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfzfbRKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345F8C4AF0F;
	Wed, 14 Aug 2024 17:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723655713;
	bh=CNLvWdFSpWetfnrk3/sCACP6QDOdIi1nd9Px9y/UFMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TfzfbRKD9wGn4D9M8fk4CCETgUFtL32SrbiMFdKE23lCkGfwf1rDw55LhbzMvFBrT
	 EgdUBKJ3s6013h0AiFvGZ31h4DL306mX7ipmx/kgLFP+FXQUhBZPEPKzTZoqRpTYXm
	 kvNM4Fuo6gi+MmF1P9/KaxhpzPiqjTREwkdgbSP+R+YYswCBTfT3YfjQGRsfQyKZ0d
	 g8WdX2pvpPsNS5K8lwY5VjMoG/rkLf+fQadbaz9t7//pKNCKrAy9ltNyfxcy+fh+6v
	 ojvvVZN6XlBObYLsOXrzEBX25z9bdqs7K7PLsJ75lbXZ8IasDPqo7L78Oi7XSlpBAY
	 vCucE9LlzDM1Q==
Date: Wed, 14 Aug 2024 19:15:06 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eric Blake <eblake@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 04/10] qapi/acpi-hest: add an interface to do generic
 CPER error injection
Message-ID: <20240814191506.21894ac7@foz.lan>
In-Reply-To: <20240814145322.00002dcb@Huawei.com>
References: <cover.1723591201.git.mchehab+huawei@kernel.org>
	<c44e6c39e6cf95a738999b721cdf71e4887258a9.1723591201.git.mchehab+huawei@kernel.org>
	<20240814145322.00002dcb@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 14 Aug 2024 14:53:22 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Wed, 14 Aug 2024 01:23:26 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Creates a QMP command to be used for generic ACPI APEI hardware error
> > injection (HEST) via GHESv2.
> > 
> > The actual GHES code will be added at the followup patch.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> A few trivial things from a quick glance at this
> (to remind myself of how this fits together).
> 
> > diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
> > index e07d3204eb36..73ffbb82c150 100644
> > --- a/hw/acpi/Kconfig
> > +++ b/hw/acpi/Kconfig
> > @@ -51,6 +51,11 @@ config ACPI_APEI
> >      bool
> >      depends on ACPI
> >  
> > +config GHES_CPER
> > +    bool
> > +    depends on ACPI_APEI
> > +    default y
> > +
> >  config ACPI_PCI
> >      bool
> >      depends on ACPI && PCI
> > diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
> > new file mode 100644
> > index 000000000000..92ca84d738de
> > --- /dev/null
> > +++ b/hw/acpi/ghes_cper.c
> > @@ -0,0 +1,33 @@  
> 
> > +#include "qapi/qapi-commands-acpi-hest.h"
> > +#include "hw/acpi/ghes.h"
> > +
> > +void qmp_ghes_cper(const char *qmp_cper,
> > +                   Error **errp)  

Heh, with all code changes, this is not a lot simpler than before ;-)

I'll address it on a next spin.

> That's a very short line wrap.
> 
> > +{
> > +
> > +    uint8_t *cper;
> > +    size_t  len;
> > +
> > +    cper = qbase64_decode(qmp_cper, -1, &len, errp);
> > +    if (!cper) {
> > +        error_setg(errp, "missing GHES CPER payload");
> > +        return;
> > +    }
> > +
> > +    /* TODO: call a function at ghes */
> > +}  
> 
> > diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> > index 419a97d5cbd9..99d12d69c864 100644
> > --- a/include/hw/acpi/ghes.h
> > +++ b/include/hw/acpi/ghes.h
> > @@ -23,6 +23,7 @@
> >  #define ACPI_GHES_H
> >  
> >  #include "hw/acpi/bios-linker-loader.h"
> > +#include "qapi/error.h"  
> Odd to have an include added with no other changes in file?
> Wrong patch maybe?  Or should it be included by a c file instead?

Removing it would cause a compilation breakage. It might be moved
to a c file, but patch 5/10 requires it at ghes.h, as it adds
this to ghes.h:

	void ghes_record_cper_errors(uint8_t *cper, size_t len,
        	                     enum AcpiGhesNotifyType notify,Error **errp);

So, instead of poking around moving this to/from .c/.h, I opted to
place it on its final place.

> >  #include "qemu/notify.h"
> >  
> >  extern NotifierList acpi_generic_error_notifiers;
> > diff --git a/qapi/acpi-hest.json b/qapi/acpi-hest.json  
> 
> 



Thanks,
Mauro

