Return-Path: <linux-kernel+bounces-543184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E500CA4D291
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D38F188C536
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 04:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F531D7E4A;
	Tue,  4 Mar 2025 04:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6tmvLRO"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD608837
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 04:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741062406; cv=none; b=pWEVHP4Gq3DM0nxb/oHTWN7AlbpAz82HqLzPucpL5tDe98SMZE94iEAiOOICYBWh14R09oc8ae4mq3s+eNCWL5TFmDIjaxQWLIPru8HqCSNEQIXUm9yELT7rxu6DSqWsy6WgeiLjTvELWpxJvy9vzNkF9TvuI8K8ABGObS45nuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741062406; c=relaxed/simple;
	bh=3M8lCkIbd0vp9anCIl5Ke1syINZVFTIOSmiG/Ct1QXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N4ETsHKV69VUmSI0yXXJfFysoE5yieilPwwxK+vtoMi8HeH2kOYE7CXki2awOqhqJ+5ryPzBlcLKgwObHJZZWi8n55gksNQOFMIBC4BGo/7Z7awJfttpPnQFVZF5cBmDPih8hDGrr1aH56J5TGyLXlRBN8l6a92WjYD4eDzMV+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6tmvLRO; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3910f525165so1154840f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 20:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741062403; x=1741667203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYysfUoaHnSD8dBiZzut53a8nZV60l3gC+2HnKebsJM=;
        b=h6tmvLROBIti68leYIMsYO/MBU5qZuTIP12DBeV6Y/D2B7L/235XdPDfUMOyR+hfvI
         LWVSLEf7jT+m5nPglQ62ZpLFk1zn4yoDVy9JzEA+UMJ9Ri1peQd4lkzHrRQLOSpW/YyL
         JhqanlyaI8eNJi2ZTGc+IIV+rUqlhI0TYHIm3Fe7y2qEVrF8zsFcUjDnDl+IQH0BCfa9
         +kcx+ZUhG+8I4/XGTPbEVWxySEXVSCS+LuuEXPFD/cMYeMMOeRAyz3yXfXpRmqVlRRB0
         xNymoiG9hoPr/wCcTBz5w7/Hx5YK3dy/wiAspbLrgAWU7N+cfv62B9th5jbJqhOShCp3
         t7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741062403; x=1741667203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYysfUoaHnSD8dBiZzut53a8nZV60l3gC+2HnKebsJM=;
        b=UdjwsyDUrpZoKWMtYJ+vj6GIxcgxSN1TufK4DAKjFexfBm+r9fhJ6foB8IJHg708F1
         BqZQMuo5jrjoks7p1NYkp8EpfmQu2E+e0aEGRKi8S0bn8p3lo58L8WXf+DNrD0neRMUh
         KJ0lKmJPvcw2evZNNJT6Mc82uraMCbTJ2bTfFtxJsaAUXlPq4kfBF7bgMD5gLC+8Qf+l
         sxlOHQuMl48j8aljzjJN9VVyt75SKbt92K35RH6Jna/HMZFDy3yBC6T2cUZZI1fa7yiC
         gv6iJKVqW7+3o51tlFQRxIwa5f5j2ihW7Qvz3TzcUOFkftb1sieCZr/mgULKpm7S/Rv4
         OJEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy5OX3sBiIMExJML0cLhDNOi+3VgT6sDzqpfwv0OXlGhgYlVXuwtmk/hCdb7e5m0AUY8mAV1RnbHcGHzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwemChdCcByEbOHLJ9f+X0WixoJ8cjnXB6IDqbjOUeyXyzZBHAJ
	7P1l3RZvfToQT2ZcoHNtPOO1fG95XMKGolv9UMHNK3aCTnLIB5LsbB4g/M4shAk=
X-Gm-Gg: ASbGncvzFYwFTAwraasn5573t0pUqHkTEhLSUzz4gJG9LqAtexluW01j0G6+TqxkS3W
	xzkR8PLGUonH9t0Zzy0cuQ3Lejbu6sRNs3UYgAD4rSIqjZYrFKxZBWWDCNn6s2WjidzknKbfAZA
	YPZeMPm2wQGQJFPHF5ilvI/o984B1KH02/wGzmo3WdgvAQ2Jpk9wChfZZUY0ue4A103DCH8U/ce
	by/0RIzJ2nf95EHg5DREB2nG7YhKU/H5aK7s7fVA/wc2vnqhptu1SDA3OnJ2J6fkSxZmQXKU6mL
	Fz/o1AjaqJjV0m7PXuo0EnJ0fL7s4ccn2aMGJnTUNOYd2e7X9uqJEHrgQcpoBrCc1Is4qW3BF+0
	L8mA=
X-Google-Smtp-Source: AGHT+IHwDTMuHwhkr1EJ8ws5Ep+PgNnf6Rh8kDrc61+J9hDNNtk114bN6civNP+cpSSOYWZ+gvbmEg==
X-Received: by 2002:a5d:64aa:0:b0:390:f4f9:8396 with SMTP id ffacd0b85a97d-390f4f98481mr10679310f8f.28.1741062403116;
        Mon, 03 Mar 2025 20:26:43 -0800 (PST)
Received: from Sahara-HP.. (bba-86-97-172-234.alshamil.net.ae. [86.97.172.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47960b6sm16732712f8f.17.2025.03.03.20.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 20:26:42 -0800 (PST)
From: kpark3469@gmail.com
To: ardb@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	keun-o.park@katim.com
Subject: [PATCH v2] arm64: kaslr: warning linear region randomization on failure
Date: Tue,  4 Mar 2025 08:26:34 +0400
Message-Id: <20250304042634.591375-1-kpark3469@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAMj1kXHyZ5_+ZrcRtdx4X8LA+mzCNcXUZM_3QcEudYGbuGBq0w@mail.gmail.com>
References: <CAMj1kXHyZ5_+ZrcRtdx4X8LA+mzCNcXUZM_3QcEudYGbuGBq0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keuno Park <keun-o.park@katim.com>

On systems using 4KB pages and having 39 VA_BITS, linear_region_size
gets 256GiB space. It was observed that some SoCs such as Qualcomm
QCM8550 returns 40bits of PA range from MMFR0_EL1. This leads range
value to have minus as the variable range is s64, so that all the
calculations for randomizing linear address space are skipped.
As a result of this, the kernel's linear region is not randomized.
For hotplug memory users, kernel needs to inform that linear region
is not randomized. However, if CONFIG_MEMORY_HOTPLUG is turned off,
then kernel tries to fall back to the legacy way to randomize linear
region.

Change-Id: Ib29e45f44928937881d514fb87b4cac828b5a3f5
Fixes: 97d6786e0669 ("arm64: mm: account for hotplug memory when randomizing the linear region")
Signed-off-by: Keuno Park <keun-o.park@katim.com>
---
 arch/arm64/mm/init.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9c0b8d9558fc..848790a9e75e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -290,6 +290,17 @@ void __init arm64_memblock_init(void)
 		s64 range = linear_region_size -
 			    BIT(id_aa64mmfr0_parange_to_phys_shift(parange));
 
+		if (range < 0) {
+			if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
+				WARN(true, "linear region is not randomized due to bigger parange\n");
+			} else {
+				pr_warn("falling back to the range considering on-boot DRAM size\n");
+				range = linear_region_size -
+					(memblock_end_of_DRAM() -
+					 memblock_start_of_DRAM());
+			}
+		}
+
 		/*
 		 * If the size of the linear region exceeds, by a sufficient
 		 * margin, the size of the region that the physical memory can
-- 
2.34.1


