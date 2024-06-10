Return-Path: <linux-kernel+bounces-209032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E499902C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9331C2122B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D1E155CB7;
	Mon, 10 Jun 2024 22:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1scedvKx"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CE3155C9D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 22:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060231; cv=none; b=UxCkQ2nLedeSs2ya5eacSWlyLwJetxF5odQZ1qsaJrmeVr273+lzXYp1FaCyaVYyoJw6QzLsoj3luNaNztZ7OaxRn7NNBe7LC9yBreBxLsqha6hO/oeWeFUlSvQXyniF4FVDkn8tPsNiNfCXA8BB6QHc/kbgtwVbSPq4NCv8UiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060231; c=relaxed/simple;
	bh=FGQxjkKFg6ikcL755lFMFBnsaceTJTK90HJM8u9R8ek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ozLW+Np+IHfSnXtiqIjVFJxesLQJNIByR1WzfZZfm7vF4m2NpX+vJFrVJaFvVgTMCNDT+w++8X2+cEoBYSrkHv4pS1A5zc/kF/Lhq1FHWNfvoTfAhMZu5n0vcq4h6tRwYNlp1W1EoYy18vXgtOhw247LQwAlzd2S1i70xx9HJHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1scedvKx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f480624d0fso3221755ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718060229; x=1718665029; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8BieCexzaDREgF6SB/4DhCje3SwtC4a6MLqQwsxjuQ=;
        b=1scedvKxTdHiiss+F3cNNIhMUJRLNoojiDHSorPQAVOgpkXAbDiGgMBsd57cmPAnml
         b9XUVjR4YxcfgmUZp2X3mMgajDl9dqSbEu8DKAmMMbZdMbzF+f3dYgOnbju4bHl6QOb6
         uA3l2Al2KnWe+LLcUweppGxUSnR11YaRTAm/RrYH4MfD6HePTrhbwOdtu+PvaUDcRMVy
         as5pYFYxNB0ndNVuy5l9a6h5NrlwF2QS5svse0lHQhpU5lEuNS9jXUGpM0and1e+r9HN
         omw+7bEMZhtAv6qga8b6EZKT7K9Cf7TCfVmJPQ7kQ1ZnGfx2qou/9/CpKFw+scjxoTDe
         BvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060229; x=1718665029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8BieCexzaDREgF6SB/4DhCje3SwtC4a6MLqQwsxjuQ=;
        b=wO5dCS7nOfFdhIpktwQSo4vjztRtSDaIQIDfAwo6Ou3M2c9JXRefgSW8Ba2mJ3+1s3
         78hhOHHRc9FwE1FVRNOzQbe0icn/EPWFmaSMKl0PHY1RNNLp0jX8Ch/5c4ejcn31+wUz
         zZEDjgtwv05vBaz+f3wpTmtjAVKoID4CFp3TK+lhZhDcmOrMsO0pvwifPVdnblIJFgqe
         P6Km43TxG3ut0EcADrUKYKDJ21w9fgHCK8IMWFR/BOlvKtHE9iPoKKI8i2fkLGBYx1CM
         EK0A3JgyUWVJ9A0PVMJ5koUUy9e+KpOArmBR9Y5RM4EJPKpg5uxm9Ii/yWBDh20++uK3
         ijtA==
X-Forwarded-Encrypted: i=1; AJvYcCXu3RXMnNvz/GnCvwLqpjssh+KfMcmUON7uu/ckREFRcyoG7Q+DBFM1BcjhTcKmpytMeerjTnfw82laot6/eD3h4DkqNhiV+PJW655o
X-Gm-Message-State: AOJu0YyslvVbgUKorewNBPvvGeHiWcnI5gvYjm4GSQQI1VG539JPdrQD
	vejNugZJZ5iA0ulgGWDT8xVEdMN79vXSVbAz2tA+9D/F/JC/qC+Q6LSHD9XTpbs=
X-Google-Smtp-Source: AGHT+IFz9vtXf5e0aEV1kuFGwIdEBaQ9jNPXflxwrEiSR/c7uf4L5n+hy7zOGF7s5B/7ltU8tsmhPQ==
X-Received: by 2002:a17:902:cf04:b0:1f7:26f:9185 with SMTP id d9443c01a7336-1f7026f932dmr68716645ad.10.1718060229608;
        Mon, 10 Jun 2024 15:57:09 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71b597072sm18355865ad.99.2024.06.10.15.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:57:08 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 10 Jun 2024 15:56:48 -0700
Subject: [PATCH v2 11/13] riscv: hwprobe: Document thead vendor extensions
 and xtheadvector extension
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-xtheadvector-v2-11-97a48613ad64@rivosinc.com>
References: <20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com>
In-Reply-To: <20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718060203; l=1250;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=FGQxjkKFg6ikcL755lFMFBnsaceTJTK90HJM8u9R8ek=;
 b=8Jye09us6BGw0+GT90JyFf5B/Coarcsdhyyne2ijzLW8oQNtKmUdJ3Z2etU1E80MtSToWDYJY
 NmJCjTuWVUcDEhoybVbz6T2CJmAUWhNf0+w/qoQHK3c6gHVe4xXvoyn
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Document support for thead vendor extensions using the key
RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 and xtheadvector extension using
the key RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 204cd4433af5..9c0ef8c57228 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -214,3 +214,13 @@ The following keys are defined:
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.
+
+* :c:macro:`RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0`: A bitmask containing the
+  thead vendor extensions that are compatible with the
+  :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`: base system behavior.
+
+  * T-HEAD
+
+    * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR`: The xtheadvector vendor
+        extension is supported in the T-Head ISA extensions spec starting from
+	commit a18c801634 ("Add T-Head VECTOR vendor extension. ").

-- 
2.44.0


