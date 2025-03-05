Return-Path: <linux-kernel+bounces-546937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12065A500EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DC9188B5F8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF1D24C065;
	Wed,  5 Mar 2025 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="LDmPYd2o"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDDB24A068
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182223; cv=none; b=GqZPdTwhNSlLnlAMnnrUvpuLtj2SLk3iEwWh7Ts4Un88leqAJZ0eHoxQFZOJLRqtlOPxImiLKSzGi6Bx36AynarcNOf2pRKO9/b6846ThchdYuw9iTxGO54hmFFkQCl5sk3CPdvkSucz1vcDUxKc7a33kr97plozNaQc6hTX+tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182223; c=relaxed/simple;
	bh=tFeLYQTId/SvT8ZMflCA2uIgO3LKdT/H7M+FsOvO4sE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qbSFAJGlURknlAIQX0cyC2OCPUWq2/wkkmoyjJqhpV7UPI1TolosW+vOVQiwoOmU2SChUPVlbpGLUGhGq6SKtHG5REn/UyNa1IJ3zYPriuKrnOxJJNy1KcRIEUoTQ0sDf27XP0muYiiUATo79TXqQokfWcW5QaKLfXpRO4Q+XAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=LDmPYd2o; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1741182217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vo2hm+yMszxw3H9IReAl6SWR01jDv9fDEr6AUb0zh0U=;
	b=LDmPYd2osyiwOtg15j1DhkvRsDox4S/7CWQcaQHJwA3oEc6JJUovfPV/14oJeBHS+QyeZX
	f38N7q/ngNHs7ROVDw/Y01T9VIX69i2GXD0+VJ+U9AUTCXQjc2NVr6CzioyKDytl2cWST6
	eCbK/4AOWjNPMl4osjXe1Y3cO/67NGudq5CTPMkggcoVgFAv/r4iNAdtuYUFGq8NZ6tdzn
	W4dqHDr6TdOJPzAUAkvEFxKLz5VW9Kw4v864lc1ZWVDx31e/73SnimmCSxfs/yaxHPbJ+i
	Gl5R/rx//ZM8CD5USk4LLF8+8GQhZTESdJRqKfit6nGzoU+dGqNKsgfLqRl00w==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: fnkl.kernel@gmail.com, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: j@jannau.net, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, asahi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20250305020546.96564-1-jiapeng.chong@linux.alibaba.com>
References: <20250305020546.96564-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH -next] drm: adp: Remove unnecessary print function
 dev_err()
Message-Id: <174118221552.156796.17819891844477649355.b4-ty@rosenzweig.io>
Date: Wed, 05 Mar 2025 08:43:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On Wed, 05 Mar 2025 10:05:46 +0800, Jiapeng Chong wrote:
> The print function dev_err() is redundant because platform_get_irq_byname()
> already prints an error.
> 
> ./drivers/gpu/drm/adp/adp_drv.c:470:2-9: line 470 is redundant because platform_get_irq() already prints an error.
> ./drivers/gpu/drm/adp/adp_drv.c:476:2-9: line 476 is redundant because platform_get_irq() already prints an error.
> 
> 
> [...]

Applied, thanks!

[1/1] drm: adp: Remove unnecessary print function dev_err()
      commit: e4c0fd3f965533cd2b38200ca73625afd602d39b

Best regards,
-- 
Alyssa Rosenzweig <alyssa@rosenzweig.io>


