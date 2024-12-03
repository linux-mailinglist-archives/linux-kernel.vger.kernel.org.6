Return-Path: <linux-kernel+bounces-430267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115B59E2EA4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59FB2832AA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E86C1E3DED;
	Tue,  3 Dec 2024 22:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Db93qrQ5"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FEF1DFE32
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263621; cv=none; b=Dp6BgT/zXo1emG4t/AJypbZc1eFFKlOEfrhtwa8hdRvbjNn+wrt5fxzu3Lf+tunBYTXdfbsMCCb0PPgHxbl6iMPUaUfydLC8GczXolBz3EkZFTgyqp2IchPQhcOhrWOdn5uISt4rYwetqV6RkOavyJs7Y12b0emjBqBFb+MRp08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263621; c=relaxed/simple;
	bh=h+BQKIpXE4PFsE+g1hGX/fGHcZIR8qmk9HgPMyMc0G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVRCBNqR9unbpW1zIM11YzByttVtaBNmmanrvjJGa2itfmFhP7SnYKnwv3ObwN0pmqeRzhMkNlPsnlVNZwTWCAfl6agW7hgBYNECZOdHWOA+HyjIazwSrnrjGri7t/fupLSn6SJ6OlVhAEXCEsCjDlyBvOj49Bc89r3VmT/rdec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Db93qrQ5; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e399e904940so2690486276.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 14:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733263618; x=1733868418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dt6tgIhfEE2uF6kBtPnvdXe7p45YNZugHzIBc4FfBbQ=;
        b=Db93qrQ5EYM7aXfrgjgPcalpYxuZKA5C0yeoICRGCveWBKNzMxkvgIFwavOGV9v5Fg
         F0JZSznECFdLSo56xN/6RpSfQAS62Ngt2tHiJn/fEsfLHZiIQC5MZTYmtI+lA9jS+8V9
         XujLSt6dOM2xiWsi1xDD2dPtD7AxqtHZYUR9xv39v8tYR+1GvSH3/2LIjfIJ6ko09C85
         i6dp18I4ywTTFSDSe3vikUZXJutKF1+YvnbGgK0xYXZRz6KKQ3WIfaJM9aRYPxol9qad
         lxq6G9hNSPqYt970tdGEsFwJjfPmW+pimfrbot1yEKmK17hC1foYQ+RUxZU7STNxDHtc
         6Qyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733263618; x=1733868418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dt6tgIhfEE2uF6kBtPnvdXe7p45YNZugHzIBc4FfBbQ=;
        b=OSw9df9SRspMwJPYEZlK7gIhvjm2Y19nvGWafoT7/YV92u9AzQ4LX6RXswe9HnnZz2
         r0998dAwJ1u7+fFT70R5K6awICASdCztqeDRuA9Dqh4/SPScSZfShL00GGcCIr3MnyhT
         mqfGqnNID/T5LFhOlnXzpYSO0zcODWrqReNDxCXi5WPFV39pTYI0Aaiq4shiKGyx/tOl
         qlfa4Jb7k07Ln2ZnboVYQmChcc65+eoxUMJbFBpTvHsEtHxsLuUQY0MVjxIaxDXVMghY
         IO7jtER6GTv4/APd62XPoN1eE5nik86tRS+na8OxXlrGbQrBG5+vCS0x286QTctE24mE
         20HQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5EJcJwCNNc4tD87UbKRJgtwAwR3KfpA+b407mCU30BWW26dYXBwXMR6W8t8VEAgII0QFvNce0UTnXylc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwypbmhuzA+p1Wz98gV8yjA0tqI0Jn/IYjSACLO2U75rLq9zHwt
	fxw0HBUpO5WhWS6tow1Bc6cRvFaiM0AMk3LY41loAm4aJ5H5o//R0JJ4/9YGe4vwejtPOejtRmd
	MuUyZQnG9sGXTxS8RkNxypqrHCI51mJE+0IX4d8zm5RkWocY=
X-Gm-Gg: ASbGncvTe1jUg7sYocSAAkAhfloCYe1+0jdX7NCgON5WTdja7eWs/NswQ+FGrScpFlW
	vRL+zU6vNA2f3qq0EmVGLo33+YOe34w==
