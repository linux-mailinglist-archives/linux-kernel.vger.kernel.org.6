Return-Path: <linux-kernel+bounces-420670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D44E89D81F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 057B7B2194F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636C218FDBA;
	Mon, 25 Nov 2024 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Njuiiomy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC9D18D64B;
	Mon, 25 Nov 2024 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526042; cv=none; b=IEJKVxTz1vgzDetX8IgrLJnIJ9nAQVVUU5oxTsrOJXBPFxJUPTbWK02YKL2CEtjjciQ8yYeklOsh8eCY21JSKaKAlLS5hjFTbaEuKRJiGYqmSMYG/WzhgUST1m7nEo8sa8QANI10f+FYp2+2NkP8nhgqbMjD/vziCnDpoqwzgYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526042; c=relaxed/simple;
	bh=1XQUPazAG20tbs4O/Rn/xERWfHbxiKgQ/YgDItpVwZA=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=mhexOvcWVf2Rhs1BY8kO7HX6IPW58EdkAKoWPUXaY7rvRX9sOaJ7vaOvXutm8qTC1takHXNym1lEK0FXoAr18TiCKQQxFiqboIctalV0YWoLQQiXItU03v0qkROrf9KeAjSOAbGIccu5PBRUBIckUpS0les/b7UiT7ao9JgcBo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Njuiiomy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC643C4CECE;
	Mon, 25 Nov 2024 09:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732526042;
	bh=1XQUPazAG20tbs4O/Rn/xERWfHbxiKgQ/YgDItpVwZA=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=NjuiiomyOxo9MIeolvgNU5/PdZ8uJVY3aZYnHAiMjOY/fWRhiffon/RO4gq9Xt/eh
	 o/9UwTIymkTPJKSxnPeIqr/+Pqxtgw2rxUE1VyYMbAzCXL/0f2wRU6JGYcnbllv1F4
	 tbl9/GZcHjMnpXarIsNYN1dcA4u6dQRB2tU0DHeGhcKvmUn+x/D4Zcc9JA2EapnbdR
	 TD+8rzRSex7h1JL9U6oGwEYRbPIu6LM7Vje1mwpRlkjRai0F52GdF43nTpTQCyZdy3
	 e3vuamCeaJTGU17s23RDnxasS5vzQ/GEXJDnTM12bovr7VKE6u0kk8CnXAgoUoZNK6
	 2b+pOjVmoTZTA==
Message-ID: <b83f53e7bffcc7de692c2e478e083928@kernel.org>
Date: Mon, 25 Nov 2024 09:13:59 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 01/10] drm/tests: hdmi: handle empty modes in
 find_preferred_mode()
In-Reply-To: <20241122-hdmi-mode-valid-v4-1-2fee4a83ab79@linaro.org>
References: <20241122-hdmi-mode-valid-v4-1-2fee4a83ab79@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "Chen-Yu Tsai" <wens@csie.org>, "Dave
 Stevenson" <dave.stevenson@raspberrypi.com>, "David Airlie" <airlied@gmail.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Raspberry Pi Kernel Maintenance" <kernel-list@raspberrypi.com>, "Robert
 Foss" <rfoss@kernel.org>, "Samuel Holland" <samuel@sholland.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Fri, 22 Nov 2024 11:12:57 +0200, Dmitry Baryshkov wrote:
> If the connector->modes list is empty, then list_first_entry() returns a
> bogus entry. Change that to use list_first_entry_or_null().
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

