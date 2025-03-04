Return-Path: <linux-kernel+bounces-543010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836FAA4D078
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5493AD527
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB5978F59;
	Tue,  4 Mar 2025 01:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpRV8Ng8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50999BE5E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050217; cv=none; b=VetDDBFBaMOk8f5/UKLoto9AkEd+QpGwXIFTVv2xy/AtbwK92lPp1UOshZ6J12EwqQUhlzy/XSk2QaRDEDoE5cJCAp4XfP2cFyFmDtxF5ufKmUvhFjgARVCFdXO63H1vOUWCEjlw5l6NSOaCpcg3HuISzFztjzazn/tvzrqG/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050217; c=relaxed/simple;
	bh=X7vkqyMBNaheIUNkehORS3JSEiBfbHm+bdTobACrNNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddIBJ5XTfPCbS+ts3ZiPRQtJ0v/YLTZ05CgNrXkUpzvaUUBxYEVjuWrTIM+Js4WG6GVtlL9k5NWRWnPXll48gVARYFV2+0KrMEN0diWLxE/Ugo+znq3ZY1mv/g2EJyBTEqcNICxppP9mr6M67Pt65QghXnAD7vj8FPDxea9pknI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WpRV8Ng8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741050214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bnm2BczQeE+oTxQUkTu0mGWgYbP3KRiI/EZBYxWyGBw=;
	b=WpRV8Ng8ORVkZxca2NVZyEkS+S8Sei1ppLUnm8n6UadFDO1Va+fjHocOrzpLZ/Lo0Mu1Qt
	F7njx5BNT3wiWV3ezxdJtK6h9RIrauw82J/HwuXXhZOd/Og72hhx+2JfwITpNxqd6yhAsD
	DMwpPZRU6rzs0/XYNg+BR7aM3NK6xHg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-MoNlUajHMSS5hFC1ZHm5xQ-1; Mon, 03 Mar 2025 20:03:33 -0500
X-MC-Unique: MoNlUajHMSS5hFC1ZHm5xQ-1
X-Mimecast-MFC-AGG-ID: MoNlUajHMSS5hFC1ZHm5xQ_1741050212
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2feb8d29740so7643578a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 17:03:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741050212; x=1741655012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bnm2BczQeE+oTxQUkTu0mGWgYbP3KRiI/EZBYxWyGBw=;
        b=Et7/oMqQc9xUsrxk9F7/vlJMZ3HSQRaASacS0yg1c/Y0N+MbV1u9zeVXuCJeVNgQs6
         aoGw9L0JqRpZkVfZCtfRR0qlE5ZAhirzAF31YkQP2Fo4UNxwy89ZgH1c0GjB4ewhimnx
         Tz64scm7td8VKqnRjwD/OIRSSj5GM08X8e8V/imBzYettUR4kXlv9EBD/NZ3mWdkJ4+K
         X1Reu46iEQE/G747sLgHbEvmJjmvZF0W7Ej7fd3+ertu+Qx2HZZRyZjN/nvJ1z8XBxBR
         ySbsMOWqOT3kFomyYGGAH6vxN7XfT9nj42Oc4/tHOv/fpqdxJl6Tm8adpRZ/yT6Q0kYR
         6/XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe1QWC+uDwtrk+XC1znEWVxFAdXcOgZHOFgMnx6d5YlymgmW3ynBKsSKjHEJ9hPtSe8eYxTq2JQF1ZCNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEQ8eL6/A2adZgwz9vvv3Uu2fXZ7VY73PWEKs2aEL65+BXZnIA
	Xhc48n2EihQurWCPXuhfgET0Ti/kmPh2gN1+x5DWo9OwyWqfW20QgxcFR00xQW1rxhVCsewq2mC
	JCTV0vMmDcJN+Xhkfjwm2/dEudVbH+BIApPc9Jz148YAI9B2D69byMimFQIKurQ==
X-Gm-Gg: ASbGncuPKcFhVvJKY0M8fj6WYANb4IBO4+BNLxMW1QChhL9LcmfP+q4LH49RMf0v35/
	ucH9SZJT0mr5l7SxNbf1PWtiGEmnGilaJ7x0FSBNqXl6uU8GUsikBchiX8KHIJQ2apntb3LHZwA
	kqQQqwUaxyrJUifLcPYzkgqw0f3uucZNOvLosklJsXOjW85jYx0Oz97yXoHTJ1YEv0XDwaedwAI
	Om4B0H0aFAmagAf4SKIS++Zgx+i98oa4US/4ilCitQ5Mmi8bPwOY2JI7G0+0n3mnqXA9q8vmyTM
	IYZAWOAAU+BsFLGfqA==
X-Received: by 2002:a05:6a20:1594:b0:1ee:650b:ac22 with SMTP id adf61e73a8af0-1f2f4e4c8e2mr29503602637.40.1741050211925;
        Mon, 03 Mar 2025 17:03:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh6O0/XBxWNy8f6zQpOsX8TWQ/teZrvIDTKOnq0U3+AlSWoqSQsK295l3GALc1XNoc+vUz9w==
X-Received: by 2002:a05:6a20:1594:b0:1ee:650b:ac22 with SMTP id adf61e73a8af0-1f2f4e4c8e2mr29503541637.40.1741050211560;
        Mon, 03 Mar 2025 17:03:31 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf2444sm9001374a12.3.2025.03.03.17.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 17:03:30 -0800 (PST)
