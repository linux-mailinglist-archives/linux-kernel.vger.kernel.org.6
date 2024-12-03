Return-Path: <linux-kernel+bounces-430127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AF29E2CB3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05BC161CAC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDBE20A5D1;
	Tue,  3 Dec 2024 20:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvMmRdmi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AFE1F9437;
	Tue,  3 Dec 2024 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256159; cv=none; b=fR9ZPDnTUmFMFGc3FZHS63v56+pRgm3LoQL4ItBOW7LFuKZ4EEtAov3E0SFg83jEQY76sbBCIQjyjimM0ioDN3TDO18vHkGyEhtfYUNlYLQdtlG8xwOZDG3NvhObfMIXP6sCUBASpfhkWEcbxkXqiMlGwh3o6cFq5egZMr0NKi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256159; c=relaxed/simple;
	bh=9s/JWRvFfTdgkQKV/nGBL2EuwZaFUujocxVtr4jGDQI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=kAG8E/+28tGBsf5/7dgoGzV7y3+EfvG9OYwdkkzQcmGD/ZVcfSV5TqmL0cEtOCoZHLRn7Fzfd0CnidXaPUIf3CEf69C1rt/L0DKzhyBUhGNNblqRoeAiJLrvXa2nQUaL04kUePPl4XKTVYg2TNI54RBzi3833B19HidNWEz6ihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvMmRdmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A18C4CECF;
	Tue,  3 Dec 2024 20:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733256158;
	bh=9s/JWRvFfTdgkQKV/nGBL2EuwZaFUujocxVtr4jGDQI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=YvMmRdmimDYcDO5m1vowBcbTVKAUOkz0LrjMrixOZXMGNMZHtmRvTww9XjYqcdcIZ
	 RLp8KJ3+buP3VIO16MSwrYrx0VrV8djm2v/XhJrkC1ogXtjOkQtutFGss9vuJH8OIF
	 ICPMWgYWF4gZnj4Ran+0UQD+TEyGMk5J9AeV88u883j2HBEJKTG2rOmx3LWiL4DLNx
	 xB7TZHiKv7To8Fc7lqCHPOrcoSlvMsVgakcqGdDpocEH+nepBYQ867PP/t/Q8MOpm2
	 sr2aBkXCTOdN+nf/DCNXqdtUSb8fDjtX78J0TtJJchfhzcxc3aPEzE48xgL7ZyyZ2A
	 pkufFOQG18c7A==
Message-ID: <afb3fce310d7a4bd1960cbabfc355d32.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d7078eb7-a7d6-4753-b453-8fce15245c34@stanley.mountain>
References: <d7078eb7-a7d6-4753-b453-8fce15245c34@stanley.mountain>
Subject: Re: [PATCH next] clk: mmp: pxa1908-apbc: Fix NULL vs IS_ERR() check in probe
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
To: Dan Carpenter <dan.carpenter@linaro.org>, Duje =?utf-8?q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Tue, 03 Dec 2024 12:02:36 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Dan Carpenter (2024-11-20 09:18:38)
> The devm_kzalloc() function returns NULL on error, not error pointers.
> Fix the check.
>=20
> Fixes: 51ce55919273 ("clk: mmp: Add Marvell PXA1908 APBC driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Applied to clk-next

