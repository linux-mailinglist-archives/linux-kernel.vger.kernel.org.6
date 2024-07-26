Return-Path: <linux-kernel+bounces-263336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCF093D48E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6571F21A79
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704A01E536;
	Fri, 26 Jul 2024 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q9XTtcd+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ShqDycFq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401481E4B0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001720; cv=none; b=fNann3sIeXRbAbJrdEz4TkI5eMWO/xUCx7Al3zO8XR9qkGBbznUQC6hU7Q3O+x9bAhderPH3PJL6pwDF1pP0dHTO31G3LulXQvTwVlfzbRa8fK9dBiekkGbRH1EFhQL1kuFGhSZK+WDvL0UaBKjL86Ea+VZPOqEum4n9b/mW9pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001720; c=relaxed/simple;
	bh=JX9mbYtArqtlSFUIrd+11eNTJlB7iPh+KVbopC0UQp4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JHbEK4RFP13wcgH4t5srPQSikILI5GYdC6wee5fh6PBr24tbJy31Yie8ESSF7dOwJbGe5TNACq6kx4UsXE1UmfXc+vTDRVuW2qxDtGewhTU/tJ6rMGGvjGFR+q8HFYozEBWSe06WxkhmrLudkbSd81owdBqNeqJ00Lo3J5gukpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q9XTtcd+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ShqDycFq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722001713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMRhRM26HwHlF4Gz76m/SwgTjxf94pSTU/LmljTOgXA=;
	b=q9XTtcd+Bg0WhBxSWqOCOJJG0VGsDOnCW9BEMJW1xdljrh3n8hKNUUYLcmuXlkr57qX4eR
	qO49DP5muuTFvz7Y3xvdRiiAKM8smxMSt6mXhGEWGCbWMTJxGNDv9ndknd+2HBm1MOMmy9
	PJsj4gM4zL0DcasNAg2TzlmXM6ZAMT/YDX9Az9Dyy8KGdWCsoq+hgCGVAJzl6v+8KGqlcc
	MyC8y3OLs2D2EZmqLQzBuSK20nFCHlNfrAdQmjdFSwAovfNp/f7/OI44NzwFlqklx0Bj5y
	sBCEBaiLirNCePkvslzW6mg/rwj63Sp6X593k6MTPtbWoROJahXDHaeKOBP96g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722001713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMRhRM26HwHlF4Gz76m/SwgTjxf94pSTU/LmljTOgXA=;
	b=ShqDycFqRPg88kX+mMIQT3omRYCdv5lbioZJLp63GldrCnn9SkOSL76bIEc5Z9bPEHMT3/
	NDzPXGMnf8diZaBA==
To: Shay Drori <shayd@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci_msix_alloc_irq_at() affinity
In-Reply-To: <ccb1b2ca-0d62-4c74-ada3-89cce13b8de3@nvidia.com>
References: <ccb1b2ca-0d62-4c74-ada3-89cce13b8de3@nvidia.com>
Date: Fri, 26 Jul 2024 15:48:33 +0200
Message-ID: <87ttgcuuvi.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25 2024 at 08:34, Shay Drori wrote:
> I did some testing with pci_msix_alloc_irq_at() and I noticed that the
> affinity provided, via =E2=80=9Cstruct irq_affinity_desc *af_desc=E2=80=
=9D, doesn=E2=80=99t have
> any affect.
>
> After some digging, I found out that irq_setup_affinity(), which is
> called by request_irq(), is setting the affinity as all the CPUs online,
> ignoring the affinity provided in pci_msix_alloc_irq_at().
> Is this on purpose or a bug?

It's an oversight. So far this has only been used with managed
interrupts and the non-managed parts at the beginning or end of the
interrupt group have been assigned the default affinity which makes this
obviously a non-problem because the startup code uses the default
affinity too.

> P.S. The bellow diff honors the affinity provided in
> pci_msix_alloc_irq_at()
>
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -530,6 +530,7 @@ static int alloc_descs(unsigned int start, unsigned=20
> int cnt, int node,
>                                  flags =3D IRQD_AFFINITY_MANAGED |
>                                          IRQD_MANAGED_SHUTDOWN;
>                          }
> +                 flags |=3D IRQD_AFFINITY_SET;
>                          mask =3D &affinity->mask;
>                          node =3D cpu_to_node(cpumask_first(mask));
>                          affinity++;

Looks about right, though the diff is whitespace damaged.

Care to submit a proper patch?

Thanks,

        tglx

