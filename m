Return-Path: <linux-kernel+bounces-189032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F208CEA1F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65817283B11
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CF543AA5;
	Fri, 24 May 2024 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QsmUEuva"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495138493
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716576988; cv=none; b=T+WV2PZY7V6pQzvRPHmeTOiLl7X0EZySA1t5CnEJyMU9KLufjDgFYhJBAueQ2sSsUSDJY2WM1YtuuEkNHRtH/WVgOGktm8ozAcAvxYleJQJDR+LjqAqhp9D2uYR6G1Kob/C74ZNDV7qrL2fEtI8fpXWOW5NbXJJRmG6M7Lgvgwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716576988; c=relaxed/simple;
	bh=EnRUwxPjMwARAQhkc9VptC1FFM+vVJDf4lE+8efMjmY=;
	h=Subject:Date:Message-ID:MIME-Version:Cc:From:To; b=m3wzQp/wTJjQaLJQeOsv39Q+tYM3ymfOEFMlm22nWjjYUkl3qSnYpHwAUWr6ZJMfzsRRGnK5va+9N4U3GhnRFLpshyDs6M+BdAggZhuVORj6bkU6kYGhThgmQyv9NUYmdvqQncdnnynj3fL9DLCfGHpPZ1SMV9B1Tu5Ri3Z91Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QsmUEuva; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f44b52f86cso9882035ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 11:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716576985; x=1717181785; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=xLUodbpWlHV/m1Bt2U9fTwJmOlm4ytnN9TrwQjmnMvY=;
        b=QsmUEuvaApp4KX0juj4+Xy3f7J7Nx/4zsj9O2XA2CakDNg6ofjYhOc1s2dkwJrOwwa
         yoCZOr1FGiKg4niD//zE7JhhCWu/4l+BM7dp4VMYhtdco/7nPzj6MyiVT5SYCWTOteqE
         jkU1MuvyGd8EOvsLB/l5fet1aYRwFrwpk66cyQhLdrm+FeSQHsdcSAVNdUxrdQD5bMhr
         Pg1vKDsbr53SUl8HQsKMEjQ/Clq6DzOnjttyOr6MG3mxJ8eOA8ASlRdlO6jbIbd0oxgA
         MvEi3xVSj32lqATv5cqvUIwpfXs1Cwn8Y+4hAKQ7bpw/isPJ5GyRfkAojgHE64piNDXw
         sHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716576985; x=1717181785;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLUodbpWlHV/m1Bt2U9fTwJmOlm4ytnN9TrwQjmnMvY=;
        b=qUo3EHwkNJINtSLIgQDtYorH8/ne90nHrpWTdzehdQBcbrzpuQmIha6XD6gp5nfE7Q
         zWPdaZK9mMoaUy1mzJ4Eqsqhr0JgjjOSdZazyPOJpVS/txzFfTlIFCHS20NsBumH8/Mr
         2vnz328/2GMtdSFU4Ufxz9m5co9B+lbVfN4p0Wpu4UOzzbzm0ffeQIjQ4TFxaZt1lh7N
         wUrPqBoMGdVQQUDupi3qSrk968YnL1kb6QyXeor6wgH5gBqXdvVEz0jNfX9tniQydKun
         kGqF5DhilHFKQA9xuldlUWO1V9+9SihXVzXTIncJcvb8I95q/8c1T9TRDR+ivUgJ6MjS
         6S1g==
X-Forwarded-Encrypted: i=1; AJvYcCWocvO4rZugPXsdxi8t86N1o5DbXd2A2YTynesI/jFNBxWGZTLqGTl+baYJ/h3FDr/PEVCoJv6zw0sbT7zUbTkkJvB/h7s5tc442jlk
X-Gm-Message-State: AOJu0YyRqw0HzyQ8K40FM0EROWPms3HC14wzTL2t96kPmBN6PLyAms5L
	nHFhztoK4jwLz4GPXxMYmNxm1AEolVbtajlw2Za7fTZ3pfRthQj0i8bOYmtSYLA=
X-Google-Smtp-Source: AGHT+IHmjdtRpnISU8MeUC5uHlVT+aFruq8xOMm5QCnc85cjYN6x/xbnArZ5Bph7B9WPdNdkHZeeug==
X-Received: by 2002:a17:902:e746:b0:1e4:3909:47c0 with SMTP id d9443c01a7336-1f4498f0d96mr42599825ad.62.1716576985229;
        Fri, 24 May 2024 11:56:25 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9c7f32sm17084505ad.281.2024.05.24.11.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:56:24 -0700 (PDT)
Subject: [PATCH] Documentation: RISC-V: uabi: Only scalar misaligned loads are supported
Date: Fri, 24 May 2024 11:56:00 -0700
Message-ID: <20240524185600.5919-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
  Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu, costa.shul@redhat.com,
  Conor Dooley <conor.dooley@microchip.com>, linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
From: Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org

From: Palmer Dabbelt <palmer@rivosinc.com>

We're stuck supporting scalar misaligned loads in userspace because they
were part of the ISA at the time we froze the uABI.  That wasn't the
case for vector misaligned accesses, so depending on them
unconditionally is a userspace bug.  All extant vector hardware traps on
these misaligned accesses.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 Documentation/arch/riscv/uabi.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/riscv/uabi.rst b/Documentation/arch/riscv/uabi.rst
index 54d199dce78b..2b420bab0527 100644
--- a/Documentation/arch/riscv/uabi.rst
+++ b/Documentation/arch/riscv/uabi.rst
@@ -65,4 +65,6 @@ the extension, or may have deliberately removed it from the listing.
 Misaligned accesses
 -------------------
 
-Misaligned accesses are supported in userspace, but they may perform poorly.
+Misaligned scalar accesses are supported in userspace, but they may perform
+poorly.  Misaligned vector accesses are only supported if the Zicclsm extension
+is supported.
-- 
2.45.0


