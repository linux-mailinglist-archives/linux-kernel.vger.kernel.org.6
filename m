Return-Path: <linux-kernel+bounces-331740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853B597B0B9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A802810A8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE3716B38B;
	Tue, 17 Sep 2024 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="yVstecOk"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E492A166F25
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726579486; cv=none; b=Hiou2BJaI+GUsW+jFo9ZjA1NhYVv+7kw6DEDCvg07QOmnCQdtrN5/QFB/9gdsMKh6MMkSY6e+BQ+lvvhT9Ndf8QhA+zPPzvJDgc1z20yEZpce5uD/Gb6QrIS9OMNq2fgyHT45DRtlL3c2t45SheQu8M3el6et2Yw/M9QXRi1Pmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726579486; c=relaxed/simple;
	bh=Gu+nQ7vQda4b+Ujmr4lLodnxU+xmstEw/XSIk3Da9I8=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID; b=m2tWVINBb1Gqt9bsbOkTUGYSZmVVZvcRUvmHJQ+a6cjxg5hjROo7UeOQDk3Gh4CYnQQ/rkIsRQvrFYr366mPe26kPdNtqfsf0M08BMyoEEKOPNv/8KKbSBhDZu0S9dguCbHp+/hZdzFEadNCk12bUDIUdd4V4c+h09zFqvRLgwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=yVstecOk; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39f49600297so19338455ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1726579484; x=1727184284; darn=vger.kernel.org;
        h=message-id:to:from:cc:in-reply-to:subject:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+GO6NbsJM6lj36sGfiQI8cJQWsBmv1dgpBBPrnX7Pwc=;
        b=yVstecOkxgb8fZXxm0IqH0ZhTVVS70c6GXTNNyJWndJPacCHT/9ly6lGMIezPCjCxu
         hEy8+VsA62Wj0VozCDp/37J2cUrpPwrI0/zRa3Qpsmx6yGtKEZI7xGcOl/FjANswQnv2
         RfX7+2cbm/xvE2gsilDZwvCTYr6AYM0ci4dH5WnZn2kX6R7lAyzTMoIKyYKoN7iSK7nf
         vyrKFmFK+OaLlL2evXRpva4FjgoNdULo63Pmn3My7BefYaSIqjPad6E9G4+zKBztfiB1
         uauApl8aFPlFxW/SPPc7zCdYjeSqgyWGrIhdGWj1nOwQR7TfSEOKpisyZ6mW4Hm9rnrF
         Pt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726579484; x=1727184284;
        h=message-id:to:from:cc:in-reply-to:subject:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+GO6NbsJM6lj36sGfiQI8cJQWsBmv1dgpBBPrnX7Pwc=;
        b=cE16ecmTRWGDd02Vtaekj/iq1n1AsdhXP1QVOWt8U0JcfXdUrlOWT7ql1Sr09SXj1b
         /gkAw8S37SgsD+EE5d5BqqDSMKxwRV8O1NJBQ6zijiWharyQs4Sw/UszrZCI81bJPzzQ
         Z5yP9CZerfoC8yoWslEKf4rbunSDTp9RkH1oKVoHWVzZLymG8/+r/cmKFvI2TxaVTPQY
         whhMRzeB8XW9iqCc0x1T1OwfdzLNJQVXkabZ8fRLSyWwHg3OVjVKpxVM4UwC+aNGyJFh
         Tr38yM+HbFOS70bYKY+60PLHP2Wf/OXAoB9qAtJdIndhNib0oTrbSBBOIyXhisEDE0tL
         cmIg==
X-Forwarded-Encrypted: i=1; AJvYcCU6TXhRHojSvQkivQfASiGs/NBQbr3lZVU0lTHrfRZAzarbm9vRIYQLQWTXzXQ6tvyirN6bjW9E6vXNUok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvBXq4QuTfBVHOU2ig/PZgn5jDVR6Wg/M13NwfYk5pvVoR7xHy
	nChUypVGsoFQa/DEQWAfL+MIC0t0IXSTDsX23onyGF69oTcbalpA9zNUZ8XHAEM=
X-Google-Smtp-Source: AGHT+IGzktPt5rKmypCFuPOGhoO3476MNHo/ULcvqysTy4mC+7xbksXlxosTGEXdcx5RmPg0u5jk5A==
X-Received: by 2002:a92:c56e:0:b0:3a0:92e5:af68 with SMTP id e9e14a558f8ab-3a092e5b19emr88470795ab.15.1726579483879;
        Tue, 17 Sep 2024 06:24:43 -0700 (PDT)
Received: from localhost ([213.208.157.38])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4998e21dsm5830170a12.75.2024.09.17.06.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 06:24:43 -0700 (PDT)
Date: Tue, 17 Sep 2024 06:24:43 -0700 (PDT)
X-Google-Original-Date: Tue, 17 Sep 2024 06:24:36 PDT (-0700)
Subject:     Re: [PATCH -next] irqchip/sifive-plic: Make use of __assign_bit() API
In-Reply-To: <20240902130824.2878644-1-lihongbo22@huawei.com>
CC: tglx@linutronix.de, Paul Walmsley <paul.walmsley@sifive.com>,
  samuel.holland@sifive.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
  lihongbo22@huawei.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: lihongbo22@huawei.com
Message-ID: <mhng-d2276021-b769-46e2-af6c-40802385909c@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Mon, 02 Sep 2024 06:08:24 PDT (-0700), lihongbo22@huawei.com wrote:
> We have for some time the __assign_bit() API to replace
> open coded
>     if (foo)
>         __set_bit(n, bar);
>     else
>         __clear_bit(n, bar);
>
> Use this API to simplify the code. No functional change
> intended.
>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 2f6ef5c495bd..c576b9bbeb13 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -252,10 +252,8 @@ static int plic_irq_suspend(void)
>  	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
>
>  	for (i = 0; i < priv->nr_irqs; i++)
> -		if (readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID))
> -			__set_bit(i, priv->prio_save);
> -		else
> -			__clear_bit(i, priv->prio_save);
> +		__assign_bit(i, priv->prio_save,
> +		    readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID));
>
>  	for_each_cpu(cpu, cpu_present_mask) {
>  		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

