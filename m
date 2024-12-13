Return-Path: <linux-kernel+bounces-444090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B3E9F00A6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 01:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8E7188D141
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97287F9;
	Fri, 13 Dec 2024 00:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WKEZTuQX"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBC3621
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734048586; cv=none; b=pqkeE5QwI/OGAahgFYimyb5UvqJ/niG3qqfQws8zAk1tQY49ZuW8PhnDE4RRZz7pAJYl2Mb+izcvuJef2UoewKEvt5ZeMeBctYfneNP5hpXkan43EtG62LRI5HgRNWoOQkoKMZOmslDs6oBnIj+z5FJsXSTdRj+Hfatyo51Nckw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734048586; c=relaxed/simple;
	bh=nIJlzC382YOHVodShQWE+C5tJa1A3vr+GG/awlIU+XQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Kjp6aGzxUnmKaMtKH5wNvJX0aQxYmZwUJ8OleS0kkls6ji9SKCUP3mEsQhPudYdaPP7wuqISEDx1t6l+hsVwXzM3mxI4QH/Yuogd1zCTOisQZmal63wwXzN58AiCNX0al5FXrPSXjFHjFpii1HjY+LEPmonen1EgpdEd18c7BlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WKEZTuQX; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-728ec840a8aso1350984b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734048583; x=1734653383; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi3tuGJpo/rfMiWH0BQDI1m0iie42CjFIyvVnonkPTw=;
        b=WKEZTuQX4IsXtIMdNnP6J20Q/pu1IMalI+MiyDV9BrO9Kt5LqQ7D0PGaF81QJkKm6z
         5ImGOM8jFFrpvKPHY8dNcQH03hO8Os33+KdaOESgS39VLtb/6ad8GRleGzJWVQnKm4Lf
         Xw9vvFEDj76brk9vW+b/TAuZLvKGI6zSsrQXWvsmr5uDs2frxVplfO3PXFJ1GczcHVDA
         guiUJWaZpMMjjillQn6PCE1oD/sUSdHE6X1dQ/x5ygBBTFcIx1qE1wcY5Fl6ft9xni05
         vmraaEY4eEaKd1hFzn9PBAsm5YChEIZPeUJV4OUY8Wwwl5UQb4YGOV6x7Eb+YISHo4tR
         rTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734048583; x=1734653383;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pi3tuGJpo/rfMiWH0BQDI1m0iie42CjFIyvVnonkPTw=;
        b=YTjD0RaIXTXXaNe6LzbRXjNnsXmpScvTa6Y44ijVdZVDEVlwyP8k8pbMVllGHOVfSe
         9VUXERSrfQRAMOY5Fjxch8LLToa0TJ20o7wZoUWkKNJXeBtz7DMvoIOcVRMzmaJieyo+
         IgFXuGKJyJguy+OR1IVuRlq9PfFncGIc03XSkTOPyEEOnxU7QRY5WCOU/ruKFewfyBVz
         OgrFJT0oevZQnWarAjArqPXVDWAXGLTmdMk9jakwzb4wrlPx6HzB6qlR6Ibz7OtGVQX4
         2HeKLCk956xfAM9QE/cvm4zkKYCQ8YO+QUNe95MyA0p9ZMHcyw6d178/O950o8XG7txW
         igrA==
X-Forwarded-Encrypted: i=1; AJvYcCWy7nZVomoE/d6efHHkoPT/wcyEmE7Z4c9DnYMSFZQN408bJSo37g/fN99IWHTDPI3IYfUfqZxL/wq258o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwuBlsLdJhv1B7MnR+SetOIOVnaCqWUd1UYCVoft309IOOCi8w
	gAo/ot/6aJcZQc5GTDTnDSlOfMZ6aGGu+MdBX2pF8CDA4aUTWFd+JQp1MUH6+kFBl8rMEFsGi14
	K
X-Gm-Gg: ASbGncttCC4n6odkewwbmE/Jdfb3ms5urZKHqBkST477KtG7DPAVzoRWZoOuJVD/zLb
	SG+DalIHTLhgvylUYOoMs13hf/y8Y2ONERjt06TZ4MhAOw+5dwN/v8snT7WHLmXuTSP3y14s/00
	rbHFAn1IzamPeAIBbmWuOEx08KDkzt87Q2b4+RFdxt9xEyD6wtb4bp8vjdm1HwnHxUphGS3MIco
	S9NYntgHGLMei9xpZWG3u4QIE5UlfPUBcXB/lXrjz+gIb41DSI95M0DleSKjN+TXta7fw==
X-Google-Smtp-Source: AGHT+IHlKxnMQX6RMj7z9YA7s0otxhJXTIs1jwyScxFa+NZs2HrzWHf7CwoOpIR95MIDKYBY/7Lzrw==
X-Received: by 2002:a05:6a00:2d8d:b0:728:e25b:745 with SMTP id d2e1a72fcca58-7290c1b0f5amr802857b3a.12.1734048582736;
        Thu, 12 Dec 2024 16:09:42 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f0a0779dsm7441455b3a.154.2024.12.12.16.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 16:09:42 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v2 0/3] SBI PMU event related fixes
Date: Thu, 12 Dec 2024 16:09:31 -0800
Message-Id: <20241212-pmu_event_fixes_v2-v2-0-813e8a4f5962@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADt7W2cC/12NwQ7CIBBEf6XZsxhYaQye/A/TNC2sdg+FBirRN
 Py72Hjy+GbyZjZIFJkSXJoNImVOHHwFPDRgp8E/SLCrDChRK1QolvnZUya/9nd+UeozCnvS4zA
 apREdVHGJtHfVu3WVJ05riO/9I6tv+puT5n9OZCWkcKbFloyUZ7TXyDkk9vZowwxdKeUDiFoqj
 rQAAAA=
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Atish Patra <atishp@atishpatra.org>, 
 Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

Here are two minor improvement/fixes in the PMU event path. The first patch
was part of the series[1]. The 2nd patch was suggested during the series
review. 

While the series can only be merged once SBI v3.0 is frozen, these two
patches can be independent of SBI v3.0 and can be merged sooner. Hence, these
two patches are sent as a separate series.
 
[1] https://lore.kernel.org/kvm/20241119-pmu_event_info-v1-7-a4f9691421f8@rivosinc.com/T/#u

To: Paul Walmsley <paul.walmsley@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Atish Patra <atishp@atishpatra.org>
To: Anup Patel <anup@brainfault.org>
To: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
Changes in v2:
- Removed a drive-by fix from PATCH 1 and created a separate patch.
- Added fixes tag 
- Link to v1: https://lore.kernel.org/r/20241209-pmu_event_fixes-v1-0-d9525e90072c@rivosinc.com

---
Atish Patra (3):
      drivers/perf: riscv: Fix Platform firmware event data
      drivers/perf: riscv: Return error for default case
      drivers/perf: riscv: Do not allow invalid raw event config

 arch/riscv/include/asm/sbi.h |  1 +
 drivers/perf/riscv_pmu_sbi.c | 22 ++++++++++++----------
 2 files changed, 13 insertions(+), 10 deletions(-)
---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241212-pmu_event_fixes_v2-c34bab91422d
--
Regards,
Atish patra


