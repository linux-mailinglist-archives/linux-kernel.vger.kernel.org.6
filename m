Return-Path: <linux-kernel+bounces-239227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC29925832
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67757290531
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC55171080;
	Wed,  3 Jul 2024 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j4f7ZLkd"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378D016B3A1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001779; cv=none; b=g1UwAzZ+nGGbDTUy/41gxqRAtRJV/Bi+m8OS6shbWJpNVz4PpnxTU8fM9cyAJNBGcgfEkuKRk0kEknHP3KKF19U7AZ6kAgD5TU5iMZC9vii03xnc1RvxiVtBQExz2fcxu0hwzuCtImmmhy1RjBcSJ4IXYXWBE8E1z7g8EZAafGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001779; c=relaxed/simple;
	bh=6uKd3zEd6o2IBq3WPpQXHIDwXFMOpWhIbBFNpjD55Eg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l+eEtnBNGCa1ny2ue3SzdlsWl6NUGYaXGPi/DyeaeVoe7SSAnq6WNO09IhQYCBH42OyOYkgEOBnKkorsuXmT/QGf6llGAzQovBrCMCqITCdpfncqpHrNgk0XvQyZmO00fTZ5+Uj9uJcXbKiAp2H/kRzds+tKbfIT9fLdw/rDLrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j4f7ZLkd; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a72988749f0so771568066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720001776; x=1720606576; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RGXPX/CSKzMjftTA4WDyZ6uPyqorccsRYB38Y+ET/0=;
        b=j4f7ZLkdXfzT8fMPkoMgbHMYfkfqXKIwwKkmOwinDbkSNy2BuHl56bcUWch0N6eK2X
         PUeJX3YcgD9nKAphm4v51w/1WC9FZMRTAOgD/Ld4qHYvPLy9iR9ddl+V5V3UkqjURRv0
         c+Xy1TdBpbNcjA0/9U2WlJE35ct6AYIuzXBXOUHqPba6atlnEiDAAaNHsdJ/PcsVe/A0
         is0QHdMgaT4r6TiNPP03gAvn6Hl3gouYfq9NP1qwwZC84si8+msvwWtdU9envU7Bc8VF
         U+o3T5R5kxyAx5/4lFfqgdvVwETvwoDHCQyTP100+UEQ0mwn0VEHpFJmnhSu4X9vSw3s
         ArAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001776; x=1720606576;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RGXPX/CSKzMjftTA4WDyZ6uPyqorccsRYB38Y+ET/0=;
        b=vVumK0m2+n5HumN4MKKGBTuRnpVrvd3ivwzBK19g4dlfecdQgIPrIAyl6m+r42zwxP
         GDVIUq9LSIOLyUDN/Rt4k1iS+2ArZfBTEzPfsqj291H/WxS7YgSkgKpIUSlInvOTSgT9
         rjozeW8DTw4UesgdsPM8phg4aOGU7+Z3c7KZcHrK6UNu41gRGfZIFMn02GG5xROm4I9J
         LNQqxrogNHjSDB1vOQY3ztfAu6eUDNWiSGRbwdNldG+P1joPwj1SJEf8RC730PBlaNrw
         bWnjX10ikQJ8BYRNIOSih7DuAtQ31kF6G9c88CivaCE+vV4MGOmt5HQEMFIPZ3RwHOPT
         ixyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPTUXlgqG7FH/5nGViTCuaOGQftG8m4cpbVn1m0GyhkUim6zi7xvRmWusBxGzs601mqT+cseUpJKmP5aiYOidhoNZIeTg0UXGwaMVH
X-Gm-Message-State: AOJu0YycODSyV+CqAbsovwZcTxW1d5b07k+yr+cPXIP2Sq6ScIR++A5i
	DA/FqwBQmxrZvx4nS2inNh29RaDo4ttqIk9COKxwk9Y2HqIGaFf/nOY+A30WDC0=
