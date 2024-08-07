Return-Path: <linux-kernel+bounces-278237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385F994ADC2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CFF28200B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F2A137905;
	Wed,  7 Aug 2024 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b="SJ0dq38k"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5215412C473
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046993; cv=pass; b=uy+stJr+31PUB8eDYcf8QfVh5YBtl3Zth4fhT6nb0kD3F9BLH2Kjuf3iiMhCujbTUb0hL8S8tC5qVYFBxiXhWy9+Mxu+3rfgVd2zLpwVuLKd+HqleKtGUX2byXB8r89/33wNZinSvjr2nr3ZdNYHV2Eq21HLQGHamLPV1UpvlCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046993; c=relaxed/simple;
	bh=/wberoPk3vx+riIHmWzo7h+FgaoSPfLIdojV4pBUIiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eqFwkqXMmm/DPlltW17GZYXTq3IwgvtZeMZdrHXvC2n1MI8iwyCC0l24A7qX1kTgb2m51UdlfW+NKpkvlDOC+3dR9v31pEUXcZit0pOe9ixHq18jYMOWO+nYyBUjZ/2iHJFYfS283kMFEcHKM00NTWX2H1AUml/xv7ZqY8R00z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b=SJ0dq38k; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723046987; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SjcJDubq4V/yt5MaTZ7WRlyyozNJDzTYiwS1tD6Ax2dL987Ayq5nLFJwUoOLsbayrFuqsbzhJe8ujBPjRLL3XZiNiHo5nzLmJXjC6Kp+SA5qUp4udx+GXQhu/5jMp8APumXO+lXfPMWKgfFmpRdJN4LYdtUiIsXY419kistenqo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723046987; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yIsDSZDx97jmN9PU77YfYDi3e/PQPn6A1nrKDz9ozT0=; 
	b=i/wJlMU9wlKxmhUXEFajERgt8XXWgOtVC/3IJyeTvRdkGmVs1BrT4684ylUf0JU4fzuUWKoSk8rsCv2UoZOruSlPI/EZl4UT9d2YO6qocYZ4QDrV+AIRs7iKsVlSlSYd2S8928HTLmK63A/2EMxIB0blaWma1WjIXn1nx1q0cw0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=mary.guillemard@collabora.com;
	dmarc=pass header.from=<mary.guillemard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723046987;
	s=zohomail; d=collabora.com; i=mary.guillemard@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yIsDSZDx97jmN9PU77YfYDi3e/PQPn6A1nrKDz9ozT0=;
	b=SJ0dq38kExxZjaeLXUVxhQLlxKvAK1hvUl6GSk+wbDFId2pDTCHg+kk92tuXrPNc
	Ys8MtFV+bgaQ5tlOqnfn4MHM0m7pxL34gztbA6VeGDEfmDruqnL3T1X31cdPLjTgaNC
	L9TTAEmDzrH5MGb9HVZu7uN9G0I04Jaih+FQ70Xg=
Received: by mx.zohomail.com with SMTPS id 1723046986917194.02206961208128;
	Wed, 7 Aug 2024 09:09:46 -0700 (PDT)
From: Mary Guillemard <mary.guillemard@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	kernel@collabora.com,
	Mary Guillemard <mary.guillemard@collabora.com>
Subject: [PATCH 0/3] drm/panfrost: Wire cycle counters and timestamp info to userspace
Date: Wed,  7 Aug 2024 18:08:56 +0200
Message-ID: <20240807160900.149154-1-mary.guillemard@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Mali has hardware cycle counters and GPU timestamps available for
profiling.

This patch series adds support for cycle counters propagation and
also new timestamp info parameters.

Those new changes to the uAPI will be used in Mesa to implement
timestamp queries for OpenGL and Vulkan.

Mary Guillemard (3):
  drm/panfrost: Add SYSTEM_TIMESTAMP and SYSTEM_TIMESTAMP_FREQUENCY
    parameters
  drm/panfrost: Add cycle counter job requirement
  drm/panfrost: Handle JD_REQ_CYCLE_COUNT

 drivers/gpu/drm/panfrost/panfrost_drv.c | 25 +++++++++++++++++++++++--
 drivers/gpu/drm/panfrost/panfrost_job.c | 10 ++++++++++
 include/uapi/drm/panfrost_drm.h         |  3 +++
 3 files changed, 36 insertions(+), 2 deletions(-)


base-commit: f7f3ddb6e5c8dc7b621fd8c0903ea42190d67452
-- 
2.45.2


