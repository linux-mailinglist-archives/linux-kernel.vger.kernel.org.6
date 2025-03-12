Return-Path: <linux-kernel+bounces-557586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E89A5DB22
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72868175131
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC8723E35D;
	Wed, 12 Mar 2025 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gxmrM4/m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qcr4dsqJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F2C1E3DDE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778016; cv=none; b=quBUhbuEmiAEHHXDyOvuH+42/QvsuVXS9ERauYqNHbpkfuxy96QdsSNfQdiXqHqT8AELyGXDWmhSsKK+EHM8K8NhpH9XAAd0xw6HrMbue9Dr3njmjQKcwUlhOF1xyN3EincSOhRefwpnh3dv0/pXO6WEA+1PE/XRUu48R6aNq4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778016; c=relaxed/simple;
	bh=UYwUjaR6v1q5/fQ/hypQGLb8gy+5OfN5YPZ0I1ZBiRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YMWqFTjqe7FnzhHpExacxm3dEQUT9LDpI6b2UESmG8d2GdfDJoP30kLYRb3dITaZoJ1SpQNYkDjjedwIg0C7R4PC5H7EYi7DY3a8afwo8PEzYXduZCjmWRTJLOmgkJp/3JJCXitPFUE1uRG5a98u2S4zzlGVj+0esX6Cq6Srvrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gxmrM4/m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qcr4dsqJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741778012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYwUjaR6v1q5/fQ/hypQGLb8gy+5OfN5YPZ0I1ZBiRY=;
	b=gxmrM4/m2Wt5JxPlKmgnKRLZRmBCBhcnTiN1uFdwuaQH030fM0iTodcR3mwiSwUwYlbHsm
	iR9Nn7JjkUBCR0K9Hta/OkoXomkdkS36havPDroloZuuLAb7LcLcNXXUKYebOydppcz6Kp
	sDSjVJdC2kAm58jGCmk/uNNLr3+UhcOAR3SNqdi2UFFYW/YNzB8L2Tt2zlrkbXmF45fFTw
	oXrEtszEXSR91P9pwJMxTiNgtBIwHe0BYUTW/6GSkgT0jhXzeEuH1sPd0HSEKIVLyWS/Dr
	gqaO2KgnusML2AAcdrrcx3iyuAvGZo7ZHf582gSfpLBqgBpR13Yxg3iWAfGolg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741778012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYwUjaR6v1q5/fQ/hypQGLb8gy+5OfN5YPZ0I1ZBiRY=;
	b=Qcr4dsqJiy327DE7wJ6oI0CAzPdppIEwqEJmnCx/6TzoobWgsGgXmWZgQ1h/nzjVvRdxCd
	6zE2N6gjr8DmTOCg==
To: Linus Walleij <linus.walleij@linaro.org>, Russell King
 <rmk+kernel@armlinux.org.uk>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann
 <arnd@arndb.de>, linux-kernel <linux-kernel@vger.kernel.org>, "Paul E.
 McKenney" <paulmck@kernel.org>
Subject: Re: [GIT PULL] Generic entry for ARM
In-Reply-To: <CACRpkdZCiiMTwf7eGJJ9aCKFOC3_xTGv1JKQUijjyp+_++cZ_A@mail.gmail.com>
References: <CACRpkdZCiiMTwf7eGJJ9aCKFOC3_xTGv1JKQUijjyp+_++cZ_A@mail.gmail.com>
Date: Wed, 12 Mar 2025 12:13:32 +0100
Message-ID: <87ecz2zelf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 28 2025 at 13:49, Linus Walleij wrote:
> please consider pulling the following git branch for generic entry,
> see below.
>
> This branch was just harvested from my own v5 patch series on
> lore with b4 am -t 20250225-arm-generic-entry-v5-0-2f02313653e5@linaro.org
> then git am on top of v6.14-rc1, so you can do the same if you
> prefer.
>
> It's possible to squash patches, even all of them into one
> big all-or-nothing patch, given the not very gradual nature generic
> entry conversion seems to have.
>
> Main upsides and downsides are in the signed tag.
>
> I don't know who the most important stakeholders are, but I guess
> the context tracker maintainer (Paul McKenney) and the people working
> on generic entry (tglx) could have a say on how important this is, or isn't.
>
> I think it's pretty neat.

It's valuable to consolidate these common functionalities across
architectures as it reduces maintainence costs.

I read through the patches and did not find anything offending there.

Thanks for doing that!

Acked-by: Thomas Gleixner <tglx@linutronix.de>

