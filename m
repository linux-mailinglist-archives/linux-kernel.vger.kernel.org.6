Return-Path: <linux-kernel+bounces-339127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C72C98609B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0D91F26840
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3188718637;
	Wed, 25 Sep 2024 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="r9NBPScs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696221798F
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270137; cv=none; b=PIKBtyAwuojXP91Xk9DzQ7FcHg2w6xFuiW43SiXviBrkZTF6xVNwrW/zvfADs9AR4bPqudamY5yMLAu/FrqXIBStl2yLbvCxYNKgss3jiQ0vAaTZVaOYY49DVYoxL3rgB4mS2bRrqzChh4UDgNSfKcCVB+3gEoEw3rcQkzXQvtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270137; c=relaxed/simple;
	bh=BhkEvTFAW7fHfis43gW7DZH8+HpRnrCo42ubr7ajSrQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dgecOFbl2QN0nHJtI3/7tRu6z7q8qhRaP+n9bxuP1sGeOLOcLSyCTc7ll0QbkfluzPePzOWMMSCuNEkrO0nUR/uCj9XgnhJA2LcV3cPz+Kn137s0ryfmsyRMac+6HxxbppDzaqss6oDORB+6Wo7XqdRo8Rk8rwghvR45zUiTJBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=r9NBPScs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34CCC4CEC3;
	Wed, 25 Sep 2024 13:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727270137;
	bh=BhkEvTFAW7fHfis43gW7DZH8+HpRnrCo42ubr7ajSrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r9NBPScs6Bgut0cVCO8J8KNGE1xN7aUjgNOOwtGPRzSyDtNT5Y1gtD5dLIq8BI/ka
	 a9eyaXwXcD2ryQQOXG4ugp6yrq0bxMZ89V0us/gaYyz4GI7O/3etOobEHBNirG/beZ
	 HHT1dj+cvcoC1dw2J5e0mD1NRjF10g4ezqdR/TZI=
Date: Wed, 25 Sep 2024 06:15:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: =?UTF-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Xiang Gao <gxxa03070307@gmail.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: =?UTF-8?B?562U5aSNOg==?= [External Mail]Re: [PATCH] mm/cma.c:
 To better understand cma area during debugging, add total and used count
 logs to in cma_alloc
Message-Id: <20240925061536.e8abdbac3217d85f6f99afd5@linux-foundation.org>
In-Reply-To: <fc8822dd647c4aafbb72a83f5f57c6f1@xiaomi.com>
References: <20240918124325.109236-1-gxxa03070307@gmail.com>
	<20240924172719.a486793abd66643d9938081f@linux-foundation.org>
	<fc8822dd647c4aafbb72a83f5f57c6f1@xiaomi.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 25 Sep 2024 12:00:56 +0000 高翔 <gaoxiang17@xiaomi.com> wrote:

> > [   24.225125] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 64, request count 1, align 0)
> > [   24.231963] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 65, request count 1, align 0)
> > [   24.235712] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 66, request count 1, align 0)
> >
> 
> 
> Above is the cma alloc during boot. The before-and-after context has nothing to do with cma alloc. Below is the log with before-and-after context added.
> 
> 
> [   24.006605] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [   24.071644] Serial: AMBA driver
> [   24.096063] arm-smmu-v3 9050000.smmuv3: ias 44-bit, oas 44-bit (features 0x00000305)
> [   24.097989] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 64, request count 1, align 0)
> [   24.104260] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 65, request count 1, align 0)
> [   24.107504] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 66, request count 1, align 0)
> [   24.140495] cacheinfo: Unable to detect cache hierarchy for CPU 0
> [   24.484998] loop: module loaded
> [   24.536152] virtio_blk virtio0: [vda] 4194304 512-byte logical blocks (2.15 GB/2.00 GiB)

What I mean is to paste the messages before the patch and to paste the
messages after the patch.  So readers can easily see what changed.


