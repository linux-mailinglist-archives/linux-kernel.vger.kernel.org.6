Return-Path: <linux-kernel+bounces-430978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D779E37BC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064B028319B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF0C19259E;
	Wed,  4 Dec 2024 10:40:49 +0000 (UTC)
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FC02B9B7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.183.69.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308848; cv=none; b=EVymfW4hojSV/UNzI8uK/lBpUj561Tw4biGFEIgFdE7RIx2ZMysHHqn3T+ZUDSO/MDs5UAubdRmLqsK6W3vy0fFazFLsIfDSWwKLo0X3MH3bfq+QFF4aosQZ84SAhQVnY8kEhxAiF7GUFK5A9ALPV4Y9b2NVWSN9d3WGm5QUdYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308848; c=relaxed/simple;
	bh=m6y3L4J784yjmc2BvW5DfbxDOz46J/Z/iGRgu30t3l8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Afw7XWLpAHRMNlze1vGYFRAIVkaC2M4nsUizW9KcJSCdCBJSOsFaqUIhcaO7i8gxgXl3wO2xgTa9BYC6AJuJ2QnwJ9/yuMxHDOwVNBc1lc5aYfP5Q/5Y0NpYph6c/i2mVIgQ56bpiQrJRn9I3ivD1/PkXrIQYmTJeDMZyKJb9Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de; spf=pass smtp.mailfrom=vosn.de; arc=none smtp.client-ip=85.183.69.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vosn.de
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: from mail.steuer-voss.de (localhost [127.0.0.1])
	by mail.steuer-voss.de (Postfix) with ESMTP id DD917267;
	Wed,  4 Dec 2024 11:40:37 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Dec 2024 11:40:37 +0100
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
In-Reply-To: <2d7f8afc-119a-4080-93be-bf3daf017e5e@denx.de>
References: <20241203191111.47B56F7@mail.steuer-voss.de>
 <2d7f8afc-119a-4080-93be-bf3daf017e5e@denx.de>
User-Agent: Roundcube Webmail/1.5.0
Message-ID: <abcc89936f44fd884b9c5da65ea64c42@vosn.de>
X-Sender: nv@vosn.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi Marek,

On 03.12.2024 21:15, Marek Vasut wrote:
> On 12/3/24 8:09 PM, Nikolaus Voss wrote:
>> LDB clock has to be a fixed multiple of the pixel clock.
>> As LDB and pixel clock are derived from different clock sources
> 
> Can you please share the content of /sys/kernel/debug/clk/clk_summary ?

Sure. Without my patch:

     video_pll1_ref_sel               1       1        0        24000000  
   0          0     50000      Y      deviceless                      
no_connection_id
        video_pll1                    1       1        0        
1039500000  0          0     50000      Y         deviceless             
          no_connection_id
           video_pll1_bypass          1       1        0        
1039500000  0          0     50000      Y            deviceless          
             no_connection_id
              video_pll1_out          2       2        0        
1039500000  0          0     50000      Y               deviceless       
                no_connection_id
                 media_ldb            1       1        0        346500000 
   0          0     50000      Y                  
32ec0000.blk-ctrl:bridge@5c     ldb
                                                                          
                                                  deviceless              
         no_connection_id
                    media_ldb_root_clk 0       0        0        
346500000   0          0     50000      Y                     deviceless 
                      no_connection_id
                 media_disp2_pix      1       1        0        51975000  
   0          0     50000      Y                  deviceless              
         no_connection_id
                    media_disp2_pix_root_clk 1       1        0        
51975000    0          0     50000      Y                     
32e90000.display-controller     pix

Here 346500000 (media_ldb) != 7 * 51975000 (media_disp2_pix)
   -> distorted panel image (if any).
The requested panel pixel clock from EDID is 51200000.

This is the same with my patch:

     video_pll1_ref_sel               1       1        0        24000000  
   0          0     50000      Y      deviceless                      
no_connection_id
        video_pll1                    1       1        0        
1039500000  0          0     50000      Y         deviceless             
          no_connection_id
           video_pll1_bypass          1       1        0        
1039500000  0          0     50000      Y            deviceless          
             no_connection_id
              video_pll1_out          2       2        0        
1039500000  0          0     50000      Y               deviceless       
                no_connection_id
                 media_ldb            1       1        0        346500000 
   0          0     50000      Y                  
32ec0000.blk-ctrl:bridge@5c     ldb
                                                                          
                                                  deviceless              
         no_connection_id
                    media_ldb_root_clk 0       0        0        
346500000   0          0     50000      Y                     deviceless 
                      no_connection_id
                 media_disp2_pix      1       1        0        49500000  
   0          0     50000      Y                  deviceless              
         no_connection_id
                    media_disp2_pix_root_clk 1       1        0        
49500000    0          0     50000      Y                     
32e90000.display-controller     pix

So, here 346500000 (media_ldb) = 7 * 49500000 (media_disp2_pix).
   -> stable panel image, but pixel clock reduced to 49.5 MHz from 
requested 51.2 MHz.

My conclusion: The clock source is the same, nevertheless the
ldb/pixel clock constraint cannot be satisfied without either
modifying the pll clock or the pixel clock.

-- 
Nikolaus Voss

