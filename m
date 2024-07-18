Return-Path: <linux-kernel+bounces-256354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86581934CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974461C2232E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5829B137905;
	Thu, 18 Jul 2024 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1l5liDI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E58512C473
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721304142; cv=none; b=fGD8x0EpO3RuHCbrfPGawLq4+F1EuNmqNbr69anK2js4rptKhnkVYJKbcsWeH+RCJM1azR8q4m2RI8rZMsGxRRLndHzMxidU+xNnh9oyWhf2IyqfSSDq0q9C5avg6EgmuN21kePmcOyHWWzItGS7EhAfWQuhLAtFxoW84nE6Mz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721304142; c=relaxed/simple;
	bh=4X3CaJuNtXM+dLODj6haMa7pA8m3mfucWCuMrl33fzA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oopJN9iaskapyMFLoEp9oQRxW2X3I7V6BZaSuv9L4DvzZxHv3t998CELKAqt2yvVm2+LcV51SVLk2idsS7qzAFxzcEs7uIDAA4+/DpmcRtlpJg2xXGS0FaKisPeU0FA0E/09L0OU2H2iyab693wtgNEZ2yxRWggZ3/KuGzI1ePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1l5liDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12162C116B1;
	Thu, 18 Jul 2024 12:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721304142;
	bh=4X3CaJuNtXM+dLODj6haMa7pA8m3mfucWCuMrl33fzA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=c1l5liDIz6OLKuDSicL7hu2aczwlYF0xi7JxW4hGZ8Qk7MfOleMq65Uq1dJHoCIl8
	 Bd8mf9fnKtlaWT+iFHqNg971jKj70kmxaAu4MtzlEJm+sWssxkfRdI73KEFDuyHpLG
	 /JwZeXOfsnw19RhZ65OeT3RIwjni92jquBu4iL9iyZAZbqBTb4Nib+1An2uKTSqrCn
	 LDyJCoZ6ZavyXN0uFBpahg88fZa2HqhSydbMDTlT2IxMIzFfCRW8Q6rJd98X+n6jWp
	 YEqG+zKaBcJi7A3JDbZL7tmxVfqi9xROuAUUUTb5TQRbQDhcC3c7pnsB+9mOjJQ+DP
	 /XazVANzV67dQ==
From: Robert Foss <rfoss@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240711-bridge-connector-fix-dbl-free-v1-1-d558b2d0eb93@collabora.com>
References: <20240711-bridge-connector-fix-dbl-free-v1-1-d558b2d0eb93@collabora.com>
Subject: Re: [PATCH] drm/bridge-connector: Fix double free in error
 handling paths
Message-Id: <172130413876.532897.864210015976659933.b4-ty@kernel.org>
Date: Thu, 18 Jul 2024 14:02:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 11 Jul 2024 14:26:55 +0300, Cristian Ciocaltea wrote:
> The recent switch to drmm allocation in drm_bridge_connector_init() may
> cause double free on bridge_connector in some of the error handling
> paths.
> 
> Drop the explicit kfree() calls on bridge_connector.
> 
> 
> [...]

Applied, thanks!

[1/1] drm/bridge-connector: Fix double free in error handling paths
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=ca5442ed8f53



Rob



