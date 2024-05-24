Return-Path: <linux-kernel+bounces-188831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0375A8CE794
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF9F1F21DC6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F83512DD98;
	Fri, 24 May 2024 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDBLqhEG"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510AF12D748
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563436; cv=none; b=qBf0Mdva8bcy2Z10VQvKSj80H/Kh2Syj2nAgiPbafT7qYHJj98BTlqtZNRxZXW6UIrBE6qdWqcOQLrCIlK6vCScISQoIZ7JycDRn+lfy79kamxVlMttcu1pd8I+qio3jchKzL3AS6mJtd1ycAeo9ZmOxu53BUqK2K05l02Pt8po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563436; c=relaxed/simple;
	bh=PUnc9znH3XnYmN1qWdPzarIaZgPvGA08yivr+HVT7Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8WdCxXu5p2DUznnxww4TkvolgS/uuAgais/MHApOUqWsd5fWWamcHhLum8/fpv4xQY/ALwKhX85u0XDvtClgq4HRPWXKrWwBwei9dhudzTbROBQB+S1rbFaSCWfS7zTVjPms4rGMYoZjcatpKEMlcqDFDQFYCp8cfP2LsJupMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDBLqhEG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f44b59e234so6916465ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716563435; x=1717168235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Af8OGgxbQV2zOwezxQcvFU86Dm2eLu88EEanROVZ7Gs=;
        b=BDBLqhEG4h48tI4prL7qqJx/vAOxk6A795FggwFPv0sYtAZPxG4LOo46+CoNn3+0H6
         KVSnCFVCnQ0C2PRzbMS8hpbFJ2YfLOuiXQoRpUZIo+LtaJnMeN0CfcTPxuOgL4aqEzW1
         vKbZSQD6hbb47urCxMFZ0mxcA1PSEF4foBxvAOobOxaZEmZBtTD4hvIm3aTLeIqsaOcK
         cNJZGo6OhkM0kfh2+uaojvFcjz7p8u7QuWc90KNpo06aieuE25Brei79lFXeNwXgSNDJ
         VH1mWwluwIkLXkiRuYL2ohqmHngN4mmFLuifaoPqQp5dQuxXqh24cKUMmnhOdsVIu+XK
         gJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716563435; x=1717168235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Af8OGgxbQV2zOwezxQcvFU86Dm2eLu88EEanROVZ7Gs=;
        b=hsfAXk3yaTVyqYF6qtwD9f327Lz2R2IiKnxkurH7RfT1+Yq6Z6VFvQiZP3uk0NlEll
         W0VNh+7QUr4z+TmTA722fOSre5yxP3YMLGWbMugCySH4LWJGHHuODzK+T/HT2TixQ7uV
         GQpATWqLWNmj+ebGGEkBDsHCZp21q77bqDmODIBpW0ay9vWsiI/iPCI3dLtydQaw+b1d
         AwkiU1D9Zwr85pd3eMD9VGRA6c6o3ODfONlQzIGZtM4SsduEw0cExRRjYIywKTsMA8CE
         NyNcySTT0W73XGgwSrX40HkHIeeiU6UChdD4QdEeX9DDm2+9MtOpZH2mQ+jrwNLSsXvu
         uE7w==
X-Forwarded-Encrypted: i=1; AJvYcCUmYyO6/wpmmg5Z6hyQFWOx7DxhCxxQi/TwAYJy6G0TLS0nyaaYyUWqqrUhwAVE0c6s447o4gyP0tlNsDLkDqG+Xe08TKVfG64u0Q/y
X-Gm-Message-State: AOJu0Yya7eH6aX9tMsfEf9+igvGN1afiemkHbVoaifdSVi8SDsLG2mJB
	JBLkt1S/RrxGrv+7WXzn6R7bLUKR9hsdMzhsIiN9V6tEJo/cAuGG
X-Google-Smtp-Source: AGHT+IFKYN2gEtwY0G5Fgxz9qkP4RfG7v4i0vZYDVcNVAVijtzn7fY8SJLSV2w+zed8Sv5SV56vdfg==
X-Received: by 2002:a17:903:230a:b0:1f2:fe12:b79e with SMTP id d9443c01a7336-1f4487029cemr23870065ad.17.1716563434513;
        Fri, 24 May 2024 08:10:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7535d2sm14989705ad.22.2024.05.24.08.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 08:10:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 24 May 2024 08:10:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Conor Dooley <conor@kernel.org>, naresh.kamboju@linaro.org,
	linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org,
	regressions@lists.linux.dev, linux-riscv@lists.infradead.org,
	apatel@ventanamicro.com, tglx@linutronix.de,
	anders.roxell@linaro.org, dan.carpenter@linaro.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: riscv: irq-riscv-imsic-early.c:52:9: error: too many arguments
 to function 'riscv_ipi_set_virq_range'
Message-ID: <ab42f444-b10c-4992-bc6a-83e269cfe9d0@roeck-us.net>
References: <20240515-zen-calculate-289cfb90cd65@spud>
 <mhng-10b71228-cf3e-42ca-9abf-5464b15093f1@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-10b71228-cf3e-42ca-9abf-5464b15093f1@palmer-ri-x1c9>

On Wed, May 15, 2024 at 10:05:59AM -0700, Palmer Dabbelt wrote:
> On Wed, 15 May 2024 07:36:33 PDT (-0700), Conor Dooley wrote:
> > Palmer,
> > This is the issue I point out to you on the call earlier:
> 
> Ya, thanks, I just hit it.  Looks like it's a semantic conflict between
> 21a8f8a0eb35 ("irqchip: Add RISC-V incoming MSI controller early driver")
> and dc892fb44322 ("riscv: Use IPIs for remote cache/TLB flushes by
> default").  I think all we need is
> 
> diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
> index 886418ec06cb..4fbb37074d29 100644
> --- a/drivers/irqchip/irq-riscv-imsic-early.c
> +++ b/drivers/irqchip/irq-riscv-imsic-early.c
> @@ -49,7 +49,7 @@ static int __init imsic_ipi_domain_init(void)
>                return virq < 0 ? virq : -ENOMEM;
> 
>        /* Set vIRQ range */
> -       riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI, true);
> +       riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI);
> 
>        /* Announce that IMSIC is providing IPIs */
>        pr_info("%pfwP: providing IPIs using interrupt %d\n", imsic->fwnode, IMSIC_IPI_ID);
> 
> as a conflict resolution, which IIUC should happen when Linus merges my next
> PR.  So I'll try and remember to call that out.
> 

Unfortunately it looks like the conflict resolution did not happen,
and mainline builds are now affected.

Guenter

