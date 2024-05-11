Return-Path: <linux-kernel+bounces-176474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885DD8C308E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 12:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09FBEB21209
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 10:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2D654BF6;
	Sat, 11 May 2024 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J7baCJoX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6AA54750;
	Sat, 11 May 2024 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715422388; cv=none; b=As9El0uGvEdsybZ+ApFAcgjNL7U91eR4t30WZV+zCKGLZISsG2XCkR6vpqfLtCuxbUgNOh1VhSmvrtwHHP3K8bss54RMDoc0oyweKIcVfiqY15/qWmfp7zG27y3UFiRhv76u4dk9avaXMlFxpi7XrDxgGgndBnk2XoyKOb+9LIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715422388; c=relaxed/simple;
	bh=sY4E2uikkRVPa50fJdTiW26GKT1LoEB7hA3kqOi786o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IofQzolJ7jBGTkj8f5V68H/Z8v8ag6hLEY3x7W2e6FaWp2qYNWcNrQsq3vsR3PavfVgz5fyjYzYmeAlzz04Rkh9JD/wCaRwREj2JATbvooi/7iajN5OlL95zAEGBL0BxFp76I6wHAUODMahcpAVcbTWuac57ZRVuqoq0z343PFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J7baCJoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C630C4AF09;
	Sat, 11 May 2024 10:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715422388;
	bh=sY4E2uikkRVPa50fJdTiW26GKT1LoEB7hA3kqOi786o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J7baCJoXTFIuOLfL4afkEaDIDcNcBHiY34IOwFbKvzytrpfdIJHlp9WRcqGDSGCY9
	 tZHBgrkXjXvVMFAG4JaH2P1OmTJC6A4tKyTcJiHCwjXg3qgRsYguDK7CGYFyK39H55
	 CCykDM3P32OjwgaBJaa6k7c1SQcDli/PjzFSHCDo=
Date: Sat, 11 May 2024 11:13:02 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/bridge: aux-hpd-bridge: correct
 devm_drm_dp_hpd_bridge_add() stub
Message-ID: <2024051133-morphing-cradling-d7b8@gregkh>
References: <20240511-fix-aux-hpd-stubs-v1-1-98dae71dfaec@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511-fix-aux-hpd-stubs-v1-1-98dae71dfaec@linaro.org>

On Sat, May 11, 2024 at 11:54:30AM +0300, Dmitry Baryshkov wrote:
> If CONFIG_DRM_AUX_HPD_BRIDGE is not enabled, the aux-bridge.h header
> provides a stub for the bridge's functions. Correct the arguments list
> of one of those stubs to match the argument list of the non-stubbed
> function.
> 
> Fixes: e5ca263508f7 ("drm/bridge: aux-hpd: separate allocation and registration")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405110428.TMCfb1Ut-lkp@intel.com/
> Cc: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  include/drm/bridge/aux-bridge.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You beat me to it, thanks!  I'll take this through the usb-next tree as
we have a commit there that requires this to build properly on 0-day
testing.

greg k-h

