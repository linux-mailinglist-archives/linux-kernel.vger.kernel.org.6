Return-Path: <linux-kernel+bounces-247042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C610A92CA39
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036AA1C223FB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049D057CB6;
	Wed, 10 Jul 2024 05:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhby9sVS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44324A47;
	Wed, 10 Jul 2024 05:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720590356; cv=none; b=VPEZOnDn+PujUC9WzrMDxs/0YNqhojis49Rl6AIETVxezr6OhFACgWx1ZshmP3mVRETM6IhbD+necWZrSKHCP8iH1dfJuCe6806ESRwsj3RUluU3WG1htSsnmt+EPRQrcqCDZllIjPQWIcriYtIVQgX236pBrd0uzqDxUS90Ni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720590356; c=relaxed/simple;
	bh=vDXmEH/MwFC9+pQQHmU6jkKyYAMEnpLQl1tDYjaedS4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IrEHD0cPSLJW4c6alIdL45eRH9As6uVv2RhC4sXCUTVjh7eO0SmUIczHHdVGBKO74ouu9GogIQ/+5Cd85e0YoQBSzzay9oSgwf8bW8wpSbxAPcEGlhrIeXkCCtWi60OiDJJkj3sNelvQy8Bo9Vyl24/+5Rl5rjFhFS2okKuhGJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhby9sVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A050C32786;
	Wed, 10 Jul 2024 05:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720590355;
	bh=vDXmEH/MwFC9+pQQHmU6jkKyYAMEnpLQl1tDYjaedS4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uhby9sVSa5D7G9z4Le7hkLM/ICeizJ2lR5TJNxBTQ73fGvLwyZttizmRb5D2PnP/W
	 sCiY/pidwQIyKlFS/WGqwOdVc2Pq2tnd1U7UwHSxvWjPxxPGcTEUMD6+zerJgiM7mA
	 y4keNkjWCf4wJ2XFMiciqRXjhAvufW9PSbSXwsMJvAZfZ8uJNgzn18hC7ik4BqX+y+
	 PftMaZ+tA5gjdxtvMVlNsasqK1zRYTlnudwlwrik/JqJiY4uIg/Eh/vlSRhP0WFIvN
	 ngyzWkhpVFSIBiyDhES+z8F2iIPmHpDI/0HagA/IHrKqZAtwO4+k+VrzgWoIE7Vmg9
	 cZTr+pcZnEhSA==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20240704003411.10347-1-yung-chuan.liao@linux.intel.com>
References: <20240704003411.10347-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: intel_auxdevice: start the bus at default
 frequency
Message-Id: <172059035276.363871.9323069657079411104.b4-ty@kernel.org>
Date: Wed, 10 Jul 2024 11:15:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 04 Jul 2024 08:34:11 +0800, Bard Liao wrote:
> When platform firmware exposes multiple supported bus frequencies, the
> existing SoundWire support selects the maximum frequency. This is not
> aligned with the SoundWire 1.2 directions: the MIPI recommendation is
> to start at a 'safe' speed, compatible with the default frame rate and
> shape, and only increase the clock when vendor and codec PHY
> parameters are updated.
> 
> [...]

Applied, thanks!

[1/1] soundwire: intel_auxdevice: start the bus at default frequency
      commit: c326356188f1dc2d7a2c55b30dac6a8b76087bc6

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


