Return-Path: <linux-kernel+bounces-225292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A91912EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E15F28330A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37A517B431;
	Fri, 21 Jun 2024 20:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ELnJX1g+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NPDl8OIk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45F716D311
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002570; cv=none; b=pYr+1iKB1ZQJx/FD1SxISC26BkERg66PxATLiGfO+tgitPHvNQgunn+YuZJggCX+fnjLN4beaoay8nxYY09NWMa3wb+1bPAJnNdwKdQL2OKp/V3JZ0/ny3Y5h0vFZaRhGEOYb2AjcqBQO5dzQUaxqZpkLyohDPZiW9p6UNomFEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002570; c=relaxed/simple;
	bh=2zggeFh0OFFhjF/ZVVgSwqdri3EwcBuEJPRN9jlHWu4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CXAgLIyZB9UO0vmCubRhgk0M/BazvGLDaJ3H+q8E3rG7MlOASyuAa4eE4SHydWpQPgS1t8wtb09fJXwRnNccS9Oh/ZjvgtgMa7VXbWkyEdDmux8T6fSkaPbr8mGbdiOswp6A/prR2AgrzQqJ/b2ulm6HNEy5BbDPU/UfR5wtWP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ELnJX1g+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NPDl8OIk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719002567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02A7gZd5M4ugoSZa49BAv+WJOyqZDtqOn+LC+bMhtQ4=;
	b=ELnJX1g+PITl8T7cwEOHyBqQOmhlVqW2HIrRycdn0GNYX1J+z+9XukHDo5KByyBLdHgSIG
	OH4qnwLuPt2pqM9aC5yqR6OD0h1iEWMGpibOfe5MsPOH8BMit4pUCjFlzecEZ06GDrb9qW
	QSL9AJifqNcB4KAK+r1HCtnudnEmO9DtBAmpzHO3tZMYJMhcYd0TDQLmiHhGlCl89tGRvk
	H0qyTMBLVeie5mm6Qtx42TcCxB0BXe4RzitHupoQgTP0VADe5XA4hbamubBEUq0oYZ40s4
	a0DOAZ1zJEOhoN4rH7KLBhJDeUpzTessVPucLrTfsQXd28cohzSrqwttfiD7QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719002567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02A7gZd5M4ugoSZa49BAv+WJOyqZDtqOn+LC+bMhtQ4=;
	b=NPDl8OIkFluIvRunTCQI4wl6r623bolgx1GrbRpQbRwVlQjByCdHSo4Sp/0LOimxHxNLK0
	RsaY3NTkL68ZWrBQ==
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, Xuefeng Li
 <lixuefeng@loongson.cn>, Huacai Chen <chenhuacai@gmail.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH V2] irqchip/loongson-eiointc: Use early_cpu_to_node()
 instead of cpu_to_node()
In-Reply-To: <20240620020625.3851354-1-chenhuacai@loongson.cn>
References: <20240620020625.3851354-1-chenhuacai@loongson.cn>
Date: Fri, 21 Jun 2024 22:42:46 +0200
Message-ID: <87msnem3i1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jun 20 2024 at 10:06, Huacai Chen wrote:
> When we use "nr_cpus=n" to hard limit the CPU number, cpu_to_node() is
> not usable because it can only applied on "possible" CPUs. On the other
> hand, early_cpu_to_node() can be always used instead.

We use nothing...

Aside of that you fail to explain what the problem is (i.e. the
malfunction) and why using early_cpu_to_node() is fixing it.

>  #define pr_fmt(fmt) "eiointc: " fmt
>  
> +#include <asm/numa.h>

asm includes come after the linux includes.

>  #include <linux/cpuhotplug.h>

Thanks,

        tglx

