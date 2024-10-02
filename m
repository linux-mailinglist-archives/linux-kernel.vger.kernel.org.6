Return-Path: <linux-kernel+bounces-347312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D8798D0DE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788EA1C21693
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E033E1E5016;
	Wed,  2 Oct 2024 10:10:13 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47D81FA5
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863813; cv=none; b=Y9qKmiK5IvN6UYle4ZKlxACOpTQfjcl1eZEVAsLFhwVl4M9YQEqeFjIrY5DQXdePrwPRfd8sPi9jT+5QVRQcbH40lJec6QrS+HEh/SACNPUr8jmJQEOkzvtyNvjjMrELvqxium/E8UcpvPtKb3v8ZxJS8z427dKi5dJW3wAjOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863813; c=relaxed/simple;
	bh=VfxSrCHikBJVa+joseSpNSXvYw8e0tCwauA7BT/i5SA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMSq1yflWaT7zJpdUjspuPFTa8pcvvtaGL5NQ/AnlcKK0Nn5dGK3nFKokCSdSR0w+Hi6brzUbDOhzxjTYaBoMVAx/jNB3AfvL3IuC0+p0PhY8CL/u9Ab6jA2Cz9Pw9ubKVFMdsbyvLLGwGSn8hItaetG5RSh3dKo5i43JOyCQfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XJVt93Qntz9sPd;
	Wed,  2 Oct 2024 12:10:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AAxfHpw7w94M; Wed,  2 Oct 2024 12:10:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XJVt92cCwz9rvV;
	Wed,  2 Oct 2024 12:10:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 47F118B766;
	Wed,  2 Oct 2024 12:10:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 5qsxC_p6Tauv; Wed,  2 Oct 2024 12:10:09 +0200 (CEST)
Received: from [192.168.233.39] (unknown [192.168.233.39])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CECCE8B763;
	Wed,  2 Oct 2024 12:10:08 +0200 (CEST)
Message-ID: <368e38d3-5883-4192-b9cf-f66d0f558528@csgroup.eu>
Date: Wed, 2 Oct 2024 12:10:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] powerpc/vdso: Add a page for non-time data
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Jason@zx2c4.com
References: <0557d3ec898c1d0ea2fc59fa8757618e524c5d94.1727858295.git.christophe.leroy@csgroup.eu>
 <20241002104334-b655500b-901b-42db-a2c8-582e10826889@linutronix.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241002104334-b655500b-901b-42db-a2c8-582e10826889@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 02/10/2024 à 10:54, Thomas Weißschuh a écrit :
> [Vous ne recevez pas souvent de courriers de thomas.weissschuh@linutronix.de. D?couvrez pourquoi ceci est important ? https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Christophe,
> 
> On Wed, Oct 02, 2024 at 10:39:28AM GMT, Christophe Leroy wrote:
>> The page containing VDSO time data is swapped with the one containing
>> TIME namespace data when a process uses a non-root time namespace.
>> For other data like powerpc specific data and RNG data, it means
>> tracking whether time namespace is the root one or not to know which
>> page to use.
>>
>> Simplify the logic behind by moving time data out of first data page
>> so that the first data page which contains everything else always
>> remains the first page. Time data is in the second or third page
>> depending on selected time namespace.
>>
>> While we are playing with get_datapage macro, directly take into
>> account the data offset inside the macro instead of adding that offset
>> afterwards.
> 
> FYI
> 
> I am currently working on a series to unify the storage of the
> VDSO data for most architectures, including powerpc.
> This will also include a dedicated rng data page.
> 
> That generic infrastructure would replace the need for Patch 1.
> Obviously, if your series gets applied, I can adapt mine for that.
> 
> If you are about to also modify other architectures in a similar way,
> we may want to coordinate.
> 

I'm not going to do anything on other architectures.

Indeed my patch is an outcome of the discussion at 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/ffd7fc255e194d1e2b0aa3d9d129e826c53219d4.1725611321.git.christophe.leroy@csgroup.eu/

I'm all fine if you are doing something generic for all architectures. 
For powerpc will it handle the entire non-time data, not only rng ? The 
purpose being to revert 
https://github.com/torvalds/linux/commit/c73049389e58c01e2e3bbfae900c8daeee177191

Christophe

