Return-Path: <linux-kernel+bounces-550719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6809A56341
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD4E3A807E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873201E1E11;
	Fri,  7 Mar 2025 09:09:03 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E211E1DEA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338543; cv=none; b=WKYTsFBuj0yOS5BPMYJ2U4NqkhGHcVbXCTvTPSxycMTycWhsnBI9on825zMqonNB8LqIXqyB25mmM8CfvpLeWN10Va8eO8ghlT9uKjE0I3hl7apegBVAGoAXK6DBWBj9V+41rbTVDjntj3haNOGe2n146UJdlSSnGztE1PIqwio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338543; c=relaxed/simple;
	bh=2jgWG9QbwNaLnCAQWNSdI3o+GvnyRoUpqPGzbjTm2y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mb82KkLd8TE9OtU3YPdinQWEvGK8G7H6XQKw5Y2u99RYs9/F/xKlvBwL78pC7uMh4dZbkLr4rHXGeBWoss6nvwj3w6wplOI5C05x8SbrR/AJk4PFvdqtfKxr1qp/1+cJ3TVnKsFHQVLN/HU4IiSCnNXbdUbqXARr8nrhAKyiPvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F71A43147;
	Fri,  7 Mar 2025 09:08:56 +0000 (UTC)
Message-ID: <d76f62d5-b461-4bff-baa7-62d0eabbf2cd@ghiti.fr>
Date: Fri, 7 Mar 2025 10:08:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [resend PATCH] riscv: fix memory leakage in
 process_accumulated_relocations
To: laokz <zhangkai@iscas.ac.cn>, Walmsley <paul.walmsley@sifive.com>,
 Dabbelt <palmer@dabbelt.com>, Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
References: <a9058ac757636e4f5160a0bd11abeb3c111fc9a5.camel@iscas.ac.cn>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <a9058ac757636e4f5160a0bd11abeb3c111fc9a5.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepuefffedvleetleetjefhjeehudejteetvedtvddvtdfhieetffelvdffgefgieeinecuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgnecukfhppeeghedrudeftddrvdefkedrudekfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeghedrudeftddrvdefkedrudekfedphhgvlhhopegludelvddrudeikedrheehrdduheefngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepiihhrghnghhkrghisehishgtrghsrdgrtgdrtghnpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhto
 heplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi Kai,

On 16/11/2024 13:07, laokz wrote:
> Sorry for last weird email.
> ---
>
> When module relocation is done, process_accumulated_relocations()
> frees all dynamic allocated memory. rel_head_iter->rel_entry is
> missed to free that kmemleak might report:
>
> unreferenced object 0xffffffd880c5fc40 (size 16):
>    comm "insmod", pid 1101, jiffies 4295045138
>    hex dump (first 16 bytes):
>      e0 c0 f5 87 d8 ff ff ff 60 c5 f5 87 d8 ff ff ff  ........`.......
>    backtrace (crc d2ecb20c):
>      [<00000000b01655f6>] kmalloc_trace_noprof+0x268/0x2f6
>      [<000000006dc0067a>]
> add_relocation_to_accumulate.constprop.0+0xf2/0x1aa
>      [<00000000e1b29a36>] apply_relocate_add+0x13c/0x36e
>      [<000000007543f1fb>] load_module+0x5c6/0x83e
>      [<00000000abce12e8>] init_module_from_file+0x74/0xaa
>      [<0000000049413e3d>] idempotent_init_module+0x116/0x22e
>      [<00000000f9b98b85>] __riscv_sys_finit_module+0x62/0xae
>
> Signed-off-by: Kai Zhang <zhangkai@iscas.ac.cn>
> ---
>   arch/riscv/kernel/module.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 1cd461f3d87..f8c3c4b47dc 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -643,6 +643,7 @@ process_accumulated_relocations(struct module *me,
>                          }
>                          reloc_handlers[curr_type].accumulate_handler(
>                                  me, location, buffer);
> +                       kfree(rel_head_iter->rel_entry);
>                          kfree(rel_head_iter);
>                  }
>                  kfree(bucket_iter);
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


This patch is not relevant anymore since commit 03f0b548537f ("riscv: 
module: remove relocation_head rel_entry member allocation") which 
turned the dynamic allocation of rel_entry into a static allocation.

Thanks anyway Kai, that was a good catch.

Alex


