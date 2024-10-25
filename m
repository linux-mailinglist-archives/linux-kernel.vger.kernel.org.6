Return-Path: <linux-kernel+bounces-381595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C569B015A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F841284604
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22DD1FF7AB;
	Fri, 25 Oct 2024 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5iN7WYB"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BC71D356E;
	Fri, 25 Oct 2024 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729855770; cv=none; b=Zyv+5xAmlIuBVi0DGLSZmh/R9R9gSk7d51qmNWfz5XyKRpopGIZYJ0Mf/uWHxm5Vt2QRdBUYQqcttHcWDExV+Di5mdmfndlhgUdw4Ktb915hV3sukSD68GCKuGPwDSJtbjq5rmoPeyL8e/XlrYWAtJEwZV7fg/aCW22uDdxjak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729855770; c=relaxed/simple;
	bh=ZvSW6zEIf+gsmaX9KiDC/q/LiQWAlLlLcCpTdsNQeV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ao8ogy+SBV/oyCv0N2RtBU1I8ae683LO2Aof/5ksV3NJbtWEQKCdQvDJnfYgUDjFe0IFBk1PdJn8rjVBTifOPkdIDCUCGnuqcnWLJ8YIT5ruO41auTpbSGet4B+gwBXrNHOx1JtMSswzGal+FvocBKN/OC/qSLO/nyv7+oTCLDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5iN7WYB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2d1858cdfso1338860a91.1;
        Fri, 25 Oct 2024 04:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729855768; x=1730460568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eoLWfDYqMargjt9GNsixRddeg2Fxxd0sF4oOMFzM6Mk=;
        b=Q5iN7WYBHq34yOwOvpBqKTdvW+jVeTawMfm+czLATvYFMGXFlh4deUBfocpjG05S0J
         sndv0SjkUsoDL7TktM9ZBzIoKLLlG/sZV6wfNGBj6EccW/TMzmtf8OKRIRZ7S7V9Xahp
         W/sk3SAxvBaOyQzcz4cfYjS0k47m6duElDaOWYa0VBTe4zBxkVOUVAbt8CV1/Bjg5n1C
         jjokePX9ehe8dJMgGkM9DlmLib9Fz6aq6o0VJBjYsz8niGuhenyniGt4NvrcFEMXxnja
         ZngIxsofHzlZp5DIoIn48zo0bkSKSWGAEunKOkUP4Gg2W4Lpzbno7ZYybWgqW58oiC30
         qu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729855768; x=1730460568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eoLWfDYqMargjt9GNsixRddeg2Fxxd0sF4oOMFzM6Mk=;
        b=K3wSGJs/IU71IGAWvjM9H9DlLsUrjWzfjzi/ZqYoaAvDb3w4c5Ci6o14D7lX/qLumF
         fPXl5vrUyoBR3f0B0ayooNOhhTzg7FhIUusBTtdHY4a3FUZFzRNcflDUteNABD0pDHVb
         /YAJWvl75SplCQRAwwxCDgIHu7+hxC9T54fOv9kwfQKERWdiqJxDYDEe3jiMyZnXwW/m
         EzQ++O8rjclAHAbjpZB4/NUOLEKN2MK8207d6MgLhyFlt+LEIuPofEuhGa7g+8cj4JaM
         T7WQEVdLHE5X/8M76QULXdeALxi6W1o0TlxxETCBpQ/jldRn4bP7pIZ/4cfYBhX0lMob
         ldRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9OkjQb0Vce1m7yIsfjhMTPDTOD5svXG9PNuisYG67/H8qrpcDMOdS8aJi5ZIV0YgrzkAh551MgRle@vger.kernel.org, AJvYcCVMPm3okEvnbfYD+F7GurYfqL6RHnOC+p6UBaD/og6DsD4PXeN+cM2gazAMCXKMsfpfVq1AW7yS7/wNQZKc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ePcg58yoRvbus6KKbulZhaJ9IWK2+jg6EOsOXlaluPFjq5ZW
	zxLVtkdkSzN+jRRv9kx0XYxkDs/cKiBQxlvG4L1yYntlFB6MwelP
X-Google-Smtp-Source: AGHT+IEB8bzGZcvOJIjZhselT38AHzYQjS+DXNlkOweOTcZYUWMza3njOQb1NrxYvytRBzozvZo8sw==
X-Received: by 2002:a17:90a:709:b0:2e2:cf5c:8ee3 with SMTP id 98e67ed59e1d1-2e77f4a2b59mr5516975a91.10.1729855767805;
        Fri, 25 Oct 2024 04:29:27 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3748c9esm1176328a91.41.2024.10.25.04.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 04:29:27 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] riscv: dts: sophgo: cv18xx: add emmc and sdio support
Date: Fri, 25 Oct 2024 19:28:58 +0800
Message-ID: <20241025112902.1200716-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the sdhci driver is already supported, it is possible to
add emmc and sdio device for cv18xx SoC.

Inochi Amaoto (2):
  riscv: dts: sophgo: Add sdio configuration for Huashan Pi
  riscv: dts: sophgo: Add emmc support for Huashan Pi

 .../boot/dts/sophgo/cv1812h-huashan-pi.dts    | 23 +++++++++++++++++++
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi       |  1 +
 arch/riscv/boot/dts/sophgo/cv181x.dtsi        | 21 +++++++++++++++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        | 10 ++++++++
 arch/riscv/boot/dts/sophgo/sg2002.dtsi        |  1 +
 5 files changed, 56 insertions(+)
 create mode 100644 arch/riscv/boot/dts/sophgo/cv181x.dtsi

--
2.47.0


