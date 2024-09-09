Return-Path: <linux-kernel+bounces-321590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46ED971C85
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D9B283C9C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C732A1BA28D;
	Mon,  9 Sep 2024 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMfG4FAH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3357E146D75;
	Mon,  9 Sep 2024 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892135; cv=none; b=ivpboIF9gM1ilP/c5ScfLwPHcZ5QnuMuUKjpI8ZOgn8PewvfLLWDW2wJHP5m2Z4cuREo1XV/T7O20Ygudozn042dn7V/tLeCNRyL1y8WtAGxenUVI99zzkSheS1+hspfXX7ybwAqOReZPA+/SXA0o0UIkHLyCoNnvp/PPuYKckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892135; c=relaxed/simple;
	bh=70ECI3PT56H5f+bIxujdNUahh4NNGp8iAXnMrm0sGiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHBwqXe+yTk7Vr4n5/kBs387HFFPsQ0E+xXMjSbVX0Buzx97AuW3pjLE5MvNDOeUAEPzki9kVjbQ8vQiY8N9y6yJY3YrB71y82pADNoqihQfLXr1CA0Nv00lVoR34paCVu7y08TYsZaBIQabURcjJX906pJSzJafQJgB0NkLGSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMfG4FAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22335C4CEC5;
	Mon,  9 Sep 2024 14:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725892135;
	bh=70ECI3PT56H5f+bIxujdNUahh4NNGp8iAXnMrm0sGiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bMfG4FAH1F9uqI2ty31tw6aM1zE0QLonfXMxz7JH+MlP7kpt6uFsIpDcKJKOLWdo1
	 aBcrYv5crh88sSg1jvmbmH8h1QrGd581jp0d2QDTxYe8Cdo/5nXmrhsuky1YtRWght
	 3Q9JnMf864TZY/3HG2IVVvH3VEQhUrp3eH+Tc4b9wLRYDmzH8OzKbjtDjTuzHJVLVS
	 JnbzjCMptk2APW9IFsgZ8ES2QyvXvGpzpk+Jllia84Kb+LgS8qvJ27fXsQUyt68jTE
	 t0gIuFY/eqqLJ+snakH6N+OdDpE7rH0C4sIVY7Mhj5JIoZL/Zy0xml/L1EVBoTfFns
	 WuTACqLab9WyQ==
From: Conor Dooley <conor@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 0/2] Add notifier for PLL0 clock and set it 1.5GHz on the JH7110 SoC
Date: Mon,  9 Sep 2024 15:28:22 +0100
Message-ID: <20240909-hurled-october-acb5ce74f3bd@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240826080430.179788-1-xingyu.wu@starfivetech.com>
References: <20240826080430.179788-1-xingyu.wu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=808; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=c9PQ+0Yrbg53RFDH/0h7VN9R/+5GlYD5aOg3NQ5HHk4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGn32ViTeHzVV9cHGBkYb9vaI6vX/U9khe+Kz9OsmEOWX o3689uro5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABPxLmZkmPX+9noXPxUW759H rvpWJQrlGZwQ35cm/PE1p8n3tMVa/owMR+SEIwwn7HuW2rOyjKFv45HH29o/qFUsiP5VUVVo/X0 ZAwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 26 Aug 2024 16:04:28 +0800, Xingyu Wu wrote:
> This patch is to add the notifier for PLL0 clock and set the PLL0 rate
> to 1.5GHz to fix the lower rate of CPUfreq on the JH7110 SoC.
> 
> The first patch is to add the notifier for PLL0 clock. Setting the PLL0
> rate need the son clock (cpu_root) to switch its parent clock to OSC
> clock and switch it back after setting PLL0 rate. It need to use the
> cpu_root clock from SYSCRG and register the notifier in the SYSCRG
> driver.
> 
> [...]

Applied to riscv-soc-fixes, thanks!


[2/2] riscv: dts: starfive: jh7110-common: Fix lower rate of CPUfreq by setting PLL0 rate to 1.5GHz
      https://git.kernel.org/conor/c/61f2e8a3a941

I applied this last night but forgot to send the ty email.

