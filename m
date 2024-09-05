Return-Path: <linux-kernel+bounces-317623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2E596E131
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A42E28AE4A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E57A1A42D2;
	Thu,  5 Sep 2024 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b="Z83LRDkE"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C8C1922FD
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725557731; cv=pass; b=SnhpWlSJPH4Ht4+lqANcaopH/z0/w18LDx7Z3iPMsrLy2mWakdCCuKrxihHxCppBqQZ2AaoRPrBCnvkZIHxxvp5hTSfLVLWmW88wGhbNLF867XHvCIpneA4XavFwNpfTqNSL7fssMqXqOokPkpmBgc1D4lhVV7MOQU/u+7jzolU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725557731; c=relaxed/simple;
	bh=CaGbbZXIrJXwBFkIvSgdSd499bR+nRNPpUF09By1jh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZQqzaoEn+BLfHVbRhiMNRwpWmj9Jm7kvERjZznNoPxXMRpSy0oXSmuzZLlCUqNwmQwglhbeI8VNksgZtI6iLnW5TDSRfhScVpaYcJGivMeUdWjcXVj/oUlkTjRfJOGytRlajIJRXc/yLDGNmKjFgzLn7TJoxhtYfB7ycJA/Whbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b=Z83LRDkE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: boris.brezillon@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725557723; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TuLBEVWRBcDiVKWhwyNV1ctD1d72aYhSugdgXIsgM7MrawUu2WC6natXhQbjuVg1SF8SETads0m36bMrpY3yaqI7xBlR9YkbcuNacEtmWfVuX1xvwciq/WD4OgCwvXxnngsfX5i0zAblD334qIMfYFdA7dbF0DsGbkxEirzru7I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725557723; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uCPBpKjvFpzfgJ19E83MsJvpP3DosEZWIQfDvlOJc7s=; 
	b=hYJpxA/2HXmN0XuT17IuLkZAd9hAYHMNn+CmhizWrPW4yYUFBEstLUDQhMbXmuAiy9HCDAldRZr5fON4ZsU/oA1HNbVZKPOfLdzsFsIbI/5vRUUn7KS5EmxgXdfBtV5OP6LDJHXNa+AUU/XBSC11oDHrvAaC7xQlmlJAoD/DGMI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=mary.guillemard@collabora.com;
	dmarc=pass header.from=<mary.guillemard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725557723;
	s=zohomail; d=collabora.com; i=mary.guillemard@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=uCPBpKjvFpzfgJ19E83MsJvpP3DosEZWIQfDvlOJc7s=;
	b=Z83LRDkE+ZYEmnW9nYFolnk6GsossFkfcVUa9rBeNnZ4RA4Gyp2AH10M+eJSSFVI
	zfb22JIbcOwTYiebkhCzr2jy1SXCiUtwod2A7E9Qq7fwUXkquIArO1KyknyDqH0JH2J
	5kf4zWIxVaNkz3zRVYtFl0c0HaXyLdtTQHQ5ubPs=
Received: by mx.zohomail.com with SMTPS id 1725557720415634.3620957149494;
	Thu, 5 Sep 2024 10:35:20 -0700 (PDT)
From: Mary Guillemard <mary.guillemard@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Christopher Healy <healych@amazon.com>,
	kernel@collabora.com,
	Mary Guillemard <mary.guillemard@collabora.com>
Subject: [PATCH v2 0/2] drm/panthor: Expose realtime group priority and allowed priorites to userspace
Date: Thu,  5 Sep 2024 19:32:21 +0200
Message-ID: <20240905173222.252641-2-mary.guillemard@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This patch series adds support for realtime group priority and exposes
allowed priorities info with a new dev query.

Those changes are required to implement EGL_IMG_context_priority and
EGL_NV_context_priority_realtime extensions properly.

This patch series assumes that [1] is applied. (found in drm-misc-fixes)

The Mesa MR using this series is available here [2].

v2:
- Add Steven Price r-b on the first patch
- Remove drm_panthor_group_allow_priority_flags definition and document
  that allowed_mask is a bitmask of drm_panthor_group_priority on the
  second patch

[1]https://lore.kernel.org/all/20240903144955.144278-2-mary.guillemard@collabora.com/
[2]https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/30991

Mary Guillemard (2):
  drm/panthor: Add PANTHOR_GROUP_PRIORITY_REALTIME group priority
  drm/panthor: Add DEV_QUERY_GROUP_PRIORITIES_INFO dev query

 drivers/gpu/drm/panthor/panthor_drv.c   | 61 +++++++++++++++++--------
 drivers/gpu/drm/panthor/panthor_sched.c |  2 -
 include/uapi/drm/panthor_drm.h          | 29 ++++++++++++
 3 files changed, 71 insertions(+), 21 deletions(-)

-- 
2.46.0


