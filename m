Return-Path: <linux-kernel+bounces-340091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E3B986E78
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855AF2815F4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FFA1A3BDA;
	Thu, 26 Sep 2024 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="FL3dR6Gs"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837121A3AA1
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337820; cv=none; b=tHHlHjLmf24prg/ycVnDPf9cmybHwk8Z8No92uvRpAWEr5Ep1nkVoN2HvqTmsa5Uh/aOTbnulxBAKHR0d1DhygNTm9RpQjKwDgumQD2d0cjNuBCfOIA7na9ZpUnLyoIADO0270MrEHxtGPXUQ4LtanihWoSFjv7t98bAnAiiOPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337820; c=relaxed/simple;
	bh=WxOXJ0g3N+bfNQHp4yoixvy0FGw/WKacroKHMWQgXr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihLNoqN3BU8VWwFPTukHI1lfrGG1lEtEztGmXoZAvcmCIg32jn3ftvYqUgBw7ErUeR76QB6mwMb2DFc+kHnKIYyQW/289+Ug3a4IZlRVZup7HrbJ5qkqqW99MqjrovaY53k2zm16CCFBsD07j+AQiDohKpHKc1kOp55T0sMdW0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=FL3dR6Gs; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8a706236bfso43458966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 01:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1727337817; x=1727942617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9RXJDhEv5QVglcEIAyBAJ4b2YbP9XJ6oelNgllPBsw=;
        b=FL3dR6GsUKDbC1FCklzDSS9LtyJcLUlxKLoTLmb4PCYqTmwdPNixZsoDsr0bs2yW/1
         +D1BbOs3n4lHC5ZYEJPvIJjxkm3tjwCX2eVEm0sQVmmaj4EgVquOxtMAVgMg0y6cMvam
         KRmXi+K0cTwJaeZ12IlZF2pBxsPqmccCM1z1Z5eSKVY/WMEJlOQaqlgpw1B6VyLKMi5a
         gPlIfLimzK/f2nF2EZol7sUjDxK5Ck2oYA0rAhQtQz7SWk/3ZbC7U3EdotFcJh5+HLnP
         nJyvnZJ55P98XRnebcUpo4MdXatBOXRN1TiamoEZ277ieUhPeVtD/IHIrA5pAOiWS3KT
         V+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727337817; x=1727942617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9RXJDhEv5QVglcEIAyBAJ4b2YbP9XJ6oelNgllPBsw=;
        b=O6ejnykCJx33xhWV0TrpfTH/cE88b2YFuZd59JBhb09iNm5Bj31mze2LPR4LnE4Hl0
         1BLXLUDvl1Rzs752pAJoqQeIZUUw10VORROazTpGpOItglfivtLF8GUBHbo7p24OQdCp
         0AhUmPtZmBmeH4HggUMS3GcSMe3MKGhtbzc/tHH3fCa2wcFBUCbdL7sa7mNR3/5yboeB
         TCBZBPGFP7Aa79SSBjmjer7MSUg7VWseUM21CFxBtt9KmByCr/CN4FDve3NuvbAMuYLz
         rcyozwwCYZc51IJpIaBUHkahb2lgfLnqZy0mlmWs7pv4Sa8VIDUL3A8PzyE0AwFvNvGJ
         yxMw==
X-Forwarded-Encrypted: i=1; AJvYcCUYCo6x6Kneq9ifHLYY/x0P6OdR+sCCrE/WT15nUnwT/YNjWx9A41rqsgPoiBq5pLdJd5Ejb8S1j+953IE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySDnpP5ZXTXGx5llUrbgYJNHuf6IfoBYNrPDDvslhfGM6iKi3V
	Kuj5Y2aundQIpELTlFw0fvQ6GU+QLR4rO6Z7IL7R5eszR4/at9VwTvWqzhybNTM=
X-Google-Smtp-Source: AGHT+IHk0x2C04tD4R7xlrLnA+RMGGzpP9AtamqlKVtJbzaCqzt5DdWGZPnHtk3Srm8M7GS5vo3IvQ==
X-Received: by 2002:a05:6402:2808:b0:5c4:2fca:b11 with SMTP id 4fb4d7f45d1cf-5c72075609fmr4874880a12.35.1727337816623;
        Thu, 26 Sep 2024 01:03:36 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 01:03:36 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 34/36] bloblist: Fix use of uninitialized variable
Date: Thu, 26 Sep 2024 09:59:22 +0200
Message-ID: <20240926080021.148031-35-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926080021.148031-1-patrick.rudolph@9elements.com>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize addr to zero which allows to build on the CI
which is more strict.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/bloblist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 2008ab4d25..cf1a3b8b62 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -499,7 +499,7 @@ int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
 	int ret = -ENOENT;
-	ulong addr, size;
+	ulong addr = 0, size;
 	/*
 	 * If U-Boot is not in the first phase, an existing bloblist must be
 	 * at a fixed address.
-- 
2.46.0


