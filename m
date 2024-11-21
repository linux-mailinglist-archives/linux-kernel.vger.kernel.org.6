Return-Path: <linux-kernel+bounces-417553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E661F9D558F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7482830B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54A51DA2F6;
	Thu, 21 Nov 2024 22:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Mvk+asdd"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D02313A250
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732228870; cv=none; b=EPdtmWc/Or+0IKTq8eWbocSZMbPjjMa4x7VXVHB6FN9HC5iDChzjeVb3SSlGkPn5GOITRD7Oe/lsAjaibEcDjyHYQjGXHgSmdSx+Rfp1MX549xRfcStw5xSex0XJ5js/Ta+fK3UmKVGZ4Vdfk9yp4+f0lw/kLYQqQqPd9oDmt4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732228870; c=relaxed/simple;
	bh=sKr2tA3fjzb6gdaxWbFMqz6pHvsc1+IXuifJVX8m32w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPm8EjDo4RdpqIRFtiIj0JswDqrIOo3Vxj/CkuZYUi9CF/jegYo1fK9W0+ANXkvxGMCTMailNdBtKlWSe5ll6KkiEWqipEeAB8liNvZK5cx5Uw8tMMD16jSFOXr11v6WwP31vHZZn50sw++eEJSwB6VPfZSWvCSZoKlWeE5H3ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Mvk+asdd; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-83aad99d6bfso55100039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1732228867; x=1732833667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G0nFhOWS85+b5e0Y+BADc2JfWMqvmPiOUR6rVphXxW0=;
        b=Mvk+asddwiQutmJSu391dLQV/f473GIqbImE/dHLQV0YwGFVGhqDQpagTWmXrLFSV8
         Oswwc2mrGifo6rfq8CgCKzsg827YgxQxLzmjxcD6D6VHKPnfA/aDq9rD34P1lN+iHmY9
         vkZs9tZkFTIu/P2jzB2GeBwocie4s6E+8Vfj1GaDPkStyNQpd8AFAwPxWXAo9zS0PhW5
         WYjT7pIM8RoL7ze2sksuAisaMfN/GXf7Sz/L9ig8lIZWi38AbqgnwG37oi3U7S1DXpOo
         XQiDWXiapXgmgfnVeBqPHFj6Dzfo1GV1CUFVEIR8T9o1o0Qm5Li65yY8bQhv91YdKnd5
         nIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732228867; x=1732833667;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G0nFhOWS85+b5e0Y+BADc2JfWMqvmPiOUR6rVphXxW0=;
        b=h02hxNNjNkbk1a7/jp203Zaxhglpw3N2oShLKJJTv8kfGRQdRtCWHKhKpKzvDHIob3
         nuMpH7McTeDM4Ot36Rvt8M+LE/8VLVqNBL42sRRzTDSfsP0dToGpFk6BpJg5OvXnBrkv
         B8qZ0tFWVB51/6M0ZjftL/z+0kuF7kS+KJAMQshVy9TZWRK2K1eWnn2q+n39aFKwws2k
         0A355hjHBa5ZAvNlRGFfeM/Grw9+xokWmRybBrC3lEeY5DV9onUUMN3YzxYjUZI45V3U
         w0qnchXL/4QAq3JkU5qj+XbDVkcg11KRLMqXzjJgHhO/du+SmlbMfe3Nkxxvz5chIXkM
         Z5GA==
X-Forwarded-Encrypted: i=1; AJvYcCVc/gN9mz11/ZoLHaya8pDhAU0W/LMmlwxcmxw9kXpOPaNeZ1SRYqZyEByYNMdSMIQNNZuZ9lDBI8XgcvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeTAieIVRfoi1o9tkxcj02dqItLkW7xVmEGjcevepTrFdcqZ2D
	kExcLv9seF6nEgzB21rIEPfjpwd2ZikzQ09u7mKhrxcRjqKExLwQBiGWsDzs17E=
X-Gm-Gg: ASbGncur5q3nzfyAu0Xe6CJswKgJvpc/Y/l0CYCulwbh+eHABdTF715w3BfV/M26q21
	gIv4lT+vtKyMB8P2FPY95du5dG0D+vRNCT4xEoqFcCJT1T7Ib/9Xx/lLC27ZPMMhAxEZdRAn1ws
	Dogc3VmBmKEWgtZjWYAuNa/N4B9fIBVA9nfk7m/t2NBJJ8WMsB4GjfzwFAzS7rFrOjc/IGGIS/T
	Bzn7KAM5YQylKJytNGypFgmtie6AH8jczeP2pmXiPqEdWRWmWxbDxeOnp++v7Zk3wpqtUFh4s4=
X-Google-Smtp-Source: AGHT+IFtYm7+InIzE8NYWnE5on5jRcQ1LiNxm3OAKBXi9wWhDfkAhDCnGw+SZnH/vFb1Xp+/slpCBw==
X-Received: by 2002:a05:6602:608a:b0:83a:b188:7a4d with SMTP id ca18e2360f4ac-83ecdb38114mr88002539f.0.1732228867257;
        Thu, 21 Nov 2024 14:41:07 -0800 (PST)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83ecd418010sm18407939f.42.2024.11.21.14.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 14:41:06 -0800 (PST)
Message-ID: <4141beba-3310-49a0-9163-538b89c0e6fb@sifive.com>
Date: Thu, 21 Nov 2024 16:41:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: Call secondary mmu notifier when flushing the
 tlb
To: Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240328073838.8776-1-alexghiti@rivosinc.com>
 <20241121-e97820f8c09de9bcedfe885d@orel>
 <0456b6b4-1453-444d-8cd8-38715dc9f845@ghiti.fr>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <0456b6b4-1453-444d-8cd8-38715dc9f845@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alex,

On 2024-11-21 4:36 AM, Alexandre Ghiti wrote:
> Hi Andrew,
> 
> On 21/11/2024 10:32, Andrew Jones wrote:
>> On Thu, Mar 28, 2024 at 08:38:38AM +0100, Alexandre Ghiti wrote:
>>> This is required to allow the IOMMU driver to correctly flush its own
>>> TLB.
>>>
>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>> ---
>>>
>>> Changes in v2:
>>> - Rebase on top of 6.9-rc1
>>>
>>>   arch/riscv/mm/tlbflush.c | 39 +++++++++++++++++++++++----------------
>>>   1 file changed, 23 insertions(+), 16 deletions(-)
>>>
>> Hi Alex,
>>
>> Is this patch still something we need?
>>
>> Thanks,
>> drew
> 
> 
> Yes I think so, hopefully it gets merged.

Please rebase and resend this patch. It conflicts with two other changes merged
since you sent v2 (038ac18aae93 and f58e5dc45fa9), in addition to the one you
sent the resolution for.

Regards,
Samuel


