Return-Path: <linux-kernel+bounces-190953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C6B8D04D1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482011C2150E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D13016F822;
	Mon, 27 May 2024 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zpo3QcK3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB4116F28C
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819830; cv=none; b=l0q/TCcPzycZlqLmhjf+kQXp1DnJ2Sa1k/T17U5l9QHPYRc9gdBW3q1uXS/lVL1RggzXKXfPsJtabtCH7sRvr/gu/AdsVt1BAIyBt+oRC0/DV/wFZmGPASWo7nFQ422i9h8j3Lj0IC252rqelgN6+p7oKdVq3Fw5B9ijMiOHF+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819830; c=relaxed/simple;
	bh=U/8+cNT/6r/cPMQxaKHzz9tqRw3+vgHMhlaxgqt/NIY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KOOA61KjcCH5UXZ6/yBKui+H10jc16hui0pRA4s0Lyu3hB4ehSKpHr5TXRYisvHDImJjUflnJkrHSNxQcQnWN31NXIZzZgEPgjku52GtToCa2UDPkcm2dwSTtTmAtEEwGBcTgLPVhw6YN3ixSdtWt3YFmsKTqb02Pg85P7lm4RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zpo3QcK3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716819828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uDkfQTZ2OD4EHqIyUHZnwKqde9p/2Gl7tlIUwS9iQSE=;
	b=Zpo3QcK3FIC1cgPF1L7YNaK6xzcZgxPAyd98bGkaO+KWiX30t8RPve54ufvrYM73p2Kq9L
	0y/IcOG3FafwOrGS6aXPQluex2gdX+ONj2Qh9jUM3EoPXB+gP8AtU2/n705haV4MtcNFZ+
	TuYTj6sAfpwkrGbVI5/AOvXOfjVnnLg=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-_9a1mtQHMTKWqB6pg-Ox2Q-1; Mon, 27 May 2024 10:23:45 -0400
X-MC-Unique: _9a1mtQHMTKWqB6pg-Ox2Q-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3d1c9fcce4bso476048b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819825; x=1717424625;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDkfQTZ2OD4EHqIyUHZnwKqde9p/2Gl7tlIUwS9iQSE=;
        b=Q67N0pm9qGdNAVb73i7b54628FVRzI3j+jtTcKP73/hbWmawjqsLp1G9LoX+pQy6sQ
         XYzpvo8h0Iku7YH9K/W3WLwFmDf/O/zHI5O3b2YEPH9/Smjn9NRHB4flSDNs5Ml6boWP
         jl15HsBZyd/kQaqPns4snw8cHPzB5UVWORm7OWzPr4dH5E3OvYiIIwcdwCYvi/Tjr0yD
         dx0y21VsxlJDek8mwkn8XGHm9U5jPIsLmveVSsvgygzdiv0jAv4kCs2ZeS5hCM08yxht
         Fmg+liVs0kdKrASGjDDZrDm3a22HtpAB/yGGXE9nLE3uiCuTtscVu1NG+DyO2vF77NvX
         zz7g==
X-Forwarded-Encrypted: i=1; AJvYcCVS7BLEOy9oGhGJO9JIEahU3/jTSgrdalaEduiIxcxWVtTzuSCwctFu2MjYglBaVMO0otme5QOqUtUm5J6HazfMcV/UejJzt66tKwh1
X-Gm-Message-State: AOJu0YzyLYaiMf+PDqvoEf5md2mhugS9/cuM8myVjxe+cQ/TdiRESztN
	FvfULx+IjwbAu98L4mdJiVNqTTLgRrRvzfaB25+OVHqS14hp2rED4kHx6yG+uINcxe8EGkSQc/a
	kawpgypOz1r7R9sGgn/QiPKtZpk8Amc3YB1xVprYV+jbpHhXKIa6cHoYhmsKLTg==
X-Received: by 2002:a05:6808:2895:b0:3c9:6f32:48ae with SMTP id 5614622812f47-3d1a7646b36mr10077213b6e.47.1716819824866;
        Mon, 27 May 2024 07:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd337yra6VNYY4/lCnAw6wP0WY3esjyq2b6ysnQazhhPyLwvvBYzmWw4XghHqjVOjt15jOCg==
X-Received: by 2002:a05:6808:2895:b0:3c9:6f32:48ae with SMTP id 5614622812f47-3d1a7646b36mr10077185b6e.47.1716819824441;
        Mon, 27 May 2024 07:23:44 -0700 (PDT)
Received: from rh (p200300c93f02d1004c157eb0f018dd01.dip0.t-ipconnect.de. [2003:c9:3f02:d100:4c15:7eb0:f018:dd01])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad77430c57sm17299476d6.38.2024.05.27.07.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:23:44 -0700 (PDT)
Date: Mon, 27 May 2024 16:23:39 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Shaoqin Huang <shahuang@redhat.com>
cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>, 
    Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 1/6] KVM: arm64: unify code to prepare traps
In-Reply-To: <080b8820-d665-40d6-9cf2-35e47086d01e@redhat.com>
Message-ID: <ab00cdd6-7b93-05a0-896b-24e68e9413a2@redhat.com>
References: <20240514072252.5657-1-sebott@redhat.com> <20240514072252.5657-2-sebott@redhat.com> <080b8820-d665-40d6-9cf2-35e47086d01e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Shaoqin,

On Mon, 27 May 2024, Shaoqin Huang wrote:
> On 5/14/24 15:22, Sebastian Ott wrote:
>> +++ b/arch/arm64/include/asm/kvm_emulate.h
>>     static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
>>   {
>> -	vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;
>> -	if (has_vhe() || has_hvhe())
>> -		vcpu->arch.hcr_el2 |= HCR_E2H;
>> -	if (cpus_have_final_cap(ARM64_HAS_RAS_EXTN)) {
>> -		/* route synchronous external abort exceptions to EL2 */
>> -		vcpu->arch.hcr_el2 |= HCR_TEA;
>> -		/* trap error record accesses */
>> -		vcpu->arch.hcr_el2 |= HCR_TERR;
>> -	}
>> +	if (!vcpu_has_run_once(vcpu))
>> +		vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;
>
> Could you give more explaination in your comments about why we still keep the 
> non-FWB handling in vcpu_reset_hcr()? That would be better for understanding 
> the special case.
>

VM ops trapping needs to be toggled via KVM_ARM_VCPU_INIT for this case to
catch when the guest activates its MMU. This is different to the other
traps that are setup once before the guest runs for the first time.

Sebastian


