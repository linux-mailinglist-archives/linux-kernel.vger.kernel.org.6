Return-Path: <linux-kernel+bounces-180910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E5C8C74AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE521286FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36EB145332;
	Thu, 16 May 2024 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lOZog/6R"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94184143C55
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715855535; cv=none; b=WZorLCBdrNe0Ga9jXkJt+6Th5/hLG4FWM2HsOGA3QCOfvoE3WiTB1NMcotpU8lhR3aEBY/4bzgyWMSw6+z42/k6tzkYkOkhmx+RuAulcalnOF+3XQvdyu3VxF28xjVGJBmMivuate0CXaHyeA9ouZbJat7lo9uLzrUxsJmvHXkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715855535; c=relaxed/simple;
	bh=tL6KAUUBdX+sVXzhCbeVX6rqZ5fXwzcnVA3Sy4BZ7pE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=drv8nnNhp9VambCudLjS5GswNwVjmJxHMh3YdDQOe1YcyRm81FmjvUuuE+cITdgBWar9PD9SoF3x5+qVMjL+/2Zd+pMRpdMUc/c2rUMAjosexeaTD+ep0D8vWl42tcvIfSOS6aILWM3QL6JXrKUWlPPLPMOZoK06RO6x1FmrOUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lOZog/6R; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44G9fmVS056166;
	Thu, 16 May 2024 04:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715852508;
	bh=wYQOXr5Vdn2rus+peaYLnfyMg1IdCq5SCmKMEecT2l4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=lOZog/6R02eMJWGESciek9BgtgdUOHA/RIeN/A52gS847IG/2nP6fiwFcydkntCMR
	 DANzLXCNaSl2HJoL/sfcEdyBd8m3PQkaJXGXCDRMI9j01ukLspmLajclg9sj6FFVsZ
	 tiniWcz/Ta7ZWGZIsriWt8SVa2gJt5fXNbfrr6mk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44G9fmEM117558
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 May 2024 04:41:48 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 May 2024 04:41:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 May 2024 04:41:48 -0500
Received: from [172.24.227.31] (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44G9ffH0074525;
	Thu, 16 May 2024 04:41:41 -0500
Message-ID: <8bb974f9-90ff-4b61-9623-cf5675f35e78@ti.com>
Date: Thu, 16 May 2024 15:11:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/bridge: cdns-dsi: Fix minor bugs
To: Maxime Ripard <mripard@kernel.org>
CC: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Andrzej Hajda
	<andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert
 Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej
 Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Thomas
 Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>,
        DRI Development List
	<dri-devel@lists.freedesktop.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, Thierry
 Reding <treding@nvidia.com>,
        Kieran Bingham
	<kieran.bingham+renesas@ideasonboard.com>,
        Boris Brezillon
	<boris.brezillon@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar
	<u-kumar1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary
	<j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>
References: <20240511153051.1355825-1-a-bhatia1@ti.com>
 <20240511153051.1355825-3-a-bhatia1@ti.com>
 <20240516-stereotyped-precise-wapiti-6d0cd3@penduick>
Content-Language: en-US
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240516-stereotyped-precise-wapiti-6d0cd3@penduick>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 16/05/24 13:41, Maxime Ripard wrote:
> On Sat, May 11, 2024 at 09:00:46PM +0530, Aradhya Bhatia wrote:
>> Update the Phy initialized state to "not initialized" when the driver
>> (and the hardware by extension) gets suspended. This will allow the Phy
>> to get initialized again after resume.
>>
>> Fix the OF node that gets passed to find the next available bridge in
>> the display pipeline.
>>
>> Fix the order of DSI Link and DSI Phy inits. The link init needs to
>> happen before the Phy is initialized, so the Phy can lock on the
>> incoming PLL reference clock. If this doesn't happen, the Phy cannot
>> lock (until DSI Link is init later on). This causes a warning dump
>> during the kernel boot.
>>
>> Allow the D-Phy config checks to use mode->clock instead of
>> mode->crtc_clock during mode_valid checks, like everywhere else in the
>> driver.
> 
> All these should be in separate patches.
> 

Alright! I will split them into different patches in v2.

Regards
Aradhya

