Return-Path: <linux-kernel+bounces-406080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EB49C5AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA361F23084
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089C51FEFC8;
	Tue, 12 Nov 2024 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nCt+95HR"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117631FCF52
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422528; cv=none; b=QeK5I/FXbyCiibD6MbP2cNviy72gVkAeDKeCHAc4YF60lEom/jAsV+qAct+wz6OLBzYTFhBF74KhlBGR7joi2SqHeMzvqFJ5mlYPf25QqXZkTseiAKNIzSYqGZUr49lfcTsOCQ1XoMChiGIzn0K7Su1Qdmfe3QA5hYyyJ3CxgXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422528; c=relaxed/simple;
	bh=C55enUx95lzHdkblDU+VDmJRQxUKFGzKW2v8XrKPHNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sieItQ/1gL+BQcUwSd4q+QHRRBmGLOU2HASaI1+SFiM4UI2OsjqySvI+OWzi0F5qL4jmsCeVHZ7nlzAvJMkUDB7rQQZETCs142M/rFcVcYZynBwnH3xERUWE03aFhzzemahAs++7cwKPU91LOL9UqUdIypjC2VN2emD2oKlXm7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nCt+95HR; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <37be000a-3ef8-4df4-aefa-b4d73487ad27@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731422522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjtCuBHtQgDpU3KQOdG6+r1FPPieI5NsRRxpX2bOTVg=;
	b=nCt+95HRT/HZ9j+8Iud0gJu10W5OMu+C9+GoNpLHisBXJCDIyhTT6aebp5aN5fV/EiM+1R
	n7hYjSLiCSfA3qiuOxDHyPUgLsVe4H+CKrNEH3UuzayqLotGsBxOgsHLaPb6hkJoWaUBmc
	CnfZaHKi7D6ckeK8Dc5H4SR/IGcev4g=
Date: Tue, 12 Nov 2024 09:41:58 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH next] drm: zynqmp_dp: Unlock on error in
 zynqmp_dp_bridge_atomic_enable()
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michal Simek <michal.simek@amd.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <b4042bd9-c943-4738-a2e1-8647259137c6@stanley.mountain>
 <20241112052754.GB21062@pendragon.ideasonboard.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20241112052754.GB21062@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/12/24 00:27, Laurent Pinchart wrote:
> Hi Dan,
> 
> Thank you for the patch.
> 
> On Mon, Nov 11, 2024 at 12:06:10PM +0300, Dan Carpenter wrote:
>> We added some locking to this function, but accidentally forgot to unlock
>> if zynqmp_dp_mode_configure() failed.  Use a guard lock to fix it.
>> 
>> Fixes: a7d5eeaa57d7 ("drm: zynqmp_dp: Add locking")
>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Sean, how about replacing all the mutex_lock()/mutex_unlock() calls
> you've added in a7d5eeaa57d7 with guards ?

I have no objection to that.

--Sean


