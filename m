Return-Path: <linux-kernel+bounces-527614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A79A40D4E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 08:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED567A3740
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 07:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427041FC7F2;
	Sun, 23 Feb 2025 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Hc5YUR7R"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075A81DC9AF
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740297437; cv=none; b=WCCF8aXqPVqFP7wjWevH5342mlXexyQDTthsbuhYmGuHW5Fsepv7jpXSv61KO9cPPnckUId1P9h0IN/OpPfjcMReqPXiVQIsWADndw0GYcFjX99ZITdL6uVQ18p2HU2QJx55lkxPe9iDCktKWqeOemTNwmRKHBDTbMTCl2Xz3zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740297437; c=relaxed/simple;
	bh=NuQImlU99qGsIQYpmmq+iOil94royqBWQVbIr/8J4GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6i9zS21+g00eDRHxQhTcsc9xsafeHLxFrb4OOuj4CwsdPNgeMLv0Ix6nmRTFoW18yyjz+RekHdRpq/Vt7oownSmTjDSWTWNWRLvfhdWaYd6Rsz622z3/lC54DF9vKpbE7zD+SNrzA3uG1PVu8r4Nb6tbvDIU93k+rmF0qKub3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Hc5YUR7R; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=5DVOc43tpuHAeSYUprVK/px81spsWiqY11TWh6bFcbI=;
	b=Hc5YUR7RMKeIPr9yWOW0WaAIKkxFLkGacRfrAK1j5qvMpYwQabpQ0MeSeMHzjy
	B7rglAa0ztRY/yrNz3B9TzR377wkkHaN7L1bDR5DwRZmGHEYJgxEzZ4eIyiKPMkf
	ZlUWQ7yAfWHmmSJXBa4yLNmRl7BJwwxkrfLSgy5IExSNY=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgAnL+au1LpnwNGLCQ--.21312S3;
	Sun, 23 Feb 2025 15:56:32 +0800 (CST)
Date: Sun, 23 Feb 2025 15:56:30 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, marex@denx.de,
	Peng Fan <peng.fan@nxp.com>, Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH V4] soc: imx8m: Unregister cpufreq and soc dev in cleanup
 path
Message-ID: <Z7rUrhJxZ3gk9nTW@dragon>
References: <20250214084751.2975503-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214084751.2975503-1-peng.fan@oss.nxp.com>
X-CM-TRANSID:M88vCgAnL+au1LpnwNGLCQ--.21312S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrAw13Gw47GF1fZr4UZFy5Arb_yoWxXFX_uF
	4Iyw1UGw48Ga9Fgr93Wrn7W3ZrKa93tr4UZ3Wqyrs2yr93K34DGFnYkrsYqF1UGw1rWa9F
	vF98tFW0grZxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU05rcDUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEQ38ZWe6kszZYgAAs9

On Fri, Feb 14, 2025 at 04:47:51PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Unregister the cpufreq device and soc device when resource unwinding,
> otherwise there will be warning when do removing test:
> sysfs: cannot create duplicate filename '/devices/platform/imx-cpufreq-dt'
> CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc1-next-20241204
> Hardware name: NXP i.MX8MPlus EVK board (DT)
> 
> Fixes: 9cc832d37799 ("soc: imx8m: Probe the SoC driver as platform driver")
> Cc: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!


