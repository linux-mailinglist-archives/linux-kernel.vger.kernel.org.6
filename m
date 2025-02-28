Return-Path: <linux-kernel+bounces-538702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC90A49C1C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E26A3B7AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF86626F447;
	Fri, 28 Feb 2025 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHehYuNT"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DCF204C3B;
	Fri, 28 Feb 2025 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753235; cv=none; b=uNfZv4dGzpfY2Vo6Ky8ocERuhFOYGQcn78rJ0yLoQqtsNxRs1FcJoNBsTkkRvJnbKsm751guZA4IlHmGUSvq8v4M4XLThFZDT4D3YW9Pez6sBB3IoCs9E0H/4jig1OYkWlWeLo7gkFn/H5++nB5XDB41lqYKLM2j0Ubf5icZWE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753235; c=relaxed/simple;
	bh=VitbQI5RIn3d1mDpf5LdlliKLU/NJonLFSWmzXZlXXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=irMSHxZAXahYazHPlyd22rXqdI867jZDptt0K2gqbP7E4TRnQSRvDAJsWmxV8mlkhBI+T1X8JQBV9+31Va0BZUHxTdXL6SeCRu28ErL2KKgiUXb+2Ykud6IctZ3czWMbA7wtZJ/k3x8dchSPlnw1hgLuCorDk9x4nCfkqm2L6LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHehYuNT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2feae7e56c6so444173a91.1;
        Fri, 28 Feb 2025 06:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740753232; x=1741358032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+z/hwD0xv70WB1DfpskxcfEOph0OOPc6FfcNrtz55wA=;
        b=UHehYuNTPXyNMVzUN5dsa8csa61ADB+EKMFGO8wdzgs/s77vwSAAgoEmPnzPR1V41i
         xvELae4dhbWTeRzocKE4y7yzYlXs5zqbyfSeW/1XCI/rLS1j8iLIW/kcYN6sa5wgmZoF
         KlGSNkzxA0TmdhiNwZI3RbmjXA93/LWe/GbdfogCSW6JoHMGe2JKQ0Q1JBlmSxuXS9vG
         NApx4c26csupqWPxh6LoNLjDnnOJ+9ledzN4dbq+HBz8/glrbaUm0eFMlUggxJUhP3ev
         +KtAWsLB6W/+obvtJKQt8Yyd+5BL+i2RR/aA9cG3S60yLYJI3uhw+baU9OamsGWmGpSK
         bO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740753232; x=1741358032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+z/hwD0xv70WB1DfpskxcfEOph0OOPc6FfcNrtz55wA=;
        b=rqKzCpJP8tCrqL94BcM40fWPu5DDY4Qp8Zm+XBPao0xqRJOAL9tm3PxApOm/i4vD0I
         B9ZHj4zeKMsj1R/oYdIHNh0SLvYeNWxUA5HGLg5NuaG/YYn+bcCvP+CQ69WhDouqnYi4
         6fB/zd1E9+wK61DYoicuo2QPQqAsQnBwLOgmnzXqM9ydXPbIaws9eGyExSlA/PMduwxv
         1w/GvYwZVD4pU1t11JxTT1vsecy6lIga09eiii9lqZR8njU2amqY6Idhs19iZAe0uG0U
         km5aGZU4eO1XSTTva9U6cZwd2WH7k5TN1dhG3T2Fe25tXDpiJNnoQAUiYL+GJIQdKIsF
         sDrA==
X-Forwarded-Encrypted: i=1; AJvYcCWJq8/igA6g3VjFa7YZnurAv9/qo463j288IaEODpNvsrBVsv3zAsy7QknzXj/dQmDARMojwAzMQJbF@vger.kernel.org, AJvYcCWVBVzKGjuJJNd6DS9KvP+MIBmAhNqg1sUF0eT7TkU0rhi3YSrsGZA01cj3NK39vzn0rHwhDsg2QE35FPL3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9zDpw4CgyuYQGGcBCyedom7xnBXkF2OAMFuMFadwh/klG4r3j
	VjJjhf86pW9mpznm58yWcSYTzeLiwy1dun11elV7Z1nCQTPuzyi6j0vAvmGz
X-Gm-Gg: ASbGncsSJnMn7Jf30l3CvqdyCYCj4+L4I4INTxokiJ91SS7MU4XGBgdB/7Y4/gjhYtS
	hau8FJ8ddFsXyvAr6gPeyf/mUdYlUx2BF60mn8eQ5XLHTmPLqYmfCRKR/8xwUmZG6kKzgCqdQ8W
	TBZTTA3LMh9TySoogWSIgchLQ0zD0d05n0hnGaxjPUOP9HU+Hrs9x6ZTjwkMzEZPpjBvFWE6s3z
	ZS3+aCdwcNyC992eCbvWO3Igim0Jl7KqBLzzRSiydQdFw/F65cGkUZPvUkkhuIcu/EOO4GfUNyF
	5kK0xhxItcaIlcWAMiPZk2nv+m0K8cY=
X-Google-Smtp-Source: AGHT+IFFK8iGt2zkzJRfvygeL6oG1AvM9o6uoiJiWNbIcylOAd9HzZ8vKfhy7zWgRggSdl3wMWsPWg==
X-Received: by 2002:a17:90b:1b48:b0:2fe:7f51:d2ec with SMTP id 98e67ed59e1d1-2febaa8d1e9mr2349075a91.0.1740753230444;
        Fri, 28 Feb 2025 06:33:50 -0800 (PST)
Received: from rock-5b.. ([221.220.131.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea6752095sm3807148a91.1.2025.02.28.06.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:33:49 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: slow down emmc freq for rock 5 itx
Date: Fri, 28 Feb 2025 22:33:08 +0800
Message-ID: <20250228143341.70244-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current max-frequency 200000000 of emmc is not stable. When doing
heavy write there will be I/O Error. After setting max-frequency to
150000000 the emmc is stable under write.

Also remove property mmc-hs200-1_8v because we are already running at
HS400 mode.

Tested with fio command:
fio -filename=./test_randread -direct=1 -iodepth 1 -thread \
-rw=randwrite -ioengine=psync -bs=16k -size=1G -numjobs=10 \
-runtime=600 -group_reporting -name=mytest

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

 arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
index 253b23ea9fba..bcefe5356936 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
@@ -724,10 +724,9 @@ &saradc {
 
 &sdhci {
 	bus-width = <8>;
-	max-frequency = <200000000>;
+	max-frequency = <150000000>;
 	mmc-hs400-1_8v;
 	mmc-hs400-enhanced-strobe;
-	mmc-hs200-1_8v;
 	no-sdio;
 	no-sd;
 	non-removable;
-- 
2.43.0


