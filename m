Return-Path: <linux-kernel+bounces-295689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571C895A01D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117712819AA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DAB1B1D54;
	Wed, 21 Aug 2024 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Dxd4LFQe"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529D51D12F0
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251148; cv=pass; b=Ss3+HjLHG3Wd6pkL9AVnt7/PknF6vHXkbJ/LRhlmUff3sBArlTc39VMBWfL4QoXYGHV1ncf/SfDEttYKIVsBhbxYJKu60UAMshS1ddosm1SZAd5DfooIVI75ymXdRqzbJgQ5L1tdU9IBc1MGduH556PDugFsXSiEDsjwTWXjrRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251148; c=relaxed/simple;
	bh=TkiIXNW92rBz2Tp1iHs3ReQq7mKAM8F/J0ERWa5CWoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxSElMaGsWN4hHwLY0NKwr9QOAT10o3zWsN+bnbxRNERkdxr51710H/YqZqgenqNyClpRH6vWAygK0ev06fMFmAgUHWLV98uNx1c5fvh+Rbn4S1II2h66V+yFWfjuw+6Xa+gCe1lB5kSx1qou6Gpl68tfUCv4PQTSmXlcJJh3Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Dxd4LFQe; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: boris.brezillon@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724251141; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WfQDs93SYT+i9J79NlPp/I7i7EY8sgKvi6stH067ccW97XSFSFROydjpmAkbppAklVytiOcRJz2naN8CEP7j/rR1SnJ3jjNXvi5qiGW2HI3JGEP/5dDYL+INrV6tFLD3XiN8rjxPZGAhyekDklSAROcNjJlQ23WhjESElxkCmFY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724251141; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HL5w15xGJTVkRRqNu8utX28aSRMGFxWi99Z7omzG7fc=; 
	b=Z2BlWgDg94ovTBh8wT0iNvs4kBI2IEgSSyZ+gA/XYkixg2yTMzHwzgkrWmymWjT+EcXhsHFJ4XMqWPxLBuqtYRyavdJnAeluBozoCKlwU08sgSHyh5mAQnbXy2nnpZ2vMV93aiNerbec2/EFkY92qdZ2uFBGxst+Fo5q1QEyD58=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724251141;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=HL5w15xGJTVkRRqNu8utX28aSRMGFxWi99Z7omzG7fc=;
	b=Dxd4LFQeDubpsgSrMS4QohAqmZ2sd9n4Y5m18fFlnEDGBwe8z7rhlyCtxApdGBHS
	+2wcdaaXI3KTrWLDQnvGZIOh5aJFUQ8IyetOljbfyJt0RacwEbwK+7vewE2V7XN/pGC
	kU37W9XugwF9r5B3VU6wg9G5+gF2b3pu+iIA5G7U=
Received: by mx.zohomail.com with SMTPS id 1724251139471361.4755537553998;
	Wed, 21 Aug 2024 07:38:59 -0700 (PDT)
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
Subject: [PATCH v2 RESEND 0/5] Panthor devcoredump support
Date: Wed, 21 Aug 2024 11:37:26 -0300
Message-ID: <20240821143826.3720-1-daniel.almeida@collabora.com>
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


Resending this because, among other things, the patches themselves did
not have dri-devel on cc.

------------------

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


