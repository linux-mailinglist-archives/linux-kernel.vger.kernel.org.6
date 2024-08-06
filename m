Return-Path: <linux-kernel+bounces-276982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F201E949ABF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC15C284EB6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65310176246;
	Tue,  6 Aug 2024 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="l9bcgHFl"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60819171675
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981693; cv=none; b=fIJSCHUxmMSamoDBNdlAAH2z89g7noMHQ2vdZHHjvMSqRFQ9ZE2vrFZCd5b5ZTjDCsc+YjkUGxUaSeDbKhZfQo+LIHHRgti+tGG9B3foap28yNMwSflpO3BOvz3GstSgrenTQVpq9nbTzmOqj3bCcX09TPWfuCXA5OBLHKB8EHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981693; c=relaxed/simple;
	bh=4NHQEehVAG0NwxpUnDGcXm8ebXdDqTJOInrMfedXBo0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U8PYjzZ57Mj6mEbReTFJ84nKWWo5sn5PD9wL1FtLMiehyUlM5gdegwndnuk2XKEBZUW6iKrzKx/KXWtXv01hYsC2V6hIxBL/SXSo5XVfKARXhgMKiyUYkMLNCHvMMlWuIhuXlYuwCSzal+Bv4KeM0DbSJIJEGAHbIVcp5r+RgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=l9bcgHFl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ff1cd07f56so9250035ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722981690; x=1723586490; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UHyIBHBe7m7I8HTEvfryrMYI7ZE76p9wqPYDI+ZDXCM=;
        b=l9bcgHFliocT63QzC9bAPNrZIhADGZGj4cZhW3iDjz9XUDR/yjdTD4urlCoYeOYo1V
         Ub5MSYL4A7BWzVXeAbS2PD85M3Hgk1zlTIiMVHxxbywyuf2AqhufRhvXk00GTNf5fB7p
         /6xLxienP6ZmBsNjQDLdWZEU+7a/H/htZVryiK8f3S1W03NBPWX64ZsMWoieMEXPAUGU
         ByP+4Qjc0mlZ3bq+c4q638OEfe/QOwY6+Tuzy6xQkmu9fWjh7DEUN/L48uQlrsXZGh8W
         FocuGhsBF1/oEC0v1wSWkLAQvDDOrf/eenmNL4XAb6p+LFzwlOASeIW3M1+kt2hD4Lyt
         /V1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722981690; x=1723586490;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHyIBHBe7m7I8HTEvfryrMYI7ZE76p9wqPYDI+ZDXCM=;
        b=Ax3MSz5bK/rGLxWWiuccUci6uuRlGbiPSXHivm3gfRQJebdb69sx2OHvmRmqkgGRIK
         If3GjqDyp38qvthVrcoD5NtoAKOmEEbwzt8AOEQWpHpDCml8baqHJMkUR7CAWfPCFXE3
         YUjxw0yi1mFazSgVedNuWCjm5tLQEsvRMOKRGb0uY37iqJV92MipH+GYKmosY84Vq2YL
         rGQNaIl3+y7cRNVxel3Lj82yT2psz0lKxjWw7wQ92sJN4UklJQ2BYI3JN4JqCZi3jhy2
         eL1E+zHHXCrwrzs3Bcr65d0Od0EMwU8VUDRzG0G2Vzby7dhcdJKOe3eQjSCkU5NQlTGN
         UM0g==
X-Gm-Message-State: AOJu0Yxk8UR4F07VFMlSl9Q30gdMxycAzOg8tBkRp/MdE6uX6G5SuX0L
	5J/LtKjNIZTXKXthph6iIFHXecwhY1f3BOfz622Wpg5pwnTSJKsrnTujBSvZD/8=
X-Google-Smtp-Source: AGHT+IE7qLlUukythdnkW3zQ3rBGy9VXhyoxZcuSe9mUdEA3w7HpB/xZw/B6gcPQ7Q6jajvAhTnbFg==
X-Received: by 2002:a17:902:e80f:b0:1fa:abda:cf7b with SMTP id d9443c01a7336-1ff5722d9a2mr185899825ad.9.1722981690493;
        Tue, 06 Aug 2024 15:01:30 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f27340sm92578425ad.17.2024.08.06.15.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:01:29 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v2 0/2] tools: Add barrier implementations for riscv
Date: Tue, 06 Aug 2024 15:01:22 -0700
Message-Id: <20240806-optimize_ring_buffer_read_riscv-v2-0-ca7e193ae198@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADKdsmYC/4WNQQ6CMBAAv2J6tqasFcWT/zCE0LKFPdCSLTYq4
 e9WEs8eZw4zi4jIhFFcd4tgTBQp+Ayw3wk7tL5HSV1mAQq0OsNJhmmmkd7YMPm+MQ/nkBvGtss
 i2iQBLroqrEZTosiVidHRczvc68wDxTnwaxum4mt/7epvOxVSydIYqxzoo0a8MaUQyduDDaOo1
 3X9AO9O7jDRAAAA
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Andrea Parri <parri.andrea@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722981688; l=914;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=4NHQEehVAG0NwxpUnDGcXm8ebXdDqTJOInrMfedXBo0=;
 b=i+I1n4AKsZR8pKpVgYlgT0CCKtIwC7b2pjgVwea6mE3ubg8yf+0dC42KkaWT+mUnI3SLWIhHt
 NaO616IplJxDAbx7WL1b6cE1qHI/MI/zZt3DmmrqUJNGG0wm4BHUdos
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Add support for riscv specific barrier implementations to the tools
tree, so that fence instructions can be emitted for synchronization.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v2:
- Fix typo in commit message
- Link to v1: https://lore.kernel.org/r/20240729-optimize_ring_buffer_read_riscv-v1-0-6bbc0f2434ee@rivosinc.com

---
Charlie Jenkins (2):
      tools: Add riscv barrier implementation
      tools: Optimize ring buffer for riscv

 tools/arch/riscv/include/asm/barrier.h | 39 ++++++++++++++++++++++++++++++++++
 tools/arch/riscv/include/asm/fence.h   | 13 ++++++++++++
 tools/include/asm/barrier.h            |  2 ++
 tools/include/linux/ring_buffer.h      |  2 +-
 4 files changed, 55 insertions(+), 1 deletion(-)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240725-optimize_ring_buffer_read_riscv-228491c4eb6e
-- 
- Charlie


