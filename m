Return-Path: <linux-kernel+bounces-203209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 521558FD7E9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065E11F21E38
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA73161B52;
	Wed,  5 Jun 2024 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OM0YCSmW"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC4615FCF0;
	Wed,  5 Jun 2024 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620740; cv=none; b=J3AxMD9dOaV3VmMI5Obf/qMTVdfE16rJ490NIHpEG5BTuosw76Lu06NjfF9aEaG4aJOH/IYe1Q1RVDi0KZasquKGdk0IHC/uBJadIHm2yA9M3vipJza2Xj9IkHTcG3hcz/A/JpOJsmZmF1b9r3+fCG85HjmaBU6yb7JeHxD3rYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620740; c=relaxed/simple;
	bh=oUhHL9Gh1eiLkn61h89qakuHxe3kwFPwvQ1qeKNnvTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpIDWDU0GBZjb/hCNnjewid4qa+v/0WmSxIUT+SYvneGZAgem2HPdJxkpwAp9CKA4Ft9RmNOFZPO6CcqtPOsFPYxPusCt5/tXAUmeIUdsTeKfjpJXv0MQlWgnPQr2QzDOiMibf843bzF8G/nkS0sF3Z9rLbqdaIxSF0RZKodWr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OM0YCSmW; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5295eb47b48so356945e87.1;
        Wed, 05 Jun 2024 13:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717620737; x=1718225537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuZhauiIXe/dPit2+IYYIDdw8J65X44pe+rX+iqZzH0=;
        b=OM0YCSmWH/K1riMSb4ocKo0OzNtP3ZInXSOusgvX7XopmCMzmElJGzkmqT76UExHxm
         IACTSqfKldjsuyItCAIUd3u/HAO+6+r/Bs2x0NJNEBSf9sqtZKmozmD8IfnzHmdsm9fZ
         LYUmXcXavKkmYVUiEGfYcT5j0FCGah23sC99xs4wSSfgmt8iJgv6N7HvaaKIK4KpIDG5
         gEOyt03QTZQ89dUgZ0xgr8AjzVAVtUvF9AiYJz+ptE6QYVHiywaQ000eeaKqB8XL01Hf
         gfIcLqTuDGzkNeBP7ZPUzXoD5EuqObcb5oP37uZGTmuZikaI/CzhMXLIATRUXHWLOUJr
         8WSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717620737; x=1718225537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuZhauiIXe/dPit2+IYYIDdw8J65X44pe+rX+iqZzH0=;
        b=nSdQA0tBQQaxyxXq0M9aUbzkbeUnysqqQFxjMCZEcNym/JfyvOsddWdC70pe+zKxsH
         LleR58C2tWY9ATMd2E0QdivAmQcPuJxG6ciIWH3vGhD8CQNi+xw/p5oGHICFTUw0CBYi
         ak8ID+xB4NgFe5XWnxjwprwzLBO9i7Lpaa7FPjDvRBnJXDABRqqp3LHK2FBdtyQXoqs0
         YK45ptPQz9S/MHAqHje+2nhSqvMrL8kehRdAaF/AsRT4G3SV357tgx8j3417nu0yma8G
         o9wYimS35SR3IpKanIQQnKs+XTaN5kMQQ369RcvzQzPRAOFtRfC5Vizomahdu4f5K3nN
         dn1w==
X-Forwarded-Encrypted: i=1; AJvYcCXoetU7MgsWp/FlONgERAKR3/JknddcTgKw0zgIbLp1e6Ys81M512Ga922SMXDJaDb3Q3y82EhkKj5KSz/kpADTp0PAgCtfYEsff4psY9WIY04U7Z4WKQ9OR454HQOdVMuQl+0SyJj/bnADTez237ihsUO4XtnyDBDOQDSaHWIleUShAw==
X-Gm-Message-State: AOJu0YyDtvqnM8CeYct/Osy4YYUGTMQcScbJysDjaISG3zj6VrvQ+8NE
	e/K5sEIkTwkTvZusQHnu6uHVL5Gx/fXZ+QlxSCRoHeS5CVUH2AE=
X-Google-Smtp-Source: AGHT+IEUmVGccmn5n59tbMFqyxwa6cCbIoRWoOhCNW7qogkjWg4uC/uKSkpRIvsdSeMzyFB7O3CvBA==
X-Received: by 2002:a05:6512:1052:b0:529:b6ea:d545 with SMTP id 2adb3069b0e04-52bab4e4507mr2810632e87.29.1717620736727;
        Wed, 05 Jun 2024 13:52:16 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:5211:58fe:dfef:c48c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c71bb5affsm72265866b.147.2024.06.05.13.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:52:16 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 2/5] dt-bindings: clock: rk3128: Drop CLK_NR_CLKS
Date: Wed,  5 Jun 2024 22:52:06 +0200
Message-ID: <20240605205209.232005-8-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605205209.232005-1-knaerzche@gmail.com>
References: <20240605205209.232005-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CLK_NR_CLKS should not be part of the binding. Let's drop it, since
the kernel code no longer uses it either.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes since v1:
 - new patch

 include/dt-bindings/clock/rk3128-cru.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/clock/rk3128-cru.h b/include/dt-bindings/clock/rk3128-cru.h
index 1be455ba4985..420984fc2285 100644
--- a/include/dt-bindings/clock/rk3128-cru.h
+++ b/include/dt-bindings/clock/rk3128-cru.h
@@ -145,7 +145,6 @@
 #define HCLK_CRYPTO		476
 #define HCLK_PERI		478
 
-#define CLK_NR_CLKS		(HCLK_PERI + 1)
 
 /* soft-reset indices */
 #define SRST_CORE0_PO		0
-- 
2.45.2


