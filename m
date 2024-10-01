Return-Path: <linux-kernel+bounces-345847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D778C98BBCE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262FA284565
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED801C1AB6;
	Tue,  1 Oct 2024 12:08:30 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361931A0AEA
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727784510; cv=none; b=mcfNGMnt/PfYdhChiWaiiIOyj30JIkxWEH7e5dPMnYOg6KmwLC2v78RKIM4B88Cw9tpbYFJVqefO6bLoK14tmxd1tvh57+ceDVnxZQ/zGp4arM9kEXvVgRhr02USgx1BSs5qjQPfuws/x+9e9AIHopBCZLbSlpoH1NE5oMUt3jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727784510; c=relaxed/simple;
	bh=JXuAyP5rwFYDM4e4eX1ibFV2ysuNy6TVwylSJoO7+a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSC1k2aavxhHr6woqrtN9fuY1DYQFX12GurFIbpAzlf9iWe5AIU9X6UGPTjAcyjtX/xDHwwtgeW8lzJmGZMA3mwVGoCRPhfPeMkGj7//cPmHm9AoX8Ss4CtNZWl8mx3Ivc8p0dmG/ysNtrGtrGmjJ+QcJDKGwcs8KzqnGkVVgmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XHxXz5KvCz9sRk;
	Tue,  1 Oct 2024 14:08:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CpCsvAqWB3yv; Tue,  1 Oct 2024 14:08:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XHxXz4XmTz9sPd;
	Tue,  1 Oct 2024 14:08:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 87E3E8B770;
	Tue,  1 Oct 2024 14:08:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id CYV2A-JBknUu; Tue,  1 Oct 2024 14:08:19 +0200 (CEST)
Received: from [192.168.232.216] (unknown [192.168.232.216])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A15B8B766;
	Tue,  1 Oct 2024 14:08:19 +0200 (CEST)
Message-ID: <8e6c75db-5c98-4f82-8151-5f86c53f4cf2@csgroup.eu>
Date: Tue, 1 Oct 2024 14:08:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] powerpc/sstep: Unexport analyze_instr,
 emulate_vsx_load, emulate_vsx_store
To: Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Paul Mackerras <paulus@ozlabs.org>, linux-kernel@vger.kernel.org
References: <8ecdbd907a8a92cbf9c7308df13f9d19f5ba5621.1727777273.git.msuchanek@suse.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <8ecdbd907a8a92cbf9c7308df13f9d19f5ba5621.1727777273.git.msuchanek@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 01/10/2024 à 12:08, Michal Suchanek a écrit :
> There is no modular user of analyze_instr, and the latter two are only
> used by sstep itself.

analyze_instr() is used in arch/powerpc/kvm/emulate_loadstore.c which 
can be a module as far as I can see in Makefile:

common-objs-y += powerpc.o emulate_loadstore.o

kvm-book3s_64-module-objs := \
	$(common-objs-y) \
	book3s.o \
	book3s_rtas.o \
	$(kvm-book3s_64-objs-y)

kvm-objs-$(CONFIG_KVM_BOOK3S_64) := $(kvm-book3s_64-module-objs)

config KVM_BOOK3S_64
	tristate "KVM support for PowerPC book3s_64 processors"


> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>   arch/powerpc/lib/sstep.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index e65f3fb68d06..a0557b0d9a24 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -863,7 +863,6 @@ void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
>   		break;
>   	}
>   }
> -EXPORT_SYMBOL_GPL(emulate_vsx_load);
>   NOKPROBE_SYMBOL(emulate_vsx_load);
>   
>   void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
> @@ -955,7 +954,6 @@ void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
>   		break;
>   	}
>   }
> -EXPORT_SYMBOL_GPL(emulate_vsx_store);
>   NOKPROBE_SYMBOL(emulate_vsx_store);
>   
>   static nokprobe_inline int do_vsx_load(struct instruction_op *op,
> @@ -3172,7 +3170,6 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
>   	op->val = SRR1_PROGTRAP;
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(analyse_instr);
>   NOKPROBE_SYMBOL(analyse_instr);
>   
>   /*

