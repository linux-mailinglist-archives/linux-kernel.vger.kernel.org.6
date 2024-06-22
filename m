Return-Path: <linux-kernel+bounces-225854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD12791361F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 23:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574261F22EEB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 21:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D659E6F076;
	Sat, 22 Jun 2024 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lhAnRcmv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RUI416Xc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D23BBF0
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719091295; cv=none; b=Hv8QlEOUs7qfOlkWyRZyvTSR1Ghi1tIdoiL9wr160QJeSsoSTRS5/OFihieke0T8ObRWCxo8LRCFGQXrr2yNkjNyKFOWkstVgwiAgB/BCqSex1+kfqV0yjyS6ofqT7KSKmHDJINmyYpQ2I0oW/MSTyjFQGyhdrFGZJwISJSb8ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719091295; c=relaxed/simple;
	bh=EHxmzrUN/A73frTQagvw4dP1WhU1NGaVPpCc4+gsYAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y+QYJVKqRwRwxLnNFrs5/ZXzVqWtjRLCidQpjn/pwVeCEliIbJh/fAUSCs9DwZy8l6She86ZOpfP7MVGmasuIZDZv/QMpHXvq7sBLGj1k4Od/jdGiWrx4tOi5PdPJfKCRDs9i+7nLgz0YVNQVtfMcDtn3HEv62iEJNJIpObrOt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lhAnRcmv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RUI416Xc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719091285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cK0peedHHtHTedjCU+iox2hw8klvuHZB6LWN/BOo6NU=;
	b=lhAnRcmv8notJ4xn6XR3VIWyHV9sQoGQM+W4ULQS/TT8wepwj5+3In7dqeMCVuzUwck3BZ
	L5WopjkXETHpnExz/ruyiA38x+/4rI5TKL1L5eODmcSrlnWAMFNbnHax3xxTJHvvfUoA/J
	MfzV9vF6vQeb19lHlWYkh2XBZMolNL1z2R7PL4Z90pv/mEsQYxeCYqM4zNJyadb3nGSoHz
	eaOwWWqF2p/e7AjS8Gs++ldxJ5fY5qLvVlj1F+br/eVfoRbXiwC4Aqil0KM+lyBOEJwjnh
	xNGXRwHdeyRw89j3z6XIrmJmXUknX8maXTsnZmEry0aUTIf2PvrdAoCcxZh90Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719091285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cK0peedHHtHTedjCU+iox2hw8klvuHZB6LWN/BOo6NU=;
	b=RUI416Xc28PiIL5XhT9HWKSfnKhzo7/u7Xcd/mJnq/y+6JuV1pWUmDhaNBJo4IlqSzvgMG
	+RbBYA1VXQbSzMAg==
To: Huacai Chen <chenhuacai@gmail.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V2] irqchip/loongson-eiointc: Use early_cpu_to_node()
 instead of cpu_to_node()
In-Reply-To: <CAAhV-H7noyrYJzyVML8y1gHPiB6qZzXy7j5L_AqjxwLZW2J06A@mail.gmail.com>
References: <20240620020625.3851354-1-chenhuacai@loongson.cn>
 <87msnem3i1.ffs@tglx>
 <CAAhV-H5TNnf+EMEtKmXk+Q9KXSZpW+9vd-7qqXDifsKfny+v=g@mail.gmail.com>
 <87pls9z3g0.ffs@tglx>
 <CAAhV-H7noyrYJzyVML8y1gHPiB6qZzXy7j5L_AqjxwLZW2J06A@mail.gmail.com>
Date: Sat, 22 Jun 2024 23:21:25 +0200
Message-ID: <87jzigznai.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Huacai!

On Sat, Jun 22 2024 at 19:23, Huacai Chen wrote:
> On Sat, Jun 22, 2024 at 6:17=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> That does not make sense because it's exactly the same situation when
>> you compile a kernel with NR_CPU=3D8 and boot it on a system with 16
>> CPUs. Then early_cpu_to_node() does not give you anything either.
>>
>> So what's the technical problem you are trying to solve?
>
> Frankly, there are some drawbacks on our hardware. On a dual-bridge
> machine, there are two eiointc instances. Even if nr_cpus limits the
> "possible" CPUs, we still hope the eiointc driver can initialize
> correctly, otherwise the machine cannot boot.

Hope does not help with technical limitations :)

So if CONFIG_NR_CPUS is not big enough to map the second node, then the
machine can't boot.

If nr_cpus limits it then early_cpu_to_node() because that mapping is
only limited by CONFIG_NR_CPUS.

Right?

If so, then please explain all of this properly in the change log.

Thanks,

        tglx



