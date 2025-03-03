Return-Path: <linux-kernel+bounces-542773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A19BA4CD7E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170A6166C6E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505C2214A93;
	Mon,  3 Mar 2025 21:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A5OhqSGh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8QjZtu+0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F5E1EEA36;
	Mon,  3 Mar 2025 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741037310; cv=none; b=Ms9y8EvZIvqup3c/a7N4yOP2GVMaOxEhABwJCM8cJkRW7+w/Z7/xTFS5meR4UI1UKxlzl420UyYDaEzxlb3MWRwavFncREcQtiBxsEiGW14+daQk/fqR2lloTbDQxcTmoI7KyXfbrk0OXUEnKPef42X8fjyHOA9EPh033gfLNZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741037310; c=relaxed/simple;
	bh=JqSLjYXp5VhQmOioTQLjOVFrkgU5gfFhEwe8rT/A+qQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BG02hbG/u0p+2xQ6VQfw1N83NU80de5lSmiVWZkYakT7bRfpqj36UiRkdXOtdpGIj48qP+QDxn7ctgLwIR0F9dz2RG9T22dV46F8KKfibtWAnWccLm+YgviZ8VMEi5nMcXqhRrIKhnZoOSJxou76yNLahb0fmg2bF7EZdo38Sw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A5OhqSGh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8QjZtu+0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741037307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJvtWYGCYENq/QZBdt4Xpkgc5ScJPg1y2QJ5vIvYZhs=;
	b=A5OhqSGhhifmQjTmDdOXzIMcnJTR8hzofFpudjTg+o48YEMPN8zPftzBzeTa9RgJ9zieas
	oSbH7k5fV2cG9y5TAhPwcVC0KYH4xMGmAuSdPsQKGxr1e17bB3/P6PjiJYXxEO1wjYQma4
	uE1wiwFTsQMlZhEYHOhf5kEA/WZDaOEG2XkZsNXlfSVUuc50RS3YS0+Lw9SPMawbf0yMlq
	cfBqhICtKoOfaYyii4DQSTo5RN4PExpZOvAsevs+K8ZfghgdsvUFQomfC+R6FuAZxXfin5
	OZmUrs9i+t+QkpWfrrYdWBS4lIoxsxXDgsydDq5tcPJAnHrSym6SMDXecu7AdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741037307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJvtWYGCYENq/QZBdt4Xpkgc5ScJPg1y2QJ5vIvYZhs=;
	b=8QjZtu+0ZT1XLXNznA1nylxUjMOHc41goKTfH/ShVw/0yCcSYTVM6p2K6egO70D6r/oaBO
	FYZfa+CY3OBpDqBQ==
To: Huacai Chen <chenhuacai@kernel.org>, Tianyang Zhang
 <zhangtianyang@loongson.cn>
Cc: kernel@xen0n.name, corbet@lwn.net, alexs@kernel.org,
 si.yanteng@linux.dev, jiaxun.yang@flygoat.com, peterz@infradead.org,
 wangliupu@loongson.cn, lvjianmin@loongson.cn, maobibo@loongson.cn,
 siyanteng@cqsoftware.com.cn, gaosong@loongson.cn, yangtiezhu@loongson.cn,
 loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] irq/irq-loongarch-ir:Add Redirect irqchip support
In-Reply-To: <CAAhV-H4G2qk69LF41VFoFgd7ZBAqAFB=hA7PMkaxXdNVEX-WyA@mail.gmail.com>
References: <20250303101533.31462-1-zhangtianyang@loongson.cn>
 <20250303101533.31462-3-zhangtianyang@loongson.cn>
 <CAAhV-H4G2qk69LF41VFoFgd7ZBAqAFB=hA7PMkaxXdNVEX-WyA@mail.gmail.com>
Date: Mon, 03 Mar 2025 22:28:26 +0100
Message-ID: <87plixby85.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 03 2025 at 22:34, Huacai Chen wrote:
> On Mon, Mar 3, 2025 at 6:15=E2=80=AFPM Tianyang Zhang <zhangtianyang@loon=
gson.cn> wrote:
>> +static const struct irq_domain_ops loongarch_redirect_domain_ops =3D {
>> +       .alloc =3D loongarch_irq_redirect_alloc,
>> +       .free =3D loongarch_irq_redirect_free,
>> +       .select =3D msi_lib_irq_domain_select,
>> +};
> For consistency, please use:
> static const struct irq_domain_ops redirect_domain_ops =3D {
>        .alloc          =3D redirect_domain_alloc,
>        .free           =3D redirect_domain_free,
>        .select         =3D msi_lib_irq_domain_select,
> };

This formatting requirement applies to all structures in this patch. See

 https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#coding-=
style-notes

for further information.

Thanks,

        tglx

