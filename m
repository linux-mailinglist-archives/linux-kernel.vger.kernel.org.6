Return-Path: <linux-kernel+bounces-397696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3928A9BDF21
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44071F2454E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9412E1991C3;
	Wed,  6 Nov 2024 07:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xw3iMcwk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D4D192B61;
	Wed,  6 Nov 2024 07:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730876814; cv=none; b=Le6ydvNhhfrrId/Uhziqz2ZCmFY5IBofp+JBFGz++b0LKQmpzikwQD40MBpkyHYpoZk4U15ZxLJMMsiux0KtpAR6VbcOmCzPkxiw5sfVk3A+ZOWJcHcwcBPa2WNl5Qxbf2a6sF70E5QFEaGqFfBD3i9ljkgynge9+rmCm/WrZOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730876814; c=relaxed/simple;
	bh=7pdnXq7EufOCuoXoSdtjBZ4tbALPR7ZeEojqa8COUKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GrIiD53Dkchwl+yug9ebq1lg9bKwBsFxNL/VVxMjLQ5PNorWF3a6Uc6Xjx/R3c8JDlcefXbj7x1MwNB6uHAqw1AIOORo3WwztEqulSpiNI/isFWCQG2Js6fPkHCGGnLtGEL0HIzYoYPhRLYTKw9yRNZtrMb4KIAF+KSAU9ECO78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xw3iMcwk; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730876812; x=1762412812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7pdnXq7EufOCuoXoSdtjBZ4tbALPR7ZeEojqa8COUKA=;
  b=Xw3iMcwk0AG3zY2G4o2JsfE2ZORCsi8arLTMzQHEes7Aa6I1Tcgx6b47
   rCDQbS5MX28UCV0QLnd/wJYPWPAMBKGust7d4CvJGgM/VMBW3JNYV48eq
   LG95VhK+9g34Ic7JBOqQxXDGxj5PUJcdyp7IqnqzrBxcvC+atoD6jL+iX
   PFNew16l2kH8MPolusWJMfmxi6W6ay5osUB1QXxA5wRIuyek/pihc/DCT
   wv8M1yX17r5ei0gmot+4K3+NtGDt0r5LhIKaNLxNvUKYofdcvsnW6aGqw
   K8cUeSeW1TyrNRr/9aU+umQTnfqowy6L2jNfj4yVvi6ZukjvtH0nOCpTs
   w==;
X-CSE-ConnectionGUID: NS8JQO7JRmmBWWF0JJryqA==
X-CSE-MsgGUID: D6vmeZpbSx68Qe6Pfxx5kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="42057493"
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="42057493"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 23:06:51 -0800
X-CSE-ConnectionGUID: YncT/+raQ4+gvwOnOC8tkQ==
X-CSE-MsgGUID: W5BlBnEGSsu+L4VuWZ6yNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="89185156"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.56])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 23:06:49 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	amadeuszx.slawinski@linux.intel.com
Subject: [PATCH] ALSA: compress_offload: Remove unused runtime pointer from snd_compr_poll()
Date: Wed,  6 Nov 2024 09:06:46 +0200
Message-ID: <20241106070646.2599-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

runtime is not used as seen with W=1 :
sound/core/compress_offload.c: In function ‘snd_compr_poll’:
sound/core/compress_offload.c:409:35: error: variable ‘runtime’ set but not used [-Werror=unused-but-set-variable]
  409 |         struct snd_compr_runtime *runtime;
      |                                   ^~~~~~~

Fixes: 04177158cf98 ("ALSA: compress_offload: introduce accel operation mode")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/core/compress_offload.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 5ecdad80a0d8..c08afbd0155b 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -406,7 +406,6 @@ static __poll_t snd_compr_poll(struct file *f, poll_table *wait)
 {
 	struct snd_compr_file *data = f->private_data;
 	struct snd_compr_stream *stream;
-	struct snd_compr_runtime *runtime;
 	size_t avail;
 	__poll_t retval = 0;
 
@@ -414,8 +413,6 @@ static __poll_t snd_compr_poll(struct file *f, poll_table *wait)
 		return EPOLLERR;
 
 	stream = &data->stream;
-	runtime = stream->runtime;
-
 	guard(mutex)(&stream->device->lock);
 
 	switch (stream->runtime->state) {
-- 
2.47.0


