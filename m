Return-Path: <linux-kernel+bounces-341574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7B79881DE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B381C2205F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5111BA886;
	Fri, 27 Sep 2024 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LM/7dnP6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7792118757C
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430741; cv=none; b=QnKhE8N91CfZhxkxtwjvROu+QwMpc6+E0nJ6a9n5pNyy88gOUgDTdgBapA3YOMw3waq/AJsq3pqrp8UPk4TLDXTF8N4t8nX2WCLRCbW8oKz0f22e2P80NJjyLIMnAAK064GfdsabCvX605AVvMiaAmI/Hgw2J3VW6T+AnTZP/oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430741; c=relaxed/simple;
	bh=J84a+GUC53/DXU7se4jcQYTHK8dHcObTxeHmGxs+G3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ukI2Ip7EdZYaIDbH5x1TnqycVNzofUQxuFFiqOyjULXDeJcc/SeulrMj2CimxrWv6p9H+3IE1Gj9WmN/revVM3/dL8ubShPwKV+mOkghjDFu/CpPotA8BwUYwohf6yRkQKijIdaNCWJgZ/cY6BkTJTthbbOS7Z2qYfvzuP2NazM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LM/7dnP6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727430737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=376iBOeZUuX7OjmvgZ+CVlpPHnHLOYHzUjijev9CODQ=;
	b=LM/7dnP6D6GDzxNpQiNHw2faSmbd2znKIscpuYCEekcOqDCGtYXodIViDLgxpZ05BQoDSl
	qnGKF4hVHk8PmjfjRRpldMZ2CYST9Zc1wm6VG1IsYoWzwdY2jGDsUW6MQ7nTmxcB2RvfU0
	H5o+1vNlUd3AoP2qHgWfpx5M7AL3/Yk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-a441__hbP_eEfK3mZSSc7g-1; Fri, 27 Sep 2024 05:52:15 -0400
X-MC-Unique: a441__hbP_eEfK3mZSSc7g-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a9a71b17a3so343978785a.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 02:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727430735; x=1728035535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=376iBOeZUuX7OjmvgZ+CVlpPHnHLOYHzUjijev9CODQ=;
        b=fHoSkPP/gSL03oy5bJ0B+uZBebEAv3pz2li8qTaAwQ7e7s0DFqyOQ+ZKtcEPSUSIcC
         ihRC5exvI9He7OZcfdSfouCRF5OIA2CYp8MiI50KNpIZRTXHkmFrtJwzjsC5gosJ1BeO
         VSExtxq5tDsnyF1CMsJqTWL6TGfDL8F2s9PO1+f2SOInZq+Y+i1dmNYwfgM8C//yZkyB
         uvkhtlAzODdMT8iwapOtW7xT5PYSbJ7chGO0q1qVr8uShA9kM54BQ/eC3J2zmzAkJHHG
         zsTEfxAN8x+DXWZf4gakWrbor0DfAeKomVRncfJShLjxPQPHXYHLkFdgS9FWCj8fe1lw
         5ZhA==
X-Forwarded-Encrypted: i=1; AJvYcCVBmAK+jrf3dr5WEaBhFeRx/8KD/wWgyvMrTkEpyy81GCfzvsx2JwYcEtIpMNFKMF8GuDazv1mge6yO+6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIoNoBwXy6quo4iOsoSzxtf5kSjEVZuBXH/i1P0WY0iwmSXIts
	JoJ7FbieP9K2sN1thklOe5dT+jlpUnoviPUgts5ki1XiX794yjY38B6y0LhDmrVHmiCyUzWTo2i
	DejxNlVa9uP7SuUR/rfO8SWB2KifvwVg2icLV9xgAFmM6M7T5vmmCRqZQmvF8EA==
X-Received: by 2002:a05:620a:3196:b0:7a9:9ec7:63d1 with SMTP id af79cd13be357-7ae3782e3b3mr378552685a.18.1727430734994;
        Fri, 27 Sep 2024 02:52:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcRCGQ3J5pp0phB8xmBJPL/cN9jReho1pvo3oym0cfHErzgl2Eu/dJWBypCa1n5PpNPoUe3w==
X-Received: by 2002:a05:620a:3196:b0:7a9:9ec7:63d1 with SMTP id af79cd13be357-7ae3782e3b3mr378549485a.18.1727430734574;
        Fri, 27 Sep 2024 02:52:14 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377d5db7sm69557385a.28.2024.09.27.02.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 02:52:13 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Scott Wood <oss@buserror.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] powerpc: remove dead config options for MPC85xx platform support
Date: Fri, 27 Sep 2024 11:52:03 +0200
Message-ID: <20240927095203.392365-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 384e338a9187 ("powerpc: drop MPC8540_ADS and MPC8560_ADS platform
support") and commit b751ed04bc5e ("powerpc: drop MPC85xx_CDS platform
support") removes the platform support for MPC8540_ADS, MPC8560_ADS and
MPC85xx_CDS in the source tree, but misses to remove the config options in
the Kconfig file. Hence, these three config options are without any effect
since then.

Drop these three dead config options.

Fixes: 384e338a9187 ("powerpc: drop MPC8540_ADS and MPC8560_ADS platform support")
Fixes: b751ed04bc5e ("powerpc: drop MPC85xx_CDS platform support")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 arch/powerpc/platforms/85xx/Kconfig | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 9315a3b69d6d..604c1b4b6d45 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -40,27 +40,6 @@ config BSC9132_QDS
 	  and dual StarCore SC3850 DSP cores.
 	  Manufacturer : Freescale Semiconductor, Inc
 
-config MPC8540_ADS
-	bool "Freescale MPC8540 ADS"
-	select DEFAULT_UIMAGE
-	help
-	  This option enables support for the MPC 8540 ADS board
-
-config MPC8560_ADS
-	bool "Freescale MPC8560 ADS"
-	select DEFAULT_UIMAGE
-	select CPM2
-	help
-	  This option enables support for the MPC 8560 ADS board
-
-config MPC85xx_CDS
-	bool "Freescale MPC85xx CDS"
-	select DEFAULT_UIMAGE
-	select PPC_I8259
-	select HAVE_RAPIDIO
-	help
-	  This option enables support for the MPC85xx CDS board
-
 config MPC85xx_MDS
 	bool "Freescale MPC8568 MDS / MPC8569 MDS / P1021 MDS"
 	select DEFAULT_UIMAGE
-- 
2.46.1


