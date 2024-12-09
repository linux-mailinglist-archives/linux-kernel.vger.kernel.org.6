Return-Path: <linux-kernel+bounces-437066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 504349E8EB2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479411632A2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E58C215F60;
	Mon,  9 Dec 2024 09:27:34 +0000 (UTC)
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168281EB3D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.183.69.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736454; cv=none; b=RmxcE0uCj0fN543ACSYytmJjpqBu91iepfyo2xpDSoWdBALxlFeN/308hAut1uj+doyPHYY88aHQnNeYaLoJiIdJG6jMHXv9PH7Cpu6bhJX+nxDbp/CTY6I475zWOiwf7fPZv2yrjqYAkT5b8pEX/eJtZKE4PtD8NRgbYcLrdNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736454; c=relaxed/simple;
	bh=anJLqQ82/6GiUkpmxOaSGyK/jfTOdeZbCM16AVc7OTc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JdShs+6SuFbubNuWAhk3mFEqpfie5Ujs1I3Z0nC1uc85zwf9GnuGXhHn/BAWQaEy6PzMfJW2NyGms0zdxv4ofJ9j1UWgzuEgg3YhR2HuNE09qh2TZtSeGccxCMH/t2I/N8odZaWw9qAcFN5DamfyulrJON6+CDj6e+A3cS7wC8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de; spf=pass smtp.mailfrom=vosn.de; arc=none smtp.client-ip=85.183.69.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vosn.de
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: from mail.steuer-voss.de (localhost [127.0.0.1])
	by mail.steuer-voss.de (Postfix) with ESMTP id 1121523FB;
	Mon,  9 Dec 2024 10:27:26 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Dec 2024 10:27:26 +0100
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
In-Reply-To: <5a6ab24d-6c74-497f-828e-b3e7645d664a@denx.de>
References: <20241203191111.47B56F7@mail.steuer-voss.de>
 <2d7f8afc-119a-4080-93be-bf3daf017e5e@denx.de>
 <abcc89936f44fd884b9c5da65ea64c42@vosn.de>
 <5a6ab24d-6c74-497f-828e-b3e7645d664a@denx.de>
User-Agent: Roundcube Webmail/1.5.0
Message-ID: <027aac3abff3f84a0ebf461653ed6c9b@vosn.de>
X-Sender: nv@vosn.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 07.12.2024 12:46, Marek Vasut wrote:
> On 12/4/24 11:40 AM, Nikolaus Voss wrote:
>>>> LDB clock has to be a fixed multiple of the pixel clock.
>>>> As LDB and pixel clock are derived from different clock sources
>>> 
>>> Can you please share the content of /sys/kernel/debug/clk/clk_summary 
>>> ?
>> 
>> Sure. Without my patch:
>> 
>>      video_pll1_ref_sel               1       1        0        
>> 24000000    0          0     50000      Y      deviceless 
>> no_connection_id
>>         video_pll1                    1       1        0 1039500000  
>> 0          0     50000      Y         deviceless          
>> no_connection_id
>>            video_pll1_bypass          1       1        0 1039500000  
>> 0          0     50000      Y            deviceless             
>> no_connection_id
>>               video_pll1_out          2       2        0 1039500000  
>> 0          0     50000      Y               deviceless                
>> no_connection_id
>>                  media_ldb            1       1        0        
>> 346500000   0          0     50000      Y 32ec0000.blk- 
>> ctrl:bridge@5c     ldb
>>                                                   deviceless         
>> no_connection_id
>>                     media_ldb_root_clk 0       0        0 346500000   
>> 0          0     50000      Y                     deviceless  
>>                      no_connection_id
>>                  media_disp2_pix      1       1        0        
>> 51975000    0          0     50000      Y                  deviceless  
>>        no_connection_id
>>                     media_disp2_pix_root_clk 1       1        0 
>> 51975000    0          0     50000      Y 32e90000.display- 
>> controller     pix
>> 
>> Here 346500000 (media_ldb) != 7 * 51975000 (media_disp2_pix)
>>    -> distorted panel image (if any).
>> The requested panel pixel clock from EDID is 51200000.
> 
> Right, this is what Miquel is trying to solve with their series.
> 
>> This is the same with my patch:
>> 
>>      video_pll1_ref_sel               1       1        0        
>> 24000000    0          0     50000      Y      deviceless 
>> no_connection_id
>>         video_pll1                    1       1        0 1039500000  
>> 0          0     50000      Y         deviceless          
>> no_connection_id
>>            video_pll1_bypass          1       1        0 1039500000  
>> 0          0     50000      Y            deviceless             
>> no_connection_id
>>               video_pll1_out          2       2        0 1039500000  
>> 0          0     50000      Y               deviceless                
>> no_connection_id
>>                  media_ldb            1       1        0        
>> 346500000   0          0     50000      Y 32ec0000.blk- 
>> ctrl:bridge@5c     ldb
>>                                                   deviceless         
>> no_connection_id
>>                     media_ldb_root_clk 0       0        0 346500000   
>> 0          0     50000      Y                     deviceless  
>>                      no_connection_id
>>                  media_disp2_pix      1       1        0        
>> 49500000    0          0     50000      Y                  deviceless  
>>        no_connection_id
>>                     media_disp2_pix_root_clk 1       1        0 
>> 49500000    0          0     50000      Y 32e90000.display- 
>> controller     pix
>> 
>> So, here 346500000 (media_ldb) = 7 * 49500000 (media_disp2_pix).
>>    -> stable panel image, but pixel clock reduced to 49.5 MHz from 
>> requested 51.2 MHz.
> 
> Inaccurate pixel clock and non-60Hz frame rate is not a win either.

Some percents of deviation is usually not visible.

> 
>> My conclusion: The clock source is the same
> 
> I agree .
> 
> You wrote "derived from different clock sources" above,
> keyword:different, which is not correct.
> 
>> , nevertheless the
>> ldb/pixel clock constraint cannot be satisfied without either
>> modifying the pll clock or the pixel clock.
> In this particular case, you surely do want to modify the PLL settings
> to achieve accurate pixel clock.

No, in this case there is a 3 percent deviation, resulting in 58 Hz
frame rate instead of 60 Hz.

-- 
Nikolaus Voss

