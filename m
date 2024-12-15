Return-Path: <linux-kernel+bounces-445782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 921A89F1B85
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4196188ECCE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC19F513;
	Sat, 14 Dec 2024 00:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NbMgb8we"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2D0D51C
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 00:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137588; cv=none; b=Do+6pPVR9ijyA2fcWszAnPhDl3irxVQjlQdGzGBS7eRF2QKhXjSIgWWv2zUdMcIpHQdRzPd9w3a9D53J+3uyXnHuI+CsF3wu2HfJAqcdBXxBjqJbCZlGhXAicSWTV512hGUBbSIdCc9mfKzP/CeElKFWAeyK3kFGONtFqgl5wYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137588; c=relaxed/simple;
	bh=xkqZWtIFPlPp7kCQwHwtJW9768dMKK1yBmnprDLCFFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F0hqVkVYRBUWlIxB9+m/uzmSWbOC7B+AKo+7x/PmMrsUj/VcIHHv2+JyF035UviQBT9gtsoDB8dFmvtzrT1VKDcRkoSid+JAFF5EVGax20o1zWOm5XGg8leBEtkj3fqGOhlSdTZFcexIT6qhB4uAFygxz72gccp1YtsROsJX9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NbMgb8we; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef6c56032eso1529063a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734137586; x=1734742386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3K5RBtg+xGFXHj6YDf/Bcn02yaBD+GLsVm3JTeRYXpg=;
        b=NbMgb8weh5IKLYaz5e3YY6UHnxB1KMHCfYCYLLwBZpZS5vBVUkP83v0GZpehyueHbm
         /pf1lILGeQbaQEXnlNu7g4sj04Xpah3YMYiFhi7mSilij7hqAnXLZ42GUoU2P822ImYR
         DYRRi6M9kM9TQiOvmC1G5sw2hnnrTUTCNTb68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734137586; x=1734742386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3K5RBtg+xGFXHj6YDf/Bcn02yaBD+GLsVm3JTeRYXpg=;
        b=Y9HWsHT0KVDQZTqwNfG7UyHJpbhVVyPLkoAAxmyEx//FC643Y9BJOqkodfnDhj39O6
         S2ddRoGelWOZd3faGbtBykPa8xCD0t+VEJ9m7RMaxUYXAWjLEwVssXkYzv1WDLJS/D0U
         PPcT4MpDfYYlHDTcElxBBF/H6eUlY2N2R6QW5cD2PAPk4lRNpY3YWB7AXLo/6FjuSIZ+
         hBEmkKekRdwvSL4KOJLaLUuQf50Zja5gNpGIVpm748qv1UeSWhDgjF/Tc/q96MmJ8Wvy
         RZ6EiiFAjtUJi2qbzFXMUj93KHJ1jNky3Y7t8ri8B0eMlKH3uhTGWnWEVOr7o776aKwo
         G7lw==
X-Forwarded-Encrypted: i=1; AJvYcCWINNAy2vORiCh3e3Kp6SWK64UenpzhsvYcYvrRH5fZLn8+Eatx645mLxSJJDhKDQGerUVIi4/EsFK4S1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrvgoX94kcwPZ4KllBeRR/qRwwVLISirVvtenRTuaiGu5ChIPh
	z46Gcd+kHXfZhTBe7YEXYifW4wkwFkcQgSXzRvZbJowWfT+GYLgyc4ln4e+U9A==
X-Gm-Gg: ASbGncuF8HrM5/sAsAoTqmFBc6lxJvpor2D9XWAym8LSuoGlXHx0k8Trdvemn72pLA1
	yw2QW6FY+lnMO43b3Aj8B/9l9BMobXpziJ7HJOX0cR5nbwk8i4SA5ecsz+JK19IE5t9N/FVCQ3/
	qU0cbpXwxHI7zrtIDobWtlvY+qcH0rT1bg8rd7/yYeWVI8mCTfHzyXIbvLQQZF97SOymTm7T7xJ
	xKwT2oJUzMveLu/fk7eWI5HF/ldYSFRHWLK1hm39UT85892hCQoifJi+DpSDdRbS6ztXwuL/Bka
