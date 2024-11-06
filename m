Return-Path: <linux-kernel+bounces-397758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9E29BDFF7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904A12857D7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C44613CFAD;
	Wed,  6 Nov 2024 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjyoJQSH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C01319066D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730880274; cv=none; b=P2CISE7v8RGhNoDM33zTJ8Vjl08NPyQEQNq1SFT6PK4Az+BcZMsRmkDCvpR0RisiMZTYd9Q7Ya3u1SUXhRnP29NdMYEVzl+W6SWcmJo7bSr3K9HJ+6Bn1+WydnXXUZxqURPbZe5l6L8galXuVGKGeOFaBtuMhO/cAiQhjtKOfDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730880274; c=relaxed/simple;
	bh=WoydzqE5y6eKPMj8Pox7le9vVqDUHaS2T14mlPzsFa8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ROofg0qrWQJw8A8Ie5AQq2BTZfZ+ZxmxtaIQHsg1LGXK5+rOuhj9XMTjilM/TK3iyS2XWturt+E+QQXg4A9ARcC+vZjkGR8QSyiyPDORthlSqcXSiYy8yUjOEYOtSbjOmxycyvLW5gJIVzCubI28Ytx8bA1cI0nBynmpS2zCn2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjyoJQSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05ABC4CED0;
	Wed,  6 Nov 2024 08:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730880274;
	bh=WoydzqE5y6eKPMj8Pox7le9vVqDUHaS2T14mlPzsFa8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bjyoJQSHSMfc57i1GjRq7oKWLAo9RBWMPcdz7CC57NSDG12fYOY4KabVrL+O3zJ/q
	 oB2vSzG/GMMXAndPZty0VanVPMvsCjeOkO6f8mA4/uuQWa9vIrIgbSSVum78WTgZG1
	 4v0GV1JL+gHctlmvcHT40xO7mpLmyDLsLurnWSOFjC4ii8WZnrVXctljFrFuPsPmZz
	 WrSLZTZ6ZNx85qi18kXkesZCnnd/IJ7rIPhPe/WTtHmi2KssYFPQ0JajXeLVmD1oTL
	 JhrwvinvBHGz0qA7kHJtB+b1VRGPxPxQdrTLz/WerB3XZeTqXWA2vdUX18ULpqVpjD
	 62Mck2JyUkBeQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Beomho Seo <beomho.seo@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, 
 Zhang Changzhong <zhangchangzhong@huawei.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>
In-Reply-To: <1730302867-8391-1-git-send-email-zhangchangzhong@huawei.com>
References: <1730302867-8391-1-git-send-email-zhangchangzhong@huawei.com>
Subject: Re: (subset) [PATCH] mfd: rt5033: Fix missing
 regmap_del_irq_chip()
Message-Id: <173088027259.3228563.17102383176327136954.b4-ty@kernel.org>
Date: Wed, 06 Nov 2024 08:04:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 30 Oct 2024 23:41:06 +0800, Zhang Changzhong wrote:
> Fix missing call to regmap_del_irq_chip() in error handling path by
> using devm_regmap_add_irq_chip().
> 
> 

Applied, thanks!

[1/1] mfd: rt5033: Fix missing regmap_del_irq_chip()
      commit: d256d612f47529ed0b332298e2d5ea981a4dd5b8

--
Lee Jones [李琼斯]


