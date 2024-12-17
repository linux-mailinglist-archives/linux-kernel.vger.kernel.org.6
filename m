Return-Path: <linux-kernel+bounces-448854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24CE9F4675
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8EE87A66E9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52FA1DD872;
	Tue, 17 Dec 2024 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eUIN6wPI"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E26126C08
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425337; cv=none; b=ZiN/00VVTqpooEpCzPLewy6NeaIHnZYDr3zkTRucznyc7mCwEdIo07uYNY8Y1So4zsEwjnwtHWJ1qEVCJFU2B/N4hhqgoFDWY7XfUj8DuiqAcZ27toosW5FPB17FYvgiXM8jPTnlHAovBjd3SSzKLZs/y/H7GSMrI0FyVnuYVio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425337; c=relaxed/simple;
	bh=TuEAdqDFvdHW9gP3adsRjRi3jQJtzsHZgPQ8FqpyKMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLZohyHXs4CveI8Xd2vj7jq4P3B1z/ny+CuR95NqCrIs4fLfbX1KG51dhJ1UtHcnNy7EtDlLy5NuR9mVH0TSIs4ByW04MCV7AC5bRY/QNvPf+FAFPXRQ2rTgEzgvXHdAoqglzeKUC7jzUut+hV2OFeCmSrW7zPRj97uHSGZlv38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eUIN6wPI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43621d2dd4cso38655e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734425334; x=1735030134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A7YTWU7uGdtLnWP4r+MAELOvdX8ajEJVx12lX99dfLw=;
        b=eUIN6wPI1+xeDczvRZH7/AzyGJPYlyyqDN654+igQySvyFwPP49e2CfpA9VE5SjdBl
         kThBXoxFiXiGeT+ZSfTdfxEx9uNZ0c9Y0qX7bVMkQNRa7RGdtklRkKHQNYPndSsb+5vx
         Hcjnx0krRbvLUB7mI4sjbQdnPOz6mucKzgX4Oos7pN2cAa06q46xx43q4WolxpONatBb
         nWr0f7iK+5fFPwtvrIs/au3Cr6KuAnXKMOcuygyOKyXyrSl5cNYbXfsVBTpXuSL1P/iS
         8s570zSfLdI8BDDF/51smHryWJu5J++3FxteHsRA97297qQrlpeUIqm89dpwsFE1xViN
         pqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734425334; x=1735030134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7YTWU7uGdtLnWP4r+MAELOvdX8ajEJVx12lX99dfLw=;
        b=b/kSXRMeJtrKlaR8cB+BUF8sfDJqfqkC4IX0KxtmCedA90Vj3/HYDGBeuvl33V+Ldy
         /RwzzfO/9MM8OTQEgV1Xc77vdb6Sz4hz9ZcSmD070c1BovpxK2D4c2AxdBq3e1Ce4iPP
         jEzGB/TeB8JiVluAKAUUqS9VQUJPRKRjWxufui2myWrnhOHEr0rSjWFTVh6mNpgNdtli
         Pj9XUI8N2RX4PPuEINybOi61roXBPYnL4ia/T/rtMHKOWMYq7mJuXhm6UIXa3igOkZf4
         ODqZdiwWqBI1UNtYSB8xzZemtQyzePT+mpoJkk7p5ViTP0gGEwObalHiHg54GuqukFDE
         bp2g==
X-Forwarded-Encrypted: i=1; AJvYcCUV0b3VXQqD5+C24YcYcYJFtSKUlALK6Oyp8MQ3nyYA/poqk0V4sMpqcR6JVD+koTlBW5NupRLZoK0R8tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOX408E8nWtcSaPFAW38hKu0XUftmD5hhOjBaqTXvyNteRXop9
	m/nfVs5v29fpQYPmAtf/sGqOQlCd2g5O5a1KheKZYjmQGUS3R4GFxumLX4B1bF0+Kj2wasx/jON
	e5WMUZ/9xMd2vu1Oh2+AorV/9Iro2wB7/Ll/F5Unmxbr2N5X4tkMv
