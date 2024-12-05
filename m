Return-Path: <linux-kernel+bounces-432850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9E19E5105
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2C0287EC3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F441D5AA5;
	Thu,  5 Dec 2024 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUQJ7wRi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A420C1D47D9;
	Thu,  5 Dec 2024 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390237; cv=none; b=theGH54PvXJFTCbLhnl8wh+MbfAeQHgngPYDWM56bpW8VIwYQ3Zy4BNCITRNRwG/JV+4Cj58I+YaRVd7IJ2Di2DmR8ILw51eN/AG5CRuJMoKV/odl75GoIDZX7/scIll+WiN9UAzbb+hy+3XuNAhJGhAko64eo+65HlQh/kIUsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390237; c=relaxed/simple;
	bh=QOb9P9iUUuYbXp8H+bEnhQIs7EBkcuBhE1xcEl9HfSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcJWYSWot0+yhP6l56WqmDb3/pZqjdShOqfHSVGAmjSW/cuo7/J6sM5X7mQ1jzGHb5F619+l6lCrrUS8xowFwQyu4zp7QDybeYdssnTbb4w2mql5dY2GtH4UjQQm20VPMWwpZr+K3iUVYj2PUd7q+PK5dhAyGucziwToCq1z2Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUQJ7wRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4560C4CED1;
	Thu,  5 Dec 2024 09:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733390237;
	bh=QOb9P9iUUuYbXp8H+bEnhQIs7EBkcuBhE1xcEl9HfSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dUQJ7wRi1jEPT4Ea18YNhAjq8BH/p8Nh8GdgvQvFwsk6AcSoFIwi0obdKwoDanA8D
	 erRYDZub8cjMcdChPYVwWj2EdteaJtPk5sp8VTk3lXciaJEaudp8jw4bEjRCBqK6ad
	 2YP9SjIBMPWU3DOrfouWL1evpNl76Kt/jTFBVPddZ+P6dyNqx7PpkFxNxECx19TsMm
	 cVABsLUrOTnvZNds7gqnxdtnbW8RiHL85WLXRl12MGy3ruQ8I2jchQabR0iuVQMbJo
	 SsV808YnOZkfZmvZdTsrR0B8uoNsYBdsDW2RsGjDgXZK/qMS8YevXseuO+iTFdAAx7
	 HH9P0VNYJOu2A==
Date: Thu, 5 Dec 2024 10:17:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vabhav Sharma <vabhav.sharma@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, frank.li@nxp.com, 
	pankaj.gupta@nxp.com, daniel.baluta@nxp.com, silvano.dininno@nxp.com, V.Sethi@nxp.com, 
	meenakshi.aggarwal@nxp.com, Franck LENORMAND <franck.lenormand@nxp.com>, 
	Iuliana Prodan <iuliana.prodan@nxp.com>, Horia Geanta <horia.geanta@nxp.com>
Subject: Re: [PATCH v4 0/4] firmware: imx: secvio: Add secvio support
Message-ID: <qgh5pzcjlke55eszovjfa3xs4icepcwz7dpfalgo2p6xyv4yei@xmgofqph4yph>
References: <20241205-secvio-v4-0-5c37cdc39573@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205-secvio-v4-0-5c37cdc39573@nxp.com>

On Thu, Dec 05, 2024 at 05:56:31AM +0100, Vabhav Sharma wrote:
> The tampers are security feature available on i.MX products and
> managed by SNVS block.The tamper goal is to detect the variation
> of hardware or physical parameters, which can indicate an attack.
> 
> The SNVS, which provides secure non-volatile storage, allows to
> detect some hardware attacks against the SoC.They are connected
> to the security-violation ports, which send an alert when an
> out-of-range value is detected.
> 
> This detection is done by:
> -Analog tampers: measure analogic values
> 	- External clock frequency.
> 	- Temperature.
> 	- Voltage.
> 
> - Digital tampers:
> 	- External tamper
> 	- Other detectors:
> 		- Secure real-time counter rollover tamper.
> 		- Monotonic counter rollover tamper.
> 		- Power supply glitch tamper.
> 
> The on-chip sensors for voltage, temperature, and clock frequency
> indicate if tamper scenarios may be present. These sensors generate an
> out-of-range signal that causes a security violation to clear the
> authentication and storage keys and to block access to sensitive
> information.
> 
> Add linux module secvio driver to handle security violation interrupt.
> 
> The "imx-secvio-sc" module is designed to report security violations
> and tamper triggering to the user.
> 
> The functionalities of the module are accessible via the "debugfs"
> kernel.The folder containing the interface files for the module is
> "<kernel_debugfs>/secvio/".


Debugfs is for debugging, not accessing functions. Come with proper
sysfs or other control interface and its ABI, not debugging one to avoid
any review.

Best regards,
Krzysztof


