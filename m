Return-Path: <linux-kernel+bounces-403863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BFB9C3BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540CF1F230DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D017185B47;
	Mon, 11 Nov 2024 10:28:46 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47D0185E53
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731320925; cv=none; b=AzUpdDIKC6GJo5L2fCwYbQW6q5Z1Nj6KuEyaGnF37dJ1Ez02m13Dhw29PccHw8KYt6gcE5P5w6jBKh/V7kWhIj7m/2KwGE2tryx9flmQj576CIRCAp966SnzrZ2iHpL+g8tg0kRvK4oYg8sv1IxOY/tiYA486mX9zsWjPsId7TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731320925; c=relaxed/simple;
	bh=6rzlKBl+EskF4uspwIhBxRxNs0OCiY0HRy1wC9+e25o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7ml1uPhqJB7uIjw9CdUGpjVwXF1h5+iX5R9F/CNYU0ldgiIrFaVX1MYnHBELAZ7CGaYpG5SgeKtYa3d56fqr+opgu4GjRcnoN486xWZBc+3vrdUaeHXBjbXaB6yTFWr17iYyxfEv0I7m9vKDLdCNQRY+SAzwAWSk808Kb71ehY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D9621C0008;
	Mon, 11 Nov 2024 10:28:37 +0000 (UTC)
Message-ID: <26452229-7461-48aa-987a-28444ace4f28@ghiti.fr>
Date: Mon, 11 Nov 2024 11:28:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: add forwarding header for
 arch/riscv/include/asm/fence.h
Content-Language: en-US
To: Andreas Schwab <schwab@suse.de>
Cc: linux-riscv@lists.infradead.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrea Parri <parri.andrea@gmail.com>, linux-kernel@vger.kernel.org
References: <mvm5xq44bqh.fsf@suse.de>
 <d380fd10-ebc4-4d66-becb-13995372d41a@ghiti.fr> <mvmfrnyxg2n.fsf@suse.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <mvmfrnyxg2n.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Andreas,

On 11/11/2024 10:41, Andreas Schwab wrote:
> On Nov 04 2024, Alexandre Ghiti wrote:
>
>> Unless you have any objection, we'll try to make Bjorn's patch into
>> 6.12-rc7 instead of yours.
> It still fails the same:
>
> In file included from /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc7/linux-6.12-rc7/tools/include/asm/barrier.h:12,
>                   from /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc7/linux-6.12-rc7/tools/include/linux/ring_buffer.h:4,
>                   from libbpf.c:37:
> /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc7/linux-6.12-rc7/tools/include/asm/../../arch/riscv/include/asm/barrier.h:13:10: fatal error: asm/fence.h: No such file or directory
>     13 | #include <asm/fence.h>
>        |          ^~~~~~~~~~~~~
> compilation terminated.
> make[5]: *** [/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc7/linux-6.12-rc7/tools/build/Makefile.build:106: /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc7/linux-6.12-rc7/linux-obj/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf.o] Error 1
> make[5]: *** Waiting for unfinished jobs....
> make[4]: *** [Makefile:164: /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc7/linux-6.12-rc7/linux-obj/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf-in.o] Error 2
> make[3]: *** [Makefile:63: /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc7/linux-6.12-rc7/linux-obj/tools/bpf/resolve_btfids//libbpf/libbpf.a] Error 2
> make[2]: *** [Makefile:76: bpf/resolve_btfids] Error 2
> make[1]: *** [/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc7/linux-6.12-rc7/Makefile:1393: tools/bpf/resolve_btfids] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [../Makefile:224: __sub-make] Error 2
>

Indeed, Bjorn's patches did not make it into rc7...


