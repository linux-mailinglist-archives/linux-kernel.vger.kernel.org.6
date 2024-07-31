Return-Path: <linux-kernel+bounces-269278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8772F9430E1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A76B23BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94AD1B29A6;
	Wed, 31 Jul 2024 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nf6JzJE/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zC/34seq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D783619413E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432671; cv=none; b=nZRibItv+FIy0KlQiMG+8g/zZ7Rc2fPQXYjzLTjSs3nNIyQbnSU6wbNPWgekEnaEkA/hdqJ07iRvhFzaXT5ONnyieaMrRrdE1wEeq1GUI5mYSUERd7SnFVGDPod/BmPbmvVSEoif2XCNjtbNb3M6oMI18+X1nTY8k3FB9BAYj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432671; c=relaxed/simple;
	bh=jfJnIeRp0Hm7cvvA9socefml3SaofeOlG1Xc6j/08/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LtmdrPIFJ23BmIgKo9YkBT+FJ+/yF4cPhaBIfPMfbqT/UaO3mFnin9umIIUL85PmDulfMQ19h9OnPKJgrU+SCYpPjIcXmgaYk2FAPdZPmXG6/bw1mTfg6GxV0407JYJ2Nuax7zSTpH4mq+LluIzb0AQA1WyX6XVXzvlh3L7AR34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nf6JzJE/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zC/34seq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722432667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jWVZQWhQQ0QCOi8Hpb86takd5VvlLVoal4eaFGN0yg=;
	b=nf6JzJE/K8GYlPOmSOjOASNUuoAOufPA5RowGkC6kjjVolQ6cetL9ZRdr707984cDQaceJ
	8wUWkloZa2Z7FJ4wjJwtFYuxzWRA3L7TlNRdBjMjZ+Ev5l+Fr5xcW45KwCmuuJ/MRV/pM+
	r/6UskK8tHr8Xm+HQy5qrcMxxBaLDopF91UpBgUB3Z9cdAV5xpVX1J0GFm8LULXI/ru1VC
	JMYfpKqX7C6aSnRsSG7mewhL1Aeh+QIOtw/r5Kx8J0rCtneJRwUzNMEpDjVxSGjQvSLN+c
	vu7DCx+rUp2Pq2dv0xLd+19e4NVuHbigYiM7gPSuw7DePoKEB7SfkM7fWNz4jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722432667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jWVZQWhQQ0QCOi8Hpb86takd5VvlLVoal4eaFGN0yg=;
	b=zC/34seqY/lLF8Ev3cWmJOajlqvA4cdXOoLohzypkgO1lxoPflXJeKPFcFbWNCNF1Bdl4v
	rJdd1ZcUGUsuMOBA==
To: Borislav Petkov <bp@alien8.de>, Mike Lothian <mike@fireburn.co.uk>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/setup: Parse the builtin command line before merging
In-Reply-To: <20240730152108.GAZqkE5Dfi9AuKllRw@fat_crate.local>
References: <CAHbf0-G4bmpuXorwH-e_chWm1fXX7AJ8ck5AL4p+AFevhvdBfg@mail.gmail.com>
 <20240722152330.GCZp55ck8E_FT4kPnC@fat_crate.local>
 <CAHbf0-FTrRPfDTkkSjq9yvyFrWvoYjH_uJAW5KDae8vO-hch+w@mail.gmail.com>
 <20240730152108.GAZqkE5Dfi9AuKllRw@fat_crate.local>
Date: Wed, 31 Jul 2024 15:31:06 +0200
Message-ID: <87jzh1663p.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 30 2024 at 17:21, Borislav Petkov wrote:

> On Mon, Jul 22, 2024 at 05:56:08PM +0100, Mike Lothian wrote:
>> That patch does indeed make the warning go away :D
>> 
>> Is there anything else you need from me?
>
> Nah, all good.
>
> Thanks for reporting and testing.
>
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Tue, 30 Jul 2024 16:15:12 +0200
> Subject: [PATCH] x86/setup: Parse the builtin command line before merging
>
> Commit in Fixes was added as a catch-all for cases where the cmdline is
> parsed before being merged with the builtin one.
>
> And promptly one issue appeared, see Link below. And the microcode
> loader really needs to parse it that early. And the merging happens
> late. Reshuffling the early boot nightmare^W code to handle that
> properly would be a painful exercise for another day so do the chicken
> thing and parse the builtin cmdline too before it has been merged.
>
> Fixes: 0c40b1c7a897 ("x86/setup: Warn when option parsing is done too early")
> Reported-by: Mike Lothian <mike@fireburn.co.uk>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/20240722152330.GCZp55ck8E_FT4kPnC@fat_crate.local

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

