Return-Path: <linux-kernel+bounces-211109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A127C904D38
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D84283DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407F716C69E;
	Wed, 12 Jun 2024 07:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VirQKIzA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869642772A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718178957; cv=none; b=mCOoZ8mc6AJOPQZ7yKqgC+1FMzDhOhoHgY07B760aFAh5M3Uz4H8O4omEnAupATsFpD/bT8R93W4Jqr4vxji1quuNQsNbjaX4pYbRlIN9HuecbPiSSAORgqzAtu9LIjYEfWB0jH0ok40ugGUhLQfds2F2wPyACTsL/wuAFdnr2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718178957; c=relaxed/simple;
	bh=DPxfwqw32UzG01diDS0TG9qPWmDaaLhYilwUhVS25/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u50ljkMajeEOXYjTDafLw2yerWvF70g1HCpkUxnfWpzdGTs7qKyqlkY2Rfwktr+7m8Oao4IBE7LG0BGofAwAr+KLJTmjzWZkMdY6bTrmUGedbt6oV3+4eOi2MoFNv2MlKtlw9DJNPy9wI0DntDkFz3EX4muZwVAhgeY8Ly4pUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VirQKIzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9807C3277B;
	Wed, 12 Jun 2024 07:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718178957;
	bh=DPxfwqw32UzG01diDS0TG9qPWmDaaLhYilwUhVS25/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VirQKIzA8Si2u5Y+WDCr4RAezIVKUHMUpfvmAWO+355t3/gJFJhOx/aYn76B1YhxI
	 10g7HZOZPDB0tM0TluMfK2+dfkSk2QS8VX4E4n8giVfOL1e+t/80A4MecLKSUN1zlf
	 gZ0EJf8ejdnv/CRDfzF77455pTOKcOJ1/ko4Q5Oag9Ei0+iJipkVJ6RvySp6cOckI3
	 1Yx6SOzQUuy1gnfWcsX477iXngeuvysJMwCttLw379fx8TVrpiCLcqqWceZSmp1DHR
	 1Yg3bSQzDAeubyP8sGzhUJrQUWMHasll26/gleJ3YAXyjtq6D3U4enIJ4UFRoG5kxE
	 J+7fc5+qkCJyQ==
From: Maxime Ripard <mripard@kernel.org>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Amjad Ouled-Ameur <amjad.ouled-ameur@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Smitha T Murthy <smitha.tmurthy@arm.com>, 
 Deepak Pandey <deepak.pandey@arm.com>
In-Reply-To: <20240610102056.40406-1-amjad.ouled-ameur@arm.com>
References: <20240610102056.40406-1-amjad.ouled-ameur@arm.com>
Subject: Re: (subset) [PATCH] drm/komeda: check for error-valued pointer
Message-Id: <171817895441.766399.8225643832267707150.b4-ty@kernel.org>
Date: Wed, 12 Jun 2024 09:55:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 10 Jun 2024 11:20:56 +0100, Amjad Ouled-Ameur wrote:
> komeda_pipeline_get_state() may return an error-valued pointer, thus
> check the pointer for negative or null value before dereferencing.
> 
> 

Applied to misc/kernel.git (drm-misc-fixes).

Thanks!
Maxime


