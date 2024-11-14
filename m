Return-Path: <linux-kernel+bounces-410097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBDD9C9679
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D6E28166F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D811AAE33;
	Thu, 14 Nov 2024 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwElYXWi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DD41B2199
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731628400; cv=none; b=mR8evFmRVtLRpL59HUSKydYV2UZJHpg0YJ32GKFigVsyVTdIjV54Ob659HISY4biRtPgKrDkPrw/COByyUuJw6UmD9H55vglw2/rk2egioUhFIDKpCDsMDRkMCu8VCJNAlNpQ528Z5t0f7EqudGkU61mqN8A/HEw4jOFoptpmKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731628400; c=relaxed/simple;
	bh=/ICuXM+GV6dBITrJIBgI7/tWym7FEU0Fxzozxfuppnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfGOokrDubYjaNdMyirv3HLiionrKysXnj0xuZ9ur+xrv0Qw2n8XIXoa44xfHUZ+ep7jgWwbw5zFdCjEYIm88/ZT6mk8+yAqzWBkCw7eDk/bVsoc82djcjV31l9mKHndf4vkGWxbSSTFoJdvHvLOeOCdK6oY6iZs43umzA7ur4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DwElYXWi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731628397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rECe5FJajV/VYN0/GaapttFhgwn5vtFillXTURUY7NE=;
	b=DwElYXWiPycHRnu0wCuV/iYV+cc81FNzEtg2ptCxeX5tIjorK4KFULT8qLIZr7hudtVwV8
	Yb8LW8AZAcgd4HD8WPsXRs4g47xIDNtXEgxfkhRWKzBQxm4Iij4cT8sey00erb+slCk/x5
	W4dPi0dW1gnbfprQzld8wOE2JQ9XF9M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-zwemFynkP7mHgyBpggQkGw-1; Thu, 14 Nov 2024 18:53:15 -0500
X-MC-Unique: zwemFynkP7mHgyBpggQkGw-1
X-Mimecast-MFC-AGG-ID: zwemFynkP7mHgyBpggQkGw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3822208f7f6so357884f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:53:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731628394; x=1732233194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rECe5FJajV/VYN0/GaapttFhgwn5vtFillXTURUY7NE=;
        b=a9mBGBvw6CDWFTZPGDWIfJ9MMWldXEpk0kfzvrUEYuVpL3Rt8WPo1a/BqiT/np1HKH
         VXPO6dPUGWThRThpWw3i5weRi8nJNZbPSf39FW64M3A5Yvprq3PMTSKX8ffkOAQVCQWX
         O8bZBIz7lqUC2LJRQh9Mrp3i2b6lGQJNQc0tHYE5RbANshv0JA6uWHVk1NJYUozQrKyu
         +Wunlj2R2fvPvDQkogAy1lWl9qkPX8tw7qwOBqk8VzjoxuZwTU5zQ24d+Z45645pvi/f
         hvfDsUgXn/cPV+8rYfmBzVNUi4X59rUqcWNFO0he+MRwAP9xEKabiArKsc5f1czlOBgj
         HRTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmwjCZWaF4/YjIQr0SfsctYmle8ETGQUDeBH/oVA7bdDkUwiUFbeFMXTqq2j3OybDz5ibsrWibHSJXdgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4R+dJfFnxkt3esUvbRFOraAyhv6/SvTptdU2fdHoa+4SkLpV/
	AsLOU9LnSiM6Sy9+xHaUqmVxpm0FZ942S3KJILivfVnQPaMpvCz8C+OIdvgGsnkcmuBmx/DNTIw
	yOqagZZCwfIi5WWvMFPtQPmhO5ur46ERMG4h+YxWDPkpEGkq/69tq6iPQAJioQtglZTVM+qATI6
	G8N7QSyWc5v/t6/oimzCphlip929Re00wR0RVR
X-Received: by 2002:a05:6000:156b:b0:374:c17a:55b5 with SMTP id ffacd0b85a97d-38225907519mr413189f8f.14.1731628393809;
        Thu, 14 Nov 2024 15:53:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKwOuvExVXPmSQhtLCT0FzFyo78jxZHYmPrEQdpvPU+torab91q63PrU3gZsTPFt//8kyo2JOBpOrw6eK7KKk=