Message-ID: <80983793-5df7-4828-96e8-90540e7d9183@redhat.com>
Date: Tue, 4 Mar 2025 11:03:21 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 17/45] arm64: RME: Handle realm enter/exit
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250213161426.102987-1-steven.price@arm.com>
 <20250213161426.102987-18-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-18-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:13 AM, Steven Price wrote:
> Entering a realm is done using a SMC call to the RMM. On exit the
> exit-codes need to be handled slightly differently to the normal KVM
> path so define our own functions for realm enter/exit and hook them
> in if the guest is a realm guest.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v6:
>   * Use vcpu_err() rather than pr_err/kvm_err when there is an associated
>     vcpu to the error.
>   * Return -EFAULT for KVM_EXIT_MEMORY_FAULT as per the documentation for
>     this exit type.
>   * Split code handling a RIPAS change triggered by the guest to the
>     following patch.
> Changes since v5:
>   * For a RIPAS_CHANGE request from the guest perform the actual RIPAS
>     change on next entry rather than immediately on the exit. This allows
>     the VMM to 'reject' a RIPAS change by refusing to continue
>     scheduling.
> Changes since v4:
>   * Rename handle_rme_exit() to handle_rec_exit()
>   * Move the loop to copy registers into the REC enter structure from the
>     to rec_exit_handlers callbacks to kvm_rec_enter(). This fixes a bug
>     where the handler exits to user space and user space wants to modify
>     the GPRS.
>   * Some code rearrangement in rec_exit_ripas_change().
> Changes since v2:
>   * realm_set_ipa_state() now provides an output parameter for the
>     top_iap that was changed. Use this to signal the VMM with the correct
>     range that has been transitioned.
>   * Adapt to previous patch changes.
> ---
>   arch/arm64/include/asm/kvm_rme.h |   3 +
>   arch/arm64/kvm/Makefile          |   2 +-
>   arch/arm64/kvm/arm.c             |  19 +++-
>   arch/arm64/kvm/rme-exit.c        | 171 +++++++++++++++++++++++++++++++
>   arch/arm64/kvm/rme.c             |  19 ++++
>   5 files changed, 208 insertions(+), 6 deletions(-)
>   create mode 100644 arch/arm64/kvm/rme-exit.c
> 

With below nitpicks addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

[...]

> diff --git a/arch/arm64/kvm/rme-exit.c b/arch/arm64/kvm/rme-exit.c
> new file mode 100644
> index 000000000000..aae1adefe1a3
> --- /dev/null
> +++ b/arch/arm64/kvm/rme-exit.c
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 ARM Ltd.
> + */
> +
> +#include <linux/kvm_host.h>
> +#include <kvm/arm_hypercalls.h>
> +#include <kvm/arm_psci.h>
> +
> +#include <asm/rmi_smc.h>
> +#include <asm/kvm_emulate.h>
> +#include <asm/kvm_rme.h>
> +#include <asm/kvm_mmu.h>
> +
> +typedef int (*exit_handler_fn)(struct kvm_vcpu *vcpu);
> +

Duplicated to exit_handler_fn, defined in handle_exit.c, need move the
definition to header file.

> +static int rec_exit_reason_notimpl(struct kvm_vcpu *vcpu)
> +{
> +	struct realm_rec *rec = &vcpu->arch.rec;
> +
> +	vcpu_err(vcpu, "Unhandled exit reason from realm (ESR: %#llx)\n",
> +		 rec->run->exit.esr);
> +	return -ENXIO;
> +}
> +
> +static int rec_exit_sync_dabt(struct kvm_vcpu *vcpu)
> +{
> +	return kvm_handle_guest_abort(vcpu);
> +}
> +
> +static int rec_exit_sync_iabt(struct kvm_vcpu *vcpu)
> +{
> +	struct realm_rec *rec = &vcpu->arch.rec;
> +
> +	vcpu_err(vcpu, "Unhandled instruction abort (ESR: %#llx).\n",
> +		 rec->run->exit.esr);
> +	return -ENXIO;
> +}
> +
> +static int rec_exit_sys_reg(struct kvm_vcpu *vcpu)
> +{
> +	struct realm_rec *rec = &vcpu->arch.rec;
> +	unsigned long esr = kvm_vcpu_get_esr(vcpu);
> +	int rt = kvm_vcpu_sys_get_rt(vcpu);
> +	bool is_write = !(esr & 1);
> +	int ret;
> +
> +	if (is_write)
> +		vcpu_set_reg(vcpu, rt, rec->run->exit.gprs[0]);
> +
> +	ret = kvm_handle_sys_reg(vcpu);
> +
> +	if (ret >= 0 && !is_write)
> +		rec->run->enter.gprs[0] = vcpu_get_reg(vcpu, rt);
> +

Unncessary blank line and the conditon isn't completely correct: kvm_handle_sys_reg()
should return 0 if the requested emulation fails, even it always returns 1 for now.

	ret = kvm_handle_sys_reg(vcpu);
	if (ret > 0 && !is_write)
		rec->run->enter.gprs[0] = vcpu_get_reg(vcpu, rt);

> +	return ret;
> +}
> +

[...]

Thanks,
Gavin


