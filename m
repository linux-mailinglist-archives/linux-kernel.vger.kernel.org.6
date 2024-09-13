Return-Path: <linux-kernel+bounces-328155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA75977FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844F21C209D4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD621D9324;
	Fri, 13 Sep 2024 12:15:50 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918781C1AC2
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229750; cv=none; b=ZCHLPdtxuXR/xtSvepljVMmsfukANMI3A/jn/iSQaT67XV4gAnZJ168TA6g2LlzNoZgsj4qOXTtPNWUs8Y0PioNo1sDdJFHGsVnIxpLY3AyYHXEyiGpRWk2cR8u78xcnFa/eKqr3it384jFvu4yjolhfL7PfStotS7ZhOb2mWRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229750; c=relaxed/simple;
	bh=bIIXpFBcy9JQN6Eq1rXBhck4SQov32Ei9qIPZHwLGC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUdg9EYaz1CndWa6mP6gW4neqQFVeuSmlUH3pRbzNBFlAv5v1U+bnlFDFHWm/WO7PnSVlAT97szd4ZuPmkd8p8OnNYw5A2X3lOo7foKtlEAi6J9jwr33nVGPGpBcxrycN8NzbKDXJx3d1Xl01KOiWQMUkWi3Hquvg61SUz6K7V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X4tYm6ccqz9sfV;
	Fri, 13 Sep 2024 14:15:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XiImRg9SP39k; Fri, 13 Sep 2024 14:15:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X4tYm5mBbz9sZX;
	Fri, 13 Sep 2024 14:15:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B657B8B77A;
	Fri, 13 Sep 2024 14:15:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id lNQyLDOf4yiZ; Fri, 13 Sep 2024 14:15:40 +0200 (CEST)
Received: from [192.168.233.70] (unknown [192.168.233.70])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5D3688B766;
	Fri, 13 Sep 2024 14:15:40 +0200 (CEST)
Message-ID: <81200b50-eaec-4cfd-9121-f661f3065572@csgroup.eu>
Date: Fri, 13 Sep 2024 14:15:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] powerpc/entry: convert to common and generic entry
To: Luming Yu <luming.yu@shingroup.cn>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au, npiggin@gmail.com, jialong.yang@shingroup.cn,
 luming.yu@gmail.com
References: <B4ABABEA5F13B86A+20240912082500.1469-1-luming.yu@shingroup.cn>
 <fc509bcd-5ca0-4dc2-962e-766a01cbe4fb@csgroup.eu>
 <153FD6B5CE4F97D9+ZuOYDQ-iHIIwJjbh@HX09040029.powercore.com.cn>
 <95ced963-b584-4ccf-ba34-8f2ba99172f4@csgroup.eu>
 <0332BAE1905768B6+ZuPsBvgv0nwmFAjW@HX09040029.powercore.com.cn>
 <854eef54-4779-4233-a958-0c98ae5fcb7e@csgroup.eu>
 <F81D1486B7B82141+ZuQp4YQkAA2cB9Rw@HX09040029.powercore.com.cn>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <F81D1486B7B82141+ZuQp4YQkAA2cB9Rw@HX09040029.powercore.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/09/2024 à 14:02, Luming Yu a écrit :

>> ...
>> nothing happens after that.
> reproduced with ppc64_defconfig
> [    0.818972][    T1] Run /init as init process
> [    5.851684][  T240] request_module: modprobe binfmt-4c46 cannot be processed, kmod busy with 50 threads for more than 5 seconds now
> [    5.851742][  T240] kworker/u33:18 (240) used greatest stack depth: 13584 bytes left
> [    5.860081][  T232] kworker/u33:16 (232) used greatest stack depth: 13072 bytes left
> [    5.863145][  T210] kworker/u35:13 (210) used greatest stack depth: 12928 bytes left
> [    5.865000][    T1] Failed to execute /init (error -8)
> [    5.868897][    T1] Run /sbin/init as init process
> [   10.891673][  T315] request_module: modprobe binfmt-4c46 cannot be processed, kmod busy with 50 threads for more than 5 seconds now
> [   10.894036][    T1] Starting init: /sbin/init exists but couldn't execute it (error -8)
> [   10.901455][    T1] Run /etc/init as init process
> [   10.903154][    T1] Run /bin/init as init process
> [   10.904747][    T1] Run /bin/sh as init process
> [   15.931679][  T367] request_module: modprobe binfmt-4c46 cannot be processed, kmod busy with 50 threads for more than 5 seconds now
> [   15.934689][    T1] Starting init: /bin/sh exists but couldn't execute it (error -8)

That's something different, this is because you built a big-endian 
kernel and you are trying to run a little-endian userspace.

Does it work with ppc64le_defconfig ?

On my side there is absolutely nothing happening after the last line, 
the screen remains steady.


Christophe

