Return-Path: <linux-kernel+bounces-227758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4867915649
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43361C2133F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420A21A01BE;
	Mon, 24 Jun 2024 18:12:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFECB1A01B6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252733; cv=none; b=H/dUIHxJGnD3TUTnKiMqwqkN7YirUL8m1fK9rSZ2PP2XcHc4eKICf9YiTrgm96OvhtG2vDJCgjAAvohDkVEBqRX/Rki/5wGAtwzbp1kJRd0dPVfMoPsJjelBCO3AO3KCXEybyasWETdRdlxlnGLTTueLO1qXGrU1HRLD9GJjFus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252733; c=relaxed/simple;
	bh=buB3ylu5FxlPNoR4IkXEIpc7ATfwz6b2lWleP5DMVTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCY9xbUWRQ8f7uVO8vC8PlBJwsXiA0eLmQ1ioVMxuI4F8klWzjpfV3VSIyASgXMSaVQgG8BTbIngg4uJvHbyDrNZHT0YiuRukE3nFRS93qzXUf6Sem/1ut/7vAE8oMv9i0OTeWDK7p0XdhMloJpZAxN32e+vHYTYezrwdJulFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D891DC2BBFC;
	Mon, 24 Jun 2024 18:12:11 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: alexandru.elisei@arm.com,
	linux-kernel@vger.kernel.org,
	maz@kernel.org
Subject: Re: [PATCH v2 0/5] arm64: irqchip/gic-v3: Use compiletime constant PMR values
Date: Mon, 24 Jun 2024 19:12:09 +0100
Message-Id: <171925272545.3100285.8769870168979819499.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240617111841.2529370-1-mark.rutland@arm.com>
References: <20240617111841.2529370-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 17 Jun 2024 12:18:36 +0100, Mark Rutland wrote:
> This series optimizes the way regular IRQs are masked/unmasked when
> GICv3 pseudo-NMIs are used, removing the need for a static key in fast
> paths by using a priority value chosen dynamically at boot time.
> 
> Thomas, would you be happy for this series to go through the arm64 tree?
> The key part of the series is the final patch which changes both arm64
> and irqchip, and I expect merge conflicts or functional fallout to be
> contained to arm64.
> 
> [...]

Applied to arm64 (for-next/gic-v3-pmr), thanks!

[1/5] wordpart.h: Add REPEAT_BYTE_U32()
      https://git.kernel.org/arm64/c/118d777c4cb4
[2/5] irqchip/gic-common: Remove sync_access callback
      https://git.kernel.org/arm64/c/e95c64a7fb71
[3/5] irqchip/gic-v3: Make distributor priorities variables
      https://git.kernel.org/arm64/c/a6156e70316b
[4/5] irqchip/gic-v3: Detect GICD_CTRL.DS and SCR_EL3.FIQ earlier
      https://git.kernel.org/arm64/c/d447bf09a401
[5/5] arm64: irqchip/gic-v3: Select priorities at boot time
      https://git.kernel.org/arm64/c/18fdb6348c48

-- 
Catalin


