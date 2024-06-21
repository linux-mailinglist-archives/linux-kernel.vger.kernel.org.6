Return-Path: <linux-kernel+bounces-224366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8242B912166
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B379B24533
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900C316F8F5;
	Fri, 21 Jun 2024 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlSNNs7R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D763116FF2A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963907; cv=none; b=ExbmQ2mrSq+HviVBWezc2GvWrIyithbti6s768kOe7jpfaoyPOcSlDNPwe+UWXNk3GlFzu3qpK1uqYuTro+Ts2cy/MnxeO7uKrqh9IhCLZQ7tbqJ3Wm5aIl4JSuOfXTR1URZpUiyYqFFzYw/oA+97OcBgviKCFN/IZbfYt/jcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963907; c=relaxed/simple;
	bh=yIT38m0X5h/xAUdgyo6UZokPqNben8J1c7EywYPzAcw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HSLmy4o7Lrp3DM6cLZJp/ImsSn87f7Hru0Je4qYQAofUn7ECAriBsxGIhJggIj87eom23iByZo3t34AvDPgl9dXMei5gQRUo8XATADJO1hFUElfQgm+6VdEYY0mmfNuksXz7pjuPEUMdnT18I46/6SIrGc0VQ25DOvBZchRoFg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlSNNs7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811E9C2BBFC;
	Fri, 21 Jun 2024 09:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718963907;
	bh=yIT38m0X5h/xAUdgyo6UZokPqNben8J1c7EywYPzAcw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=mlSNNs7Rcj3RJam78NY9YP8LdXzuuBK4GaRNqDpQ8ljcb35Us/tDqm8D5OoE7S+cl
	 Aw57zgrvYhInOBxlEvWqOndAJZbOCSqhWYx9fvDjTPlgS3BtG0VIDg1lYtqKhKcw05
	 1igAuhzrobVoClbgEZdhLgHh5S9HpnHszFglGULr6UMaREeojNxhYZSyfjNDWRVK9e
	 e/vqOHhl1gmfnVuqcowBYJ6nGQtztm/zq++dEPUiZ3A50k//7j+Q9nuUwJSSOIDesa
	 cxZoNKBDJIpeuiAUjfu3EovMylZi4HoYgZ+SoTeXyqWTd0jozkiG+I3datYGJdW4Qk
	 ARBLZDFKR1stA==
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240620091046.12426-1-krzysztof.kozlowski@linaro.org>
References: <20240620091046.12426-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] soundwire: bus: simplify by using local slave->prop
Message-Id: <171896390510.263874.7819997619365288749.b4-ty@kernel.org>
Date: Fri, 21 Jun 2024 15:28:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 20 Jun 2024 11:10:46 +0200, Krzysztof Kozlowski wrote:
> The sdw_initialize_slave() function stores 'slave->prop' as local 'prop'
> variable, so use it in all applicable places to make code a bit simpler.
> 
> 

Applied, thanks!

[1/1] soundwire: bus: simplify by using local slave->prop
      commit: 5a4c1f0207d8925c45a516d8dc85f0dd70c020ef

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


