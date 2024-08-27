Return-Path: <linux-kernel+bounces-304125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AA2961AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85120284C45
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604D31D47AC;
	Tue, 27 Aug 2024 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzXIMASK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E4E1D45E3;
	Tue, 27 Aug 2024 23:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724802055; cv=none; b=VsPOOaxnoCH4zyzFpNAEJGRDVjDFIKHF0vrnl8vbuHeVXaD0HdJcAspnpOo3zGFg9q60gsUWjeBwImMCX9crZUXML13/7CtgTsmxsQXkBOemdBLPRtTS03hxE75e+9GcqMEYrU+NXf2AnLlozPgZ5vjQoH9BFuPuGUsDjZVb+RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724802055; c=relaxed/simple;
	bh=uqrM2V2XUJLc4pgu/Aww4+b2GdKnuDt3PVEz7Sr5IpM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=JF2iU1V3DqGzkRpt9o4Cokduom/RAc+kvmV32qsh5Hm4PTHi9EYgdJokhTyf1LzgfW/JlXtN41apYddbKOpBXRvCBZ2xwTy+a+LyQI5D0HQJQmoxFOwa1ksZBJIwK9KP0o+jjL6spG2uE5BD7yfgJYoa0O8NUciNm7LCR5wPXv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzXIMASK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF597C4AF48;
	Tue, 27 Aug 2024 23:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724802055;
	bh=uqrM2V2XUJLc4pgu/Aww4+b2GdKnuDt3PVEz7Sr5IpM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=QzXIMASKT66GFa9TA9/DogHT9n4Q14c3Ln/9BGRg7+NKCqUBKgYfY0HH38bzgOvB4
	 etBHV3qp1B1wG0woKbGU8+dgboQCtVdt87nv1YrKxN7+/YpbEsteJ/xQ2U3ZlfwBlS
	 O51ZidQ+codqrCbPFpYkgIMPRsLe7je+m2LQvlRKY39xl0XC5+UZ1zrbOqBAI+C8G8
	 97R6jSsV5IwI6p9uGCCpz/XBLDdEDf5iOX0Q88R/59lImai+6WMV+Ju3bOgbjt0dAv
	 QpJ8uc7sTiAz8ShgLL9dxc6iFtj5GvRScQoGB9U5LiFJaX4mhef+iZjNxjLy0FeHsp
	 gtoxy/DukxxJA==
Message-ID: <ced9ed863c4b648a65c80447a8482cb2.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <D3QXIGN92QZ7.S2LY531JZ1L9@protonmail.com>
References: <20240826123602.1872-1-hpausten@protonmail.com> <20240826123602.1872-8-hpausten@protonmail.com> <2024082655-cubicle-flashily-6ab3@gregkh> <D3QXIGN92QZ7.S2LY531JZ1L9@protonmail.com>
Subject: Re: [PATCH v3 7/9] uio: add Xilinx user clock monitor support
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Harry Austen <hpausten@protonmail.com>
Date: Tue, 27 Aug 2024 16:40:52 -0700
User-Agent: alot/0.10

Quoting Harry Austen (2024-08-27 12:08:52)
> On Mon Aug 26, 2024 at 2:11 PM BST, Greg Kroah-Hartman wrote:
> > On Mon, Aug 26, 2024 at 12:38:36PM +0000, Harry Austen wrote:
> > > Xilinx clocking wizard IP core supports monitoring of up to four
> > > optional user clock inputs, with a corresponding interrupt for
> > > notification in change of clock state (stop, underrun, overrun or
> > > glitch). Give userspace access to this monitor logic through use of t=
he
> > > UIO framework.
> > >
> > > Implemented as an auxiliary_driver to avoid introducing UIO dependency
> > > to the main clock driver.
> > >
> > > Signed-off-by: Harry Austen <hpausten@protonmail.com>
> > > ---
> > >  drivers/uio/Kconfig            |  8 ++++
> > >  drivers/uio/Makefile           |  1 +
> > >  drivers/uio/uio_xlnx_clk_mon.c | 71 ++++++++++++++++++++++++++++++++=
++
> > >  3 files changed, 80 insertions(+)
> > >  create mode 100644 drivers/uio/uio_xlnx_clk_mon.c
> > >
> > > diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> > > index b060dcd7c6350..ca8a53de26a67 100644
> > > --- a/drivers/uio/Kconfig
> > > +++ b/drivers/uio/Kconfig
> > > @@ -164,4 +164,12 @@ config UIO_DFL
> > >         opae-sdk/tools/libopaeuio/
> > >
> > >       If you compile this as a module, it will be called uio_dfl.
> > > +
> > > +config UIO_XLNX_CLK_MON
> > > +   tristate "Xilinx user clock monitor support"
> > > +   depends on COMMON_CLK_XLNX_CLKWZRD
> > > +   help
> > > +     Userspace I/O interface to the user clock monitor logic within =
the
> > > +     Xilinx Clocking Wizard IP core.
> >
> > Why do you want a UIO api for a clock device?  What userspace code is
> > going to access the hardware this way?  Why not use the normal
> > kernel/user apis instead?
>=20
> I was just trying to provide userspace access to these _unexpected_ clock
> status event indications (clock stopped, underrun, overrun or glitched) a=
nd UIO

Maybe unexpected events can be indicated through the EDAC subsystem,
except that is usually about memory or cache errors, not device driver
issues.

> seemed like an easy way to do it and leave interrupt enablement and monit=
oring
> up to userspace. I'm not aware of any existing clock event notification
> framework. Are you suggesting that such a generic event notification mech=
anism
> should be added to the clk subsystem? e.g. additional clk_ops callbacks e=
tc.?
>=20

I've been thinking of adding devcoredump support to clk drivers when
they hit an error condition. The idea is it would be a coredump for the
device register state when the clk driver detects an error. Maybe you
can use devcoredump for this?

