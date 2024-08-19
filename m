Return-Path: <linux-kernel+bounces-292045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2D7956A78
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609111C23570
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF74616C847;
	Mon, 19 Aug 2024 12:08:15 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58231166F0C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069295; cv=none; b=XQPGJ/LIRQ3umO/Ch4y+dR1hK2GtZYG9WSJU6uvqQ2vxEEwF897lXOmM6NuAMCv5fqK6FdXyRQj5qFivTjS4+hua7ziVHC+dg0sFX9Rp/gDVd8XqotUrDhrk+OMOr240eGRh6dtCb6LLypsUbA4f4YtSlcrnEfCmIq0eI+uwdJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069295; c=relaxed/simple;
	bh=rc7IaxgSQPhdKrsdjiuq3UI0I+5ZwNEdEdwI4ZHdePw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lx7pgKd6CleKnSH+uXimMOV6qpxH8SNC1/bJ67QpYbDIU2uCU8N8Am0YK8PiLZwfRxlnLvSpw7pgZpRNwUiQ68eUO5rlYtOnKPu/m4MEtWq/Wjo9oWMmM/Yel07B+wT1SYyvdyzOVpSkUg8rbM13Moq/ErWUVySxb2zihj/xyto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WnWWK6Nx3z6K9KZ;
	Mon, 19 Aug 2024 20:05:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id ED573140D1D;
	Mon, 19 Aug 2024 20:08:10 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 19 Aug
 2024 13:08:10 +0100
Date: Mon, 19 Aug 2024 13:08:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Tong Tiangen <tongtiangen@huawei.com>
CC: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, James Morse <james.morse@arm.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino
	<vincenzo.frascino@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mm@kvack.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>, Guohanjun
	<guohanjun@huawei.com>
Subject: Re: [PATCH v12 6/6] arm64: send SIGBUS to user process for SEA
 exception
Message-ID: <20240819130809.0000731c@Huawei.com>
In-Reply-To: <20240528085915.1955987-7-tongtiangen@huawei.com>
References: <20240528085915.1955987-1-tongtiangen@huawei.com>
	<20240528085915.1955987-7-tongtiangen@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 28 May 2024 16:59:15 +0800
Tong Tiangen <tongtiangen@huawei.com> wrote:

> For SEA exception, kernel require take some action to recover from memory
> error, such as isolate poison page adn kill failure thread, which are done
> in memory_failure().
> 
> During our test, the failure thread cannot be killed due to this issue[1],
> Here, I temporarily workaround this issue by sending signals to user
> processes in do_sea(). After [1] is merged, this patch can be rolled back
> or the SIGBUS will be sent repeated.
> 
> [1]https://lore.kernel.org/lkml/20240204080144.7977-1-xueshuai@linux.alibaba.com/
What's the status of that one?  Seems better to help get that in than
carry this.

Jonathan

