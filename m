Return-Path: <linux-kernel+bounces-305740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC57B9633B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29A0FB219F1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C651E45C1C;
	Wed, 28 Aug 2024 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TBiLe0vj"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D115C14D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879737; cv=none; b=cTXEGKiOGRz10Svu4y7NlC4hqWL6sQ2SWfyI+t862KrbsZ8Hb5Oq3znkCcDS5VUizjHUysLqcFhC4tgzk3kZ9IQOCDoYaAGQItCiZNPsqdSK/1FHxHjiQgf5lemeckKB0J8gEOnCqh/1/LcwMAaHBe2G9uaopyH384gidEf0aXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879737; c=relaxed/simple;
	bh=rZ0hzRuydgbsTmzNxJW5qDg7GgFGEViAZUQW/xwoQg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAG+63GaeNUncjy5rDjOqYv4PAuz7oIiR8rb4BKYU1+gaEaxafTcuUgB2net0NG6FkbGPc2TC7OXUKEbxDN3r1AL/pPIGRQB1OlDkbne7OITB+848+cE8Pm78/8EEXjvEJmNE+T2650hGS37LwFHkiCac1IbS2qbH09Rr1IWit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TBiLe0vj; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-27020fca39aso5613758fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724879735; x=1725484535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wroWp6ZdRx4y4EGEIviQ1d0CtpBbTRnZ8bxPpcNXhAI=;
        b=TBiLe0vjaf36ftvRiYxFcrVq1iqjr+3zy/fT7Q1yy1IzCUD7zT6gYvsEqx/wrTVQvl
         ymSRKKT3tUCTieMWMlrtdw+ErPwKK/cH70D5XUutZU6QHTUFDcWhoKInR3Hz4ykwjKFi
         wCMkK22euHZamSB3MBO0WqGEIG0W3SBMdmUMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879735; x=1725484535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wroWp6ZdRx4y4EGEIviQ1d0CtpBbTRnZ8bxPpcNXhAI=;
        b=ubeEJmedKqSPslOUsv5btMOAZIeo95j49V0oO1/Gu1Qqd6kimERQipx/jF7ug9aG2N
         g6bNXxMTPyUvoMVOIMdXKXGEcCFfkmAX38wXbrSE8g9SvNRF39G884V43OPYtMkagR1N
         mnmVS9XBS0q1Jo9usufSLiXOII+9M5Dy0FlSTFoM4N1Eb70zyQSbSpQclnE3wKP2iN8u
         4JeCkVEKwogfR6VKSOELs5FVrucavziR2tjdHf9bMMFzm3ZGKTeIZ8fViAEsP6wmVFZ3
         CHY/EqnLD0IZWmJo8AqsO1Ftv5aGcM3GiIDVsK/dxQ48Rvmge34COJa2iPdYzs7fBoUo
         8CPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+e0zSfrRF8IeTe8B//JsbEL0mS+ChUqsVL86jDsPeWMlggM5LAXyMXyBUEKfNzpKWycfFl70T+4UjXRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsy9uFDUilqSJFDDMT+dpf78pCT66qBztjbbrwahyail/HRr5Z
	MeBA4eblSvbO4g0l4iXklrKp4FoD6xDRtBNBLzpQFH5cyli0UEgyGbhBjYIujxuOn2ONqzodSO7
	3i1TvlB2FZOaX4qt3g9SUTFLkHlY2XsQUZ8UF
X-Google-Smtp-Source: AGHT+IHpc1TwQ/elzvJfTT8LvKlPqSoX8Jgij02Zkapj6rbYbejYym0vJh0kKtUwFwrIDA0pdyfbKUIckcCIzSc/5qU=
X-Received: by 2002:a05:6870:1586:b0:260:ebf7:d0e7 with SMTP id
 586e51a60fabf-277900cfd7dmr1020924fac.15.1724879734799; Wed, 28 Aug 2024
 14:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823-trust-tbt-fix-v4-1-c6f1e3bdd9be@chromium.org> <ZstCyti3FHZIeFO8@wunner.de>
In-Reply-To: <ZstCyti3FHZIeFO8@wunner.de>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Wed, 28 Aug 2024 17:15:24 -0400
Message-ID: <CA+Y6NJE1p-nidmCZzJ7j-mJAmCLmC2q2meUf-5FFSWofWES-qA@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Detect and trust built-in Thunderbolt chips
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	iommu@lists.linux.dev, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 10:49=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wro=
te:
>
> On Fri, Aug 23, 2024 at 04:53:16PM +0000, Esther Shimanovich wrote:
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > +static bool pcie_has_usb4_host_interface(struct pci_dev *pdev)
> > +{
> > +     struct fwnode_handle *fwnode;
> > +
> > +     /*
> > +      * For USB4, the tunneled PCIe root or downstream ports are marke=
d
> > +      * with the "usb4-host-interface" ACPI property, so we look for
> > +      * that first. This should cover most cases.
> > +      */
> > +     fwnode =3D fwnode_find_reference(dev_fwnode(&pdev->dev),
> > +                                    "usb4-host-interface", 0);
>
> This is all ACPI only, so it should either be #ifdef'ed to CONFIG_ACPI
> or moved to drivers/pci/pci-acpi.c.
>
> Alternatively, it could be moved to arch/x86/pci/ because ACPI can also
> be enabled on arm64 or riscv but the issue seems to only affect x86.

Thanks for the feedback! Adding an #ifdef to CONFIG_ACPI seems more
straightforward, but I do like the idea of not having unnecessary code
run on non-x86 systems.

I'd appreciate some guidance here. How would I move a portion of a
function into a completely different location in the kernel src?
Could you show me an example?
I'm assuming you'd want me to write another function elsewhere.
Shouldn't it be in some existing file in
`include/linux/platform_data/x86`? I don't see `arch/x86/pci/`
included anywhere.
Or would CONFIG_X86 be sufficient? (instead of or in addition to CONFIG_ACP=
I?)

