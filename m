Return-Path: <linux-kernel+bounces-544098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4F7A4DD60
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D46189BEA2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15F420409F;
	Tue,  4 Mar 2025 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fK8j81U/"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813E62040A8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089629; cv=none; b=JEDxKYfSgm0BD5Nai8RR/QCEaNrIt4uPiMelhqNnfk7bleCwtSzB+TfuAN7isgyHvv5Nk5I0zvE6Gri8qisphLIUEHx4D5Rpq92ifQrRlCcJVWfShUCr6nbF5kXhknUyGvbsnfefXJhT4Oh8WGCBuW0hzf0sAfdfY2dLnl1/GdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089629; c=relaxed/simple;
	bh=HCTDVZLc27RfB3QlgUMKi3V9KsZa8/51pTH+CsMD1z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTJVKglsXkSrjS+FlZNch1arTPXWYRLhsrAik3TfLP2oBZ7MpIgNOvhQT8YEiwfETWtMfb4yYBi3pqWYiXJtr2LojBns2DIDvE0aNMzKmm+boBTu10NZ1Lde9h8ZMqt/riHx7eXDcdDkoL0Oo1Sv8mYvSTDEtn1WeCzLTjxqgmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fK8j81U/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so3347845f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 04:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741089626; x=1741694426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvHP2BboCGauKM0TvBqQfBu7j1TlN9OaRIMMc+Vl6gA=;
        b=fK8j81U/AqVoW3rzpXJB/UpVv5DYoj/KLcdLyK1ygu0/UQabkISqT/9m6i7qyqPJz3
         7oUabz5RzjkikGUz2zvGe+VqdFYdOgmbnp2yOZxVqDs1XcXiBhb3m0mqZfq8EwJCb7V6
         URwRkcMuarzaMtv1lbSIbb0WYjl51uh3NRE1p7ThUoRnaRG72Mg7tsXX3gdRQCX0ZT1D
         f0doM6A4mFj2m22xK8QoVD2Rdqwj5mc4GWAwl6OBLCWJ3zlW0PT0gkdh6jsdY7/SfZMm
         9dknLXRWEdcLBd2WSitSgp49uojifozEhMZ3Sr2JDaZfk4lQ6C2Xecgktq0Gv1q57cVV
         79MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089626; x=1741694426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvHP2BboCGauKM0TvBqQfBu7j1TlN9OaRIMMc+Vl6gA=;
        b=LgA1yEPSAclojFV0/ITvWmFy9vuUcmGFxk4kWyh7vouMnyq/8rJ576aVMPkpwxsRaj
         BlJaFsFqniQ0WFCmF+ra3/SW54pFSYNnYmjY5M8ViprxbPGIF98lfsjrXZcK0Ut0ThUF
         fGQndGkC3e35TZpuQodVX8wjiXED2h+/UKmk1OIAmhYPJZ0RE7lZptGLYoAGcryu1eAn
         tVdDp2VUABOMK19vj/bchQ/Eawi7Oi2UH2TA0JVenXyszX1Uu2UquK0aaPICUAVLql/P
         Oqir2bcCe/nPSp56HU8Ja/NUqgQ7KEJ9d4l9H/OcyZ8/mdmyD18BdCb4lEBNw4RqXmY5
         mCag==
X-Forwarded-Encrypted: i=1; AJvYcCUPHQCN3DwlfIp0LlrGY+6OWmPG9LGuhHoBqrNzgGGcBzsPPEoGRiMTeaeYWTfjlWYarWy8wnQW5a3jjeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Fg8uqx8SqXY5RWtBS7ODeNDeKDDpfU7/sigTTANGDXgv+Owb
	TE51ECtPA3q1mde94e6rDFlzC3xQ2lSXC0ZSexf5RxioNemvmeEFcubfnTlpfjE=
X-Gm-Gg: ASbGncspPElB1egTcmqN7e26y75G0g+neZZp9Onzre6p8rlRD7VVPpnO6h4qjSTNJbU
	xv1NikkuFjN1MddfWTmhlVIGik6MiBMcNHtXaWa6Ah+8dEQhO1ZUBhVmhqrHF/k/CYrzLbrrkIg
	7YjCEO1b1vfCTECTnk5bbLUaab8FwN0ky7yMRYZuRU1zptuT7/A8TWFjJBzZ6X9+Px5WPRh3fCz
	vY665PPOP3Z+wGRYvDvEziXTrEndMtnf2BPGb4Gq1/dpyJz58rfcd7fVrTDKJPrxPk11F2WiB+e
	2n1QUCLrbh2smWsm6pbo5sjUr8Dunprm
X-Google-Smtp-Source: AGHT+IELzkVFh9RITGThHEwxgYy+2Ld8GAacL3JsxhdPQ1ZeOzGuZugE0nk+z2RxPZrajYXuj5Csrw==
X-Received: by 2002:a05:6000:2101:b0:390:f750:40df with SMTP id ffacd0b85a97d-390f750412amr7616475f8f.34.1741089625766;
        Tue, 04 Mar 2025 04:00:25 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::688c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796517sm17247748f8f.5.2025.03.04.04.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 04:00:25 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	alex@ghiti.fr,
	Anup Patel <apatel@ventanamicro.com>,
	corbet@lwn.net
Subject: [PATCH v3 8/8] Documentation/kernel-parameters: Add riscv unaligned speed parameters
Date: Tue,  4 Mar 2025 13:00:23 +0100
Message-ID: <20250304120014.143628-18-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304120014.143628-10-ajones@ventanamicro.com>
References: <20250304120014.143628-10-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document riscv parameters used to select scalar and vector unaligned
access speeds.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec8..9e3c5fecfa52 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7477,6 +7477,22 @@
 			Note that genuine overcurrent events won't be
 			reported either.
 
+	unaligned_scalar_speed=
+			[RISCV]
+			Format: {slow | fast | unsupported}
+			Allow skipping scalar unaligned access speed tests. This
+			is useful for testing alternative code paths and to skip
+			the tests in environments where they run too slowly. All
+			CPUs must have the same scalar unaligned access speed.
+
+	unaligned_vector_speed=
+			[RISCV]
+			Format: {slow | fast | unsupported}
+			Allow skipping vector unaligned access speed tests. This
+			is useful for testing alternative code paths and to skip
+			the tests in environments where they run too slowly. All
+			CPUs must have the same vector unaligned access speed.
+
 	unknown_nmi_panic
 			[X86] Cause panic on unknown NMI.
 
-- 
2.48.1


