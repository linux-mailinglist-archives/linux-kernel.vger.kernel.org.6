Return-Path: <linux-kernel+bounces-169411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B16238BC856
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29411C213A6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999C8763E4;
	Mon,  6 May 2024 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPi2B+bP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB63D1772F;
	Mon,  6 May 2024 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714980465; cv=none; b=sT05s4IaPPM9xwktMwimO2+xJULfr7AuYHe3MYcWB/QbPx8pjFfmloTxGKeW0/hggVEaYYfvOxQcdkt9/ROkwj++E5FfxwOGMA67Pu7tAyw3SWmGC8ujQ4/yCAUD786QphUNTSwQa8JeXfebJr6iLKznoG+NnphMRyigBPWEf/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714980465; c=relaxed/simple;
	bh=9Kw69BfKa5kkeDkJAAyST9I0D7UXthaocRM2ai6H6cA=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=bxkbhIATY0YhHLvNC2Wy9GAxmYNLc/pkCKsfQmk3zQBj/g3roF5UmBtt4EMAYd0Idb7ZG9A61BH38mi/OjYnsLW+nzwirQBvcNiHtQ/8vslkmYP7pABbr9ecroWOm7B2yCyknShBgL+9X41cKIS7bjeTXg07UQWIgepPBumZDQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPi2B+bP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E091CC4AF63;
	Mon,  6 May 2024 07:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714980464;
	bh=9Kw69BfKa5kkeDkJAAyST9I0D7UXthaocRM2ai6H6cA=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=TPi2B+bPlbWrXR0vRrMi7OO7YfR/17oBUiIP3I0reFQOse+6mJiSXTFUDiYz9KNxR
	 Xgovz8h0zqDVo38VqRUvYWa495nrfut4pabGPBCiTJyx8MjnJDLDH8Es1uxCDl+3hM
	 UMzY/RS2j75++Trzbyg6e6aITMjsDP7A3+iToxB6REkWgd4QuQHWdTc7nCS3vwzbpc
	 e0z72+4Ib9oZ/Smq22YUV4CnfxfAHkusWe39MT5oJnmX8+hSa589nJhtRd1NPj/zlH
	 6O8cxnx+WZaWn5Rm9rYHzlX2ijHikOqIxGr1IQXAhHqQQIo4MkIs7LcwYYge1M3qSq
	 cXp1IO+KNQZ2w==
Message-ID: <0aebaa438b4f2fd13b8a7ea5a92ca60d@kernel.org>
Date: Mon, 06 May 2024 07:27:41 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [RFT PATCH v2 00/48] drm/panel: Remove most store/double-check
 of prepared/enabled state
In-Reply-To: <20240503213441.177109-1-dianders@chromium.org>
References: <20240503213441.177109-1-dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, "AngeloGioacchino
 Del Regno" <angelogioacchino.delregno@collabora.com>, "Chris Morgan" <macromorgan@hotmail.com>, "Daniel
 Vetter" <daniel@ffwll.ch>, "David Airlie" <airlied@gmail.com>,
 =?utf-8?b?R3VpZG8gR8O8bnRoZXI=?= <agx@sigxcpu.org>, "Jerry Han" <hanxu5@huaqin.corp-partner.google.com>, "Jessica
 Zhang" <quic_jesszhan@quicinc.com>, "Jonathan Corbet" <corbet@lwn.net>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, "Maxime Ripard" <mripard@kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Ondrej Jirman" <megi@xff.cz>, "Purism
 Kernel Team" <kernel@puri.sm>, "Robert Chiras" <robert.chiras@nxp.com>, "Sam
 Ravnborg" <sam@ravnborg.org>, "Stefan Mavrodiev" <stefan@olimex.com>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Yuran
 Pereira" <yuran.pereira@hotmail.com>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Fri, 3 May 2024 14:32:41 -0700, Douglas Anderson wrote:
> 
> As talked about in commit d2aacaf07395 ("drm/panel: Check for already
> prepared/enabled in drm_panel"), we want to remove needless code from
> panel drivers that was storing and double-checking the
> prepared/enabled state. Even if someone was relying on the
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

