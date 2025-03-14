Return-Path: <linux-kernel+bounces-561504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF68A612BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6849D7A6A93
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099371FF61D;
	Fri, 14 Mar 2025 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7xhDzVO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F1A1FDE26
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959227; cv=none; b=FUxc2QS0r5aVj8rGkekV8U9VO4xdYtPmpecbOAgWPSOfYe67eY0DQztMCLnwVgjC7ij/LUMk9GWEKzg/a/E4NiX246JCGsCglc9Erpi3pPs8PT4xoUuedxxJHo7CdHZKiSihz16TQWkeftbq28i5LDQ1HjahSY/txEATuqQwT4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959227; c=relaxed/simple;
	bh=loodNzrUi1U1/aKWFeUcg7+3ZF6ne7Dvoyl2XSrp6i4=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=AS/kpDz19HNaLOHFRLyZf7giJVon6hPQO7d/Z5GebjIW74ByHfOyhj02jK8IyK0NfASZh1QTV4HN92FbyqBdsplFVIwIfeCDSijUJQlpgxNCmO2EtXGCbHHmnkxDKBtiNNVifgm39EFSo0jQ6S9NPL1tsxh/e2aSEIAwUzkRy14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7xhDzVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F46C4CEE3;
	Fri, 14 Mar 2025 13:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741959226;
	bh=loodNzrUi1U1/aKWFeUcg7+3ZF6ne7Dvoyl2XSrp6i4=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=V7xhDzVOqhy8xuG6nppZU7U3mCPKnBa5vHNF6X/Adc/djde5FnmcCnviMX8nv/Pam
	 K/MR2imbb6+qixX1FQ1K6a/H/NClX6AadNd7aO48BRkFDSsIKzZvym0+gG1yjsoeoF
	 6Qc3xAllcjFi3sKgX0s7sA+2wY7bbFF/D7inxrRTTb8qYFp4R1WuNZPFgO2cpgdYbV
	 w72C1U7ploBr5IRT2NuBJKFYSFbj+dVPzOln6H5vJCvaQgLpnns2IGr+SQkqanFu4C
	 ftbsMq+F/WC+QEHMXelKuwJgJxm8kxC72PRHfLcOTi9mNuNIsU/XeowotzJsV3TARv
	 GPo9FQ5/pr87A==
Message-ID: <25f45ec5103eebdee9883a60f0af5fb6@kernel.org>
Date: Fri, 14 Mar 2025 13:33:44 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "David Turner" <david.turner@raspberrypi.com>
Subject: Re: [PATCH v3 2/2] drm/vc4: hdmi: Add jack detection to HDMI audio
 driver
In-Reply-To: <20250312-vc4_hotplug-v3-2-d75878677de8@raspberrypi.com>
References: <20250312-vc4_hotplug-v3-2-d75878677de8@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Dave
 Stevenson" <dave.stevenson@raspberrypi.com>, "David Airlie" <airlied@gmail.com>, "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, "Raspberry
 Pi Kernel Maintenance" <kernel-list@raspberrypi.com>, "Simona Vetter" <simona@ffwll.ch>, "Stefan
 Wahren" <wahrenst@gmx.net>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Wed, 12 Mar 2025 15:40:56 +0000, David Turner wrote:
> Add ALSA jack detection to the vc4-hdmi audio driver so userspace knows
> when to add/remove HDMI audio devices.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: David Turner <david.turner@raspberrypi.com>
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

