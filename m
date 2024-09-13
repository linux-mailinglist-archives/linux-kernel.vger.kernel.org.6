Return-Path: <linux-kernel+bounces-327449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A899977627
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578C11C242CD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 00:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BFB29AF;
	Fri, 13 Sep 2024 00:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MTxTj6DO"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E300441D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 00:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726187956; cv=none; b=jVIpvJzex4HDo8Q3FvChrn2IpZwOJtcFsUMCfdmStHDO9DZKGQrvEt3qB5MxOaP+ARrANhhrDwCSJB06IhfsBYZNEREMeUY97WZQ3ipnCx9h8Efm8bG4uRiGvA3FJp8QUgVlSdymr7U90yjP9ki/dLbRdHyRXvUUA/ZyL5ZtvV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726187956; c=relaxed/simple;
	bh=08L0zeY49h3WNCoKEWf1RrEqzKHTnip0RZZYSfxScew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhqIzvg9M7w8TjynvHMkp2ZHL+JmvOasqtadhiXOmSyj3R1Nk90TAdEO/b5043H9B1qgyQJSV6D1tWG7QXjMLvLH2g1qDUkn61qzZFRpvkbuY54KfSoPyUCmwpn9WmFZLuGG+vweQEsPB7krO80VN5u8z01QnNXGis81Ilr9r6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=MTxTj6DO; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-829f7911eecso82067139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 17:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1726187953; x=1726792753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yq7jQvcHt7PS48CeNeYkOSKd0KSPF8mXYZUm141Cz7c=;
        b=MTxTj6DOs0S4xQL6gqj1scwZ3c82fzDvm0liDY2v9YDNNa47hO9/w9BoaC/ofCECwZ
         HHYyEQ1EyeNMxdnJbWGqKwl5EJytqxTiWfOExX6UWKX/5YeaSqSNQDX9bgPz/Yrnp7Xu
         BCqvMkADciK+2MSXuTwHIAaYcvyJMnfOctSPWGURQTwbEqU75+En2S9+lFyQ8FrA9ZYp
         c29yFDc+4u3VrKjp6hMc1S96IkAdr323NtRKXTbZaVAYYtwWJq8ISxIQsKC7Or0205sx
         7U6naFkzh7lAmVNvggi7swBWYcj4mpqoq/v9tbahrp+hgSrBNHa0Ow/hUoWaT/CvE9A5
         NfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726187953; x=1726792753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yq7jQvcHt7PS48CeNeYkOSKd0KSPF8mXYZUm141Cz7c=;
        b=QSBBHnu6X7IsDetycxFldhXynds2qeJfGKLtqyfSxiQUJmw1AuOWhXvQdQukWHXV6p
         7xthW+apJmxbtLbtUq+P2pUqqhJJLcayKBjbhYHAzehhTjhxQgghw3cP5nd7zVKGbX7p
         lwVwyKInB/x6jA7MXythZiRcKreKgzXeTQ4K/alwKILneSctXLOT2jIFkhE7LLmB0DMW
         fAp35DxMnTcQezMkMNdUZtHZpBpJSo4uX3LP294ZPhyi3Db9BcVHwMU1gmTY5Rb4gJa+
         KVj1NGkaMjFttV+PrrqCDxstbTWHp1j8fX30aqFyM0gfURABWXoPWs4K+AjYxfhD5wUf
         0dKA==
X-Gm-Message-State: AOJu0Yyx0iw7TMrDpTSoF0QpxFnRsvJfeooecg/oFpZ9Qgx+pryW3KIJ
	lCxygV9iiJDglfZuhkkq7JgY2dM6PdK0o3/AxXREFWEfDxoezEAyRUCgs9aBgyw=
X-Google-Smtp-Source: AGHT+IFvrXsansubjNKmfH96tpet9MMQHobUfK5ZcIImam7/5J5d7xDWJDRwrnj478owALsMz4iHEg==
X-Received: by 2002:a05:6602:2c88:b0:82d:461:703e with SMTP id ca18e2360f4ac-82d1f8c3477mr641631739f.3.1726187953271;
        Thu, 12 Sep 2024 17:39:13 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82aa76aac56sm343052539f.44.2024.09.12.17.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 17:39:12 -0700 (PDT)
Message-ID: <380f4da9-50e9-4632-bdc8-b1723eb19ca5@sifive.com>
Date: Thu, 12 Sep 2024 19:39:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: KVM: Redirect instruction access fault trap to
 guest
To: Quan Zhou <zhouquan@iscas.ac.cn>, anup@brainfault.org,
 ajones@ventanamicro.com, atishp@atishpatra.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
References: <83c2234d582b7e823ce9ac9b73a6bbcf63971a29.1724911120.git.zhouquan@iscas.ac.cn>
 <b5128162-278a-4284-8271-b2b91dc446e1@iscas.ac.cn>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <b5128162-278a-4284-8271-b2b91dc446e1@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-09-12 4:03 AM, Quan Zhou wrote:
> 
> On 2024/8/29 14:20, zhouquan@iscas.ac.cn wrote:
>> From: Quan Zhou <zhouquan@iscas.ac.cn>
>>
>> The M-mode redirects an unhandled instruction access
>> fault trap back to S-mode when not delegating it to
>> VS-mode(hedeleg). However, KVM running in HS-mode
>> terminates the VS-mode software when back from M-mode.
>>
>> The KVM should redirect the trap back to VS-mode, and
>> let VS-mode trap handler decide the next step.
>>
>> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
>> ---
>>   arch/riscv/kvm/vcpu_exit.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
>> index fa98e5c024b2..696b62850d0b 100644
>> --- a/arch/riscv/kvm/vcpu_exit.c
>> +++ b/arch/riscv/kvm/vcpu_exit.c
>> @@ -182,6 +182,7 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct
>> kvm_run *run,
>>       ret = -EFAULT;
>>       run->exit_reason = KVM_EXIT_UNKNOWN;
>>       switch (trap->scause) {
>> +    case EXC_INST_ACCESS:
> 
> A gentle ping, the instruction access fault should be redirected to
> VS-mode for handling, is my understanding correct?

Yes, this looks correct. However, I believe it would be equivalent (and more
efficient) to add EXC_INST_ACCESS to KVM_HEDELEG_DEFAULT in asm/kvm_host.h.

I don't understand why some exceptions are delegated with hedeleg and others are
caught and redirected here with no further processing. Maybe someone thought
that it wasn't valid to set a bit in hedeleg if the corresponding bit was
cleared in medeleg? But this doesn't make sense, as S-mode cannot know which
bits are set in medeleg (maybe none are!).

So the hypervisor must either:
 1) assume M-mode firmware checks hedeleg and redirects exceptions to VS-mode
    regardless of medeleg, in which case all four of these exceptions can be
    moved to KVM_HEDELEG_DEFAULT and removed from this switch statement, or

 2) assume M-mode might not check hedeleg and redirect exceptions to VS-mode,
    and since no bits are guaranteed to be set in medeleg, any bit set in
    hedeleg must _also_ be handled in the switch case here.

Anup, Atish, thoughts?

Regards,
Samuel

> 
>>       case EXC_INST_ILLEGAL:
>>       case EXC_LOAD_MISALIGNED:
>>       case EXC_STORE_MISALIGNED:
>>
>> base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


