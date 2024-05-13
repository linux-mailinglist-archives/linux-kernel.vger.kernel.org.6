Return-Path: <linux-kernel+bounces-177233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD868C3BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1AE280FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EDB146A6C;
	Mon, 13 May 2024 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRVnhgMk"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2693E1FA1
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715583809; cv=none; b=s8fw4nWAMgZ8LinrkM37TLAIQoR+XBJQ/mw7cA9AnfGoiWgLKlLE+GxipbktRO5c6s9zdjvBGU3voNFW2llTk2PCibcte6ylNKV8A7J53iLyIbk/jyrUAnZ3d4j4CLJXEWfeOMhjH5W4TRvatqzkxT21hu73PQhoIV+xFJg/ZBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715583809; c=relaxed/simple;
	bh=ONdJxKlfhyNXebBPQPra4Xv6KPjeaTlP2lRULfxOxYE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RKq9aJlB3RFNXs1ei0/PRzRp/VnCCm5awuSzCvOsaTgMKfvH8JfBPYsbPaoYs0ZHEL81twJ2dSGmAgGXKy5kW5GVYq6N7iPDVzeJyVJSpZI7CXmDzGGssAizJ5qAOr3R9Wsbi0uSk24x1v3Al29Hx3XzomDB0/v/JhOwXToYat8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRVnhgMk; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59a64db066so992416066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715583806; x=1716188606; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UB9MjKNzc+XYuQAMT6qF9iPxqKBm5lo44opn5r+P9mI=;
        b=HRVnhgMkeJpy6tB2ZxH1EWLJ3vyCYeVPZU+AwJuRqx+dxO6KlL6RuJsTnW+mlJeE72
         wP7ek+SHimwmKt7fXf8ZTjEz0+HYXM2R2hfaACMQ77ClJV2DWd5HY1T6UOJ1XtwIFrqe
         MfpDOva4GfRSft5ypY7lSyDWF0uLB7oRCiNdhEbGV9A5KU+8n8djleLvEZirE4Y5X/xy
         dgsVhnFPM8bJ5KYdNAfo2Gtv5qwgUN/LP70AZptPSSMsjNtIcKbI3bg9FD92roNZidln
         V9SieiXgMUYXM0aAn4zaJhY7X3+pRtoROoOzZEWIPyMspPlmcihVFuDV9HTenG+EqYaw
         zN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715583806; x=1716188606;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UB9MjKNzc+XYuQAMT6qF9iPxqKBm5lo44opn5r+P9mI=;
        b=q8siS5K6a/Vw9HDsPe15fOKOs+9TNjDisQEuO1NUVsCfx+sXm6eQyh01QcraAf+CEG
         eOAo6zWmLDPWWmFMWyz4s6lkGpu7JE+6MD1riqmPm0OYiMtMpvkrJCSU3tHSE09IFlRK
         VudWmU/T9e2CRzSrWB+ZDCalzRXtWqOsqTudbja7sqOyfNU1IxkM+9K+ardODWXya584
         cLMbQwNnszk1HSEcsNQPOVSr2qZwv6V29kKfNUYh6vbzG3Z+AnGcdbJs/ZtjmzB+omDX
         hwAVoJxSeFuGpbrhk0an2onpG/PX0e1ULxgDvppHZjHLWd00m5Jzxl7J4vmQUpc1L3Vf
         rY1Q==
X-Gm-Message-State: AOJu0Yy3UaGIMhiF3oJm2R7U12yFEZBqUFMMMaDufFPMF8rPb6nOXaWj
	MSVa/XEqDeBW5zzXhD71EmGB55uf67J17MADXJctY2QM/zxnmsWdaJh15JpM
X-Google-Smtp-Source: AGHT+IFKvNWgi3mVl/tyu1Ht/F7pKiRvFDS7Mg6KhuQG7bV9n7TpHx1GTpshxsDOji0Q9EAyiutjHQ==
X-Received: by 2002:a17:907:119a:b0:a5a:1df:a0ae with SMTP id a640c23a62f3a-a5a2d53bb30mr624098566b.7.1715583806232;
        Mon, 13 May 2024 00:03:26 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b0145csm551856666b.158.2024.05.13.00.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 00:03:25 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 13 May 2024 09:03:23 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Subject: [GIT PULL] x86/build changes for v6.10
Message-ID: <ZkG7O1JtDp8vDNH+@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/build Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2024-05-13

   # HEAD: 71d99ea47fbd3179e01f8037aad1d1367a821de2 x86/Kconfig: Merge the two CONFIG_X86_EXTENDED_PLATFORM entries

x86/build changes for v6.10:

 - Use -fpic to build the kexec 'purgatory' (self-contained code that runs between two kernels)

 - Clean up vmlinux.lds.S generation

 - Simplify the X86_EXTENDED_PLATFORM section of the x86 Kconfig

 - Misc cleanups & fixes

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (1):
      x86/purgatory: Switch to the position-independent small code model

Masahiro Yamada (1):
      x86/Kconfig: Merge the two CONFIG_X86_EXTENDED_PLATFORM entries

Wei Yang (4):
      vmlinux.lds.h: Fix a typo in comment
      x86/vmlinux.lds.S: Remove conditional definition of LOAD_OFFSET
      x86/vmlinux.lds.S: Take __START_KERNEL out conditional definition
      x86/boot: Replace __PHYSICAL_START with LOAD_PHYSICAL_ADDR


 arch/x86/Kconfig                  | 26 +++++++-------------------
 arch/x86/include/asm/boot.h       |  5 -----
 arch/x86/include/asm/page_types.h |  8 +++++---
 arch/x86/kernel/vmlinux.lds.S     |  7 +------
 arch/x86/purgatory/Makefile       |  3 ++-
 include/asm-generic/vmlinux.lds.h |  2 +-
 6 files changed, 16 insertions(+), 35 deletions(-)

