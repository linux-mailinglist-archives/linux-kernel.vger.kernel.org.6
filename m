Return-Path: <linux-kernel+bounces-433641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BD49E5B14
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332AA1884C82
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E373225764;
	Thu,  5 Dec 2024 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="B4sLpv/e"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3F822144F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415141; cv=none; b=dkCoWdqOreq5XKDK9jZIs83sRdwBvEsNkHzYMsEf7V1VorzNsAdQT25b4/Spz+0CTyYSHRHiz+jzbAt8X2BsEjzRdST3klxG7AEG73tQpoAYk6LH2avnE2pQ8gl8nJuYM0fbTVuFoXpJAASScnxS35orPINrsuz2KkzgQ+fwPDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415141; c=relaxed/simple;
	bh=Ut8+scTSjVpQnW57Q4gARiffheiB676olnzlE55eiMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooBHe2beQFUAYY+HF96X6kSo2nxi/ekF9FN2bopnMLnP7ggti+e6rvqN1LfUkt5j4J1f7/o3wSK8/0A5EzypCOtA8cwkImzFQRcqh2LEZlkGrzFeW1ZfQ8OvEtrRtq6DcVWfRKOCt7RatIKJ3TpWl6oU1hOQ6dhiu5C5Xlrg8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=B4sLpv/e; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385deda28b3so922917f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1733415138; x=1734019938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+3xHwvrZFGkgILsc+8sbeeDFiAlqkrIqdKcR5hFeMk=;
        b=B4sLpv/exmyOUHnfBCb8gxCy8CZ3BWOPcLwIawR8N8417SxzLYiqlquJGav5W0wsBE
         +c9gA3JzzHJAzYhBifHzgddHFj+BQh9PV4m8Aug6tVkrKmCmql0ZUzFoi864YxRoHKBb
         EzRhYjuWEKZnHhM5XZXDVxrEmp5A5GwMoeOBW4lUBDDbt4Te76cIIc/1Qo3W3B+cFysH
         O83c/kjm5AdXXKlsEOBYI4kYlcWFwqOXObhYf4zD//CUtWHrdTersHYfDrB3njWcv9UD
         2BQ99nE6/Af8ydEsWI7eZIiX67cRK4Tb/oWOFRZM8xv+IBvj5ujFeRyF73ntatgy749e
         dskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733415138; x=1734019938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+3xHwvrZFGkgILsc+8sbeeDFiAlqkrIqdKcR5hFeMk=;
        b=pMuud6yiKzbS1Qxv6TpZObcct6HCQTmICNuP/vU0m6UnsZzi8fUu8XjcWcKjx85h+1
         0jkp3/mCzF3VrD1MYsN5XpDtj251IxCOvq8/+HfRPBzv3ZBgJevs0cIGfkTb8Tl21Vlj
         kOL6Cb2En6d16i5b0W5q9DZRRdSvyETIbpFn3JKbn9exnMu0ZFeJLyn1OoFxsVVX3uQ3
         LLQ2EmehTDRze1/gCkU22yyC9cj1+zM6jnKlMO8d/ph8TN4NdD5hQkfx0fp6b+12WBFu
         4LsLTMY6AQJX5bd0xqTf2aOSwfYLcPVmfjAuuy/YopNRaWbPJFtvNKOUauLHlAbMDf+p
         5LkA==
X-Forwarded-Encrypted: i=1; AJvYcCVGfV4+NW/LROBMUqPj6/M9zLSEOfFlFxF4FS8tbeVdd9L/+QNuWBEE2P4S1hSjreIapPVe7+w1HfbHYcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPerHFt5oCTVZFeJm6Tb7YLtXbTJNQZnMYZMVp+G7Z9BPCHG/n
	RrqcC2lVwdkNhIb7csdv4u7QPfdiP80zeupmI5J0HjTgNCqB3+mta/G6Wo32ZJs=
X-Gm-Gg: ASbGncvYO8sS3Ny12lyG1DHkNyXEJAYuHPRFIwOCYNMfl84MTlzTpOTkaLf75IgijG9
	6VY0ZVgAwDa1YKx4t7BJdRMxM0V7j4wW5BulpNkZlnCrI+JsQZFnAWkaVXxxxoorriyRkaAhOrL
	Ayofy79jFbmIl6c8T1pROBCz3WRNXeWBvAFK/XjxTTB5zwDD+hF5OzLJN3GMb7cY05lGQe50/tq
	97ADf3tH7UWKhAyab9bBH5LbItH7n81IeZZ87r6NAdnyEjYrcE+4ikaAe1QFdJpQkDmSgGyfin7
	zXmGp44Q4Wb3JiOPvB26/t9SHb7zHZ2Fcys=
