Return-Path: <linux-kernel+bounces-346044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7243298BEAE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17C3DB25EF1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EDB1C7B90;
	Tue,  1 Oct 2024 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2t0SnVCR"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052E1C68A7
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791039; cv=none; b=gAwXPFUnNPx8HbpP0FuIEC9i3+QubrV+t9gIREt06uOa5/jmfMcVDSQ1WZR2EZPgn9hzXSHq0IQc/PdM30uLop7m7wwMwjB1fVTJ22S4l5jXwdnYufUONbiY9FyIA7jA/Jc449jubUk9S8V5i+dFVHiFeN9gkdUDh4T/4SivU7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791039; c=relaxed/simple;
	bh=tjLYD3V41DzogUemF4gur7wHWOIMzusH1RKwnS+Y0yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyUn6j+lEXD36lYWZbrL60Ys4owWMS+Y1NNgUXCcVgWz08mXnT8R1XO0kM2e5ocXJUzX5UMHHJS7/CLptfN+qbw1furskxjfFAd5JNFGolOCwye/e97LptfeK69l7sV71cGKJYxf2V4wnpxInJP+AtWUq29yArKeU4pb52kb4mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2t0SnVCR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e09f67bc39so4562475a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 06:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727791037; x=1728395837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9PFAbc8gZj7FEr67uMmDVJNbst4qOOa2vLXUqiM1p3I=;
        b=2t0SnVCRNz07p6fl+GoPPNA3PH1hkzuGLDSm6JsADh2VIERRfGXULwlAvQA0Awt1j9
         BKrJmiIeWfqezGH+SQDGASrE1ozOhMk6yKZS1U58451mtuto9zpRsfmJ3MPeut6OlIAm
         8ir5419cZ+kfPAJzKditMtxuspKyYiYgtiK70ByfuLl2fOHxSpyfwwSfuA5YY3qA9JBo
         KAtKG5yIZ9UbCcAh6iaqZkBgml+SbGGPkfwxeevxALhssMHJYG2LW9pyLRqe4OUpspqG
         5fmb9R92DRchdxrlB9zRBIpXKXr42PNwBNspt515HOsI35Zx8/abstzeN55ciFeVmVO0
         xPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727791037; x=1728395837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PFAbc8gZj7FEr67uMmDVJNbst4qOOa2vLXUqiM1p3I=;
        b=sWS+MpisuxdJherAfEGjejeiohVh64m3K/whu4y5Qx454jQ9jxideW5rPbPkEW8ajn
         NNMhK0v5mfuQ0+l7xSUSXBgkfs602gZrA7XuZYvCfk+WUey0qkRmSw4q7hTahdYu0yCu
         VMc31jMLePgmeYu31/4dtlYPr9hKh3PSq26RX+KWMqJIofHLvnQYtFRidoFf+6HWM+LE
         L1SyJSsDH4U7bOxEembO5G1dNwlYpt7rArQnBnfSKYIjnbTM0AhipTnYGYQG044H7UiW
         S/rOQzXlxEMgKRm7M+ZEdlzFcBR46zAhiL2PAlrHBhNWU4tPmzLq0FyTSVJGPclfhV/D
         GIew==
X-Forwarded-Encrypted: i=1; AJvYcCWtZBDLiYJDGoqdZhqxWb1/d4oaEUOrH4OWYhRocl/axJWZ4yy57hssuzGJvAsUUbcSesNII5yjmQ77/hE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxLpXlXm9XfrejSphxeFQ9/dxoZC/yHMAz2WAPSSUlelWjPj5m
	mIRJR7f+DtYoQhXWpTACONxW39NWuFckepF7esjAKS7drpLZEJLJedvz3l8vh/22ra+98rO5Erh
	LRTrqzkQZPCPN07aPfbPVk46pnFA59bg1OjJB
X-Google-Smtp-Source: AGHT+IFN+E1lmq35Ro6r+Hc7SFKp4o52m72Exx3yN6pDWmQJfVsDgYxjk3hzOHGi7T+i4Pl5nY3JMAHwbJ3imQPTpZs=
X-Received: by 2002:a17:90a:c691:b0:2d3:d45b:9e31 with SMTP id
 98e67ed59e1d1-2e0b887c870mr19277418a91.2.1727791036665; Tue, 01 Oct 2024
 06:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925143154.2322926-1-ranxiaokai627@163.com> <20240925143154.2322926-3-ranxiaokai627@163.com>
In-Reply-To: <20240925143154.2322926-3-ranxiaokai627@163.com>
From: Marco Elver <elver@google.com>
Date: Tue, 1 Oct 2024 15:56:40 +0200
Message-ID: <CANpmjNN+Oq+U9V3v2hZ6g-BoLXhm-PS2Z0dU5NUCdD+CRuhO3A@mail.gmail.com>
Subject: Re: [PATCH 2/4] kcsan, debugfs: refactor set_report_filterlist_whitelist()
 to return a value
To: ran xiaokai <ranxiaokai627@163.com>
Cc: tglx@linutronix.de, dvyukov@google.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Ran Xiaokai <ran.xiaokai@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Sept 2024 at 16:32, ran xiaokai <ranxiaokai627@163.com> wrote:
>
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> This is a preparation patch, when converted to rcu lock,
> set_report_filterlist_whitelist() may fail due to memory alloction,
> refactor it to return a value, so the error codes can be
> passed to the userspace.
>
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>  kernel/kcsan/debugfs.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
> index ed483987869e..30547507f497 100644
> --- a/kernel/kcsan/debugfs.c
> +++ b/kernel/kcsan/debugfs.c
> @@ -131,13 +131,14 @@ bool kcsan_skip_report_debugfs(unsigned long func_addr)
>         return ret;
>  }
>
> -static void set_report_filterlist_whitelist(bool whitelist)
> +static ssize_t set_report_filterlist_whitelist(bool whitelist)
>  {
>         unsigned long flags;
>
>         spin_lock_irqsave(&report_filterlist_lock, flags);
>         report_filterlist.whitelist = whitelist;
>         spin_unlock_irqrestore(&report_filterlist_lock, flags);
> +       return 0;
>  }
>
>  /* Returns 0 on success, error-code otherwise. */
> @@ -225,6 +226,7 @@ debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *o
>         char kbuf[KSYM_NAME_LEN];
>         char *arg;
>         const size_t read_len = min(count, sizeof(kbuf) - 1);
> +       ssize_t ret;

This may be uninitialized depending on the branch taken below.

>         if (copy_from_user(kbuf, buf, read_len))
>                 return -EFAULT;
> @@ -242,19 +244,19 @@ debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *o
>                         return -EINVAL;
>                 microbenchmark(iters);
>         } else if (!strcmp(arg, "whitelist")) {
> -               set_report_filterlist_whitelist(true);
> +               ret = set_report_filterlist_whitelist(true);
>         } else if (!strcmp(arg, "blacklist")) {
> -               set_report_filterlist_whitelist(false);
> +               ret = set_report_filterlist_whitelist(false);
>         } else if (arg[0] == '!') {
> -               ssize_t ret = insert_report_filterlist(&arg[1]);
> -
> -               if (ret < 0)
> -                       return ret;
> +               ret = insert_report_filterlist(&arg[1]);
>         } else {
>                 return -EINVAL;
>         }
>
> -       return count;
> +       if (ret < 0)
> +               return ret;
> +       else
> +               return count;
>  }
>
>  static const struct file_operations debugfs_ops =
> --
> 2.15.2
>

