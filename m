Return-Path: <linux-kernel+bounces-423619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E219DAA87
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC4F166EEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0E41FF7C4;
	Wed, 27 Nov 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTk/mCsL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2641E1041
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720499; cv=none; b=WV70jDY1sk17B9omXRIdwwRNn5aMiq2Ey339J9+En7PoHFN+Tcvn/e9V2CmIrC/q3iC62YWAPhytBd3FB//id0GQ65btB7i+v2YFgmSapAKmvyiCYinAcAitxizZ1bZtVDEgfakyL8OVA034Nc5by18pt8kGwwczog4B3ei0Wuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720499; c=relaxed/simple;
	bh=xDyB2V7nzgRl1i5zIG6QEKNFLXMrQcIRwvofnEFitV4=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=PQkHjAFWQcYZ1CznBQywM4f0pq1ChGPjcKx3mEjEylk/+9onlOQn0FRyHZ2YGh0OxekiprlWAYoxL8zpzyrscMyWwc3rAlcszvr0Y/EA0k6EPhhhx5FPgy/NXxnZOZT8aSNKe4cX4UEcQoi1jXTN4tluSKxTnPosWNCnNidL698=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTk/mCsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D35C4CECC;
	Wed, 27 Nov 2024 15:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732720498;
	bh=xDyB2V7nzgRl1i5zIG6QEKNFLXMrQcIRwvofnEFitV4=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=cTk/mCsLbWxjjhej3XQVyuLxzO52Dvq+TMbf0O+PQIf2aAMj8b4ud6WP+trMLVSXZ
	 BcebhQBa7I0gdnaz4j8CMZKHJcv0sUALZMx10forB2sjeVu0m2EmudOTV3JXucqXiQ
	 jzYpoK1C5ja6E/QRlmdYivH78r2QgpXd8uTO/Fa3VKwhCaJq9GIkU9WHreqCYXAEYD
	 /MihforS6gJ3DCHfe5Yyezy6TNK6v1fvdvYhBhTzFd41MdvBsPy8AzbZgfjGYTCEQa
	 GjRKvSjhyENRkRlDmBrY3YVeXc/GANB9iusbqnSpv2IbgkY2r+5CCbAQHbhv7rRrOn
	 meSo8my2QP2fg==
Message-ID: <0fdc00c3d39563fa06cf8ac022e36d43@kernel.org>
Date: Wed, 27 Nov 2024 15:14:55 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Subject: Re: [PATCH v2 1/4] drm/vkms: Switch to dynamic allocation for
 connector
In-Reply-To: <20241122-b4-vkms-allocated-v2-1-ff7bddbf0bfb@bootlin.com>
References: <20241122-b4-vkms-allocated-v2-1-ff7bddbf0bfb@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, "David
 Airlie" <airlied@gmail.com>, "Haneen Mohammed" <hamohammed.sa@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 =?utf-8?b?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>, "Melissa Wen" <melissa.srw@gmail.com>, "Rodrigo
 Siqueira" <rodrigosiqueiramelo@gmail.com>, "Simona Vetter" <simona.vetter@ffwll.ch>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Fri, 22 Nov 2024 17:35:09 +0100, Louis Chauvet wrote:
> A specific allocation for the connector is not strictly necessary
> at this point, but in order to implement dynamic configuration of
> VKMS (configFS), it will be easier to have one allocation per
> connector.
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

