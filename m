Return-Path: <linux-kernel+bounces-190018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9A38CF86D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE30281685
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB580D518;
	Mon, 27 May 2024 04:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HUWtPH+B"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC579F6
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716784569; cv=none; b=gCDAxSVy0uxokwwNhvKaebGOBQQxAWdWR/fGZNuwtoMXkfb0GyOP/C1Earz5gdodma2q9795Qzn89NKyVbFDo8Wli7vzUgv4bNRGpL88alH7lAGbnAm4up+I6klWBpuhm37Py/H8VSBEWakddWpMyzNu986ORmmq5gXCbQXIERE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716784569; c=relaxed/simple;
	bh=xrShOrBMudNx1lIclZjti31jJIj1JbkTGrXCdkVq56E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuyGcZ56Xdu1QNCk/iJtGjBCFQNImAredoSP+5NBC2TmSzrhPeEUH30L/+mAGORnXVOr5Z91qXhCx8n06thGXtOixI/us/X7XxRhKmouBkMQmkxE8N5QBx1GW/uQhgPHHjJYkeD+n7aTVBofH8IDPX4QVpG+X9/OxdSpmz8RIPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HUWtPH+B; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f4a52b9589so2682495ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 21:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1716784567; x=1717389367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GCL45r5HwUdhMGMoKs1ELoA50Buz5dFrdewkzzL6SwI=;
        b=HUWtPH+B4s9VBr7trmJFxqpU9h7juGROj+DdwSAGFXn00tLV80cqU8gE0xdMrQPnoF
         wW5xf7Ulb0Gc9w7n2Svvv+l3z4ArPKtXXweQHSToFwHXeZAMV19FMvhYZzqpdBHJu16C
         s3SB5DujB+Gk/1J0mnvEq6oej2Al7a+KZD778zlL9b/i129ZqDkjrjPSq7FL2S2h13Lr
         y9vJcuuJBbmVTeS4KMzPdhfCTNxO/bU76lY96Np6AxLTYYNM6xFWuhmt3TdFS6suAHEE
         0Lx0Ri88aVapvC4n19UGgE16go7ZxBXfBhegovEOO2yOOsFuuoD1MkYaOZPwtVZuRId/
         CPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716784567; x=1717389367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCL45r5HwUdhMGMoKs1ELoA50Buz5dFrdewkzzL6SwI=;
        b=npxS/yGDMPgw5PEQPDzjTXAlFnrvXTdSsgtuE+bK410C5D8B3KFR3OgMSDSD8+o52b
         3pMN3TkiL0KCLukwrZpADaKf76wL3VhfWO9EPYUuNGcOWJn7spCdAQw3xtDJ++UuwMDb
         +PgvO5NmNr8wT2o9O32m07cGnTnfWYfyvhk+nLhfmZWsrxzUxLZLyL940k4wH+FJOm7p
         yHNy2VbLW240ylURms0dbM3uhUPVv/1s+VNulIPkmtGYmTNknCEo67Afhjd1RIXdnYHD
         XwX2rJCH35h8gARs+nNKFXzglw88L9SLVoKgUDJi1xCp2l4IomqSCEuKqgHIQNtQhqcL
         Syog==
X-Forwarded-Encrypted: i=1; AJvYcCWtDNenTeOejowlQqmRTXI8DfktWiAXcUy8buwiKWJRY03ruZ1efn7wNFaGBGlRfxLiSWKTHS7BZ6j5KSwdIqiOqwHKq8w5ZFR93abB
X-Gm-Message-State: AOJu0Yx3K875+y40i5hYnEK8+gq91+EvwpEa9wus3+pTi4zQOcZHO9ch
	yQBENF6fFm1fGF7y22C+VIUQr+8u7HDyfJQNv+hjIrOp41rggbLiBUdCvFCwm7s=
X-Google-Smtp-Source: AGHT+IH2qTAk+H4YWdMT+3HDQ47VPDZxZ9rT9jbAlx84jUV+F91w+En1i4ZeI520OwORxw1JjKsITQ==
X-Received: by 2002:a17:903:2306:b0:1f4:a77a:3bb9 with SMTP id d9443c01a7336-1f4a77a3ea0mr9409085ad.64.1716784566971;
        Sun, 26 May 2024 21:36:06 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c968516sm50975975ad.179.2024.05.26.21.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 21:36:06 -0700 (PDT)
Date: Mon, 27 May 2024 10:05:54 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH v5 07/17] ACPI: bus: Add RINTC IRQ model for RISC-V
Message-ID: <ZlQNqiWXNpv30AGp@sunil-laptop>
References: <20240501121742.1215792-8-sunilvl@ventanamicro.com>
 <20240523215903.GA138985@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523215903.GA138985@bhelgaas>

On Thu, May 23, 2024 at 04:59:03PM -0500, Bjorn Helgaas wrote:
> On Wed, May 01, 2024 at 05:47:32PM +0530, Sunil V L wrote:
> > Add the IRQ model for RISC-V INTC so that acpi_set_irq_model can use this
> > for RISC-V.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  drivers/acpi/bus.c   | 3 +++
> >  include/linux/acpi.h | 1 +
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > index 17ee483c3bf4..6739db258a95 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -1190,6 +1190,9 @@ static int __init acpi_bus_init_irq(void)
> >  	case ACPI_IRQ_MODEL_LPIC:
> >  		message = "LPIC";
> >  		break;
> > +	case ACPI_IRQ_MODEL_RINTC:
> > +		message = "RINTC";
> > +		break;
> >  	default:
> >  		pr_info("Unknown interrupt routing model\n");
> >  		return -ENODEV;
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 846a4001b5e0..c1a01fd02873 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -107,6 +107,7 @@ enum acpi_irq_model_id {
> >  	ACPI_IRQ_MODEL_PLATFORM,
> >  	ACPI_IRQ_MODEL_GIC,
> >  	ACPI_IRQ_MODEL_LPIC,
> > +	ACPI_IRQ_MODEL_RINTC,
> 
> Is the ACPI_IRQ_MODEL_RINTC value documented somewhere?  Maybe an ECR
> for the ACPI spec?
> 
> acpi_bus_init_irq() is going to pass ACPI_IRQ_MODEL_RINTC to _PIC, and
> ACPI r6.5, sec 5.8.1 only mentions the ACPI_IRQ_MODEL_PIC,
> ACPI_IRQ_MODEL_IOAPIC, and ACPI_IRQ_MODEL_IOSAPIC values.
> 
> Even the existing ACPI_IRQ_MODEL_PLATFORM, ACPI_IRQ_MODEL_GIC, and
> ACPI_IRQ_MODEL_LPIC values aren't mentioned in ACPI r6.5.
> 
Yeah, I also noticed it. I don't know the history behind this. Rafael or
someone else might have better knowledge. IMO, it is better to update
ACPI spec _PIC with all these values. If I don't see any objections, I
will raise an ECR to update the spec.

Thanks,
Sunl

