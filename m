Return-Path: <linux-kernel+bounces-176925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4348C3729
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 17:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DC6DB20DAC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 15:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7BD45BEF;
	Sun, 12 May 2024 15:47:47 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180BE3F8F1
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715528867; cv=none; b=TPxYGG4waZNp1ZADCFrNiB+noM37xrAbnGglQC9kNraJJ+YHgIVyHnJ93IKieWhFFo95MEpAnZL6lejOUCTfxvjdDhC4MIYcZYNBaCOUOt1d+lU/CdGKu37c3koH0aa5m4ZS2ldeBovWFqWO315Fv6GaojcJie74Kti1xLzzToI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715528867; c=relaxed/simple;
	bh=JZCbtyH96U3ULD5+dHXMU9zi+LK4H2q6LB1Ry8GqQwc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=NvMghtVp5rY/aZdvBgJqQHDTsfh7a9Uh08ahuImzXkWMJrHgPo4yijRUSlwpYLvEqQCVtRa2r/PTY82NSLuDYvaoAZM/rrURZNN+Lwtmn33XtAjBPlpCku4ZwrjGrYMV1cmb01ZRaVZyLFCHY4ikiWnbWTyyw23Kd67klPWtuH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03BA41C0004;
	Sun, 12 May 2024 15:47:28 +0000 (UTC)
Message-ID: <46c70799-87b1-4478-95bb-4d4c90519f5b@ghiti.fr>
Date: Sun, 12 May 2024 17:47:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH 0/7] remove size limit on XIP kernel
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1715286093.git.namcao@linutronix.de>
Content-Language: en-US
In-Reply-To: <cover.1715286093.git.namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Nam,

On 10/05/2024 08:28, Nam Cao wrote:
> Hi,
>
> For XIP kernel, the writable data section is always at offset specified in
> XIP_OFFSET, which is hard-coded to 32MB.
>
> Unfortunately, this means the read-only section (placed before the
> writable section) is restricted in size. This causes build failure if the
> kernel gets too large.
>
> This series remove the use of XIP_OFFSET one by one, then remove this
> macro entirely at the end, with the goal of lifting this size restriction.
>
> Also some cleanup and documentation along the way.
>
> This series depends on
>      https://lore.kernel.org/linux-riscv/20240508191917.2892064-1-namcao@linutronix.de/
> to apply cleanly, and also depends on
>      https://lore.kernel.org/linux-riscv/20240508173116.2866192-1-namcao@linutronix.de/
> which fixes a boot issue.
>
> Best regards,
> Nam
>
> Nam Cao (7):
>    riscv: cleanup XIP_FIXUP macro
>    riscv: replace va_kernel_pa_offset with va_kernel_data_pa_offset on
>      XIP
>    riscv: drop the use of XIP_OFFSET in XIP_FIXUP_OFFSET
>    riscv: drop the use of XIP_OFFSET in XIP_FIXUP_FLASH_OFFSET
>    riscv: drop the use of XIP_OFFSET in kernel_mapping_va_to_pa()
>    riscv: drop the use of XIP_OFFSET in create_kernel_page_table()
>    riscv: remove limit on the size of read-only section for XIP kernel
>
>   arch/riscv/include/asm/page.h       | 25 ++++++++++++++++++------
>   arch/riscv/include/asm/pgtable.h    | 18 +++++++----------
>   arch/riscv/include/asm/xip_fixup.h  | 30 +++++++++++++++++++++++------
>   arch/riscv/kernel/vmlinux-xip.lds.S |  4 ++--
>   arch/riscv/mm/init.c                | 11 +++++++----
>   5 files changed, 59 insertions(+), 29 deletions(-)
>

XIP kernels are intended for use with flash devices so the XIP_OFFSET 
restriction actually represents the size of the flash device: IIRC this 
32MB was chosen because it would fit "most devices". I think it would be 
good to come up with a mechanism that allows to restrict the size at 
build time: a config? XIP kernels are custom kernels so the user could 
enter its flash size so that if kernel ends up being too large, it 
fails. And by default, we could a very large size to avoid kernel test 
robot build failures.

Thanks,

Alex


