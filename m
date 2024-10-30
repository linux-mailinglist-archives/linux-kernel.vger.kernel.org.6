Return-Path: <linux-kernel+bounces-389478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F37E79B6D90
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F22D1F22A07
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DF21D1721;
	Wed, 30 Oct 2024 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCPw7GXI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43F71BD9D4;
	Wed, 30 Oct 2024 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319839; cv=none; b=mykqttRGIzoCb0TPZp60bFYLbeFMLPgB5bsg7NfNQmIJgWQmJStpyGy2EzyuYsBk5zSfl0aijy5epynhTMenvUZEvvQQznhXAFTEUV57ammwBjVhTE+p4kMRxqxs2YfqlYcnMA+4VvoeRJZ9Xcqu9x08xxiLsZSpCReBlRgBu7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319839; c=relaxed/simple;
	bh=Q9syJ6R0wjduA4DUlaRWARzhz7ENcnTrcqvXhyZe1WU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=YKfOiaA8Cqqqq2rataU1WFJGbh3v2bfvEM+0dd9bSEkyH06w8VtkQ02IgRkiH2Nne0BfK9X+6PK/9+rf9B2T1uRg7SE+5ELo2+MCj938Pbzf271fYN2bgpXIuqENwujWPREBN4ZFFKzUCaquDkQepldIBF6Sk2eBRqt51IANOas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCPw7GXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A37C4CECE;
	Wed, 30 Oct 2024 20:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730319838;
	bh=Q9syJ6R0wjduA4DUlaRWARzhz7ENcnTrcqvXhyZe1WU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=rCPw7GXIVbrF9q+Cuhn+tg9C/7zY6VEBfGdfCPSKksS65sgxzVXTjPMSkloUwzxDP
	 BThQQrBYNBfopz1nVyl8iP26wF4gjxRc+922Bdc1TiYP5C5YXL753xiAOaOxSGxzfz
	 MLXBvj6cn8D2KTyp22UKvEbQ+b+PzNvP4Fbtdve4lycKgv+47WEgI0ovFmQ6gTjaT2
	 SUN5/KsGcQGQOk7k9lAiJnxMLlxi/bAgwW+oJ1xov4yoGkp88hGNIPW2keg5QMXX7Z
	 pbxTU+/0olBONELb657oQyKL/kPZ2hyMh/db8FKuikCZ//gZjacCbhQL4dxAEiMIAa
	 8V850AOgHLNqQ==
Message-ID: <72f5d3bd9e8a6aec59ef547bfd0d7bce.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241029032828.238706-1-changhuang.liang@starfivetech.com>
References: <20241029032828.238706-1-changhuang.liang@starfivetech.com>
Subject: Re: [PATCH] clk: starfive: jh7110-pll: Mark the probe function as __init
From: Stephen Boyd <sboyd@kernel.org>
Cc: Changhuang Liang <changhuang.liang@starfivetech.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Emil Renner Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>, Xingyu Wu <xingyu.wu@starfivetech.com>
Date: Wed, 30 Oct 2024 13:23:56 -0700
User-Agent: alot/0.10

Quoting Changhuang Liang (2024-10-28 20:28:28)
> Mark the jh7110_pll_probe function as __init.
>=20
> There's no need to support hotplugging in the jh7110-pll driver. We use
> builtin_platform_driver_probe, the probe function will only be called at
> startup.
>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---

Applied to clk-next

