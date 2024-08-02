Return-Path: <linux-kernel+bounces-272636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 906C3945F3A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34A2BB217FC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C041E2894;
	Fri,  2 Aug 2024 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4asp4AHl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T9f9Go1/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301F01E4EF8
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608270; cv=none; b=m37cSgWiYdGQdXvoX6c9UsQp/65m52l4wXEA/Y9SLuS7DQ4dI5vozY7lSnoUVcrsMyse/iRvyJXD3gDoTu9Y4T80QgllYkPl+zgXsCtu3pA2YExqbsVbUG7KUKZ38cKz39tHaJPI8Fy+WP3ZGyk+s83+8xP1ZzGl1GXselirVB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608270; c=relaxed/simple;
	bh=IIZ4J9eCu7qiyvmbXDsboXGKGqpTaIpnpAKPEaHl1LU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g5S0euuW4fzWWxfAWWzGPJ4fYYJVccd/3Rr/GZ7H5Qy65vGDKcWZLsZvY1rhUheUXKL7UoRskxMF/SYHP21vtIlrlWyyD6/pGte1YkimBJsgHzA7om39g24uCU8w6K68ZxZfSY0VLJcfCriY34w0oyjT3RJrVkSkv6TDdId52zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4asp4AHl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T9f9Go1/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722608267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6UOXUHsCuEOdHkhLbc1yBpiOisJQeHbIHrJz/cErYg=;
	b=4asp4AHl6LezVIO4M4TqADwV3ukpIDq2AWXP3jyCD5encysu+ucCWO3VOSQFZEXcSwyAui
	6vX1+Eidv3BALfS+JvbIHSHPsXOwbcSiGRfjps5iT70ldwOBy+wFJ+/HH2hcX4afmwZUtE
	T9ywk3CzwoZcVPnxH91V0++aQz/tV//2+bEYZxLhqrh9CJcmXiIXevmnTlgipdxAstaaBi
	j8OPQEM/t1OD3i1Ogfdr4Kq1gRjI7wf9ZNA1tYKQd1/rQKxT2qIrKs39IX9Rvc9iGVgqlI
	oUCxsajCnRCIxc5oyETfg+jwD5tqEzzOfucfSIqE+0GlKp+dGWNNbRSmwOzJeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722608267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6UOXUHsCuEOdHkhLbc1yBpiOisJQeHbIHrJz/cErYg=;
	b=T9f9Go1/xBBUIFhRYlj80SZL0LFSfUHTmPwmY1RY4nLQzdBdOVAzePZvj2F8K+XWTJAfY2
	2NM+ZK+00TCR2VDA==
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Peter Zijlstra
 <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, Jiaxun Yang
 <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v3 0/3] LoongArch: CPU parallel bring up
In-Reply-To: <20240716-loongarch-hotplug-v3-0-af59b3bb35c8@flygoat.com>
References: <20240716-loongarch-hotplug-v3-0-af59b3bb35c8@flygoat.com>
Date: Fri, 02 Aug 2024 16:17:47 +0200
Message-ID: <871q37101g.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 16 2024 at 22:14, Jiaxun Yang wrote:
> This series implemented CPU parallel bring up for LoongArch.
>
> Being the first non-x86 arch enabling that we need to fix some
> infra in patch 1 and 2, then implement everything in patch 3.

I've merged the first two patches into

     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core

and tagged them so the loongson tree can consume them to apply the
actual loongson change:

     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-for-loongson

Thanks,

        tglx


