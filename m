Return-Path: <linux-kernel+bounces-524218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 432F9A3E0AF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A0547A7504
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D6620D4EA;
	Thu, 20 Feb 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EXwVsrVK"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9D91FFC4B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068885; cv=none; b=c4LuYZ64/eMrB0yPpeFvsXZjb2wGmuJc0Gm5nlfUlmyRROhLGQEIxQLKaXHcc2CjZoUpfBJA8wLokVVFdPkVTaqTiUKw/XSRSZie0M7y+uBnP5RypgwInQZHgxJOhZdh2rM+BRIKEVHVhVtcZ3saiFzdFUwyOO2Im+3cacIB6qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068885; c=relaxed/simple;
	bh=xbuB4v9UY+AZQ9DxHNx0yrkkoAjU5kCgeOxjeEoyiCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DO39Apb/ONXgR20UbjOluOh7G0rIWaSseokDgmjCYBnwn7b+tsVm7+8fENhsiagwz+X6NVDfZ91IFuvArG8z5RXnqY1yAE7mXp+93a7CTDtYijVHaifE/FB0LJ9lEvX92q6sqeeGowDJG+tV3TR2Z6B6rAYQN4EJw+KdtPRDwc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EXwVsrVK; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eotf4X4yWZCzZmmNzhXG8/clvYwDsnXoUd843iZILzc=; b=EXwVsrVKDlIdDfrYtaclqkAmk8
	CmeyvQU4fIFXtUP33OM6F19wpmb9YLeN6Vlm4C4XjofRWhUK5tTm4IJdiU+Bjq0OKBFdl1vYC8veS
	bcrYzHSiVAXWQTFjsgT619Lpwo2lS/PQ923paHY1/aM3MW/3jUlFUPA7nlGbREPMoRNcxU8rlTXyG
	R323O9tTjaXe52O0Jr3BveZKgHGP/JlV5IOS+7bzf1bVWoatKzpn95XrPN8JHiHMcjiQ1O9TnwXSM
	ewWRT9OwV0qVBZjoXn5eGihVp0zUzu2uk3FNEoYa9nF3dCgMpJqy579onIC6gQEYaMz04npjEoH+j
	JTQZkPVA==;
Received: from [191.204.194.148] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tl9Ow-00FS04-Lg; Thu, 20 Feb 2025 17:27:56 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	siqueira@igalia.com
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 0/3] drm/amdgpu: Small reset improvements
Date: Thu, 20 Feb 2025 13:27:47 -0300
Message-ID: <20250220162750.343139-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series does some small improvements to GPU reset information collection.

v2: Keep the wedge event in amdgpu_device_gpu_recover() and add and
    extra check to avoid triggering two events.

André Almeida (3):
  drm/amdgpu: Log the creation of a coredump file
  drm/amdgpu: Log after a successful ring reset
  drm/amdgpu: Trigger a wedged event for every type of reset

 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       | 21 ++++++++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.48.1


