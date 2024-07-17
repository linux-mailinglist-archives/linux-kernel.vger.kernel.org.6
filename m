Return-Path: <linux-kernel+bounces-255105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EA9933C19
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07CCE283E01
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379C617F392;
	Wed, 17 Jul 2024 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zCiOmj07"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1B2BA4B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721215044; cv=none; b=CNX/+2l6CKgAgsCNKANUeGEVeb6fWfyO3Q1sAB9CnGJf9hssqC6kHyjGeK9oefy0KNp2OmjuruUTMLRiPNpuL0MKrEhwcFoMeCLfJiqwmGe1RnglHJOgCizAqAa6iC0PLtINj8IYm009eivD/utJ5Dz3rWGwoWiZvmMLhra8v0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721215044; c=relaxed/simple;
	bh=kGPmnEoXtEwIAt0EnQQ543oTvDKGLtZ/GVvPIJYgjNU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SWf/kHq+otICm8yNq4U+JFOlNjKMvUzA93Q5HcC8t60PASmdRHtU10MoHEKcxc/gem/puxEpLbnK8qeGdxBPmmEW6+EV0b0pybEfDGC2oKTIkf7iz9NxWoFD7enJize1vpIqdd0NZ9ksBdw3R4gabTZWExnyjf/0pNBAtALedkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zCiOmj07; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3683329f787so259287f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 04:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721215040; x=1721819840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MEde5o55HcVFlN6Ab0SvCBTZkTEAqRrN15IuEXMMTLY=;
        b=zCiOmj07znoe09z9XMjtfb+JNwjFKurFF1QVKR5YGnHVYH6MAZVV5PLw4/f10iL+Yf
         ypYyJC9YGPCDZHN8LthxgWJq1qYbmhtK2tWfhJVykK096UjAzZqlhSW/dBusxIHOhlCb
         VE/7xC1iCKukxaU3B1hXbKIgUfDjDHOmFCSu3xG1BwYAySWKSp9qKLdYVCQW0X2snIL7
         o7AjvJ5+cJRgvIRue5v914R/lkHIqVqzskNNoLzqOfiNTp91xuP06aQsEGdbO0s8iWW5
         r7I46dqBjcnUlkgBqM+r95zJXsS/6mbhhRTDNUvGX+oFsjivnAVNy/4X2kQ5UmSnRQP+
         tTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721215040; x=1721819840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEde5o55HcVFlN6Ab0SvCBTZkTEAqRrN15IuEXMMTLY=;
        b=IbxEIZ71pUTIUAxvM4zme7kyxddYGdzOL7gWQxdv5SQ08QiCB7j+1bYuB8NNd1+ygd
         8wL7mqryK4y6TRFsr0mZOP7VuMkFeem7V3bgS/O4+ofaD0n89M0hTwsHCFRPhqBQDVd0
         iDMtpCy3d7VMU0f3Hqoj6U5RuaYowzq5RXL0MU4EnS5Fh+kEZrQWdo2lxMtAYM1x11R5
         gd5aOxXHGdJ51Bnrm7ZjbcxA1bomovWb751gGESKxoyD/CT4nPdrgq/d1GdLFUpn/vkn
         wqiAlSYEX1QkNdhiBb56697f8oL0VS+M5rwShDOcUAYVNc27lANWzFqSXD2W/uSIP2Qw
         BjWg==
X-Forwarded-Encrypted: i=1; AJvYcCX9tZfFgOuu9OZEyqEdnNeXMMw/XPzoQ19tG1qoHBXI4pqJMJlwJEzQJWV/HexQFBqguTkh63qIziIgd4QrZL0g62vwR3e0jZxwGzNc
X-Gm-Message-State: AOJu0YxaOTAqhZbW5EizlxLBqJGe2yEIPfL6HHN5jBKT0/v4sjbMSGX0
	G171We4JlF3QKd4DAACn8uT4Ii0h6eNpmdIoqHwyLDDlKZ8PEeFSJEEOFuoiZY8=
X-Google-Smtp-Source: AGHT+IH+V2ev/OCWLwYSzMlfYIiT2IfSh24gG/zyNHG70xS+PgIrxI7Rq2MKq9mnkZWa1dyGUYJqiA==
X-Received: by 2002:a5d:6a47:0:b0:367:9614:fba9 with SMTP id ffacd0b85a97d-368315f5b2cmr909738f8f.3.1721215040043;
        Wed, 17 Jul 2024 04:17:20 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([31.32.81.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2cc42esm202931055e9.32.2024.07.17.04.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 04:17:19 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: kernel test robot <lkp@intel.com>
Subject: [PATCH RFC] riscv: Allow to build only with LLVM >= 17.0.0
Date: Wed, 17 Jul 2024 13:17:16 +0200
Message-Id: <20240717111716.157149-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following build failure happens when using LLVM < 17.0.0:

kernel/sched/core.c:11873:7: error: cannot jump from this asm goto statement to one of its possible targets

This is a known issue [1] so let's upgrade the minimal requirement for
LLVM to the version 17.0.0, which is the first version to contain the
fix.

Link: https://github.com/ClangBuiltLinux/linux/issues/1886#issuecomment-1645979992 [1]
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407041157.odTZAYZ6-lkp@intel.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---

This patch was done by Nathan, I'm just sending it as an RFC to get quicker
feedbacks.

I tested it successfully.

Note that the build failure happens on the not-yet merged qspinlock
patchset.

 scripts/min-tool-version.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 91c91201212c..e81eb7ed257d 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -28,6 +28,8 @@ llvm)
 		echo 15.0.0
 	elif [ "$SRCARCH" = loongarch ]; then
 		echo 18.0.0
+	elif [ "$SRCARCH" = riscv ]; then
+		echo 17.0.0
 	else
 		echo 13.0.1
 	fi
-- 
2.39.2


