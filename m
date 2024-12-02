Return-Path: <linux-kernel+bounces-428045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D939E0968
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC13163911
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A1D1D9A5F;
	Mon,  2 Dec 2024 17:03:27 +0000 (UTC)
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF461AC444
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.183.69.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159006; cv=none; b=FGKkNlho8GvKxDIfNWNx1cQW6ldZglk3BTU4yBRJE2VqAjhgfyquYD31Ir3s4XLarqTnQsmG5q3qvSNDoaJd10nvmUoOxyEHv1bH0OLKxsIN9rGp7O42hQD8PWkig7pUTt28iw7sRfv4Y1x+KVbyQZjpSuJzLHE9B5vLblyGEao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159006; c=relaxed/simple;
	bh=UraHYu3PVGdBa1G5kKPcqpScOE2DGLtNUyGJsKgIW1I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BqEJrgsPimcT4xunrloL8oT1HMJYknZZvlyWJRn6DV44mKEH8f6UVtg3VKxKzo7tOeGCm0rFNSB2FzFSDnaihQyr3s7PDPAgt8QbL6tXQy5l0HWmwjX/HNiT/FU7UZgctnnVYRpg5XgqaCfsvsunW9pDf56YRcrlTj1Ket+YZLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de; spf=pass smtp.mailfrom=vosn.de; arc=none smtp.client-ip=85.183.69.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vosn.de
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: from mail.steuer-voss.de (localhost [127.0.0.1])
	by mail.steuer-voss.de (Postfix) with ESMTP id AA1BB2D2;
	Mon,  2 Dec 2024 18:03:16 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 02 Dec 2024 18:03:16 +0100
From: Nikolaus Voss <nv@vosn.de>
To: Marek Vasut <marex@denx.de>
Cc: Liu Ying <victor.liu@oss.nxp.com>, Alexander Stein
 <alexander.stein@ew.tq-group.com>, Liu Ying <victor.liu@nxp.com>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Fabio Estevam <festevam@denx.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Miquel Raynal
 <miquel.raynal@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, nikolaus.voss@haag-streit.com
Subject: Re: [PATCH] drm: bridge: fsl-ldb: fixup mode on freq mismatch
In-Reply-To: <50ee0207-b37a-4a6a-83fe-32a7a43645ce@denx.de>
References: <20241126172610.AD8B51622C@mail.steuer-voss.de>
 <1f0a307a-666f-4647-9f73-e9bddd6c7eff@oss.nxp.com>
 <50ee0207-b37a-4a6a-83fe-32a7a43645ce@denx.de>
User-Agent: Roundcube Webmail/1.5.0
Message-ID: <9cc55af202690bad0616bee76430133d@vosn.de>
X-Sender: nv@vosn.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 02.12.2024 13:56, Marek Vasut wrote:
> On 12/2/24 7:32 AM, Liu Ying wrote:
>> On 11/27/2024, Nikolaus Voss wrote:
>>> LDB clock has to be a fixed multiple of the pixel clock.
>>> As LDB and pixel clock are derived from different clock sources
>>> (at least on imx8mp), this constraint cannot be satisfied for
>>> any pixel clock, which leads to flickering and incomplete
>>> lines on the attached display.
>>> 
>>> To overcome this, check this condition in mode_fixup() and
>>> adapt the pixel clock accordingly.
>>> 
>>> Cc: <stable@vger.kernel.org>
>> 
>> It looks like stable is not effectively Cc'ed.
>> Need a Fixes tag?
> Isn't this fix effectively superseded by series
> 
> [PATCH 0/5] clk: Fix simple video pipelines on i.MX8
> 
> ?

Maybe. I wasn't aware of the series. Looking at it, the change is
rather complex and not suitable for the stable series.

My intention was to get a simple fix which doesn't potentially
break anything. It wouldn't even break the patch series you mentioned.

-- 
Nikolaus Voss

