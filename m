Return-Path: <linux-kernel+bounces-214052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEC9907EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60481C21C57
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF3C14B965;
	Thu, 13 Jun 2024 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+gvKFl4"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CAF13B580
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 22:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718316757; cv=none; b=cs1XMzkebK3lzLRMaaAc28NFcvtx51m4KZbCheVDHj2Nn2GAsUWIxYFUuM3CG7iyYPBtp4zO3qthD4L3ZQnwrsK7T0VzEw/rFWrgenSvYUH7fSyBZWJq4AlQj8EyntUC1rSZU/D6zlSN+NXsxHYitw4J+Ae0E3nIUXBEHGJCo4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718316757; c=relaxed/simple;
	bh=7TE2RcI6NDwB3o1gLJvgqM50bbcK/0FP4+7QNN0zd6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SgZ+cWpVUx1OINbgiOtV0Cv+p7wpsA4gYQYeFsF6kvp7iCRfI4wsRGzhwHDozlHxCdCID0tQuZNkzccM4HgZ9yKBvCEHRQ6sNssZWQH7ZY4/3ZXuk3aIul8V4vh09bWgFGk+VGmLVjurReoX6mTMEtZe2LzEI2MI/5X0CH36/BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+gvKFl4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42172ab4b60so15612895e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718316754; x=1718921554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=me4cz2sH6K4XsN9xxV5NWaQHOePrLe/rCqne2IhtkQI=;
        b=L+gvKFl4WdN3Vpb137l8MiWKwAQvtsSxE8jei3VvRbOJtYxIuz35GtymRNjG5dti2U
         Hw8UDS5ceSleX6cYvkpnpGjkdLIpYkkpJB5ZDpuXbptBlctLb1FSBfKVHPyPwU09T5t7
         d6imum7Uuivpa8kd8Tsu8u+a1R4UTGmJqNP1XZHbzPUcyum5iG1bBQxECvctzDgOpQ4K
         z1vt6fsas+fK5JDtKHLbQxZz1ebBjMLYkV55K11omG0AarG2BzL1Lr2dCWoztRmuQGHE
         2H+6m2MwVHTzrwSYfyCJ0hW8/cecAd1yBVUrxFhGjRs39ALJ/9EeoYEdpw3Sk5FDCIs4
         XkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718316754; x=1718921554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=me4cz2sH6K4XsN9xxV5NWaQHOePrLe/rCqne2IhtkQI=;
        b=Lo3ySp1SNXn+YimZlNsFV0scR5RWCENFVRVowdshodRXeQWiPiGx2uJ0XG8+c3YWSx
         7+IqzvVFQF6x6JLj+S8YhQKZrQwHOWUXHKqRYmyuTDZRCHISnEjEtGXlPelfOmBBdfvk
         OpeEZD264Y2sb2ZIlYmHSG5zEguF36JWGBOXdIEyydvKgqDFZbZOXKHYSC+d0ZEXfSbz
         LZ1ODvmy7HoDEmR81keoToqqbfCFhUZvoH7qXT3w/+ARhxf5KNu3tBXsMcTIruHvoLP0
         fAjhZHB+yjx7sz9Ejw9j8USX357xg6+pQya+GBtr5rRQqUGim7AFLinDcJOH3pl1PXKc
         FaEw==
X-Forwarded-Encrypted: i=1; AJvYcCWwKny3BMkGpzJFc57xHfHZNp9bFevi7SXewyIbfh7WoaT6opnx3u2oRBu5bkktBcxeD8I3wN2tQlIxWSzVIpuRqPKbobccHzrHxb7B
X-Gm-Message-State: AOJu0YwbW4ot4tALOgm7vA7737EOXjWogpJ1bQ053RaeI2PqjNNXwcf2
	VKoT1zbxmwRzf0+a2TSpZ008eD++yp6tFsGxmZxT34S7E62wJ1PY3T2JBfNlzyxMf9Yh9AP3Pb0
	IBiRGh9Hx5OBvTJajML/zwM2LVC8=
X-Google-Smtp-Source: AGHT+IE+Uk2WrNVT5+gp+iYvKvosecaQGwaoTNEJBig8JFvhJIr6WDheaL5aPHNoBMZLLyEtg3mfIodrfAI4qLKbjsI=
X-Received: by 2002:a05:600c:3d86:b0:421:9fc4:7973 with SMTP id
 5b1f17b1804b1-423048272c9mr8941605e9.15.1718316754107; Thu, 13 Jun 2024
 15:12:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611133229.527822-1-nogikh@google.com>
In-Reply-To: <20240611133229.527822-1-nogikh@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 14 Jun 2024 00:12:23 +0200
Message-ID: <CA+fCnZcDE4YyfRNM236duuk6kmOhCrOnpW0XvwMHY+vgVaqbkg@mail.gmail.com>
Subject: Re: [PATCH] kcov: don't lose track of remote references during softirqs
To: Aleksandr Nogikh <nogikh@google.com>
Cc: dvyukov@google.com, arnd@arndb.de, akpm@linux-foundation.org, 
	elver@google.com, glider@google.com, syzkaller@googlegroups.com, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 3:32=E2=80=AFPM Aleksandr Nogikh <nogikh@google.com=
> wrote:
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
>         KCOV_MODE_TRACE_PC =3D 2,
>         /* Collecting comparison operands mode. */
>         KCOV_MODE_TRACE_CMP =3D 3,
> +       /* The process owns a KCOV remote reference. */
> +       KCOV_MODE_REMOTE =3D 4,
>  };
>
>  #define KCOV_IN_CTXSW  (1 << 30)
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index c3124f6d5536..5371d3f7b5c3 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -632,6 +632,7 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsig=
ned int cmd,
>                         return -EINVAL;
>                 kcov->mode =3D mode;
>                 t->kcov =3D kcov;
> +               WRITE_ONCE(t->kcov_mode, KCOV_MODE_REMOTE);
>                 kcov->t =3D t;
>                 kcov->remote =3D true;
>                 kcov->remote_size =3D remote_arg->area_size;
> --
> 2.45.2.505.gda0bf45e8d-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Tested-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you for fixing this!

