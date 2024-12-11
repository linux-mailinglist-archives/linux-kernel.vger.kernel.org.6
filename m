Return-Path: <linux-kernel+bounces-441687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396499ED28E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD03228A01C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDB91DDC13;
	Wed, 11 Dec 2024 16:48:02 +0000 (UTC)
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5364238DE9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.183.69.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935682; cv=none; b=kzJZqzBYLwqaUg0B4NQMGdpYUsYm2Lc4FQ6h2UA4q87v+8R6Oi4/bJgsixZLCqTlX18wFZdFXH69LfD246h5U2ir/zoV9nOfNsrNcG6WdkDykCFksm8rxR48HBCgPRydjWWxCw6/8AhgMpc2tD+maJop8y0SUwLFCH9FKYZH7CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935682; c=relaxed/simple;
	bh=ey0bDn6pUkb7pDg7fDiX6ymNsX9UAVXBEvkSEB22dqE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fgyGVCMdUHy8TGXqcD13yzvtUKzqRwhUxQh07c3xQKukFRP31ZYDNfqUDVwInMN1jRpFBq4K9Aac+aCixVze/dp+wb9SHuPgvd1rNhJli7tqheF6PUwggGqGv9SnF6X9WMu26X5Pt/BMpaSaCXbHG/cnRIf6nOCgXTsRsoA3AUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de; spf=pass smtp.mailfrom=vosn.de; arc=none smtp.client-ip=85.183.69.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vosn.de
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: from mail.steuer-voss.de (localhost [127.0.0.1])
	by mail.steuer-voss.de (Postfix) with ESMTP id 723402468;
	Wed, 11 Dec 2024 17:47:46 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Dec 2024 17:47:46 +0100
From: Nikolaus Voss <nv@vosn.de>
To: Marek Vasut <marex@denx.de>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, Liu Ying
 <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Fabio
 Estevam <festevam@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 miquel.raynal@bootlin.com, nikolaus.voss@haag-streit.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: bridge: fsl-ldb: fixup mode on freq mismatch
In-Reply-To: <fba91fbb-e819-4b08-9845-fa1138773113@denx.de>
References: <20241203191111.47B56F7@mail.steuer-voss.de>
 <2d7f8afc-119a-4080-93be-bf3daf017e5e@denx.de>
 <abcc89936f44fd884b9c5da65ea64c42@vosn.de>
 <5a6ab24d-6c74-497f-828e-b3e7645d664a@denx.de>
 <027aac3abff3f84a0ebf461653ed6c9b@vosn.de>
 <fba91fbb-e819-4b08-9845-fa1138773113@denx.de>
User-Agent: Roundcube Webmail/1.5.0
Message-ID: <ed914413fd0e9dc38887b139da733499@vosn.de>
X-Sender: nv@vosn.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hi Marek,

