Return-Path: <linux-kernel+bounces-514444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ADFA3571A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762533AD34F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D191200BA8;
	Fri, 14 Feb 2025 06:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X8YU8RP5"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E3917E;
	Fri, 14 Feb 2025 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514675; cv=none; b=WY4WHQBwXHAprzlpZGehqE7vnnk/EYk4vboCpygb2W6RCFW1jzBhr7VGJ7iknoHUGKF/UABlhdNeItmmgVTDyNfcWMa317WH95I9C4yti8/2d+wRRV1V7+KexfeF6hPzIGc4Ay5o84DjCru+gX+X7wP6gwlCSmRiUTw3JSoT5ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514675; c=relaxed/simple;
	bh=A1FbOq1iows2Sv/bNsx+GZoO3j1Yqqb3gf7/FDhFvPg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cw9snFdpD80dIOmou0618CJ6JsvVpynECeIFO9ujB+CtHqvcwAi6mUgvZFRgSdYHY8cBFOYP6F1p8j8K5UUHPpcd38z6O2gOZGTxAB23edYg9tCJ4/8bi9lSqMs++rbqezN5hA2xF9bDoaxBmv7Pz/RejfOW6l0DwtTIjR9Z+Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X8YU8RP5; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51E6V0kt899872
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 00:31:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739514660;
	bh=6Jta8SCvtFAKEEUc/90d7iKXUlrgbGqW9xLB321U+JU=;
	h=From:To:CC:Subject:Date;
	b=X8YU8RP5LuZm/PU/X+upariCwGLkPzb7L2QxScspfwpAGYtNchPKq2QFn4vS5wZyP
	 LypUpoDqaKBgeCSTpS83Cn5gMMmU/72C0cYFGNoq+/5azEq/X/JAIJzlvVc2AYlh43
	 KrHFX5oHrRpqfuZl7MaHe8nh4yoBYwbIcRq3ePEA=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51E6V0mG019376
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Feb 2025 00:31:00 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Feb 2025 00:30:59 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Feb 2025 00:31:00 -0600
Received: from lelvsmtp5.itg.ti.com ([10.250.165.138])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51E6UtCc108646;
	Fri, 14 Feb 2025 00:30:56 -0600
From: Baojun Xu <baojun.xu@ti.com>
To: <jwboyer@kernel.org>
CC: <shenghao-ding@ti.com>, <linux-firmware@kernel.org>, <13916275206@139.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Baojun Xu <baojun.xu@ti.com>
Subject: [PATCH v1] ASoC: tas2781: Change regbin firmwares for single device
Date: Fri, 14 Feb 2025 14:30:30 +0800
Message-ID: <20250214063030.6396-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Change regbin firmware for single device.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 ti/tas2781/TXNW2781RCA0.bin | Bin 868 -> 812 bytes
 ti/tas2781/TXNW2781RCA1.bin | Bin 868 -> 812 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/ti/tas2781/TXNW2781RCA0.bin b/ti/tas2781/TXNW2781RCA0.bin
index 9718640b529e324bc5975d7d66bcfbdef8d4ad6e..49d64fb0912acc339f2b573997898c31a89e28c5 100644
GIT binary patch
literal 812
zcmZQzVAiQr6Ubs<U}Obi#`JXugcv~#1~^~_vT}g<3=m&{i;f_Mfq|~4QLwI|SyE<+
zZfbHyeo<;#YEf!la;k1|PJW325kbMkzyc0Y4xm~_Fl1n2U|?o+1M-o@qznwfb|oj~
zWF{3QmSpDV5n(#25|CXtfI=Byvl$uK7#R4DFfi~tFfi}}9U;KNz#!(tz$ktK=mZu9
z7O?Xf!E6o*h)Ez9a>y`1#55Ry8X;^h4~RTSA6EoK9HbVPUyQ(hNvbSJEG~xVB$WjD
W#So|ol>Rt?HnC&(3zGsp`~v_rY$nG5

literal 868
zcmZQzU`{#U%krFofsqx68Pj~{%w_~J7~p^z$m#*&J3xE`E;@o3Da8f4hGt2bCA!5q
z`6UMA_?(H6g>eB;qXrN&GcW=nL(EJD76y9;1}-Te4;c2mKrt}~1_nN$5`G|NVqj!u
z1aUZk7^DLz&&1?u6byAsYH~(?QEFOhQEFatDk&}lxn&8^%nBgp0-6epU%n$iI~~y6
z!~$`X0FVZ{i&6Xp&`B%|EMWgLg4rArKqG(v<Tef&kds*$I5Zd>Kw=;^mj{RiWk*27
zA^yPXx1`E~#NuLz7BWeot&EjGy(K`*33eAKDKmrp2@FTLKW{QHBnSY#uLlozeEuWB
JUkq5{3;=u;DgFQe

diff --git a/ti/tas2781/TXNW2781RCA1.bin b/ti/tas2781/TXNW2781RCA1.bin
index f92631f8477b78cd8714e9941fa57d8346323df8..49d64fb0912acc339f2b573997898c31a89e28c5 100644
GIT binary patch
literal 812
zcmZQzVAiQr6Ubs<U}Obi#`JXugcv~#1~^~_vT}g<3=m&{i;f_Mfq|~4QLwI|SyE<+
zZfbHyeo<;#YEf!la;k1|PJW325kbMkzyc0Y4xm~_Fl1n2U|?o+1M-o@qznwfb|oj~
zWF{3QmSpDV5n(#25|CXtfI=Byvl$uK7#R4DFfi~tFfi}}9U;KNz#!(tz$ktK=mZu9
z7O?Xf!E6o*h)Ez9a>y`1#55Ry8X;^h4~RTSA6EoK9HbVPUyQ(hNvbSJEG~xVB$WjD
W#So|ol>Rt?HnC&(3zGsp`~v_rY$nG5

literal 868
zcmZQzU`}~`QE(3f10yRCGp6~@`OgSqFu(ybkaY)$dw}=`Tyz96JdJ{N4b74=OLS9{
zGxCd4(^894^O93_i*xcz42TN{CI%M9B|xPWK+MI!$N&sez9S3_{0<BZF*6xh80>+<
zT0n6Y1_oYW&<g-*F$V@l@e>R{oeV5sTNuG?4he{jj6l^KG7Jzg4F;e=5H^<wL>{D%
zD*_@8QVUebz|6=8l;i+nkO)YODW$jo>NgU61F-={g8T+@pau{#L(B#H2`C2k6EIzY
z`~>t51IT)QAja;Nq{@QC;$omQ`2ge=Pym$xF(<?=z@*F!4s)Qtk;0rIK>+AJE4bV6
Mg*7NFImi!V0F@^x`v3p{

-- 
2.34.1


