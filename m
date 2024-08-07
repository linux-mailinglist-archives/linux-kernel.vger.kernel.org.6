Return-Path: <linux-kernel+bounces-278546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CA294B1AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFF9281C14
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B19146A62;
	Wed,  7 Aug 2024 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lB+tF3Ba"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137162575F;
	Wed,  7 Aug 2024 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723064246; cv=none; b=pPMlGsu5cOa7V/Jl/+Glyrm60MUToNneAO557QLvFE8En4oPSNgCstzVOKffH+LSohMgyAhw0giiv6kUB/ul4xCmueHeWkpBES69b4r7DWqTgm0+HAI2szV36+GYdznu+6C9tAchS2b+YsudOX2a7oKplHS2vUj01n3SfGAFYYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723064246; c=relaxed/simple;
	bh=CoT9kc9SyDZefE7l/baC5uJQkkoclRK2DyCLVA/Cmps=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=S9+vIanQ7vs1a/t/ZUDKJVQxqvGZtuuoR1QEd2HBHLVXV3ZIoXboU31XBbMySS38z4IzS2+iE7jNmk17LcE9FD8iCO09VfoPnuZcrAN+d+LElKCG2X6tFAVGs1RkoF3MGGOxgCYXyWAzqVg1e9xO18R5oRDrfaHiHBuzXJN8OGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lB+tF3Ba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEA7C32781;
	Wed,  7 Aug 2024 20:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723064243;
	bh=CoT9kc9SyDZefE7l/baC5uJQkkoclRK2DyCLVA/Cmps=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=lB+tF3BamOf4tSVH8rciCBPjpGks/O6PHAQc+nBS+W4H6TkuoxmEWZihwEgkEK1DL
	 540CZ04Y5xBw1PaLD0XIAzlZdlhTKuZsETaxHrG7iEvGXXYIj/aw8or/Wez5rTh6Ls
	 7mZ2h3gF3XoHJs4rNMgx4Za+pFBYpx59uHqsF8NSNgkcZvO3wjCmRmBKC12b7RbZ+E
	 iKvTRWaM1UUWGANRF3HwsAVxgzQNucTwzgAQ5Q8iKydLiYcHGjZo7dEoJuKYktfrfe
	 m17IYBl7iWtpvRs+3JywWtQ/AID4Ki5100jo96DNc9qRx1YhHzYv6+SXe6OxTeeVBo
	 A/7K10EaBcsBQ==
Message-ID: <d673b1539ad5d4abfff29900461f9209.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2024080709283455745026@rock-chips.com>
References: <20240806073832.13568-1-zhangqing@rock-chips.com>, <cca491b4b4f5716e634f7c0ce0c574af.sboyd@kernel.org> <2024080709283455745026@rock-chips.com>
Subject: Re: Re: [PATCH v1] clk: gate: export clk_gate_endisable
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk <linux-clk@vger.kernel.org>, linux-rockchip <linux-rockchip@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, huangtao <huangtao@rock-chips.com>, =?utf-8?b?5byg5a2m5bm/?= <sugar.zhang@rock-chips.com>
To: heiko <heiko@sntech.de>, mturquette <mturquette@baylibre.com>, zhangqing@rock-chips.com <zhangqing@rock-chips.com>, =?utf-8?b?5p2o5Yev?= <kever.yang@rock-chips.com>
Date: Wed, 07 Aug 2024 13:57:21 -0700
User-Agent: alot/0.10

Quoting zhangqing@rock-chips.com (2024-08-06 18:28:34)
> Hi=EF=BC=8C
>=20
> Some modules, which need to do workaround, need to disabled the clock dir=
ectly,
> independent of the reference count.

We don't want clk consumers going behind the clk provider and turning it
off and on. You'll need to figure out some other way to do this. Are
there really other consumers besides the one changing the pin to a gpio?
If there's only one user then it seems like clk_disable() should work?

