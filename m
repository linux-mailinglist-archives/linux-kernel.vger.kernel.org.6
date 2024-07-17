Return-Path: <linux-kernel+bounces-254695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA3B933673
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC011F22FDA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E1C10A1C;
	Wed, 17 Jul 2024 05:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="Nd7t96X2"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0EB1878
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 05:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721194721; cv=none; b=f4oSgxRgywfTu78B1WO1T/UZgzEijKp04MArKL21NGwOOlnkitXiriHf62qF35lB9h3eJko/1QMvCghDloXiF/ZlHgYyU4RQ+G1SjVyP1tm0AMM92Jmw+RHZSqiO3MUOeU+rKVPZXvGdfTcvXi5d+6U66AY+96KiPr7mFGcdPdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721194721; c=relaxed/simple;
	bh=35NV8D5AgC2A3IpahQlvijpejzH/WFyKdyFKLkkvxgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBAof+o57EWU8J8jxCHAIkKBScLNKSe7tm3yJ3O0JlIT0CPhO0hjVEP5AO3wzgEVmqxdHGBnIRXp9ft2dzTXk/5F3ckrI6RDoP1gTBJx1PrRonq/UmHEpCnYyLycR+nvLpQVBTcLw7W/cibf8S4mDwH/myyI/YyaozECbfKXRJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=Nd7t96X2; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7fe8d029fbeso23253839f.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 22:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1721194719; x=1721799519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1d1s8x6mwhXq96evpThZCuzx5ViT58+IxOGUpFwTDk=;
        b=Nd7t96X2g944ju1IO1IRt2xyGLJzr39DnhpnedLHyY/SDaiiTib6UoQTwDiwZ4vcoi
         nhzNGRfbPvMuWnMXv6H6SNuSpkvPiU6wook5OSalA291ydU21GBlVhIOPEBSXuuBzNur
         jqqeb+zG0Q5tYToVfXJZloPlVgQXH10zwVYXnll0GO8WoqQStzmmNEsT9a+kcxvLzKHD
         +fhbUT4ulVZn3s3E89eoDtdeQPCJjnRAo6XQSwP4H4wI39WAZuz2ojpxNC+9rYRuvqxL
         +Mz8GSMUdcRuWLwfEaTYZG8nR/TJdoGVKWClzJqaAL5r0nm/YOeX7/3hY6OXkQYUB6fM
         IHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721194719; x=1721799519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1d1s8x6mwhXq96evpThZCuzx5ViT58+IxOGUpFwTDk=;
        b=v3BJmZmANdHWfHXk36dt90WlsAa77QYgCTbHPIxyKUegAe8obmTkKUIpjlJ/4BBowS
         LqP2E3h7oyVfyBkWxCTTzLwthmfANPBfx9x3YA5R8a4VyKPrmnfF7QGHxhP0BAWtlZcj
         HKFoiuOg/MAb4J90BZTBlaKHqm8bcytcRQQH7+xN9pHozb9RJ7GqOh5wCTC78JGa8mEW
         pZcPxkW2B6m5591MTsnNbZwx9FP/StXBCbVKb6CrNTTpmtB5LUDWRwH3rvTZcyCEwthz
         TBxU+3Iu/XHhi24rEen23bUn8fnh2kiTrQdZfXFbNks72k+qSG1waXTKbXYhsPtLi3MV
         zWyg==
X-Forwarded-Encrypted: i=1; AJvYcCWB3FMdstI+7GHmigFbfOGDwO0DlzkksHTlZ46VyT8BOa51H8jjfetIExoj7+vpHyyvmiL3yUoVfuzd7vDnSA0kIVCSyZgJL42SovXv
X-Gm-Message-State: AOJu0YxlRYkKJQbBmeXK0T9nhcPaogFMGud87sEdx5NsSRy1nyOpveD+
	hDZCsX59aTkRWEaWYVspY2v13d1PRJPEA7KbGL/dP/RdNcwlR46OU9RZwC1YM6J4aA2wJV+I9NV
	Nq4YoY/7x2Lm9T+yAFbHZ0/JZWlx4AxgGW9x3dw==
X-Google-Smtp-Source: AGHT+IFar2Tx72l8Cv59EhI8FVwMpDSti1Ksk+Y6IAcwQVvN0Ug2DKjNu+xQ6dXlAHjN7eOD53sNRQW8pQa/oQb1+Ls=
X-Received: by 2002:a05:6e02:1384:b0:377:1611:1b49 with SMTP id
 e9e14a558f8ab-3955760f797mr9351435ab.25.1721194718728; Tue, 16 Jul 2024
 22:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717031714.1946036-1-nick.hu@sifive.com>
In-Reply-To: <20240717031714.1946036-1-nick.hu@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 17 Jul 2024 11:08:26 +0530
Message-ID: <CAAhSdy2W3gCdx_EtqVaTLqk8nVOnc59T2ub3KhdCuS20qHWBSg@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Enable the IPI before workqueue_online_cpu()
To: Nick Hu <nick.hu@sifive.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	tglx@linutronix.de, peterz@infradead.org, samuel.holland@sifive.com, 
	tj@kernel.org, alexghiti@rivosinc.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, greentime.hu@sifive.com, zong.li@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 8:47=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrote:
>
> Sometimes the hotplug cpu stalls at the arch_cpu_idle() for a while after
> workqueue_online_cpu(). When cpu stalls at the idle loop, the reschedule
> IPI is pending. However the enable bit is not enabled yet so the cpu stal=
ls
> at WFI until watchdog timeout. Therefore enable the IPI before the
> workqueue_online_cpu() to fix the issue.
>
> Fixes: 63c5484e7495 ("workqueue: Add multiple affinity scopes and interfa=
ce to select them")
> Signed-off-by: Nick Hu <nick.hu@sifive.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
> Changes in v2: Rename the cpuhp_state of sbi ipi
>
>  arch/riscv/kernel/sbi-ipi.c | 2 +-
>  include/linux/cpuhotplug.h  | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
> index 1026e22955cc..0cc5559c08d8 100644
> --- a/arch/riscv/kernel/sbi-ipi.c
> +++ b/arch/riscv/kernel/sbi-ipi.c
> @@ -71,7 +71,7 @@ void __init sbi_ipi_init(void)
>          * the masking/unmasking of virtual IPIs is done
>          * via generic IPI-Mux
>          */
> -       cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> +       cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_SBI_IPI_STARTING,
>                           "irqchip/sbi-ipi:starting",
>                           sbi_ipi_starting_cpu, NULL);
>
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 7a5785f405b6..0a8fd4a3d04c 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -147,6 +147,7 @@ enum cpuhp_state {
>         CPUHP_AP_IRQ_LOONGARCH_STARTING,
>         CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
>         CPUHP_AP_IRQ_RISCV_IMSIC_STARTING,
> +       CPUHP_AP_IRQ_RISCV_SBI_IPI_STARTING,
>         CPUHP_AP_ARM_MVEBU_COHERENCY,
>         CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
>         CPUHP_AP_PERF_X86_STARTING,
> --
> 2.34.1
>