On 09.12.2024 22:51, Marek Vasut wrote:
> On 12/9/24 10:27 AM, Nikolaus Voss wrote:
>> On 07.12.2024 12:46, Marek Vasut wrote:
>>> On 12/4/24 11:40 AM, Nikolaus Voss wrote:
>>>>>> LDB clock has to be a fixed multiple of the pixel clock.
>>>>>> As LDB and pixel clock are derived from different clock sources
>>>>> 
>>>>> Can you please share the content of 
>>>>> /sys/kernel/debug/clk/clk_summary ?
>>>> 
>>>> Sure. Without my patch:
>>>> 
>>>>      video_pll1_ref_sel               1       1        0 24000000    
>>>> 0          0     50000      Y      deviceless no_connection_id
>>>>         video_pll1                    1       1        0 1039500000 
>>>> 0          0     50000      Y         deviceless no_connection_id
>>>>            video_pll1_bypass          1       1        0 1039500000 
>>>> 0          0     50000      Y            deviceless no_connection_id
>>>>               video_pll1_out          2       2        0 1039500000 
>>>> 0          0     50000      Y               deviceless 
>>>> no_connection_id
>>>>                  media_ldb            1       1        0 346500000   
>>>> 0          0     50000      Y 32ec0000.blk- ctrl:bridge@5c     ldb
>>>>                                                   deviceless 
>>>> no_connection_id
>>>>                     media_ldb_root_clk 0       0        0 346500000 
>>>> 0          0     50000      Y                     deviceless 
>>>>                      no_connection_id
>>>>                  media_disp2_pix      1       1        0 51975000    
>>>> 0          0     50000      Y                  deviceless        
>>>> no_connection_id
>>>>                     media_disp2_pix_root_clk 1       1        0 
>>>> 51975000    0          0     50000      Y 32e90000.display- 
>>>> controller     pix
>>>> 
>>>> Here 346500000 (media_ldb) != 7 * 51975000 (media_disp2_pix)
>>>>    -> distorted panel image (if any).
>>>> The requested panel pixel clock from EDID is 51200000.
>>> 
>>> Right, this is what Miquel is trying to solve with their series.
>>> 
>>>> This is the same with my patch:
>>>> 
>>>>      video_pll1_ref_sel               1       1        0 24000000    
>>>> 0          0     50000      Y      deviceless no_connection_id
>>>>         video_pll1                    1       1        0 1039500000 
>>>> 0          0     50000      Y         deviceless no_connection_id
>>>>            video_pll1_bypass          1       1        0 1039500000 
>>>> 0          0     50000      Y            deviceless no_connection_id
>>>>               video_pll1_out          2       2        0 1039500000 
>>>> 0          0     50000      Y               deviceless 
>>>> no_connection_id
>>>>                  media_ldb            1       1        0 346500000   
>>>> 0          0     50000      Y 32ec0000.blk- ctrl:bridge@5c     ldb
>>>>                                                   deviceless 
>>>> no_connection_id
>>>>                     media_ldb_root_clk 0       0        0 346500000 
>>>> 0          0     50000      Y                     deviceless 
>>>>                      no_connection_id
>>>>                  media_disp2_pix      1       1        0 49500000    
>>>> 0          0     50000      Y                  deviceless        
>>>> no_connection_id
>>>>                     media_disp2_pix_root_clk 1       1        0 
>>>> 49500000    0          0     50000      Y 32e90000.display- 
>>>> controller     pix
>>>> 
>>>> So, here 346500000 (media_ldb) = 7 * 49500000 (media_disp2_pix).
>>>>    -> stable panel image, but pixel clock reduced to 49.5 MHz from 
>>>> requested 51.2 MHz.
>>> 
>>> Inaccurate pixel clock and non-60Hz frame rate is not a win either.
>> 
>> Some percents of deviation is usually not visible.
> 
> The PLL is accurate, so this kind of non-60 Hz frame rate compromise
> really should not be necessary.
> 
>>>> My conclusion: The clock source is the same
>>> 
>>> I agree .
>>> 
>>> You wrote "derived from different clock sources" above,
>>> keyword:different, which is not correct.
>>> 
>>>> , nevertheless the
>>>> ldb/pixel clock constraint cannot be satisfied without either
>>>> modifying the pll clock or the pixel clock.
>>> In this particular case, you surely do want to modify the PLL 
>>> settings
>>> to achieve accurate pixel clock.
>> 
>> No, in this case there is a 3 percent deviation, resulting in 58 Hz
>> frame rate instead of 60 Hz.
> Consider e.g. 60 FPS video playback, on 58 Hz refresh panel it will
> suffer from some stutter . It is better to aim for the 60 Hz then .

This is a relevant use case, I agree. But even with a dedicated video
PLL (what a luxury in the embedded world!) you will eventually have to
drop or double a frame as the clocks are asynchronous. And the sync
problem still exists with 25 or 50 FPS videos.

-- 
Nikolaus Voss

