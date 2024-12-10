Return-Path: <linux-kernel+bounces-438597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC629EA346
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3DDB16218E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E2EA31;
	Tue, 10 Dec 2024 00:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yW+hOQB0"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A832566
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789094; cv=none; b=V6mDVXE5HJnu2/nXtdL2JyAp9aPkpfMQgbyfZXdQ/DeWJhJ/6tROWsdYAdji//VGUf0RDXearrY4jkgeiFGMsd8Avz1l9TWEF6OKJ5m+HvmgE54CGBBfBL+tbXj6XHiGKbgMm76lk4pQTtMzMMh6zclDgAY8Fh1CA2ubAIOyMo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789094; c=relaxed/simple;
	bh=45UQk0/I/HX38Ry9mSNig2CV+KAUFGjh1/uo9hmFhLQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gEM+ziiLaeaeEtMzGECFSTv55Wad0RtxfFK3uRH+XMygng87sDDeSrWycd/akzAkFVEQMEZud++Kle7xiaMKahvuDqaaB6ABqE9kMtnArXwAOm5tekE0/Nw3/NWjjN2rbcfRYsnOBVPP/brmCgizcZ7CjWx7xW+VNWvByHfyppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yW+hOQB0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-725f4025e25so1069965b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 16:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733789091; x=1734393891; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ji/bjCDM8Ft34migBO4y7ku5uywiRK/wox/r71XWWSc=;
        b=yW+hOQB0voX97760+/jlgLIT4JWE+UCH/qHttw3W93GEzk0TB3yOouAd/fIJ3UGG5N
         54h7WcZWT0ta4KznY/On73K3/Qe+TXxKFGc5ISSwI7XMslXBi9zjQMXxRHp8/pO9JGKb
         +248i58F34pf+ibxPGRqO1kVSV3zY10NXBw6B5yEM0f1EVAtia3cL3oihnT5AkYev4/8
         pwA4CFpkIvzQIyToWZsf9CnUVT/ffMFeGR/2VVXs2xAgVM35WZy3coWz+DIuS1tXxqU+
         RbEFSRKg1LMO0PVXCNGjw5qR9FktFzNe+iqeuR1+SbUSqbMtuFRJ+uql2LSYR5l+i0ot
         ctVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733789091; x=1734393891;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ji/bjCDM8Ft34migBO4y7ku5uywiRK/wox/r71XWWSc=;
        b=OhXnE8hg7zpJIILLbgcZdw3rGHN8KONtGFNy/1vdbdaH1lLK6+HfreC3eNAS9OcAxK
         AtHXqqM5FyBTydmw7lZTOm09CrUK10zmrpcbBWV/i8bhJDQFQNSIwqHa2GRxrjFXDuH0
         7HS9h83wen4QFf07N7ntmhOlmE4VvtniJ8rTDf/lOF8Uyoyp/+m5ZJEnOZjO4m8LwSDv
         4XUagEF7XkuNkWp+klwV2Yi+1OvuUC/jb9cNkQuTCcWaryymEavr3+2LDZ8IzsST10ED
         cvsWulSTVUb5qLnTPDNiAkc30cuj61cOQCE/G0xQGgNwiqXjLlqbTefkW1iMZGUoCakW
         XK+A==
X-Forwarded-Encrypted: i=1; AJvYcCWIPuvism+FJWJC3tGEzMjHJO/2YA2KUtAc/l1aMYPw9m1mk7hddBwj2tRW/HwCGatlKncBw+k+BesM0vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlreeZwnzTQLgP7Ai5tPh8or2yjUFwrx8jrBcw8j+P+5TjO15o
	8bhcN9539pG+co4WUj48bgkgE69W4OXZNFH/pG5JfGZVyS6hX3JKDT8LifHO23uIbJMM7ETrR/b
	+
X-Gm-Gg: ASbGncvMGrhK0U0vST16nXmL5xMM4IY50YEZ18phOxbp4SqnuKLwabdfKvVVmj1h/Ik
	UN4gu7oB0rJ8vSHq4Y4jcxiLnWof3u+TdnH2fI4X5i+jtLr5UD7zq6st0kRZnW2IS0GpUfNSjDC
	OwGtnAdqPUUK2rX/jeOW1CrdRkqmcEVCyeYbC43Bmo1Ta/jURV74nD3nu5FY9hWWpVNrJ6bCmru
	ylvU1jS6moxHq5bk3v1Jd8/7X3y8Ogs2L8PyjkMv3num1cb70JC1W5KZRfr+SVGQ4s=
X-Google-Smtp-Source: AGHT+IEl0iThSUMRmBt5x82YsS+Na48szQj4WL5LFMN+y7ChsI0Bj1eWoqCFm3HRkd/vd/duzw7Oyg==
X-Received: by 2002:a05:6a21:7889:b0:1dc:1:3e28 with SMTP id adf61e73a8af0-1e18713e068mr26159811637.40.1733789091182;
        Mon, 09 Dec 2024 16:04:51 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e3ca46f0sm3477249b3a.15.2024.12.09.16.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 16:04:50 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Subject: [PATCH 0/2] SBI PMU event related fixes
Date: Mon, 09 Dec 2024 16:04:44 -0800
Message-Id: <20241209-pmu_event_fixes-v1-0-d9525e90072c@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJyFV2cC/x3LQQqAIBBA0avErBN0kLKuEiGhU80iCy0JorsnL
 R+f/0CiyJSgrx6IlDnxHgpUXYFbp7CQYF8MKFErlJ04tstSpnDamW9KokXntTYN6slAuY5Ifyj
 TML7vB1ahNx5hAAAA
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
Atish Patra (2):
      drivers/perf: riscv: Fix Platform firmware event data
      drivers/perf: riscv: Do not allow invalid raw event config

 arch/riscv/include/asm/sbi.h |  1 +
 drivers/perf/riscv_pmu_sbi.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 10 deletions(-)
---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241209-pmu_event_fixes-72cd448624a8
--
Regards,
Atish patra


