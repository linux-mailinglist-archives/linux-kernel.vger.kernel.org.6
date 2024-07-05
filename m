Return-Path: <linux-kernel+bounces-242420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D16D9287D1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063191F23471
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D5D14A08B;
	Fri,  5 Jul 2024 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6g3jB8C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDBA149E0A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178496; cv=none; b=POEHk+lXz1Uk7Jy8uObIw6xMq9YGqKLVRtrycSxQox0QBHJWb3Th5uuQXF2bY49eduTK+yZCScQXdwd0IYpxjtIiY85Lc7LJGf+koyS81MBckLco3nJ58xxcKxFlarUlmrgxZnktROj4PXrpx36KpoAO2Mta+Q6tEBRV/IopkCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178496; c=relaxed/simple;
	bh=bVClftXDHHpDPh0VgbjtXlcSOUs7zeo/ymJqBBRouoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyzKTtE1lz4AQMFl6tIW+yUMINBQGPzJT5dpMoYx/g7dNf6XS7duzudEv2Jwo1MPUDFUN1qp2Ttpv9PwdLfaFr5Up7Fuz7UjJLu+qhpZ9VEPZcqMGZSU19ToVWeMEekkU/H0BsB02U2mfZbpujj4boBVWnVvfYbGI4Hulr/i804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6g3jB8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C646C116B1;
	Fri,  5 Jul 2024 11:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720178496;
	bh=bVClftXDHHpDPh0VgbjtXlcSOUs7zeo/ymJqBBRouoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J6g3jB8CUu7UxGCAqoWW/gvFt7VmQEPVZYQzf2FVR2hY129dP5U+Po2e/lWHfN0XF
	 GHH3Yy68eXYmugU8S5zjKHu32g16uaJRx2rpQsN7VYNGAPfXUSe0ekT6lshFGx71Zq
	 wCa/tR1dPW5fGJYR/DJxjBUX2sXlMJlcLwCq6J/t6h+A4cIR+oGlWRywucvSnb9iRl
	 hnCvA2IEc14+a7Housgm65fLGy82zhe3qEB3m7CaMZx2TPjU5sZIfftHyXKDpPFOYH
	 TGiA14doF1vKxQqBBvXWBmlDGRI4Xc2l8QRaBxpAuYDQtHdgJpm8NuyDkl152y4Kqx
	 D88dZhJrc7g6Q==
From: Maxime Ripard <mripard@kernel.org>
To: Alain Volmat <alain.volmat@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 1/4] drm/sti: dvo: drop driver owner assignment
Date: Fri,  5 Jul 2024 13:21:31 +0200
Message-ID: <172017848787.1096462.10024102415561558148.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
References: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 30 Mar 2024 21:38:28 +0100, Krzysztof Kozlowski wrote:
> Core in platform_driver_register() already sets the .owner, so driver
> does not need to.  Whatever is set here will be anyway overwritten by
> main driver calling platform_driver_register().
> 
> 

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime

