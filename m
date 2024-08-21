Return-Path: <linux-kernel+bounces-295876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EBD95A25F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F2B2879F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C267B136E09;
	Wed, 21 Aug 2024 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OawoPRUT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C1E1C687
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256340; cv=none; b=kEk/SP+Crmg5cLPraoRTGFN07pi+Tro9uw/E1lcbLw3y72lkygA60LOVj18qSTjaYz0hl8uSRkzLWCeiRKOrdRpJcJbtZaHRZ9e+efdAU/bqyA6aW54Js9U9TGja3jBQjAzJct35ke3yhnjy5Lk2TLUpqOt1KcgM1eKUfweb/L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256340; c=relaxed/simple;
	bh=oaxu8ws/+NB+3MPjDQ663bhvmqdM1Od2djHQXs7Mlgs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dNljWY8/E3IAe29Th8aZTkfQYvgaN9dUFbuymWGf0gNYSTGWA9ZUeW7Jwbh174H/qRqADIQ8+zN3uihha6FDUs+CVgtUGL1xFOqVbQ4O532Dr5otUmVXjwcbbVrMxcomjSutmH32lxz59aWhCkQrGEzSVLhmItrsxhJ7bGwhEfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OawoPRUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4D4C32781;
	Wed, 21 Aug 2024 16:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724256339;
	bh=oaxu8ws/+NB+3MPjDQ663bhvmqdM1Od2djHQXs7Mlgs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OawoPRUTYj0eu9jItV3naNbvoBFBQT/epwKXVG0B2oiiQbOJWwE5FTDS+RZJdvVK1
	 Wj+VkDDvD2mjZ3qGIb/XZLnIkGpf3lQmvWDrR4tTacdQ+xOaXse0lfYxbE+D2Zn3m8
	 rGEG+LDb+AhSeczjt6B5+2m7e31X7FLO1aDUl22LTRSRZMZP6WSFdhd/CPHVXeZn2C
	 BNQTmLnXuL88lTlzs0rG/BP6r0fusZwexAPIydFQH106PmE9ivWwTK0gg7FUKvsGOw
	 p1Ef+T9F8++SdJpwaiilXaCkJYtHmvDqexNQJ/Qb15k3gr2eXg9z067Vatwr7oPBg8
	 SrsQuladhd5zA==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, Liao Chen <liaochen4@huawei.com>
Cc: cw00.choi@samsung.com, krzk@kernel.org, lee@kernel.org
In-Reply-To: <20240814025710.3875859-1-liaochen4@huawei.com>
References: <20240814025710.3875859-1-liaochen4@huawei.com>
Subject: Re: (subset) [PATCH -next] mfd: max14577: fix module autoloading
Message-Id: <172425633838.1098397.10024560779171253032.b4-ty@kernel.org>
Date: Wed, 21 Aug 2024 17:05:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 14 Aug 2024 02:57:10 +0000, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
> 
> 

Applied, thanks!

[1/1] mfd: max14577: fix module autoloading
      commit: 9b443909657acc0439d1c78dbf98c15d67e2b546

--
Lee Jones [李琼斯]


