Return-Path: <linux-kernel+bounces-280081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1322194C570
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453FA1C221DC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04665156238;
	Thu,  8 Aug 2024 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OViQqds/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4468D2F23;
	Thu,  8 Aug 2024 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723146361; cv=none; b=X2UrBYvkeGoTc4VXSu/XScbXxO922B6h/lb2RUlj4zC5vrXzQpJ3QWc+OhgENh0aezf/oUwnYAtcC0ERtdbJBdjJYOQQVsZUdPmQCjkPu7+uPEJx/zQwAc/xZ0PC5T+Z73PbFY0iC80fh8kIfBYOVQq6rMLlbUIjJgC0es6OC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723146361; c=relaxed/simple;
	bh=BqACvSNDT8Zhao8FyVCgc3fIxwqa2PLl8h463ajEmaA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ko2Rflt1JcwBMNpWbXjFxW+RIlCsHFiNflg5kRlanZBDkf7QkkY6nHRNwNHj1rXaNjzy0gawDtYGRYXcMtyKfGRMs1BkCewos2I//awxAvMp8128YWeQ4QffdotitDSrcPVsNG24ULqr7UIYLSvk1UrwiR7gBup9YfuZFPI9Tno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OViQqds/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF5FC32782;
	Thu,  8 Aug 2024 19:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723146360;
	bh=BqACvSNDT8Zhao8FyVCgc3fIxwqa2PLl8h463ajEmaA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=OViQqds/ZR+NfWdoOK5bN5vsclLQLXYUEtZ3P9VYh1x8efOjLTBv6FCAvUMiBY1c1
	 6hoDSP3uymjiAa6vT7I3i2H7PDp6Mt/4l6yLGqIkrLepSWeb3boWdTfu35Kwt3Mp6N
	 uyDfSU8b3PiZGssxebrwNFrbmxERVYC7ZybLCFuB7xZbgn1SKzRYhdLH7RyBzfJiiK
	 QL9aj3E3imPuALcEGU2gap2F/of3ZtcfoRhToCUm8xxWN/PgMRJnZuW+FttbEZV1xZ
	 CIpf46q40tiKV1IiRlsT2jKgI5+Vd2hnkwlkVMyNefAJoDAvACJ6Lv1TuobnTgX/io
	 s998Gc9x/TQKA==
Message-ID: <6bc191590c1a5b7fa3ef991d6b7e327b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240804-clk-u64-v4-2-8e55569f39a4@nxp.com>
References: <20240804-clk-u64-v4-0-8e55569f39a4@nxp.com> <20240804-clk-u64-v4-2-8e55569f39a4@nxp.com>
Subject: Re: [PATCH v4 2/2] clk: clk-conf: support assigned-clock-rates-u64
From: Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Michael Turquette <mturquette@baylibre.com>, Peng Fan (OSS) <peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Date: Thu, 08 Aug 2024 12:45:58 -0700
User-Agent: alot/0.10

Quoting Peng Fan (OSS) (2024-08-04 05:32:56)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> i.MX95 System Management Control Firmware(SCMI) manages the clock
> function, it exposes PLL VCO which could support up to 5GHz rate that
> exceeds UINT32_MAX. So add assigned-clock-rates-u64 support
> to set rate that exceeds UINT32_MAX.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/clk-conf.c | 42 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 5 deletions(-)

Thanks. I'd like to have a DT overlay KUnit test for this as well.
Either you can write it, or I'll write it next week.

