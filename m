Return-Path: <linux-kernel+bounces-302937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B673960548
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306721F229AE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A561199FCE;
	Tue, 27 Aug 2024 09:13:24 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720FF198A34
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750003; cv=none; b=Ezr3ChPTW+WQQlVN28Mdwkk33dBNLv3+i8Q/jf3QiDYTGzRhyNlXzVYJI9qH7tbcQvl4i7lR4hh6JcoyTP4Dn1EDZriR5yi3N2T/aRjtY0kjUsIlaiTreAYdLWyZw6dnC8sMhchyDFHUi9DgaWl6Jp9J35oA4GLiReJeysHBVIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750003; c=relaxed/simple;
	bh=FUslb9QoNs8bwpKsnfdTUotKs1LxMcU8ckg6eX0w7YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8KKY9yQoJYVn0cF9R267vn8V0ZPLQMdsuyKdFkV5rH/QlzCCj6M2rduI0aFORDB7/BM7IKFhfQXUzchKaouxVu6r/lqlAargoR827MiJGObhtaXZ+t/G2RI04qZQR3cxysq/eNFIpOlTsKH5Xs21Ra2EiRbodtm1vCvdUwkQeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 35520C000A;
	Tue, 27 Aug 2024 09:13:17 +0000 (UTC)
Message-ID: <14d633c5-804b-4be9-8329-751a2ac08c7a@ghiti.fr>
Date: Tue, 27 Aug 2024 11:13:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes] riscv: Fix RISCV_ALTERNATIVE_EARLY
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240826105737.106879-1-alexghiti@rivosinc.com>
 <20240827-striving-dispute-19b6cf97139b@spud>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240827-striving-dispute-19b6cf97139b@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Conor,

On 27/08/2024 10:38, Conor Dooley wrote:
> On Mon, Aug 26, 2024 at 12:57:37PM +0200, Alexandre Ghiti wrote:
>> RISCV_ALTERNATIVE_EARLY will issue sbi_ecall() very early in the boot
>> process, before the first memory mapping is setup so we can't have any
>> instrumentation happening here.
>>
>> In addition, when the kernel is relocatable, we must also not issue any
>> relocation this early since they would have been patched virtually only.
>>
>> So, instead of disabling instrumentation for the whole kernel/sbi.c file
>> and compiling it with -fno-pie, simply move __sbi_ecall() and
>> __sbi_base_ecall() into their own file where this is fixed.
> IOW, this should fix the issue that we discussed here
> https://lore.kernel.org/linux-riscv/abec162e-f3f2-488c-83d9-be17257a5df8@ghiti.fr/
> also?


Yes, as a side effect it also fixes TRACEPOINTS + [KASAN|RELOCATABLE] as 
I reported in this thread since I moved the tracepoints in a file where 
instrumentation is disabled and compiled with no-pie.


> I'm sorry I didn't get to test that yet, we had some pretty bad IT
> issues in the office the last weeks and I have been avoiding going
> there. I'll try to test this one instead..
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

