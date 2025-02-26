Return-Path: <linux-kernel+bounces-534671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CDAA469C9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1008A7A45BA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77BE22A4E2;
	Wed, 26 Feb 2025 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="RVNkjYjx"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC9522332B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594672; cv=pass; b=Ir3+Kz0ZeqQ5riEXEdIVQIbR/D3xaiEZSG31guZalG02QSsyJ9a4Pn/6JR+cfX6UFGZO3eLAo6DKeyQ+izCwigiLisvKbA+Nt81TVVxnXMgSwsqn9M+FQpEoR2OS1kjFc5AQUCHuAPgze81GvuQMgaSCYPI2qdJQ1/BZNBK+0S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594672; c=relaxed/simple;
	bh=1JZflQNZrncVL8YgWJhjqQJ1/DYLL7pKTWmTS83fJLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ag9QjIzLSyZ+24nxkjjWQIf2vqTsP4syuonL6j+D9RtkyR7fysTrSmdddPvaMJf4228pJAstLclNBJTrVVV/CYaSmz/I3ARL8fYl1hwVdI/oK0tjOZqD5Md1WYXW0Hu2wtI0WHLnzUyRxHhcNTP2YPTj9wam/Y/ud/dwgPiT5HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=RVNkjYjx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740594653; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PrsOkTAFcwIU6IFxSVRJn0RSe7CA646ZyjzBGP1z/smgj0sCIsB1qEInB4o0vZi5kdmP5EcuX4VktWgIWRSaKMkKFnsW+9s5s3T6yaRDyLxQncVgPIOsGjDu8Lk3XEHMioCw10O1WaqumaXC2jBtQ+zSanyDKdOKJNP0MIMi198=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740594653; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=so5Ya2sNVzVdPATWv72yqrbwqb2T7dEICsjtp1FE3Ao=; 
	b=RyfScPZAyl0cLhkmX1a7T1i+C23INECA3j83ke5KgWeL27OGkcaAxixs2HmcjWVbwQ0ot8Sm6GE97kPLvn1E25/PXWGf9ZOUxGK6nfeQN6DEckAfp1kCzn+iw1UwJRlf7VordwOR2LJF5gfY7LwxIs5bo9KSqgxTvBDQsujXbfM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740594653;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=so5Ya2sNVzVdPATWv72yqrbwqb2T7dEICsjtp1FE3Ao=;
	b=RVNkjYjx0Z9MkF/tTe5Jrq6xfJ/GgtE3d4LW1Sop47qRyRU4X6uaYwyMyvtL6ncY
	ZpHacDaXWzUnXYkr48rbaYwfK46i16JqK5vP4i0lbFZkviJl+C5qnFOBkfztiFh53XM
	T86Fe0/ggPzjzxR9JhdkclkfZd7XwV9dKWI7qEFU=
Received: by mx.zohomail.com with SMTPS id 1740594650931636.5193849645846;
	Wed, 26 Feb 2025 10:30:50 -0800 (PST)
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com,
	robh@kernel.org,
	steven.price@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: [RFC PATCH 0/4] drm/panfrost: Support ARM_64_LPAE_S1 page table
Date: Wed, 26 Feb 2025 15:30:39 -0300
Message-ID: <20250226183043.140773-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi all,

This is a RFC related to AArch64 page table format support in panfrost.
Currently, only MMU in legacy mode is supported, but Bifrost GPUs use
the standard format LPAE S1 page tables.

There's a previous similar thread on this topic from 2019-May [0], which
got stalled. This RFC is an attemp to bring this discussion back in
order to properly support this mode.

So far, this patchset has been tested on a Mediatek Genio 700 EVK
(MT8390) board, with an integrated Mali-G57 MC3 GPU using
`glmark2-es2-drm` OpenGL 2.0 benchmark tests.

However, Mesa CI dEQP tests for GLES2, GLES3+ and EGL already reported
possible regressions on this patchset, still under investigation.

Due to the possible impact of this patchset, exhaustive testing should
be done before merging, but in any case, let's start kicking this thread
for discussion.

Any comments, feedback is welcome :)

[0] https://lists.freedesktop.org/archives/dri-devel/2019-May/217617.html

Thanks!

Ariel D'Alessandro (4):
  drm/panfrost: Use GPU_MMU_FEATURES_VA_BITS/PA_BITS macros
  drm/panfrost: Split LPAE MMU TRANSTAB register values
  drm/panfrost: Support ARM_64_LPAE_S1 page table
  drm/panfrost: Set HW_FEATURE_AARCH64_MMU feature flag on Bifrost
    models

 drivers/gpu/drm/panfrost/panfrost_device.h   |   1 +
 drivers/gpu/drm/panfrost/panfrost_features.h |   3 +
 drivers/gpu/drm/panfrost/panfrost_mmu.c      | 124 +++++++++++++++----
 drivers/gpu/drm/panfrost/panfrost_regs.h     |  50 ++++++--
 4 files changed, 149 insertions(+), 29 deletions(-)

-- 
2.47.2


