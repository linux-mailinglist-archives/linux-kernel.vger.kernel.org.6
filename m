Return-Path: <linux-kernel+bounces-378164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE75C9ACC38
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C67B22021
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD5D1BD50C;
	Wed, 23 Oct 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ExIoVPnC"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CCB1BD004
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693527; cv=none; b=rD6t5PpQNNVT7bsHadxBoEuZXLv+HrejZ7SBmM6oX8EmBc4smJCeD1apW1+93V7hzcdY9eOBX7yk2QjMXtjRdsvDHcNebg467Wuq1hIAIeT6qQ78M+DjpC5I6Myq51DZ9YgMV4SwEWoSmkGq0NkU/5bwnrvsDbeUxmZ5DE7EcsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693527; c=relaxed/simple;
	bh=Atp5upH3DtCIHnwaI9XOSOzgzoZpBVQq3z1PqjbCDtc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lnDDMXEgz3ne2xiBmKAozbpenYfLIZMdhFKOoQ1CzgXFlmsHswWjV1Hj1uOcOvKqGphgc/PSi9e+4nmSH3zumG/GP4LBN7O9uDbtIihS+n2cod7lpfMUcksVtngTvM0U0IAmPeNvqKcVJcf5hVBNKJjCTDAHYHmKsQYCgnc6zx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ExIoVPnC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43159c9f617so66657705e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729693524; x=1730298324; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JbBGUrTTwoSsEPHprz8mGE870fzfQn9kpkbrOCXaRAU=;
        b=ExIoVPnCWX8ynGHQ1bDzietNbf958uZKlsKSMnYpKN3wg2br6wi9hLBnB9nQ50HAyG
         kDZUkwsjTvxDmCgNFedJ2hEB8CaXPjx6/NacVSRlKvitLmxiEJBC9joDRy7lRPo3dg8c
         JE9sHb8p4/0j4GU0MKZlV9bcNDZYE8LTLXv8I0UApayh2tAMP9/PyGnk7fszrbpAtIF9
         erBfJYOUjX4KZIvxc6MIJsw1MxD18/q9SigqsYGMwf+N7DXO66/WLAVnW77ZVRaF0zSl
         QH/sP4g78ytDmRChb8ssOI77aR+1GfPt5Txu10KjLee0rilgz+GJR1BbhzijHJvxonOM
         ChWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729693524; x=1730298324;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbBGUrTTwoSsEPHprz8mGE870fzfQn9kpkbrOCXaRAU=;
        b=Y9xS2Iga/w3funS3mGv0coHetxB3Q8577yJslizomR0yuvoLsnYOy9QYyuMOCGv7Fd
         bBZKPlFhLezMSjk4NHHkl5uooL8mUuDtPhyljTw5AMUgRXhJXhgifzfVvwq+gGkDQxQ4
         O5LK8826tmvbW+hkhmzyag3geu5ptg9kzFpz0iNJnHXb0ZrlzycV7agoh3W73a7kxp3t
         g9mzbdiQTUlGbpkZDTIAtz3mj28rxnI9XoNPg2Igfb2g3F3G/YOyK7ri15WeIBsTmVUz
         yQ4unyjYskihm6ulufAYTpYhapIGmlXF3wSYC+J/Eu6KxHqNa3XU5zQta6HVdCfz8M4F
         kCMw==
X-Forwarded-Encrypted: i=1; AJvYcCWxrMuofugfF/4vdCV3vDFjoQafq4JcRO2LJ4EL+8iuG3BcPdRj0Jnx7f+ya/qt+g3hFJhmESuBktRsCMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFK32ljtNxgs0sgWBWEhsSmW4+wYo/HE0pthyzihrAP+4GUGbT
	VmPMoQLHb+9KxdjulioBNtrDmPYF+XIIwoAbVj/XewhDet0rZ+KWs46cr0JW2Zo=
X-Google-Smtp-Source: AGHT+IH0BmYhNGb6Zb0oJGSdG6YllMWt2Vog0aTsr5Pi+a0czFvT36y4AITV9lfciKIwZL7MAwqiDA==
X-Received: by 2002:a5d:6707:0:b0:374:c4e2:3ca7 with SMTP id ffacd0b85a97d-37efcee8e52mr1870049f8f.5.1729693523957;
        Wed, 23 Oct 2024 07:25:23 -0700 (PDT)
Received: from localhost ([149.57.114.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a487bdsm9064779f8f.32.2024.10.23.07.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 07:25:23 -0700 (PDT)
From: Punit Agrawal <punit.agrawal@bytedance.com>
To: palmer@dabbelt.com
Cc: Alexandre Ghiti <alex@ghiti.fr>,  punit.agrawal@bytedance.com,
  paul.walmsley@sifive.com,  aou@eecs.berkeley.edu,
  alexghiti@rivosinc.com,  chenjiahao16@huawei.com,  guoren@kernel.org,
  vishal.moola@gmail.com,  stuart.menefy@codasip.com,
  linux-riscv@lists.infradead.org,  linux-kernel@vger.kernel.org, yunhui
 cui <cuiyunhui@bytedance.com>
Subject: Re: [External] Re: [PATCH] riscv: add a warning when physical
 memory address overflows
In-Reply-To: <CAEEQ3w=S=Gn9qER=qNwUn8+Gs9AN4Y5-0Zg0w8-4Vps4L7n97w@mail.gmail.com>
	(yunhui cui's message of "Wed, 18 Sep 2024 11:49:27 +0800")
References: <20240814062625.19794-1-cuiyunhui@bytedance.com>
	<afaa4192-da08-4180-a09b-2b953293ba76@ghiti.fr>
	<CAEEQ3w=S=Gn9qER=qNwUn8+Gs9AN4Y5-0Zg0w8-4Vps4L7n97w@mail.gmail.com>
Date: Wed, 23 Oct 2024 15:25:22 +0100
Message-ID: <87fromgalp.fsf@bytedance.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Palmer,

[...]

>> On 14/08/2024 08:26, Yunhui Cui wrote:
>> > The part of physical memory that exceeds the size of the linear mapping
>> > will be discarded. When the system starts up normally, a warning message
>> > will be printed to prevent confusion caused by the mismatch between the
>> > system memory and the actual physical memory.
>> >
>> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>> > ---
>> >   arch/riscv/mm/init.c | 8 ++++++--
>> >   1 file changed, 6 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> > index 52290c9bd04bd..c93164dc51658 100644
>> > --- a/arch/riscv/mm/init.c
>> > +++ b/arch/riscv/mm/init.c
>> > @@ -236,8 +236,12 @@ static void __init setup_bootmem(void)
>> >        */
>> >       if (IS_ENABLED(CONFIG_64BIT)) {
>> >               max_mapped_addr = __pa(PAGE_OFFSET) + KERN_VIRT_SIZE;
>> > -             memblock_cap_memory_range(phys_ram_base,
>> > -                                       max_mapped_addr - phys_ram_base);
>> > +             if (memblock_end_of_DRAM() > max_mapped_addr) {
>> > +                     memblock_cap_memory_range(phys_ram_base,
>> > +                                               max_mapped_addr - phys_ram_base);
>> > +                     pr_warn("Physical memory overflows the linear mapping size: region above 0x%llx removed",
>> > +                             max_mapped_addr);
>> > +             }
>> >       }
>> >
>> >
>>
>>
>> A bit weird to review and test my own patch, but here it is anyway :)
>>
>> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>
>> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Looks like the patch has been ready for a while now. If there are no
further problems, can it be merged please?

[...]