X-Google-Smtp-Source: AGHT+IHa5lee9Sxqmls08SUxS6uuiGe/lvzblZfbVXScCZEse7mEYCbZITkpv0Vj+gpxQag2jSxbIw==
X-Received: by 2002:a05:6000:18ab:b0:385:e8ce:7483 with SMTP id ffacd0b85a97d-385fd3ccbbfmr9165309f8f.4.1733415137730;
        Thu, 05 Dec 2024 08:12:17 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f4a874dsm2290643f8f.24.2024.12.05.08.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 08:12:17 -0800 (PST)
Date: Thu, 5 Dec 2024 17:12:16 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tjeznach@rivosinc.com, zong.li@sifive.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, anup@brainfault.org, atishp@atishpatra.org, 
	alex.williamson@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu
Subject: Re: [RFC PATCH 01/15] irqchip/riscv-imsic: Use hierarchy to reach
 irq_set_affinity
Message-ID: <20241205-2ed14db745f00a0ee9be444b@orel>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
 <20241114161845.502027-18-ajones@ventanamicro.com>
 <87mshcub2u.ffs@tglx>
 <20241203-1cadc72be6883bc2d77a8050@orel>
 <87a5dcu2wq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5dcu2wq.ffs@tglx>

On Tue, Dec 03, 2024 at 05:50:13PM +0100, Thomas Gleixner wrote:
> On Tue, Dec 03 2024 at 17:27, Andrew Jones wrote:
> > On Tue, Dec 03, 2024 at 02:53:45PM +0100, Thomas Gleixner wrote:
> >> On Thu, Nov 14 2024 at 17:18, Andrew Jones wrote:
> >> The whole IMSIC MSI support can be moved over to MSI LIB which makes all
> >> of this indirection go away and your intermediate domain will just fit
> >> in.
> >> 
> >> Uncompiled patch below. If that works, it needs to be split up properly.
> >
> > Thanks Thomas. I gave your patch below a go, but we now fail to have an
> > msi domain set up when probing devices which go through aplic_msi_setup(),
> > resulting in an immediate NULL deference in
> > msi_create_device_irq_domain(). I'll look closer tomorrow.
> 
> Duh! I forgot to update the .select callback. I don't know how you fixed that
> compile fail up. Delta patch below.
> 
> Thanks,
> 
>         tglx
> ---
> --- a/drivers/irqchip/irq-riscv-imsic-platform.c
> +++ b/drivers/irqchip/irq-riscv-imsic-platform.c
> @@ -180,7 +180,7 @@ static void imsic_irq_debug_show(struct
>  static const struct irq_domain_ops imsic_base_domain_ops = {
>  	.alloc		= imsic_irq_domain_alloc,
>  	.free		= imsic_irq_domain_free,
> -	.select		= imsic_irq_domain_select,
> +	.select		= msi_lib_irq_domain_select,
>  #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
>  	.debug_show	= imsic_irq_debug_show,
>  #endif

Hi Thomas,

With this select fix and replacing patch 03/15 of this series with the
following diff, this irqbypass PoC still works.

Based on what Anup said, I kept imsic_msi_update_msg(), which means I
kept this entire patch (01/15) as is. Anup is working on a series to fix
the non-atomic MSI message writes to the device and will likely pick this
patch up along with your changes to convert IMSIC to msi-lib.

I'd like to know your opinion on patch 02/15 of this series and the diff
below. afaict, x86 does something similar with the DOMAIN_BUS_DMAR and
DOMAIN_BUS_AMDVI tokens in x86_init_dev_msi_info().

Thanks,
drew

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 51464c6257f3..cc18516a4e82 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -36,14 +36,14 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
                return false;
 
        /*
-        * MSI parent domain specific settings. For now there is only the
-        * root parent domain, e.g. NEXUS, acting as a MSI parent, but it is
-        * possible to stack MSI parents. See x86 vector -> irq remapping
+        * MSI parent domain specific settings. There may be only the root
+        * parent domain, e.g. NEXUS, acting as a MSI parent, or there may
+        * be stacked MSI parents, typically used for remapping.
         */
        if (domain->bus_token == pops->bus_select_token) {
                if (WARN_ON_ONCE(domain != real_parent))
                        return false;
-       } else {
+       } else if (real_parent->bus_token != DOMAIN_BUS_MSI_REMAP) {
                WARN_ON_ONCE(1);
                return false;
        }


