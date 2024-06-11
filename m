Return-Path: <linux-kernel+bounces-209968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 652B4903D83
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A2A2862F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D201D17D37A;
	Tue, 11 Jun 2024 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nUOkLDRJ"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8106917D351
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112850; cv=none; b=jT1NVPj90HbS30pUKuxuD13gBdfHubgmptGPop8jEGokPXlUTxqicYYa6RM0ysbyGfBi8wrwMVvgrAGOC1SZpwtpxc+oOZNtscurYFok+EElrwMUhB6EI+HmYAo1Qs5Btq0nwVn8Z/Qh5UtuJzswoJzZzPDvFvjNleAqCsTnJ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112850; c=relaxed/simple;
	bh=az03lmCGEbBRYJQ1px/OBDoeVc1VHeAxjMT9UlmV150=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWjOr+2v5Nn9ziTElRRd9eBQV1r2rl8m8V3FMHnZDXuEq96K7cc5gLr/8nbovxLyFMD4lze0k6S9SQQVMGtvRoMz9N97SMo09Vsu2b6CA+VJsjo61AB7kEWPVXOaI2L+y3AT7UJIW4+Fw5+97DjOJwz4AUI/djlwN4s1vWIfJ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nUOkLDRJ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c8bd6b655so17005a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 06:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718112847; x=1718717647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RonLSH5VW0CRVsgXmgBTcMVlLlRjvCFzxuDnDau0nJE=;
        b=nUOkLDRJzfPg3MvrmAeNUTokkayOUpn1dRHbqgKllb6QsEfqXShSiivzljpxw8l9z6
         4MSzU2LhisGB1G+cwFx4lAhWBjURY6Zit4tzd9kVN1M9A1PN2XLaB0TXuMSuZj6hhSm0
         rmicbeaZPttT0ZpbvdwXOtGI+0FoJHV0KiCYgHXD0jTsr6miRYBJaTncQXvqIYkh8Jao
         POC5ROKBuMN0OngaymG++pdq7Fy019yh284zLSdkmtaoevsWDv+ie6juwOxEcXRuCryo
         2oyYh8Ujh9GN2Anj7XyAxOBRpwHGEIh5XSUe+ROoe5CouBE6GUfscigAoVb0Mal1trXZ
         sEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718112847; x=1718717647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RonLSH5VW0CRVsgXmgBTcMVlLlRjvCFzxuDnDau0nJE=;
        b=Gdv/ROYe12MLAbCAT8DjENKU4CfPvpSgawV22KW8PImzdPpjs0aY9+y3sEMrYwcamF
         nc7nd9C6euSy+nLVkCwoPSXG1wYLjF867HuPNNsKqhgpELymeckhsZnprT8OLq94zM2k
         gYuQQluaquX6DOpJQWItM1lxCuyup8enP3WUohcecnnk5TxouzTpakQeU8uYgxBdqhIU
         KshfOuyIeUBP6MevoD3rd0OJyRAFBqGL9xiZm4WzthM9tgi+dKY7ntgIkZh5QEFwhR9O
         QJKs5omNuN/Tu4t4HShFwDygQD7b4lYQC2KbK31k9+tC/DiiWf2AgXZTyb4yYB4IKjCV
         oW1A==
X-Forwarded-Encrypted: i=1; AJvYcCXwbBEpuBc1X/02YGJX3pZm5fSJWUhSMgxPtDZCNmnxED/KVCVTQN3RARCPPXtmW08HuPvuZyspV/BV+5iXLLNUpBGsek4gpeFtPS5r
X-Gm-Message-State: AOJu0YxmGtP5srSK8F39dniwBQsrlgURmYlVLaGmLOdZ2t68IN9Vfg15
	GMxZf1aVYSsTuQ8U3HxJT+QikMQd6WGQtCZ2dDHc74qGBChE09G4cH2NkGeGzqNXmP/erDYxyX6
	WXj/p0sPD5ACyRLNKpk8AQ5A1MMVORA1ukk0Z
X-Google-Smtp-Source: AGHT+IEPfx5wFa00mAwkfDUuJUUN94PBYevFuTAcb8wA41wgBryHd7hgk6G1E6rtljnp7K8LxXPjbBE/K/rVvBjg+xw=
X-Received: by 2002:a05:6402:354c:b0:57c:9853:589f with SMTP id
 4fb4d7f45d1cf-57c98536334mr103562a12.2.1718112846492; Tue, 11 Jun 2024
 06:34:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611133229.527822-1-nogikh@google.com>
In-Reply-To: <20240611133229.527822-1-nogikh@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 11 Jun 2024 15:33:55 +0200
Message-ID: <CACT4Y+YpMz8f_Z9G3QeFzcX97FXY6QTSf8r_u4TQwk6xiO8+eA@mail.gmail.com>
Subject: Re: [PATCH] kcov: don't lose track of remote references during softirqs
To: Aleksandr Nogikh <nogikh@google.com>
Cc: andreyknvl@gmail.com, arnd@arndb.de, akpm@linux-foundation.org, 
	elver@google.com, glider@google.com, syzkaller@googlegroups.com, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 15:32, Aleksandr Nogikh <nogikh@google.com> wrote:
>
> In kcov_remote_start()/kcov_remote_stop(), we swap the previous KCOV
> metadata of the current task into a per-CPU variable. However, the
> kcov_mode_enabled(mode) check is not sufficient in the case of remote
> KCOV coverage: current->kcov_mode always remains KCOV_MODE_DISABLED
> for remote KCOV objects.
>
> If the original task that has invoked the KCOV_REMOTE_ENABLE ioctl
> happens to get interrupted and kcov_remote_start() is called, it
> ultimately leads to kcov_remote_stop() NOT restoring the original
> KCOV reference. So when the task exits, all registered remote KCOV
> handles remain active forever.
>
> Fix it by introducing a special kcov_mode that is assigned to the
> task that owns a KCOV remote object. It makes kcov_mode_enabled()
> return true and yet does not trigger coverage collection in
> __sanitizer_cov_trace_pc() and write_comp_data().
>
> Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
> Fixes: 5ff3b30ab57d ("kcov: collect coverage from interrupts")

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  include/linux/kcov.h | 2 ++
>  kernel/kcov.c        | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/include/linux/kcov.h b/include/linux/kcov.h
> index b851ba415e03..3b479a3d235a 100644
> --- a/include/linux/kcov.h
> +++ b/include/linux/kcov.h
> @@ -21,6 +21,8 @@ enum kcov_mode {
>         KCOV_MODE_TRACE_PC = 2,
>         /* Collecting comparison operands mode. */
>         KCOV_MODE_TRACE_CMP = 3,
> +       /* The process owns a KCOV remote reference. */
> +       KCOV_MODE_REMOTE = 4,
>  };
>
>  #define KCOV_IN_CTXSW  (1 << 30)
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index c3124f6d5536..5371d3f7b5c3 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -632,6 +632,7 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
>                         return -EINVAL;
>                 kcov->mode = mode;
>                 t->kcov = kcov;
> +               WRITE_ONCE(t->kcov_mode, KCOV_MODE_REMOTE);
>                 kcov->t = t;
>                 kcov->remote = true;
>                 kcov->remote_size = remote_arg->area_size;
> --
> 2.45.2.505.gda0bf45e8d-goog
>

