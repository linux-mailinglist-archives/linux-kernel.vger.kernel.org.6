Return-Path: <linux-kernel+bounces-561492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 778C3A612A3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B828188CA96
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA32F1FFC55;
	Fri, 14 Mar 2025 13:28:45 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5711FFC46
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958925; cv=none; b=nYFSnz9x9teUpOfDqfsD1iauVYcl1vfcmgdjEuIbE+RsYZrSz2wXCsSi+I2TDJdni/HSFqKWw8xBvz2Hfs378uk7hkqgkqzhTRtxNpAtaNxq9zK2oRZ4Se1pXTEzVLMjho3fe0ibWDgsOee4ymwlZhJBg5mV04Dbms+ypMHKJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958925; c=relaxed/simple;
	bh=8uDIjj7n3Y2XMNmO7hPZ5YbenfmMmfvy/g7Rjg8/egg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Txk3QnpI+9iuR8q0ccOogFiaN2mTKUO7roYpL/MjAmBFn4d6Eb8R3J4D7yDnh00YxLXtwd+Oi5rG8pVfVQ66pVTWmDel38uUXcbB7nloPFDohtKYm0Zwj7xYqYbV8dkHXHI82CpxdcTo1dF/pAN5/Da57jxfy36qhs2sHt3ReL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA90D42FF4;
	Fri, 14 Mar 2025 13:28:38 +0000 (UTC)
Message-ID: <4f6c83c0-39f6-467d-83c6-13d37440fb20@ghiti.fr>
Date: Fri, 14 Mar 2025 14:28:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] riscv: uaccess: optimizations
Content-Language: en-US
To: Cyril Bur <cyrilbur@tenstorrent.com>, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, paul.walmsley@sifive.com, charlie@rivosinc.com,
 jrtc27@jrtc27.com, ben.dooks@codethink.co.uk
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 jszhang@kernel.org
References: <20250221000924.734006-1-cyrilbur@tenstorrent.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250221000924.734006-1-cyrilbur@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpefhhfdutdevgeelgeegfeeltdduhfduledvteduhfegffffiefggfektefhjedujeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemugehrgefmeehsgeisgemuggvfhekmeeltdguvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemugehrgefmeehsgeisgemuggvfhekmeeltdguvgdphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemugehrgefmeehsgeisgemuggvfhekmeeltdguvggnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheptgihrhhilhgsuhhrsehtvghnshhtohhrrhgvnhhtrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtohepr
 ghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehjrhhttgdvjeesjhhrthgtvdejrdgtohhmpdhrtghpthhtohepsggvnhdrughoohhkshestghouggvthhhihhnkhdrtghordhukhdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi Cyril,

On 21/02/2025 01:09, Cyril Bur wrote:
> This series tries to optimize riscv uaccess by allowing the use of
> user_access_begin() and user_access_end() which permits grouping user accesses
> and avoiding the CSR write penalty for each access.
>
> The error path can also be optimised using asm goto which patches 3 and 4
> achieve. This will speed up jumping to labels by avoiding the need of an
> intermediary error type variable within the uaccess macros
>
> I did read the discussion this series generated. It isn't clear to me
> which direction to take the patches, if any.
>
> V2:
> I've taken on this series as there isn't any response from Jisheng. No
> significant changes other than build fixes.
> - Fixes build breakage in patch 3 to do with not having used 'goto' keyword.
> - Fixes build breakage in patch 4 on 32bit not having delcared __ptr in the
>    macro.
>
> V3:
> Significant commit message rewrites.
>   - Corrected the justification for patch 2
>   - Better explained/justified patches 3 and 4
> Minor code changes for legibility and more comments.
>
> Jisheng Zhang (4):
>    riscv: implement user_access_begin() and families
>    riscv: uaccess: use input constraints for ptr of __put_user()
>    riscv: uaccess: use 'asm goto' for put_user()
>    riscv: uaccess: use 'asm_goto_output' for get_user()
>
>   arch/riscv/include/asm/uaccess.h | 205 +++++++++++++++++++++++--------
>   1 file changed, 152 insertions(+), 53 deletions(-)
>
Following up on Ben's comment here 
https://lore.kernel.org/linux-riscv/b45aab1e-6d37-4027-9a15-4fa917d806b9@codethink.co.uk/

The problem that Ben mentions is caused by the use of *macros* which 
used to make the evaluation of the parameter inside the user-accessible 
section, and since this parameter could be a sleeping function, we could 
schedule another process with the SUM bit set, which could be cleared by 
this process, which would make the first process fault when trying to 
access user memory. I did not find any macro using unsafe_XXX() 
functions which could cause a problem right now, but I may have missed 
one and new could come up later, so we have multiple solutions here:

- suppose that a macro using unsafe_get/put_user() and passing a 
sleeping function as argument won't happen and then do nothing
- or save/restore CSR sstatus when switching processes
- or simply check that SUM is not set when switching processes

Let me know what you think.

Thanks,

Alex


