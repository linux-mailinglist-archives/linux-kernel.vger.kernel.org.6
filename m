Return-Path: <linux-kernel+bounces-168661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616D98BBBA2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188D3282220
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5682322EFB;
	Sat,  4 May 2024 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U86SWI7j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9986B1C695;
	Sat,  4 May 2024 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714827504; cv=none; b=AusEFpny278qD7UN0RJ2/w/HvfECzLx17aa9J7eWOrAuUe+HdrQA/f0s44pphXGLCjXfv8qtlclOp/08RkUnWcLvnkDGS0FuaL/jD+4c5tt0N8l1O2IyJfKSwACuao6ByFFFbaPwJCmX7qgUO1REd3yCA+KCzrdlZOMs6lfAF7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714827504; c=relaxed/simple;
	bh=fuUV6rbC9KtqaB3E4wMX4NKqb+NpCFrjFTSVLWFhbT4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fw4Ra5cwRVOknSuBbBhBWFd09Q7B3y5AzQ3LAWCvNgmS+gtRME20yEEhzNqOVR2ej9SXyyaSgEL6pD0DAwNhbadeXDJmqkyv0y5gZJjCERJgMBLodQ1qb+oUYCjxIoWzQ/rVgdVnNGD+48k9eLUEwqPMW/qjcEQ99r55OiQ2aTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U86SWI7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74796C072AA;
	Sat,  4 May 2024 12:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714827504;
	bh=fuUV6rbC9KtqaB3E4wMX4NKqb+NpCFrjFTSVLWFhbT4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=U86SWI7jpijgYbli26YHih1UzmitBpjjOF18elIDhbPxqhwFWqrnVJzaaCyqDbS6h
	 4m/1MNIC1PKoW3zEIkpMDUs/E7Y9SxvwZdKXm16q81FJULE/193GUDGBMwiIhSNcn/
	 tUuounrhX7aoU04VkBdP25P/fAzX2BfyVGAeOdvA/ljqinHyfiqc9h7x0RVHucZRpE
	 Vzdm0JFQnqB/YaHmbIHToWLmxPZc5BtHu6DUY2H+g5c+WX6A+UsPMyuu3XZ4kTRNBo
	 txg4m1paRT0FxjnQSPPPHOW/SdJ5pcu0/f8BRhQk4DP0Av6QDv4fZzQ3nQUe40QmIA
	 pkEsaTUuPvvBA==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20240429004321.2399754-1-yung-chuan.liao@linux.intel.com>
References: <20240429004321.2399754-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/4] SoundWire: intel_ace2x: read DOAIS and DODS from
 _DSD properties
Message-Id: <171482750098.68782.2541610580303144917.b4-ty@kernel.org>
Date: Sat, 04 May 2024 18:28:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 29 Apr 2024 00:43:17 +0000, Bard Liao wrote:
> The DOAIS, DODS, DODSE, and DOAISE fields are Intel specific and the
> recommendation is to use settings read from DSD properties instead of
> hard-coding the values.
> 
> Pierre-Louis Bossart (4):
>   soundwire: intel_ace2x: cleanup DOAIS/DODS settings
>   soundwire: intel_ace2x: use DOAIS and DODS settings from firmware
>   soundwire: intel_ace2.x: add support for DODSE property
>   soundwire: intel_ace2.x: add support for DOAISE property
> 
> [...]

Applied, thanks!

[1/4] soundwire: intel_ace2x: cleanup DOAIS/DODS settings
      commit: 80962485f62c3c33730407a8059c6292194cb887
[2/4] soundwire: intel_ace2x: use DOAIS and DODS settings from firmware
      commit: 3b0b441a297e7fe11baab51439a81cd6a336ed64
[3/4] soundwire: intel_ace2.x: add support for DODSE property
      commit: 75933ba58dd49ded547ad0d00c74c0cb862530f9
[4/4] soundwire: intel_ace2.x: add support for DOAISE property
      commit: a0df7e04eab07cb2c08517209f792a8070504f0d

Best regards,
-- 
~Vinod



