Return-Path: <linux-kernel+bounces-436567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7592C9E87A9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 21:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D67128196B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 20:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4613015B0EC;
	Sun,  8 Dec 2024 20:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sML6Jew3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KOKJxPpr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308C21917F1;
	Sun,  8 Dec 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733689341; cv=none; b=FiHjzbk3/UjKlVK848FDhoA8RpiO2hxzwsP/VttqFPFmOTrmqPU08NQmbtgNBlROWkvMK8BGZKLNME3rbMv/zvvqwMe+x+XULSAJOqK3IuRQCw0Q6L/0dPAJbaZws9CTkSJCXCpKVt17V1axO4DAjkcDH7AV/HGh4XwLY9LXd9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733689341; c=relaxed/simple;
	bh=XEYRwMnet+r825nSM/cLYqyePethGAWl739j+BAGgIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dSdibDMCO0C47hV8pWsZuaEia0IKwTCqm44dvg6V9bi/Xnp3XMc9EdESbxIX8W+ckcaulw7AH7wPaOCIFfMkhq4VUggyY6GXesK6cRQupIq458B8r+WBctjnTqD93GweTeh2CW3p0W0OrG2OCz6gUSpl6St/l8l6kmGo/ES1+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sML6Jew3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KOKJxPpr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733689337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GEwHm4RjPwsEsy6MSACHhlpzhxhayGl7iXcDVkZS/vE=;
	b=sML6Jew3YPmWDyO5lPXBHfu9LLs2SsTjquepGfC1DIlh4w5wlQ5W77HhcxKH8aI35yiKNU
	jl5eL38zYn/WhmPYLgTPru3vHpJrs8kn4pEDjOm1HnEwu5S21eOIHisI7e9oMtOjt1objP
	5j9ImyS2yDpdZVjpa6iC2cwErM6uIxcKN7rBymqbBIMeadkg9rS2EWtE7E3kvNJZ7wkUGB
	easKIie2nb5MfVzdamJ7KyyBmXc/6I6F+vGr1zWQaTvlG5UaHrVhT18VsICAChemfUPgOa
	qQM6WNG7ZzvcTMAlmG+TBOvbRA4I8V4E/Wu7A8mW1XPA2damcN1aFkdtqys+MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733689337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GEwHm4RjPwsEsy6MSACHhlpzhxhayGl7iXcDVkZS/vE=;
	b=KOKJxPprxJ2zqEcww/Hvti+UJDiBwwUMD7UOkYPp4oJB9yIVw+4yOjp5zLUxqVPSOVUvFB
	5LMz6zhJ+huB3rCQ==
To: Huacai Chen <chenhuacai@kernel.org>, Tianyang Zhang
 <zhangtianyang@loongson.cn>
Cc: kernel@xen0n.name, loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/loongarch-avec:Add multi-nodes topology support
In-Reply-To: <CAAhV-H4VAyD+=Btt9S6HrN6-sVQJqe1_jeLPS13UR1kxXJ8S5w@mail.gmail.com>
References: <20241207033146.20938-1-zhangtianyang@loongson.cn>
 <CAAhV-H4VAyD+=Btt9S6HrN6-sVQJqe1_jeLPS13UR1kxXJ8S5w@mail.gmail.com>
Date: Sun, 08 Dec 2024 21:22:16 +0100
Message-ID: <8734iyq613.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 07 2024 at 17:11, Huacai Chen wrote:
> On Sat, Dec 7, 2024 at 11:31=E2=80=AFAM Tianyang Zhang
> <zhangtianyang@loongson.cn> wrote:
>>
>> This patch enables the advanced interrupt controller function under
>> multiple-node of 3C600. The topology of the advanced interrupt controller
>> is consistent with NUMA node. We check the enable status of the node whe=
re
>> each CPU is located once when it goes online, which may cause some
>> additional operations, but it can ensure that the advanced interrupt
>> controller can still be used in situations where some CPUs cannot start
> The whole can be reworded:
>
> Currently we only enable one chip's advanced interrupt controller
> (AVEC) in hardware, so multi-chip machines with Loongson-3C6000 don't
> work. This patch enables it for every chip (In theory every chip needs
> to be enabled only once, but for simplicity we enable it on every core
> in the CPU online hooks).

It want's to be reworded without 'we' and 'this patch':

  avecintc_init() enables the Advanced Interrupt Controller (AVEC) of
  the boot CPU node, but nothing enables the AVEC on secondary nodes.

  Move the enablement to the CPU hotplug callback so that secondary
  nodes get the AVEC enabled too. In theory enabling it once per node
  would be sufficient, but redundant enabling does no hard, so keep the
  code simple and do it unconditionally.

Thanks,

        tglx

