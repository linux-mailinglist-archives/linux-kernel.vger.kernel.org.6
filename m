Return-Path: <linux-kernel+bounces-189334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C088CEE8E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 12:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E9B1F21666
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 10:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C490E2C6A3;
	Sat, 25 May 2024 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myJdwF+C"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDA8249F7
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716633576; cv=none; b=HFpeMm3FE9Rl641uk+xXqsodtzST64/xtLWldVEn8WTx64rgMpWZdLRlfLFG3ZPrYOQDmtU9pTbZpRgPrYLtGSZbf9jnLiiybn+IjZkFjiAjR92u8syoLhiXozcQpMyCs32xrnDB1oFM+81cY+1taFsyruMYH1HUR4dQ2fQAk8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716633576; c=relaxed/simple;
	bh=5534t604xlfM1KrlT0OVz5l+fJid84/A+r/s2pnicsw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nlcv+3uXTaf+S245hCkP/AFgWZHIlZXfNVQ6EX5CzOxbYhxsqNquR+D4xAIc9vEqUUYJUMEnHGw7b56xGRNeAE+ftrlARlYNAa4MdnKCHoBUBwLzBUxFZ+ahbsoueMEJB3NtUD2ozaq52izG495O4UVqO+igLco848CbqKWUmOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myJdwF+C; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-354df3ee1a9so3660432f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 03:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716633573; x=1717238373; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DwWYavkRGaW305jNA9vDx6y5y0qKQeWqgMlOSirm2Sw=;
        b=myJdwF+C5B4t5VhiQBR5rSfWz1EzgNWyW943TbZGWzMc/Uqo5kdjIm7RFEfWKOkEBP
         qLBFKN3zsEBE8X4uVhMYn4AtpI/hqZ0gHQQxWjAg17DlGd9BV2powdnkFAudTbLMn6aA
         xVHVceWSXpURQfraEV2M0ib/DD25j4wdcQCdabyZ4xdFMmYb928HrB5x5C7TXw1Mlt9p
         BOnw/eIQpOoZv4dPNjcTmkoV+QMjEkXCP4NwxWYUSkcGd3IdBYZcR0wRnjX6AoTF1J2O
         L6o/Vz+lyEXsSwRBs3AEo93Qu+9pBLs6dRYrLSJr8v1PW5P9kQN+nR+Tktn0zdf312xV
         sx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716633573; x=1717238373;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwWYavkRGaW305jNA9vDx6y5y0qKQeWqgMlOSirm2Sw=;
        b=ImKJHCkYRr1z/7PJpE5JYgAh71ZQ8SqmBgUdks6wlxj9SbyTIF5TG+6oIJKvBBED7e
         Bzt4lctiXTDorm5/wfgOeps3z2n+wR/auaEWjVnEPYlSy0W8PYFnpK4zcizTqPtvy8/E
         q21NcOxfjLAJJq2AhEESiEBFC0DJamXGq9yqMBcDjWCuzmNT+vPB2j0ukVESMEsVi0no
         Y4CJxPzpCO0i9myaD50nFbqLnK3gLHNiSqEAakOReA85ImkkcN5mX/r7jDfCRXzuVOHm
         pugiyBBcsQ6QeUWbwC7uw/sKmSooP9OdBwwbnOSGf4Vu60h8C9eMv2DoDRF7hwzFN7Dh
         vysg==
X-Gm-Message-State: AOJu0YxmHM8+l3X0rAXyWqrihe/5WLlmus7/YNQyF8kZ4kNdZ7JDenLP
	voXWZqtM/fgqhTBv3wgm5nuMX2eZtwVe00PxlMx43NuHiqNMcKmmQAUJ/Wz2
X-Google-Smtp-Source: AGHT+IGnSSj08w3r+amtzZsjhXbjCkSYj/LBzKPsipj4xQE0bRt7O+k+JoedrHmlmqLMDtlP0s+0ZA==
X-Received: by 2002:adf:a38b:0:b0:354:dde0:97a5 with SMTP id ffacd0b85a97d-35526c279c8mr2934504f8f.19.1716633572393;
        Sat, 25 May 2024 03:39:32 -0700 (PDT)
Received: from gmail.com (1F2EF63D.unconfigured.pool.telekom.hu. [31.46.246.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a08a899sm3705935f8f.37.2024.05.25.03.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 03:39:31 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 25 May 2024 12:39:29 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <ZlG_4Xvh7ssQrUYL@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-05-25

   # HEAD: 93022482b2948a9a7e9b5a2bb685f2e1cb4c3348 x86/cpu: Fix x86_match_cpu() to match just X86_VENDOR_INTEL

Miscellaneous fixes:

 - Fix regressions of the new x86 CPU VFM (vendor/family/model)
   enumeration/matching code

 - Fix crash kernel detection on buggy firmware with
   non-compliant ACPI MADT tables

 - Address Kconfig warning

 Thanks,

	Ingo

------------------>
Masahiro Yamada (1):
      x86/kconfig: Select ARCH_WANT_FRAME_POINTERS again when UNWINDER_FRAME_POINTER=y

Thomas Gleixner (1):
      x86/topology: Handle bogus ACPI tables correctly

Tony Luck (2):
      crypto: x86/aes-xts - switch to new Intel CPU model defines
      x86/cpu: Fix x86_match_cpu() to match just X86_VENDOR_INTEL


 arch/x86/Kconfig.debug               |  5 +---
 arch/x86/crypto/aesni-intel_glue.c   | 16 +++++------
 arch/x86/include/asm/cpu_device_id.h |  5 ++++
 arch/x86/kernel/cpu/match.c          |  4 +--
 arch/x86/kernel/cpu/topology.c       | 55 +++++++++++++++++++++++++++++++++---
 include/linux/mod_devicetable.h      |  2 ++
 6 files changed, 68 insertions(+), 19 deletions(-)