X-Google-Smtp-Source: AGHT+IFpjC/UncuvZVsjweNMYxrJoEVZ09OWbbmaVadtytsY9DAfzhNDTF5hguxVUFge710PE/lfJg==
X-Received: by 2002:a17:906:ce28:b0:a72:7c0d:8fdc with SMTP id a640c23a62f3a-a75144631bemr673990966b.14.1720001776609;
        Wed, 03 Jul 2024 03:16:16 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab06565csm494291466b.103.2024.07.03.03.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:16:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Jul 2024 12:15:56 +0200
Subject: [PATCH 4/9] soundwire: intel: simplify return path in hw_params
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-soundwire-cleanup-h-v1-4-24fa0dbb948f@linaro.org>
References: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
In-Reply-To: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1567;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=6uKd3zEd6o2IBq3WPpQXHIDwXFMOpWhIbBFNpjD55Eg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmhSTku0e0ZPNzRqNV/p6R7MRgwqF6z2Drikr2X
 zBVT0McBfCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoUk5AAKCRDBN2bmhouD
 1xzpD/47ioCRH55FERGs7W33sRBsRuCldVHnisxShW4zIspBBmfU+Jfo+bH9fEXFga5oqS8E3G3
 0SOJ5ACjYR3l5UC7lYgFQBUrlLPCFehm1jIPrMcmMpMV5ub/0IPrKvGEirCejtdQ+9FazVcFd2Y
 oX46M4grsOcL06/LtLN9Fl2TMqs8k1B7k3kbLZZRXMLg2dmdxRqxWlMtTmPVh2l9Eo9PEhNPNdl
 2ASelRKxbmfAXpHEUC7cPANXn2JXKaxdLLZf64s13ln3DA1uKQ0YpYUbs27A+hu03UwAY4zjEF7
 tKCQEvedWmRFScBot2e3fBLIsuh7FfiTaT5niF4rmOpA14AutLhj3UFrTSl3Jl7oAKsR5JMU+Eg
 necUljx9SfZcYDYTKzjLntNsL17HBP1xFu1crn2l3iqmS43gg/Q72L2+dXP667INVwJOFPqgDHO
 2PGN3gEn5WOmdt1ZyJwPsB5vBxplg8D5Eml/TXB/7e2xzUC8RyEUy0SqA9UJIUVIRt7sv7FsQYU
 8MU0MYaU8coIKxU+U2lrITGfsqMXy+Gd2BrThJX3Wn1g6gDMgE/gR1VJV9duD8nhvJKPDHzKDV/
 5O0f+6QEa5+m0ColVNshZip7vZ+nsL3D5KoEXvNtneRpXGy/iy/Vi2CqQ3cxGO8KVAt5qsOvLsH
 ahjuM42P2e+E/zw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Remove unused error path (label+goto) to make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/intel.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 01e1a0f3ec39..b4449095b423 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -743,10 +743,8 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 
 	pdi = sdw_cdns_alloc_pdi(cdns, &cdns->pcm, ch, dir, dai->id);
 
-	if (!pdi) {
-		ret = -EINVAL;
-		goto error;
-	}
+	if (!pdi)
+		return -EINVAL;
 
 	/* do run-time configurations for SHIM, ALH and PDI/PORT */
 	intel_pdi_shim_configure(sdw, pdi);
@@ -763,7 +761,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 				  sdw->instance,
 				  pdi->intel_alh_id);
 	if (ret)
-		goto error;
+		return ret;
 
 	sconfig.direction = dir;
 	sconfig.ch_count = ch;
@@ -774,10 +772,8 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 
 	/* Port configuration */
 	pconfig = kzalloc(sizeof(*pconfig), GFP_KERNEL);
-	if (!pconfig) {
-		ret =  -ENOMEM;
-		goto error;
-	}
+	if (!pconfig)
+		return -ENOMEM;
 
 	pconfig->num = pdi->num;
 	pconfig->ch_mask = (1 << ch) - 1;
@@ -788,7 +784,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 		dev_err(cdns->dev, "add master to stream failed:%d\n", ret);
 
 	kfree(pconfig);
-error:
+
 	return ret;
 }
 

-- 
2.43.0


