Return-Path: <linux-kernel+bounces-541938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 771C6A4C3A1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7176F3A5AD5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6253213E61;
	Mon,  3 Mar 2025 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="BFTjdSeE"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C142144D3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012779; cv=none; b=IdyvcwENbHjlgfI3CVgzBW4QgSzsaPbHcFBqtjsbmcoXRlRWWnNUbmZeVD881JCf91xpcsmtXsLdtwbt+53CrzbFk8/cqu5LzSSo75FIDQxVet/biHq2L6Rx25AcQOCZDJifPv9TIVYD/TWcNXmlJk3uIicvN4+wcignqItlVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012779; c=relaxed/simple;
	bh=fMQXmIpJnRynyUooJSkwf9B7epSNLxBWIzognhubjfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IYAkAXXEKxf3xLXD21tYlhhS3kqXYCpH14YVEwqOLSNQB2EAqXpwEHqWBCoHtHFfynPP+0X/TXnp0MHjeMks+K8OH5HoXhUmrsPU5vJ3moWcaDly/SwoPYleQc4cj/DubfibXK7Dk9IDHP1hsixdOBXqQWM5aXBRFQP+iXRcBZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=BFTjdSeE; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=CBFiAgytTxTQzTWMXsbcqZJFBhGc1VYrDgGawtSz/iY=; b=BFTjdSeEgK4c28ta
	CTOaJI+TwzcWTtltpn9xrH72Bb74PgKNoXDyANk3kQ28NwgUlUdl8U+spQNYy7LEClHxumLQ1LGy+
	hJnczPrRqSsU/N8MbX/zpGHrbC0aWh/ICABgmi3Uk67+lVtDk9tM0vEAlehKRn3Q+IOVwXE/zGZf7
	EN0JHzmEbd+fMX3qKDZCRor+Fgvr9Nyc8TK9iJZrWtxAZ3EBR1GAGC1Gat0AZ/FiYqGhoptKf/0wX
	ccnvURrCf3Kg2SzV/BCP8/Q1bozIYWbhjPO0NnL1lVeDERzx0rPcVRoGdS9gnKJcy7U3UU3WlmuXC
	V+qQqn+nUv9JlUQjhg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tp6x1-0028PG-0V;
	Mon, 03 Mar 2025 14:39:23 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	austin.zheng@amd.com,
	jun.lei@amd.com,
	kenneth.feng@amd.com,
	linux-kernel@vger.kernel.org
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/6] drm/amdgpu: Deadcode - the P's
Date: Mon,  3 Mar 2025 14:39:16 +0000
Message-ID: <20250303143922.36342-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  Here's another blob of deadcoding in the amdgpu's;
this set is all the symbols I noticed that start with 'P'.
  Most, as normal are whole function removals,
  but I also nuke the powerdown_uvd member in one patch.

Dave

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (6):
  drm/amdgpu: Remove ppatomfwctrl deadcode
  drm/amdgpu: Remove phm_powerdown_uvd
  drm/amdgpu: Remove powerdown_uvd member
  drm/amdgpu: Remove unused pre_surface_trace
  drm/amdgpu: Remove unused print__rq_dlg_params_st
  drm/amdgpu: Remove unused pqm_get_kernel_queue

 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 -
 .../amd/amdkfd/kfd_process_queue_manager.c    |  13 --
 .../gpu/drm/amd/display/dc/core/dc_debug.c    | 120 ------------------
 .../display/dc/dml/display_rq_dlg_helpers.c   |  11 --
 .../display/dc/dml/display_rq_dlg_helpers.h   |   1 -
 .../amd/display/include/logger_interface.h    |   5 -
 .../amd/pm/powerplay/hwmgr/hardwaremanager.c  |  10 --
 .../drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c |  78 ------------
 .../drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h |   3 -
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  |   1 -
 .../powerplay/hwmgr/smu7_clockpowergating.c   |   2 +-
 .../powerplay/hwmgr/smu7_clockpowergating.h   |   1 -
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   |   1 -
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |   1 -
 .../amd/pm/powerplay/inc/hardwaremanager.h    |   1 -
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |   1 -
 16 files changed, 1 insertion(+), 250 deletions(-)

-- 
2.48.1


