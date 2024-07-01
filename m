Return-Path: <linux-kernel+bounces-237009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C7791E9CF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A261C22F35
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7132116F8EB;
	Mon,  1 Jul 2024 20:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlXoM50E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21551366;
	Mon,  1 Jul 2024 20:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866972; cv=none; b=ndrNtKYDDBC/Ew8IomnIMFyKU43nYEtG3DnmudzkjuwcqjaDAOF+kvFa20V9003LUlMC3SZ/cMdUvMFHgTMlh8klsS+SiUmbhBRHyn0wVeImqh5sF5Lt3eF7MEv9WwHjwQE1KNzv1nSGctNL6/a+5bKe4Fq2fcU+eBnuE4GL0CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866972; c=relaxed/simple;
	bh=o37moTC+5VU1Fr6qsrcOG49psStRpz07mCbTVh78s7U=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=N91p7lNgz7OpfH923kWGDX9bQbIRS3Vw48rKpl9d7bot6AlTOK/U4NH0b+Opt0xcywM3sRU0N0WEVrM25EiNupFa74SRYNPh0lRH1skg+WrnddaS3SDMcl+eURtMgO6Ig5LyDZZADIKQ5xVpYYIjY0+Oz2GcwV+tcUjcNi4RkiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlXoM50E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38276C32781;
	Mon,  1 Jul 2024 20:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719866972;
	bh=o37moTC+5VU1Fr6qsrcOG49psStRpz07mCbTVh78s7U=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=dlXoM50ET/DFPIP98MA4aGem9DZ33eTUGGpgQCjjqavEEEu2Ro6OrQFAmT4lqTD50
	 cF8pPcsyihN7QN/ynIulJMOCoBGFV4l2eCCEXShkCHYVO4KxkUJg5K5B4vEifAZr7C
	 ryG4aQGCvuKqU2awr2d8VW/pRDN2oflo7DBhQ6s6E0auDAjY4kpxgkEJZpSW1CzzZH
	 JMO1qdD8jWOkHjbnKffN2/9naEEpQTYz/OQKViAahPG6afRRPaEMciyTmQarHU23/4
	 mnnG9YbmIswv8s/ACvCSFZS6UYzpuSnsSqazmbVPE/7dj7ip7HM9B0Qea6dSxvh85E
	 rQ3rmAjMHzbwQ==
Message-ID: <d3d91a26f205925c4d0197fbd977a6d3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240613120357.1043342-1-treapking@chromium.org>
References: <20240613120357.1043342-1-treapking@chromium.org>
Subject: Re: [PATCH] clk: mediatek: mt8183: Only enable runtime PM on mt8183-mfgcfg
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org, Pin-yen Lin <treapking@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Pin-yen Lin <treapking@chromium.org>
Date: Mon, 01 Jul 2024 13:49:30 -0700
User-Agent: alot/0.10

Quoting Pin-yen Lin (2024-06-13 05:02:28)
> Commit 2f7b1d8b5505 ("clk: mediatek: Do a runtime PM get on controllers
> during probe") enabled runtime PM for all mediatek clock controllers,
> but this introduced an issue on the resume path.
>=20
> If a device resumes earlier than the clock controller and calls
> clk_prepare() when runtime PM is enabled on the controller, it will end
> up calling clk_pm_runtime_get(). But the subsequent
> pm_runtime_resume_and_get() call will fail because the runtime PM is
> temporarily disabled during suspend.
>=20
> To workaround this, introduce a need_runtime_pm flag and only enable it
> on mt8183-mfgcfg, which is the driver that observed deadlock previously.
> Hopefully mt8183-cfgcfg won't run into the issue at the resume stage
> because the GPU should have stopped rendering before the system calls
> suspend.
>=20
> Fixes: 2f7b1d8b5505 ("clk: mediatek: Do a runtime PM get on controllers d=
uring probe")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>=20
> ---

Applied to clk-fixes