X-Google-Smtp-Source: AGHT+IE2YrqkKpATv2ql0bO6AIUnbqRYssgrXj6tpnlBoXs+JhE+ngG5QFI1yRxn2LJsxV5LcLo/Nw==
X-Received: by 2002:a17:90b:4c0e:b0:2ee:dcf6:1c77 with SMTP id 98e67ed59e1d1-2f28fd66bbdmr7577820a91.16.1734137586549;
        Fri, 13 Dec 2024 16:53:06 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:ae86:44a5:253c:f9bf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e186sm3788270a91.41.2024.12.13.16.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 16:53:06 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-msm@vger.kernel.org,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Julius Werner <jwerner@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	Roxana Bradescu <roxabee@google.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	bjorn.andersson@oss.qualcomm.com,
	Douglas Anderson <dianders@chromium.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	James Morse <james.morse@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] arm64: errata: Rework Spectre BHB mitigations to not assume "safe"
Date: Fri, 13 Dec 2024 16:52:01 -0800
Message-ID: <20241214005248.198803-1-dianders@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Recently I realized that a device with some Qualcomm Kryo 4xx cores
reported in `lscpu` that it was _not_ vulnerable to Spectre BHB. This
seemed unlikely to me.

I wrote up a patch series to attempt (with a lot of guesswork) to add
Qualcomm cores to the tables governing how the Spectre BHB mitigation
worked.

In response to that patch, Will suggested that I flip the mitigation
on its head and assume things are vulnerable until we find that
they're not [1]. This patch series _attempts_ to accomplish that.

I've tried to do the right thing for ARM Cores and for Qualcomm
cores. I _think_ most of this likely to be right except that I don't
have a lot of confidence in the "k" value for the Kryo 4XX cores.

This patch series is _expected_ to cause some WARN splats for other
ARM CPU variants. Sorry, but there's no way to make this "default
assume affected" but not cause problems for ARM CPU variants that
weren't previously listed. I hope the WARNing here is better than just
slowing your cores down pointlessly or assuming the incorrect
mitigation. If your core is mitigated by "loop" hopefully it's easy to
just add your core to the list. If your core it mitigated by
"firmware" you can add your core to the list and get rid of the WARN
splat and you'll be left with the kernel reporting you as vulnerable
until you can get a FW update out.

In case it's not obvious, v2 of this patch series is pretty different
than v1 because it flips the logic on its head. Some of the patches
carried over, though.

As a last caveat, I'll note that I am certainly no expert on
Spectre. Mostly I ended up here running `lscpu` on a device and
noticing that it thought that it wasn't affected by Spectre v2 when I
thought it was.

Link to prev versions:
v1: https://lore.kernel.org/r/20241209174430.2904353-1-dianders@chromium.org/

[1] https://lore.kernel.org/r/20241211213410.GB17486@willie-the-truck

Changes in v2:
- arm64: errata: Assume that unknown CPUs _are_ vulnerable to Spectre BHB
- arm64: errata: Add KRYO 2XX/3XX/4XX silver cores to Spectre safe list
- Slight change to wording and notes of KRYO_4XX_GOLD patch
- Rebased / reworded QCOM_KRYO_2XX_GOLD patch
- Rebased / reworded QCOM_KRYO_3XX_GOLD patch

Douglas Anderson (6):
  arm64: errata: Assume that unknown CPUs _are_ vulnerable to Spectre
    BHB
  arm64: errata: Add KRYO 2XX/3XX/4XX silver cores to Spectre safe list
  arm64: errata: Add QCOM_KRYO_4XX_GOLD to the spectre_bhb_k24_list
  arm64: errata: Add QCOM_KRYO_2XX_GOLD to the
    spectre_bhb_firmware_mitigated_list
  arm64: cputype: Add QCOM_CPU_PART_KRYO_3XX_GOLD
  arm64: errata: Add QCOM_KRYO_3XX_GOLD to the
    spectre_bhb_firmware_mitigated_list

 arch/arm64/include/asm/cputype.h |  2 ++
 arch/arm64/kernel/proton-pack.c  | 52 +++++++++++++++++++++++++++-----
 2 files changed, 46 insertions(+), 8 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


