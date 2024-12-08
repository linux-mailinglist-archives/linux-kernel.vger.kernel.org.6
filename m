Return-Path: <linux-kernel+bounces-436498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D830A9E86CB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 17:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7134518816A2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1323918C008;
	Sun,  8 Dec 2024 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcwdN23m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7342920323
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733677142; cv=none; b=b46lBulkCW22gA5BGqcOePakFYywc4VOCN7yPf/iGRBz5cc0YT+MJpjQ21d6jaosBUgo4gXmDJA5Q3ihVip+HEhDyrsP3mFI0hiUQ3mZP4dAzJ6fmxT6Utrvs9Pd9zmExPzJaBAlc1KTXjAZqRjXTkZWYeiTbQz60vH6rS2Fmj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733677142; c=relaxed/simple;
	bh=toOsgRuEWOhHn9FOC604OTu6l2exJPo4BC7XHhbdWEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NgozXOHaR7BtCYFF3Ex90Qv/Y4R7h1H1mZ7Nvbb4qOtDkPVCZz6LXR8jvYGcK+Vetqh9Luo2FqeatHJPkt+XdWMTOYonpAOIwiKVo4aqaty79EdiQBNPJkmaxxss7dfE5wU4ZJpNKiA01C/cz61aguAp6SKIGBoA3zI0V0mZry0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcwdN23m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487EEC4CED2;
	Sun,  8 Dec 2024 16:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733677142;
	bh=toOsgRuEWOhHn9FOC604OTu6l2exJPo4BC7XHhbdWEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DcwdN23m6ERs8sHSF54Cs3zdlAnAHoIvQLu9QM8FseNB7dXYYwrbcaT9dZ7gYMclV
	 Fx0gIMS3GCzAa+JVPD5g8xblWLuo32yKC8mxwKdWe8a3626FpSut7T62RpkWK/shYu
	 y7fnZluusiAQGkplCvDLy1dScye9kG3dTMP3lCMiZ3BKxOKbRARHGXl0XlQIO93Iag
	 IM4lJkOqJNh/6sUfWld5GWk/Vh+DHqdAnCqGhCobNVMGAVpraMNeLvh51OJrR4giTC
	 DyMUxLT3yPwnrWVSKd5MNfDGaDyEiLRUZqAMM7VFJyamA6No0oAzFl2dQJpa36n8hH
	 ezHls67pDIMKA==
From: Vinod Koul <vkoul@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Yang Li <yang.lee@linux.alibaba.com>, 
 linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241111103712.3520611-1-arnd@kernel.org>
References: <20241111103712.3520611-1-arnd@kernel.org>
Subject: Re: [PATCH] phy: stm32: work around constant-value overflow
 assertion
Message-Id: <173367713788.1031947.8609520201420590738.b4-ty@kernel.org>
Date: Sun, 08 Dec 2024 22:28:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 11 Nov 2024 11:37:02 +0100, Arnd Bergmann wrote:
> FIELD_PREP() checks that a constant fits into the available bitfield,
> but if one of the two lookup tables in stm32_impedance_tune() does
> not find a matching entry, the index is out of range, which gcc
> correctly complains about:
> 
> In file included from <command-line>:
> In function 'stm32_impedance_tune',
>     inlined from 'stm32_combophy_pll_init' at drivers/phy/st/phy-stm32-combophy.c:247:9:
> include/linux/compiler_types.h:517:38: error: call to '__compiletime_assert_447' declared with attribute error: FIELD_PREP: value too large for the field
>   517 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |                                      ^
> include/linux/bitfield.h:68:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>    68 |   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
>   115 |   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
>       |   ^~~~~~~~~~~~~~~~
> drivers/phy/st/phy-stm32-combophy.c:162:8: note: in expansion of macro 'FIELD_PREP'
>   162 |        FIELD_PREP(STM32MP25_PCIEPRG_IMPCTRL_VSWING, vswing_of));
>       |        ^~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] phy: stm32: work around constant-value overflow assertion
      commit: 2de679ecd724b823c2cb58caab8508c7eec8aefc

Best regards,
-- 
~Vinod



