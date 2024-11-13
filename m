Return-Path: <linux-kernel+bounces-407913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1281B9C7766
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98E71F2A88C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DF2203712;
	Wed, 13 Nov 2024 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w6rF+o4j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UVbZIgEQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EE714AD2D;
	Wed, 13 Nov 2024 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511893; cv=none; b=A4JGkdJE2EWBF1Smo84ejwqjESpNHAfoAiX9+r7fNb9ecMFbT6KRjaZhaXp0w4CqSvtk3hOD/hQRfBTXsAWLCQ4cHBI8N0huDtqe9xLOWBy3Ay+UvkMKCES+Hq0KAHOGRF/mXin/haAKaq8bfXbBfhkplfNhdABDXItCYx6lUmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511893; c=relaxed/simple;
	bh=5zx+ivpU0X8L7BhqDHs0w8O4ysdQnQxpnwn6xEaMrws=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jMaMZvYRUfEkG+pSEcx2zbWd62zd9xUlZ0yoCM4XFgfCnI96KrYxhFlGpIsfFOfsHnSYQr7stpZ1dWQlVr9uX0eyXXEsNBgQHcZI+WWO4ZgMKVX8Rw5S70DP/BYMhDrfAwZUzc2THgPQVaaWKR+03bK8Xr1y4GxlSc9xG76bpz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w6rF+o4j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UVbZIgEQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731511889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njW3e4/sr8AYqkXvzqK+glp62OVtkPOURqkStAgOtjQ=;
	b=w6rF+o4jQgg041568o9ZMcMLYeSAWwxvBzFLVqxrJTZFZvNTQ+MBzsR6NLfu/Zze/MOaO6
	qD6yiKdzJQQROKyN92flHAe/ycJLWzKFjr/uYwGneVMT99pvYajdAUAdUSWGJsH10p56Q1
	/VUVg1yqiTiSpnqHOUAlnnUrXDiWVOEIwrKPPuHnULhi/PPMcGYy+IEhrG+T+qzF2CsUlv
	V7R2M/sSb9MFXgIfXCOFikby7SI2TW57Le75dnPE68zTfYidgRuKyfOt7qxLI8hcBfB2Fu
	fu4qfF5ylj9naIK57HtJjyHQrBVJABs2SHsBrrx2HCWDgRoYhTTNS2ruhC2eNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731511889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njW3e4/sr8AYqkXvzqK+glp62OVtkPOURqkStAgOtjQ=;
	b=UVbZIgEQUS/SEuRGDp1iLbyHr4v1jr7KurOynoale65lK8XUgENfNM0rMCmKgSxOTNdMqn
	JWCayrqphnBvLIAA==
To: Chen Wang <unicorn_wang@outlook.com>, Chen Wang <unicornxw@gmail.com>,
 u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
 conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
 krzk+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 robh@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
Subject: Re: [PATCH 2/3] irqchip: Add the Sophgo SG2042 MSI interrupt
 controller
In-Reply-To: <PN1P287MB28185C9DA26A773775BDC4C6FE5A2@PN1P287MB2818.INDP287.PROD.OUTLOOK.COM>
References: <cover.1731296803.git.unicorn_wang@outlook.com>
 <8076fe2af9f2b007a42c986ed193ba50ff674bfa.1731296803.git.unicorn_wang@outlook.com>
 <87cyizmzhf.ffs@tglx>
 <PN1P287MB28185C9DA26A773775BDC4C6FE5A2@PN1P287MB2818.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 13 Nov 2024 16:31:44 +0100
Message-ID: <87v7wrkv4v.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13 2024 at 14:43, Chen Wang wrote:
> On 2024/11/13 14:14, Thomas Gleixner wrote:
>>> +
>>> +	middle_domain =3D irq_domain_create_hierarchy(plic_domain, 0, priv->n=
um_irqs,
>>> +						    fwnode,
>>> +						    &pch_msi_middle_domain_ops,
>>> +						    priv);
>> So now you have created a domain. How is that supposed to be used by the
>> PCI layer?
>
> Here I create the domain and attached it to the fwnode. In PCI driver,=20
> it can set this msi controller as its ""interrupt-parent" and find the=20
> domain attached as below:
>
> static int pcie_probe(struct platform_device *pdev)
> {
>  =C2=A0=C2=A0=C2=A0 struct device *dev =3D &pdev->dev;
>  =C2=A0=C2=A0=C2=A0 parent_node =3D of_irq_find_parent(dev->of_node);
>  =C2=A0=C2=A0=C2=A0 parent_domain =3D irq_find_host(parent_node);
>  =C2=A0=C2=A0=C2=A0 ...
> }

I assume you then want to create a global PCI/MSI domain via
pci_msi_create_irq_domain(), right?

That's not the preferred way to do that. Any new implementation should
use the MSI parent model, where each PCI device creates it's own per
device MSI domain with the MSI interrupt controller as parent
domain.

There is a library with helper functions, irq-msi-lib.[ch]. See
gicv2m_allocate_domains() or pch_msi_init_domains() for reference.

Thanks

        tglx

