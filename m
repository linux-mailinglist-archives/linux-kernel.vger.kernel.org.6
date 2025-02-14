Return-Path: <linux-kernel+bounces-514627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67596A35975
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897C616F33F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89A6229B18;
	Fri, 14 Feb 2025 08:55:51 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A90F18DF64
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739523351; cv=none; b=sZ9XsWxZ95X0/TyLeiJsQtmDBpMiQMMj5Wlun+L/EyKL2K6E0VaracVQU3CXXKftsOmTEPU5STRgVee9UrRTXyFLP04QckI7NSvpbcPD5SQRjix7gM7B0Ll6dqNGqmfOLJkhOxj2zg7cyNgyq2H3CfcuFoYAyBJQ9N7Q7edwVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739523351; c=relaxed/simple;
	bh=3LuVVB3Hq/sIcuA6V6jc4GTisXR8AiCjtPoyLdZ9Bx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CW12HMsQGLtLXUFCd64h62e5iVtyAew8wAs3UOvNTsU+8LxwbJJNk0XATOIZGsZVL/ReBNL6vMASK89tdSHR97wqqUUFlLjmTrUF7m4uPsmN3FKzDtotj+u2uwBxLyyunuZm7n913MgOQdD98FMQIA0AbUl4e+KAfjuZqEzR0q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1tirU5-00018k-91; Fri, 14 Feb 2025 09:55:41 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tirU4-000t9T-2z;
	Fri, 14 Feb 2025 09:55:40 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tirU4-00Ed9w-2f;
	Fri, 14 Feb 2025 09:55:40 +0100
Date: Fri, 14 Feb 2025 09:55:40 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, marex@denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4] soc: imx8m: Unregister cpufreq and soc dev in cleanup
 path
Message-ID: <20250214085540.o3qrylwoc457c52z@pengutronix.de>
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
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-02-14, Peng Fan (OSS) wrote:
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

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

