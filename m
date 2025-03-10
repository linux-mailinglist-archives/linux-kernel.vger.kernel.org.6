Return-Path: <linux-kernel+bounces-554972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F809A5A402
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D04B1892C51
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DB81DDA17;
	Mon, 10 Mar 2025 19:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bOXb2S3S"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCB4158535
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635987; cv=none; b=cctAO6dqYYQrca06In2b87a8xsac0xbuXrevXdXPJhDybkgyfOcGM5ieSOyC2NdxOYx6RKlyVEz2sZNmpKb/mFVpA44JouUcIv8y4U7dkP5XS5T/NwSkQZlv9dVacVAmlYXRiYnBPBLke1k7QL87/5wmdMoqgpcpwBjzSVvKK/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635987; c=relaxed/simple;
	bh=yPtT1URqHYreEI5ndrCPZSwQGTTEBPuFfvMnUG3ZU+U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AOJt2cbBsQcg5hFKTN8MFdFs/bIWpMKLRYHM1VZmm9LporXsCASz47ZuB4hGjMGekUNRpN6nqqQTn5A1y2q3krGgKNIQb3enb3CYtLK5liISNUP8Od82Z61zZf+Z5wBjHzEFH087rRR+0UJ7wwWlimIeyY4bhDeQidVqJTDa8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bOXb2S3S; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso2312828f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741635983; x=1742240783; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IvLfn3qhWG0LPJSKPMLdwGHyzm3ZQnbWN9kL2fMh4Mw=;
        b=bOXb2S3SDxRCZR5epXmTDOriYQ2VjsOfjNJGx984+FMp6W8h5nh+TKDpS5g7SAO6+M
         RByqwmm0F4r95T2ajtEt+9v4TRmDxHRtGxlpZln9Opg+J8FdDqIeN7bmDCFD50fnD6ZW
         rVzpx9OJrWarbGRpE9j9GwucNMgMnSWSzalz5WIC+41iIXo4V/ksDO14GZL+RW44crk+
         atYJi3nKRXDmD90yW6UqNLv3q6EI/ovdrPcf2pJcIliABn1dWr4hbHl4S5SmKacwAbON
         VtDeTzqxAcC2CqGxSJyoo7sWoAltCy63r9iD6neef3L7SwlQ+OcqBkSdzcK98ZXGKLaG
         RBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741635983; x=1742240783;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvLfn3qhWG0LPJSKPMLdwGHyzm3ZQnbWN9kL2fMh4Mw=;
        b=RmDomQt0ghdeeQQGuXCtjKZSoOcqLRm2+lkxLsos26aiPFIGH9jEPv/xAfbd7MhBTh
         FVUX3aiRxJXdbC/jurqJhGx3unsRoJm0VYig9uCV9Q5TI8FHFMCkOU+G4YVb7h5byJTW
         FaU81w6aXSA+gXdUPvDMPzkPKJPeyZT09Sl7cIjxEgc43ziGnGVuu+j6ANnEXKYEXdLI
         A2DD6s8XNjMRakvfBUSmClrHehyoeEp/3B2wQPFZsv3fzMqfr+pdRXBZJ0BksMIeuw9S
         y3vATMCpMy/dzTsTJgxcUplvz1mXS/ChS18rhEmdpuUnMao13qOAhUWHrkXfsNWKOJFm
         pqCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYgrKGFNMBv0AEllAnMDBoI/qrCyvfobsJ4lgiSi4VkipY2us8hWJJIjw7STJf+V1SLPNDfEbcgV+wVec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxALWsoMXPa0okWuBg/PG5IU17vpJV0SLkRK2+c9DM7BQpF7JR
	6qb6GETs13P03dNAfJtFhU8buDZaJOobCsymnxEyakgDYHHRfcKdnm9SusTSvtA=
X-Gm-Gg: ASbGnct82SCrfSnfUJvmHtnFXYBZUc4YzVq2TnBlSI2/c4gB7vhPX6b1SbSfCGQs016
	t2bklafpXk4c/JYL1XrxjQbUrR6c2GqURuwzaIiKLPLEb3Tk3EKJ9QwraKGAO01aZxpv5C7Gfnj
	XEDpexDFkVVmGrjrkgAzz4VT2QUpQS/nMddafXHE2gS5ei8Rsc2oENtdCPHBWMJOeQBM9axSUqJ
	p5igWbjZt2AHsulJD4uaDaPdB3Z4yhzDPi0g0vJzyHe7vHej6sCLXy+RGfDg5+mgRm4/m9jnPge
	VuzLw5XUkZwp8JCGxMiYjcAvXia72IFMvQq6bmcsgxSPqRCFyw==
X-Google-Smtp-Source: AGHT+IEd/pl739SBNrD6h1Towv44982Wiak2l2/J5QTRayAEyqBes8blAzLgBmUO87jKdAG+98SPfw==
X-Received: by 2002:a5d:64e4:0:b0:391:865:5a93 with SMTP id ffacd0b85a97d-3926d123ba9mr995249f8f.22.1741635983490;
        Mon, 10 Mar 2025 12:46:23 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c0e3250sm15993154f8f.61.2025.03.10.12.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 12:46:23 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:46:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	John Harrison <John.C.Harrison@intel.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/i915/gsc: delete a stray tab in
 intel_gsc_fw_get_binary_info()
Message-ID: <6152e1ac-745d-4b38-ba49-f013e6760936@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This line is indented on tab too far.  Delete the extra tab.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c b/drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c
index 5dc0ccd07636..d550eb6edfb8 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c
@@ -230,7 +230,7 @@ int intel_gsc_fw_get_binary_info(struct intel_uc_fw *gsc_fw, const void *data, s
 		gt_info(gt, "Invalid GSC firmware for MTL/ARL, got %d.%d.%d.%d but need 102.x.x.x",
 			gsc->release.major, gsc->release.minor,
 			gsc->release.patch, gsc->release.build);
-			return -EINVAL;
+		return -EINVAL;
 	}
 
 	if (min_ver.major) {
-- 
2.47.2


