Return-Path: <linux-kernel+bounces-294616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCAD95903E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6657328420E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8941E1C7B67;
	Tue, 20 Aug 2024 22:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqbs5rfp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F7165F1F;
	Tue, 20 Aug 2024 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191646; cv=none; b=tShGlWSt1SyPKMevjjWlztx7FhE6Wo2Q0GPzRtWYsYjQdQbdLBqSrpiThtdGFDBnX62+/Hhb4b/pN2bFpYzAwVXKjZMmkcpd2hfwRNOzmuEgGe8+4/ITgpVSNoDPIMx7gWhHosegGTbK8YH52t9x/PPSp6Z3i0YkToa3ZsUTbKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191646; c=relaxed/simple;
	bh=gTCfUazAJbz+mImit/XNqwQ9XUVQJSY7H1UanfSeIhE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=nNIhExxAWO2B7PiS2pb1IUfFh0zYA4beNEryy34wCqnVGuWmDz4uZsL+XrvpOG9nm5HDfMbV6lnh6Uy0RAJ6Jk3aKTiJiCe0KPyrBz/VmxaMrjoJZRYTpMcVz/QW2u/rgNJ489Q9uWrV7Y2XJwZnhTXHo+on7vdZWjXxL0TgmUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqbs5rfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8495C4AF12;
	Tue, 20 Aug 2024 22:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724191645;
	bh=gTCfUazAJbz+mImit/XNqwQ9XUVQJSY7H1UanfSeIhE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=cqbs5rfpF9GosR2zhGsHx/iMlNYQWn+8YrNpk7H1zYS0SVkhY55nUAZDFAu95B+Cj
	 ilxtwwqd2AGODFB7Kxcyxlk8tyyfDsYdOL+TiDR9ccJzx6hhYIKl1iuh+0AUtHTpSi
	 W+9CYiyc+vbAeodh1/d8ZLliW4aOHOfiIUD17ItajQEGFx6zimblkHfz8DeNwSfE8o
	 sALnZ2FT8xr8q/RaMFtBSuUHsEF1aGa6mu6vuV1apq3GB9el6gVOXK8FeWb+d3Ad7n
	 m5cH87SmzqscvG7ufFKeq8UslO8ANLRcZWhWQLmAoTKynL5TvK8jF7JluEFT0TINgX
	 lTEgnPdojQafQ==
Message-ID: <1d4c39e109bcf288d5900670e024a315.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240820025902.2355565-1-liyuesong@vivo.com>
References: <20240820025902.2355565-1-liyuesong@vivo.com>
Subject: Re: [PATCH v1] clk:clk-imx8-acm:fix wrong pointer check in clk_imx_acm_attach_pm_domains()
From: Stephen Boyd <sboyd@kernel.org>
Cc: peng.fan@nxp.com, kernel@pengutronix.de, festevam@gmail.com, shengjiu.wang@nxp.com, linux-clk@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, opensource.kernel@vivo.com, Yuesong Li <liyuesong@vivo.com>
To: Yuesong Li <liyuesong@vivo.com>, abelvesa@kernel.org, mturquette@baylibre.com, s.hauer@pengutronix.de, shawnguo@kernel.org
Date: Tue, 20 Aug 2024 15:07:22 -0700
User-Agent: alot/0.10

Quoting Yuesong Li (2024-08-19 19:59:02)
> device_link_add() returns NULL pointer not PTR_ERR() when it fails,so
> replace the IS_ERR() check with NULL pointer check.

Can you document that fact by adding a "Return:" line to the kernel-doc
for device_link_add() in another patch?

