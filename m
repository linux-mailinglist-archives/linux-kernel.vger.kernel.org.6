Return-Path: <linux-kernel+bounces-360515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8892999BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708071F2474E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 05:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53721F4FDA;
	Fri, 11 Oct 2024 05:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDIrk3Hk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7772581;
	Fri, 11 Oct 2024 05:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728622970; cv=none; b=mkL8mXYIVN3Sg9JvBjSUV/CJtJuoxo8toMVRj9HQhrjdncm0N7ZP43K6mxchQSOgaoskoPwjKwRwdyBTv/SW6X1ROKuOdT+6Xhe7IYlWg85b8FyMAwVjP1tbpM2um9Tl2W5duvsg8xpQvze8Mw6KsmLexnYFX79z+H6szItX9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728622970; c=relaxed/simple;
	bh=B+sLWmKRT1T9vEjd5LmbOryJh3J4YeWOr3mb4n15DRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6zEIU1f5Pskmb1CK+04/GT6s6T+yFzgdQEyJqCbsqmSnJ6IOSr1d/Cu/MAFW7FYRJuNqlS1SjkxgjRghBLubsJIbSN3T4rGTjAMqNTCQLmGkUfU4j3jbPV1CGeXf69XL7o1qIgYHf7kyxHkl+JkEHkwPH8AdNrdDghHwJL9tco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDIrk3Hk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C49C4CEC3;
	Fri, 11 Oct 2024 05:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728622969;
	bh=B+sLWmKRT1T9vEjd5LmbOryJh3J4YeWOr3mb4n15DRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZDIrk3HkxbUc220z9iFo0GCWNJvPtsi/EULO78W2Zf1RTHxADX4Yg0ILqgXq3aXnU
	 oF0XrfbcW6kmN/t6M9EXML1R05lO5LIz9erJdlBqskYYGl7IDE6np5UVo3ysMOKZrL
	 EA/q25wTVCtypVd6UEWiNq/1NUyhRuA5GnfNnd35XzktlI9bJaijPCCXlHJjSD8KBR
	 usfWDKV1LXxiB1r42w4eVz9MgRmM0NFRSw6w/lcavBb5JCaPev2PCNd+pkSGQcDEf0
	 XouMB2VL6QTo4/AzGDqPrEriEeTZ5m4ZJRmuIKzOtCZ9GESB6ZZpj0eM/k2LaHlXub
	 UZHodKv9RDBNg==
Date: Fri, 11 Oct 2024 10:32:44 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: broonie@kernel.org, tiwai@suse.de, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, pierre-louis.bossart@linux.dev,
	bard.liao@intel.com, peter.ujfalusi@linux.intel.com
Subject: Re: [PATCH 2/2] ASoC/SoundWire: Intel: lnl: enable interrupts after
 first power-up/before last power-down
Message-ID: <ZwixdK/n4RgNhJL+@vaman>
References: <20241007121241.30914-1-yung-chuan.liao@linux.intel.com>
 <20241007121241.30914-3-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007121241.30914-3-yung-chuan.liao@linux.intel.com>

On 07-10-24, 20:12, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The HDaudio mlink support makes it more logical to couple interrupt
> enabling/disabling with power-up/down sequences.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

