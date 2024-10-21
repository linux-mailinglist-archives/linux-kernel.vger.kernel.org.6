Return-Path: <linux-kernel+bounces-374454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCC29A6A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B79E281CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2C11F8F15;
	Mon, 21 Oct 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YcIRcbq0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD281F4FC8;
	Mon, 21 Oct 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517835; cv=none; b=TBrHjaWQL+kSZXySm6S7lPlkAyn0lLUKKaxyFSotiXs4JtgrQRMAmu6DLaE9BlivSdtIl3wk0raO++Pjfht7E0wD8HyPPDGevAnEHTQo7gM300zuaAXy+IwCg4P4nMOrKvW0ey9C42v96zUx7bmNdVwrcDfshuzcROoKTkVAfC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517835; c=relaxed/simple;
	bh=oD+19+bWPRUo+nFEhiHZ++FpJIph8ImQWAJ19j4w9BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHzJslL/QtOOI7a5bxbK+QtVGlFXebafnVHu1iladj3ICE3GkQdwCvB4ZQtGg/6psFD6D7MEo8m3/5YlAb2Fbes70GyohGOtExSu8hIjkVOkTg92+V82Wwcc0z851fwKNQOROyD2C2uK+I4YLDl0hnEmeJD3aU6ZCuB68QEmqT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YcIRcbq0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729517834; x=1761053834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oD+19+bWPRUo+nFEhiHZ++FpJIph8ImQWAJ19j4w9BQ=;
  b=YcIRcbq0PGmQlUdFOIblUMeXttIOdqocvwTat9qI+vUcU/ivOUwEOF+G
   zTW7v9VfgXZiMzhUS45wZ7iXGo9I0bIbtAv6CfEaTAua2Rnbzr1th9tU4
   5uonESf8srqbYsI6GgCbicXcsUVX0HxwXrfWWZqcvhyIvNtPfF59HS7hC
   3dBEHktuQHZdCNJNMuBYFjr86RXjCDun58J/5OJnnXThZ36fsD/Qm0C/K
   eiHMRr2bhFAO02v6zzQB20cSrtEOy+XlRa9f+BU/Z+bgDGcjjm8Jz2Sq4
   m7/Jq8GleUzD8U4OPz4VQqOz1tP8e4q5HcxbYG/vg2oqnhUxFKYynYzBu
   Q==;
X-CSE-ConnectionGUID: dQwQriJhSKii1KtVC+HscA==
X-CSE-MsgGUID: INbHtcy6RlWLGss87lndNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="29119826"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="29119826"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 06:37:11 -0700
X-CSE-ConnectionGUID: Lu0rLax5QaubmbmGTfdY2A==
X-CSE-MsgGUID: wNM0YO3SRGmG7RStq6LZUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79931177"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 21 Oct 2024 06:37:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 42D2912B; Mon, 21 Oct 2024 16:37:07 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v3 1/5] platform/x86: intel_scu_ipc: Unify the flow in pwr_reg_rdwr()
Date: Mon, 21 Oct 2024 16:34:29 +0300
Message-ID: <20241021133705.2933464-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241021133705.2933464-1-andriy.shevchenko@linux.intel.com>
References: <20241021133705.2933464-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unify the flow in pwr_reg_rdwr() with intel_scu_ipc_dev_command_with_size().
While read buffer is not currently being used by the callers of
pwr_reg_rdwr(), this might change in the future. For the existing code
it's a harmless change because the read data for the write operation
is simply discarded.

Tested-by: Ferry Toth <fntoth@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 5b16d29c93d7..8d11d18701a4 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -325,7 +325,7 @@ static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
 	}
 
 	err = intel_scu_ipc_check_status(scu);
-	if (!err && id == IPC_CMD_PCNTRL_R) { /* Read rbuf */
+	if (!err) { /* Read rbuf */
 		/* Workaround: values are read as 0 without memcpy_fromio */
 		memcpy_fromio(cbuf, scu->ipc_base + 0x90, 16);
 		for (nc = 0; nc < count; nc++)
-- 
2.43.0.rc1.1336.g36b5255a03ac


