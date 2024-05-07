Return-Path: <linux-kernel+bounces-172142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999028BEE0B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3201F23A7F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1897B187352;
	Tue,  7 May 2024 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbh17CzC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCA3187349;
	Tue,  7 May 2024 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715113579; cv=none; b=MTSggWiWQWyucDGGQynLPoe00gKxI9VkLRfba++1tmHHn+QbHo4vi0SaW/E56T8juqe1vl9zLFODIfjsPlrCsCB8cN1HyasiQSivYFerELrdo1MRc2WgsT0vRJp1pP+xM9X+svpVEfbirBun1FScoF/plXmFpnrDjGc15q17Q/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715113579; c=relaxed/simple;
	bh=Jkp27+7iEZAczyVopDS/5uxqbBICAzoIBowJEK5GE3I=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=pkSNBau5Jdy/Uj5xDpM3ypenlnZDMMYkDokfokPnJ3TmxDrF/dJqQqbgYQdOqk2S5MAxm/qHnsVsBczDRUhOHJjN97PIef7fv3UILeRgNnxKNPdoO8LHzAAR5ltMnDRhL1OdSjMipc3aKKhcelO1cUNkJ1CSX6r083jDC5wjKh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbh17CzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E76C2BBFC;
	Tue,  7 May 2024 20:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715113579;
	bh=Jkp27+7iEZAczyVopDS/5uxqbBICAzoIBowJEK5GE3I=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=cbh17CzCDmEwOgsnptt4Ye6NTQIA+dRLnckghXFPqJfX6PTrDEyKPeF/eGWq2XRHf
	 RDXdulKcVlQ8x+T7/NJd16bt9gWUCvzvfKLA1bnZGO1Nlr4xy6SClpr41G/pmKgsAP
	 ANJLioY6qIxXdxZV28Ia5REAgGlTok+7G669Euu2SkFY5X/rT1g/3vaxfetgPlxsbG
	 N3N0lx050AiHhPuODaLmWlUg9P4vOhnx0pBkWtxXwwQ2dxqIrDST00VIAvFk5nOIGT
	 K9S2eIezCRLlCysDFbFsaSPSxEF8BWvLrLlOP5d4dd/J3HxFOuT/gRbsyNwngRsHC0
	 PwPAfpbN6xVzA==
Message-ID: <820ddc2ec70780ae1ecd3af864dc8bd6.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <11be44d3-0f32-49c6-b4ae-ba97a9f97763@app.fastmail.com>
References: <CA+G9fYuZd_ur56H8fwDSvUywopvn_b7ogprGkjEatQ7EPTLwYQ@mail.gmail.com> <11be44d3-0f32-49c6-b4ae-ba97a9f97763@app.fastmail.com>
Subject: Re: clkdev: report over-sized strings when creating clkdev entries
From: Stephen Boyd <sboyd@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>
To: Arnd Bergmann <arnd@arndb.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Naresh Kamboju <naresh.kamboju@linaro.org>, linux-clk <linux-clk@vger.kernel.org>, lkft-triage@lists.linaro.org, open list <linux-kernel@vger.kernel.org>
Date: Tue, 07 May 2024 13:26:17 -0700
User-Agent: alot/0.10

Quoting Arnd Bergmann (2024-05-07 00:44:15)
> On Tue, May 7, 2024, at 09:20, Naresh Kamboju wrote:
> > The WinLink E850-96 board boot failed with Linux next-20240506 but there
> > is no kernel crash log on the serial [1].
> >
> > Anders bisection results pointing to this commit,
> > # first bad commit:
> >   [4d11c62ca8d77cb1f79054844b598e0f4e92dabe]
> >   clkdev: report over-sized strings when creating clkdev entrie
> >
> > After reverting the above patch the boot test passed [2].
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >

There are two fixes on the list: [1] and [2]. Perhaps one of those
resolves this?

[1] https://lore.kernel.org/r/20240507065317.3214186-1-m.szyprowski@samsung=
com
[2] https://lore.kernel.org/r/20240507064434.3213933-1-m.szyprowski@samsung=
com

