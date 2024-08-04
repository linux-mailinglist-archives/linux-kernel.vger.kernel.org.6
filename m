Return-Path: <linux-kernel+bounces-273827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0843E946EA5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 14:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4161C20A73
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 12:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2906939AFD;
	Sun,  4 Aug 2024 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="qdboYzyB"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C231173F;
	Sun,  4 Aug 2024 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722774534; cv=none; b=ETxvCzPEKTCLSxeYmSvES/lhHwnRm4nzIaiGwt1IUK3Gq3weoowRO8CWQAZJWjmHmySuVKdQ2zy/n9L7olAN1SOftvmhDMo66mcnLQMoWwjAo/iGj5e2MgRqyQAaB5xJ1HzuMmj4+iXrUOt2+49aNwgVLEnR4QgChvr0HroMduo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722774534; c=relaxed/simple;
	bh=FJHFFio51TR7iDTdyJkEa2mmH2T9i0TYbb6oOhKfR4M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXgkyVoab9DM9D/J+64GkR8JDUmDgH8a7tVh7rHkenfuiC3MR6DC5RuY1rSwJvVvp7dyqq1oLcitiIx1Y1JHjctCIJoioSOVKP9NQrKFu4NNqO3CDSx7ISfeTy//INkiBWv2CPaZ1p92iGrGOK3MECG2wWxuQXkuUNZ8eb26uMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=qdboYzyB; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722774530; x=1723033730;
	bh=FJHFFio51TR7iDTdyJkEa2mmH2T9i0TYbb6oOhKfR4M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qdboYzyBzq/KC7h+KRg7PNLZOQ9o7LI7XrJNGDTAsn4BgOuh6618YHL31U+9FKen9
	 EH3ixwzAi/HUK9vomM0hK/BezDc80NI2OwYu2+Xs1nRzO3xN/zxewIiIdcNzQZ/1us
	 I6j7Jdr3LGEjOUhRWplIhVS0A3bz1iUgGS/t359I9zft+TYzxn+VO0I/E+JTiuCuNJ
	 lGgoJPzN434uQkuZtIxI+F1jxWpuXk7g7jijImfaokRK2SHqm8eTf5xvYfunfD9wZ0
	 24sQ/wwYbkd3ugMO8uy96hQWR02xP5AAMORhOyaYXz3eDj0tL5N05sDHAzAAEyKSMD
	 PV2K/P2/nAdfg==
Date: Sun, 04 Aug 2024 12:28:46 +0000
To: Krzysztof Kozlowski <krzk@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/9] clk: clocking-wizard: add user clock monitor support
Message-ID: <D374LM180ETW.M8ESN44FLCVX@protonmail.com>
In-Reply-To: <a35918fe-d0d5-4418-b6ad-0150873cb507@kernel.org>
References: <20240803105702.9621-1-hpausten@protonmail.com> <a35918fe-d0d5-4418-b6ad-0150873cb507@kernel.org>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 03bfeefe836df90c0dab48a12ac6979d29732885
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Aug 4, 2024 at 10:01 AM BST, Krzysztof Kozlowski wrote:
> On 03/08/2024 12:57, Harry Austen wrote:
> > Improve utilised clk/notifier APIs, making use of device managed versio=
ns
> > of functions, make dynamic reconfiguration support optional (because it=
 is
> > in hardware) and add support for the clock monitor functionailty added =
in
> > version 6.0 of the Xilinx clocking wizard IP core, through use of the
> > auxiliary bus and UIO frameworks.
> >
> > The combined addition of all of these patches allows, for example, to u=
se
> > the clocking wizard solely for its user clock monitoring logic, keeping
> > dynamic reconfiguration support disabled.
> >
> > This is currently untested on hardware, so any help testing this would =
be
> > much appreciated!
> >
> > v1 -> v2:
> > - Split and improve clk_hw+devres transition patch (2+3)
> > - Fix/improve DT binding patches (5+8)
>
> Be specific, what did you change? Anything can be a fix or improvement.

This was intended as more of a summary, referencing the patches which have
their own more detailed changelogs. But I will be more descriptive in the
cover letter too in future.

>
> Best regards,
> Krzysztof



