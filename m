Return-Path: <linux-kernel+bounces-343008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E739895CF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 16:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3891F2225B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148D516BE0D;
	Sun, 29 Sep 2024 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Kb3EisiR"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3A3F9CB
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727618573; cv=none; b=PX00W5yIB1hQYqNSiN9mHytNAu/feuYaYFEti5qGCxQWROBw+hdPVtEkbFuydmr675NZtjWRzF9Fm32jYQa65T4u8AFNezHgDG4gB3DbhoUEUjSLTFvrTiHlxMfWTItLuB5v+2FoUuMxSMt7CstmlaY1w/Wc/PD0MjzOelwMSGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727618573; c=relaxed/simple;
	bh=jQWuKneG6PSuozkSdhcxOcE5ilARFwHnwjN8VyXm0oE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LoN4UAsB7XyXG4z+nRIZ2QxCn4vU9W/0A/9ISt6mZnYCqBKjvKUeLsKUkb/kt2x/HTQdKwtLPFln60uqTrEk5SRRplCunylwvJYwg+vKn+znBUUJGvHkoQgfwKjfjEr5WtQ6HCEQGlFJclLDzFFqIg3OHbhM99SVdNBj16EPDVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Kb3EisiR; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 81FE53F22B
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 14:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727618564;
	bh=rHKx8mIJ5uIzbptOZkjeP2ZJIjmWzd/aEM3nFAlxFXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=Kb3EisiR98rWNoAQ0hKdOpXRntljj0WvklUAWaFtUsEvbUlNDXYYN+OMjLkZ2x+Yi
	 jGSVl/5eg1Z9pMa5tXwEGWOghW00osIcChvkKpeY4TUjYg0difIQ28duDDjEPHwJ54
	 rXvaLOSMcirUZRq64Z3EQvNDxwAh9Ip3qzIehbPWzPz6vUlso4LTGLtK5M9aI6I6tr
	 qo5FwZ9qEKhgHEbZ/IsuUooDUsSCYwfktCWy5sh6UIZ78MiHtWOu8QCxJ8ncEodPFM
	 J9oc3BOvlit+p9XlZvVOGQy+lJU7tNC9poZnxLXRZ+XVflG4JmdlZaFNsrLD1d68J+
	 19R1hZ9s82S4w==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb2c9027dso26556835e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 07:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727618563; x=1728223363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHKx8mIJ5uIzbptOZkjeP2ZJIjmWzd/aEM3nFAlxFXE=;
        b=gQZrbQ/Dv9P4hgISMQo9CM6dqIpwWZzmVdFTqoy2frfNaBVQpXXuQowDM3q7sZ6eJT
         nkJmge5QMGI/5pND33WECt3jMuMFZPoBCh72Szp3h8xl5ElTrSTcSy6yRvbMCJIkO8OF
         KJ+QMuDK8aIgOMbzBdScUQNzmk06xPbM6N/ajA1wZXf9yFK57hpzTUR2ok1CV7vrITh6
         mbrJ2RqnrDX+Xe16i+gqNsDq5RXVjjxOiARXPWIEbkngtKs+9ODwqgeeFzs7ZyehZziu
         lbDEiudupbY5BHM+HLwgfltdZXgr1/wWfW7p3ptUPaFfR/OBPrpDDM1i15LVxkJ23rth
         EbNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9ybGwfDqDA8RJAbeNSjWYuVjkHZ7KWAezaxwQTXiPb0FQwn8W+eniTjabCQuJJjkdpnTuGJmdOQhOqEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjvmWWrWMkCrf3zYfhVtBnZwz5O+saSsd4NlRZ06egp+lfyaKl
	o9UwVTcLAYORRGflqMX6uGAXcpn91R2mLyARadtWUhOmvXmnMmYKkZlCq3LhpietqUD2dEkXnYF
	VYTjWut0G5VKTuoxb9yp2BBRsBPF72Jxpe+ULKdmaRmMM1GI5f+HAcfuA2q5rklyVBYTsdCx5nK
	IJiA==
X-Received: by 2002:a05:6000:46:b0:371:8750:419e with SMTP id ffacd0b85a97d-37cd5b1050dmr4364129f8f.47.1727618563437;
        Sun, 29 Sep 2024 07:02:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpRsGnT/O5Zh2PNndGTBGCRoPiKJuRnaYvFSR823DBh5TYMOIXkdUslOOcZ+Mk5FUrP/jCIA==
X-Received: by 2002:a05:6000:46:b0:371:8750:419e with SMTP id ffacd0b85a97d-37cd5b1050dmr4364109f8f.47.1727618562729;
        Sun, 29 Sep 2024 07:02:42 -0700 (PDT)
Received: from localhost.localdomain (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969f23d5sm127805885e9.13.2024.09.29.07.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 07:02:40 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] riscv: efi: Set NX compat flag in PE/COFF header
Date: Sun, 29 Sep 2024 16:02:33 +0200
Message-ID: <20240929140233.211800-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IMAGE_DLLCHARACTERISTICS_NX_COMPAT informs the firmware that the
EFI binary does not rely on pages that are both executable and
writable.

The flag is used by some distro versions of GRUB to decide if the EFI
binary may be executed.

As the Linux kernel neither has RWX sections nor needs RWX pages for
relocation we should set the flag.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/kernel/efi-header.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-header.S
index 515b2dfbca75..c5f17c2710b5 100644
--- a/arch/riscv/kernel/efi-header.S
+++ b/arch/riscv/kernel/efi-header.S
@@ -64,7 +64,7 @@ extra_header_fields:
 	.long	efi_header_end - _start			// SizeOfHeaders
 	.long	0					// CheckSum
 	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION		// Subsystem
-	.short	0					// DllCharacteristics
+	.short	IMAGE_DLL_CHARACTERISTICS_NX_COMPAT	// DllCharacteristics
 	.quad	0					// SizeOfStackReserve
 	.quad	0					// SizeOfStackCommit
 	.quad	0					// SizeOfHeapReserve
-- 
2.45.2


