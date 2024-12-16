Return-Path: <linux-kernel+bounces-448060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D599F3A89
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E9377A4300
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278E21CF5EC;
	Mon, 16 Dec 2024 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fa6UDZZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820B81D434F;
	Mon, 16 Dec 2024 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379983; cv=none; b=uc+MtOHijth5bXK+DYvadJIxcjwhrdm3Qv2VJZVKQUE9+bV2LFi/T7JnNy3ENe7K2yFGhnWIbLUh9R+xrHuXr6gfpHUj0dliFOvt0ZoQZ4Qb+hSuPAcqq7jtD8CE1fEjyJG/q8uXNGVSuycX1jCdNAyKsPbAyx1euMy/fZNURNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379983; c=relaxed/simple;
	bh=9z+6ELH5uuiyTM6MH1n+deEOoHgAw/exY116v8SrYUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwHwASDIA2/57GC976FivLQ4+X6GVGPR91TFALlCNsUivD+Mw3QXQ+xvQ7UvoKHLuCVGrffm8aAGOdObsGljyUSmJYiqSnjMrNw/J8myg2U3MMLxc+xkIKrIJqtgXChPInrMFHtu6r1DbTYKKI4Dem9T7G82QrkCer/bIPEBL3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fa6UDZZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27692C4CED0;
	Mon, 16 Dec 2024 20:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734379983;
	bh=9z+6ELH5uuiyTM6MH1n+deEOoHgAw/exY116v8SrYUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fa6UDZZC/YeDt+DgUzi6sliC6aqkhfUhgE2vBDBu91o/Cn5MGLo84GatGuMHRXgzv
	 9CYg/aafuoYk+YHz8QSNqWPX/7BVXGpx6AreEwnCPLVDUqIGBR1KJpx2/HG66Od0kZ
	 JTd0ppQSmxykHQEsi+pOh+DQTaFdE5ibrUmVFTrxr6Y7QsCjgYEFU2HwT1a1nESrRB
	 Wpp3tryt70Hvyq7AwBKtCLDNUGpiJWwgtRaU3o+iLACr/WqkiUjadFPtfd00s5GwAn
	 euVejRkOzySahmGKrKU0pB7xQyXgEE2vX5Orvpq4tepvXePLyXxTkCjGGcCbjFa2xF
	 mGzSPoROi+Krg==
From: Conor Dooley <conor@kernel.org>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>,
	E Shattow <e@freeshell.de>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: Re: [PATCH] riscv: dts: starfive: jh7110-common: Use named definition for mmc1 card detect
Date: Mon, 16 Dec 2024 20:12:46 +0000
Message-ID: <20241216-elixir-cupped-f7a83bce4e12@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210040652.164030-1-e@freeshell.de>
References: <20241210040652.164030-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=339; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=TXGlr3eOJJ2HgKkEMMrHmxaZTXUHl2/ECdNZ18GXMqc=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOkJnfs1l507Hrbwq2//keb0gNjNK5RuFTz9byjwfe6fm YxXt6xo6ChlYRDjYJAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBEKrkY/lmHr3i7OC2mqU1q Ocebs97sfAfci+/488VvTsn3lpyX8pyRYWegxO1lDxJORSrN2tDazrnrwTKXlsc6ebnpx5lDTt1 6zgkA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 09 Dec 2024 20:06:46 -0800, E Shattow wrote:
> Use named definition for mmc1 card detect GPIO instead of numeric literal.
> 
> 

Applied to riscv-dt-for-next, thanks!

[1/1] riscv: dts: starfive: jh7110-common: Use named definition for mmc1 card detect
      https://git.kernel.org/conor/c/c96f15d79172

Thanks,
Conor.

