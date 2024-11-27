Return-Path: <linux-kernel+bounces-423275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAFE9DA547
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C877B25D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BF41957F8;
	Wed, 27 Nov 2024 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mrSuNVNh"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94E6194ACF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732701726; cv=none; b=CZNApaB9HxF3haVIUSkXCnUiL/iPJAFZ/UAO/iGRjI3OFtPlR97qsfFI7XpkdUV+b4aP5TrKeqvYUspjsg/2/T0k8YsesdcdZJJNx/XgFmqme7s6vdXuyHwis3wChKwYIrqMsFeOnmly8OuW2vbg+tLDttxsU1eKgB2e6S39dIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732701726; c=relaxed/simple;
	bh=NvSG3zelG+rR4cIjRHjFyNRBSUc2x1i3rn1BQtgcjyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ALFrieVQcNGvFrLuSGyAQ7onOpOS7SS9TokJMY9qmVcvkAnNIEA+9mVdRe/mHjsfK7QO6BUyiB7hcbrq9Z/qBrlqiequtSGaHTlL+zIr6xuVOW4hkJlMEJM5x60TNi369j/EX3up7ki26EWEsNwJcEgIsCSJ00xXm9137fMdnd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mrSuNVNh; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53df30a5ff2so76164e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732701723; x=1733306523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LA9dViqKYqwFBgszUeA0NVjaCyBCvEgaySoNXwjG8Lo=;
        b=mrSuNVNhmn0c5FdzCjQhrrHIHUpYVWjOv57R+MFzboYKh2+2H7d7hTbnvekqgRIfi4
         rpd6AYkydicIKGOWZY+0+5q8pAVo30CsiE7DAXBl2dkERIuBD1S5+9Y1D3FdTuYF14lR
         KB/rouFx1Wr6u8uM0HKJ2Atbefe22BSZsLY1C7+SYfYBYVLIOb/SSsID5rLFEDOUZ513
         mAt6Oxxu5BbLZrmZU7X5OqVT6FxqKRQiMf5aCJDkWDoaxsKoqfSUpEB2bMqeTjKKSzOU
         V5Ox+nYnyqm0PEbAFovLmysE4ooXnDVAtDNvUaUDlOFSwPjCTpJAnVuvB0NaPtCxewV5
         oJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732701723; x=1733306523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LA9dViqKYqwFBgszUeA0NVjaCyBCvEgaySoNXwjG8Lo=;
        b=HBvCiSGFY1Jj4cPGjtM+Z50baykP1q7PfcP/qUNzniGfRzkLTNNv4hAgt7U3BwzwSE
         aXYVzHfBwnYm95VYFORpm97kv/sb5u4XEZplQK1yAfSA3jmZQsbqxs6/sKo8BVnm/81Q
         POLucNtGCncA0ZDeqgiboHjX3YNKJVhnY/l238hAd5K1G359X9/3nli9Vl40YYc93M8G
         If70JZfq/oicz2bmUmcZvX0uRvJT63Pz1CuermuldzB1ea1FIvynFsCDV0HUDzpWTMVR
         Tfr7vql75P1o5KtwHq+DqjK3er1RhCv/Bn37RSdvgbxEGHa9gcOtYs2DbyO1LxOA4Yp0
         9grw==
X-Forwarded-Encrypted: i=1; AJvYcCWprHutBWgt93V9ArQgmmSuuWOx5g5vYn5YHsu1X6pEp4TZzx+5R3ilSaqEyG6dckVL6fu0DKX69tilCb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwePXZAfb+w+QsqZbWbw/k666WAP9xn16d1v1M4uuRPsK8CMMO8
	OM2cJY6kdfeIEjAdcwnEEu1CbjL0/5YhEVoFnlo48BlowXqWAO7K6U6VgaS1S+g=
X-Gm-Gg: ASbGncvBQpiO8T27saqxBCEIXof3lVUZqSez8z5bh3lJ+SVc6tN0hGbv1cdZC5ja2A1
	xVSqr92gXTWRUbVuX5B3alycbBLsoA7ohwFny5XbV6znhGXM3x5DXTYMXEedBGO0qB6EV3avcth
	75HVWaEwfJGptpmr3OpuClhEF7CNCP1GjL23vX3uD/zcigNIkx8YJn79iGxNiuLpiWmu7Aql0gV
	HBPqgYpkzlhQuuoVS1lz2+ygKG+9YC1Ze0QXkQFKaOyeHBd5g==
X-Google-Smtp-Source: AGHT+IHr6cIPtse8uoTubAv1bGLQ5YJFJMlo8fFp5uzleSsgFVzX7cUspnX76HmoEaHTdGlhoc+IPQ==
X-Received: by 2002:a05:6512:b9d:b0:53d:d3cb:d90b with SMTP id 2adb3069b0e04-53df0117178mr1668132e87.47.1732701722968;
        Wed, 27 Nov 2024 02:02:02 -0800 (PST)
Received: from pop-os.. ([145.224.90.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa547ffb152sm421887466b.62.2024.11.27.02.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 02:02:02 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: maz@kernel.org,
	kvmarm@lists.linux.dev,
	oliver.upton@linux.dev,
	suzuki.poulose@arm.com,
	coresight@lists.linaro.org
Cc: James Clark <james.clark@arm.com>,
	Mark Brown <broonie@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Shiqi Liu <shiqiliu@hust.edu.cn>,
	Raghavendra Rao Ananta <rananta@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/8] arm64/sysreg: Add a comment that the sysreg file should be sorted
Date: Wed, 27 Nov 2024 10:01:20 +0000
Message-Id: <20241127100130.1162639-4-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127100130.1162639-1-james.clark@linaro.org>
References: <20241127100130.1162639-1-james.clark@linaro.org>
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


