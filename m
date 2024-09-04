Return-Path: <linux-kernel+bounces-315341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9FF96C14A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D581F287CD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015541DC181;
	Wed,  4 Sep 2024 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uueR4Mz1"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61091CCEFC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461566; cv=none; b=bN28VFmxMBSZvJVsB8kRGnlA0D9tE5a7M/fiyv6GpXb9qluSa8iuM4lNaQ40qI7b5sKN+w2h94UNlCCoR5/CTvtah2HWM+8Pv0UcIBgsm5LrZnGo3Dk3+7Sk33loEGd7MheMLPAlFTXMcQaocboWQ/Sb6Yh7WCi+ASIL84hLJK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461566; c=relaxed/simple;
	bh=voyOYZWjEblOB0Gzb74raxPK2rOaJWiesmUXjO3gSkg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RLhl5t+LAn7JqKHD+dCjnKbvXor5L/6n+Xj/PEgZGGoU+lISiFLxhJP8s2kFDnpJJIj7NcKKx//ZPjL14ElcWamV3008qcNJd07UYrLEtpPWPv612uSeSSZLC1Nby6C1Cvzfl20Qs2Oz8mhzVMwfXWC9qp8gLnQny55/rjFWGHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uueR4Mz1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-36830a54b34so180244f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725461563; x=1726066363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MbOpSXNYVcQhcvwtIzrMQlGRTGRRC7rPZsCeaAArmmk=;
        b=uueR4Mz1EAuhchCywMREh9ObqwL84wQka+M91Dz+Z5l77L27X0MhrvHRwzoMleXUHf
         ESRleDBaHs2pdZXXT1v5twGoNq2d7bJp91kAyFGMdu6udaoY/sz4zxISHYHwvL1E1sWU
         SQRYXP2IpU+Z4jbKn5swCUBxNZkvwzG9s9sNipeARsf/i3LiDKBXYj0i5cp7DRWwlREw
         5UITDOxuiSvrAfdj3vLAxQMondxH/Lgu8jM4urGcHkRamcvHRqc/xHc0sq2JCaD121HA
         cqlEK1PmuJDE4h6ouDg4Ke45lziZCfDArPxWXT2vBUAiFkzLsLWA/ySDvWIwYremnnn0
         JbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725461563; x=1726066363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbOpSXNYVcQhcvwtIzrMQlGRTGRRC7rPZsCeaAArmmk=;
        b=T9PssrEwe2vppGjeoqFydBsL054U2Buw63/TZC+iH06+/1CEbHBejwyRXmA0YoLgUq
         w8lz9GLSlEFpTefQir8pU/XGzhYXM1RoJxeHEhRwzR3Tx8V8kCUI2H0S9FJxx/LREsSr
         uEfzO2yu+5U1NXFsImzZ5FknD1TGEN5IPfJu/KVZEcwgLLFt+UU+iMI2R1jsua00fyke
         5+hENzJY9BUA82fVhZou3UZd6UiPDHvMNty4PqPDNFXkHVLyuUW0XSCub7Q1aaGr2xzt
         qK3EOy1C3PXqu51vPb7l2Iv4Rf7uyL9skl/q2r0x0dnUdx8jcWiv03DjTQm5SckPWBS4
         hmVg==
X-Forwarded-Encrypted: i=1; AJvYcCXKkz4Gyg+oXoP7zi4SQFm7SwACcLxsC+8913IA5n6OBEl1uukn0IoZwRvKsj2Icv6mM0nK803eMTg+xY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHrNa7Z4nVzeDWYrGQERJ0A3fMXPDIMKOHWwl34elAbEMNZJNY
	QIYk0C4y0GoSCcqZ0nEkSacMblktxnPr3r2vfeWEzvB1RzeO64bH6u3DMnqFJRvdo8e0NeXUvGe
	J
X-Google-Smtp-Source: AGHT+IFigIDgeK0AYS1NHvcazhvwSBWTvpXPKjRSJmmszC2cebhtjsf44CObPbChB6ovhvnuWTp5LA==
X-Received: by 2002:a5d:64c8:0:b0:374:c800:dc3d with SMTP id ffacd0b85a97d-374c800df1amr4487507f8f.1.1725461562709;
        Wed, 04 Sep 2024 07:52:42 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c03595fcsm11963357f8f.98.2024.09.04.07.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 07:52:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] soundwire: stream: Revert "soundwire: stream: fix programming slave ports for non-continous port maps"
Date: Wed,  4 Sep 2024 16:52:28 +0200
Message-ID: <20240904145228.289891-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit ab8d66d132bc8f1992d3eb6cab8d32dda6733c84 because it
breaks codecs using non-continuous masks in source and sink ports.  The
commit missed the point that port numbers are not used as indices for
iterating over prop.sink_ports or prop.source_ports.

Soundwire core and existing codecs expect that the array passed as
prop.sink_ports and prop.source_ports is continuous.  The port mask still
might be non-continuous, but that's unrelated.

Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Closes: https://lore.kernel.org/all/b6c75eee-761d-44c8-8413-2a5b34ee2f98@linux.intel.com/
Fixes: ab8d66d132bc ("soundwire: stream: fix programming slave ports for non-continous port maps")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I will need to fix my codec drivers, but that's independent.
---
 drivers/soundwire/stream.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index f275143d7b18..7aa4900dcf31 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1291,18 +1291,18 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
 					    unsigned int port_num)
 {
 	struct sdw_dpn_prop *dpn_prop;
-	unsigned long mask;
+	u8 num_ports;
 	int i;
 
 	if (direction == SDW_DATA_DIR_TX) {
-		mask = slave->prop.source_ports;
+		num_ports = hweight32(slave->prop.source_ports);
 		dpn_prop = slave->prop.src_dpn_prop;
 	} else {
-		mask = slave->prop.sink_ports;
+		num_ports = hweight32(slave->prop.sink_ports);
 		dpn_prop = slave->prop.sink_dpn_prop;
 	}
 
-	for_each_set_bit(i, &mask, 32) {
+	for (i = 0; i < num_ports; i++) {
 		if (dpn_prop[i].num == port_num)
 			return &dpn_prop[i];
 	}
-- 
2.43.0


