Return-Path: <linux-kernel+bounces-168934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E24B8BBFE9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 11:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B236E1C20C02
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 09:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B12B7470;
	Sun,  5 May 2024 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1j3wqXS"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68AE567F
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714900450; cv=none; b=rPebyiH/APdN1Glz6+6c+gfnNwojGSNzajBk2Xt4inMrJEOffHwj5CUpGS1wj1DtFchQQjp9tR8jGbRhL1oUEJ7NOq001zh7nattTi/BTvBtd9z6gIYWZl8xqOp2cVKhQ7nRpkXfwXlG5p0U7UjxEBQxoFHObRdobPP1zhbICGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714900450; c=relaxed/simple;
	bh=TyuZWegX19rqyKTf0kKbcyrdgJXHkTuZZ+Idt5a1prE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ggcPIGM218br4afG8MVgKXGu1c31NNsZYnZOon4jQCvuu+DsxqfnlhWfYgHBne2JqVvhI8HsooLRVM6yU2jOUXwNBmdyneOwOSXTHk+CY9tmFdxw7oeQjM6KflHhhnoUiazAAbRQ7IDSHF9IG6VyBNZ4A6JW/yqrXKfO2GvDkqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1j3wqXS; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a556d22fa93so210920466b.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 02:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714900447; x=1715505247; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=j+IzeSIAzspeIPsP3FgMN2XPpbtWtWKA+rDgxZgout8=;
        b=i1j3wqXSPvs1q+ojymbEfgJXSMZTFuuesZdoAUkX9HDPmBvy2EIlisMPLfVjaGN75X
         9dWSsaWMEB97iWolIn5xZrTYmxZhEopMPBI3NOF+U8S9kUjjBe7VmJsVgA0DqjdEiO4q
         Vx7JovgdN6KVkzx2stKwM0d1ud75dVdLe5KZRwJPxMS3YMLdQdZQrr1El88bucYZyvWR
         6RJ8/ejIKE7xucb9+sjkVohjLR9JQzNYSqh266YF0XUiAYIYuQnkXERMsoiGlvn6hT1w
         ZgB2s53Z24Ehq06EeHMWho8fWImEuSaESN2EChq9WWqJr0/LfdpC+eHf4cl4QcO6vTs8
         HpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714900447; x=1715505247;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+IzeSIAzspeIPsP3FgMN2XPpbtWtWKA+rDgxZgout8=;
        b=tVQK/KsK+nQJlptH3VPICeF+fw8u2rCrbTW7VVMTVBcdJqPUxF8I+APZagxs0KII8T
         VfVKuRLDdie6isgHg8WicCh90TVctofk/M4UP7Y6Ie8TPHa3Ikk5O/Dp9gi9eHh+1rxc
         lfHGiQtSZ6aWuctQGWvVR+eBVEbrFVBfUVkFnMsE8CMloc+W9BuAzpvfqbaXHagNc/H7
         JFB8Nr42K/yCHXnr7/UjqXZrTmCB1ECq+mfSSuZL6FxdQMxZwzo2aFG2cV0EuM7HGMOL
         dC+sjIXcsvSuMR+6Ir+3m+XKtgrCtFqfH6FjjJmq7xpxNlISNczjPzb2PBRNNR5Y+z6x
         PG0Q==
X-Gm-Message-State: AOJu0YwYrpN6SZr3n9x+C00/BE5xd38jWoBcfoTJ4udKfvhMaJVvsma4
	gmD0aT8IZNb6cNB001p/LPjdhYp9LeWxn5Gx16hgWefh1gZ6HSzF
X-Google-Smtp-Source: AGHT+IGAIiDmvkfnk1Zzn0UsZxeosFo7CsWKs3O19T6fRarlOMJZNamwu8pkz+zILpimHHYVFsSPWA==
X-Received: by 2002:a17:906:2bc4:b0:a59:adf9:611e with SMTP id n4-20020a1709062bc400b00a59adf9611emr1610515ejg.36.1714900446776;
        Sun, 05 May 2024 02:14:06 -0700 (PDT)
Received: from gmail.com (1F2EF54C.unconfigured.pool.telekom.hu. [31.46.245.76])
        by smtp.gmail.com with ESMTPSA id i20-20020a170906445400b00a59bba81e97sm839922ejp.126.2024.05.05.02.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 02:14:05 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 5 May 2024 11:14:03 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <ZjdN2w4vdyWsv3e7@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-05-05

   # HEAD: 02b670c1f88e78f42a6c5aee155c7b26960ca054 x86/mm: Remove broken vsyscall emulation code from the page fault code

Misc fixes:

 - Remove the broken vsyscall emulation code from
   the page fault code.

 - Fix kexec crash triggered by certain SEV RMP
   table layouts.

 - Fix unchecked MSR access error when disabling
   the x2APIC via iommu=off.

 Thanks,

	Ingo

------------------>
Ashish Kalra (2):
      x86/e820: Add a new e820 table update helper
      x86/sev: Add callback to apply RMP table fixups for kexec

Linus Torvalds (1):
      x86/mm: Remove broken vsyscall emulation code from the page fault code

Thomas Gleixner (1):
      x86/apic: Don't access the APIC when disabling x2APIC


 arch/x86/entry/vsyscall/vsyscall_64.c | 28 ++-------------------------
 arch/x86/include/asm/e820/api.h       |  1 +
 arch/x86/include/asm/processor.h      |  1 -
 arch/x86/include/asm/sev.h            |  2 ++
 arch/x86/kernel/apic/apic.c           | 16 +++++++++++-----
 arch/x86/kernel/e820.c                |  7 ++++---
 arch/x86/mm/fault.c                   | 33 +-------------------------------
 arch/x86/mm/mem_encrypt.c             |  7 +++++++
 arch/x86/virt/svm/sev.c               | 36 +++++++++++++++++++++++++++++++++++
 9 files changed, 64 insertions(+), 67 deletions(-)

