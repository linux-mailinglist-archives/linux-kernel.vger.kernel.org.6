Return-Path: <linux-kernel+bounces-299757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BB295D9B9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF7F1C23BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3978A1C8FDB;
	Fri, 23 Aug 2024 23:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vORTuiKb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FAD61FFC
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724455702; cv=none; b=JsvmkBajAsys3m6urZRoYsAkY0rSYrZ0ZOfcFSuCwYDKn7CxRRh9hTn38u62Ko0NI097OUlxj1ojl4tcy8OXMHEj4gM3Qezim0gsBLuYTIdDoBq4UE93iRfvJrENxdGcidM2Jt2jDIik4P9KEAprcm2+uWK/2y01ylvVYPuUtJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724455702; c=relaxed/simple;
	bh=qUWlsVBaCvs/ScOoZEuc4eDAUzoBoNdCnkHyMXoBP0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZDDj4JhiyzoSP7qkJwZ2fidj50TLwZy0E5cC5VtATTsiBAu8cVCMR3ErGI25boNKp+5S/OxJ/0wAX6zRbd3xuW0ybY7VLWrfYF7VC54IzWRlzyIcCnp40sDrLHztBC1YQXP0R0J7TubIH1ncHNZEUlUoIGV531DFpDu06YBDy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vORTuiKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57787C32786;
	Fri, 23 Aug 2024 23:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724455701;
	bh=qUWlsVBaCvs/ScOoZEuc4eDAUzoBoNdCnkHyMXoBP0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vORTuiKbLxZNPOEQ0PzthnF0YH6X3D3t02uOkqzxXEq3ydhuflVlK3Waov1PUgvD3
	 7cF8XEuVzOfd9feh4tnCeA5ZFXAep0b31PKMPFr1s0danzrge9wOW0+haFLp1CCj/S
	 lQOizMv3uah49tKyOFUH8fpRFmgXA9loFR6Pa+w8xkdzzHG6hqcj9josDJwMI6JLjy
	 JZk0F/3AUmy4xUbjEERKYoPRKj8ckzWxQfe1WsNR+bzzR9u3BObxclWpPquTBY5tns
	 MNvjEK8mV5/IxshEJXM62Wjf9e9cUjTXPuZtMJkwbgdpizZSn0w1f6hMAPFWAv6x0R
	 IOMmxMh68Yg1g==
Date: Sat, 24 Aug 2024 01:28:06 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 03/13] acpi/ghes: Add support for GED error device
Message-ID: <20240824012806.6189d0a4@sal.lan>
In-Reply-To: <20240819134304.68c54eae@imammedo.users.ipa.redhat.com>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
	<ba1864f1aa7073abe090eec0c31915f187967140.1723793768.git.mchehab+huawei@kernel.org>
	<20240819134304.68c54eae@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 19 Aug 2024 13:43:04 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Fri, 16 Aug 2024 09:37:35 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > As a GED error device is now defined, add another type
> > of notification.
> > 
> > Add error notification to GHES v2 using
> >a GED error device GED triggered via interrupt.  
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This is hard to parse, perhaps update so it would be
> more clear what does what
> 
> > 
> > [mchehab: do some cleanups at ACPI_HEST_SRC_ID_* checks and
> >  rename HEST event to better identify GED interrupt OSPM]
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > ---  
> 
> in addition to change log in cover letter,
> I'd suggest to keep per patch change log as well (after ---),
> it helps reviewer to notice intended changes.
> 
> 
> [...]
> > +    case ACPI_HEST_SRC_ID_GED:
> > +        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);  
> While GPIO works for arm, it's not the case for other machines.
> I recall a suggestion to use ACPI_GHES_NOTIFY_EXTERNAL instead of GPIO one,
> but that got lost somewhere...

True, but the same also applies to SEA, which is ARMv8+. After having
everything in place, I confined the source ID into this code inside
ghes.c:

	enum AcpiHestSourceId {
	    ACPI_HEST_SRC_ID_SEA,
	    ACPI_HEST_SRC_ID_GED,

	    /* Shall be the last one */
	    ACPI_HEST_SRC_ID_COUNT
	} AcpiHestSourceId;

	static bool ghes_notify_to_source_id(enum AcpiGhesNotifyType notify,
	                                     enum AcpiHestSourceId *source_id)
	{
	    switch (notify) {
	    case ACPI_GHES_NOTIFY_SEA:             /* ARMv8 */
	        *source_id = ACPI_HEST_SRC_ID_SEA;
	        return false;
	    case ACPI_GHES_NOTIFY_GPIO:
	        *source_id = ACPI_HEST_SRC_ID_GED;
	        return false;
	    default:
	        /* Unsupported notification types */
	        return true;
	    }
	}

The only place where the source ID number is used is at
ghes_notify_to_source_id() - still we use ACPI_HEST_SRC_ID_COUNT on other
places to initialize and fill in the HEST table and its error source 
structures.

On other words, the source ID field is filled from the notification types as
defined at include/hw/acpi/ghes.h:

    ACPI_GHES_NOTIFY_POLLED = 0,
    ACPI_GHES_NOTIFY_EXTERNAL = 1,
    ACPI_GHES_NOTIFY_LOCAL = 2,
    ACPI_GHES_NOTIFY_SCI = 3,
    ACPI_GHES_NOTIFY_NMI = 4,
    ACPI_GHES_NOTIFY_CMCI = 5,
    ACPI_GHES_NOTIFY_MCE = 6,
    ACPI_GHES_NOTIFY_GPIO = 7,
    ACPI_GHES_NOTIFY_SEA = 8,
    ACPI_GHES_NOTIFY_SEI = 9,
    ACPI_GHES_NOTIFY_GSIV = 10,
    ACPI_GHES_NOTIFY_SDEI = 11,

(please notice that ACPI already defines "EXTERNAL" as being something 
else)

Now, if we want to add support for x86, we could either add some ifdefs
inside ghes.c, e. g. something like:

	enum AcpiHestSourceId {
	#ifdef TARGET_ARM
	    ACPI_HEST_SRC_ID_SEA,
	    ACPI_HEST_SRC_ID_GED,
	#endif
	#ifdef TARGET_I386
	   ACPI_HEST_SRC_ID_MCE,
        #endif

	    /* Shall be the last one */
	    ACPI_HEST_SRC_ID_COUNT
	} AcpiHestSourceId;

and something similar at ghes_notify_to_source_id():
	static bool ghes_notify_to_source_id(enum AcpiGhesNotifyType notify,
	                                     enum AcpiHestSourceId *source_id)
	{
	    switch (notify) {
	#ifdef TARGET_ARM
	    case ACPI_GHES_NOTIFY_SEA:             /* ARMv8 */
	        *source_id = ACPI_HEST_SRC_ID_SEA;
	        return false;
	    case ACPI_GHES_NOTIFY_GPIO:
	        *source_id = ACPI_HEST_SRC_ID_GED;
	        return false;
	#endif
	#ifdef TARGET_I386
	    case ACPI_GHES_NOTIFY_MCE:
	        *source_id = ACPI_HEST_SRC_ID_MCE;
	        return false;
	#endif
	    default:
	        /* Unsupported notification types */
	        return true;
	    }
	}

An alternative would be to move source id/notification code out, placing
them at hw/arm, hw/i386, but a more complex binding logic will be needed.

If we're willing to do something like that, I would prefer to not do such
redesign now. Better to do such change when we'll be ready to add some 
notification support that works on x86 (MCE? SCI? NMI?).

Regards,
Mauro