X-Received: by 2002:a05:6000:156b:b0:374:c17a:55b5 with SMTP id
 ffacd0b85a97d-38225907519mr413177f8f.14.1731628393484; Thu, 14 Nov 2024
 15:53:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114094128.2198306-1-chenhuacai@loongson.cn>
In-Reply-To: <20241114094128.2198306-1-chenhuacai@loongson.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 15 Nov 2024 00:53:00 +0100
Message-ID: <CABgObfbLYfAo=PGNPxEJXrttM575JeSV265madXmN2uuZEFqfQ@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch KVM changes for v6.13
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 10:50=E2=80=AFAM Huacai Chen <chenhuacai@loongson.c=
n> wrote:
>
> The following changes since commit 2d5404caa8c7bb5c4e0435f94b28834ae54566=
23:
>
>   Linux 6.12-rc7 (2024-11-10 14:19:35 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson=
.git tags/loongarch-kvm-6.13
>
> for you to fetch changes up to 9899b8201025d00b23aee143594a30c55cc4cc35:
>
>   irqchip/loongson-eiointc: Add virt extension support (2024-11-13 16:18:=
27 +0800)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> LoongArch KVM changes for v6.13
>
> 1. Add iocsr and mmio bus simulation in kernel.
> 2. Add in-kernel interrupt controller emulation.
> 3. Add virt extension support for eiointc irqchip.
>
> ----------------------------------------------------------------
> Bibo Mao (1):
>       irqchip/loongson-eiointc: Add virt extension support
>
> Xianglai Li (11):
>       LoongArch: KVM: Add iocsr and mmio bus simulation in kernel
>       LoongArch: KVM: Add IPI device support
>       LoongArch: KVM: Add IPI read and write function
>       LoongArch: KVM: Add IPI user mode read and write function
>       LoongArch: KVM: Add EIOINTC device support
>       LoongArch: KVM: Add EIOINTC read and write functions
>       LoongArch: KVM: Add EIOINTC user mode read and write functions
>       LoongArch: KVM: Add PCHPIC device support
>       LoongArch: KVM: Add PCHPIC read and write functions
>       LoongArch: KVM: Add PCHPIC user mode read and write functions
>       LoongArch: KVM: Add irqfd support
>
>  Documentation/arch/loongarch/irq-chip-model.rst    |   64 ++
>  .../zh_CN/arch/loongarch/irq-chip-model.rst        |   55 ++
>  arch/loongarch/include/asm/irq.h                   |    1 +
>  arch/loongarch/include/asm/kvm_eiointc.h           |  123 +++
>  arch/loongarch/include/asm/kvm_host.h              |   18 +-
>  arch/loongarch/include/asm/kvm_ipi.h               |   45 +
>  arch/loongarch/include/asm/kvm_pch_pic.h           |   62 ++
>  arch/loongarch/include/uapi/asm/kvm.h              |   20 +
>  arch/loongarch/kvm/Kconfig                         |    5 +-
>  arch/loongarch/kvm/Makefile                        |    4 +
>  arch/loongarch/kvm/exit.c                          |   82 +-
>  arch/loongarch/kvm/intc/eiointc.c                  | 1027 ++++++++++++++=
++++++
>  arch/loongarch/kvm/intc/ipi.c                      |  475 +++++++++
>  arch/loongarch/kvm/intc/pch_pic.c                  |  519 ++++++++++
>  arch/loongarch/kvm/irqfd.c                         |   89 ++
>  arch/loongarch/kvm/main.c                          |   19 +-
>  arch/loongarch/kvm/vcpu.c                          |    3 +
>  arch/loongarch/kvm/vm.c                            |   21 +
>  drivers/irqchip/irq-loongson-eiointc.c             |  108 +-
>  include/linux/kvm_host.h                           |    1 +
>  include/trace/events/kvm.h                         |   35 +
>  include/uapi/linux/kvm.h                           |    8 +
>  22 files changed, 2735 insertions(+), 49 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/kvm_eiointc.h
>  create mode 100644 arch/loongarch/include/asm/kvm_ipi.h
>  create mode 100644 arch/loongarch/include/asm/kvm_pch_pic.h
>  create mode 100644 arch/loongarch/kvm/intc/eiointc.c
>  create mode 100644 arch/loongarch/kvm/intc/ipi.c
>  create mode 100644 arch/loongarch/kvm/intc/pch_pic.c
>  create mode 100644 arch/loongarch/kvm/irqfd.c
>


