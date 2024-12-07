Return-Path: <linux-kernel+bounces-435916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F06DA9E7E8E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 07:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C263B1885F97
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 06:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F5A6E2BE;
	Sat,  7 Dec 2024 06:30:35 +0000 (UTC)
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D1A360
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.183.69.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733553035; cv=none; b=FhDdZ8+ln81/ijm48tNQskwWHfJuJzLbEFV+1e+VC8ecTyfbqIp5HCrxrQfnFTH2oMfuhUU+7X+Y8bwCNQlmfTkUIYZ35gvpGt3fLnFKNwFryTrqZ78DD6uo/aCxuxcYAQjGxUXfmqwrx0pMMKrUooMMZeJEPOTQpVv5snY/ieg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733553035; c=relaxed/simple;
	bh=Vin7YR2E9FVuXmPE4I2eJ+mPqvNc6M0xZrQuwYAwbdA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Wor5c5rQ+qAq6nCnUj+Ky1omIR6YLN72nLq1wGIQ7qLhLTNAAhBEnKgEyYaDAKzR+1HAcd4lMBCUAC1uGAnXqUaK0cSArkgxGXadaTzGJiODtvM6CT7TkfQKqDWondWWEmO1jR+FGjwQshrmoodMv6jYXhnr/VSCFZkXwwQoaxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de; spf=pass smtp.mailfrom=vosn.de; arc=none smtp.client-ip=85.183.69.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vosn.de
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: from mail.steuer-voss.de (localhost [127.0.0.1])
	by mail.steuer-voss.de (Postfix) with ESMTP id 5FDDF22D4;
	Sat,  7 Dec 2024 07:30:27 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 07 Dec 2024 07:30:27 +0100
From: Nikolaus Voss <nv@vosn.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, Liu Ying
 <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Fabio
 Estevam <festevam@denx.de>, Marek Vasut <marex@denx.de>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, nikolaus.voss@haag-streit.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: bridge: fsl-ldb: fixup mode on freq mismatch
In-Reply-To: <87zfl8oqeg.fsf@bootlin.com>
References: <20241203191111.47B56F7@mail.steuer-voss.de>
 <87zfl8oqeg.fsf@bootlin.com>
User-Agent: Roundcube Webmail/1.5.0
Message-ID: <bb14f0aca5d14141b45700abf10deb61@vosn.de>
X-Sender: nv@vosn.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hi Miquèl,

On 06.12.2024 15:08, Miquel Raynal wrote:
> On 03/12/2024 at 20:09:52 +01, Nikolaus Voss <nv@vosn.de> wrote:
> 
>> LDB clock has to be a fixed multiple of the pixel clock.
> 
> Not only, IIUC it also needs to be synchronized, ie. share the same
> source.
> 
>> As LDB and pixel clock are derived from different clock sources
>> (at least on imx8mp),
> 
> Wait, what? I am sorry but that is not at all recommended, both should
> come from video_pll1 which the de-facto versatile PLL to use, no? Am I
> missing something here?

No, I was wrong :-). I've corrected the log text in the v3.

-- 
Nikolaus Voss

