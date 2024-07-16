Return-Path: <linux-kernel+bounces-253654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5E893245E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA881C2232D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A64198E6E;
	Tue, 16 Jul 2024 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="DQd1tazg"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADAB13D630
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721127076; cv=none; b=VPgiu13ghSP3A+fzwnTvc2/QzN++ATx35c1lLXsyc8lvqRWS0JlrXpxIKfPFLEYC5XdIYWjdz5xwJpjev77cLgEzcyHrG0WvtB7B6v9/k4JuyH5G3SKQ3W/duPySK5d/oYF+hqkpDdinQFy1MxXpq9WnbiMdxOvhaR2SSw5IWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721127076; c=relaxed/simple;
	bh=Y4eYjHJ1coNIJsiv5IOAsbQ5dekTLijWkfuE3vo9PXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhn/UmoSy6SOHPvo1txdV6RBJ2tgR0NSsE4FmFSsQ7Y4MC18VMcAfWZpLZM7xkdcM8ZcxzMhJXsfEDct2d7fHTraHvfJZOIn2TKsHxaMqINk4JUAyPakt4nOd0ma6tn/yfqbDAwd8E/IV8+XaI5hFdqZDM4dehMK9mHu41wKikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=DQd1tazg; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-8063553b837so261319139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1721127074; x=1721731874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SOtGr51pErFpahsrrtYqkp40ybrWdij71XCYB1jqEQ=;
        b=DQd1tazg2XoJ71WO+o+lEP6sse7ZrhNAiFmy2cdGaPq9cYFN0KALA3F4uZJgCRu5DJ
         rYI4tkAs0MOBPE1fLoqhNKmPRwk1KvG5rTFVNvAznlFSvoAodsyXMHOkyjnh+li1agUS
         mXzH4KalwPLmOuKZitnx/LKgiF39TC59/2g5JKE9KaEj7Jga1Pcx3JW80aH/DaCLipuf
         6i38lkEfTXteFsYweggCGY0evwnYOTmUyyA6sBOzh7cih2UPK2vJz5NKfnw+W0mTdtXl
         bwaBc6FtY1Mei8siZxAVVzmxIhyvDWmFJH9Ifb3ffDtqLOQv7A41Y4l8061+IkRiZkkj
         RoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721127074; x=1721731874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SOtGr51pErFpahsrrtYqkp40ybrWdij71XCYB1jqEQ=;
        b=SDkBuf76UNASise4P9hDRHtJatPs5wmLlqQUHfOwd1f/UpuahC607h3Gh0kQmidi4n
         kBtSeP4xfa8EzjjcB5FckCZTw/ctUTT/J8gV5NTSjMBomWj4JxIkw+Huh5MhptKX40DG
         r0aGUJAMqPs4qMFHJfgxFGM1HJ1a+WgHXcG2NWI9Gc1JKthGT99DX1n5xFSCyupPDi+v
         O35XvfNVmxYf0k5UvMn5IHBsF35BZBNA0Cnnmx/rE5jeH/1iqJJkXTjKZVP6B4cJwN4e
         PtStjGSdZobv6rBfK2voOuiUeyS/YRd+mJ0wfcrlzbXEir1IScMQzdNGfDJ/3WKT1o3S
         zvDA==
X-Forwarded-Encrypted: i=1; AJvYcCUsEDd5N7qaJQKcTBVuZyP6ERHu+VVRVAoxkqrasiwQ+ms9Bz5WhPo55GldSn9FwjNRS1Tf5nQGj+8YE+5K42E45CZ0vZrQ9mv6O+Mc
X-Gm-Message-State: AOJu0YxJBAH3eJSB0PV77CfCcgjXuKD5T6C3x8NahpS9jB7xE+QoDGyY
	q/+NXx6zDUex+3JigjLCSx2mXbRuWod5ARA8ux6mTy9zl0IKqPmUqdC+NQ0R44pn97UcHMIvUal
	DB83xfBez9gxr0wmPjmeYL59DSITn1g9nQOIUpA==
X-Google-Smtp-Source: AGHT+IFgLgr7BH1UuGGVhx6H0o4guImRTlhd3fKWbpAvzMa5o4ntPygEZJHxgQXzcZZOiJZ5wZoNNfFdR2dzx/sgAYs=
X-Received: by 2002:a92:c56a:0:b0:375:aaaf:e88f with SMTP id
 e9e14a558f8ab-393d2c94bebmr24128255ab.27.1721127074278; Tue, 16 Jul 2024
 03:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716090521.1752166-1-nick.hu@sifive.com>
In-Reply-To: <20240716090521.1752166-1-nick.hu@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 16 Jul 2024 16:21:02 +0530
Message-ID: <CAAhSdy1pjg=etzNNu-E+-VDmU5gLkS2jYhdO29pPN23OQ5=NiA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Enable the IPI before workqueue_online_cpu()
To: Nick Hu <nick.hu@sifive.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	tglx@linutronix.de, peterz@infradead.org, samuel.holland@sifive.com, 
	tj@kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	greentime.hu@sifive.com, zong.li@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 2:35=E2=80=AFPM Nick Hu <nick.hu@sifive.com> wrote:
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
> ---
>  arch/riscv/kernel/sbi-ipi.c | 2 +-
>  include/linux/cpuhotplug.h  | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
> index 1026e22955cc..e05e68de8871 100644
> --- a/arch/riscv/kernel/sbi-ipi.c
> +++ b/arch/riscv/kernel/sbi-ipi.c
> @@ -71,7 +71,7 @@ void __init sbi_ipi_init(void)
>          * the masking/unmasking of virtual IPIs is done
>          * via generic IPI-Mux
>          */
> -       cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> +       cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_SWINT_STARTING,
>                           "irqchip/sbi-ipi:starting",
>                           sbi_ipi_starting_cpu, NULL);
>
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 7a5785f405b6..57dcf1229b27 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -147,6 +147,7 @@ enum cpuhp_state {
>         CPUHP_AP_IRQ_LOONGARCH_STARTING,
>         CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
>         CPUHP_AP_IRQ_RISCV_IMSIC_STARTING,
> +       CPUHP_AP_IRQ_RISCV_SWINT_STARTING,

This is a misleading name.

I suggest s/_RISCV_SWINT_/_RISCV_SBI_IPI_/ .

>         CPUHP_AP_ARM_MVEBU_COHERENCY,
>         CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
>         CPUHP_AP_PERF_X86_STARTING,
> --
> 2.34.1
>

Regards,
Anup

