Return-Path: <linux-kernel+bounces-203951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6358FE23C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EBA31F2165F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD8913DDA9;
	Thu,  6 Jun 2024 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbWlIRBj"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DEF219E1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664774; cv=none; b=pMWnsbz3k3777Mh2TazBjFkxTEIyKLYdNK9u1IniLP9toLDwCwy22sbX5wS2dQZtNt7RxlujVZvVmcDwyLCITcjkNQqjEuQCaSS0r0rgSkI88R/3H64vrwY4gDmg9MTBE05pBKi8G1/BHHdb2aVZ51eQcD52/2kHxj2WgY+jedk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664774; c=relaxed/simple;
	bh=0s2tqnVZ8o1Ooqq2REO8kb7fgRVkVQI1Jj3HyXpVWSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvPvSnEE35JI4ouBTuxA7J89c/uy5dbUI+OlRShUQsTgaqgH2sH4fkSkFL6ZaajtwAxwRyRiNal70EAFHr2N09FjIgueS20DQwYXNGJFrxYXTDeLeypywHMhVR2LyJs8BJ1Dj/a0xzfWO6eFJcMHzPqCtYJeVYBgISU2be8Axsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbWlIRBj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42108856c33so10683315e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717664771; x=1718269571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnszw8n4L4YEghZrXAC4hBn0cS9S211yJ6LqSVtlsjo=;
        b=kbWlIRBj0lCRKLpuMZqZK47RLxX9y/ntPC/kQD4FtVjCaX9A92ygO6APg9Ni9+l+hW
         1LySBS++RWaC/HToyFwxKkjMeKH1WIG8O23L+FfAwElNojZGFlMrtH09SW38JwAk/l3E
         ldwutRpPc/PSfmG1pT5vljd7vdNscoGunnWoOkqakNEizA+LWzX5TbPxj/DRb13GDteo
         AZWHUagUWr+yB9w9pve4j0Kr7CALNKltmZ+ZHnHvLpdbOlSnjpzW05+U8AywRGIw0Vg1
         3fmNoBpV32Q2bALpFGDeBQpQR4m78EV6QcXnEnAxOmS/xFvPClO54pStrKnZCVTIWQ85
         ROFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717664771; x=1718269571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnszw8n4L4YEghZrXAC4hBn0cS9S211yJ6LqSVtlsjo=;
        b=JoIvJPgHubShNip2Wi0IdgQHRiZtywDulRA0sQ32aBR4tiO3SKeLH84/Dyft9sXIC8
         RLc/Cjy3y1Vdmb2Iu5GX1JLvYvn7oXIcqBG3X4PsmStul0Jx9D6ItuV8TXZ+7QATBCWE
         k9j0iDC/Uwli2UNWum6+mD9d87MBrk++xv6/arVXq5wWoSHdJVopeEtULPwYOKqtU2NC
         GzQ3Gh+Sp4EwyBIo38nPK0KE9mghw7ox6BpiDBDYWs36FQaiDXY1mKgfJrMhsEXdFY1b
         ViYwF1e39ELsWezioV8BDVOtwOs/4P6SxESHYsxsn/Bo36X1sf7YY4WjHCTxWsNu8NN8
         TlCA==
X-Gm-Message-State: AOJu0Yx3nzuZV7N6/F92BhWRSFsrGVv5KaKDHp4slbOND+vxZRbqqXjs
	N48Qr9focBdgu+m7mslDu2TqzXEa2fGyr6QVpfC3WRfqLb8gLFJM
X-Google-Smtp-Source: AGHT+IFMhC1oPfyKrsZlAwV/OdzyxsBoH7hu8OS9Q1I+NglNdPIcimhJGIe+o1W4wru1RzDuoKmfMg==
X-Received: by 2002:a05:600c:4fd4:b0:421:38c4:1829 with SMTP id 5b1f17b1804b1-4215ad1f9acmr16393815e9.13.1717664770714;
        Thu, 06 Jun 2024 02:06:10 -0700 (PDT)
Received: from gmail.com (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158148ffasm50087755e9.38.2024.06.06.02.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:06:10 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 6 Jun 2024 11:06:08 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH] x86/fpu: Introduce the x86_task_fpu() helper method
Message-ID: <ZmF8AH0TX_lgkxS5@gmail.com>
References: <20240605083557.2051480-1-mingo@kernel.org>
 <CAMzpN2hms-cpsaief4j_1LhXXznreE+it8nnsH2-8yoQ2Bn0Rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2hms-cpsaief4j_1LhXXznreE+it8nnsH2-8yoQ2Bn0Rw@mail.gmail.com>


* Brian Gerst <brgerst@gmail.com> wrote:

> >  17 files changed, 104 insertions(+), 107 deletions(-)
> 
> This series would be better if you added the x86_task_fpu() helper in
> an initial patch without any other changes.  That would make the
> actual changes more visible with less code churn.

Makes sense - I've split out the patch below and adjusted the rest of the 
series. Is this what you had in mind?

Note that I also robustified the macro a bit:

 -# define x86_task_fpu(task) ((struct fpu *)((void *)task + sizeof(*task)))
 +# define x86_task_fpu(task) ((struct fpu *)((void *)(task) + sizeof(*(task))))

Thanks,

	Ingo

========================>
From: Ingo Molnar <mingo@kernel.org>
Date: Thu, 6 Jun 2024 11:01:14 +0200
Subject: [PATCH] x86/fpu: Introduce the x86_task_fpu() helper method

The per-task FPU context/save area is allocated right
next to task_struct() - introduce the x86_task_fpu()
helper that calculates this explicitly from the
task pointer.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/processor.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 920b0beebd11..fb6f030f0692 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -507,6 +507,8 @@ struct thread_struct {
 	struct fpu		*fpu;
 };
 
+#define x86_task_fpu(task) ((struct fpu *)((void *)(task) + sizeof(*(task))))
+
 /*
  * X86 doesn't need any embedded-FPU-struct quirks:
  */

