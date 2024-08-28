Return-Path: <linux-kernel+bounces-304347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2570961E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6B3B21EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925B6158546;
	Wed, 28 Aug 2024 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SdEfP3uD"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E86E158214
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 05:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824186; cv=none; b=uSus9Vdk0NoLYe8pohyjnMILOw42qgbw6pUTHjz3ROXfSeMBmVHNqoSWrzRWORdajjH+Vfs2F2oTZ+9CMSluh7jDvGInmiDI3kJkMY49NlyS+vqkvOB/1jmAUOIsxk4RCMzeKwLfWhEpA3o4Qr4WaN/tpjoQd/nZHaY7ZBMQKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824186; c=relaxed/simple;
	bh=h9Jl0isly8hfO1RunVOJNqZoeZvdanuDoXET0lufwJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HJF3EozhAf0VpRu/jZCZxuovjiLrN8bJG9xSXm35zfEtA/x2dNZl8diuzve8Qx84IoTQ5FSTc/+8+6hES7ld56RkwL05bcMgwOyKc6OQ/+hqTmXQt4Y34imsfJFuVyajjhjyJYPw3ECtGVL9r4CGgvPXfDqD47R5wqYZO1nljlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SdEfP3uD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201f7fb09f6so54510985ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 22:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724824183; x=1725428983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5srBcKEXlmg65Adrhp9lVjL7ktMhhBJWYWob6ko31g=;
        b=SdEfP3uD3zsNjVEX1Pvh5I+ZIZUakaUIzBEKiPkmhSm3NWP3i48Vox5K7/qd4G01Zj
         nedYNM/PePwBL11dBTmfx/BT9cUcK9iCb5WYgSxijzDNQ/wte+Cx8MIKUPgWNj35qJra
         k3hb+Bqtg9fCrGUwcGaty3kxVFvcjVS1+lB6ZMxDqQFELzeakNjL2v/2rFYfNRBr77gW
         Yh9/ieECY6bcTGEqt96y1TkpVRGOx/0vwR1ookdlxbE5E0aPJUWvhWhORs8dHuRFzyjx
         rsTcxqhrvJyNhMvOaszQfngUQKGCMA0BbU15eU8LRqbQkYC0ThnobpJAEHjgQbH3xH39
         YBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724824183; x=1725428983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5srBcKEXlmg65Adrhp9lVjL7ktMhhBJWYWob6ko31g=;
        b=NSxUmCmQFgcq/B5BSKwTSyWZDg/vwBhCI+8AOxZ2Q+IPI7nfBnDUak/lZ35zqhfcdp
         lT22lccMWelYGjqnV8kS6u1P4CqNpDdxyF0mdtRPMO52ui8gBQ+Bj2EmLypHZ8btEQPz
         jvk6q7uqhhHA8Nh3NQzZeCAE5VAPDENh5xZvvSxqQSlXqDu3gXkLhF368GsEgQfNHAcM
         zb5oLJHQEs2HOz4uCpedQ++c4awQZYDbUETZ7M/nKEwCbKL6HweyTCA95SVjrhQCxj1u
         KkwsGDfLTHe6NesQH0nXNJdpKGCOXP8eq6meLXAXR1s8Nfuhde3dzqxM5VlnIo11ulni
         M9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXmEnH0Aobg/q9320kgfGdrTItpQ71XE/gJMuj9EcJ8Civ36nktdF8Nz90MgmPuXrFDcsWopP4VO2sVeF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR8KgEZSc7b86o8CCwk82Bpuzck6tKqK/boPEn4EnYe/tqMRbJ
	72iaTHe1PA4/KDJ4cI9Rgf/CjK4ablrjJmvjGNW4buCxZW7cwzvvFw8l1Z5XBI4=
X-Google-Smtp-Source: AGHT+IGHu+eM9GywkA2KKhkiXH1gwQVKDtYtrmu0o3xp962KqVz7yKVZ3UFfIj7ogPOJug6LrKMhnQ==
X-Received: by 2002:a17:902:e54c:b0:1fb:3474:9500 with SMTP id d9443c01a7336-2039e4ab846mr148619915ad.27.1724824183237;
        Tue, 27 Aug 2024 22:49:43 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df0c4sm92092495ad.157.2024.08.27.22.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:49:42 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 27 Aug 2024 22:49:11 -0700
Subject: [PATCH 05/16] riscv: mm: Support MAP_BELOW_HINT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-patches-below_hint_mmap-v1-5-46ff2eb9022d@rivosinc.com>
References: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
In-Reply-To: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
To: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Russell King <linux@armlinux.org.uk>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Shuah Khan <shuah@kernel.org>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mm@kvack.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=921; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=h9Jl0isly8hfO1RunVOJNqZoeZvdanuDoXET0lufwJg=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9q5XXFHufOLGl2Wf1oQkLR82ZWndTOfPt314eCzeyv3r
 BZKWtO7oKOUhUGMg0FWTJGF51oDc+sd/bKjomUTYOawMoEMYeDiFICJNPxjZOjefGX9Tl/G6Irp
 nxS+dN0zOpEeMVEk78LzG1JnNgQw8RYzMpwwaro+TU52Snefw54npdeqTGoNrXMnik1KMY5Wjl7
 KxwgA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

When adding support for MAP_BELOW_HINT, the riscv implementation becomes
identical to the default implementation, so arch_get_mmap_base() and
arch_get_mmap_end() can be removed.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/processor.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 7ff559bf46f2..20b4ba7d32be 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -14,16 +14,6 @@
 
 #include <asm/ptrace.h>
 
-#define arch_get_mmap_end(addr, len, flags)			\
-({								\
-	STACK_TOP_MAX;						\
-})
-
-#define arch_get_mmap_base(addr, len, base, flags)		\
-({								\
-	base;							\
-})
-
 #ifdef CONFIG_64BIT
 #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
 #define STACK_TOP_MAX		TASK_SIZE_64

-- 
2.45.0


