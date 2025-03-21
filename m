Return-Path: <linux-kernel+bounces-571621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9EEA6BFD3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F3A1891741
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476B022A7FF;
	Fri, 21 Mar 2025 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7gPvO3o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA891A238C;
	Fri, 21 Mar 2025 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574196; cv=none; b=KQ2/XLgKx8mt4Y5im1uJJHwtw+tsHYwN0RoptRq1N6hS26TRaAOh2qltwYZq0hqLI2WkLDnE/01MWY0Nd6DE9uluaf/eC8iAGX9kZM3t35FRRq5OQWTF4OXbVD7WoHA+QfWRF4qWb3u4R8HTOlKqyl9RMH6PL1/IlcHlA1bHkts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574196; c=relaxed/simple;
	bh=uhN6QJh0tP83UgoduWmaigRwPkVaACTLj8V+BUixCws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANgGDsV2Cm/3VJh6BVyl9GPF8Jgx8AViEvces2fAHVgX74xv5zRhY/LbHbTzGImttGOHzSDjVr37UxskNzYDHbZuxvLzCo2aW/kuXpzCBlbpwp2HzXe1ZO4AkbxVpTsYpJ/gX2LrIzRxRVEmq/tpukUSCVzZRhHXEfdhlzAy/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7gPvO3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B070BC4CEE3;
	Fri, 21 Mar 2025 16:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742574195;
	bh=uhN6QJh0tP83UgoduWmaigRwPkVaACTLj8V+BUixCws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7gPvO3okxvDMLDqE4vtR0NptCjPnaTAqAqUwY3qA/DfySDChcOVpbmG5vpe/8RVJ
	 TUcu7fYT1pYBNBo4cVtentnH6ATRwjYhV+cdQ5304hCyc7giVcUGIL1peapF9KXO4X
	 dCZ3Bw/RstpIWLo8sOLQk1F/lH76+JK5lPWlIHmi45fKc6WWBGieuK3VRGwsi3gFVj
	 meQnBcSupj12gb67FwJHx/QdKAjjM4T84Xr4JPigVlnzD0sckKH9HG1UiHspr9PTi4
	 Kgq+CNkVvN9OvmaQ9UF67LRzXC56ukdco3SYjd4lsdz2e8IP5aR0rkm//NdtUwJJD4
	 1iICj7yAU750g==
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Min Lin <linmin@eswincomputing.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	rafal@milecki.pl,
	Anup Patel <anup@brainfault.org>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/10] Basic device tree support for ESWIN EIC7700 RISC-V SoC
Date: Fri, 21 Mar 2025 16:21:50 +0000
Message-ID: <20250321-trimness-unwind-0ffafee4ac8a@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250320105449.2094192-1-pinkesh.vaghela@einfochips.com>
References: <20250320105449.2094192-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=646; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=G5nMXPv07/5t5qEEHTEA3VTjgeOZ3saVfKZymta3BuE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOl3Jyk6nJ7/OTf/3mtx64Ctwmf+FhRPnFWmpLMvnW2v3 Iz5PoVbO0pZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjARpxyG/8URCaFT+Q/8UrpX 6lXeUV/3Ty9tTemRRZVB7IevGfmfWcLIcM8o7Hvinq2Jy8V3zirel7PHSO/G6kNHXfkkdrNl/zV dxQAA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Thu, 20 Mar 2025 16:24:39 +0530, Pinkesh Vaghela wrote:
> Add support for ESWIN EIC7700 SoC consisting of SiFive Quad-Core
> P550 CPU cluster and the first development board that uses it, the
> SiFive HiFive Premier P550.
> 
> This patch series adds initial device tree and also adds ESWIN
> architecture support.
> 
> [...]

Applied to riscv-cache-for-next, but too late for this merge window.
They'll be 6.16 material, the commit hashes below will change when I
rebase on top of 6.15-rc1.

[05/10] dt-bindings: cache: sifive,ccache0: Add ESWIN EIC7700 SoC compatibility
        https://git.kernel.org/conor/c/a506a819af37
[06/10] cache: sifive_ccache: Add ESWIN EIC7700 support
        https://git.kernel.org/conor/c/4a9d4db6ba17

Thanks,
Conor.

