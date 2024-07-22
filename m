Return-Path: <linux-kernel+bounces-259380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 780F793950F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38CCF1F221F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395B638DC7;
	Mon, 22 Jul 2024 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Fz/XlNq8"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80924219FF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682310; cv=none; b=HbU4qkR9i4KE8TxNOFnGAWNL/oMZJycESQYZft+00d6VNd/qVsiVDRsOUEwJo+4zpGuCUppW/CUfeLik4BTPD8U0NCNI7AfMBlHpKYEvGZb5O0ovlKFdqPIUnaozXm1zW/4Qds1Nw9+/I8T/9mmpHViSDnk6vxbKNxoazCge8ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682310; c=relaxed/simple;
	bh=pKDNl9/ehHUpSmuKgCdC/RyOZx807qf27mBVei8eZ+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ftj2vhQaKhPpkK+lwhk4zYvD49ZWJDZI/ByaO1QjUuzROBVb6LOzgAu15dpAPiD5+PsUuaNxRqWnwZlMy5FYAszXLnqCk8TiTGIOyrIXLhuwT4hZq0T1g/9dCe5GFx23xbG+TCTkP8BuJmjEL2NwSBFV9XGDeR6X0N3NIYDp+Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Fz/XlNq8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3687f8fcab5so2147945f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721682307; x=1722287107; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wJl+KODOtbQbJVQoLcgZraNukUc1AfpSiHvhjNN/EGA=;
        b=Fz/XlNq8scis6Et7kQv1Ns0YAB0TuSWzOUFAn3gZJXVW5zYBctuOPE9lacsaneYr+m
         d6Xe6at3KU+yqr8pDuyVcTvvcALVNkE2A5vqNlyueq9f8/ZD7qzMEW3PNCQymadouo5I
         VrVwM/l8q6oDNx7F3HgIzwbSX9hSBQb6Wnjk33Zj9mdZFZlWFJliJza1rhZXXb7T/Mln
         kb35wOO3vP/RkyUvfc+/9dJ4BI7owz3aoV0qXf5c6k2yJUWJy+pYN5fm4Z1dWUvQ07+A
         2Ou/njQ8AbkBc0fJLdESavbA2/BAwuqoBnvyzYdJ7qgbcXxcK5G7Ke4HxUMsJwARdapQ
         wJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721682307; x=1722287107;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJl+KODOtbQbJVQoLcgZraNukUc1AfpSiHvhjNN/EGA=;
        b=CuoR/TDS4LP4Ot2slupgi1Yyzqk5H8ws4wzYYjxGiq0WrOLvep/YgKCpiXye3YPR8A
         5WXER1U8nkGiPjuWAdvJV9meQbq462DFZBjo80ptu1wZhmjYEXxOUZsm6GyufiFRZ6ro
         yLfMXNztu69X2uodoBNQgMkQpdR7I5YI8oq60c0gg7Hi/z4JwAsMbWISjV/aU64Rx1PA
         eqINBzDOKGAVIT2/vyuLA4be/dExd6sddDmwtHdZrpqc0/Hge7CG1CqfF5oMLPm+Kxjh
         T9eaEfRYWGr14W8sX13JZgpmFx4Znqk3X15601fhRv7nWaV+7USxbnf49O22cal4q+jg
         Gt2g==
X-Forwarded-Encrypted: i=1; AJvYcCW8kk1z3Cg9ljfBGj8dBVTT/QBkuBmgMuXYbAiZM97WbR7TKL1EELM3nW9RWoTOOSbYxqP7EciSOwq8tQ/1Il86n5T0gJl6+CqjSC9i
X-Gm-Message-State: AOJu0Yy6ZkR9HycSQYrnMF0jbIalzI7bOjjFCajemeKDB0xgAsRAUB5n
	IZfyqC/byGc6oAT6MOyip62QCgwcTc96eRY0q5jk5+jYcejyYvxqU4WkrsS9eA0=
X-Google-Smtp-Source: AGHT+IGmKiPLP6iZJ8231zq2ISbOWAeyGZtgOmCIid0gBb3g2mEMGCtiGof9hqlaCaNgxv7yS+/6Pw==
X-Received: by 2002:a5d:6192:0:b0:368:3717:10b3 with SMTP id ffacd0b85a97d-369bae23a3bmr5618969f8f.8.1721682306665;
        Mon, 22 Jul 2024 14:05:06 -0700 (PDT)
Received: from localhost ([149.71.24.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787cedabsm9521320f8f.84.2024.07.22.14.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 14:05:06 -0700 (PDT)
From: Punit Agrawal <punit.agrawal@bytedance.com>
To: palmer@dabbelt.com, Palmer Dabbelt <palmer@rivosinc.com>
Cc: paul.walmsley@sifive.com, costa.shul@redhat.com, aou@eecs.berkeley.edu,
	samitolvanen@google.com,  corbet@lwn.net,
	Anup Patel <anup@brainfault.org>,  linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,  jesse@rivosinc.com,
	conor.dooley@microchip.com,  Yunhui Cui <cuiyunhui@bytedance.com>,
	andy.chiu@sifive.com,  cleger@rivosinc.com,
	linux-riscv@lists.infradead.org,  jrtc27@jrtc27.com,
	evan@rivosinc.com, Punit Agrawal <punit.agrawal@bytedance.com>
Subject: Re: [PATCH v4] RISC-V: Provide the frequency of time CSR via hwprobe
In-Reply-To: <87jzhtmvqg.fsf@bytedance.com> (Punit Agrawal's message of "Wed,
	10 Jul 2024 10:39:35 +0100")
References: <20240702033731.71955-1-cuiyunhui@bytedance.com>
	<20240702033731.71955-2-cuiyunhui@bytedance.com>
	<87jzhtmvqg.fsf@bytedance.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 22 Jul 2024 22:05:05 +0100
Message-ID: <87bk2pkuim.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Punit Agrawal <punit.agrawal@bytedance.com> writes:

> Hi,
>
> Yunhui Cui <cuiyunhui@bytedance.com> writes:
>
>> From: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> The RISC-V architecture makes a real time counter CSR (via RDTIME
>> instruction) available for applications in U-mode but there is no
>> architected mechanism for an application to discover the frequency
>> the counter is running at. Some applications (e.g., DPDK) use the
>> time counter for basic performance analysis as well as fine grained
>> time-keeping.
>>
>> Add support to the hwprobe system call to export the time CSR
>> frequency to code running in U-mode.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>> Reviewed-by: Evan Green <evan@rivosinc.com>
>> Reviewed-by: Anup Patel <anup@brainfault.org>
>> Acked-by: Punit Agrawal <punit.agrawal@bytedance.com>
>> ---
>>  Documentation/arch/riscv/hwprobe.rst  | 2 ++
>>  arch/riscv/include/asm/hwprobe.h      | 2 +-
>>  arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>>  arch/riscv/kernel/sys_hwprobe.c       | 5 +++++
>>  4 files changed, 9 insertions(+), 1 deletion(-)
>
> The commit looks ready to be merged. Will this picked up for the 6.11
> release?
>
> Once this is merged, we can send out the DPDK change relying on the
> newly added key.

I see the first part of RISC-V patches got merged for 6.11. Any chance
for this patch to still make it for this cycle?

