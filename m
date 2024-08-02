Return-Path: <linux-kernel+bounces-272479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B99945CBA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D02282B0D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA5D1DE852;
	Fri,  2 Aug 2024 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="Qlto+zct"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D69B14A4E0
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722596586; cv=none; b=hQtvqqPc9phngKJ/SawBtHyjhvAVVDj6FIBDUckTR5FwSATaWSEAZyqJA7suoC7uFtYNn36kDS803hwJ1zmiSeFYbeNZl1waxVdBb2FALmhlA3LmBTlb3erDhn6+jVSk1b7kADfrkbWtLio86GwNgnDLVaa8lO1RQM/n6ssWm+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722596586; c=relaxed/simple;
	bh=gvZ32kuJnAQHWuEQ5kKTNJZn1SJB/jyL2wR18+EWeR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbXT/DASBawj+zn3c4ONH8dJQ2fA4iDOk6aGXXoI5bJWzzRagmGs/E4niJlpvTRFXrY7KEzJus6DfF3T1YoukUb38W819eykjFQlp2gKyufJGczd4qgW4vYHPl8sGr1T2/ndm8DJIevNHmG6warxRbq78G9V6QYZ4N+I36VizGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=Qlto+zct; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39b27935379so377195ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 04:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1722596583; x=1723201383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwUaUssVs29PUTspR4BzI9XA6uViKQGq2HqZKYi3CTc=;
        b=Qlto+zctyM2d0HF/PH5fQq0GapbLD5YvzK/OVdnUF1VZMJlbtO0geIhHOGvsVmT/0a
         Si9hlhqDeDKkLkge0XBa6vb06ShwU69CsvSuHiuC1GgX/dDoAALqSPIzlWQ8r4Emgds8
         +W84yclJ6O13sDgOAB98qg4BHIxdq9Uo1Gq49O49jyyo2Rmrh5ZG+nNwBVGQ8cFz5yUP
         eKiF2NZKIkl4ZoedFCbhs1P2jl+qDvMKRCvRlRi//l5gsapdcM9ZDpe02w6mjmyoBc/g
         KP5XNLGVOYVFpDgRO85uQHRQq5yqc+jTl8LckgilwiWCCwUnTsytw44wizTj8XqW9PPh
         5iCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722596583; x=1723201383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwUaUssVs29PUTspR4BzI9XA6uViKQGq2HqZKYi3CTc=;
        b=EuH3sIIrxirGtP/cuzO1K5EpBzSU5QbRAnizQD7V6SzYBNeK22pgtbi9zucIagBm41
         JsaCn4PC3JT7NkugH8FN7LRwvLR1TavpZG6D2ARGYfwSUixUY8F6oPSwW1zrG5Rr1Rbc
         XSlBePg5/MMmELOQTmN+NXJh3bNJunAFLtvCs8klmE6l7IhAi8gLkletkmvq/bhHxSZC
         VBZeFW4b3f4UFVvt5qmM1ItDN2TE1cMbvOL21KirG09LytJkpowhDO5GNsb/bNq6pBV3
         6RDFwRyK4sTcJ3GP6jZIyM2vWvPSlpxYHAxxYyg5rXBn6KgcSoQ43r6ynRnCqufg5/jw
         EQDg==
X-Forwarded-Encrypted: i=1; AJvYcCWUYA23ZQACQUrvbwyyfMsKEa7p9ZOWGvrgv9IeF/VhE0Ll+qUr8IFGTvvvqFCjIPchTPuM8r9s7B5WHoUBIBTTMWOG8jPEj4JC9z5J
X-Gm-Message-State: AOJu0YzlOG1/6jUTymxB4Te5HSkUBI63imzKhrDONBefAznCsqae1EaR
	Mz9esQlfirwdMnDOuPyD45n12/MwgiNCeuXlf+ADzSOvnzPflrFtUwpo7c/jbJn7Bn5FXp09Zrg
	NqWk0c9hM2H5fA9Of3TBk2/S5OS3r68dbc+m4jw==
X-Google-Smtp-Source: AGHT+IH43E7Mfc6q5x718I3ZcYVbr40JWGwdK4O48RfeKEf97bzGFtbKMl5FOuQjZpif1eAkLPoTxnfBQkNOJQTgESk=
X-Received: by 2002:a92:6b08:0:b0:375:dc39:cfd2 with SMTP id
 e9e14a558f8ab-39b1fb92548mr37783595ab.11.1722596580822; Fri, 02 Aug 2024
 04:03:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802075741.316968-1-vincent.chen@sifive.com>
In-Reply-To: <20240802075741.316968-1-vincent.chen@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 2 Aug 2024 16:32:48 +0530
Message-ID: <CAAhSdy3yx=mm3M6U_Q+_WdMs12SGCypPgNkBAVc9Kwn9jgev6g@mail.gmail.com>
Subject: Re: [PATCH] irqchip: let the probe of APLIC be earlier than IMSIC
To: Vincent Chen <vincent.chen@sifive.com>
Cc: tglx@linutronix.de, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 1:27=E2=80=AFPM Vincent Chen <vincent.chen@sifive.co=
m> wrote:
>
> When the debug message of driver/base/dd.c is enabled, the following
> error messages are present in the boot log:
>
> [    0.207941] platform d000000.aplic: error -EPROBE_DEFER: supplier
> 28000000.imsics not ready
> [    0.208115] platform d000000.aplic: Added to deferred list

We are relying on fw_devlink implemented by Linux DD core to do the
probe ordering. The above prober defer message implies that the
Linux DD core is doing its job correctly.

>
> The reason for this error message is that the probe of APLIC is executed
> earlier than IMSIC. This error also causes all the platform devices
> connected to the APLIC to be added to the deferred list. Because both
> APLIC and IMSIC are registered by device_initcall, this patch adjusts the
> compile order of APLIC and IMSIC to ensure that the probe of IMSIC is
> executed earlier than the probe of APLIC.
>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> ---
>  drivers/irqchip/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 15635812b2d6..3c09666569d6 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -96,9 +96,9 @@ obj-$(CONFIG_QCOM_MPM)                        +=3D irq-=
qcom-mpm.o
>  obj-$(CONFIG_CSKY_MPINTC)              +=3D irq-csky-mpintc.o
>  obj-$(CONFIG_CSKY_APB_INTC)            +=3D irq-csky-apb-intc.o
>  obj-$(CONFIG_RISCV_INTC)               +=3D irq-riscv-intc.o
> +obj-$(CONFIG_RISCV_IMSIC)              +=3D irq-riscv-imsic-state.o irq-=
riscv-imsic-early.o irq-riscv-imsic-platform.o
>  obj-$(CONFIG_RISCV_APLIC)              +=3D irq-riscv-aplic-main.o irq-r=
iscv-aplic-direct.o
>  obj-$(CONFIG_RISCV_APLIC_MSI)          +=3D irq-riscv-aplic-msi.o
> -obj-$(CONFIG_RISCV_IMSIC)              +=3D irq-riscv-imsic-state.o irq-=
riscv-imsic-early.o irq-riscv-imsic-platform.o

First of all there is no issue here.

Secondly, changing compilation order in Makefile to influence
the probe order will not help in any way.

>  obj-$(CONFIG_SIFIVE_PLIC)              +=3D irq-sifive-plic.o
>  obj-$(CONFIG_STARFIVE_JH8100_INTC)     +=3D irq-starfive-jh8100-intc.o
>  obj-$(CONFIG_IMX_IRQSTEER)             +=3D irq-imx-irqsteer.o
> --
> 2.34.1
>

Regards,
Anup

