Return-Path: <linux-kernel+bounces-520273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46752A3A7D8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909073A9D04
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E001ACEDA;
	Tue, 18 Feb 2025 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6efqgq3"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289CB1E833E;
	Tue, 18 Feb 2025 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907699; cv=none; b=QCY7KD/LRikE9Hr/nqJip5KfGpUcc9zOQCVT7iubn9YdABZOOy5YIjFDOyIYpX0WA+keZSrTkvJzt6FXPNbGfC2Behe6FffkTUX1x3VdtFR/xhZW9iuPIet+taiAiMi0kpwsmGp/Lr9WKRrwsXcxbHJ8LbAVvMgWemi3lk7AaQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907699; c=relaxed/simple;
	bh=hFLiI87cr3igWP05XfYyNhOKbMvc8Cx4sch49Pa1HBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozeog3J48RVvJBvzfMbhL+GJi7i/CFgQHsJPhd6rEj3hxk3978l/fFCj8ZRGMll4Q2LKcj+PlFuPkQnPhoV8UG5Hp8MX10iI40kVB0of58fdHMnaPzhwhbu6dLMsPxgQmtcpgaImu23PIqfu3uSgeCOpJU9ysibzPsNo2ASXTiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6efqgq3; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-868f18a629bso1602261241.2;
        Tue, 18 Feb 2025 11:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739907697; x=1740512497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aum1vTGQH2NNijCedl5+ZhVVjTUbGCmvDvbVv0IZuTI=;
        b=L6efqgq3zVXlS3cqS9nC+mGMgNyk3cOF+kPoVnhvGq3JiBGsxTtrGu/0TUA7H4HN9q
         D0wKKZybsRV4r2u4bdEaV2+rzJKTx9MhOxOrjLsuw2R3OFZf9H4qOAEGF2WSmIfzr4Fp
         tQ2pktDRr+Vu50FfcDdDUGvDfLsIbvlybQmtad9SSq7DFML0NESbkF2J3EfrtGAOc4MZ
         FDnsoe5tot0WuERwkGyM8aa5IbQN1qHV/rxcB1MdOD0DgItkbBfMu60DYTbH6SNFwIpb
         zcV379mDziKD67zOgsjDlUb5uB4JSf7d8t8+cDL2mMuneUoNbug/3WlYb5AFCpgo4e9n
         BEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907697; x=1740512497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aum1vTGQH2NNijCedl5+ZhVVjTUbGCmvDvbVv0IZuTI=;
        b=j8j4A1uQ5w+UOFJ1JQlGETvoPPS/U6rOfz4U5avtV6OCQ0CSM5pWjJhkz36eEhOlPh
         IENuTiWK8dfxNQS4LYbJEsxLbbJUn9psMP1F040OjlyWvnP8B1iE6oR1UoUspei21SVB
         /33f2ctaR4VeR2z4IoDow+bE69bU1lzEefG843xSCip5Sd6ob4byLmezOf5H+vL9IJy7
         9r1Hx4MPcyhbBWvuu603bx/+aZh9gslW+CJ88dkStjnPim1sButzommydqiqXFQcDMcS
         0X+fjo9kz8x8uBD2Kwbvm94nAz3lfx5A0wXf7E0KVx+qGE2JL8CWHcpgJKYfF1vPtlHk
         J8VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGivtej6z2yihgsqtOiHEWR3t6+YFRfJue2jhr55Kp7+ya+tzATh7RiaexcD4/mlVEYFhKpdZt0Tpjqqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPcEl9MKhk2XCVc0qa2Q5VVSXfiMsPUNXlsLmsdSQOczx15G3P
	94xQR/xuTYXaeailaDLQd8I9XrTsvOfBozmx+k5+M4KtQutiNni4
X-Gm-Gg: ASbGncsCp2WqRMYLeoLfNYqijS+y1q60t5vsfnmONilOXLXsrANZozyi9yirZNhzgA8
	xx9r+Z24rncuh6TMnquIgoFUUgAfL6VDkzMXtk6pGb5EodfPKzIoO6P8JSC69d/8AE2JA5bITch
	/JfBLt6xuIxI/umOaYgGWkyTIHHi5hOIupHRYR8UFwsoREGNQx21DbWcnXcuMioX8Pd54QdXKUu
	DMLSdD+5xr1fr1ZbXlOr8aTIRpXIawPA9DsgZkpOkFEvpDu/zuBKwrJ4E9wLaoAR12Rw2ckCnCJ
	lj540mvg8j0A1vaFwmcqXV0=
X-Google-Smtp-Source: AGHT+IGsalX4IFdNygtfG+gMS3LxKf2sFOlQxqavWEULQxH1EGNCxQNVKihNNAw1WesaVyWYqLl83g==
X-Received: by 2002:a05:6102:f12:b0:4bb:e14a:944b with SMTP id ada2fe7eead31-4bd3fdfaec5mr8100018137.20.1739907697120;
        Tue, 18 Feb 2025 11:41:37 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bc68dd766bsm2305214137.20.2025.02.18.11.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:41:36 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Kurt Borja <kuurtb@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prasanth Ksr <prasanth.ksr@dell.com>,
	Dell.Client.Kernel@dell.com
Subject: [PATCH 1/4] platform/x86: dell: dell-wmi-sysman: Use *-y instead of *-objs in Makefile
Date: Tue, 18 Feb 2025 14:41:08 -0500
Message-ID: <20250218194113.26589-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218194113.26589-1-kuurtb@gmail.com>
References: <20250218194113.26589-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `objs` suffix is reserved for user-space tools. Use the `y` suffix
instead, which is usually used for kernel drivers.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/dell-wmi-sysman/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/Makefile b/drivers/platform/x86/dell/dell-wmi-sysman/Makefile
index 825fb2fbeea8..0a6df449e222 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/Makefile
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_DELL_WMI_SYSMAN)  += dell-wmi-sysman.o
-dell-wmi-sysman-objs := 	sysman.o		\
+dell-wmi-sysman-y :=		sysman.o		\
 				enum-attributes.o	\
 				int-attributes.o	\
 				string-attributes.o	\
-- 
2.48.1


