Return-Path: <linux-kernel+bounces-274584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF19E947A5C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278BA1C212AC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5420D155743;
	Mon,  5 Aug 2024 11:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmuqOyl/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEE81448EF
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722857416; cv=none; b=MGo79LdXQJeZJ/yjKRnxB6SCp58U3lYIxozA/cAu0Eiv3rkRWHBul7SqxCJJUT4da/ruhp7Kmk9MuV/DKv2G6ev/d0shWg6ye3S5672wYhkWmyXWF8axJg9YNpcqAq2JtmjnkMmHMLrX/FXBZ4FvQfWvBM6Q/t4CLd88rNmpJkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722857416; c=relaxed/simple;
	bh=8Z1pSg25/Oj1kOS1VJAI/o4U3DsNumKOXI+5DUXr2U8=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=iKO0L1zyWhf93hDJx/IikE5N8GjxEU56IWIb9nu8r8PTMwggv0ozKwgRrEaLEDyP6ieBkcrIIWBxM548uIietRmLwaEMD8rrXACAqNjAWDxFHbBytRQKgJmuCcWqA/fPqXXC4GaPHmRP8BorEG2iUxKFppzrTA34+X+y8AutMpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmuqOyl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB450C32782;
	Mon,  5 Aug 2024 11:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722857416;
	bh=8Z1pSg25/Oj1kOS1VJAI/o4U3DsNumKOXI+5DUXr2U8=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=bmuqOyl/OZHd2e7fzJ8Yle2rThjupSzExrUP3BTo3fuqs7HDMTOV/KMVymyNt+F5+
	 xvsg5XGekR8loCllKC/lymrO/P181NuFZoqRmZr7KyU1Og37jlHgP221NvmlOr3VGW
	 UZKFQtv1N7xdW5CPP7GhfHbEwHzK5AGTUHp8ChuwXEtwLZZF3dlzGasnCj9htDqZ8i
	 aLNvE19Og+JfvV75rP57zJjeOd18X3/6M39bIyOfZWzSrqShB6KFDkd2Ofhh+MvoHf
	 yU9+zBw/kKv3GHhc7AHi/oyqPvP5uo+JDvEnttvK/Qoq0yCjufcBd0QWF/FuuQ3sc3
	 V7wLjVSKum6Nw==
Message-ID: <fea441df060ae1ed802980782f3e3d5d@kernel.org>
Date: Mon, 05 Aug 2024 11:30:13 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Alex Bee" <knaerzche@gmail.com>
Subject: Re: [PATCH] drm/rockchip: inno-hdmi: Fix infoframe upload
In-Reply-To: <20240805110855.274140-2-knaerzche@gmail.com>
References: <20240805110855.274140-2-knaerzche@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, "Andy
 Yan" <andy.yan@rock-chips.com>, "Daniel Vetter" <daniel@ffwll.ch>, "David
 Airlie" <airlied@gmail.com>, =?utf-8?b?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Sandy
 Huang" <hjc@rock-chips.com>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Mon, 5 Aug 2024 13:08:56 +0200, Alex Bee wrote:
> HDMI analyser shows that the AVI infoframe is no being longer send.
> 
> The switch to the HDMI connector api should have used the frame content
> which is now given in the buffer parameter, but instead still uses the
> (now) empty and superfluous packed_frame variable.
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

