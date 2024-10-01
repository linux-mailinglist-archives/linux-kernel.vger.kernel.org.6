Return-Path: <linux-kernel+bounces-346047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4381998BEB3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06889288683
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6981C9B78;
	Tue,  1 Oct 2024 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HU6tGNSB"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFE11C9B6D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791060; cv=none; b=PdCYGtVORITyCZn8i0zcVPaYSo7oC/JI6glRozefFsYOABPCNEBBZOt+aNVzhEp9XH89ekXkobWY/2QmdFPVbTc1sNs9i1gWqgfxroQZlMvbV2mhn2k5kSWLLS/znHZDxehmABvpELE8elRMW27NKy6ti/ffSDs90OjhSBRFqMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791060; c=relaxed/simple;
	bh=ZB02EkY/4WSUcxueCwj7J8jzfcP2uw1qyelP9d0HxDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAWz5Geak6XUOhrVtIlDLo2vDt0/P6K+59jQGw1/sca1DtCku8ckFqc31kfX9q8rPbH0FRv/jbVAbi0Q1WuPDsjc9J8MU/Ml3LHZ8EboY4+y4M6tGvYSqo7EPyvgHPp/Mw+8tzvPp64K4mzsgRpZkJHIfBR7yUbGF9rFk8rmk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HU6tGNSB; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e06f5d4bc7so4728972a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 06:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727791059; x=1728395859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tZuvfapWSfcTxW9oAzTmyzPbGIeg43d+eoh3qwTSmWA=;
        b=HU6tGNSBbmEugmiKAwTXCLxS4/zkq8WuTfWOmYWBOy6O5ZJ7e/4VOAo5SKi1lmGBxT
         VJrEqYRbKHoldn1xH5MCFBANPTV1Q+iUOSwDqgrYeNy2+GhMo+mo2+DR32vSvnOE52aQ
         Eidod/iMpniU5bJdc8y7Jpuixnei+jXe/kfg2IpYR/tO9Emfrgo58MUX18TBAMc9eFDS
         D3HPDQ4gOnJxv8h1+0mAbLOrDocSMX6OcCbiv7mY93014b20Z/GsSUElUIpOYFZg7YT6
         PBq1JBeU4cRLpcueK9X3kmazUZLMgLTbBdLaxvyTyB+KGoOem/kTLDjvD6xnGAiUa66K
         cohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727791059; x=1728395859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZuvfapWSfcTxW9oAzTmyzPbGIeg43d+eoh3qwTSmWA=;
        b=iizU5bF8D3tooPQTWfCOFoKMWxQJjxsSGrh5uNAcQg810gwl70x7cEriWniO3Ek3l2
         26ROa3HlIosigiSsqfUBznWW48lTsCFfrfVGbmaQFGUF6qUD2u1gsh3dQfO1IMEmQPy2
         S28grUItDzjg3Ft0pfpyv8D8SI5QyXv3KMXRA5dV8DSzgGFcwuEKiUjO56h3o8OlGr3I
         SMKDiWrLrztp5qxgrVZNiwo5FUWAbRBBwxK1DrZvAEoAjCH8r83F3cS9N5cgVVO6eLR9
         q2Bw0zLFGq0K6LPGm/BT0oKT3NI9iWvovM2PbBn+AV1JzG35l9mLamwa5zKTYvzo7ltr
         iPDw==
X-Forwarded-Encrypted: i=1; AJvYcCWNbMNzIPEvpk1Y2/G0/vAA0QUbaPSiIHXgJRNt+7jA/7SNRfT/vXusg2EBkIIvM7XXlLMDcuO4FKzkPIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzqBX5LU2sUsAGYWGOjbC42xaJXBvQAMKu4hMBuEJzexzlKTg9
	8NiuDySN6EwAdnXy6+NkMjdNSYJD1mIyIudPfgc74uw//aubNFUN7UcuXYhl5WW9/sNCiCAy/9i
	LVpdTzvrAFzppcGqCVAhfU2QSYHHbZzN5fWdO
X-Google-Smtp-Source: AGHT+IElZfPqVM/GCnGPCB0oWWTGjZ/ldkmsOIxYcfwK5D2tDxmi0DfQiGHnLikXHHgZtuu4nRSsRuBwGhkW7PobE3M=
X-Received: by 2002:a17:90a:a88c:b0:2d8:71f4:1708 with SMTP id
 98e67ed59e1d1-2e0b8b1c5c9mr17858783a91.19.1727791058530; Tue, 01 Oct 2024
 06:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925143154.2322926-1-ranxiaokai627@163.com> <20240925143154.2322926-2-ranxiaokai627@163.com>
In-Reply-To: <20240925143154.2322926-2-ranxiaokai627@163.com>
From: Marco Elver <elver@google.com>
Date: Tue, 1 Oct 2024 15:57:02 +0200
Message-ID: <CANpmjNM-DHav6B7h4ZeTQd9KERY0dKD9qYQ1RT966aLTvbYnfw@mail.gmail.com>
Subject: Re: [PATCH 1/4] kcsan, debugfs: Remove redundant call of kallsyms_lookup_name()
To: ran xiaokai <ranxiaokai627@163.com>
Cc: tglx@linutronix.de, dvyukov@google.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Ran Xiaokai <ran.xiaokai@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Sept 2024 at 16:32, ran xiaokai <ranxiaokai627@163.com> wrote:
>
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> There is no need to repeatedly call kallsyms_lookup_name, we can
> reuse the return value of this function.
>
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Reviewed-by: Marco Elver <elver@google.com>



> ---
>  kernel/kcsan/debugfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
> index 53b21ae30e00..ed483987869e 100644
> --- a/kernel/kcsan/debugfs.c
> +++ b/kernel/kcsan/debugfs.c
> @@ -181,8 +181,7 @@ static ssize_t insert_report_filterlist(const char *func)
>         }
>
>         /* Note: deduplicating should be done in userspace. */
> -       report_filterlist.addrs[report_filterlist.used++] =
> -               kallsyms_lookup_name(func);
> +       report_filterlist.addrs[report_filterlist.used++] = addr;
>         report_filterlist.sorted = false;
>
>  out:
> --
> 2.15.2
>
>

