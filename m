Return-Path: <linux-kernel+bounces-352722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DDF992347
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 05:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0A6B22777
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 03:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A513FB9F;
	Mon,  7 Oct 2024 03:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOnVDakc"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2875C3A8F0
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 03:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728273393; cv=none; b=BdFDZfs8mB1mlAozPj3OISuO3oSy80dhzAocX2HWt1mhLH8QcrLDurk11e6WiwTkFKmiqcJELy3n+fGKsoAec4tS8hTzhZwYx9qw1KYVfnWI+SQSOx7tWEu9A8xoenDHgOd3vqoT+sjdAOs8AIpC417l9BXOmnndXogZd5uB/7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728273393; c=relaxed/simple;
	bh=8LcoMqDMXRbF37uLR3U9Pk8EAu0/CnVCPEyfY1gmzfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7vf0VLb009Ty7GVcXc2J2SLcZr1B8PHrLsdOS0PE2C9URoCoSa/zowZ26cR3sQXWq/N9IrsGr/sX266csij3EOdZMNcnMDWWz6HH4jD13S0KRA7uJacnMfg4AT6MjhrIbS9r729/+IoC7aEh4q84vLwirCihPtEjhT3xwjq0Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOnVDakc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71dfc1124cdso673349b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 20:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728273391; x=1728878191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oXVPUAH11w1sXXy+8Ce+V8sqrsY4hj5A34A1lI1cIgI=;
        b=TOnVDakcPZhsEbZczLUex1mAU8U8A92ttCKYByV7fpLOUg3SZZnaPkFx+IQWgI6p8s
         Tb+k8wnaetxCtZ2F3Br/EhTTBaT7nx/2I9AZs/5PhzLZhRcWEq67IbBJXUVVEhuoUrSV
         pq5qXjZOORbFxvbCdEbPr/D5RRD2IsgaHwYYE97BBLqJVeTmakRPJgNBAsp4uNlBdIJc
         ItawcZLfpdCMOJJZPNNbQE6LbfSmjszHxG0zJSMFcgtTnOO4zAl27FR8mUPhgPP3uFmg
         OmNrnr/ROE6EyzFwxFqolOoasqtJYSBD9z+RdSc42wSQo8LNr3XVBHjMtvjJfpKd+ax5
         5ttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728273391; x=1728878191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXVPUAH11w1sXXy+8Ce+V8sqrsY4hj5A34A1lI1cIgI=;
        b=qbCiA9lTCPj3K6ATObok3++/VdtN8pilrC7mhqi2NJ8NHoDN4ZRhT33LgV5Wa3LofB
         HGw2cDZhZIsp6HEQ1/qkMbLta1Uv4tzPulj5T6e4dFD1reK3xo5nZIlSRkvM/N2p6xHa
         a1rcbISCyJ8jZX5U4SerilDDVDDMVHYlzR/ZwdLckysy2C6KCLG80aKCUqsfKIvJ5hph
         4etWREg4USOtCaDFIA+D2wptwohEmaqgMZHmDDqolGXQqm/8IQyxyc6DCZfWKN6KgMCF
         2jBrjSMaj24bk7c6kRZ5ydmqbCuQJ72DQRyZYC69cps2xRvpwFfz0N7nPH/yW/lSiIGO
         xMBA==
X-Forwarded-Encrypted: i=1; AJvYcCVDvToN8MUixjCQQ5sT5G149Nc2DM7mISX9nWY0EEXRLKdCygxXTXfusOIeg0r1HLZ4PAnp/qKDZuTvK1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP1BpLvCh4olPq7dP6Ne8v6d9SiGVM7Gkz8hOdi/5330cpSbQ7
	YT/b+YIkLyNWE1EDCqP+RM+qKicRj1G51i0x+AYwTMX8/Al9dOA1
X-Google-Smtp-Source: AGHT+IEw3q8By6MuG2yg2vwK6pYopsLAtSTTzK6kFSoPAmmJ5SviE31F6F0Hl1AgvzLgES4Y3VeDhQ==
X-Received: by 2002:a05:6a00:914d:b0:71d:f2e1:f02b with SMTP id d2e1a72fcca58-71df2e1f068mr9912225b3a.2.1728273391377;
        Sun, 06 Oct 2024 20:56:31 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbbac6sm3451322b3a.39.2024.10.06.20.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 20:56:31 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v2 0/3] RK3399: PCie Phy using new helper function
Date: Mon,  7 Oct 2024 09:26:08 +0530
Message-ID: <20241007035616.2701-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Earlier patch series were part of the clk and reset series [1]

[1] https://lore.kernel.org/all/20240901183221.240361-5-linux.amoon@gmail.com/

Now I treed to split the series for phy changes.

Latest clk and reset changes are below

[2] https://lore.kernel.org/all/20241006182445.3713-1-linux.amoon@gmail.com/

v2: Fix some typo in the subjects.

Thanks
-Anand

Anand Moon (3):
  phy: rockchip-pcie: Simplify error handling with dev_err_probe()
  phy: rockchip-pcie: Use devm_clk_get_enabled() helper
  phy: rockchip-pcie: Use regmap_read_poll_timeout() for PCIe reference
    clk PLL status

 drivers/phy/rockchip/phy-rockchip-pcie.c | 92 +++++++-----------------
 1 file changed, 25 insertions(+), 67 deletions(-)


base-commit: 8f602276d3902642fdc3429b548d73c745446601
-- 
2.44.0


