Return-Path: <linux-kernel+bounces-300086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D7995DE9B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 16:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A572830CD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 14:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D4917A5B4;
	Sat, 24 Aug 2024 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y2EkhhiD"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216BB1714DA
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724511293; cv=none; b=r+Rir2IJP3pnx+xwoDnLHQpQVtIO0wlGxgTUcW65GBP805DemXNMUTHKZh0aSrMHi4iuILuIYhq5++31Sd2s06r/625phXaRPoqvm+hvmwNAF3sXDTbX6pyv3VFDXFPVgIZQdXSyBkW4dIDbD4MvECKVLGQzWVW0Ayr1IJfzEok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724511293; c=relaxed/simple;
	bh=a+asFzQ7lKVWgmU6A/JhGyv0hiCK5GaVL6OhmrR0OyA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=VMANiq4Y4I195YVsSec/vUZw9tBJ/GQMvba3Icf2EADJZno0meA3zCmguzMbj9dNzmZOjwtrLF8zGDqjxiXMBaXTuJAkw4H2aItedUc7XnS3NDCqX22Ecr8pVsACkGYylI37ahFqSWaGCu/SV7xZzG7inWAxLpSZG50N15QHDz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y2EkhhiD; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724511289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4Dun9+QghgLkmk/cmrnlNXVS+3fk+s6UWbxShI5EOs=;
	b=Y2EkhhiDGJzLhy7WGmCHHIRzpbDFpbdoNHMaNa02DPCoulKr87FbtaeD2Occf5pOfEczIE
	yNHGcMF0H8krmJO6ZmY+Aq8ySuBd1K9+fc8a99W0E2f2DGyNvnNHLNpptO/LoXmRfEKn35
	EgjonGhrBdXO4H1VxIkIv/qQY6034XU=
Date: Sat, 24 Aug 2024 14:54:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: jeff.xie@linux.dev
Message-ID: <f2e282ae3c502561d8ae302f535d969250dd967e@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] genirq: procfs: Make smp_affinity read-only for
 interrupts marked with IRQD_AFFINITY_MANAGED flag
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, xiehuan09@gmail.com
In-Reply-To: <875xrrgicx.ffs@tglx>
References: <20240820020904.2514189-1-jeff.xie@linux.dev>
 <875xrrgicx.ffs@tglx>
X-Migadu-Flow: FLOW_OUT

August 24, 2024 at 3:16 AM, "Thomas Gleixner" <tglx@linutronix.de> wrote:

Hi tglx,

Thank you for your very patient review, I=E2=80=99ve learned a lot from i=
t.

>=20
>=20On Tue, Aug 20 2024 at 10:09, Jeff Xie wrote:
>=20
>=20>=20
>=20> Currently, due to the interrupt subsystem introduced this commit 9c=
2555835bb3
> >=20
>=20>  ("genirq: Introduce IRQD_AFFINITY_MANAGED flag"),
> >=20
>=20
> This is not really a proper sentence.

Thanks for pointing this out, I see.=20

The=20introduced IRQD_AFFINITY_MANAGED is not the reason, I will delete t=
he description.

>=20
>=20>=20
>=20> an error is reported when a
> >=20
>=20>  system administrator modifies the smp_affinity for the virtio_blk =
driver.
> >=20
>=20>  For example:
> >=20
>=20>  jeff-labs:/proc/irq/26 # echo 2 > ./smp_affinity
> >=20
>=20>  -bash: echo: write error: Input/output error
> >=20
>=20
> That should obviously return -EPERM for managed interrupts.'

Got it, I will fix it.

>=20
>=20>=20
>=20> However, checking the permissions of smp_affinity/smp_affinity_list=
 shows that
> >=20
>=20>  they are set to rw. System administrators are strongly complaining=
 about this issue.
> >=20
>=20
> System administrators complain strongly about a lot of things. Such
>=20
>=20complaints are not necessarily a technical reason to change the code.
>=20
>=20A proper reason is to argue, that the kernel already knows at the tim=
e
>=20
>=20of interrupt allocation that the affinity cannot be controlled by
>=20
>=20userspace and therefore creating the file with write permissions is
>=20
>=20wrong.

Thanks, I will use the description.

>=20
>=20>=20
>=20> jeff-labs:/proc/irq/26 # ls -l
> >=20
>=20>  total 0
> >=20
>=20>  -r--r--r-- 1 root root 0 Aug 20 01:32 affinity_hint
> >=20
>=20>  -r--r--r-- 1 root root 0 Aug 20 01:32 effective_affinity
> >=20
>=20>  -r--r--r-- 1 root root 0 Aug 20 01:32 effective_affinity_list
> >=20
>=20>  -r--r--r-- 1 root root 0 Aug 20 01:32 node
> >=20
>=20>  -rw-r--r-- 1 root root 0 Aug 20 01:32 smp_affinity
> >=20
>=20>  -rw-r--r-- 1 root root 0 Aug 20 01:32 smp_affinity_list
> >=20
>=20>  -r--r--r-- 1 root root 0 Aug 20 01:32 spurious
> >=20
>=20>  dr-xr-xr-x 2 root root 0 Aug 20 01:32 virtio3-req.0
> >=20
>=20
> We can see that from the code, no?

Yes, we can see that from the code, I will delete it.

>=20
>=20>=20
>=20> Therefore, the permissions of smp_affinity/smp_affinity_list should=
 be changed to read-only.
> >=20
>=20
> Should? Tell what the solution is:
>=20
>=20Therefore set the file permissions to read-only for such interrupts.

Thanks, That's indeed a better description.

>=20
>=20And please format you change log so that it has linebreaks around 75
>=20
>=20characters.

Thanks for you reminder, I will change it.

>=20
>=20>=20
>=20> #ifdef CONFIG_SMP
> >=20
>=20>  /* create /proc/irq/<irq>/smp_affinity */
> >=20
>=20>  - proc_create_data("smp_affinity", 0644, desc->dir,
> >=20
>=20>  + if (unlikely(irqd_affinity_is_managed(&desc->irq_data)))
> >=20
>=20
> This unlikely is a pointless exercise as this is not a hotpath
>=20
>=20operation. Also please switch to S_IRUGO / S_IWUSR and simplify the
>=20
>=20whole thing to:
>=20
>=20 umode_t umode =3D S_IRUGO;
>=20
>=20 if (!irqd_affinity_is_managed(&desc->irq_data))

Okay, I will delete the unlikely.

After thoroughly analyzing the code, I think it would be better to replac=
e irqd_affinity_is_managed() with irq_can_set_affinity_usr() like below. =
 What do you think?=20
=20
=20     if (irq_can_set_affinity_usr(desc->irq_data.irq))
             umode |=3D S_IWUSR;

>=20
>=20 umode |=3D S_IWUSR;
>=20
>=20 proc_create_data("smp_affinity", umode, desc->dir, &irq_affinity_pro=
c_ops, irqp);
>=20
>=20Thanks,
>=20
>=20 tglx
>

