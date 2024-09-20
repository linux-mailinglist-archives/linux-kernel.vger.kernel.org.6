Return-Path: <linux-kernel+bounces-334104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7CF97D2A7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D47B2868DB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900DA13A884;
	Fri, 20 Sep 2024 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="UTjO6AzJ"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBEC7DA7F
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820595; cv=none; b=AYtmiivVJc/boeHTiVNmFpU0sPsKbq07j16FtRYmrEwoyDCuP1G6x1g4RzzfOlBTOJesNMVTmb1bH3+fPqzUgBP7duUFxIIGxob6Tm4Au0dXtG/OGILCDaat3AW/J49EkhBMtLeJ0wLIp6f8UbF2U8YfW/1qJq9e1YdgDSus7LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820595; c=relaxed/simple;
	bh=P2sjOrqTsbBlMQUUmRlnVFRfEsF3ZmCxwKp0czSkzAU=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=G5Xd7wQenc3uljTyfQO9oTd67584ErJcdflSKhdJkited8vFAPEWYzrv54KM6eaV85A3N0xbC0oDjW88SWkwbFjPFxpYstYIjbtBhpLjKjt5XWux2tbMqkoWD0Lxh5laCVXX/jrma0tTPKl0fQ1t3UYIm+rqbD98zCpvDKlGRR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=UTjO6AzJ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d87176316eso2144921a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 01:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726820593; x=1727425393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBXVQPVO/WRUu0WRIrl+Jty9fGGbOdQ0ucp8kontCfg=;
        b=UTjO6AzJtypbFkIqoKS6jfz68vHy1oJPyUZnzLPw/g9C8Zh1CN+NhkX0E9zjAKQt4D
         A7EqUswwFrvrBIKOXXsWiplcEg4jsBysIZlY4MFK0bKWgAlFV+rn+HCTh9ozqWJiuSUY
         ozRrDwooGkkoLylV//xcyQYSrDq9MtrhcBaF63cfg7FQJA2j7/T/ZsYtZEaCMtqJWM4N
         idbfCyns/iLaJQPjzNCQOyuAQdPbx+l/LsiOBnsFmR71X66585NXoGc5H3RTyZHkDR6p
         5hCsec7IbXgVlvazlaNnvJwnzYQ+zjCCuzjgwmaCu/WlmBWCMeg2152EOFOmOiVSEeJT
         PlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726820593; x=1727425393;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBXVQPVO/WRUu0WRIrl+Jty9fGGbOdQ0ucp8kontCfg=;
        b=Gj+0Q990wqbYvb6PI4P8yO0iDeeepE1ZTDeYO6ToWtyw9UnC9aqYU2l77g41QGfAv4
         Gj3ba95gJ1X0aUO7s3hX1KoTOmcC02NXVXyjv7l4X5tu9gwK3vJahiIAAxRQGgbXhEqh
         DlKRtDTJSdG2eLEbMO6mwo/Q0e13UOkPepUHn5mtUxaM54OJ3B6gP2mdxZOMDiakXYR1
         LMf7vELiA8iKhUS7700V7aqvCkVuS2kH25sOiGU3mOzbhJJSlUdtAsqO/3cvk0O6s1ue
         uBGJ1k87/HUtXaQa6pHsnNW8Mgg29rZyn/W08HGPw+dQrO8e+gBiFrRK2Xv12LnHYXZ7
         6NxQ==
X-Gm-Message-State: AOJu0YxaOhCl3GeOl2E1Ub/gS9gcOh/R5rM+CadzJK4q6gMv7F4ZmkvM
	IyvTP9Fl+E3aFdV3hHe9k8CFyPqWaGVf117+SHceDAt854Y1ahNXSYUhTnxyOY/9M22hff6SpeU
	0tIZz0g==
X-Google-Smtp-Source: AGHT+IH9NDrV7GAHbQQEl1l8JhxVht+PyNuR5hqxcVUyTc66ttD41jeiinzt/IvAv2rd3AzIKS/KOA==
X-Received: by 2002:a17:90a:2f06:b0:2d8:e6d8:14c8 with SMTP id 98e67ed59e1d1-2dd7edac0c6mr3617878a91.15.1726820592704;
        Fri, 20 Sep 2024 01:23:12 -0700 (PDT)
Received: from localhost ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef31995sm3404509a91.41.2024.09.20.01.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 01:23:12 -0700 (PDT)
Date: Fri, 20 Sep 2024 01:23:12 -0700 (PDT)
X-Google-Original-Date: Fri, 20 Sep 2024 01:23:07 PDT (-0700)
Subject:     Re: [PATCH v8 0/5] Add Svade and Svadu Extensions Support
In-Reply-To: <CAAhSdy05BXUZu6BNUoDWoEVd_YiM0Dpqg=t5WYUX7+cacnO2Hg@mail.gmail.com>
CC: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
  kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, greentime.hu@sifive.com, vincent.chen@sifive.com,
  yongxuan.wang@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu
From: Palmer Dabbelt <palmer@rivosinc.com>
To: anup@brainfault.org
Message-ID: <mhng-1e3d83bb-a7f4-4fa7-8cfa-2550835026de@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 21 Aug 2024 07:43:20 PDT (-0700), anup@brainfault.org wrote:
> Hi Palmer,
>
> On Fri, Jul 26, 2024 at 2:19 PM Yong-Xuan Wang <yongxuan.wang@sifive.com> wrote:
>>
>> Svade and Svadu extensions represent two schemes for managing the PTE A/D
>> bit. When the PTE A/D bits need to be set, Svade extension intdicates that
>> a related page fault will be raised. In contrast, the Svadu extension
>> supports hardware updating of PTE A/D bits. This series enables Svade and
>> Svadu extensions for both host and guest OS.
>>
>> Regrading the mailing thread[1], we have 4 possible combinations of
>> these extensions in the device tree, the default hardware behavior for
>> these possibilities are:
>> 1) Neither Svade nor Svadu present in DT => It is technically
>>    unknown whether the platform uses Svade or Svadu. Supervisor
>>    software should be prepared to handle either hardware updating
>>    of the PTE A/D bits or page faults when they need updated.
>> 2) Only Svade present in DT => Supervisor must assume Svade to be
>>    always enabled.
>> 3) Only Svadu present in DT => Supervisor must assume Svadu to be
>>    always enabled.
>> 4) Both Svade and Svadu present in DT => Supervisor must assume
>>    Svadu turned-off at boot time. To use Svadu, supervisor must
>>    explicitly enable it using the SBI FWFT extension.
>>
>> The Svade extension is mandatory and the Svadu extension is optional in
>> RVA23 profile. Platforms want to take the advantage of Svadu can choose
>> 3. Those are aware of the profile can choose 4, and Linux won't get the
>> benefit of svadu until the SBI FWFT extension is available.
>>
>> [1] https://lore.kernel.org/linux-kernel/20240527-e9845c06619bca5cd285098c@orel/T/#m29644eb88e241ec282df4ccd5199514e913b06ee
>>
>> ---
>> v8:
>> - fix typo in PATCH1 (Samuel)
>> - use the new extension validating API in PATCH1 (Clément)
>> - update the dtbinding in PATCH2 (Samuel, Conor)
>> - add PATCH4 to fix compile error in get-reg-list test.
>>
>> v7:
>> - fix alignment in PATCH1
>> - update the dtbinding in PATCH2 (Conor, Jessica)
>>
>> v6:
>> - reflect the platform's behavior by riscv_isa_extension_available() and
>>   update the the arch_has_hw_pte_young() in PATCH1 (Conor, Andrew)
>> - update the dtbinding in PATCH2 (Alexandre, Andrew, Anup, Conor)
>> - update the henvcfg condition in PATCH3 (Andrew)
>> - check if Svade is allowed to disabled based on arch_has_hw_pte_young()
>>   in PATCH3
>>
>> v5:
>> - remove all Acked-by and Reviewed-by (Conor, Andrew)
>> - add Svade support
>> - update the arch_has_hw_pte_young() in PATCH1
>> - update the dtbinding in PATCH2 (Alexandre, Andrew)
>> - check the availibility of Svadu for Guest/VM based on
>>   arch_has_hw_pte_young() in PATCH3
>>
>> v4:
>> - fix 32bit kernel build error in PATCH1 (Conor)
>> - update the status of Svadu extension to ratified in PATCH2
>> - add the PATCH4 to suporrt SBI_FWFT_PTE_AD_HW_UPDATING for guest OS
>> - update the PATCH1 and PATCH3 to integrate with FWFT extension
>> - rebase PATCH5 on the lastest get-reg-list test (Andrew)
>>
>> v3:
>> - fix the control bit name to ADUE in PATCH1 and PATCH3
>> - update get-reg-list in PATCH4
>>
>> v2:
>> - add Co-developed-by: in PATCH1
>> - use riscv_has_extension_unlikely() to runtime patch the branch in PATCH1
>> - update dt-binding
>>
>> Yong-Xuan Wang (5):
>>   RISC-V: Add Svade and Svadu Extensions Support
>>   dt-bindings: riscv: Add Svade and Svadu Entries
>>   RISC-V: KVM: Add Svade and Svadu Extensions Support for Guest/VM
>>   KVM: riscv: selftests: Fix compile error
>>   KVM: riscv: selftests: Add Svade and Svadu Extension to get-reg-list
>>     test
>>
>>  .../devicetree/bindings/riscv/extensions.yaml | 28 +++++++++++++++++++
>>  arch/riscv/Kconfig                            |  1 +
>>  arch/riscv/include/asm/csr.h                  |  1 +
>>  arch/riscv/include/asm/hwcap.h                |  2 ++
>>  arch/riscv/include/asm/pgtable.h              | 13 ++++++++-
>>  arch/riscv/include/uapi/asm/kvm.h             |  2 ++
>>  arch/riscv/kernel/cpufeature.c                | 12 ++++++++
>>  arch/riscv/kvm/vcpu.c                         |  4 +++
>>  arch/riscv/kvm/vcpu_onereg.c                  | 15 ++++++++++
>>  .../selftests/kvm/riscv/get-reg-list.c        | 16 ++++++++---
>>  10 files changed, 89 insertions(+), 5 deletions(-)
>>
>> --
>> 2.17.1
>>
>>
>
> Let me know if this series can be taken through the KVM RISC-V tree.
> I can provide you with a shared tag as well.

I think the patchwork bot got confused by patch 4 going to fixes?  It 
says this was merged.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

if you still want to take it, otherwise just LMK and I'll pick it up.

> Regards,
> Anup

