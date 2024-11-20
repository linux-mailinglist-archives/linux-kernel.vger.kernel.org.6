Return-Path: <linux-kernel+bounces-415155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5709D3217
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 03:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F69284219
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 02:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CA473446;
	Wed, 20 Nov 2024 02:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tud4FGh7"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D52F18035
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 02:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732068749; cv=none; b=aFcBJL8l55qzj4R5SDNVoOiwEk7vhnVQFQc4/+N2xY7H896O9Q0gGBedWnOcA4FtfXoJzTgRRahlD5cP99NQQcwC5syMqDU4dI1OrdVII6mIPmYDK8o8YefgLurGYNVWtbhReNh500Fye/sve2v7SxyU8jYeTkxTydgYUPsUPJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732068749; c=relaxed/simple;
	bh=FWZUq11I1pa0bhqSml/fV7KDJ7Gg6G1OnoWj84E5YnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ueAnziPhwf0NdfNz20xiqtYRW84RF+8GZdGjNmVpGb1kTf85bMyjklPA0ML9cCA7ygZ5UJCCeL6FkmkfRRHElunG9m4wPIrqhJhpKeow0qsJvj4Yy6m3B9OcO3Tz5jh02Hb02er6gcVlfkd0+pCaRBVEuIIYh9RyQdTUx8BDvB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tud4FGh7; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 557A33F2A4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 02:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732068739;
	bh=dXXaxjoKuHs8ClphStnUelMg//gOqxe8KULRjLpKLYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=tud4FGh7t+DklBVfD3BNaZT1x5dWsnclGORRV8W/NDUsXmY+Bv83anxSuq3N0C5Zp
	 gKPdNUiUjWFnmMwk53EgpP4mPSOpPmTjQ9SLhUPVUClWa+06p0b1yn517S6rMF9AC0
	 ImFnNZXDLFzWwManGxliMdnV2dtSQbaFlG0TEPzApY1nuq4p3xmI+Yt1YE/hJFUOoz
	 DyjQRDwZjHdvGASTBSYCqlLd897UcOPkahzn/dJWzpYyfCY+XfReeJekXpqo3j+dZ9
	 vsgOxQUjyG1Tc5EFRTPmi/Y6T9gzzD6wlJgqqNwVuudnTGNzOVokkCrozNR6Hp7+k/
	 xvWtEIKHkeHBg==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2124debb33cso3883215ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732068737; x=1732673537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXXaxjoKuHs8ClphStnUelMg//gOqxe8KULRjLpKLYE=;
        b=eWVAVPdOc0NTtGPtuMYwl2hdpIhterAR5PNesy33exazd5Se+JXwfBCjNg2e3V9ggP
         83uR+ffczKmEiVk4QyzRw6bU43T/9XrqUohbIc/xxgivmZ4aNt9clEdNGiOX68OBUtne
         RswN0mAHG3XMphGjCOc6CR5+GUoNaZCtBpQXZN/G9arJlnQUQnWrn363OkB8H7zF6jRV
         AesQkRBplJkEOmWwwSQjgR4tJ3N0k7d6gEUBu5EeSbkm6DswRb9VFOvmjc4ztrJ4AEY3
         K+2hYF2CrZrdOeyRaYlxxCUBEHLiE/2MgVLnwGiRAtUyxpMAWIlR/H9CZe5clx8/p26W
         B/EA==
X-Gm-Message-State: AOJu0Yxo2teBCVEvAi1HiKSAnYS0MiyEvyFA6HJuJzMtjQSjPjpJd3rS
	zJ6Qhigdmk+DiM89/BTFDYO96cY9iQeI4vNGvM7vQskczf8aup3cJ/z893T6mvi6PMHKLA4WpQh
	TS9GW29FDm9ESMsfMLjtqNcuFtHiqhcYnVAyDpRWCSQNnO+PAmgcfwy8G/N/3AHrei4XO2GXaXN
	eQBYSbDr4R3g==
X-Received: by 2002:a17:902:dace:b0:212:f7d:9284 with SMTP id d9443c01a7336-21269dc8946mr23413265ad.8.1732068737609;
        Tue, 19 Nov 2024 18:12:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBhzJj5EEuAQqMTiz/knGaoepCW4lqXLanIqGcfDi6yQPLjbrJJLO80rJzuSbiXHBtqXIrUA==
X-Received: by 2002:a17:902:dace:b0:212:f7d:9284 with SMTP id d9443c01a7336-21269dc8946mr23413005ad.8.1732068737319;
        Tue, 19 Nov 2024 18:12:17 -0800 (PST)
Received: from zoe.. ([2001:f74:8f00:c00:6aff::1003])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2126f2c5ba0sm1371875ad.47.2024.11.19.18.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 18:12:16 -0800 (PST)
From: Masahiro Yamada <masahiro.yamada@canonical.com>
To: kernel-team@lists.ubuntu.com
Cc: linux-kernel@vger.kernel.org
Subject: [Plucky/Unstable PATCH 2/2] UBUNTU: [Packaging] remove unneeded prerequisites of $(DEBIAN)/control.stub
Date: Wed, 20 Nov 2024 11:11:02 +0900
Message-ID: <20241120021205.1590999-3-masahiro.yamada@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120021205.1590999-1-masahiro.yamada@canonical.com>
References: <20241120021205.1590999-1-masahiro.yamada@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

$(DEBIAN)/control.stub is marked as .PHONY.

There is no need to specify version-controlled files as prerequisites
for a phony target since they already exist.

Signed-off-by: Masahiro Yamada <masahiro.yamada@canonical.com>
---

 debian/rules | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/debian/rules b/debian/rules
index 600e7bab2150..d1a6c2a78521 100755
--- a/debian/rules
+++ b/debian/rules
@@ -180,13 +180,7 @@ UBUNTU_COMPATIBLE_SIGNING=$(shell grep -qx ' *Subject: C = GB, ST = Isle of Man,
 
 # Misc stuff
 .PHONY: $(DEBIAN)/control.stub
-$(DEBIAN)/control.stub: 				\
-		debian/scripts/control-create		\
-		$(control_files)			\
-		debian/canonical-revoked-certs.pem	\
-		debian/control.d/flavour-module.stub	\
-		$(DEBIAN)/changelog			\
-		$(wildcard $(DEBIAN)/control.d/*)
+$(DEBIAN)/control.stub: debian/canonical-revoked-certs.pem
 	for i in $(control_files); do                                           \
 	  cat $$i;                                                              \
 	  echo "";                                                              \
-- 
2.43.0


