Return-Path: <linux-kernel+bounces-267676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C27094142E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82336B284F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0078F1A2C16;
	Tue, 30 Jul 2024 14:17:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877361A2554
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349064; cv=none; b=rWskjUEcPs9TGhlRRkNZNJrFMkmg4eYRwYL4GGrf7V0mwOr9HCAG5CmkZYb0qGHgoGZrPPWoUPDRTfXG02KfsbVkQ9evLrSzrI4oYu7moPc293ndwcaNzuBcOPIQ6U8bRZe+mN1unxB+XF3KE00ulTx7AJeDHxbkBHEQkmOuHCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349064; c=relaxed/simple;
	bh=nvcNOzRoAf7FeIn+zLFySCEXj8MUOpjhYWAKoZJ7GCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWA6Mth8+zAb3ZtvxPnwQXdliJi9UX+t8dM3oAovnNIswkZP/bkRHV8+ymzbSk8HcmTb1s7XMguREnti/LCz9BNdL7t5dvXFxau/tRyjgaf44ARsywXPlsFzZ8fJn/rcz1MF40EUpUtSnRUetI8PJ2moVjOtNJ2ZDoqDTqwyHyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900F5C32782;
	Tue, 30 Jul 2024 14:17:42 +0000 (UTC)
Date: Tue, 30 Jul 2024 15:17:40 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
	Chen Jun <chenjun102@huawei.com>,
	Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	kernel@openvz.org
Subject: Re: [PATCH 2/2] kmemleak-test: add percpu leak
Message-ID: <Zqj2BBgAIDb623tZ@arm.com>
References: <20240725041223.872472-1-ptikhomirov@virtuozzo.com>
 <20240725041223.872472-3-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725041223.872472-3-ptikhomirov@virtuozzo.com>

On Thu, Jul 25, 2024 at 12:12:16PM +0800, Pavel Tikhomirov wrote:
> Add a per-CPU memory leak, which will be reported like:
> 
> unreferenced object 0x3efa840195f8 (size 64):
>   comm "modprobe", pid 4667, jiffies 4294688677
>   hex dump (first 32 bytes on cpu 0):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 0):
>     [<ffffffffa7fa87af>] pcpu_alloc+0x3df/0x840
>     [<ffffffffc11642d9>] kmemleak_test_init+0x2c9/0x2f0 [kmemleak_test]
>     [<ffffffffa7c02264>] do_one_initcall+0x44/0x300
>     [<ffffffffa7de9e10>] do_init_module+0x60/0x240
>     [<ffffffffa7deb946>] init_module_from_file+0x86/0xc0
>     [<ffffffffa7deba99>] idempotent_init_module+0x109/0x2a0
>     [<ffffffffa7debd2a>] __x64_sys_finit_module+0x5a/0xb0
>     [<ffffffffa88f4f3a>] do_syscall_64+0x7a/0x160
>     [<ffffffffa8a0012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> CC: Wei Yongjun <weiyongjun1@huawei.com>
> CC: Chen Jun <chenjun102@huawei.com>
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

