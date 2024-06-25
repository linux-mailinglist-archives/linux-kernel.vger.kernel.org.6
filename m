Return-Path: <linux-kernel+bounces-229241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85391916D36
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91CB1C2048D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A5A16F0F6;
	Tue, 25 Jun 2024 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="jbUXl7GF"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C64847A64
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329778; cv=none; b=K2VJBIOinvK7/OP9f58sLAHFpEL0kuDJR8FeFb9yyed7RnTn2bH85qt5jh/IubMJM2zv3/0rYGxkP3q7nd3W8DLb3pk+39UWx3jxhdp8rP/SduejOG4GhzSghDcBWHCJLINZf2tNCWAcUCA031yuSkl++sTHktDtmWdXbPmJ+O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329778; c=relaxed/simple;
	bh=68KI8uiF8gCj47gWXr2F0l40VS/7c/NxbsbaxrO9RnI=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=KxemSCBeQZXpNDrkq5eT58vQYOXcqEizLjwqM5StsBH688qlt5muPkCrWNzeiKpxIHdCV34HgAzz3KUoiCN0uFjn2AqTmoMzQGfs9JdKVLWCz4Butre42nkSX82OxGxI/38vYQY5eJyWgb4dt9JgZaLwxPylJwGlKGKr2eXvOWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=jbUXl7GF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f9c6e59d34so47155545ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1719329776; x=1719934576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEraVljjtG6yZ3F7hZuYF2rXzKtHxlFX+R3/h/MRFAM=;
        b=jbUXl7GFplh+UUbwt4unVjiPQmmNlYAVSqHpRJ7xb5gBKnOeEE09bv4BPBhwkAHTvD
         riczW/yDtrW9D7mJVPVD8MgQlSYz41aY6rY6VRU3kLFIzgn4nifA/D4jC7tf8KBjMMe2
         hqjMM0PgGG643PuDMjNtFbbJxowEYtXwvKcj+NXsU0TgSuSrTgpRrb2EpPdM9HniEgZJ
         FlknX32mmYUzF80VXt6Pwi2pMDz0APyFit6ThNza5QJgIB3WmvSP1nSbqt7WppFY7tX0
         dQzWxTeZDaSp7VS6aiWePSQaUgTqG2FW7Y0ZsDNrpRdzCvZ0lw7tC1MgwjkB9lMqq0fw
         14AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719329776; x=1719934576;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEraVljjtG6yZ3F7hZuYF2rXzKtHxlFX+R3/h/MRFAM=;
        b=YVG90/7cCj13B26+lYx8gH5lNPDlC4cUkmZfSedDeeJJICmVZCYVRmPsSHbXUvxNOc
         /N5cU4Da1QDRlqvp7DpJfyCABVNAIDTk3ljFuRQz7fWpjqzambdV9sWBRHBi3X6pfHv7
         eEQkkNNC5F86PLOhL/QR23T17QXPZk4HHniVql51scw4/Mhvc8cgJlv4g1SqXPnV6CEq
         ++Ox0rOSAACDfy1NAnfKCfuqTixITyNARlaFR7ET026XiG9e4YYXgtxGNYYREiHBaVGL
         oPVceyq7Xp9PKpK75/n623bvfDoaOP+FUxyzEfCFEnEcEQv5HzLEzH8UfwSqJdEO6FF+
         CxJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf7L+q5jxd4vM/k4KZdnjm/DOCYlEcebA4DcLkfqxanTndlUjSe/+M3Q8CUOrFmAYlcDxLOnBp7W0131rpN+8ucSLTCESswVpAvhh8
X-Gm-Message-State: AOJu0YwpxLeQAIv6vJKUbwpfNTGxAjUJhnobKGzGk6X9QpLF5k6KmkZA
	9DYOoSB7V6q5/PvNW5sC2q4NEG6mGcxD0ME4VyN0EVB0jjdhT9Ua5N1/N+QZnJMsFLk2b10t8gx
	p
