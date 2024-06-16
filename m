Return-Path: <linux-kernel+bounces-216079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D760F909B18
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 03:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35819B214D9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 01:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922251552E8;
	Sun, 16 Jun 2024 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IpwdFEWc"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E674154C0E
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 01:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718501139; cv=none; b=mhGr7iIBSAP7CaVZH0Xgxl/yeYcB143dO2W6D6KVMbfTKyjkgyB32zLlfzbDyWuih/qFzyDWplhaKvdU2h46GU/++XYva41qgl2BsYfJb7U4t6RHTYHhSZKljsLPD9KcNZcIQB/gXAjOf3AiINEhdlLo+R/qGcJwtrZO/M1bjJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718501139; c=relaxed/simple;
	bh=JHe8PmT8CAiOYlGo1cndu3zZ4OloPw3FeLHc2NnF29Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lxw55NrOMWvaJT3eNQXVYnDDhlEy5B8HPQ0uv7Hhtr5BNZGGjesprM79QZsswpOu88+FeOz+SwKO1BH+fnfdmETE3I5xmatitpZB6u/zieDCs0Xq60sIV+wDe0EgBeRYNy2Em/96t/eW82S9ue1y5nuO2+kMY2F7KwfjCUsszok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IpwdFEWc; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-796df041d73so236102885a.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 18:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718501137; x=1719105937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmh7B10VjitCXi5UnMX7IBHWWNFhALchrxl9IDbnSME=;
        b=IpwdFEWcmhtqCuDAJySqs0o61HabJmdtHdIP50TwjkjLmvdg2V4I1TWgElm/9QCJjV
         gdiAQSnwlz3g0y5dlFUctsolxw+Dz2G2zVTD5j5urms5iBosxPc9EY4lWFvp/u2tqBXh
         E38I51S1z2ZsMmy73JSNUjBJh95HDvZ2iyvbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718501137; x=1719105937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmh7B10VjitCXi5UnMX7IBHWWNFhALchrxl9IDbnSME=;
        b=AsrBWd7Mx1OuFbndYb0bw1S/t+2mwGp8dqO3ixg7YXB7k7aPEifAeC0gu8mg7FRqJg
         ylTtBT4wTjiSw+uQgughpI+S2/Zh3XflP2zhwVGV7ILMUzmt1T5Gkwir9h8HPwDCoqkP
         b9wXATDl0qIwcZMTN/Di5DkOkZ2rKIhhLxWaFLTOGkddoAg4V5orgMl+2RlkH1L92JDU
         Q4oSvy74WgChfaGFoDNo4fYzderHbyo3iGOf3pQOdRH0b1+9AMP8yzdLEESPZlz/M2/9
         4CwgwJIbO2y6CEUEKYZkxGSpz0kFkYBWFRRWnyKZBR1az21asDmtHcQ4qU5sg4lvIPaF
         xeHw==
X-Gm-Message-State: AOJu0YwNZN5aR8EeUbnRZuPcYuLMf/naQk4nx8DcofkNu3up2ue7J75i
	FWUwJHpVg1Ntv2nka3pN3gr5OiVDM2Oq9G7weP2oI8hI7f9KtNnm/GvlJatTGn4eyVXgwrQ0AU7
	JpQw2FGnU+6yTVJcbqSPRnbX/Q5FNK4wFl2HARHbwNuJi+5vD/wjXQ+QwUXg3sIGEPexqZZ/oc8
	hamZer/bOQr4uVQfszN8rn7I4XrtyrXw5nqgbtgLc7HA0pglre+wIM
X-Google-Smtp-Source: AGHT+IF3o2n1vuAWzivHA2bQV4+Plh7YsZ6B36O+Td3GL1zNvsydHY+4muaeP2QpJFgYTbtdwi7YNA==
X-Received: by 2002:a05:622a:130a:b0:43a:b542:d1dd with SMTP id d75a77b69052e-44216af8850mr64153021cf.36.1718501136510;
        Sat, 15 Jun 2024 18:25:36 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f310dae0sm32256121cf.97.2024.06.15.18.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 18:25:35 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	bp@alien8.de,
	bcm-kernel-feedback-list@broadcom.com,
	lkp@intel.com
Cc: zack.rusin@broadcom.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	linux-iio@vger.kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	nuno.sa@analog.com,
	dragos.bogdan@analog.com,
	anshulusr@gmail.com,
	andrea.collamati@gmail.com,
	oe-kbuild-all@lists.linux.dev,
	x86@kernel.org,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH 1/2] drm/vmwgfx: Fix missing HYPERVISOR_GUEST dependency
Date: Sat, 15 Jun 2024 18:25:10 -0700
Message-Id: <20240616012511.198243-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <202406152104.FxakP1MB-lkp@intel.com>
References: <202406152104.FxakP1MB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMWARE_HYPERCALL alternative will not work as intended without
VMware guest code initialization.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406152104.FxakP1MB-lkp@intel.com/
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/Kconfig b/drivers/gpu/drm/vmwgfx/Kconfig
index faddae3d6ac2..6f1ac940cbae 100644
--- a/drivers/gpu/drm/vmwgfx/Kconfig
+++ b/drivers/gpu/drm/vmwgfx/Kconfig
@@ -2,7 +2,7 @@
 config DRM_VMWGFX
 	tristate "DRM driver for VMware Virtual GPU"
 	depends on DRM && PCI && MMU
-	depends on X86 || ARM64
+	depends on (X86 && HYPERVISOR_GUEST) || ARM64
 	select DRM_TTM
 	select DRM_TTM_HELPER
 	select MAPPING_DIRTY_HELPERS
-- 
2.39.4


