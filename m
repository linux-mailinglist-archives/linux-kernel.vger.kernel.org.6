Return-Path: <linux-kernel+bounces-321129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084BF9714F3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BBE284EE7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F501B3F08;
	Mon,  9 Sep 2024 10:10:25 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59B61B374E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876624; cv=none; b=QU//VLpLn61YOJGOY/TlQubS7KnMYoaXffHxWnfIgcK2ANuzUvum24xiOn+7cmQNgnODqIuefd+u4kYzk81EhnJ8m6YV8MZWKesbaT/rGxpeGePfiB9kIC78CG/beNcIHbXBSb6wvdOPkkLGiVFJjy0QiLbtAzBDMse2DROj9tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876624; c=relaxed/simple;
	bh=o4kDfNrXagWFom9Cl2AjkAUgmr7hZtDQL8OP/RNhBLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0rVmM1tXnInE+qDEwuPdnX0fkvkA9Vk+eNMq7+iWG/OJx5d0w0MPjUP32kd+/SKI79KOqgsNVl86kS96CI9oQv5XG7LVk9Sbk1wBoobG6Ntj2jOK5mRgNH/pMimNPyr8KbFZinHwEJhspVn/t+TnjxlseD5awUJyDuttM4zBGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3434660011;
	Mon,  9 Sep 2024 10:10:17 +0000 (UTC)
Message-ID: <03808c3d-1f19-4ef7-ab76-4219e1e66ed8@ghiti.fr>
Date: Mon, 9 Sep 2024 12:10:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Remove duplicated GET_RM
Content-Language: en-US
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chunyan Zhang <zhang.lyra@gmail.com>
References: <20240909095557.446745-1-zhangchunyan@iscas.ac.cn>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240909095557.446745-1-zhangchunyan@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Chunyan,

On 09/09/2024 11:55, Chunyan Zhang wrote:
> The macro GET_RM defined twice in this file, one can be removed.
>
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---
>   arch/riscv/kernel/traps_misaligned.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index b62d5a2f4541..2a9b72dcd648 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -136,8 +136,6 @@
>   #define REG_PTR(insn, pos, regs)	\
>   	(ulong *)((ulong)(regs) + REG_OFFSET(insn, pos))
>   
> -#define GET_RM(insn)			(((insn) >> 12) & 7)
> -
>   #define GET_RS1(insn, regs)		(*REG_PTR(insn, SH_RS1, regs))
>   #define GET_RS2(insn, regs)		(*REG_PTR(insn, SH_RS2, regs))
>   #define GET_RS1S(insn, regs)		(*REG_PTR(RVC_RS1S(insn), 0, regs))


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