X-Gm-Gg: ASbGncu5Zq8uGpd3xu23/PBDE2UjMVlgqMYYYPl8C7JiQZHr2dP7Xdh3JTk8uFxonCO
	sUQfmgx8G7dVQ0di48e9wCazcrJPLMxndxXU2OlOL2Za69vGTHc1ITEdf3OIFhnfJCTg=
X-Google-Smtp-Source: AGHT+IFQVMhJyuBvpWnirFZOzp1TjeSx17Y5DE8/Tuu+aAN9FtjNwt0anC94607YgOtJmmmQzWkBb3MnulFBgA2MdLk=
X-Received: by 2002:a05:600c:5741:b0:436:1811:a79c with SMTP id
 5b1f17b1804b1-4364ad4db33mr735615e9.5.1734425333713; Tue, 17 Dec 2024
 00:48:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com> <20241216175803.2716565-9-qperret@google.com>
In-Reply-To: <20241216175803.2716565-9-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 17 Dec 2024 08:48:17 +0000
Message-ID: <CA+EHjTxd5euMqYrq510kgqvON1JdGmjhE4ROFuMwTR1pgwLD9w@mail.gmail.com>
Subject: Re: [PATCH v3 08/18] KVM: arm64: Add {get,put}_pkvm_hyp_vm() helpers
To: Quentin Perret <qperret@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Dec 2024 at 17:58, Quentin Perret <qperret@google.com> wrote:
>
> In preparation for accessing pkvm_hyp_vm structures at EL2 in a context
> where we can't always expect a vCPU to be loaded (e.g. MMU notifiers),
> introduce get/put helpers to get temporary references to hyp VMs from
> any context.
>
> Signed-off-by: Quentin Perret <qperret@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/kvm/hyp/include/nvhe/pkvm.h |  3 +++
>  arch/arm64/kvm/hyp/nvhe/pkvm.c         | 20 ++++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
> index 24a9a8330d19..f361d8b91930 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
> @@ -70,4 +70,7 @@ struct pkvm_hyp_vcpu *pkvm_load_hyp_vcpu(pkvm_handle_t handle,
>                                          unsigned int vcpu_idx);
>  void pkvm_put_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu);
>
> +struct pkvm_hyp_vm *get_pkvm_hyp_vm(pkvm_handle_t handle);
> +void put_pkvm_hyp_vm(struct pkvm_hyp_vm *hyp_vm);
> +
>  #endif /* __ARM64_KVM_NVHE_PKVM_H__ */
> diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> index 071993c16de8..d46a02e24e4a 100644
> --- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
> +++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> @@ -327,6 +327,26 @@ void pkvm_put_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
>         hyp_spin_unlock(&vm_table_lock);
>  }
>
> +struct pkvm_hyp_vm *get_pkvm_hyp_vm(pkvm_handle_t handle)
> +{
> +       struct pkvm_hyp_vm *hyp_vm;
> +
> +       hyp_spin_lock(&vm_table_lock);
> +       hyp_vm = get_vm_by_handle(handle);
> +       if (hyp_vm)
> +               hyp_page_ref_inc(hyp_virt_to_page(hyp_vm));
> +       hyp_spin_unlock(&vm_table_lock);
> +
> +       return hyp_vm;
> +}
> +
> +void put_pkvm_hyp_vm(struct pkvm_hyp_vm *hyp_vm)
> +{
> +       hyp_spin_lock(&vm_table_lock);
> +       hyp_page_ref_dec(hyp_virt_to_page(hyp_vm));
> +       hyp_spin_unlock(&vm_table_lock);
> +}
> +
>  static void pkvm_init_features_from_host(struct pkvm_hyp_vm *hyp_vm, const struct kvm *host_kvm)
>  {
>         struct kvm *kvm = &hyp_vm->kvm;
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

