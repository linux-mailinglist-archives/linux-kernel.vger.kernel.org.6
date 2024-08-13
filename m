Return-Path: <linux-kernel+bounces-285507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98986950E53
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502D91F23B82
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46251A7067;
	Tue, 13 Aug 2024 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="VNiSMnF0"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879EC1A38C7
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723583194; cv=pass; b=nVG3as280jnYNkKbUn9B7s+GrXfy/00woliMUC2iCpF8IT6GafRgIyJn+GqZ0Owy7zPmZDGPD04wFBJE7hgieNZ1o/2hUhPiDATpQsvGXXBkNqlBTR5JuiqvF0brV2qItVf+DqkO1uXPhkLwHrKuGEn6K2B5QvaTHbuQ7w27/ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723583194; c=relaxed/simple;
	bh=z257IE3tCLOWQoFDwGJUwLsWIs1kvaQv5TrmPkky3tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTwJtaVMJ87jIuvGigRuPFnKPFs9u6MS44JB4LhfAibERoFzYpzYMUHAk8GLtZGRslGec1eUunI14HWd9abcJ5J/k3vZJm20wN2WDfW0j2nAdC/vKatEPgKw06C/9ALVa+W6wK0ImSXPqy7KDegpPxTy8fsPBEPFvrTfd14Mt3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=VNiSMnF0; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: boris.brezillon@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723583187; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GfuN5SduhOa2Dy6WGFLmlH8mEnUF53zN2Y5h203ASP0EoOLIY0dcUZ4DBQZarCrBfCL+Vdeo5Zszt0KeyL0i1M3AZIf9mwMgGoEQJXjmKkqPFfkVL7FHydFehrhkH9oHRO/xUbwCChnoIXKWxyKaBDIf4l3U9MWAOck1Y+3ePNs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723583187; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sH8Kxf9T0Mh/jOF40A/ZTuNm4Vj8lVB3ZsDwjfslkq4=; 
	b=LkznHqG88E0QaSc+FJhCsjveXhzk8IKkrk8dO8k70e3CBroTIzkapYB1vt9e/Qeo96PX4F8O02HLo+Qd0a7xoHKF2jTB7kaoFr4b0KjDUtHN7rgwzPHvhpan7odtR+gS/Lib1gm56P20yrTcX+pOoho0uw460hv1+l6yvKC7Bng=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723583187;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=sH8Kxf9T0Mh/jOF40A/ZTuNm4Vj8lVB3ZsDwjfslkq4=;
	b=VNiSMnF0pvhAGuQqcrudufi8n0jmfC90c+MCVnj6GpQQSiFV2CUSlIkC6nXy7h5G
	vtK0+rg+qBhGeh6PzoBVrvwjuFcOkWMuhw3kuy+nubIYDUoIG8RnI8uE245Tin9VFU4
	pJRQgGZ589ROr42zqZ4EtEtyFI2MFQXi4QJuITMw=
Received: by mx.zohomail.com with SMTPS id 1723583186458366.1738304104575;
	Tue, 13 Aug 2024 14:06:26 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
To: liviu.dudau@arm.com,
	steven.price@arm.com,
	carsten.haitzler@arm.com,
	boris.brezillon@collabora.com,
	robh@kernel.org,
	faith.ekstrand@collabora.com
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/5] Panthor devcoredump support
Date: Tue, 13 Aug 2024 18:05:42 -0300
Message-ID: <20240813210555.607641-1-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710225011.275153-1-daniel.almeida@collabora.com>
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi all.

I will refrain from writing a changelog here, since I have rewritten
this series from the ground up in C. I removed the Rust-for-Linux people
from the loop for now, since this has become a bit tangential to Rust.

Lastly, this is no longer RFC.

For those looking for a branch instead, please see [0].

I have tested this with the decoder tool I wrote at [1]. Unfortunately
the dumps are too large to share.

You will notice that I added support for a new query. I am still working
on the IGT tests for that. 


Let me know what you think.

-- Daniel

[0] https://gitlab.collabora.com/dwlsalmeida/for-upstream/-/tree/panthor-devcoredump?ref_type=heads
[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/30651

Daniel Almeida (5):
  drm: panthor: expose some fw information through the query ioctl
  drm: panthor: add devcoredump support
  drm: panthor: add debugfs support in panthor_sched
  drm: panthor: add debugfs knob to dump successful jobs
  drm: panthor: allow dumping multiple jobs

 drivers/gpu/drm/panthor/Kconfig          |   1 +
 drivers/gpu/drm/panthor/Makefile         |   1 +
 drivers/gpu/drm/panthor/panthor_device.h |   3 +
 drivers/gpu/drm/panthor/panthor_drv.c    |   9 +
 drivers/gpu/drm/panthor/panthor_dump.c   | 459 +++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_dump.h   |  36 ++
 drivers/gpu/drm/panthor/panthor_mmu.c    |  22 ++
 drivers/gpu/drm/panthor/panthor_mmu.h    |   6 +
 drivers/gpu/drm/panthor/panthor_sched.c  |  92 ++++-
 drivers/gpu/drm/panthor/panthor_sched.h  |  17 +
 include/uapi/drm/panthor_drm.h           | 143 +++++++
 11 files changed, 788 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_dump.c
 create mode 100644 drivers/gpu/drm/panthor/panthor_dump.h

-- 
2.45.2


