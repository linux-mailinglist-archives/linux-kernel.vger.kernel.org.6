Return-Path: <linux-kernel+bounces-177214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810758C3B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19531C20F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C717D14659C;
	Mon, 13 May 2024 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA89JUv/"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDCB145B19
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715582451; cv=none; b=FhXua73TCVzFBuqesUsEFV8TFoNthC2H5aEYyyS0r8BxbbKdpZNIkl8eGpPJjW/cnet5N2rkCOSp+OygmnZv01pG+Bt/P14v6ANHYknkxa+TIIQXuzk+V/hUFE3+RGBaceJtbRDrDb9l3vdU2n1b74y5BTmF/C8KGi2wME1jB+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715582451; c=relaxed/simple;
	bh=yxF90Br7QmOUK3LCw+6twJYKw/mQe+YkyyfE8V6KlyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GTCzO07UxaQMkEDJNcgfKrMHCecUJFlGthjQAQy/WYZ+Ttu9nulAP3Ih4AFUQ3RSj2/jF+n1MPHpOEwaMVnXMVOJt5DjEbi899VkgJNvmUX6XgkCDfVt9NGf94zlJaf+V2WCmP13CejVJcXezaaFUyWYzV0uMgtBIrgDs85tGYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FA89JUv/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5a5cce2ce6so208836866b.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 23:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715582448; x=1716187248; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LaWHbjgN9aI6ddaKT4LQDAGK2/D8k7lIaGHYUNMyh7M=;
        b=FA89JUv/FUYR8pTVDCtWvuuStOTXM0MTcwFDz7IveUWo26RgXXcrwa5cJYZrmgwLK3
         GTAfZtZJoPPxffvW53wojCkYDrOfDWIMnh/iT4kn4p+dzJ6CKEz3pLsVUA0eWsQqXGAj
         4gJlS8SWF2EytmLGUl154OykxggmFA9LgBsETld/6+voIFuEqHzo7VRRbdVZ7VpWyqZx
         GKco05/0JjJhVwDUQAJGhT7dH00Q6158xVAZmvVuR9FMQj9UW8q9udS5QWDZztN93xV2
         c5XvQqh9/rL31/n8jOrezQwwHQTGrobnHegsR47Zor92Y+IrzB4UEj/xOt5gu4PVvSl+
         lZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715582448; x=1716187248;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LaWHbjgN9aI6ddaKT4LQDAGK2/D8k7lIaGHYUNMyh7M=;
        b=bN3Yzb1DfAHIj985wZN7o2/dVcCSZYWmNRLHeFhS4a6wpXhDNBEdHTnvgskb8edXlC
         ojVm6WskXUBUO6KJsHfXxWertYJTzr3E72Eptr+oDLKeIkTcFMXWne8/OTNQTsrXaj1m
         e6MBrtsMhnccanfiUW85BVzYjRRGOpV74j/TwMXkjIihmaRPzGCQQtbnVu+ctNGeoDGe
         sjtSg/kQ0imvBrvZTum4FSE1/hXT2rZ2vHdZJz41hIoCbzyfS5z/n7oYRLHgBcLk3gAP
         vaQ0SXoQ+aEF++GW3uYb3gHsftYBkmQwCXswRpOx95AiQqz1PyVwgz+ixPqXKufdxC7f
         NYqg==
X-Gm-Message-State: AOJu0YyYoM6rL339+lw5RgTQNuIXZEVAfPB9d4pGqYP3Q2w6VUe7OnXX
	Y1nM7MH77TuXPqOJe6qHZ+Vda0c3kPTwI3JTZfQ7NaIfi+z9vZgsT7zq8PcN
X-Google-Smtp-Source: AGHT+IErj+YVRnyggMSvx3nUJ5R6ROHE2xdo+n/d3bEe+MPVQkLKgRmuUBQtz8QZ2YCtXJcenbylsA==
X-Received: by 2002:a17:906:17c5:b0:a59:c9ad:bd26 with SMTP id a640c23a62f3a-a5a2d54c601mr554093666b.12.1715582447380;
        Sun, 12 May 2024 23:40:47 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b014f6sm559294366b.145.2024.05.12.23.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 23:40:46 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 13 May 2024 08:40:45 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Subject: [GIT PULL] x86/asm changes for v6.10
Message-ID: <ZkG17XCNvUM7C0k5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/asm Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-2024-05-13

   # HEAD: a0c8cf9780359376496bbd6d2be1343badf68af7 x86/alternatives: Remove a superfluous newline in _static_cpu_has()

x86/asm changes for v6.10:

 - Clean up & fix asm() operand modifiers & constraints

 - Misc cleanups

 Thanks,

	Ingo

------------------>
Alexey Dobriyan (1):
      x86/asm/64: Clean up memset16(), memset32(), memset64() assembly constraints in <asm/string_64.h>

Borislav Petkov (AMD) (1):
      x86/alternatives: Remove a superfluous newline in _static_cpu_has()

Uros Bizjak (4):
      x86/asm: Remove %P operand modifier from altinstr asm templates
      x86/asm: Use %c/%n instead of %P operand modifier in asm templates
      x86/asm: Use %a instead of %P operand modifier in asm templates
      x86/asm: Use "m" operand constraint in WRUSSQ asm template


 arch/x86/boot/main.c                 |  4 ++--
 arch/x86/include/asm/alternative.h   | 22 +++++++++---------
 arch/x86/include/asm/apic.h          |  2 +-
 arch/x86/include/asm/atomic64_32.h   |  2 +-
 arch/x86/include/asm/cpufeature.h    |  5 ++--
 arch/x86/include/asm/irq_stack.h     |  2 +-
 arch/x86/include/asm/processor.h     |  6 ++---
 arch/x86/include/asm/special_insns.h |  8 +++----
 arch/x86/include/asm/string_64.h     | 45 +++++++++++++++++++-----------------
 arch/x86/include/asm/uaccess.h       |  4 ++--
 10 files changed, 51 insertions(+), 49 deletions(-)

