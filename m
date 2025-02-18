Return-Path: <linux-kernel+bounces-518706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E333A39398
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56CD01890656
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 06:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F04B1B6CE8;
	Tue, 18 Feb 2025 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHuA3w+b"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6D21465A1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 06:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739861862; cv=none; b=nqXLrKmWkslDZQg/g3NxUhztcvWQylySDer91jpx/3h4YKdf5/jTw8UmvO9GRCQ1Uggl0QEPmm6k1yuSWonUeSyPMYXLlId58PXyXETp2Q5h5j5Wk/lOZVZVAuqxgNyVRjCGzOTG2/EltaA+vWXIRRCg9cfF3Y6Hh9EjZRrP2cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739861862; c=relaxed/simple;
	bh=XQ/NVnfVE7NNvDTmpfLLDpqgGlSMILACTRheTT216ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nq7WFUAI8qpJMycvpSg9nYb3bWEQwl+8hvKlA496XWIlxc1JnLBskYNNhIUxNw3inFaq0B2s6RUKOwPUilqg9fd9CeAY4ZzEYc3tb3nliFViP48yzFI0kvqWgiU493nQAZoyfAF8nbksqkHHK2hIzcKiKMSUrVLP7PGm6T2+OHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHuA3w+b; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30613802a04so53937361fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 22:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739861858; x=1740466658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iRBSYqRtQX5z3bqMamdRSkx7Zu9m86472PmcDCtWIMo=;
        b=nHuA3w+bWD4Zhj5/+Vb6V6f3mX05RPbcoEiPe2gn/Ntt5ldbUicwEZNBVCq3jjl2CD
         LR2WpTtLFi47/ggs5ICsiszMl6VU1zMDMUi7Rp26Hf1lxuCJ0PKhSdLgmjxvCPGaK3yl
         09rC5KlWO7+6QKdNFNU5UEwhVgYTHQk0keTCd14SbM4rRcPuXxmf4ackvYdZDcRojCoT
         7jiji9bg/CkDqvmpQjSqHPVtbrQY7FDpHBdcIxxryxLaTsIWqx6yMylkVZh0DZcT7TGT
         oVQiLuQflp9P+Tif80xJ0V5i7ibrOOw7QClRZzSaefIrY1QOp5GH+idK6fwRRvLcJzAx
         mYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739861858; x=1740466658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRBSYqRtQX5z3bqMamdRSkx7Zu9m86472PmcDCtWIMo=;
        b=srD2L715vQlfIZLzwgQRU7EuN60JWZjsz5Zjh7Y49IgKW/opNBxtPDFGl5rHdqoy4O
         9ortLGGCiOULJIClxf7QvS6+kt/L11FyYcoFR/BhIIF5RiqwSvYsztGioeuWoU1th8PQ
         KbyFhI+p54LJe3yOjWWHqt/4gkGDtMRSOUEsdqS5h5DtGMkLNhU63IJ4OdLT931jLyOU
         h7InWDNjy3ffDQwkw8mTs15DLLVdf/d87uiCfpmoAL7eLrZhg3P97dufRmwz+I5CeAJp
         mKu9KG9u1t2KizarC4iEKBQHYho8wn+jhFkmSTYCv/SD2Dytc1An9+y9036YLqC5hoeb
         ikHA==
X-Forwarded-Encrypted: i=1; AJvYcCUBEJdMNBIFK/YWyReyQFJCdKoyFNQ+r29pk/MI4N/TiTB6DqOTG8E9TXzS2deJOhuOCOUWdGPr/3tRxLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwakBtWqEHSSAcQxzHIbtiHkDbyhG8qGz+Is/DU6vh0yksQta22
	vcczFIzokKuOAKhJhpy5lUvhT87KhgY1H6H7VjOAKKOfXeM1vvccpiMpbbHgY7CBc0+cLCYS3Iy
	6E/zRHnJy0cDltKol9Y8sKzb8sqQ=
X-Gm-Gg: ASbGncvjr8coMW8OGwAhDvQw7mP6SK0oLCB+31uFHnx5905jBbhwldioP6KEshqzKOV
	3P4G4o0ACUZzuOhz/nPysG8w5es5vMv2U+8+A4WZ/LpwyEqDb11LkOy/+GmUyRaJQrRN95QJg
