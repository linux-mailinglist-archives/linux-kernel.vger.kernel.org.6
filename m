Return-Path: <linux-kernel+bounces-294069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA9F958881
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8281F2290E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CBE1922F4;
	Tue, 20 Aug 2024 14:05:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393CC1917E5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162718; cv=none; b=gyGxuPSQyWl+ifdQkY7J/HN0X2Hu5cj7Xx3jOvKhd9XzDqiky0/1W5gx15o22Fn1tR2fLXjYlUVbK63LsiHxwkQycpH3pCLTKoI/1lgv5+ypHzFPiyRPKFA7k29GxxodumDVf+YvYp1R55fFaz9J9jd3UBmC8GqUoo/gjab/BjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162718; c=relaxed/simple;
	bh=1Qgdai2QpJ4izg2Cq70y7siAGvfjrqcTRZS8BqThLVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UygRUvE2BxwsKKUrkqX7WJeCAWU42LHy8dquAlAub6k2tYkFc3IDasD41IOL5XtdrCN/h/CawQwT1Tb6zfUcQY8uajy9FfhtQqwL4WSW2W4Do/mumVfkUqcVZOx/MXvBGUX4xXdLKLH41JJd1ebwvhjHCkLqy0CJ9UbdDsjqjOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96170DA7;
	Tue, 20 Aug 2024 07:05:42 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 971613F66E;
	Tue, 20 Aug 2024 07:05:15 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org
Cc: James Clark <james.clark@arm.com>,
	linux-kernel@vger.kernel.org,
	anshuman.khandual@arm.com,
	mike.leach@linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] coresight: tmc: sg: Do not leak sg_table
Date: Tue, 20 Aug 2024 15:05:08 +0100
Message-Id: <172416269493.339483.9402392984207620369.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702132846.1677261-1-suzuki.poulose@arm.com>
References: <20240702132846.1677261-1-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 2 Jul 2024 14:28:46 +0100, Suzuki K Poulose wrote:
> Running perf with cs_etm on Juno triggers the following kmemleak warning !
> 
> :~# cat /sys/kernel/debug/kmemleak
>  unreferenced object 0xffffff8806b6d720 (size 96):
>  comm "perf", pid 562, jiffies 4297810960
>  hex dump (first 32 bytes):
>  38 d8 13 07 88 ff ff ff 00 d0 9e 85 c0 ff ff ff  8...............
>  00 10 00 88 c0 ff ff ff 00 f0 ff f7 ff 00 00 00  ................
>  backtrace (crc 1dbf6e00):
>  [<ffffffc08107381c>] kmemleak_alloc+0xbc/0xd8
>  [<ffffffc0802f9798>] kmalloc_trace_noprof+0x220/0x2e8
>  [<ffffffc07bb71948>] tmc_alloc_sg_table+0x48/0x208 [coresight_tmc]
>  [<ffffffc07bb71cbc>] tmc_etr_alloc_sg_buf+0xac/0x240 [coresight_tmc]
>  [<ffffffc07bb72538>] tmc_alloc_etr_buf.constprop.0+0x1f0/0x260 [coresight_tmc]
>  [<ffffffc07bb7280c>] alloc_etr_buf.constprop.0.isra.0+0x74/0xa8 [coresight_tmc]
>  [<ffffffc07bb72950>] tmc_alloc_etr_buffer+0x110/0x260 [coresight_tmc]
>  [<ffffffc07bb38afc>] etm_setup_aux+0x204/0x3b0 [coresight]
>  [<ffffffc08025837c>] rb_alloc_aux+0x20c/0x318
>  [<ffffffc08024dd84>] perf_mmap+0x2e4/0x7a0
>  [<ffffffc0802cceb0>] mmap_region+0x3b0/0xa08
>  [<ffffffc0802cd8a8>] do_mmap+0x3a0/0x500
>  [<ffffffc080295328>] vm_mmap_pgoff+0x100/0x1d0
>  [<ffffffc0802cadf8>] ksys_mmap_pgoff+0xb8/0x110
>  [<ffffffc080020688>] __arm64_sys_mmap+0x38/0x58
>  [<ffffffc080028fc0>] invoke_syscall.constprop.0+0x58/0x100
> 
> [...]

Applied, thanks!

[1/1] coresight: tmc: sg: Do not leak sg_table
      https://git.kernel.org/coresight/c/c58dc5a1f886f2fcc1133746d0cbaa1fe7fd44ff

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

