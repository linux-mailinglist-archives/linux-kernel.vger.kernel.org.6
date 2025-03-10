Return-Path: <linux-kernel+bounces-553612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61636A58C76
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0622B188C434
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C67A1D5AD9;
	Mon, 10 Mar 2025 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwMkueU8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876E71D54FA;
	Mon, 10 Mar 2025 07:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590370; cv=none; b=W7CL1zly6dh08x0cYNfwZvOw3+FE03tggMUU7BshvTU9oLw/z/uvk68q7XiFSP2leUggD8e9mLi4XerGvJsOGZdFsTpceWUxQIY2Vk8vTlRk3V2mnXv4rvVWCNIkFe1gKQV/Wdv6ggYthLSEQ00CVAflsUTCnj+ZKeJuWLHl+nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590370; c=relaxed/simple;
	bh=dely0WkpZhW9G5y6TR4CN3t7bLGidi5lnjr6+/I7Dw4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZeLFgThqRyHgrc9AKYPLn4pkzJ3vyMjTJSKqTmhjquVFbsNxhz0NfwmL4KM8MuOwpnvUN2gZ7i0iqawDWxBS71Za8HSOBpIYQ52pQ5fa4IEnUNthL/4FD/unotZfKIpFzCJumW6IGe2QwW08j1DCgxfCQroIDGTL4bCCBGSJn2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwMkueU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2168C4CEE5;
	Mon, 10 Mar 2025 07:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741590369;
	bh=dely0WkpZhW9G5y6TR4CN3t7bLGidi5lnjr6+/I7Dw4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DwMkueU846Ed+Gmf8Ltu6fs8CAyhNAws8EahO5MyBVLHSbML8mIyiv3rW3EIpRct4
	 AHA5LnSwMfhnVwbZ0xQicPctAJ/w4nPy7r1SIfN6xw3czauXVsdeAhb1Cd/O87euTu
	 6mEcWc1A/CEoPk9mxIKIA9N1eMpywrgqe8MqM0acHkqSYgDUm0cGVG2rpmKEDevX4L
	 oRNzE9jzijfEpHsBxrEcTXFtu1SKqUKj7Z9YhCBSspT5cQZQKJZgO6XXWlala9S2mR
	 ulEUfUGlTJq/U7A/q+5B/jWizv6eg9ISp2gFAHWgDPAhY9PfsNPQrNnU98mN3AYDYm
	 zUgTGsaYq2y7g==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, broonie@kernel.org, tiwai@suse.de, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.dev, bard.liao@intel.com
In-Reply-To: <20250227140615.8147-1-yung-chuan.liao@linux.intel.com>
References: <20250227140615.8147-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v4 00/16] SoundWire/ASoC: add SDW BPT/BRA support
Message-Id: <174159036743.426660.895612998776430727.b4-ty@kernel.org>
Date: Mon, 10 Mar 2025 12:36:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 27 Feb 2025 22:05:59 +0800, Bard Liao wrote:
> This series adds support for SoundWire BPT/BRA. The change is mainly on
> the SoundWire tree. It is better to go through the SoundWire tree with
> Mark's Acked-by tag.
> 
> v2:
>  - Add MODULE_DESCRIPTION in the "ASoC: SOF: Intel: hda-sdw-bpt: add
>    helpers for SoundWire BPT DMA" patch.
> 
> [...]

Applied, thanks!

[01/16] Documentation: driver: add SoundWire BRA description
        commit: 3641c6392695b0846e80a4c1245d7139c8ed7d48
[02/16] soundwire: cadence: add BTP support for DP0
        commit: 3e3ae0c8fccc51021136b192ec88e94a1bc5704c
[03/16] soundwire: extend sdw_stream_type to BPT
        commit: df896e4f7cf5cc3abffb186e2b6815b785500b57
[04/16] soundwire: stream: extend sdw_alloc_stream() to take 'type' parameter
        commit: dc90bbefa792031d89fe2af9ad4a6febd6be96a9
[05/16] soundwire: stream: special-case the bus compute_params() routine
        commit: 00f57195f10fa7e2fa2ceeac0b2768ae544fee2e
[06/16] soundwire: stream: reuse existing code for BPT stream
        commit: b422b7237ead30bfb90f52c7563ef518a5849cd9
[07/16] soundwire: bus: add send_async/wait APIs for BPT protocol
        commit: 9a756289ac5a8517dc643555d784d830b61576ad
[08/16] soundwire: bus: add bpt_stream pointer
        commit: 8e4a239b403bd8aed8787798de8e4e42f79246c2
[09/16] soundwire: cadence: add BTP/BRA helpers to format data
        commit: 8eb5d7ade8b1ed1678cdc5340ef3f6d346eed9be
[10/16] soundwire: intel_auxdevice: add indirection for BPT send_async/wait
        commit: 7f17a73a7dd8252aa88c6f5e23310861de3d5423
[11/16] ASoC: SOF: Intel: hda-sdw-bpt: add helpers for SoundWire BPT DMA
        commit: 5d5cb86fb46ea1c7efd3b894f63fe364e5847043
[12/16] soundwire: intel: add BPT context definition
        commit: 5cdc23764da8be3c1b2c022ddce95dd8e49673da
[13/16] soundwire: intel_ace2x: add BPT send_async/wait callbacks
        commit: 4c1ce9f37d8a809dcdfba082cc9003880efa0a63
[14/16] ASoC: SOF: Intel: hda-sdw-bpt: add CHAIN_DMA support
        commit: 3394e2b125043aeede344d28fc73b3c0d2a5c21f
[15/16] soundwire: debugfs: add interface for BPT/BRA transfers
        commit: bb5cb09eedce756eaeb66c69b6dac0f16e464e24
[16/16] ASoC: rt711-sdca: add DP0 support
        commit: 9452422fc321f105a38435bc72afe5fd2c51882b

Best regards,
-- 
~Vinod



