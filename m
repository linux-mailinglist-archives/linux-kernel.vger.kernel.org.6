Return-Path: <linux-kernel+bounces-290981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D5D955BD4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 09:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE5C1F21D9F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 07:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E55D17C7C;
	Sun, 18 Aug 2024 07:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8BUWnIo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3C317BBE;
	Sun, 18 Aug 2024 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723966140; cv=none; b=plb9g4Zb5yrhGNTdhthZ5RLLs/xgFoV20WsphW9VRgdnwesF8mElR+l7Wdx/c2zqy8ZC2CfOv2kj+dQIrEJr8D3lkurRc2JsE+u2FuZIC7MJitnUyH/LCYpe581K2Hj6oMRB1+1DdHMXDpJeqIPsZwGQjjlkVrm1wta99gs++qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723966140; c=relaxed/simple;
	bh=fdiA/nubjDzgaO8d4ynk/avtPhGWva8ZWhFS6UXqLdQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UjKTlqSHZ9R9u6vXafQZRh4x8pU4b64v9scldjCediD1+IJ8X7aDckTqmAmdq6gIVZ+aBgrvhtjSLPFAgq4KGbZlBA4agXQYIBG5U2XQ9ZN3Tnx4hrtqJUPnXGk7NikOWGE0xGl7GFH5hSHIzKhn+quS4lABDk0jBmzDFVfQGbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8BUWnIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B227C32786;
	Sun, 18 Aug 2024 07:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723966139;
	bh=fdiA/nubjDzgaO8d4ynk/avtPhGWva8ZWhFS6UXqLdQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=G8BUWnIo7osb38b0wOzaDc7R5KIJtnRzZNtcZWxBoIYh3VYbgW0NwEttVwDqFx0ed
	 u3ZeFy3ojVrAWqRcfvYN+NoGkINyeIbnOi5iwHS9Bw49KwfdpO0nBNzYuEfLL0Ls/8
	 fB05WmGXRq3h9jZwi0diVI05T6hc//bXlkJw4ZXwAu7NouczXrSs1iBe0lE/5+lFio
	 2AeSM2ItPMoYeY1Vd8/VDDyR0JAfodmdEwVcZigEtlkUGgK6aWw0ZBLbEDiYVO8uJb
	 N4QYjM7m57mZdnYqAOK1JjdfW+SZAXHeDcNlCLGgIxQbYQbD09QBjztlDk7n30dx68
	 q/OqsRfU4pYPA==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20240805115003.88035-1-yung-chuan.liao@linux.intel.com>
References: <20240805115003.88035-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: intel_bus_common: enable interrupts before
 exiting reset
Message-Id: <172396613728.999616.2602960995757572106.b4-ty@kernel.org>
Date: Sun, 18 Aug 2024 12:58:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 05 Aug 2024 19:50:03 +0800, Bard Liao wrote:
> The existing code enables the Cadence IP interrupts after the bus
> reset sequence. The problem with this sequence is that it might be
> pre-empted, giving SoundWire devices time to sync and report as
> ATTACHED before the interrupts are enabled. In that case, the Cadence
> IP will not detect a state change and will not throw an interrupt to
> proceed with the enumeration of a Device0.
> 
> [...]

Applied, thanks!

[1/1] soundwire: intel_bus_common: enable interrupts before exiting reset
      commit: 5aedb8d8336b0a0421b58ca27d1b572aa6695b5b

Best regards,
-- 
~Vinod



