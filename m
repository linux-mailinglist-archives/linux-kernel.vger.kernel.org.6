Return-Path: <linux-kernel+bounces-405654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE37B9C56BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFF9AB3C967
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8E6227B9A;
	Tue, 12 Nov 2024 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IZYtA2Pq"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1CB226B97
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407858; cv=none; b=VmdtMa9Qc8cWZlGO6plSPaqfqFACZhJXyEgJOUZzuMypeRm9xzyuPeoC9Afocf4FcjeungZnATHRdv3KaBnUle3r4L3ixDZvaXzGzYlqzrsyHDcJ43Qt7Hj2zSPmT9aPmxKkl3L4JgWWGWoFwf2+vheqPgpHIg4hnM62FLDn0Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407858; c=relaxed/simple;
	bh=NvSG3zelG+rR4cIjRHjFyNRBSUc2x1i3rn1BQtgcjyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dksI7pPh8e6uqdUNZqbXhyAvqZYzL+E+19M2rI2PIAGdzfw2ntsRPXiLXKxcx+OYuiPkUI2CbbX+mF335ji7MSuqJ/S34CqOYFoHdZ2QYek8z6F4BRHqsC1h4F6CEY7GXvakvtwNhMWE4mtEEcXSd/UQefttf9o1YdyRDQszCE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IZYtA2Pq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43158625112so48328065e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731407855; x=1732012655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LA9dViqKYqwFBgszUeA0NVjaCyBCvEgaySoNXwjG8Lo=;
        b=IZYtA2Pq0P24d0BmDBg4H3U15WmHtXBXytL7bto1x1bEIVF1M0SQWDhQJ5YzTMcg1u
         R1Qx2mesde4OK111SERbAz2G/8XiSLRNThy6WHBsjpl3mLavrs+zfOfWmUpdp6IYq714
         dHd4OQQjIQ1hb2aNXac7Qip+agoFnNWIMPNfapSIHGUuvonw5TXo4zEk8kz7GSo2PGgk
         2FongwhiAaaKSduLBTrQH/3mOdCSlyCc3yWVM3lKPGE/B7POwbTxlhVLmDRRxuOsZ/cI
         W3a1FmZK1vGJx9OT0NYPHVIlW1ZPpXLdHF5ps3Lj0OCST8yzKC8IB01sWNdgb6MvIij6
         GopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731407855; x=1732012655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LA9dViqKYqwFBgszUeA0NVjaCyBCvEgaySoNXwjG8Lo=;
        b=vh5vVdN46e/lay3HIc5bvdOZENh1+5RBKPbFmCY/JClRzyaWwmnuyj/h+eVDx/OeE8
         BMbk7UfQ3CaobHm4X93NN5CokesD08lNQAiYcLzMzIb8n+biM01mY2jeWXo687DMO0nT
         ASrv4mAa+y0i9ONU1ohjljXtXuokD2KHQSUHNVyNj4LGta5JJT4PpXUs/adOaGmyXfjQ
         /Sfg2m71S5cV1eU3K3JAXO0qkPDXQaTAhL+ZAyiX04eIzKE80buqBrrtPrEVueI1OJt1
         MjgWCxPh80242sN0hWEY2U5Ef1k8gSOBXin0LMxnzMEHz1tgTumTR9D3Mroi57dahRS1
         8KyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHXtKIu1YmVkI7zYg7I5F8FeWM/KbGDSEHiiC9b7yQ84FsPrtXkHi1IuvVtUGDVz6zVJpEtP3CtWBFn9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEQ8cJ3JEpgEJGUBWIoDXjL3nv1rjbEXi6fyuzlwNFIq+eEHy8
	v4m6+zyiwfbowDY9PoKa0azWXuDNA6UMYB+DsW5q7ZAQ5OB5QoD2L1sYoCy5ybY=
X-Google-Smtp-Source: AGHT+IEJtm4ivV1htjbZWKRvdvQU4deS33CMMl/XnYQuXPgkmNTFagTge7vJGgMMOIhXkLqCtkpxGQ==
X-Received: by 2002:a05:600c:1e03:b0:431:518a:683b with SMTP id 5b1f17b1804b1-432b7509b0emr146282075e9.18.1731407854903;
        Tue, 12 Nov 2024 02:37:34 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432bbf436ffsm142270955e9.44.2024.11.12.02.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 02:37:34 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: suzuki.poulose@arm.com,
	oliver.upton@linux.dev,
	coresight@lists.linaro.org,
	kvmarm@lists.linux.dev
Cc: James Clark <james.clark@arm.com>,
	Mark Brown <broonie@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Fuad Tabba <tabba@google.com>,
	James Morse <james.morse@arm.com>,
	Shiqi Liu <shiqiliu@hust.edu.cn>,
	Raghavendra Rao Ananta <rananta@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 01/12] arm64/sysreg: Add a comment that the sysreg file should be sorted
Date: Tue, 12 Nov 2024 10:37:00 +0000
Message-Id: <20241112103717.589952-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112103717.589952-1-james.clark@linaro.org>
References: <20241112103717.589952-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

There are a few entries particularly at the end of the file that aren't
in order. To avoid confusion, add a comment that might help new entries
to be added in the right place.

Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/tools/sysreg | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index ed3bf6a0f5c1..a26c0da0c42d 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -48,6 +48,8 @@
 # feature that introduces them (eg, FEAT_LS64_ACCDATA introduces enumeration
 # item ACCDATA) though it may be more taseful to do something else.
 
+# Please try to keep entries in this file sorted by sysreg encoding.
+
 Sysreg	OSDTRRX_EL1	2	0	0	0	2
 Res0	63:32
 Field	31:0	DTRRX
-- 
2.34.1


