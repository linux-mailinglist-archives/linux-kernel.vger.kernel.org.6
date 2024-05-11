Return-Path: <linux-kernel+bounces-176476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174868C3098
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 12:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84634B211CD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 10:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BA3548E3;
	Sat, 11 May 2024 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+m/I/Xe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20F51078B;
	Sat, 11 May 2024 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715423363; cv=none; b=G6irqD7jTAOglrtLXlVxidksZy3IJitat5Ngza2uEVN1LTz8Bt+tt8BFsYImKZWEq3peu9ujRYcIIDJf7/aVwjlPdOvsF0vCjSrEfVyvbkrC8bqiYm68i6rPAGZkbZNQaZFIe2fdNSHXWMy3mlgyLdWpKfmRZ+4hOM8myi/uwIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715423363; c=relaxed/simple;
	bh=PMAOwpgrZ/FIs0F+Zm1F7GYZkjeMZ8mXeT9Vjz1iQKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KY1/jQ2HZIhX6Xh9vbYuXyp/UD/TEIwtgEhQtKUK7QpK3AYxXSBB3BlIp4ozNEbH2z7QdkAXjn0LbEQLQxkdAHKFxx6fRuQ7HnT7hPgzMuY8MxRcpuse6OuopTNvhMpWasu6AAhXwNLaQic2rjg1D9vgh1a33nRvnH/mph+O7/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+m/I/Xe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B746C2BBFC;
	Sat, 11 May 2024 10:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715423362;
	bh=PMAOwpgrZ/FIs0F+Zm1F7GYZkjeMZ8mXeT9Vjz1iQKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+m/I/XepZWIXPMMtrcIJyMaaTAVELjIGDXFmg2qEADMWmje79euTE0sVQAe9UU2b
	 FrqUySHoJI+qxgdWk2CEKwZtGIo4Qg+9cW+5VhVQRlONW99TIRdq3GUKGvWZ6eN1m0
	 uMiDYVokDyvWwwNR27Xs0/J2N+jsUkrmbFxmlsNLLCz4OQ5lUxmUBOTLVhw/HzBKaI
	 gxgcPrzrZhCQfOySVg5iaO+dqtwhSkdsveySxX91Nhk1TJmTcpUAHH0P33tQCJFTEw
	 7VQxV//HrfQCYAPuobJ5l0/p1jkZ1Pp77OrwCBVb/aGRW39bWmqOoyT/1gTy20eqL7
	 N+wQJ6+gtGbGg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s5jyr-000000004cA-1Mhi;
	Sat, 11 May 2024 12:29:29 +0200
Date: Sat, 11 May 2024 12:29:29 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/bridge: aux-hpd-bridge: correct
 devm_drm_dp_hpd_bridge_add() stub
Message-ID: <Zj9IiezupybPOxIn@hovoldconsulting.com>
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

Thanks for fixing this.

This one should also be backported (e.g. as the patch that can trigger
this probably also should be backported to 6.8 [1]):

Cc: stable@vger.kernel.org	# 6.8
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan

[1] https://lore.kernel.org/r/20240424-qc-pmic-typec-hpd-split-v4-1-f7e10d147443@linaro.org 

