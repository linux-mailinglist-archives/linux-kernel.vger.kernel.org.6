Return-Path: <linux-kernel+bounces-330869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FB997A56F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6231F26A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEFE158A3D;
	Mon, 16 Sep 2024 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RXKJDXW/"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E87215747A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726501295; cv=none; b=Gl76RA3KXdnqY1kFoyb2vsw60rZoSG77xfkHCGDpCGVnS+QW/1weRaDO1dmUAG6zL7O52a2KBDythRnOX6QUCtztQugzWQBhw++7W3tS2P2UqrYfEgvRwqcMxblC+dDzmGvOuz8u9SW8wEGc3v3bpCmoJJHiFzsr/srng01soAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726501295; c=relaxed/simple;
	bh=12OH91olMyUweAWzgr6kUI9vOD2ESkwCZUHpLcEpqMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQ0NY27O4VUhHYHNBLKbOmGuQkE8gemFXnhNe12GAIE2U0F/HxH7JVVn4lj+mb3fYnvHyMjeT2XuYVES6hjWwbn0fWFYLvCtEbLnBWSClVZ9ONZ7N9K+t2xjw0PgAJ59JlRlfGZsSr1IynFR7/rLNF1dmKDNIDqJW/4cIb4DdD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RXKJDXW/; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6c35618056aso23311896d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726501292; x=1727106092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UD0LyiDwxju/GX0u4ElVAJ/9aIhwrpfl8zDCEnggOb4=;
        b=RXKJDXW/yo0ks9r8isJq8BjSmWvoXfL1gPItPLh4ccuP/EmcSGi/vV6Zd2CZI+AWrY
         HCg8ia+JolupPLAJIjVtYS5RbjdxNG54bZwi0JIW0i6xfl/E0gUrHXTcNx+Uao4dJ38t
         3LesWIZz60ZjNMgpAq5UAUkl8wRY832FOBVKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726501292; x=1727106092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UD0LyiDwxju/GX0u4ElVAJ/9aIhwrpfl8zDCEnggOb4=;
        b=Nv9qs/bOF0qcWLknoOkcr7p9OzCsYtDBjs/Q/aI/IioA/77LKn5BfScXpOv9af2Inz
         lt0txhYt1dhF1dSKgfZ914Dr1LLgmcS7WY2+NyGdVFCQSeJZVu0Cv3O2vPdnhvO9jcrd
         hp8SZllz+s1HFgdhgSICEovXcLFvkvpvCpcD2XB076OGryap6P8KwBkiMcqA1L0hTAwK
         tGBure1bJ8T5bAnCDdu88oye3sxIBQrUeNTYE8FtDfk+bwjhtVuNqAKe7OKt+tB5i3zg
         0VAoLFPg2uLAC/ceOOlbJNUcFwGTl19kucbzc5C876CggKy5DYtr95c831LB8E/wUoDI
         7yNg==
X-Forwarded-Encrypted: i=1; AJvYcCUPFQimcIygbW97blBoyaNNxOUo1t5a+sV83aKLERvL1AbjdDEkfwgwgGINWhm1p/OPan0mrOWtceLkt+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yworb3+5RkDWdLyjfbj9nuHNv2CnuU3VK+H+dexbuUNw2wSbt7v
	AYuI5wnGJuMl0ajZlIY3jPS5WiY2HMpzZFDtgbIIBuOoxed4k1N41+decQQZ5VmfQqnUTTEO2s6
	ZaFBcKf/RiAi8WJF+PqihPMHeF+cEuTw3JfiBDYauHDmZWMUkgkQroww=
X-Google-Smtp-Source: AGHT+IGPEwUoQ9WWbFS8dEcNdcUnY4d9P4LGm5tr83ZyUVCI+aQdfOeuk/HKmgqIpR2YVITCmtjbJozyDabb5i0eeIg=
X-Received: by 2002:a0c:fbcf:0:b0:6c5:8125:d7c2 with SMTP id
 6a1803df08f44-6c58125e162mr147413046d6.26.1726501292174; Mon, 16 Sep 2024
 08:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-21-patrick.rudolph@9elements.com> <CAFLszTgYrEk=UBd6zgesphC+rLPtkOG4fjBOYaGRQXYLNUomyA@mail.gmail.com>
 <CALNFmy3cDCTzppfr5y=sAjKn0eBKsHPq9LD4zGg0KC9HT3qNMA@mail.gmail.com>
In-Reply-To: <CALNFmy3cDCTzppfr5y=sAjKn0eBKsHPq9LD4zGg0KC9HT3qNMA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Sep 2024 17:41:15 +0200
Message-ID: <CAFLszTj+S-d64cx0O1SqPjq_OTePr5Z4Cq-Z92xRqs7_rbWStQ@mail.gmail.com>
Subject: Re: [PATCH v3 20/30] drivers/arm: Implement acpi_fill_madt
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 12 Sept 2024 at 00:31, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> On Thu, Sep 12, 2024 at 2:58=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Patrick,
> >
> > On Wed, 11 Sept 2024 at 00:25, Patrick Rudolph
> > <patrick.rudolph@9elements.com> wrote:
> > >
> > > Fill the MADT table in the GIC driver and armv8 CPU driver to
> > > drop SoC specific code. While the GIC only needs devicetree
> > > data, the CPU driver needs additional information stored in
> > > the cpu_plat struct.
> > >
> > > While on it update the only board making use of the existing
> > > drivers and writing ACPI MADT in mainboard code.
> > >
> > > TEST: Booted on QEMU sbsa using driver model generated MADT.
> > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > Cc: Simon Glass <sjg@chromium.org>
> > > ---
> > >  arch/arm/lib/acpi_table.c |  1 +
> > >  arch/arm/lib/gic-v3-its.c | 89 +++++++++++++++++++++++++++++++++++++=
+-
> > >  drivers/cpu/armv8_cpu.c   | 27 ++++++++++++
> > >  include/cpu.h             | 27 +++++++++++-
> > >  4 files changed, 141 insertions(+), 3 deletions(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Are the GIC values available by probing, or are they just 'known', and
> > dependent on the compatible string?
> Sorry I don't get that question.
>
> The "arm_gic_v3_its" and "arm_gic_v3" driver uses existing DT
> properties and should work with all existing boards.
>
> The madt_gicc entries are board specific. Besides the mpidr all of
> them can be 0.
> Those entries currently do not have matching DT properties in the CPU
> node that could be used.
> Some of those entries are present in the GIC node, but there's no
> direct association between CPU nodes and GIC nodes.

If they are board-specific then they should depend on the board
compatible-string, assuming they cannot be read from the devicetree.
The properties should be set in the driver, though.

This might be the sort of situation where the GIC binding leaves out
stuff and Linux fills it in from internal data? Or perhaps Linux just
doesn't care about these features of the GIC?

Regards,
Simon

