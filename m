Return-Path: <linux-kernel+bounces-227826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B549156E6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641081C22060
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A936419EEDC;
	Mon, 24 Jun 2024 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hQ6wXJH3"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E004503C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255986; cv=none; b=d5Lk0LD/4vYZ+JCS+qgyII1ElTVOTDfzIAIMrnvrD96liebHhfWuTADXF6LEmQl/BQi4n8dUlosWFLSJMdPU7x4wYtsLWiSv21vtawNgmHdPXAxdFJz84yb7QB4FgFaaoV3GTQuwlVFH3Cp5okfV6l2Yk4MWKlq0wXnAuJRb6JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255986; c=relaxed/simple;
	bh=1dLFH1BN3fCMPMV4hZ8XzTSy79RRF8rKOFlO83dhJ70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZF1YsxHn2MW3aYaAqZciVPb18RfR/EKJknyiUPHcKoh6w/7H+UAVu3El/0fSOGfiXypKHUZ7UHfLcK9qKxPyqDA55d7VsDa1icH6u6lMU2ib+h//phclg9PT5A7cRws1T47G4U8xp1GFwTsXIWqxjN3iGDgx37OXgJ19RCFIEbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hQ6wXJH3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4230366ad7bso51732855e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719255982; x=1719860782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jtibGmNRXCXDZFzGLSqXKj8dY1qUNsegYw3njVNk31c=;
        b=hQ6wXJH3aB5twnsjaO1MXFppybEYqv2tu/vaQqYxfFrEEHDGBqk0x7jztf2QjFFzXO
         Ba/CAm6CVVNZsyZ5XRvpYO99y+fW0OqbpETCHox3pI3RTTMYRJ9VJCdtYLN0AwA0A16g
         wxRt2mqpzQmV8ZOYhMufhbT4592F/xlLnwO8Rovk/Z33BOnIeFD5MzTaHVoGl8u9Y0CT
         XRURe5ZM315qZu90B9+MUrQlh4ybTgoSP/NEl5esA8EceiOcVDzyyr+aJvv90nz/UEpc
         wje2r6+qlpWP+MnJEPyBhI0o/5cnmY14R2XBUuz33TPUpl5pyWuucVmJl7/PB3E8CJgF
         HIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719255982; x=1719860782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtibGmNRXCXDZFzGLSqXKj8dY1qUNsegYw3njVNk31c=;
        b=a0d3Ke26WoNXtAwqZe6IVrdtJ1uFtIl8XMiMZI4it8OmVTEqsQtvE/z/TbtOnopyXt
         75hVpREkgKIu5P6Z8NqYsZ8qiqoiYTHgGJMDxY/pYlmE0h+0/F8/mrkMujoi2pFDWZHK
         fLTpGWf+/yAKzgGm5iOHJUwa9Y7rgdZNC2Qg0qIY555lW7fquYOEGd2J3rZAEanEukYH
         quNCn+ULrha0BMLZF1wiDGLPUrNB4ZY1yTuqgeu8+cPFR0Q8cUAGXqXI14FZ+ecAfOy2
         vJZG/sqKI6mJan5+ckFjd427G454j3BhdThHQq0BgH2zc4pR7kBd+f+mxiaVa2mls54J
         ZUYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3qYF3j6+F8J5X92f9UFZJ6e/qc0iVV5c9pylSM+bsTCH9kmdNXOBGaLDKSWWuYvz6VleN0gwXYNT8CZ0CFQZGHwtS2FOzYZfbXI0G
X-Gm-Message-State: AOJu0YyeHuE1DVUzyfeW3XfuWKQdChK//H198qA6wi44QO/X9GQHl1Eh
	18533ca5qwzPEg/+vqHejMQ5QqDNZwf2l3i/USRhfrr2qQKX1iPpyMFRicv05rU=
X-Google-Smtp-Source: AGHT+IFLpYq7oL+k6nqRubCfnJ1jZVdzNTvXaNtfeVafAGEmCMonKcUlI3do5gX5sPMGu+O0/embTw==
X-Received: by 2002:a05:600c:42c7:b0:422:902b:73bc with SMTP id 5b1f17b1804b1-4248cc27201mr49942765e9.13.1719255982146;
        Mon, 24 Jun 2024 12:06:22 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b80e:a46a:7fb3:4e3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f667dsm10770383f8f.16.2024.06.24.12.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:06:21 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Elliot Berman <quic_eberman@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] firmware: qcom: tzmem: export devm_qcom_tzmem_pool_new()
Date: Mon, 24 Jun 2024 21:06:14 +0200
Message-ID: <20240624190615.36282-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

EXPORT_SYMBOL_GPL() is missing for devm_qcom_tzmem_pool_new() which
causes build failures with randconfig. Add it and fix the issue.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406250127.8Pl2kqFp-lkp@intel.com
Fixes: 84f5a7b67b61 ("firmware: qcom: add a dedicated TrustZone buffer allocator")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_tzmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
index aab6376cade5..5d526753183d 100644
--- a/drivers/firmware/qcom/qcom_tzmem.c
+++ b/drivers/firmware/qcom/qcom_tzmem.c
@@ -324,6 +324,7 @@ devm_qcom_tzmem_pool_new(struct device *dev,
 
 	return pool;
 }
+EXPORT_SYMBOL_GPL(devm_qcom_tzmem_pool_new);
 
 static bool qcom_tzmem_try_grow_pool(struct qcom_tzmem_pool *pool,
 				     size_t requested, gfp_t gfp)
-- 
2.43.0


