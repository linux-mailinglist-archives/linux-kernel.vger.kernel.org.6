Return-Path: <linux-kernel+bounces-319610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C12EE96FF45
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 04:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E4B1F23593
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 02:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664631798F;
	Sat,  7 Sep 2024 02:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fqO02YY5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635CC134B1;
	Sat,  7 Sep 2024 02:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725677309; cv=none; b=VUNRq/HAqQZPRdkpB+gdQV0rZaeevehMShlGGANXU4WoXCKA6CFYewjMyt4AFwXS4YQTtwrFVLIm+SHacTSItI9GN6hbjwhiZ6ccVPFGpAuzQATJ3xr9Af3JttJmkmGv4dlYRwcfuMQHCmTB5AEKA9Z2KBKasBCEVgSMQsTKhRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725677309; c=relaxed/simple;
	bh=3tEnVSgl4KWu1DsgL0C8TGbUh8FjzR6eAkgRRbuiFhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1Hsegbttny769I5nldjFJoHQXV6ozcNMsAm4UP43JgbKImUMQUoURywsz+WAnBv7fK5640vp6X96i5uX7gXjIdnPTzGMhiMqcaJ0a6+h9/zsbWb8zys3e9KI0Ri2JAbFXJkqrbFQeGmN0DjTxQ+zFyqmi1Chy8yEDXC1EDMxzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=fqO02YY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FEFC4CEC4;
	Sat,  7 Sep 2024 02:48:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fqO02YY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725677304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tEnVSgl4KWu1DsgL0C8TGbUh8FjzR6eAkgRRbuiFhw=;
	b=fqO02YY5HU2dzIXH4LOY7waP1KOWEKEq+VK2fi3DFd0ALf2jlq4EUKGsxhcXb8luexzVoh
	ln7+wBl1ecMkfj7zz+xVXxfFN25l7W2561YA50qHpmhc1r6x0u0AU+BLvbUUH7ezTwXtNP
	geFkd0DFal/qrafG/iixh225s5PpreI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b2310a09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 7 Sep 2024 02:48:24 +0000 (UTC)
Date: Sat, 7 Sep 2024 04:48:22 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: maobibo <maobibo@loongson.cn>, gaosong@loongson.cn,
	jiaxun.yang@flygoat.com, qemu-devel@nongnu.org, thomas@t-8ch.de,
	xry111@xry111.site, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jinyang He <hejinyang@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: LoongArch without CONFIG_ACPI and CONFIG_EFI
Message-ID: <Ztu-9qgiKS98c0hl@zx2c4.com>
References: <ZtsX_tcEuOjktUl9@zx2c4.com>
 <84a8ee9c-7781-c474-c394-d1498dc00050@loongson.cn>
 <CAAhV-H5CbyemhjoYLXqW3pLPtp4Ne3wcOZXzv2k5=jJCpi3rfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5CbyemhjoYLXqW3pLPtp4Ne3wcOZXzv2k5=jJCpi3rfg@mail.gmail.com>

On Sat, Sep 07, 2024 at 09:47:38AM +0800, Huacai Chen wrote:
> On Sat, Sep 7, 2024 at 9:44 AM maobibo <maobibo@loongson.cn> wrote:
> >
> > Add huacai who is maintainer of Loongarch Linux kernel.
> >
> > On 2024/9/6 下午10:55, Jason A. Donenfeld wrote:
> > > Hi,
> > >
> > > It appears that as of QEMU 9.1, it's possible to boot LoongArch machines
> > > that don't provide EFI or ACPI.
> > >
> > > Would you consider removing the `select ACPI` and `select EFI` from the
> > > arch Kconfig, so that kernels built for this minimal QEMU environment
> > > can be a bit leaner and quicker to build?
> Very difficult, at least removing EFI is difficult. Even if booting to
> a FDT environment, we still get information from EFI now.

Makes sense. !ACPI is the more interesting one for me, anyway, as that
takes a while to build.

