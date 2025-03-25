Return-Path: <linux-kernel+bounces-575044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E42A6ECD9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 449E67A5AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EB8255255;
	Tue, 25 Mar 2025 09:42:24 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688E0254AE5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895744; cv=none; b=QEYxFf/vul4QqAvL40+xlopUZRyReZORqO9NYNwoRE66z0S5ZUrDVla5AJd5E447CgqI2Onm4wK5UrLHbQrM9rwwPyqRnThHHi8VZzYuLJ6Onz0MsXt5Dmr+kbJ0Osw6GjiA7URK9gzeJhjYceIgtOy0CywmLExjEXBw//7FZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895744; c=relaxed/simple;
	bh=kR7mmVDXSQQ0ZbXlhrdwUB4b1sJSjGlMoaEuCDViCW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=POThAbG6B6PPWIKdWk5FqBV+Q0gt/3uX93kWL/m1d9t0N5ZmEgelR33UGjK2U8Lr/+lf89njgxoMrJsTJ9VfGUAoTcYaiSkOkLrXbYpGjIpL4a1J87Gp1VPu2jWJWA7B3AKmwOUEzwWaPuil+ciEWyaWfGZPNDmY8ylRnGe+T/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 18FF943423;
	Tue, 25 Mar 2025 09:42:15 +0000 (UTC)
Message-ID: <2453d5e6-cd47-4a4e-8636-3a1524be0589@ghiti.fr>
Date: Tue, 25 Mar 2025 10:42:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: traps: handle uprobe event in software-check
 exception
Content-Language: en-US
To: Zong Li <zong.li@sifive.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, debug@rivosinc.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250314092614.27372-1-zong.li@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250314092614.27372-1-zong.li@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepueefgeehheegtddvgeelgeejjeefudekgeetffeijefgveejudehfffftdelhffhnecukfhppeefuddrfedvrdekuddrudekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeefuddrfedvrdekuddrudekjedphhgvlhhopegludelvddrudeikedrvddurddvhegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepjedprhgtphhtthhopeiiohhnghdrlhhisehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtohepuggvsghughesrhhivhhoshhinhgtrdgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrr
 gguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi,

On 14/03/2025 10:26, Zong Li wrote:
> Handle the uprobe event first before handling the CFI violation in
> software-check exception handler. Because when the landing pad is
> activated, if the uprobe point is set at the lpad instruction at
> the beginning of a function, the system triggers a software-check
> exception instead of an ebreak exception due to the exception
> priority, then uprobe can't work successfully.
>
> Co-developed-by: Deepak Gupta <debug@rivosinc.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>
> This patch is based on top of the following series
> [PATCH v11 00/27] riscv control-flow integrity for usermode
>
>   arch/riscv/kernel/traps.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 3f7709f4595a..ef5a92111ee1 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -386,9 +386,12 @@ asmlinkage __visible __trap_section void do_trap_software_check(struct pt_regs *
>   	if (user_mode(regs)) {
>   		irqentry_enter_from_user_mode(regs);
>   
> -		/* not a cfi violation, then merge into flow of unknown trap handler */
> -		if (!handle_user_cfi_violation(regs))
> -			do_trap_unknown(regs);
> +		/* handle uprobe event frist */
> +		if (!probe_breakpoint_handler(regs)) {
> +			/* not a cfi violation, then merge into flow of unknown trap handler */
> +			if (!handle_user_cfi_violation(regs))
> +				do_trap_unknown(regs);
> +		}
>   
>   		irqentry_exit_to_user_mode(regs);
>   	} else {


Deepak, can you take this patch in your next spin of your CFI series? 
Otherwise, I'm pretty sure we will forget about it :)

Thanks,

Alex


