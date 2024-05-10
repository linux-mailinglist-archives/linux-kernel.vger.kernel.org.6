Return-Path: <linux-kernel+bounces-175915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6148C2717
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94424283ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025A517108A;
	Fri, 10 May 2024 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/R9ZiRD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6478168AFC
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715352318; cv=none; b=f5HYKG1p9ZsaJwkUgAWKx0n3y5/j2HBSTRlosI302SSacefp2HT5s9tspMBQoPPmOhBoZAzvVdEdddcgdlClaYGCp4ZM0T0dPFN+LSloKPZ+KdjcPzwzafDccB2mF3sBCR6Jw2mwSSXeX51N65mebdeZgVhL5bd5pMcdILltrdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715352318; c=relaxed/simple;
	bh=kmj44PEzEs1Hc7RYAG2y6Omx6rTiyxtrlA8AzcCTcUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFltvad8SstX9EWte9d+852otTYPNVUm9aGfc8DsMJOtV4LjMj3MfJtppwgwAUlungJvJQsePjapuPQB4xcSaLZMhvufVb1/pb+F4tPrs7MXdPWvIViOQyJIGqQJJLILGuW5CMOfIgGzyRHpt00pPeve2ckAI6xJJewtEdh0gtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/R9ZiRD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715352315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0JbujFYt/9SItNTEbEiczRuSL3qAb2lZe4U6XNdsCE=;
	b=T/R9ZiRD8cowlEvt6k45zjjee8Kz32Ig6uE04Hl+0adaxC7SEYVRZ9pHV6omzhdCLueWKJ
	5Tr5u9HyopoRvIY/YBvdMI54UffAINO2tR/Fc+LDtxVUeMwEVeCeOlaxa0G4xa1LHr/WpC
	VkRlaK5h061dzpV+hatkQdfPbrK6eH8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-BGv3MJGHMumIaHyZGJNQOQ-1; Fri, 10 May 2024 10:44:59 -0400
X-MC-Unique: BGv3MJGHMumIaHyZGJNQOQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34d7a7585d7so1208101f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715352297; x=1715957097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0JbujFYt/9SItNTEbEiczRuSL3qAb2lZe4U6XNdsCE=;
        b=YGEyy7c/OF8V99/8n7UDQshtuL8qS/UuKQXW3Fv/igG/OS2GySYrT3oO486bHOpfjx
         keP+Q/1xeGSqKdRBSf6z3ZW8oJdaPRdQWrYxGR6sYYUTyYaqbzXGoiiolHTZSnIc/D9J
         8ZUsWZDdR78jeKnQEmPHnsqT7tfQ94UdQTjo9iQc4g5XVTJo4T+NhfDOFoFgZyHw5dxP
         myXqHiB38CgM1gQ3cWo1zDYh1mxSvfBdH/c7OOomrCGPQ+ebaa95ESuW9f2n0HT4d0Ut
         dJyW2/ucrz6dewDkvt7ZZfd35AW6MqfDX4h6jjEC/T+soZZwqr2EgLcU4d9KmLNCS5Mi
         faSg==
X-Forwarded-Encrypted: i=1; AJvYcCVZwCMDF9SIjwqOx/4Qi3ZOM5ATAEWxvBzQffL+5hDSiAP0U4eFcTIo3Qi0Bldj+0CokVXY5SQC7aaQGmgIytpcfbl90tODw5A8fJm3
X-Gm-Message-State: AOJu0YzyqTeLBRCGyx9Oo+BYn78Uqnw5uplwqI9kwLnAPwm1KJZ4sPwc
	R8UYPr4GAfNLvlQxJntwxxO2CJPjdqHgXH/G67c3aLipsAH/isrbqH32jTZ1bpaJsQm6SlxCkrJ
	O2yuDXMIBheIwT5GSMkayuUBk11VThIejdAMpYPDj6MKuNnqsGpd4GI2gucg3XPXQ6d06PoZh/v
	4CrgCXJZOx0lnTDHbxD1Veuhufv/p84yUB6gt/
