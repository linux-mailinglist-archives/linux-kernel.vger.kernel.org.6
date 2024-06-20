Return-Path: <linux-kernel+bounces-222214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2D990FE4C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F451C21591
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E2517B43E;
	Thu, 20 Jun 2024 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DrH8nq46"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD1A17BB16
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870792; cv=none; b=hGtGKr6VagTZQbiiO3DtnUfzBNdFsqZmfa9he+0BKQS2fFDW6YqsjAmdDiNpw3JM/hK3+PWa0/L5dItHYRwBniO3SxMzDltAirpXEKWWZ5KYq5FZ74Uc9lvx8qQM/ifKd/ox0pbYUrkOvJrn+jVSNuLMI2ABFGCFOhZe1sqI/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870792; c=relaxed/simple;
	bh=FU48facaQl2PqkE2PgZpGVkpwXcOiNsjxDvq6YgBXdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7Su94lV1kRWhjh1POJnFPfyvH+8ncS5R/Bjdypam4CSrhOoSPfedQ1ID8habMkzyKw1hh+lLN1b86NazZpbV5inXDPI2FOZLld4Yv5+GWz5Kqq2pkVIy9e57DF41PV43mSmLHiKRCKvuBxQMQ7EFIXF82zzRhTzj3d15cAdHVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DrH8nq46; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6ea972a3544so68244a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718870788; x=1719475588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=exxCmNisYIiHsonIuEmQnhq8929ewEgsNh/K3XrANwA=;
        b=DrH8nq46Dgvn+rw3A6OqLzkHkykhVT910xON8WuQu4cs8+QXLmi04OQLalqG6prC/Z
         ay3UuaLGABmsA6tSyLOTblxmpDEWwm1rHH/A6ErVljk/mse0kkpwCP80+SlK13eyiXqa
         mJlBpXEKrXK8I+gKzhFWWrdOQWi37Vkz/TILJWVmqRfWn0PGbx6afwO/7L+z/FQuR3Jg
         xaX2DIC1LJMv8SzrIh+wVBZzDrm3CO4Gy4wLChLEWHTnjY5fvaCgoQB6Vw//t5q57hSn
         wqJ6r6/CBEX69PdJWdTvwfRKap++AeaaOJ7Ow6nWqIDViw2TOYVAQVgffzPal4wAlZz3
         35tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718870788; x=1719475588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=exxCmNisYIiHsonIuEmQnhq8929ewEgsNh/K3XrANwA=;
        b=kOoFHKxYSwI08eLrzmBcfGj0BImSZiUzzXVxZKz5NzB0yEye9oLDypnrITzlx2fjj+
         TVSl2P+P43ac/iKzpMnfrYESlhLGB2T95JYfEk9sXijzM8ZRsoCFEZzn8I8SqXiXSZzK
         mKkEFo28raQJArXvncjC8ecCaJ3YV97lwJzDZCLR2RHRoTZssLDkNmYr0xOmFu4IlvUS
         o1WWiMlBXjThBleSHtpx0YtURwocBk0VCqmDv005ErxYPbppiGtRCdCQPjbILSvC/sGa
         GxnurHeS9FwJ4lhRNsAMUQjFhG+4V2pr4kLbWAUwsYb2c4EeqfGGbt7FdjnQh5hre3DU
         BLdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNZVY/NUhh2X3kY8yTI7dDxwDkB4G43VnZMU9snLFNI7D/3sp9smthohvPznMfTKTsminpybGTpx4n6FXv+p3MV5kHp13S9Wg9eU4a
X-Gm-Message-State: AOJu0YyQZZEXxw24iOTuxz8CplN4/3J2XyDnHndlU6AyDipNdGjWGrtp
	MYr0bjQ26fk44DwhWK5KNuCt8ocBBJJ6jhLiPx7oAKGAT2l8Oss77D5yz+EKwoA=
X-Google-Smtp-Source: AGHT+IHNixGnAOroozEEVABH50xx3qDhURAPZcq/Ej7yCRxPjsGlm6bITccu4Lo4UqUle+I5x6nCaA==
X-Received: by 2002:a17:903:2291:b0:1f6:ee76:1b35 with SMTP id d9443c01a7336-1f9aad7d3ddmr47193385ad.5.1718870787905;
        Thu, 20 Jun 2024 01:06:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:6944:2115:e2ed:b038? ([2a01:e0a:999:a3a0:6944:2115:e2ed:b038])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9d6b45389sm4079855ad.216.2024.06.20.01.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 01:06:27 -0700 (PDT)
Message-ID: <95a081a9-2307-4e5b-8ae2-082be16b327e@rivosinc.com>
Date: Thu, 20 Jun 2024 10:06:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] riscv: convert bottom half of exception handling to C
To: Cyril Bur <cyrilbur@tenstorrent.com>, Deepak Gupta <debug@rivosinc.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Samuel Holland <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240616170553.2832-1-jszhang@kernel.org>
 <20240616170553.2832-4-jszhang@kernel.org>
 <ZnMPhcaTKFRbbE1i@debug.ba.rivosinc.com>
 <CANtDSipXbYSuz6NakbXw-8k0_ZN5hdT7VWMushXvQ5VB0Am_Ng@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CANtDSipXbYSuz6NakbXw-8k0_ZN5hdT7VWMushXvQ5VB0Am_Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20/06/2024 02:02, Cyril Bur wrote:
> On Thu, Jun 20, 2024 at 3:04 AM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> On Mon, Jun 17, 2024 at 01:05:50AM +0800, Jisheng Zhang wrote:
>>> For readability, maintainability and future scalability, convert the
>>> bottom half of the exception handling to C.
>>>
>>> Mostly the assembly code is converted to C in a relatively
>>> straightforward manner.
>>>
>>> However, there are two modifications I need to mention:
>>>
>>> 1. the CSR_CAUSE reg reading and saving is moved to the C code
>>> because we need the cause to dispatch the exception handling,
>>> if we keep the cause reading and saving, we either pass it to
>>> do_traps() via. 2nd param or get it from pt_regs which an extra
>>> memory load is needed, I don't like any of the two solutions becase
>>> the exception handling sits in hot code path, every instruction
>>> matters.
>>
>> CC: Clement.
>>
>> I think its better to save away cause in pt_regs prior to calling
>> `do_traps`. Once control is transferred to C code in `do_traps`,
>> another trap can happen. It's a problem anyways today without CPU support.
>>
>> Although with Ssdbltrp [1] extension and it kernel support [2] for it,
>> I expect asm code would clear up `SDT` bit in mstatus. Whenever `Ssdbltrp` lands,
>> I think `do_traps` should expect nesting of traps and thus cause should be saved
>> away before it gets control so that safely traps can be nested.

Hi,

Indeed, every register that is "unique" to a trap and than can be
overwritten by a second trap should be saved before reenabling them when
using Ssdbltrp. So that would be nice to preserve that.

>>
> 
> Is a possible solution to do both options Jisheng suggested? Save the
> cause before
> calling do_traps but also pass it via second param?

I guess so if it fits your performance requirements.

Thanks,

Clément

> 
>> [1] - https://github.com/riscv/riscv-double-trap/releases/download/v1.0-rc1/riscv-double-trap.pdf
>> [2] - https://lore.kernel.org/all/20240418133916.1442471-1-cleger@rivosinc.com/
>>
>>>
>>> 2.To cope with SIFIVE_CIP_453 errata, it looks like we don't need
>>> alternative mechanism any more after the asm->c convertion. Just
>>> replace the excp_vect_table two entries.
>>>
>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

