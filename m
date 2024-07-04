Return-Path: <linux-kernel+bounces-240928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAFE9274B9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3AF286048
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0AD1ABC53;
	Thu,  4 Jul 2024 11:16:32 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5053A1DA316
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720091791; cv=none; b=cOOZqNiUt4n71DJqjxbzoVzR8uZJXTkU5fGyCLavmMBXAi4yZ48ABUYF5VIOolVUBiwFg0r4wxhInBZcwSli5n04Zz0m9ftZ7U3L4tCmJ2/lu13fKPH93PX3wSFlmLdSB8hSir2fnNcb481NUhKrxwBCtUXWdVYosSu3yRggjpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720091791; c=relaxed/simple;
	bh=Qc5wCUv0oelOTdxC8kgcnWHRJm+fU4RMTy+CAjLdO4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p5LbdHtGhbGKTJ3eihRrthvRKT+CdVJ2tVhjV+rfxomB+I5olOTR7c+V+WpUQAP8bHHS0uZjQz5pg8NfbMBAVH9Fs1WXSkGFUGM0qAdGfwijv427jkVs0ufvRHH1FWj3EEFNEz7gQ6hVin4+7ImCRUZ3qjnv61Tlsv6TRny+bKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D94B60004;
	Thu,  4 Jul 2024 11:16:26 +0000 (UTC)
Message-ID: <7fac15fb-83e0-4711-91a0-db0cb616c2c9@ghiti.fr>
Date: Thu, 4 Jul 2024 13:16:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Check that vdso does not contain any dynamic
 relocations
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Vladimir Isaev <vladimir.isaev@syntacore.com>,
 Roman Artemev <roman.artemev@syntacore.com>, Guo Ren <guoren@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240326113831.283025-1-alexghiti@rivosinc.com>
 <8734oqzlyq.fsf@all.your.base.are.belong.to.us>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <8734oqzlyq.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Björn,

On 03/07/2024 14:41, Björn Töpel wrote:
> Hey Alex,
>
> Alexandre Ghiti <alexghiti@rivosinc.com> writes:
>
>> Like other architectures, use the common cmd_vdso_check to make sure of
>> that.
>>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Looking in PW, this fails on rv32? Is that a false negative?


I had missed that, thanks.

So it's not a false positive, the check this patch adds actually reveals 
an issue: gcc seems to be smart enough to insert a memset() in 
riscv_vdso_get_cpus(). And this call to memset() inserts a relocation. 
Weirdly, only on rv32.

I managed to fix this by adding:

ccflags-y += -fno-tree-loop-distribute-patterns

I'll send this fix soon.

Thanks,


>
> Other than that,
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

