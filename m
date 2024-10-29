Return-Path: <linux-kernel+bounces-386432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEA39B436B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 455E2B21626
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD16D2022ED;
	Tue, 29 Oct 2024 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cjjF4eRg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7jVzdxDg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BD81DE3C5;
	Tue, 29 Oct 2024 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187966; cv=none; b=KmC6G2TYiVtuqSgZiXeAHDoAJuxLJUdFPAo/oa2FJ9BP2SxQyb8BgswFaWuYZxJ2+lZUv5XJCvaRCB6CbRKHZZrc2i2HZK7KdjOglTRnBJ75x3ZASHgZuWv6c/rqR/+/Tm3ijWTEQPhYjZqOBZ9/6sW7PBaTLvL+VQMCAKSdlWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187966; c=relaxed/simple;
	bh=dp97rlroyRB/zeuGmGOsQg6ZrHeImmvKZEPuUVrYK4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eAZXqQ+cUl9XpQrTmSKj/UEOmqhppvBTRwK0iYrvw0HYUAb4o3y1zm4TXhvCbDxooZGw+ojerZ1gQ9cSsA0yovgUqzX+fZWNbJlYTCreMtle0mYUbQO/P9wpcs3v9kqNi2S1rlIzipvczT3FY/mx0SxRjreqLqA42fL9BugR7fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cjjF4eRg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7jVzdxDg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730187960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ocksU4RpVjVurxFAx+JTZsKtC/IfAmmtb1MA+uZcAo=;
	b=cjjF4eRg2GOvVf6wvheFfn4WnNcXE7pBA/yTUbkb5/0+f1w1E9JgPmB5BgeTrirHqeGw5s
	o6edotnjAfJGGT7NayRxbP9rbd0P19ubVvb1LZlOg0cEmpZyMPHRmNIKCynB5mqq9V9Skr
	2mm+783Ob8qCw6bEKrcNhAM8hqwAFB2hYT7UeYizARgCrar0CON1jjhWWsG+LbC4qYcMBJ
	xiaGdtnddI/QxwOPRlylBjYFHqBucgbY5Hlyx+5c1iYDmreWC+mBVFp+RRzLr3YbGICTe3
	UOLo0f8PpJ14jASC9FOJdTM/0kd8wtcZHuFSqqxxtGEhpM5tapmauJ7HOXRqOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730187960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ocksU4RpVjVurxFAx+JTZsKtC/IfAmmtb1MA+uZcAo=;
	b=7jVzdxDg/7sUfxRa0SpbynMf/6HBZ6o3TVpLElNB3+/Hkj50ji1N0JZjF0ZDBx7c1z/cn8
	WcxB2PVbuwjnjWBw==
To: Inochi Amaoto <inochiama@gmail.com>, Chen Wang
 <unicorn_wang@outlook.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Peter Zijlstra <peterz@infradead.org>,
 Inochi Amaoto <inochiama@outlook.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Yangyu Chen <cyy@cyyself.name>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Yixun Lan <dlan@gentoo.org>, Inochi Amaoto <inochiama@gmail.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 2/3] irqchip: add T-HEAD C900 ACLINT SSWI driver
In-Reply-To: <20241022040218.450573-3-inochiama@gmail.com>
References: <20241022040218.450573-1-inochiama@gmail.com>
 <20241022040218.450573-3-inochiama@gmail.com>
Date: Tue, 29 Oct 2024 08:45:59 +0100
Message-ID: <87jzdr2vyg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 22 2024 at 12:02, Inochi Amaoto wrote:
> Add a driver for the T-HEAD C900 ACLINT SSWI device, which is an
> enhanced implementation of the RISC-V ACLINT SSWI specification.
> This device allows the system to send ipi via fast device interface.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Can someone from the RISCV folks please confirm that thtis is good to
go?

Thanks,

        tglx

