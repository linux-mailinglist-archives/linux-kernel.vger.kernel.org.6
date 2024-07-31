Return-Path: <linux-kernel+bounces-269902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CA1943844
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A59A1F21584
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B356168C20;
	Wed, 31 Jul 2024 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgd++1cx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4770F16C869;
	Wed, 31 Jul 2024 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722462723; cv=none; b=d0KxxofCM8dH4sjSrKQKV5CJOI2wtAHyaFQpagrBSeyRv71JyE/M93DLdga1rZmTFp/sNA29v48GSHyMkOCjBMlTt3aFqXtjtOAeuqOMAf1re7pvSqu4qvDSytqRJT6BPHYOBpeYFoa1C4SGZXJHjGukEcdVwhLksiFUwsLvgQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722462723; c=relaxed/simple;
	bh=LzrxpMDPHD8tdlmRH+vOiXD1KsGz4EH0qN3aZbe0v/k=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=r/nL8gXr+suGbf+/A/mrcEkrNCt6/ywqgbf9IQUpJtjsLQ3+/YfxibYtdrILNbfH79KHUCr+LzMheoX3XjAkdt6jXepDSrE1B3AEpiEXX9jktNoKyzg1OEvtv09AASsbjUEEMBsv4noblp/zIrpMTAKk4vXuQxAyTVW3hM0MwzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgd++1cx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7C0C116B1;
	Wed, 31 Jul 2024 21:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722462722;
	bh=LzrxpMDPHD8tdlmRH+vOiXD1KsGz4EH0qN3aZbe0v/k=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=tgd++1cxuCDTl1r42SQmpyjbWvvfkraBvQKeUuxbcAWw0j/2SIzfTHZTaBgrbRC8a
	 KAn9jn28xZNJFJbIzsVPnTcnA7RwWTHJEUHXyC3N8vTMtPTlyWR6p0RmIRiSK704J/
	 SatyyVjtdAyjawOGbRnnbkEyNcT1zuA5feyD2qAz77YMnsOT8T43ILwmMA/yTsmpXY
	 DEm5G67M2xiL04T6KsjY6XaHoUOpZgA4oNMnbMHB/PGYhdUK5QtBylqyq+aliIkO/Z
	 yI0qr/sKpwSN/jnwb4uCCpV7Ki2e6xXe4CELQAkr1dYP5rZgS5KhQmTzFOOikTcEit
	 mN9c+en4DGUWg==
Message-ID: <dfb7e69f944a5d5821a503b23bd9c1a5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240731061439.3807172-1-drew@pdp7.com>
References: <20240731061439.3807172-1-drew@pdp7.com>
Subject: Re: [PATCH] clk: thead: fix dependency on clk_ignore_unused
From: Stephen Boyd <sboyd@kernel.org>
Cc: Drew Fustini <drew@pdp7.com>
To: Drew Fustini <drew@pdp7.com>, Emil Renner Berthing <emil.renner.berthing@canonical.com>, Fu Wei <wefu@redhat.com>, Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Date: Wed, 31 Jul 2024 14:52:00 -0700
User-Agent: alot/0.10

Quoting Drew Fustini (2024-07-30 23:14:40)
> Add the CLK_IGNORE_UNUSED flag to the vp-axi clock (CLK_VP_AXI) to avoid
> depending on clk_ignore_unused in the cmdline. Without this fix, the
> emmc-sdio clock (CLK_EMMC_SDIO) fails to work after vp-axi is disabled.
>=20
> Signed-off-by: Drew Fustini <drew@pdp7.com>
> ---

Applied to clk-fixes

