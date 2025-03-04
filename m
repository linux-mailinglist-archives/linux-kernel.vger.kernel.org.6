Return-Path: <linux-kernel+bounces-543034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A20A4D0C8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42FB173A6B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7144C131E2D;
	Tue,  4 Mar 2025 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eokXTI6Y"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8568273FD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051683; cv=none; b=cXqZTtpTRO2t/5AdeleMAe/vrGmIIVxsPkrskREkCAQmiETZ8ouayOUmI7+2ZyLqvXsvRZAbak9WaFUguNLFzDhNclGEYWZPkpPMLGXzPM8Wp4oBoloAjCob6IhctoRZdFfNM3Zv2g7zau/rwjJNnicZSc/Uolir9VaLYHoMQ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051683; c=relaxed/simple;
	bh=t+Xrt0qsNI/3jCv8vxd3v9EHoBPhonl6lmfjg43y+fI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QYUKk7kbKeEZmwWqud4hujuGmD5lAdsnMF+tnrDq5qH7Q+/CqxFpx3c3yeXHL6NMuCCLpY5kPSM1PaFaqqbnSHqZ1zPSnv2QCCRkbOfBu/k+OCA08kKXCRQ/mbkolwR8zWSfg8/0SFeYcWT/6t2HNBtvsqVxLvwOahBZ50vr3cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eokXTI6Y; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cglj5woUV+xBeWxO2ZGZ/VdsyqOBQIzL5JqjWUsjQCQ=; b=eokXTI6Y7COlJGaHcHIcxk2Hxi
	MOkOLldymOkSmxLGCUR2pT6NP9NpgPvO/TLFxbSjP1IhiVB8uBrmcex2HCMd/8m9HlWJEMvOyPYlj
	KcxV3+pYxRCzb3FhWEnA9YZWMK3f1Up+Eis8HmC0IUbb/VNfrQzsexO/waVvnSgUEYPwcXMWs7HxP
	7Y3zvvIrHQ166ZqBLSJZb/O/ySyzVfj+9A5LRZsv+9D7+fxBj9i4nPcK+CSguZVuSX4AjSQMj8lVQ
	I8Hk2t+cWopxtyApTOh6F3bUqmfYnwN4/dXJ2N2kUiUkWp3XyEMMbmvFBH6teWz5aEJ2rgbMv4aO3
	F/qyqFQw==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tpH4S-003VPW-7i; Tue, 04 Mar 2025 02:27:50 +0100
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com
Cc: kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH v3 0/2] sched_ext: Add trace point to sched_ext core events
Date: Tue,  4 Mar 2025 10:27:38 +0900
Message-ID: <20250304012740.35473-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tracing support to track sched_ext core events (/sched_ext/sched_ext_event)
to debug and monitor sched_ext schedulers. Also, change the core event type
from u64 to s64 to support negative event values.

ChangeLog v2 -> v3:
 - Change the type of @delta from __u64 to __s64 and make corresponding changes
   in scx_event_stats and scx_qmap.bpf.c.

ChangeLog v1 -> v2:
 - Rename @added field to @delta for clarity.
 - Rename sched_ext_add_event to sched_ext_event.
 - Drop the @offset field to avoid the potential misuse of non-portable numbers.

Changwoo Min (2):
  sched_ext: Change the event type from u64 to s64
  sched_ext: Add trace point to track sched_ext core events

 include/trace/events/sched_ext.h | 19 +++++++++++++++++++
 kernel/sched/ext.c               | 22 ++++++++++++----------
 tools/sched_ext/scx_qmap.bpf.c   | 16 ++++++++--------
 3 files changed, 39 insertions(+), 18 deletions(-)

-- 
2.48.1