X-Received: by 2002:a05:6000:1003:b0:33e:7f5c:a75d with SMTP id ffacd0b85a97d-3504a96cca2mr1881556f8f.57.1715352297327;
        Fri, 10 May 2024 07:44:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqPh3msW6mLhD5AYzc7IzmHoZiilZKRmz2o9qQNP3DbnrKVIBIgk/dOAj3od9jdxMGgdFJY8LFNOkvNb4LRmc=
X-Received: by 2002:a05:6000:1003:b0:33e:7f5c:a75d with SMTP id
 ffacd0b85a97d-3504a96cca2mr1881542f8f.57.1715352296757; Fri, 10 May 2024
 07:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508150240.225429-1-chenhuacai@loongson.cn>
In-Reply-To: <20240508150240.225429-1-chenhuacai@loongson.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 10 May 2024 16:44:44 +0200
Message-ID: <CABgObfaivYUYZwmC9p2uwCWTC-hzJc4P_=rK0S244Hjx3X8kvg@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch KVM changes for v6.10
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 5:11=E2=80=AFPM Huacai Chen <chenhuacai@loongson.cn>=
 wrote:
>
> The following changes since commit dd5a440a31fae6e459c0d6271dddd628255053=
61:
>
>   Linux 6.9-rc7 (2024-05-05 14:06:01 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson=
git tags/loongarch-kvm-6.10
>
> for you to fetch changes up to 7b7e584f90bf670d5c6f2b1fff884bf3b972cad4:
>
>   LoongArch: KVM: Add mmio trace events support (2024-05-06 22:00:47 +080=
0)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> LoongArch KVM changes for v6.10
>
> 1. Add ParaVirt IPI support.
> 2. Add software breakpoint support.
> 3. Add mmio trace events support.
>
> ----------------------------------------------------------------
> Bibo Mao (8):
>       LoongArch/smp: Refine some ipi functions on LoongArch platform
>       LoongArch: KVM: Add hypercall instruction emulation
>       LoongArch: KVM: Add cpucfg area for kvm hypervisor
>       LoongArch: KVM: Add vcpu mapping from physical cpuid
>       LoongArch: KVM: Add PV IPI support on host side
>       LoongArch: KVM: Add PV IPI support on guest side
>       LoongArch: KVM: Add software breakpoint support
>       LoongArch: KVM: Add mmio trace events support
>
>  arch/loongarch/Kconfig                          |   9 ++
>  arch/loongarch/include/asm/Kbuild               |   1 -
>  arch/loongarch/include/asm/hardirq.h            |   6 +
>  arch/loongarch/include/asm/inst.h               |   2 +
>  arch/loongarch/include/asm/irq.h                |  11 +-
>  arch/loongarch/include/asm/kvm_host.h           |  33 +++++
>  arch/loongarch/include/asm/kvm_para.h           | 161 ++++++++++++++++++=
++++++
>  arch/loongarch/include/asm/kvm_vcpu.h           |  11 ++
>  arch/loongarch/include/asm/loongarch.h          |  12 ++
>  arch/loongarch/include/asm/paravirt.h           |  30 +++++
>  arch/loongarch/include/asm/paravirt_api_clock.h |   1 +
>  arch/loongarch/include/asm/smp.h                |  22 ++--
>  arch/loongarch/include/uapi/asm/kvm.h           |   4 +
>  arch/loongarch/kernel/Makefile                  |   1 +
>  arch/loongarch/kernel/irq.c                     |  24 +---
>  arch/loongarch/kernel/paravirt.c                | 151 ++++++++++++++++++=
++++
>  arch/loongarch/kernel/perf_event.c              |  14 +--
>  arch/loongarch/kernel/smp.c                     |  52 +++++---
>  arch/loongarch/kernel/time.c                    |  12 +-
>  arch/loongarch/kvm/exit.c                       | 151 ++++++++++++++++++=
+---
>  arch/loongarch/kvm/trace.h                      |  20 ++-
>  arch/loongarch/kvm/vcpu.c                       | 105 +++++++++++++++-
>  arch/loongarch/kvm/vm.c                         |  11 ++
>  23 files changed, 746 insertions(+), 98 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/kvm_para.h
>  create mode 100644 arch/loongarch/include/asm/paravirt.h
>  create mode 100644 arch/loongarch/include/asm/paravirt_api_clock.h
>  create mode 100644 arch/loongarch/kernel/paravirt.c
>


