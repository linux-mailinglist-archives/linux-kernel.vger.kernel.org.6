Return-Path: <linux-kernel+bounces-522530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43537A3CB8C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E155417741E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C842580CE;
	Wed, 19 Feb 2025 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="U64rNfDn"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508431F91C7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000939; cv=none; b=jztvNX1rAfnFII9rKRmMDxvdh4LQhdIBEdVGPz6LkaUHZhF3sHcu7jIhZnKgoZed620fCK4VmN8AMLzHOao6saKmMSS8eLAgtmbXjt7MULHvqarsh5alvOrPDQIgTabrnlv7tv5NNJTp2nD3UcswhtW87RFDXPg/Lm2zI0wQWtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000939; c=relaxed/simple;
	bh=Jx4Xl6QMgXYxph2/oz2iMRVmBmu3FFnI/dL1iLUC5ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jIf7ok/BW+AwCwZHwwzIYA1PfrjJaYT94S8I6GCtQG43hwEYCtpoItLEvzm1ldazZij2FNnWrB9H3wdUBhT8wVLR29cQp+Ffe/OnLlXVIAZzF8X4H2xBXLNGSW+na6XL3eo3yWeOp1ZpH8GThmJmh5qIlxD1D44KgqvJEZppwsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=U64rNfDn; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jFbysj/kIakJJpsBhVzm0lzhdukBPqOgudq9jwi4AQA=; b=U64rNfDnyyZ+BnFjQdkFPvHEV3
	As0d9KYr+SI/IvRWMCW0DMvqD3wnUHiNPVf21JKYZIgjAIONznBrPyaeXSVlQCputB7yO3NNI6kLH
	2AQ5RG6ETjQ8zdarAyf/cZugSL/q4GLPOp/ccmpUHWLVOlGhx7eDrujE/7SzSSOpyAUAyN5Vs3+WX
	knd+hrtyUceIN4ZfwTUCwRJOQREwsLGKB4B9xwxwSqzlwWxJPcMaWyZul8Ln4DCpZJ9MPVRtyHmXl
	JQwLwp/25KZcPDJiMyVg/Tmk1C5hjw8jZV2fPmI5Rz8MMiy4Ku5RcKIPcm6hV0FjUp4ViZUZ+hW10
	Rv5DdE1g==;
Received: from [191.204.194.148] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tkrj1-00F1SN-0L; Wed, 19 Feb 2025 22:35:29 +0100
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
Subject: [PATCH 0/3] drm/amdgpu: Small reset improvements
Date: Wed, 19 Feb 2025 18:35:14 -0300
Message-ID: <20250219213517.281556-1-andrealmeid@igalia.com>
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

André Almeida (3):
  drm/amdgpu: Log the creation of a coredump file
  drm/amdgpu: Log after a successful ring reset
  drm/amdgpu: Trigger a wedged event for every type of reset

 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c    |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c      |  3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c         | 17 ++++++++++-------
 3 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.48.1


