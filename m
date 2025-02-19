Return-Path: <linux-kernel+bounces-521351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8084FA3BC1A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1614A7A5D15
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F761DE893;
	Wed, 19 Feb 2025 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4m6XscK"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4BB1CD210
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962465; cv=none; b=KvBh7TNERT117v1l1GUw5EpY4kk+q3qtNMJvEIUnkb1UEYJRIlVlDCaLeMFbuE8v+O3m6hxnJnjroAtEt41oEGO01lG2SvHCpuEp1yAM6y0CJMlWt4bzPjsOpBhM3xISK1A3cElcTA0doYwKmRBg0pLCkRTuVM02yO+WfsEmJmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962465; c=relaxed/simple;
	bh=ZRzmE51RCzLrD6CAknzJoAoOBe4NMC6yWJ8npH4vSpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zcwtd6o7QE2RPdiLKSrcdtFSs7qV5inemzKGHkHNZa3KIHaZPlt4NgsVBbzckW9QPleP26tlEzLoKqrOO9LVKM+KCNJwmpqGkJhtAACtt/8u/vCcF5BiLICZxo0brt3QmALyyM0MaK8hx8Ck8XIrcQ9D03oRUD/FcsrJ6jCCeaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4m6XscK; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220c8eb195aso132738435ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739962463; x=1740567263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bBVwkgLFU9CUqCFGNHENMJIJXnYpb7KPQnJUp/4i6C8=;
        b=H4m6XscKFFAsqthAA+iMwuQMFDYxWXU8Wt2OBXupC9EFtfgPh2JK9EVt8e2R328qBQ
         sALwp3gtHx73NvPvteK8+3Jtj4jbaB6e343SmpMzOvozZoY+usR79knKOjNbkfCvOEyT
         SNHyZJ2E20pCCDdiKueuLLplvE4Z4bVad0VOVb8QfhYNk4hYJCyJm8j3BLAW7jmdS7Pk
         z7iIDBUNkJ1SXBtoQ6HLvAnhT89k3a51/p2rCgFPGUcFz2Us/G3KLjzJlTL2KfmJ4jjl
         becCJs40SRi8RPD8Nhvo9q0vnuxDD0QnButpMc21AKpOIebpPm4pLthz1AJeKfRrZU7l
         oHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962463; x=1740567263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBVwkgLFU9CUqCFGNHENMJIJXnYpb7KPQnJUp/4i6C8=;
        b=OH2PLDJydx0UVmjC1zEwqJd9LgwQWMLB8/W/f7kZ84zz1X7FJ4q88BiUz1NFV9lc4g
         CMCIvPa2Z8oZ//V0KUZU/zRO++I95GDNDIjCMKs9SFhqY2jzL5qErO4PaJgvye3ZJMES
         3T5EDy5zOwa8VbrtL20FmxreHL2OP8YZCZOCDkCrifl4Y7FUt0RjWRyYy1yfFt6HrFPW
         Ey9HQEJM+ClJ4gYRAd/kQ1sujPdIB0bqW45ME4LfSB2bN3qAPXar1LIUjPiRwBgCR8qh
         peG6ElJKpAOgmuDthWXwvVex50bQ8dUROUMdSZlJON2MuqzUU29coSUDbDQ0a5WXVh+j
         ++/w==
X-Forwarded-Encrypted: i=1; AJvYcCXLCjb+6smAdJkXR3Z8qB5zv/FAoSCBBUmkWDjw9BoJIrjT2o8pX3HkfiA0y3JwacjmC2XF9HdjkxpsHIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfs5YFCOYwWs0v5iNq/fHpFyRC6zNJJtZFLRXrgZrSSObOu58z
	p0aog1bDLtzWXIwWoo9U91YShbIPc5rQ2114v5wY3TtZ4Kacy6gq
X-Gm-Gg: ASbGnctecoUX+O5vjCK3vriiw1orgvPOyanQ4OKGPn1b+yUXNXYOuqweaytYNoPk7NZ
	AOJr7gf6IVTD4sV9+ImDSQVZPcDsWAPnvQvdGKza/b5QdGf/2pF8Rp6fykaDKTsxtvLrTMuMV3l
	Utb0pEiuBdgX5MNdXr19Lz/PflLwoWTb8XY07zg6aBbaRShD9RZiUP3o76+wcyrcsZTi73aWbBU
	SQ5WQyzghnIOOL1LPWyYMV5G4hWGztmbfWxUUB7kjpeU48KDweU2FyKosZJJ39Gs3YREuO/lPJq
	uP9bVZHDaKv4Z3dfnAkm5B6Z1AyvPWYzWqhT2oUk2BCz0Q==
X-Google-Smtp-Source: AGHT+IGbaYzXjVA+2aK1N4bUqfgQc4xlCKQkoojFuNuiykcWUGludHj1DqcSrBY2X3ZzG6N2xYTCfw==
X-Received: by 2002:a17:902:d4c1:b0:216:6c77:7bbb with SMTP id d9443c01a7336-2217086dc59mr43604335ad.17.1739962463296;
        Wed, 19 Feb 2025 02:54:23 -0800 (PST)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5364503sm101827285ad.80.2025.02.19.02.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:54:22 -0800 (PST)
From: Chongchong Gu <chongchonggu21@gmail.com>
To: vkoul@kernel.org
Cc: kishon@kernel.org,
	aford173@gmail.com,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	guchongchong <guchongchong@xiaomi.com>
Subject: [PATCH v3 0/1] phy: freescale: limit div value in FIELD_PREP()
Date: Wed, 19 Feb 2025 18:54:10 +0800
Message-ID: <cover.1739961770.git.guchongchong@xiaomi.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: guchongchong <guchongchong@xiaomi.com>

In fsl_samsung_hdmi_phy_configure_pll_lock_det, the variable named
div becomes 4 after loop. It must less than 4 in function named
FIELD_PREP(REG12_CK_DIV_MASK, div).

A way to reproduce when run the following shell command
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j4

The error log is following:
'''
In file included from <command-line>:
In function ‘fsl_samsung_hdmi_phy_configure_pll_lock_det’,
    inlined from ‘fsl_samsung_hdmi_phy_configure’ at drivers/phy/freescale/phy-fsl-samsung-hdmi.c:469:2:
././include/linux/compiler_types.h:542:38: error: call to ‘__compiletime_assert_538’ declared with attribute error: FIELD_PREP: value too large for the field

...

drivers/phy/freescale/phy-fsl-samsung-hdmi.c:344:9: note: in expansion of macro ‘FIELD_PREP’
  344 |  writeb(FIELD_PREP(REG12_CK_DIV_MASK, div), phy->regs + PHY_REG(12));
      |         ^~~~~~~~~~
make[5]: *** [scripts/Makefile.build:207：drivers/phy/freescale/phy-fsl-samsung-hdmi.o] error 1
'''

changes in v3
 - Simplified code structure

changes in v2
 - modify the commit message

guchongchong (1):
  phy: freescale: limit div value in FIELD_PREP()

 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.48.1


