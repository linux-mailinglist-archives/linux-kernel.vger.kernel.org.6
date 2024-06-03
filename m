Return-Path: <linux-kernel+bounces-198845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3E18D7E3C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA8C4B2364F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C328C7829C;
	Mon,  3 Jun 2024 09:14:57 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C8B770F1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406097; cv=none; b=ZfecDtj9zm1C26y2q2G2PjJbZ+SDCU2IIKKoomF8CkR6h1RLLlxCpLsa2IV1ZLXOZvU5bx1XxESplwXLWTdnwZWrBHcklppEiQ7YEhAK6BTLP0uOCBrhuvSMZ03FqSkJYFc6ZlJixQbq8eMdqjL3OS63Yh7EwWNL4B1G5nZwAto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406097; c=relaxed/simple;
	bh=RBHxbEbPrdDXGVgs9JAV6IdcubHw5Ps3pU1smttww4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ke/U+H8MY3ylSvy3U/yytkLonGV9B6Ew9QU2WxJQ5rx/Px1lLj6clM2uFeirgxQM9RNWJLoF4Qi3aXcPnAbBoCtj/FctF+ordXKqxU0pvxrqVOx6ZKwVXtltg02IL2ezNUjfwtOIeUOlT/Yel/Z/Dtv4QpVC6Gz6SPqTPGRLn9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8477CC0005;
	Mon,  3 Jun 2024 09:14:50 +0000 (UTC)
Message-ID: <b199fde6-c24e-4c18-9c38-fdc923294551@ghiti.fr>
Date: Mon, 3 Jun 2024 11:14:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Masahiro Yamada <masahiroy@kernel.org>
References: <20240531162327.2436962-1-jesse@rivosinc.com>
 <20240531-uselessly-spied-262ecf44e694@spud>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240531-uselessly-spied-262ecf44e694@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Conor,

On 31/05/2024 19:31, Conor Dooley wrote:
> On Fri, May 31, 2024 at 12:23:27PM -0400, Jesse Taube wrote:
>> Dectect the Zkr extension and use it to seed the kernel base address.
>>
>> Detection of the extension can not be done in the typical fashion, as
>> this is very early in the boot process. Instead, add a trap handler
>> and run it to see if the extension is present.
> You can't rely on the lack of a trap meaning that Zkr is present unless
> you know that the platform implements Ssstrict. The CSR with that number
> could do anything if not Ssstrict compliant, so this approach gets a
> nak from me. Unfortunately, Ssstrict doesn't provide a way to detect
> it, so you're stuck with getting that information from firmware.


FYI, this patch is my idea, so I'm the one to blame here :)


>
> For DT systems, you can actually parse the DT in the pi, we do it to get
> the kaslr seed if present, so you can actually check for Zkr. With ACPI
> I have no idea how you can get that information, I amn't an ACPI-ist.


I took a look at how to access ACPI tables this early when implementing 
the Zabha/Zacas patches, but it seems not possible.

But I'll look into this more, this is not the first time we need the 
extensions list very early and since we have no way to detect the 
presence of an extension at runtime, something needs to be done.

Thanks,

Alex


>
> Thanks,
> Conor.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

