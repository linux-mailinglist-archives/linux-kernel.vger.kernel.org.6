Return-Path: <linux-kernel+bounces-556854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F20FA5CF82
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F80188A80C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5B9263F49;
	Tue, 11 Mar 2025 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkoRgJeJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C616B262800;
	Tue, 11 Mar 2025 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721666; cv=none; b=GGcrfy1lgvoN8AhEYz+2NUEsKY2hD7LChPilz8EGA2bJV5FfPBLVQv8gWQSftLaR345nWWiV1nkxq3z8ZAie1WMVznZTJJR25TPTVFzU1gHhiyuoyMghwNhuhUVLjrWF2qoRjwmqvHiz18cYgFomZNggs3wnhb92dZudysJHemk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721666; c=relaxed/simple;
	bh=7SzSmNQI5Lq15IlMk57NIhjyJKbjRjI8NcTmba3AXVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjVp4yzGqaOm6lCqJTiEgR6A2g/rnA5aP2nuqvBPax/HSm2fhd/cMjtqEVIrfr5m7pVpyimZZiWYpChjh9iRdO0EgQsmE10j+IDu/pqR+Bh+LiDXmMZ89+tTVZuEbbwSp8rZ/vRQSTPMoTWO8uyKDgmsNBtmQbQ1YYO6y3glvIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkoRgJeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B17C4CEEC;
	Tue, 11 Mar 2025 19:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741721666;
	bh=7SzSmNQI5Lq15IlMk57NIhjyJKbjRjI8NcTmba3AXVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QkoRgJeJFXxlTW+99XRp2q4NDI9BDBJPGkBfz6igAVwDGxzS/HyKTtrx39Ai71c4d
	 isNzsFY1aKZj9sa2BSv+dc9ljLPkz5XZKo+K6dg04Unvtu3/T9VlCSydoN937mvUpu
	 HO9QDuG2WziULaShHg590LN/H36/OktS//Kf7ZA+xbStMjW13Zqao+z716+X9NcMIg
	 auXhiZVXPDDQvrRf4Bf5PnL+q2BFornqaZ6gw6u9JhhePTzGBE7HaDtv/JjlXvD97k
	 GjoWMP1PvTx0KM4aez0R6/7jjRJFtHwa3RYfrTgVwQ0AEtC84UYdf5TSTs7FYQ7K8N
	 D+mkFg7Qx8YAw==
Date: Tue, 11 Mar 2025 21:34:20 +0200
From: Dmitry Baryshkov <lumag@kernel.org>
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] drm/panel: simple: Add POWERTIP PH128800T004-ZZA01
 panel entry
Message-ID: <l5xqtntobwrqm6itp2bxnfr735fbzye7vvai6fl2wdmk6jzjbs@dk2kmfhzg5to>
References: <20250311-add-powertip-ph128800t004-v1-0-7f95e6984cea@bootlin.com>
 <20250311-add-powertip-ph128800t004-v1-2-7f95e6984cea@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-add-powertip-ph128800t004-v1-2-7f95e6984cea@bootlin.com>

On Tue, Mar 11, 2025 at 05:40:06PM +0100, Antonin Godard wrote:
> Add support for the POWERTIP PH128800T004-ZZA01 10.1" (1280x800)
> LCD-TFT panel. Its panel description is very much like the POWERTIP
> PH128800T006-ZHC01 configured below this one, only its timings are
> different.
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <lumag@kernel.org>

-- 
With best wishes
Dmitry

