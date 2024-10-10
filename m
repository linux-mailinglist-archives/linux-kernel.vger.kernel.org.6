Return-Path: <linux-kernel+bounces-358952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F03A9985B1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB291C23AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA2F1C1AA9;
	Thu, 10 Oct 2024 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIKsFw93"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E871C1757;
	Thu, 10 Oct 2024 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562561; cv=none; b=QN5x0FPSBdwzNuKXbFWgO6nozdFQihuCsFws628MaLy/boEUYiZxRApnXw4ooCFbEZfXYg8440cbNfV3Aa4+tC4bdnWNZi3LspwiD6C2hHOtSn9CKIDKoQHwDkC1GjUNKpQihPmxxhGEmfJyGML5VEk0obVkOXFz8h7mHcLwAg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562561; c=relaxed/simple;
	bh=QYM5VF0qjxk3FqTLWXpMoz+67UlOrWS/8TiVE7jvYRE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bF19vJZaVX51tHx8pH2/2XJYHJC0kUcb18sLdVORKCSSFxNnPHO9WGbwlHTL9SxHbkUdST/2xGgR7UHWBfPemXDfET2g1zMiDfBhLvxjfwM0XRtO94huCLIpIJ5WArWY4KCDmzG9pH/rksIiOjjGOhqbE7Y0vok3h02ybYb3+50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIKsFw93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE639C4CEC5;
	Thu, 10 Oct 2024 12:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728562560;
	bh=QYM5VF0qjxk3FqTLWXpMoz+67UlOrWS/8TiVE7jvYRE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aIKsFw93XicltnMWXukxU4uAHbXhny2QlK8Pqunu1ivkvaBFGSa3hqobSy3eIRaXP
	 0iArtV6LE7l14gDrk2uvGFouvo53Ps/JCzQveZ9seOBTkgdG3ZmaxVrvdO6qvrqKe0
	 0GNF47GMPL8yWNaSgcKvrly9MMDX3Sz/c8JgLk49/zKimZqEB+RZ6DL7Si7PriXQMJ
	 KbklbbU0A+TcTS7Vak/K7zMh7IYn0qsMmKAy//CT7AxdVR8CoBWv7PKDsdDs3qgFgO
	 SuBdAoEjkQIx2Z/GTcHN6KLvuNbu66tf0KIjEPOwlBOhNYMfLej9u6wmfJ7Z/sW8s9
	 ZT6smxNhZvY0A==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.dev, bard.liao@intel.com
In-Reply-To: <20241004021850.9758-1-yung-chuan.liao@linux.intel.com>
References: <20241004021850.9758-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v2] soundwire: intel_auxdevice: add kernel parameter
 for mclk divider
Message-Id: <172856255861.307286.1884919518191376671.b4-ty@kernel.org>
Date: Thu, 10 Oct 2024 17:45:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 04 Oct 2024 10:18:50 +0800, Bard Liao wrote:
> Add a kernel parameter to work-around discrepancies between hardware
> and platform firmware, it's not unusual to see e.g. 38.4MHz listed in
> _DSD properties as the SoundWire clock source, but the hardware may be
> based on a 19.2 MHz mclk source.
> 
> 

Applied, thanks!

[1/1] soundwire: intel_auxdevice: add kernel parameter for mclk divider
      commit: cbcb7edd099aee3f001c008fb8bbb1c0d2b7154c

Best regards,
-- 
~Vinod



