Return-Path: <linux-kernel+bounces-329409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8929790FE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 15:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2CA1C214FA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D2B1CDA15;
	Sat, 14 Sep 2024 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wra250YA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A6B749A
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726320856; cv=none; b=Tq5fmUaaqGoRRBttvhqW+XT0F0HRTA9okkFF19kbcm41eR3mNVfjGWNCCGDmI4K61XJD6Y7oOYwmccivRdmVwpiRcjvgV8jj2bpma301168t6CxCfxzEVhh2dcNuVTjStPqAfYDPA3rXSJxGfs3WhIfDfnsxL45p78gpL0snaY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726320856; c=relaxed/simple;
	bh=Bo9HHMH/7VGecfGqlAkHXUQ0PAaQ8egvSPQACg+ewKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqdNV8yKzb/ajH6wpntSszk5h5akakQ1C2z4JdwM+6VI6IZfkgWnYDfrxVwPrTaRjc/NSoMoqU3E5CkNDHQlbGaJOZHRmA8n/qdfDfwS/vn2KUfi2PcLs2cZlnM4NCCCjkROJr5QJcHMbvtNUH2xCqQoTCY0Jq0QXpwBG0QuWHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wra250YA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726320853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INwlJ0XvfL4HQTe5EqAskgvpw/m/mm4hcWt9RMaUHIY=;
	b=Wra250YAieYEKcF1HP5+BlUTQXyl723ntPkE70XbHZBZ2bl/VE1NR1fzuZeW/zhFT5oC9p
	kqCJ8qkUYViWTShlLMKdsjvvp16Eyy3t4Ch/PmsPDb5GuQQMNwvYkrdThlZKe7T5bXElS2
	O7fMe+4VUxKGNR8L/296510ee5xd3Sg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-wHnnFR2tMFG87bz4JfmLwg-1; Sat, 14 Sep 2024 09:34:12 -0400
X-MC-Unique: wHnnFR2tMFG87bz4JfmLwg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3780c8d689bso1441863f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 06:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726320851; x=1726925651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INwlJ0XvfL4HQTe5EqAskgvpw/m/mm4hcWt9RMaUHIY=;
        b=ov5YyqZJ2BVfIdNj65g+rPKH7swwuWbbFxuDUTvXJVwW45Za8Xo//azmdG3IqPCDaZ
         h+QjOCgbxaPkOlGTM+Ej4lLnMqu9y/QA9IYBOx3TpXiz5bctbAM3com9+J76V8zHw3Oq
         IdRP/sAwnDN2RhYd+X55n/CJsYqyqh1v5Jx31N3SwgbpFcj4cvWXsG+k1OBpfZmvwkN9
         LT0oDeJdzziZu/M2ZZF3C8hyQq6+j+RFuXzfav1RSUapffDxrJ1FcKkY/FXdrz50l+a6
         yLrSU+7oAdU4tKwvZ4gVElFjJ+EBJVbGgADgWI9dXOXIiUKCaFoehYfTez9hF280N7gw
         dokQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzmMp7zca1K5A4rgGliYcuCPJiVsHS/IGsabQxcv92isMay8Q99DfiSo5wZ82EFCMK6iHM2nrsz5mvi3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx53vDjw5fFvQFgbGruMgRqxbPzov4LvkuPH5Q5ZfsiWGdTHCl
	1tqBfFJC9aa8mX+ketIXSUEoSl33y2HtC9qlA6v01UihOhj4QGm+iXeRnnH8QY+ukEwbtCAdwz7
	q3X9fFxZo+qePEtwrWBQ7tAIHUwSm8Zbz1vOnWGOzbkpcXR4vskqZX7xol/WV6TIaAV/Z/HYoB0
	iDwGcZANMoN763R1PZbYT6Ukn7vaOZB8Rm554S
