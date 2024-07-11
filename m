Return-Path: <linux-kernel+bounces-249391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FCB92EB0B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC5E1F23F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6161916A37C;
	Thu, 11 Jul 2024 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j88/7H4p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IlGeZ13L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D32578283;
	Thu, 11 Jul 2024 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720709399; cv=none; b=OE00La1Aybz1lZoDnqTXwV5hu/8mfHZWPUj1C0nA4GW1tyupOgCfksdyc0Q9arWOEy8QlMZ6OApLaIs5zKjFKbnwGlUoMtIkFWgW11+UFDM2kGk3Lv8lqSw4Kz+AqoGZ+VciEMPEv22X4FdhA2k32TvIREgqfnB6mE71bZkZ4aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720709399; c=relaxed/simple;
	bh=pccx1xqoPjK9OuUCpS2BEJckKXw84NRAAK7BokOHo94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=asucMaMyQ2bzMZGrvfBaZDVW519myEVw5raU475Hxf60eF2ceG5QQf1yY/+1QvBiyij5RiQvG0FGxCnX8KRPUPNrd4siMQCuYHXSKoYABaPLv99yE298MIsBNcPBbQIDVDpQyEgKXyY5T4Vg+ochxbUNBH9ozbRMAT8T9eGMcsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j88/7H4p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IlGeZ13L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720709395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbdG/TttFE3xcEPdHpWdCeUTzVY0jQF13snsXgRUZSU=;
	b=j88/7H4pxxED0hNYv6vGsokIh+L+L+6pHo0xxUFuebBlo7iZ0bE/ANqfUGRJiggq7lmt13
	RrS8EnEl04SlG9rj4H1+RCmfFbFEdjhqFyeXUR2FEe+ucQapGCcYFzXUBPP59X41YUTHWM
	llhDy+Q//u5X3cMouDKjAV7FEG0XOhA6V9t1OedM2ttsc5tCDW6dgShHKHyjbRYnJGuNJW
	REDgB0aWR03sKt9B0/h9x9fn0Fcs+f6bQ/dyNj3ahBxgWrjaZKmnNM3o8FojdpLKo3TT0P
	NOXBTvk+0EW8Z0D2nKu7Alb7mU8CABe/rYeQgDTdpl8Jec7oss6GWurHW04WIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720709395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbdG/TttFE3xcEPdHpWdCeUTzVY0jQF13snsXgRUZSU=;
	b=IlGeZ13LIh63bYhT3sHcKW+d/BsN7lwEkxhbAcrGUDd9m/kaTjGgTsTBfP62B9uInVhcgR
	7dK+IDVfE08STmDg==
To: Tianyang Zhang <zhangtianyang@loongson.cn>, corbet@lwn.net,
 alexs@kernel.org, siyanteng@loongson.cn, chenhuacai@kernel.org,
 kernel@xen0n.name, jiaxun.yang@flygoat.com, gaoliang@loongson.cn,
 wangliupu@loongson.cn, lvjianmin@loongson.cn, yijun@loongson.cn,
 mhocko@suse.com, akpm@linux-foundation.org, dianders@chromium.org,
 maobibo@loongson.cn, xry111@xry111.site, zhaotianrui@loongson.cn,
 nathan@kernel.org, yangtiezhu@loongson.cn, zhoubinbin@loongson.cn
Cc: loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4][RESEND] LoongArch: Add AVEC irqchip support
In-Reply-To: <245cd3c4-fdcd-768a-1c7c-e7abd1086864@loongson.cn>
References: <20240710043859.13053-1-zhangtianyang@loongson.cn>
 <87zfqpus3h.ffs@tglx> <245cd3c4-fdcd-768a-1c7c-e7abd1086864@loongson.cn>
Date: Thu, 11 Jul 2024 16:49:55 +0200
Message-ID: <87wmlst23w.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11 2024 at 09:40, Tianyang Zhang wrote:
> =E5=9C=A8 2024/7/11 =E4=B8=8A=E5=8D=8812:30, Thomas Gleixner =E5=86=99=E9=
=81=93:
> I have reviewed the kernel submission documentation and found that the
> usage of RESEND is inappropriate. The next time there is a modification
> issue, I will update the version and resubmit it

Please address the review feedback of the original V4 and send a V5 with
a proper documentation of changes from V4 to V5.

Thanks,

        tglx

