Return-Path: <linux-kernel+bounces-209570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DFB9037D5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C185284BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5A0176FC6;
	Tue, 11 Jun 2024 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VVoEClD5"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59321BF2A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098227; cv=none; b=Xdf5ApI+po3QnvpNVsMzqcGdoNH5vbjZPWWtdkO3W/T1PHPKbcpcoMvZH05x79xfIz9cTi0ZHtP05Fgn3jRwxUoH6vKxGcO0pwJDpsVc7MBSdL4jpJwe/D3IJrg55hAHct7iUwkzaV5lCR9kZvWVxgYiScLil1xoKzh1OYqAa7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098227; c=relaxed/simple;
	bh=nXEsdQt4QyeAtiAdCClsdUMroXo5h2/rqQshG483cYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4goXo4yR+RCLYfE00NaFlFCrzXTqOwevC9BAE15sfqJG/SO9+O+Oz47FAXfarohB4kgf8zwZ4wQjd57U7rjIcvqcEBNTaD3aoUfFWx61e1BCYBWGY9YyrZDsUPlH7XJCs9xX/5TrQmZg6XtGkOLeK7YMXG3Yrx46eu5JoI6tTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VVoEClD5; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebd95f136bso8696061fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718098224; x=1718703024; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H1NZkrJnLAv7l2APwu+NKyronseBdr2OqFI4XMkfgYg=;
        b=VVoEClD5FT9pFUKU6YMTo37/3hzDfOsJG6Smc14E5UtqtCnguuppo50FHVhWiVxjDv
         Vl5EB1L9tx53DHITzP06HNfR2vLkdMcLv3zq3TB0ujiCKCKrMx2kjo91VRVSz7g/jGoc
         XRg2UOpcXCpj4rXXe5iD9+wMgl6BInKa5hBmDq1jn/0fEhhjSK6V2lAo20m/2O3+kR+A
         JqiqkH9WgsCQruXh1PXdPI/Odq+rZIxB4UN1n8FB+QBgaVI7/fFUqgDRO+1yqa9jOCD1
         G+V/6NVcTaJX6reN3g7j8JWHr4bficlrVh5R+qRcqjzcRZ2cU0S411xTGRd9wM//PB/K
         K2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718098224; x=1718703024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1NZkrJnLAv7l2APwu+NKyronseBdr2OqFI4XMkfgYg=;
        b=UqrxmTts58lLPYVC3ELRJfVsi2LWQXRUaY70Xv4eVbHaK+Zmp+tJNlZpgFjeQoWuQK
         xqLg8gshhL0xT1suCr2MIUubosGSxrP4o7BttftpjIORg9OGIMZKWhCGFwAKbJ8865Im
         ZsoJlTY8SebE2/384GbIPVXQyCDr8Cb6NlSNrxs87JP8HbZTFEwTb7ErzQfdhuFtQ3r7
         FcCSKfKkwdodcByvyb+zNVxhtT1Fu+N8cfo6GVohsNZjSGLrS8tF9xj6qjMwZnw5yHop
         FP1anVydpqJvzGzGjZenR8FjZozG8aPnAlGP0ArxEwQ30gGWxWOr6XZ4sj1JZpobYK0X
         307w==
X-Forwarded-Encrypted: i=1; AJvYcCUQuzU5ZUXQdHtUoyH0qMp/5n4brWbnGNqrCvMK+GnIDidzCAwYumyXQWFTbM0rJobgNzUXrJ72QWuOCBoLs1YvJPwXK8Wyb6b813y5
X-Gm-Message-State: AOJu0YxRunVCnKKZf/VOwvzceU9qK1AePKfHvIVfcuWE/kB9k5QEPHuz
	JCm4Fyqupgug65fT9pY4FkEsG9QTAq5l+mJAr+og2qveGmbzsBANlobBqg86ak8rywXL/vAKnzJ
	aDI+zPbwmDZyqZCft+lwV5OJFIvqk+1RT2UoG
X-Google-Smtp-Source: AGHT+IH4tkEZxz4vqD6nVOICFGZhCKhY6mHQQxJBjR0fKsf1eo2l0BF0rZJ2jKW/7+AvD07sUJzvhowhHTTwAchfwxU=
X-Received: by 2002:a2e:8752:0:b0:2eb:120c:1a59 with SMTP id
 38308e7fff4ca-2eb120c1b22mr57720031fa.16.1718098223559; Tue, 11 Jun 2024
 02:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718092070.git.dvyukov@google.com> <bc0cf790b4839c5e38e2fafc64271f620568a39e.1718092070.git.dvyukov@google.com>
In-Reply-To: <bc0cf790b4839c5e38e2fafc64271f620568a39e.1718092070.git.dvyukov@google.com>
From: Marco Elver <elver@google.com>
Date: Tue, 11 Jun 2024 11:29:41 +0200
Message-ID: <CANpmjNOyu-76um2psqoeQQJZDiDhwhMX5Ht6d+9k0h7LOG1uBQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] module: Fix KCOV-ignored file name
To: Dmitry Vyukov <dvyukov@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, glider@google.com, nogikh@google.com, 
	tarasmadan@google.com, Aaron Tomlin <atomlin@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 09:50, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Module.c was renamed to main.c, but the Makefile directive
> was copy-pasted verbatim with the old file name.
> Fix up the file name.
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Fixes: cfc1d277891e ("module: Move all into module/")
> Cc: Aaron Tomlin <atomlin@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: syzkaller@googlegroups.com

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  kernel/module/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/module/Makefile b/kernel/module/Makefile
> index a10b2b9a6fdf..50ffcc413b54 100644
> --- a/kernel/module/Makefile
> +++ b/kernel/module/Makefile
> @@ -5,7 +5,7 @@
>
>  # These are called from save_stack_trace() on slub debug path,
>  # and produce insane amounts of uninteresting coverage.
> -KCOV_INSTRUMENT_module.o := n
> +KCOV_INSTRUMENT_main.o := n
>
>  obj-y += main.o
>  obj-y += strict_rwx.o
> --
> 2.45.2.505.gda0bf45e8d-goog
>

