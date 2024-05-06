Return-Path: <linux-kernel+bounces-170000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B698BD071
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F97289889
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6130115351B;
	Mon,  6 May 2024 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSRwuZut"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1302D152DF1
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006319; cv=none; b=MYlrK/XiEWCVpT4OeLoMWRIygytZ9ckv2mYsqYcf5Ysqm4hy7skQKPN+FKogeN3ezv814+HB+/0vALHk+TubQtEHSxsLfBY6Z6f4fq1B8xe22fTeqRNUNC7SscqiWjJmo+4txWmj3MA9FIIiHIaZ/FQlH5NL9Hh4ycjGMyfsSi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006319; c=relaxed/simple;
	bh=xL+slvlMHKNXO7juHQ1bTxdfrJhU58SOc3JoQytqDE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiyVz0uDAoqpoHnfaNSKMf3C4/BVRHnVVR3HfGekSMf+o6map44m43rYdKAeIT8PeBunDV2/HDQgB4A4Qn01FYn/MFTK1rnpTDxF+nt7avmfGy4r7SJIcQlTMw8lnQpg6Bnrr5hS1ldv98eY1pNrr4+PXwkb9z4c1blyjV7lsCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rSRwuZut; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59a0e4b773so461848766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 07:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715006316; x=1715611116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=102JG5apXBGrIa57cE4M29Xyb7pBgwDBKRD4HbgTxuc=;
        b=rSRwuZutZCX7eg4MS59Kx0nsKunFdsvDbBXgMEXJu/6D4BgdLLXKhw3FLjPXYFbquM
         6rHTlxM4IWoXWXhV2Uv0bILHiwz4XjjNZVFMq0k+SJmYqNNheOpOwR2Rp1lRiy2eUEd0
         4u0FHEgiy4AtRTMTwYds0tUslLUeky7EwFVMdeI4SmPKcUn9hvszSLmUtF8SYCGFPZUl
         12KMFyzQHV07itlpvdalGpIypc0Flcl+EwdGdWpDnyCdhlH3bk4/g2QtWhBbxeu6oqv/
         RQsqqDywOlzoRV7b6v645Zv0ydgLAXJRByhuE9Zde+V2IeLJvwQGoMoieEOKNgf0ZYR5
         oU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715006316; x=1715611116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=102JG5apXBGrIa57cE4M29Xyb7pBgwDBKRD4HbgTxuc=;
        b=P6WUERNAkkJ5bsossVxf8BAMSDregeb7IcbpBtW8fgZWMRddbL668l5tYkg/mYY2Bs
         ge5lI6sscgcO+2MtLLiitUOktAuXr3MqRtku+cI1qnHAqEiiple8IrXgs2Ws9GkFUvGm
         syIS4e/iRn7DfEIdKGxKKb+Kcb9hW3lX0LtktTDYSDhxBX1T4VUwNBQpE4nZobxqMmfk
         FAETGbh7TZDD1/Lo79/vrhBi3H3f/VxhlwTQnNKeBiL8vGfWtUi2aSyBbD9WrJrrqjPa
         S0Rd08d1J+z5u+8cbaq9akojpuFXKgOy85nXiMbd401GHMarQmFlyk0gi3EukhoSDUEd
         q34A==
X-Forwarded-Encrypted: i=1; AJvYcCWWPQ/6mM50A+s42QHwQGC3rxPJ03crGbVM6q8fzTMImnQiXE/HgmTJNpCG3V6aQtAZnPjjR+kH78t16ewbrMHUQ9JNeLYJPfwMOHJ2
X-Gm-Message-State: AOJu0Yw0z6UMmz81nKx6731xt7zPrvDu0mI4Vc4KsUNX497HE2FG7S1I
	nhy/3NMIpk8b59eHtBc0HparLxfu6p3h5ZtXm2saZFE9LfU3ADbmKCyXHMXgeNhd2yo+cZAbrrp
	ZG5TkAlWz0Lu9eTrWkcpEKT4Z441Me/uUpvuN
X-Google-Smtp-Source: AGHT+IFFyrHpfeF9cVImvJkE9ObGZRWKkpGXrbBpT6xCxnHxBmUGcgIO91KRtNxfWTXkngygP76Edx6YtUr+eGGWeKw=
X-Received: by 2002:a17:907:100a:b0:a59:a727:1e8b with SMTP id
 ox10-20020a170907100a00b00a59a7271e8bmr3866049ejb.1.1715006316077; Mon, 06
 May 2024 07:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418012835.3360429-1-yosryahmed@google.com>
In-Reply-To: <20240418012835.3360429-1-yosryahmed@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 6 May 2024 07:37:57 -0700
Message-ID: <CAJD7tkZmDQi2HBOxe5u-Lji88NDuZKCQ_=N_O5aE1nq23aUPqw@mail.gmail.com>
Subject: Re: [PATCH tip:x86/mm v3 1/3] x86/mm: Use IPIs to synchronize LAM enablement
To: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 6:28=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> LAM can only be enabled when a process is single-threaded.  But _kernel_
> threads can temporarily use a single-threaded process's mm.
>
> If LAM is enabled by a userspace process while a kthread is using its
> mm, the kthread will not observe LAM enablement (i.e.  LAM will be
> disabled in CR3). This could be fine for the kthread itself, as LAM only
> affects userspace addresses. However, if the kthread context switches to
> a thread in the same userspace process, CR3 may or may not be updated
> because the mm_struct doesn't change (based on pending TLB flushes). If
> CR3 is not updated, the userspace thread will run incorrectly with LAM
> disabled, which may cause page faults when using tagged addresses.
> Example scenario:
>
> CPU 1                                   CPU 2
> /* kthread */
> kthread_use_mm()
>                                         /* user thread */
>                                         prctl_enable_tagged_addr()
>                                         /* LAM enabled on CPU 2 */
> /* LAM disabled on CPU 1 */
>                                         context_switch() /* to CPU 1 */
> /* Switching to user thread */
> switch_mm_irqs_off()
> /* CR3 not updated */
> /* LAM is still disabled on CPU 1 */
>
> Synchronize LAM enablement by sending an IPI from
> prctl_enable_tagged_addr() to all CPUs running with the mm_struct to
> enable LAM. This makes sure LAM is enabled on CPU 1 in the above
> scenario before prctl_enable_tagged_addr() returns and userspace starts
> using tagged addresses, and before it's possible to run the userspace
> process on CPU 1.
>
> In switch_mm_irqs_off(), move reading the LAM mask until after
> mm_cpumask() is updated. This ensures that if an outdated LAM mask is
> written to CR3, an IPI is received to update it right after IRQs are
> re-enabled.
>
> Fixes: 82721d8b25d7 ("x86/mm: Handle LAM on context switch")
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

The merge window is approaching, is this patchset ready to be picked
up? Is any further action needed?

