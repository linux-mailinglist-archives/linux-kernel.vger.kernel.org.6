Return-Path: <linux-kernel+bounces-200420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF278FAFD2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D60E1C21F8B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1979E142640;
	Tue,  4 Jun 2024 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awDF//VM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7F31420B7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496749; cv=none; b=NcZh+aHmNt02y7HxZHGd6G4Uii1cCQonjySAise7XFRtTiDcW2wXv3dHh44o5HhyRTo8bUYpHnWzy702Zq3KBzgVOURt0GFtw2mCC/sLxUB1XUAquUk800YDeVJ3ZR+2/I8ynA3vIZQDV/lWpoQ85XPhkSPaBMY1/Q4mgIhI7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496749; c=relaxed/simple;
	bh=+97KsIZt98CG2CLQQ+IHOpFd91SSXI25Tj7kdAO85dM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWjO2qqn1bIzrcoI2S4YIuLCzPRgFghFCYFeK5RFu/8hKK7LN3LsLf+9Td/OK6rVtGjohvmikaLS3CLyqtAd1tuDD2pmia4vSmH8Kqjsgq6ZxZAqxonlwWnX+v1eF1N3MD0aizNDkuuoZq294kG0cyNe0kWKwUj/jDnPF6ck2yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=awDF//VM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717496747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sjq+ocxMAUYVGusvI1ZuTtsck+6zljQvQ0oRVrUKm+k=;
	b=awDF//VMiy4s9jdNz9y9QFTSQJaVLOUbk70CWY/tmx5aVL4e+NSrUfk/CNfCvHdPfP16o3
	FR5ywzU9kD6P0NRRSq2e9e1M/oSl7154hWtkHoNtYHOE6sRTMGKOFuy6/M2tG0ySe8b0RZ
	2FiPY2ym87yM8QLpv5kxB7I9wBoWkZs=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-HE8GCU_UOMiG8Ir_fx7NPg-1; Tue, 04 Jun 2024 06:25:46 -0400
X-MC-Unique: HE8GCU_UOMiG8Ir_fx7NPg-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-df78acd5bbbso1576499276.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 03:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717496745; x=1718101545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjq+ocxMAUYVGusvI1ZuTtsck+6zljQvQ0oRVrUKm+k=;
        b=kG1jvCjaMmyJZysCyohyqwML6PCRwCfHqqfdoGDvie06rsx2JQnKj7KO3ohIRBLXpw
         QbA/azhEXGiQhWrdAdPgKW2loeKBTlEzx/nAeE+wl43Xz/UPnLVSr0//PswCM+H9FJeu
         rt/JDb6Jy85GMCcYLZg910pjUgcN3rQgl13tTdAJMQhn10d84M30X8w7wAshkD6gtbcB
         KJFdr1WWxTaWiWXFs/Cn0DHipOUIvDMKoxc9ii9Otu8Tz2kRO32Z8Lw8H3j2AAzsXbKj
         Y1o1ynCYN98jLxm8ZMXhGlsg0lTMaMhzApO1VXIGl37M05bAgLMuOJ7NnIaJxlt0WkET
         3zCA==
X-Forwarded-Encrypted: i=1; AJvYcCXcb9vPVNzYHJ91uiWeO17IHN0PwKW3FEuHKpk0OLp8afGVMx/fEDBnKMedi2OlVrjDHzD1sJsQ0nXqsDxnFDF7+zDvc372HTbVnaSG
X-Gm-Message-State: AOJu0YxWBah7FaQqn7umji+bpVwMCYWEAsdeIkc1QXdQIZlB9Rxamwoj
	Hb5g6FAiF0FsqQtQcUHnS2wU+EAI55ZLjTKTt1DL1mNsQcllDlTH2Azfml1X5yZQY14C1Y8tnoC
	Vsqz/zs7EWCIbQUiloXxsqVEY/ZycfwqYF29x5jcQmZrG/lYFD4j0dBnm7XNN
X-Received: by 2002:a25:6b4b:0:b0:dcf:f9bd:fe05 with SMTP id 3f1490d57ef6-dfa73d9d171mr10940053276.48.1717496745519;
        Tue, 04 Jun 2024 03:25:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzKks9sYQBB15/uyoqAU68Bp9AvizlHHt2LmvmToSGcHUC1wjK/6K1q3rNrZhfzQf3HfbZpg==
X-Received: by 2002:a25:6b4b:0:b0:dcf:f9bd:fe05 with SMTP id 3f1490d57ef6-dfa73d9d171mr10940043276.48.1717496745159;
        Tue, 04 Jun 2024 03:25:45 -0700 (PDT)
Received: from klayman.redhat.com (host-82-62-247-97.business.telecomitalia.it. [82.62.247.97])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff23c5ef2sm47985371cf.24.2024.06.04.03.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 03:25:44 -0700 (PDT)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND] Revert "fpga: disable KUnit test suites when module support is enabled"
Date: Tue,  4 Jun 2024 12:25:35 +0200
Message-ID: <20240604102536.59010-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit a3fad2e92c76587fe262a1a4a122045b29885354.

The core components of the subsystem no longer assume that low-level
modules register a driver for the parent device and rely on its owner
pointer to take the module's refcount. KUnit test suites can now be safely
re-enabled with loadable module support.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---

v2: reworked commit message
---
 drivers/fpga/tests/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/tests/Kconfig b/drivers/fpga/tests/Kconfig
index d4e55204c092..e4a64815f16d 100644
--- a/drivers/fpga/tests/Kconfig
+++ b/drivers/fpga/tests/Kconfig
@@ -1,6 +1,6 @@
 config FPGA_KUNIT_TESTS
-	bool "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
-	depends on FPGA=y && FPGA_REGION=y && FPGA_BRIDGE=y && KUNIT=y && MODULES=n
+	tristate "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
+	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT=y
 	default KUNIT_ALL_TESTS
         help
           This builds unit tests for the FPGA subsystem

base-commit: b7c0e1ecee403a43abc89eb3e75672b01ff2ece9
-- 
2.45.1


