Return-Path: <linux-kernel+bounces-432986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9244F9E5297
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A762282978
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331A1206F06;
	Thu,  5 Dec 2024 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DfbvqQUq"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ED9206F05
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395134; cv=none; b=uftiwjToxNHL+KZ4igkM2t7oDah6bsZRh37rgor0yUUxeBnwE91pCWCL/VzJL38VXCO8QW/tDHT1iK4g8n/PONW57e8HOXdWYKBt/+bH5FjSgC+1nCWddOrm3dAD7X1JKWM9G8foy9fWGNibt1ynDIVCwj1/eO+hEGjA0dcT4eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395134; c=relaxed/simple;
	bh=xZW3Hjbwaye/czccQX2iibB21IBSJjMq6pEPTJmFaVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SyE1NDZP7Un1FVRtBuEL4fVNLuLNpgYcV9cTUQFx07lDSoNCxj9jlRfLBdH15JW5ZXyYaVZvPw/ZOYBLRrKG3hPDEBy0dB4muMhywgnM4tknaRaMUczBaJ1Em4XKiDMCzcnvGH3rAoOuiKAHrPozZ6QRn6DDpLu0Gl3+JS/LEEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DfbvqQUq; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fcc00285a9so834648a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395132; x=1733999932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fWC9OQ8fDv8IwsAqd/wbk191tCVh4tSTxqplFbmaYk=;
        b=DfbvqQUqQ3XH9vHIclajmTrDUH/7gA8SQ2xtdMfxkhJm3BnyFUofn0UGaB5j+w4qNc
         lprY61uxSnGLHjMWwMrk07n/WepHHSopOf4KdSfCFdbcSQpRfidlZT9H0/WOUhVCXZ8l
         2rCHUUhOmQPegiOLPOmytV/QfwNGcns7NdYkjYZctXF5r3Uj3EDKR5Bmjb5/gYv1CE5r
         begRMVUkYdtANvkHPpYOCu0IMyCcjC0LQS2/653/Jv8IQcEJqJMGZgzYJ/TV5hsmzM5U
         99V62o+6ylbKez0qYwtON66Kdw9Q/II7aO35HttZonr+SlxXoZc0SQhxw4FoGlkIzAdv
         28qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395132; x=1733999932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fWC9OQ8fDv8IwsAqd/wbk191tCVh4tSTxqplFbmaYk=;
        b=SOG0FtdM1rqtBZ5van4rkiw0yknGaK5BTz2jpdoc0vKCwMth1EMhhWejL33ZKztP8q
         R09ebO3StN1vH7ygAUMKlKaVMk5LqKr0+GFDMU3DsjuhBXy1+NsgbhEe3X4RbdCutIWE
         9k3gERm8BcCYbjXmTb2/2JP82szX6/No28PQ7MWn83uDoWgtIsGlBTQ0kjZY1HSmMSvW
         zAKZHIYU7ARBvDCwV8ejlZMyVat2vIzphnUsBq/PqWQYjE/J7RrQa4SNvTSIED3Uokdl
         waxjcxHwslmE43tBpy0YwSRAXfuI/PSnexysveAXhHTW7DgMrcwp0w3/bAH7MxxxxqCM
         misg==
X-Forwarded-Encrypted: i=1; AJvYcCWQjWpbvpOL0m9/tfEaez3IeewBFDevaZOPHN6SPuKhPrhbWADi+nA4g+sjwym2eJ+F6ynZA0WITgWxhOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfk9ff6YXtihPuQcch42X70W2KX9VL0bXEaYqVz1IfvxU+Sabx
	yooLhAHJ8cjL2gi6B98b9wMizcZILZYfWNH/gndI1ikMd1C1bTnLv93GT9Fo7ZI=
X-Gm-Gg: ASbGncsDXJE8JbrLOrhSUc1L6HakHlpOBd7wr5WFdwPuOAeBq3KlgZVaHNqW0vzc46p
	E+4AqE+YjcolNzGbyoA+0QXO7A8UTTED7cQRjOJq3l3KiKSILiPV/rX9NSHHNxaaEeaBrwFtb9H
	BUlWWzP0PyUoJpplxWoJZi+6KjiLjtyc7fSnnimhRNEHiF5CPCeJAPPLbFTPZETKIvFXpMRXNA5
	xkLYlPndD0SrS+OHvl1Je4se7OKGUP1MpWK2wt1TUVpFiZ3L3nP+bf8b0zetH+sc6ONZ8hQmifQ
	tbqTo4TXA88ZFcnc+czQmvE5mVEGdyZn
X-Google-Smtp-Source: AGHT+IEXD1d9VHmdEfHzDn4iIzGpKroyoIRBm9V8GpOCRUVEQI3tEWlF/wbQq82AYL+CFEewTt8KjA==
X-Received: by 2002:a05:6a20:7350:b0:1db:ff9d:1560 with SMTP id adf61e73a8af0-1e1653bb992mr16055868637.18.1733395132079;
        Thu, 05 Dec 2024 02:38:52 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.38.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:38:51 -0800 (PST)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	anup@brainfault.org,
	atishp@atishpatra.org
Cc: xieyongji@bytedance.com,
	lihangjing@bytedance.com,
	punit.agrawal@bytedance.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v2 18/21] riscv: Kconfig: Introduce 64K page size
Date: Thu,  5 Dec 2024 18:37:26 +0800
Message-Id: <20241205103729.14798-19-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241205103729.14798-1-luxu.kernel@bytedance.com>
References: <20241205103729.14798-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces new config to control whether enabling the 64K
base page feature on RISC-V.

The 64K config will set software page size as 64K and automatically use
svnapot to accelerate basic page mapping.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/Kconfig | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 2c0cb175a92a..592eb5766029 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -167,7 +167,6 @@ config RISCV
 	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
-	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
@@ -885,6 +884,28 @@ config RISCV_BOOT_SPINWAIT
 
 	  If unsure what to do here, say N.
 
+choice
+	prompt "Page size"
+	default RISCV_4K_PAGES
+	help
+	  Page size (translation granule) configuration.
+
+config RISCV_4K_PAGES
+	bool "4KB"
+	select HAVE_PAGE_SIZE_4KB
+	help
+	  This feature enables 4KB pages support.
+
+config RISCV_64K_PAGES
+	bool "64KB"
+	depends on RISCV_ISA_SVNAPOT && 64BIT
+	select HAVE_PAGE_SIZE_64KB
+	select RISCV_USE_SW_PAGE
+	help
+	  This feature enables 64KB pages support.
+
+endchoice
+
 config ARCH_SUPPORTS_KEXEC
 	def_bool y
 
-- 
2.20.1


