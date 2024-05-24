Return-Path: <linux-kernel+bounces-189074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D76C8CEAB1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 22:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6645AB2148C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F0E6FE16;
	Fri, 24 May 2024 20:07:52 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114443D0C5
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716581272; cv=none; b=lKVWqjVT/g4+r1ClxEFC9oE8rtpf+T7kEm2EO1fN0EozSzKaetGuHCDIx5TICsse8zY1rBMEZPgzNi/AtJCBAuiv3KRRIQF53jh09B5JFp7BJzvXqoDc/dr058X6gw3rOzxPLa3RLexOrDDb0Osj237doCTO+uTrvmrJjOJhEzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716581272; c=relaxed/simple;
	bh=Zp3FRRxd0wt0czjSGF99QfwIwMQpolF1rDHfd4FWYeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBfVZZnlYMMA9ZZSw36A5QSeUfS2tl7a3Nox4vYbiALBt2HDn5L/8F8PnF899SceYy1seYvBJ2cr9XZIv/8orBHNbFNnK3LFIN6HOuLOfSXtk/twWWLWYGuJ0cYJFLiVJEF15priKoN1MCJVcqq14jl0It7/OI0g5SuYwL4aE48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id C78AA1BF203;
	Fri, 24 May 2024 20:07:40 +0000 (UTC)
Message-ID: <8b741144-8a3c-4a4c-bb3f-dfab4aa8e576@ghiti.fr>
Date: Fri, 24 May 2024 22:07:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Don't use hugepage mappings for vmemmap if it's
 not supported
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240508173116.2866192-1-namcao@linutronix.de>
 <43829e94-98ae-46a4-a3e6-dbabbe94d7c1@ghiti.fr>
 <20240508184641.WP8ok_Hg@linutronix.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240508184641.WP8ok_Hg@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Nam,

On 08/05/2024 20:46, Nam Cao wrote:
> On Wed, May 08, 2024 at 08:22:43PM +0200, Alexandre Ghiti wrote:
>> Hi Nam,
> Hi Alex,
>
>>> Commit ff172d4818ad ("riscv: Use hugepage mappings for vmemmap") broke XIP
>>> kernel, because huge pages are not supported on XIP kernel.
>> I don't understand why XIP kernels can't support huge vmalloc mappings,
> Me neither.
>
>> so I
>> think the right fix would be to enable such mappings on XIP. WDYT?
> I agree that is the ideal solution. But I don't want to send any new
> feature to the stable trees (stable folks may even reject such patch).
> So I intend that to be in another patch.


I have been thinking about that, and I actually think that the real fix 
is enabling huge vmalloc mappings for XIP as it was an oversight/mistake 
in the first place. On 64-bit kernels, there are no reasons we can't use 
PMD mappings for vmalloc. So I'd rather not go with this fix.

Thanks,

Alex


>
> Best regards,
> Nam

