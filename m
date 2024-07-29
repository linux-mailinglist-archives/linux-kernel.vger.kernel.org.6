Return-Path: <linux-kernel+bounces-266427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B3C93FFC7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52211F225A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F491891B8;
	Mon, 29 Jul 2024 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="k3LqT+WB"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44A783A19
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286245; cv=none; b=Z5USLlv8M7iaKqKSKTP4avRABY6mRLB49wbaf7Tb3BpTsU6q1+CXhMLhRKiMF4SXSPtLU9iBS9lY8u90fOYOBDyxYljdccdCC1h09Z41zoAizeDaflreN3KzfoD9Xms1ZSPAcLTDI96fP3LnMFa6yu3IpjfHjXaWf3QxUvthsYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286245; c=relaxed/simple;
	bh=SWoPzKkjwRPP6Fw8++lKxhhYl2PukdTfW8smKgrVYEM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A6RJ6lUVVDvbFxVJisRPkk96Koe40NMSZo00f0p9AxsFUQkRtllh7qwacPNQ2sNXHUReyErL1YVsSQUwChktAx4J3DsdaAI31v4Ok3UMh3u6kJ4bgjdT9A1EannL56bsxurz4BFoHLAuMk1PxHDhEw9QHiV+L9Y4zuFsBDW20k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=k3LqT+WB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d2b921c48so2779741b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722286242; x=1722891042; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MyqkDl560JD0CBTzhcqGXAUa2SEvliDo3DhwU/kYi7w=;
        b=k3LqT+WBL/jGS5l+OXyRFMXfJ8jbUGdAOmQoY96blfibBCNPISPDU8AAJ7fMk3bXMX
         /QKgUO3r3BaHJC2macYExiWcLEF3YEt6tbpckCZ9G+Ic55wt1r07z6i06pPmLknfC/eF
         sVOIuXHkXboQEdt2ZayTJv5LQ9L6CDPuzTEHrNM8GSR3NUJRPxI/Njalp1zZoyGDwPJ8
         rJcOH8xeHQMig27nCv6wN1Sb1oUKOZe6Owx4jpSCzY+KKho6njEpXeXwHo2QJrobkUi6
         3y9LhY/0/A8WttGLJIRYsDc5CciF9H0rigsg9YHdA/QJ3VaI8IE9yYRSYX+vroQL4jiP
         fg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722286242; x=1722891042;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MyqkDl560JD0CBTzhcqGXAUa2SEvliDo3DhwU/kYi7w=;
        b=ZiIFX07K/5Jjps/9MKb3RTnXAYbrZsN9eKLKb0yzUQG8AEDq9p+qQbjD5HSt+EA41g
         /V1jRg2VRCI33QYPAy3wheYngFsTT1Rlb0YtdSFCbYVq3CHh8WslqYipGdVdFHyqmabx
         k9kkN3/vBCbwPxumq66iyzzCXNVr+Qjs68E6bpr3fdklbwybHG4QFesiCDL6hgqJqdRf
         Ync78M0JZWUPjgBG6A9lZRUWJBSp+FC1WJoTUlfgNfhebbIXkIgWoSr2XJL7oy8EnA65
         A6HFE7nwDeVvzRhMI5kY5yRaBzfnJBj4RVxFsfM9HV9LWjSSxhSCnK1tvvmlo6U53GEa
         tvAg==
X-Gm-Message-State: AOJu0YxSe3Vrb1mgWydYUfji5AayhDrJX+nErCloYGM1ZjoFYKH8HSIU
	UyqnHZ89iwPRKnTKyDs7HOjG9+8tdlNwS4ngT7g9uo08PXFsllSFcYybRorXYrg=
X-Google-Smtp-Source: AGHT+IG4q+xT7Eh/jxfLNLEeUa+wuUhMGfqsXxfHJcPRKtZmUSqwQyvc2zQVI5TKZqsQKXpgBYWH3A==
X-Received: by 2002:a05:6a00:3c90:b0:706:67c9:16d0 with SMTP id d2e1a72fcca58-70ecedbc503mr6449388b3a.26.1722286241843;
        Mon, 29 Jul 2024 13:50:41 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ba2csm7454541b3a.93.2024.07.29.13.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 13:50:41 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 0/2] tools: Add barrier implementations for riscv
Date: Mon, 29 Jul 2024 13:50:34 -0700
Message-Id: <20240729-optimize_ring_buffer_read_riscv-v1-0-6bbc0f2434ee@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJoAqGYC/x2NwQqDMBAFf0X23IAusbb9lSJB44vuoVE2KqXiv
 xt6nDnMHJSggkSv4iDFLknmmKG6FeSnLo4wMmQmLtmWDddmXlb5yA9OJY6u30KAOkU3ZJH8bpg
 f9ll5i/4OypVFEeT7P7zb87wAqv4X33EAAAA=
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Andrea Parri <parri.andrea@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722286240; l=748;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=SWoPzKkjwRPP6Fw8++lKxhhYl2PukdTfW8smKgrVYEM=;
 b=X/1NIE1i3kONOrn/juB4EbkpjSE6PBybz1vWcokDzgdT9HvE0maY9P/qm4SaaxK4RnxljnKmy
 Fi9LezqwdrHBqsyDrIeDZDY5pawHgzuuAOiJta1jDUwztfGMDtBhXd9
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Add support for riscv specific barrier implementations to the tools
tree, so that fence instructions can be emitted for synchronization.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
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


