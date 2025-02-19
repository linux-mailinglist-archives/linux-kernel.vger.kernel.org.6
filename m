Return-Path: <linux-kernel+bounces-522254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463F2A3C7DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24716176CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA73214A7F;
	Wed, 19 Feb 2025 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lPdPzJqW"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88FA21481A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990853; cv=none; b=mqYW2X3Sb3pC9AjYYfF/ZWjpYBgJZuZIPmddVFlmLJaluv2DkHttZ2Yuv5XyqR/OvxwJnG77Da/mAPhZx9XNg+YQwgDJKOXtqi6mUs2r5C0kkY9tSi4mUXLUiPwbEs14zJHGXVNXfT/fBZuyg9UjuhIN2i4XWkQyhgUc85Y6PIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990853; c=relaxed/simple;
	bh=fozhqE9akH7er2I4jciWAzDTwepAkfAZs2iN9t2Op/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d7Xq1EJYh8IlPpKC9nN0M4RfnuEfqKdnnfGThjVtj6u1Sp4RKOZZj3qOOjaGnjL87Qrgw8T5H0/EyY7gvxoOBuxwo4id7FdVz0VxHTYozbCR+mO2E7UM2L4NDwFkeurC3z0Yl2l7zgOEwoY1aVSIoRU/uqnqEuYxEI4tOiueDyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lPdPzJqW; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=akHLByESjhAZIdirUO+hq68gdgMh4KX2vVVmGox+LUA=; b=lPdPzJqWh9ItaRTXq608inXMoI
	/qML2dL16PX7Q9qIr5hMjpVDKmdyHjoKhA+xJMCcR+xvNlDG68IHHS0zmU0Akp5q8CqUTVeIRN/VV
	H2b5KEBjni7cQQpluquYCgn3Wg4Zp4urVz2EepDu0XsL/kSSnkg82+gja6603wcwXuWAIeW97YzkA
	x5HCTUjbiibPBRhwkFVdlQMkjuR8Rs818dHCBkDCGGh8YoZ99dFTv0my7cXFmDuMmOB7WdyO0werJ
	P+5Ulu/dKy4m1X2++XQfh3Z+srGzzXoeC6cMr0OIDcaPzcJZ4idfEC2UERixtw0MxTzAO6WM3GHxS
	ib1cKO/A==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14] helo=maloca.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tkp6M-00EwF0-DV; Wed, 19 Feb 2025 19:47:24 +0100
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 0/2] Add myself as a Reviewer of AMD display and update mailmap
Date: Wed, 19 Feb 2025 11:46:18 -0700
Message-ID: <20250219184702.242924-1-siqueira@igalia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset changes my status from a Maintainer of the display code to
a reviewer, and it also adds an entry to my name in the mailmap file.

Thanks
Siqueira

Rodrigo Siqueira (2):
  MAINTAINERS: Change my role from Maintainer to Reviewer
  mailmap: Add entry for Rodrigo Siqueira

 .mailmap    | 2 ++
 MAINTAINERS | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.48.1