X-Google-Smtp-Source: AGHT+IFcDIYh0s6VN6UUlT7OSsptdYbkjMKXFFp/bpJc9hg8XcEtPBjjWR1dCJHKcOpGDI4z6ka+Kba83P/F1EPrKao=
X-Received: by 2002:a05:6902:18ce:b0:e2b:c7a7:7a3e with SMTP id
 3f1490d57ef6-e39de1e88a8mr2399999276.3.1733263618691; Tue, 03 Dec 2024
 14:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203060350.69472-1-laoar.shao@gmail.com>
In-Reply-To: <20241203060350.69472-1-laoar.shao@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Dec 2024 17:06:48 -0500
Message-ID: <CAHC9VhTRaX02x+KFpsxmguze3R=AAF9yjTtDxf_ghVpQ3XdU2A@mail.gmail.com>
Subject: Re: [PATCH] auditsc: Implement a workaround for a GCC bug triggered
 by task comm changes
To: Yafang Shao <laoar.shao@gmail.com>
Cc: keescook@chromium.org, qiuxu.zhuo@intel.com, rostedt@goodmis.org, 
	lkp@intel.com, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 1:04=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> From: Yafang shao <laoar.shao@gmail.com>
>
> A build failure has been reported with the following details:
>
>    In file included from include/linux/string.h:390,
>                     from include/linux/bitmap.h:13,
>                     from include/linux/cpumask.h:12,
>                     from include/linux/smp.h:13,
>                     from include/linux/lockdep.h:14,
>                     from include/linux/spinlock.h:63,
>                     from include/linux/wait.h:9,
>                     from include/linux/wait_bit.h:8,
>                     from include/linux/fs.h:6,
>                     from kernel/auditsc.c:37:
>    In function 'sized_strscpy',
>        inlined from '__audit_ptrace' at kernel/auditsc.c:2732:2:
> >> include/linux/fortify-string.h:293:17: error: call to '__write_overflo=
w' declared with attribute error: detected write beyond size of object (1st=
 parameter)
>      293 |                 __write_overflow();
>          |                 ^~~~~~~~~~~~~~~~~~
>    In function 'sized_strscpy',
>        inlined from 'audit_signal_info_syscall' at kernel/auditsc.c:2759:=
3:
> >> include/linux/fortify-string.h:293:17: error: call to '__write_overflo=
w' declared with attribute error: detected write beyond size of object (1st=
 parameter)
>      293 |                 __write_overflow();
>          |                 ^~~~~~~~~~~~~~~~~~
>
> The issue appears to be a GCC bug, though the root cause remains
> unclear at this time. For now, let's implement a workaround.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410171420.1V00ICVG-lkp@i=
ntel.com/
> Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Closes: https://lore.kernel.org/all/20241128182435.57a1ea6f@gandalf.local=
.home/
> Reported-by: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
> Closes: https://lore.kernel.org/all/CY8PR11MB71348E568DBDA576F17DAFF38936=
2@CY8PR11MB7134.namprd11.prod.outlook.com/
> Originally-by: Kees Cook <kees@kernel.org>
> Link: https://lore.kernel.org/linux-hardening/202410171059.C2C395030@kees=
cook/
> Signed-off-by: Yafang shao <laoar.shao@gmail.com>
> Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/auditsc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, does anyone have a link to the GCC bug report?  We really
should mention that in the commit description and/or metadata.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 279ba5c420a4..561d96affe9f 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2728,8 +2728,8 @@ void __audit_ptrace(struct task_struct *t)
>         context->target_auid =3D audit_get_loginuid(t);
>         context->target_uid =3D task_uid(t);
>         context->target_sessionid =3D audit_get_sessionid(t);
> -       security_task_getlsmprop_obj(t, &context->target_ref);
>         strscpy(context->target_comm, t->comm);
> +       security_task_getlsmprop_obj(t, &context->target_ref);
>  }
>
>  /**
> @@ -2755,8 +2755,8 @@ int audit_signal_info_syscall(struct task_struct *t=
)
>                 ctx->target_auid =3D audit_get_loginuid(t);
>                 ctx->target_uid =3D t_uid;
>                 ctx->target_sessionid =3D audit_get_sessionid(t);
> -               security_task_getlsmprop_obj(t, &ctx->target_ref);
>                 strscpy(ctx->target_comm, t->comm);
> +               security_task_getlsmprop_obj(t, &ctx->target_ref);
>                 return 0;
>         }
>
> --
> 2.43.5

--=20
paul-moore.com

