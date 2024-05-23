Return-Path: <linux-kernel+bounces-187863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5646D8CD9B9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBC40B224BA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694EB80603;
	Thu, 23 May 2024 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="MSu3ybZT"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A71243AB4
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716488110; cv=none; b=eiWgkrSkPCTqzuJqQBfx/kZLHpwUoeO6pEpxD9YJ2X5/Ad/sdl2O8GnP9/3ecZgKdTdFdp4I1llqf5wrWslA3Rl4V3PVCYWp7V6ro4XJCPz8RJJgIj8x6E11M9Om61+FUg92yNbxtRxG8yDT7Ir9nNR4nC9JKaMZ7Ju0ruxNDSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716488110; c=relaxed/simple;
	bh=fX8mSppGZ/Zwq6LsvNMxN4PDNReI6QiaAxfOjSQuhzc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tdVhflWRVIfBfpWMH9Du8mV1CadfACZfxA/lynynFeAltFCwwkhXjczFk0Bv08nkqfj7cTUi8yMmvWSKu10qxcCanB11b+FCtvjcEb6iPIK4mGaq4PGlhoKjwVbtCX387tF3MF7MMDx7EtI8vfJlbzqvv+45UQ5M6E8YMulnktA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=MSu3ybZT; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1716487751;
	bh=fX8mSppGZ/Zwq6LsvNMxN4PDNReI6QiaAxfOjSQuhzc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=MSu3ybZTg8BMjTHiMSL7eit6fDs7/LYW1i0G7KLFbM2EeumOWXqT2XpXPASstv5At
	 5jdP7kVkf/q9/6ljobGWGw5tzKtwfkemmMMMnJ9g5oluCZN1hEyfwGSqbOcI/f6Q0i
	 KWcqyWkHwiTDi7aex6KKy8CuxXOPFVUjrj8Ng4AE=
Received: by gentwo.org (Postfix, from userid 1003)
	id 3A77340251; Thu, 23 May 2024 11:09:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 39BF5401F3;
	Thu, 23 May 2024 11:09:11 -0700 (PDT)
Date: Thu, 23 May 2024 11:09:11 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Catalin Marinas <catalin.marinas@arm.com>
cc: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org, 
    anshuman.khandual@arm.com, scott@os.amperecomputing.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
In-Reply-To: <Zk93vBqAD3LgmbGb@arm.com>
Message-ID: <640f8606-2757-4e82-721f-9625d48ded65@gentwo.org>
References: <20240520165636.802268-1-yang@os.amperecomputing.com> <Zk93vBqAD3LgmbGb@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 23 May 2024, Catalin Marinas wrote:

> On Mon, May 20, 2024 at 09:56:36AM -0700, Yang Shi wrote:
>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>> index db1aeacd4cd9..1cc73664fc55 100644
>> --- a/arch/arm64/include/asm/insn.h
>> +++ b/arch/arm64/include/asm/insn.h
>> @@ -319,6 +319,7 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void)	\
>>   * "-" means "don't care"
>>   */
>>  __AARCH64_INSN_FUNCS(class_branch_sys,	0x1c000000, 0x14000000)
>> +__AARCH64_INSN_FUNCS(class_atomic,	0x3b200c00, 0x38200000)
>
> While this class includes all atomics that currently require write
> permission, there's some unallocated space in this range and we don't
> know what future architecture versions may introduce. Unfortunately we
> need to check each individual atomic op in this class (not sure what the
> overhead will be).

Can you tell us which bits or pattern is not allocated? Maybe we can 
exclude that from the pattern.