X-Received: by 2002:a5d:50c5:0:b0:374:b35e:ea6c with SMTP id ffacd0b85a97d-378c2d515cemr5395082f8f.40.1726320850953;
        Sat, 14 Sep 2024 06:34:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb6HtPkwGnd8GM7d/KRiyJlB1NATkocV9vkbyr817E3RiHieIGR5imtJW33zVee0ZnqWkWEGQp1XYS+1SQiKY=
X-Received: by 2002:a5d:50c5:0:b0:374:b35e:ea6c with SMTP id
 ffacd0b85a97d-378c2d515cemr5395071f8f.40.1726320850544; Sat, 14 Sep 2024
 06:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913085812.1030686-1-chenhuacai@loongson.cn>
In-Reply-To: <20240913085812.1030686-1-chenhuacai@loongson.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 14 Sep 2024 15:33:59 +0200
Message-ID: <CABgObfaNgSX=3RJjksLq+g9qq6r6HO=YgAXRE4UQdPPL0XKifw@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch KVM changes for v6.12
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 11:07=E2=80=AFAM Huacai Chen <chenhuacai@loongson.c=
n> wrote:
>
> The following changes since commit da3ea35007d0af457a0afc87e84fddaebc4e0b=
63:
>
>   Linux 6.11-rc7 (2024-09-08 14:50:28 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson=
.git tags/loongarch-kvm-6.12
>
> for you to fetch changes up to 3abb708ec0be25da16a1ee9f1ab5cbc93f3256f3:
>
>   LoongArch: KVM: Implement function kvm_para_has_feature() (2024-09-12 2=
2:56:14 +0800)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> LoongArch KVM changes for v6.12
>
> 1. Revert qspinlock to test-and-set simple lock on VM.
> 2. Add Loongson Binary Translation extension support.
> 3. Add PMU support for guest.
> 4. Enable paravirt feature control from VMM.
> 5. Implement function kvm_para_has_feature().
>
> ----------------------------------------------------------------
> Bibo Mao (6):
>       LoongArch: Revert qspinlock to test-and-set simple lock on VM
>       LoongArch: KVM: Add VM feature detection function
>       LoongArch: KVM: Add Binary Translation extension support
>       LoongArch: KVM: Add vm migration support for LBT registers
>       LoongArch: KVM: Enable paravirt feature control from VMM
>       LoongArch: KVM: Implement function kvm_para_has_feature()
>
> Song Gao (1):
>       LoongArch: KVM: Add PMU support for guest
>
>  arch/loongarch/include/asm/Kbuild          |   1 -
>  arch/loongarch/include/asm/kvm_csr.h       |   6 +
>  arch/loongarch/include/asm/kvm_host.h      |  37 +++-
>  arch/loongarch/include/asm/kvm_para.h      |  12 +
>  arch/loongarch/include/asm/kvm_vcpu.h      |  11 +
>  arch/loongarch/include/asm/loongarch.h     |  11 +-
>  arch/loongarch/include/asm/paravirt.h      |   7 +
>  arch/loongarch/include/asm/qspinlock.h     |  41 ++++
>  arch/loongarch/include/uapi/asm/Kbuild     |   2 -
>  arch/loongarch/include/uapi/asm/kvm.h      |  20 ++
>  arch/loongarch/include/uapi/asm/kvm_para.h |  21 ++
>  arch/loongarch/kernel/paravirt.c           |  47 ++--
>  arch/loongarch/kernel/setup.c              |   2 +
>  arch/loongarch/kernel/smp.c                |   4 +-
>  arch/loongarch/kvm/exit.c                  |  46 ++--
>  arch/loongarch/kvm/vcpu.c                  | 340 +++++++++++++++++++++++=
+++++-
>  arch/loongarch/kvm/vm.c                    |  69 +++++-
>  17 files changed, 616 insertions(+), 61 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/qspinlock.h
>  create mode 100644 arch/loongarch/include/uapi/asm/kvm_para.h
>


