Return-Path: <linux-kernel+bounces-431297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F859E3BA3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD646286F70
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1731714CF;
	Wed,  4 Dec 2024 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WySxUk0w"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EBA1B4152
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320076; cv=none; b=Xbg0YGnUTCtZNLwWLdkkuqbYuv5oq65vQNmNf1M3/o7RbnPuWemLXKESSIMjTZ96QEByTvlyia49VR5zCa+xDSyDXWORJEEeflG2n7SIfrA2cHmeeoNirpIWDtMQVMm70sin6jo2+RwbnqcTb/5VNUVgIfoX12G1469LqIHvxVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320076; c=relaxed/simple;
	bh=N7/vkh77qk1fPHVjfiBISqmE4uv/JTxV7LgwE4hm2a0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RVW42ad030DIHFTrEZpiC+wbiTnXxos3Y5lZglHIZjeJVpBLE20dklFX98YE5VAnAHGtMmevFLcEgcZ9o7A383BCMphuq4MdrL2jLvb2Ryz8GXjTL5/Xi8oGCAl4BDnGKcZ2xwfAfTRgNS5knSS9SuiKCfOEgSDn5tz0CEDcXyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WySxUk0w; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434acf1f9abso62697635e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 05:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733320073; x=1733924873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7dkS0jxrNDHpGzyQIGNBb3o5Ra/IS2ul8BnWsJrSOvg=;
        b=WySxUk0wWBiHni28UtltSPBZArrlpsUtaBD2E/QQ1rkDSIW3CvXiTpHI/QpeNqLMZO
         cf/qH08jGjUxrjmubok8L90x5V2B+Y7yNvPK3Hs8w0fAR8Imd2x9SotDUs5PN0KQc5QL
         6/jvbnzUbOxWyuUUHrbix2BZWNXjY3zbbYLceQMH7Xj7pd/HDA2Y08OVr1VpSVWuPkJp
         33tnK0UY1r431lSqecx85UkZh2bhVP3+eUMIKfNC1hb8+BmsqK7gPy8En2GWSMyK/e2D
         Hx9R/tfh4XmfXSGtVphXbEJ5y8y2GMJv3lU7sGSzA2l/lHVzQTuaO8qzkTRwiKwQuIrB
         aIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320073; x=1733924873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dkS0jxrNDHpGzyQIGNBb3o5Ra/IS2ul8BnWsJrSOvg=;
        b=kmDHKCK5IlBC7T8ViExzo5AMvR41vtShHk8TiRZBAO3ZCMEXGA93gm6VuH98/DSN7d
         MajvRmW4jjDgRURtejVuqET3VXZ0Iqv+42BVM9h74MyVep7oEXCKEq6HYggxtbyfXQPG
         98GbQZkdvlxX6pw5rNhabgTN7D27STgLW8cIrQzr/UEWmf7zwE+VOM5u0AI2+6C2tPPh
         ZzKSGnMolZ9LT6d3sfQ9gDz71Hb5GRKYGpZqfazhJkcgQ6pHJ3FuCuMJVvgEiXRPhSr0
         2xi4UIhL1LSvEzXbvSrMMsFGbFp9tipMSismNRxPs0ziBw6PT9Dfafgb5SWNyphuGnn2
         puCA==
X-Forwarded-Encrypted: i=1; AJvYcCUeP7mUmc34UIiOsmS/zu/tnGXV8QxUvSpdnzEsDSEFOUgofNQBZiQevIsvLqkU3hIsnk7a+oxLoUT+Mys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2t+vxAy2x/oqL/XEgeE0dsVh1YnW0DgM3fp0G6irWut+vUvEn
	/kxJZJWWJYugztrXK7G5uqong6JprOPsU/FCa4t9Zst49Lh2yrWH
X-Gm-Gg: ASbGnctNOsqj0XiAFrQ8IiZjsnJsFjJcSlxOjiUz/akH76O0VzoQ2bUkPKvmIHjkyIW
	YV0NmSkmrmV+9g7HcK+86Z1soz8lZrbxV7tkkR2aDohoRDS55fzCCzObhS6aghpHHj26U1TRxyM
	2vqdumQ3jgBTcAFy2ehwL4H4bSUs0M9ImvdGRCKySIn659UYcR2HGPsDGYW6uOTGjIF9XHcZ7JE
	GtxCYW1G+jUybZYUm1XhhjVXQeDgOy8/798nc5wdU31pqToZsqCokV8W/Dlc5cy9psoGMlv4k6H
	37IIiJVt3w==
X-Google-Smtp-Source: AGHT+IEERzG3Y2W6qTUJPL9AaT3DvYbYKP20IfUHmhXP+mAbXsk1BfF07T4abHbvNiGofdVOsKIM8A==
X-Received: by 2002:a05:6000:1fa5:b0:382:47d0:64be with SMTP id ffacd0b85a97d-385fd3ec1c0mr5280390f8f.29.1733320072859;
        Wed, 04 Dec 2024 05:47:52 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385deeb6acdsm15939891f8f.81.2024.12.04.05.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 05:47:52 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: sfr@canb.auug.org.au,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH] staging: gpib: Workaround for ppc build failure
Date: Wed,  4 Dec 2024 14:47:36 +0100
Message-ID: <20241204134736.6660-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make GPIB_FMH depend on !PPC

Reported_by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/all/20241015165538.634707e5@canb.auug.org.au/

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/Kconfig b/drivers/staging/gpib/Kconfig
index 95308d15a555..a9b811165f6b 100644
--- a/drivers/staging/gpib/Kconfig
+++ b/drivers/staging/gpib/Kconfig
@@ -128,7 +128,7 @@ config GPIB_FMH
        tristate "FMH FPGA based devices"
        select GPIB_COMMON
        select GPIB_NEC7210
-       depends on BROKEN
+       depends on !PPC
        depends on OF && PCI
        help
          GPIB driver for fmhess FPGA based devices
-- 
2.47.1


