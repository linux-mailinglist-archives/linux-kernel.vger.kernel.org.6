Return-Path: <linux-kernel+bounces-412987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE059D1202
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5665D28682F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDD81A3A8A;
	Mon, 18 Nov 2024 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pn+XHJxf"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C36193439
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936625; cv=none; b=n/dhjhSRMQ01+5wSLfY67Nk+x02yldHYVQCGy26HG0KqwTfZ4Y7GLkC4iSoOQlPOfYwlgE/SndNmfJoAJBUYXGoua4r4rEDdBCOK3HHt/5Ng8msMLa8t/OBcYNYU2txE3LDH4pCGbgYjQod6nAbwr4ULrUyU7zaXLJjR8UqVN6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936625; c=relaxed/simple;
	bh=BuCw6NCGsfZKXuxcxlRqFxzAW6RX+37Q46kAcUsWPyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H87KcdZsnUFRVxYMp5SX1uGAMuniVWEUazTEWIkmxHvXUVJBl+I/9LpfFATKNHj7EYRC1jfPfx8Ao9GTOmkKRaOf+BWUcTVmHaFNBUuqeQK6CsOsS+9c+BY1FleRclklHRkZzru5RMtgVZajCHGaT2gZpfkS0EbyS7Px5OfmJoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pn+XHJxf; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F6D640008;
	Mon, 18 Nov 2024 13:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731936621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qa9NHhyLL4kxKZmTxJR2l8vXYrk/AJLkfdhe0yrUDHE=;
	b=pn+XHJxfizpJj+4/n7TDk7Pm8QBR25q0R1sp9RLBQz2n/Zhl9quYOW8cbg/S5UI9ZFCfgr
	7xrNwznaJcUWbC/l/E7HYYAv/PewQ8i+cXrN+2UV/+XWXvJXwUjbc+Eru2mcRO9br3VaJA
	yyj++LrQjTBSfO0F5DazhDQA4EaQlDZUoor3lVzkLFWv1xdu3Gts8YNUZQuFmhSQrKi1BC
	CeWHf3DuwMz36LYqBXC9dAV8BaqJGBl4ygEeydtPhJln4p/ugOQrhFSVgrxQpEKOD1uyMN
	44LFyn0t4ccXMTxey0TXg9cA1Ch7xOy90oMXxz+9RyNtn8vrrYDHYUoMODIa/w==
Date: Mon, 18 Nov 2024 14:30:20 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	mtk25126 <defa.li@mediatek.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
	mingchang.jia@mediatek.com, yuhan.wei@mediatek.com,
	hao.lin@mediatek.com
Subject: Re: [PATCH v2] i3c: Use i3cdev->desc->info instead of calling
 i3c_device_get_info() to avoid deadlock
Message-ID: <173193659471.36588.2292207422310600314.b4-ty@bootlin.com>
References: <20241107132549.25439-1-defa.li@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107132549.25439-1-defa.li@mediatek.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Thu, 07 Nov 2024 21:25:39 +0800, mtk25126 wrote:
> A deadlock may happen since the i3c_master_register() acquires
> &i3cbus->lock twice. See the log below.
> Use i3cdev->desc->info instead of calling i3c_device_info() to
> avoid acquiring the lock twice.
> 
> v2:
>   - Modified the title and commit message
> 
> [...]

Applied, thanks!

[1/1] i3c: Use i3cdev->desc->info instead of calling i3c_device_get_info() to avoid deadlock
      https://git.kernel.org/abelloni/c/6cf7b65f7029

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

