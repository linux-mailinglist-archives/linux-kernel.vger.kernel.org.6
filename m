Return-Path: <linux-kernel+bounces-513668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEAAA34D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209191612C7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BC8241693;
	Thu, 13 Feb 2025 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAs7UjPc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5DE2222D2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470279; cv=none; b=kA8NuhQirYtwfLP4B2TUdHCXSSk9juIUEMtn6yzNlZjLLlxQV9UI1l4pOBUk2WwTDSATS8zpdXvsSYkRL2babcHuE0xP0WPfUDWM0M1oOqz6bYpx7oQfb9FroQ7c8fRN4bW9lzkptauXcwbESYF1i3cd5Zh3tjSBNrzgM7K4b8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470279; c=relaxed/simple;
	bh=i/aKh+UG4eFXBFc2spO6dzy+TGHEer6l9Vaf+E4l828=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d4xH98hoCPYQ8BbS5peE/omJCrKjEQAsen6LC8JFXY1c1Ulp+4/cwNeAcZ9XHVNjJjAF6YNCsk1F2q+jHoOSzCblliWlYSCBcE+SiYqb7e/XTqdCmquJ4L392Dp0UDzRWn15Mj0LQz6mKicgMo9HKq8PaWPbSn5epub+siZ5vxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAs7UjPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B488EC4CED1;
	Thu, 13 Feb 2025 18:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739470278;
	bh=i/aKh+UG4eFXBFc2spO6dzy+TGHEer6l9Vaf+E4l828=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GAs7UjPcMZYhRHW/VAhhAbTZSdfuBh9xCaKTHWp7t15bb68giQEhn4MIaFygJMQdq
	 ssG2FoTYFTaBSjWkQp8DUClgwLoUy0KHuRQ6fHs+nVoihMyA4B/hYowSGHJfO+lvns
	 bgqSceD0iFLtiW72ZzwR79bgIpZ4Vbs376bNOpBegBziQI7Us3g/IiU0U4uF4R2m8a
	 SNVZRLrZv1mBflF7CSkejlRBuEsX5c39yJDTO4kObxpZgYwPTiwI4y3OCBH8LvPsT/
	 HrbhNgUNdQel7UslBUZYHxovQaCdo+PTQgZbkofby+VgmzKvFlTlwQc96+yyk71NpB
	 GkMcEbKqLfkQA==
From: Vinod Koul <vkoul@kernel.org>
To: aford173@gmail.com, kishon@kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, xiaopeitux@foxmail.com
Cc: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <tencent_6F503D43467AA99DD8CC59B8F645F0725B0A@qq.com>
References: <tencent_6F503D43467AA99DD8CC59B8F645F0725B0A@qq.com>
Subject: Re: [PATCH V6] phy: freescale: fsl-samsung-hdmi: Limit PLL lock
 detection clock divider to valid range
Message-Id: <173947027636.282331.3484983514931257187.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 23:41:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Tue, 11 Feb 2025 10:29:48 +0800, xiaopeitux@foxmail.com wrote:
> FIELD_PREP() checks that a value fits into the available bitfield,
> but the index div equals to 4,is out of range.
> 
> which gcc complains about:
> In function ‘fsl_samsung_hdmi_phy_configure_pll_lock_det’,
> inlined from ‘fsl_samsung_hdmi_phy_configure’ at
> drivers/phy/freescale/phy-fsl-samsung-hdmi.c :470:2:
> ././include/linux/compiler_types.h:542:38: error: call to ‘__compiletime_assert_538’
> declared with attribute error: FIELD_PREP: value too large for the field
>   542 |  _compiletime_assert(condition, msg, __compiletime_assert_,
> __COUNTER__)
>       |                                      ^
> ././include/linux/compiler_types.h:523:4: note: in definition of
> macro ‘__compiletime_assert’ 523 |    prefix ## suffix();
>       |    ^~~~~~
> ././include/linux/compiler_types.h:542:2: note: in expansion of macro
> ‘_compiletime_assert’
>   542 |  _compiletime_assert(condition, msg, __compiletime_assert_,
>  __COUNTER__)
> 
> [...]

Applied, thanks!

[1/1] phy: freescale: fsl-samsung-hdmi: Limit PLL lock detection clock divider to valid range
      commit: cd57e4327707126dca3f9517b84274c001d4c184

Best regards,
-- 
~Vinod