X-Google-Smtp-Source: AGHT+IEVO2RloeRFS7aruFEhKi3Dam9+w8kNJr0NKAJEy2z+RvgfGkDPX/JEBDXkFZBWZxQs9gGhyA==
X-Received: by 2002:a17:902:da81:b0:1fa:2b1f:6762 with SMTP id d9443c01a7336-1fa2b1f68eamr88102695ad.45.1719329775863;
        Tue, 25 Jun 2024 08:36:15 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fa0bf76ca7sm63983305ad.277.2024.06.25.08.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 08:36:15 -0700 (PDT)
Date: Tue, 25 Jun 2024 08:36:15 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2024 08:36:13 PDT (-0700)
Subject:     Re: [-fixes] riscv: kexec: Avoid deadlock in kexec crash path
In-Reply-To: <20240609141802.6976-1-takakura@valinux.co.jp>
CC: alex@ghiti.fr, songshuaishuai@tinylab.org,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, guoren@kernel.org, xianting.tian@linux.alibaba.com,
  takahiro.akashi@linaro.org, takakura@valinux.co.jp, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: takakura@valinux.co.jp
Message-ID: <mhng-cd9af4c1-3eb8-4053-8d59-e59c12c14166@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Sun, 09 Jun 2024 07:18:02 PDT (-0700), takakura@valinux.co.jp wrote:
> Hi Alex, Song,
>
> On Fri, 24 May 2024, Alexandre Ghiti wrote:
>>Hi Song, Ryo,
>>
>>On 06/05/2024 07:10, takakura@valinux.co.jp wrote:
>>> Hi Song and Paul!
>>>
>>>>> To avoid the deadlock, this patch directly EOI the irq regardless of
>>>>> the active status of irqchip.
>>>> Taking a quick look at the other architectures, looks like no one else is
>>>> doing this.  Is this addressing a RISC-V-only problem?
>>>>
>>>>> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
>>>>> index f6c7135b00d7..d7ddf4d2b243 100644
>>>>> --- a/arch/riscv/kernel/machine_kexec.c
>>>>> +++ b/arch/riscv/kernel/machine_kexec.c
>>>>> @@ -149,20 +149,12 @@ static void machine_kexec_mask_interrupts(void)
>>>>>
>>>>>   	for_each_irq_desc(i, desc) {
>>>>>   		struct irq_chip *chip;
>>>>> -		int ret;
>>>>>
>>>>>   		chip = irq_desc_get_chip(desc);
>>>>>   		if (!chip)
>>>>>   			continue;
>>>>>
>>>>> -		/*
>>>>> -		 * First try to remove the active state. If this
>>>>> -		 * fails, try to EOI the interrupt.
>>>>> -		 */
>>>>> -		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
>>>>> -
>>>>> -		if (ret && irqd_irq_inprogress(&desc->irq_data) &&
>>>>> -		    chip->irq_eoi)
>>>>> +		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
>>>>>   			chip->irq_eoi(&desc->irq_data);
>>> I think this deadlock is relevant to riscv and arm64 as they both
>>> acquire irqdesc spinlock by calling irq_set_irqchip_state() during their
>>> machine_kexec_mask_interrupts().
>>>
>>> However, I think calling irq_set_irqchip_state() during
>>> machine_kexec_mask_interrupts() is arm64 specific way of handling EOI
>>> which is not necessary for riscv.
>>> For arm64, its interrupt controller(gic) seems to have two ways of EOIing
>>> an interrupt depending on the mode which gic is configured. One of them
>>> treats EOI as two step procedure, priority drop and deactivation. I think
>>> irq_set_irqchip_state() is there to handle the deactivation part of
>>> the procedure.
>>> For riscv, EOI only requires irq_eoi handler to complete EOI and I think
>>> keeping irq_set_irqchip_state() will only leave this possible deadlock
>>> without any use.
>>> So I think it's best we simply remove irq_set_irqchip_state() as Song did.
>>
>>
>>I think this ^ is relevant and should be added to the commit log. @Song
>>can you respin another version with the updated commit log? @Ryo can you
>>add your Reviewed-by when it's done?
>
> Sure!

Just checking up on this one, I don't see a v2 on the lists.

>
>>This fix has been lagging behind for quite some time, it would be nice
>>to merge this in 6.10 and backport to stable.
>
> Sincerely,
>
> Ryo Takakura
>
>>Thanks,
>>
>>Alex

