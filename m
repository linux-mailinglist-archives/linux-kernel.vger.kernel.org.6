Return-Path: <linux-kernel+bounces-245631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1780C92B52F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F2C1F24085
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A1F15746F;
	Tue,  9 Jul 2024 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="um3f/b+C"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F615624B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520734; cv=none; b=UdKSyukbCyyNsgfBfmZHoeRkS0YtclEZbGwWgv30V0SJWcvkWFLBMEwJuSXjbY7ZwRWhfM8VU4zqfVC/qcY+XjDnSP3FtBgXjfZ3NsjY2IWbKcVsMLlMO5/lTM5SvtmVFKbOgiH3sRYw/DAieXZ4ByjsuudDmKiUIVHnjRB0oSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520734; c=relaxed/simple;
	bh=0Gl/CDETNc7UaPLuBI6q9MDmLGCd9UmNsrU2KW56MHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jaQgqkY8KIkRPSN4t0QXHd6Hc2PuPkVQzNboFEkp/2PjBsDhwbGEiQBGXPkOaGnzFgPFJghNdYwzE01O+sPXPG9T0+SXlntQW6Owxtfic0+oJFvxbJxarN5W4t7NofeFccJo4MLYKTOJu58uibMVaakrAKNVdrAmd89vub40ikE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=um3f/b+C; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4255fc43f1cso33029215e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720520728; x=1721125528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1/IuzHgP2/F+IUWJG66cldcOcCbab2/uU2CM5fWu7Q=;
        b=um3f/b+CeXbiAl9i5XVKC2iRF2+vNiMA4IXnF6mHsBu9WCwtt9ry0dTsc1m9Ssp9ZE
         SQHj9kMrFefZ8pRFj6rmZo4ot9+4gd7PyctYRG527bUzhaaBVCSoXSDu5B4mieeDDKjJ
         2zIzprGaAxkaVsWAs+lEvqN7YvUCPikgBTQ1UCwZnmjLIGPok8C2OSmoK8X9XHmu3+B4
         gpZYZ90JeMWb8ONrnR0ZMswueNE083pb67vcFHAkeswy81EanITGd/Meq4PZCH8Ck5FS
         nvIGNKO+d8cX7kWgdna6m4KcttoYpWAnD4IbpAmWDw9kWqtqgxIIrVBk+sSOa/ZFI38S
         /IJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720520728; x=1721125528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1/IuzHgP2/F+IUWJG66cldcOcCbab2/uU2CM5fWu7Q=;
        b=QBT3qU5NvEQL032Oc79gQiPago7ML7k/VUuAD2zCLmuvTb0VTLWgjzmnLITHx8+JWy
         qglZcdGp0BcVSgdFlPqY51VR7+Ba1Cxy/e5jCpDtHsZwTL/gJG93HXQQpnxKDQ6fgoYU
         0j3NBKT5Euszm7erfiAhNpul9HXlWw1CjzrUCazNWABIkT9bGVacsiCnahEPPT3m5m8y
         puQLrccw8EH2I+jOIbkYE6zz7DVVDH7Z/JKC4bI6pqUJwIeyPbrtrGKyzgSI01u1eLLX
         xl5wZ5b5KjefIb0VyIguSD8EXrJApwFGkrktqH/TnoqS2KU7u2M4SLqms0SdMvpHn1QM
         ABeA==
X-Forwarded-Encrypted: i=1; AJvYcCXZTfL2wRS4oYnebwJpyMJ9AXSVYxAbgk8/z5ljs09URC5tqpNA71qOuPPryx7LyKBt3dZTnlSF0Cf4Jiyrr/yrSQFg7XUo9GqdOYYr
X-Gm-Message-State: AOJu0YzjVbtrkFiWwZSy5gxFnLFnwiIFkJUSk3+rJKo9pUqRt92eb/Ko
	fy9lk2lvE1TDKfYgnuHwCdCZLpQUk6yF4jkcyn5oIKaUrfYHqLPKwHRwmehXWdU=
X-Google-Smtp-Source: AGHT+IEo1WH45KTt1j+jhdCnRL/LptTaGgeGNdbbLKjgs+2+kMwF9HAkLK1nJ32kCq4mOQpvTPEFZA==
X-Received: by 2002:a05:600c:1587:b0:426:5e91:3920 with SMTP id 5b1f17b1804b1-426708f1df1mr16566385e9.29.1720520728032;
        Tue, 09 Jul 2024 03:25:28 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f741553sm33954285e9.40.2024.07.09.03.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:25:27 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: akpm@linux-foundation.org,
	robh@kernel.org,
	suzuki.poulose@arm.com
Cc: linux-perf-users@vger.kernel.org,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Kees Cook <kees@kernel.org>,
	Matt Ranostay <matt@ranostay.sg>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mao Jinlong <quic_jinlmao@quicinc.com>,
	Hao Zhang <quic_hazha@quicinc.com>,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] MAINTAINERS: mailmap: Update James Clark's email address
Date: Tue,  9 Jul 2024 11:25:10 +0100
Message-Id: <20240709102512.31212-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709102512.31212-1-james.clark@linaro.org>
References: <20240709102512.31212-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My new address is james.clark@linaro.org

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .mailmap    | 1 +
 MAINTAINERS | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index a6c619e22efc..9313134efe32 100644
--- a/.mailmap
+++ b/.mailmap
@@ -260,6 +260,7 @@ Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@motorola.com>
 Jakub Kicinski <kuba@kernel.org> <jakub.kicinski@netronome.com>
 James Bottomley <jejb@mulgrave.(none)>
 James Bottomley <jejb@titanic.il.steeleye.com>
+James Clark <james.clark@linaro.org> <james.clark@arm.com>
 James E Wilson <wilson@specifix.com>
 James Hogan <jhogan@kernel.org> <james@albanarts.com>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index da5352dbd4f3..87949d7546d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2157,7 +2157,7 @@ N:	digicolor
 ARM/CORESIGHT FRAMEWORK AND DRIVERS
 M:	Suzuki K Poulose <suzuki.poulose@arm.com>
 R:	Mike Leach <mike.leach@linaro.org>
-R:	James Clark <james.clark@arm.com>
+R:	James Clark <james.clark@linaro.org>
 L:	coresight@lists.linaro.org (moderated for non-subscribers)
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
@@ -17587,7 +17587,7 @@ F:	tools/perf/
 PERFORMANCE EVENTS TOOLING ARM64
 R:	John Garry <john.g.garry@oracle.com>
 R:	Will Deacon <will@kernel.org>
-R:	James Clark <james.clark@arm.com>
+R:	James Clark <james.clark@linaro.org>
 R:	Mike Leach <mike.leach@linaro.org>
 R:	Leo Yan <leo.yan@linux.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.34.1


