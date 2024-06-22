Return-Path: <linux-kernel+bounces-225621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1B49132FD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 12:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3A728420B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 10:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A0F14D45E;
	Sat, 22 Jun 2024 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BbGyknvb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pDXnJ9Jv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201BA13D614
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719051476; cv=none; b=cVga5EaPPwxr3UXIP8SVU2P63kyyYNWMO+9Bl70pAxCJnr072z8nJoHVlb2fVOP1DKQFeOgFA5RffhdUe5uHUB6DOCQa9PHzcIBOJH7FJG39XDOfTacHogSlrLhf+H+v8gD/Jg3cGvzMfo2UhXH2r2iT978u9XqBFxCNUNg38TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719051476; c=relaxed/simple;
	bh=ENt6ZNPVg6/LybX0Pk6zZTLzCGyzbxAPfrToun8Dwoo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pwlxSrVjiT9BjRHOQyfQArIUAqG33bWAPJEn4GzxcWODS7dOE1aTJ+z420wr1e4drb/IZKciYaoHTnk+BBogHO8zDs4zT9kxRwuHyTKotUFcmkPCXHTctWK5iy5Dz5j5stfOJtEOr1MGQaApamwZWjGdho9lhij4n6FX7IcAt6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BbGyknvb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pDXnJ9Jv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719051472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ssaN1tkzzEsL2Y+r8IH9q6uYww1OTiPt1J+oMIZPEqU=;
	b=BbGyknvbWY5nRDmD1yDUqzMZel/tVHPDLzo61iPh00f01UQJmg12XDJrfhJRrKlpFEEzpg
	0Y1vbkbUpuhwJpjRE/pD7h9nq9kBvBlA2XSJiMLoW+rYWwOJa7UR73krDT4kPZrCUBolGq
	EKqxpsdryUoJL2eLf/rSfl+1WzqfeqYu3XpSLVfH/EnYUxT3/1rOSYE8uJ1ej/sjdWU20Z
	avAcvSoeJUfVLajzgcFxrHGveVDWv7BGLsXNqoxozPTlapskQQbcx5/wITqbW6nM/gjzLm
	a9OSKucpzLThZ/ODbHWPSwjCHz5bEWFuOgtTxDveB22VkPX6BYlMJZ3z4Z5yOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719051472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ssaN1tkzzEsL2Y+r8IH9q6uYww1OTiPt1J+oMIZPEqU=;
	b=pDXnJ9JvrXG/zYuyrRKc5naGA1rFYIGcCTDXRlIG7Lu1OS0JOCy9yebIRpLE3IKhMw4JR0
	xIYwsfXcWd9RCfAw==
To: Huacai Chen <chenhuacai@gmail.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V2] irqchip/loongson-eiointc: Use early_cpu_to_node()
 instead of cpu_to_node()
In-Reply-To: <CAAhV-H5TNnf+EMEtKmXk+Q9KXSZpW+9vd-7qqXDifsKfny+v=g@mail.gmail.com>
References: <20240620020625.3851354-1-chenhuacai@loongson.cn>
 <87msnem3i1.ffs@tglx>
 <CAAhV-H5TNnf+EMEtKmXk+Q9KXSZpW+9vd-7qqXDifsKfny+v=g@mail.gmail.com>
Date: Sat, 22 Jun 2024 12:17:51 +0200
Message-ID: <87pls9z3g0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Huacai!

On Sat, Jun 22 2024 at 10:49, Huacai Chen wrote:
> On Sat, Jun 22, 2024 at 4:42=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>>
>> On Thu, Jun 20 2024 at 10:06, Huacai Chen wrote:
>> > When we use "nr_cpus=3Dn" to hard limit the CPU number, cpu_to_node() =
is
>> > not usable because it can only applied on "possible" CPUs. On the other
>> > hand, early_cpu_to_node() can be always used instead.
> cpu_to_node() depends on per-cpu area, and per-cpu area is only usable
> for "possible" CPUs.

When nr_cpus=3Dn is on the command line then what needs to access
something for CPUs which are not possible to come ever online?

That does not make sense because it's exactly the same situation when
you compile a kernel with NR_CPU=3D8 and boot it on a system with 16
CPUs. Then early_cpu_to_node() does not give you anything either.

So what's the technical problem you are trying to solve?

Thanks,

        tglx

