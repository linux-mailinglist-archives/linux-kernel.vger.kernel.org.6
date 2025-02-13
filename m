Return-Path: <linux-kernel+bounces-512519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453B8A33A60
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4350C168EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA02520D50C;
	Thu, 13 Feb 2025 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHCVDPyt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4F220D4F0;
	Thu, 13 Feb 2025 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437002; cv=none; b=S+LPOER6lk8rz/4l68f4KHCzSbdL3naP2sVDrfHWvNLAz4DUS69JA+LVxk9ZlRRZpYyXtv+SMaEWyTFZG78EMWoM0J1B9xHdn716jqISoT/FQMmLQdwpiQqgV0p9nw9mS2Flfrj+gTlxepSaPMF+0A0UVqxJeQaDr/fEFB8MzHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437002; c=relaxed/simple;
	bh=u0HLLklJOTFaRYEeDQYu/nDUkCt1ooDe7WmRZLU//hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e9mTn1YTFh425e/fjOQffQv8qIElezn05qnu3Q5DWOI7r0MpXM+otS6WZYGkOto4zhwbFTORc8wMb2YxaY4MZMYRL4v1UBqjzesiXVP0mTWNuhgO6f2k4+/IdfG7QGkWpVOspu4AETFLBflit7c8w8kh/TdTS8TvfkmMkkFbF4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHCVDPyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E17C4CED1;
	Thu, 13 Feb 2025 08:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739437001;
	bh=u0HLLklJOTFaRYEeDQYu/nDUkCt1ooDe7WmRZLU//hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QHCVDPyt+W4tprbg/BwpXDdvuglkaaSB65Q+Nd4Rvl5C/zhva/XYfp0ffTgdI0/xb
	 tx4uqxfB1rscXDF9FtdCLFKKGi8QRbc6Zp8SWrHIuUOXK8CHZ9vSCJ5kyq4STDUwfY
	 pCp43nE++vPlvGhHHmuOxf4g6nv66hNZbJqxPqeLo/LXM+4I72HxibP879CgIaBX5u
	 tW02cbYMiXK0SxqXJBogKac9F0KOgQpFf4yN1YSwOVo1V3TWqnhXGHy/JDQ0avyHbQ
	 dnn+DUtmWDBI8JtfKu3QEAHy+WzaN+bkpJUFAv8wqgASaZ48maAkd9bHlQl9SGf5dM
	 xt4Va2cllf17A==
From: Maxime Ripard <mripard@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] drm: writeback: Fix use after free in drm_writeback_connector_cleanup()
Date: Thu, 13 Feb 2025 09:56:33 +0100
Message-ID: <173943698485.1868200.10958498043496540480.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <78abd541-71e9-4b3b-a05d-2c7caf8d5b2f@stanley.mountain>
References: <78abd541-71e9-4b3b-a05d-2c7caf8d5b2f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 12 Feb 2025 18:23:48 +0300, Dan Carpenter wrote:
> The drm_writeback_cleanup_job() function frees "pos" so call
> list_del(&pos->list_entry) first to avoid a use after free.
> 
> 

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime

