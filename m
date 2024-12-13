Return-Path: <linux-kernel+bounces-444093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CFD9F00A9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 01:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3528285289
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B09748F;
	Fri, 13 Dec 2024 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="INmCwDsw"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE3763D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734048588; cv=none; b=Zph5Qd9enT+gXsSEKqtk3ac+5ZKPK+2C+AqHStyoUotIIl7pY17z0pUp8Vphvh5++6zAdUoVJtl2oMO4/UBkgeretDrYOmkLk+3KnJSItncRKIBfFbcGDWiaTqR0pxWXanMJlNNnu3YAM0Q2Srcb+8XX6gE/wiKXw/mAN7FNJDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734048588; c=relaxed/simple;
	bh=LXH6AuqC9k9zN30pZ34dwBYnTR3yc/roklRdUANPHtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nlNC1aIqx4RohcSlcugBiBEIhicqJpJl6CpKT2nT6C3eOawLBcL1xpSD8a9wW8lgOO2HxqlXYM3V3axqb6TylCaAoi6rS0j5Acycb0p1D37bQWy0zz2cYo5Tr5P+6ki9nTl0NdB+qfBBLa7X9ZJIf2vfS7fjKdEQF81N7LiG2vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=INmCwDsw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7265c18d79bso1348649b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734048585; x=1734653385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKpycrpAm/2Z4OIP+dAI4fHeHhUuh023l0NFrl2ztmQ=;
        b=INmCwDswu4DOFcs9Dn8ydxjau7MZOLt8BSz5iuU1QDpspXrmasVARM5L0eBs2EtY3G
         3wKeXwe9jXse1xeAhJeANlW82GISWd6qUrb/luUeAgkFL+NruWqaeAvfJM6zCh3CFXWy
         KX29N7/1swRX7s8PE+8gvZth/RTiTNnToSMIyucmRoAIUqrNtXpqiKAq7B+9F5DzAvqS
         qnaz8PT4y3L5mr3MpmcbpPiwsh4IxVK90Z1VvLkJGieVN/vaoV5rSYCiUW290wfvMXAv
         QlpdShz2YyUJQQA/U9s2PGdI6XFU7Bh6UraWwJQwLheRoX1KLuJug88YsxNHWCalftTx
         SWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734048585; x=1734653385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKpycrpAm/2Z4OIP+dAI4fHeHhUuh023l0NFrl2ztmQ=;
        b=Mm06A1jQEz7Defb2CiWlp4Air7WRW4+uLttkENtYNSVWDHZ7xCzUuqLfvk5RmCA1WZ
         pT8dfKRZW0/bRJpTS2dXJe2DUngJJqG0jBwLqFHMB1T4KAtQxiZbMZ2DM6AA/ptqjeKI
         lNB2qEB6JhnXnrtaphKOhKDmC1V+BK4YuEq2T5CNH+Ri2dlV4D1WOVmaut5sIaPqMjqI
         IkeWcFDo5zbod/fyj9Ofv8fAuYQLjZcPlPr34YhW5oyAnYdpAE2hYVE4WHjItGPbW/bU
         EzJKFPDat7mCyNbeDhzgUs2+ovOirQ+UCq+rJ3QUu48uoW7jeSxMN5lazKRYIfPLTNlb
         eHuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPzlTP0pNWeI0KL2OpSP+3hHuj0w5bjIr4LcLV/xZxAsxP+jwGSholte4I6wT3Mq6zKR7lyV9V3eJBqWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjyRY8lqckqlM+i2TXSXbXWSfedSB35fPobAT8ejFNcHXiQko3
	83X1NIyS8FdZuSKygBoQ7SwA5+P7rU+3KsqLfwR3gk37NtDYqD9UBDSHVzM2LZfR5kMz9Ao3kJA
	Q
X-Gm-Gg: ASbGncvURjs34BmxMY8FCe2TJeIOCCUaY5Jjz+hgsn0eM0FppV+QsKLm1lAZos3jlsy
	0HAGum8tYqBGFMFQN7gJs6Jq2n/+P4+6gFK+q7aPVMH47aI9Vkc2CEGhwjk2o+q+nb72Jmpxgq9
	iG5CS0NovGv3z+SNp6DRPEvnKypbRzsOtWphpEksSkLc00oZae1Zx7jJlmsI6G6zaBIgzPC/Bvj
	WyzZcXz/+qYHsMnSQ+IlGIa6qnTQfeLEM7L7zJafAd8l5WgeY6edJkiddn+OR196jSb9Q==
X-Google-Smtp-Source: AGHT+IE5j/5Y5d7tWNO+kILk+qFgEl6eIe6LD4J0VHaW3xwow9/AiwKc2ul435G3UAea8bcO75mrFg==
X-Received: by 2002:a05:6a20:244f:b0:1e0:d4f4:5b39 with SMTP id adf61e73a8af0-1e1dfd9433fmr735097637.24.1734048585651;
        Thu, 12 Dec 2024 16:09:45 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f0a0779dsm7441455b3a.154.2024.12.12.16.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 16:09:45 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 12 Dec 2024 16:09:34 -0800
Subject: [PATCH v2 3/3] drivers/perf: riscv: Do not allow invalid raw event
 config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-pmu_event_fixes_v2-v2-3-813e8a4f5962@rivosinc.com>
References: <20241212-pmu_event_fixes_v2-v2-0-813e8a4f5962@rivosinc.com>
In-Reply-To: <20241212-pmu_event_fixes_v2-v2-0-813e8a4f5962@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Atish Patra <atishp@atishpatra.org>, 
 Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

The SBI specification allows only lower 48bits of hpmeventX to be
configured via SBI PMU. Currently, the driver masks of the higher
bits but doesn't return an error. This will lead to an additional
SBI call for config matching which should return for an invalid
event error in most of the cases.

However, if a platform(i.e Rocket and sifive cores) implements a
bitmap of all bits in the event encoding this will lead to an
incorrect event being programmed leading to user confusion.

Report the error to the user if higher bits are set during the
event mapping itself to avoid the confusion and save an additional
SBI call.

Suggested-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index da3651d32906..194c153e5d71 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -536,8 +536,11 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 
 		switch (config >> 62) {
 		case 0:
-			ret = RISCV_PMU_RAW_EVENT_IDX;
-			*econfig = config & RISCV_PMU_RAW_EVENT_MASK;
+			/* Return error any bits [48-63] is set  as it is not allowed by the spec */
+			if (!(config & ~RISCV_PMU_RAW_EVENT_MASK)) {
+				*econfig = config & RISCV_PMU_RAW_EVENT_MASK;
+				ret = RISCV_PMU_RAW_EVENT_IDX;
+			}
 			break;
 		case 2:
 			ret = (config & 0xFFFF) | (SBI_PMU_EVENT_TYPE_FW << 16);

-- 
2.34.1