X-Google-Smtp-Source: AGHT+IER7wjl6f9njeMck7m0ivCclnh4kfcs7yKY0+I1guG8f5sYgtFMtdPO/1a8VTFbDz5EyQv2cPIiaAaMAZBQ268=
X-Received: by 2002:a05:6512:a8f:b0:545:576:cbca with SMTP id
 2adb3069b0e04-5452fe2ef99mr3503855e87.8.1739861858234; Mon, 17 Feb 2025
 22:57:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217040928.34561-1-chunjie.zhu@cloud.com>
In-Reply-To: <20250217040928.34561-1-chunjie.zhu@cloud.com>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Tue, 18 Feb 2025 07:57:25 +0100
X-Gm-Features: AWEUYZnV-Lx0KP6OYcQcbVwoe36BP9Dfghup5ZWfXQ0Y3N-qXvk2GRJ-CxLSgXM
Message-ID: <CAHpGcMK0vez+c0NT-U40=JYy+_X-rtfR50KEZXiFXuA6E-tUmQ@mail.gmail.com>
Subject: Re: [PATCH] fix gfs2 umount timeout bug
To: Chunjie Zhu <chunjie.zhu@cloud.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Am Mo., 17. Feb. 2025 um 05:10 Uhr schrieb Chunjie Zhu <chunjie.zhu@cloud.com>:
>   If there are heavy lock contenions between nodes in a cluster, at
>   fs umount time,
>
>           node 1                           node 2
>             |                                |
>             |                                |
>      iopen glock lock    -->       iopen glock go_callback
>             |                                |
>             |                                |
>          EAGAIN                       try evict failure
>             |                                |
>             |                                |
>        DLM_ECANCEL                           |
>             |                                |
>             |                                |
>       glock complete                         |
>             |                                |
>             |                                |
>     umount(clear_glock)                      |
>             |                                |
>             |                                |
>  cannot free iopen glock                     |
>             |                                |
>             |                                |
>     umount timeout (*)                       |
>             |                                |
>             |                                |
>       umount complete                        |
>                                              |
>                                              |
>                                        umount succeed

Thank you for your bug report. I'm having a hard time following what
you are trying to say, and the patch itself doesn't look right to me.
If there was a reference counting problem like the patch suggests, we
would probably see regular left-over glocks at unmount time, but I'm
not aware of any such problems. So you ld you please explain in a bit
more detail what you think the problem is? Do you get any messages in
the syslog? The file checksum in the patch refers to commit
bb25b97562e5 ("gfs2: remove dead code in add_to_queue") from 2023.
What exact kernel version are you running?

Thanks,
Andreas

> Signed-off-by: Chunjie Zhu <chunjie.zhu@cloud.com>
> ---
>  fs/gfs2/glock.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index 4a280be229a6..bf2445f0afa9 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -2120,6 +2120,23 @@ static void thaw_glock(struct gfs2_glock *gl)
>         gfs2_glock_queue_work(gl, 0);
>  }
>
> +/**
> + * IOPEN glock might be a zombie glock instance due to lock contention
> + * between nodes in the cluster during fs umount, then it causes umount
> + * timeout
> + */
> +
> +static int is_zombie_glock(struct gfs2_glock *gl)
> +{
> +       if (test_bit(GLF_LOCK, &gl->gl_flags) &&
> +               test_bit(GLF_DEMOTE, &gl->gl_flags) &&
> +               test_bit(GLF_BLOCKING, &gl->gl_flags) &&
> +               (gl->gl_name.ln_type == LM_TYPE_IOPEN) &&
> +               list_empty(&gl->gl_holders))
> +               return 1;
> +       return 0;
> +}
> +
>  /**
>   * clear_glock - look at a glock and see if we can free it from glock cache
>   * @gl: the glock to look at
> @@ -2132,7 +2149,8 @@ static void clear_glock(struct gfs2_glock *gl)
>
>         spin_lock(&gl->gl_lockref.lock);
>         if (!__lockref_is_dead(&gl->gl_lockref)) {
> -               gl->gl_lockref.count++;
> +               if (!is_zombie_glock(gl))
> +                       gl->gl_lockref.count++;
>                 if (gl->gl_state != LM_ST_UNLOCKED)
>                         handle_callback(gl, LM_ST_UNLOCKED, 0, false);
>                 __gfs2_glock_queue_work(gl, 0);
> --
> 2.34.1
>
>

