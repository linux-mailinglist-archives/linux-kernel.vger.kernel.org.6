Return-Path: <linux-kernel+bounces-262034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2EC93BFCC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2921C215DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745D8198E63;
	Thu, 25 Jul 2024 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDvXdBgx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BE819750B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721902736; cv=none; b=H1y6IbOVB5/sMWliNap+U1I87Ol23B3U8DmfbuIPQNOSnKw3CCD9KSXkD3XAIi7kPB/ZCH2fBBBP/Cr68MfyiT/W4ATsKdoPHksQ9v48+tYWsIrh34A9fzPfFDHimPEnqMbzRo8tVMqmr3N972z7oxoFGHj9bXkdAVzKjUqPm24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721902736; c=relaxed/simple;
	bh=xcyUsAObjzUoWt+gYb3Nj0AXQctkIgHNhrm+t1FDpHc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jPOnoLQgxrutl5cL034PocB0Oi/SrZ5O8VZIRewux2xeF/F05YlPJkq0yPhHibbkihifbuo/tPe/Laqc9q+ACgquyw+yUHSmK/hzF8krGkUIOzFLorDgnpvl1NXolbfFICmTXUmpsfLg2rGPEwdrsdGTvq1bEdAFj+075og5iss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDvXdBgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FA3C116B1;
	Thu, 25 Jul 2024 10:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721902736;
	bh=xcyUsAObjzUoWt+gYb3Nj0AXQctkIgHNhrm+t1FDpHc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gDvXdBgxICvZ5rwCX8u757PEZ1xtVnIDnRC06/FBhChJUE8PjgEG5ezRSDt1mnMmX
	 mBLwlN2DYnRxSYudrRwn6rkwJq1E43MmnInRWP7bWXeWh+A+Tu3+ccvajCwrbKeljB
	 WW8haobavU8KMOtR9vFG/8GGBX4W+7SD27DW+dIYGUVTypt+T1PTTAprK7tk7SCIz+
	 DKPIYZ0BNJgXQNlH5wJckZkZ8FSsVYqRTvOa8fqIvOx1q8hZRIQT0PjQjVTJ1eTjXR
	 OSaozvJtIPMgVDAiXsuXvVDBXmPd/9sspVKx4JBaQkLQabnmgLlQVVv14FhBP7Ua3l
	 zIWUkL7lBiAXg==
From: Robert Foss <rfoss@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Pin-yen Lin <treapking@chromium.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Kuro Chung <kuro.chung@ite.com.tw>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20240719110623.1850021-1-treapking@chromium.org>
References: <20240719110623.1850021-1-treapking@chromium.org>
Subject: Re: [PATCH] drm/bridge: it6505: Disable IRQ when powered off
Message-Id: <172190273302.1592998.13226934023612913257.b4-ty@kernel.org>
Date: Thu, 25 Jul 2024 12:18:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 19 Jul 2024 19:05:36 +0800, Pin-yen Lin wrote:
> When the bridge is powered off, disable the IRQ until the next power on
> to workaround an interrupt storm on some badly-designed hardware.
> 
> 

Applied, thanks!

[1/1] drm/bridge: it6505: Disable IRQ when powered off
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=10ba3753665f



Rob



