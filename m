Return-Path: <linux-kernel+bounces-261163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B2193B37A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CD9283C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45DE15B0FD;
	Wed, 24 Jul 2024 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="dafAJaUO"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05F33FD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834256; cv=none; b=E5rdN6JNg1k3EeNszC711+MxtBcMrups+7oENx6HMp0H7d5Q4BuEzLYwwbk5EtJpWzPHzyT+jrtwgrD70PRHARSvCRbqYhZXHYs4/HppFGOTsOeRJ8rGcrCx+NYdEXsXquIn2VlJYCVJrC4tLgN9K7oI+VwcOz4UqMYTNRxawPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834256; c=relaxed/simple;
	bh=a+Ua/ltIdCBXzmBR4aP6AsT71kbH7M8vEX8Uou0oB5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKFAye4kNcIGCsjFC49mvn/t7Ewdw/X24HhHjH2NSFuS9PO9PQOVFPAsKUCnjT+8gL05B4mFFFwM6sqmSJWuOA2HGzng4G4ApsSs2F9IRLvXfNciykcgvu0gje5fjwifLdEUk5bBR5Tlm+PHg8U+t3Z8HFmBKlyyhZU6gppHWb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=dafAJaUO; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efd91dd28so776913e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1721834252; x=1722439052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wspkz/Cs5R9BiUPCuy7k5Wn7V4f/vU9ck3LJUYhHuQg=;
        b=dafAJaUOIouygVZ7Bw1r103lqZADXgnkxSDS8vtIsk6eLEyTeSGPaY6x+DfWPZdPPC
         EaUYEPty9YhN28Pyse2tlRNKc7oUO4B9nBygDoPq86Q6zPpSsS61OO4fq4Naym/8bPvd
         uNkaeeyaTfz7NgadDDlLG8r5XpcNjtnLtLuQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721834252; x=1722439052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wspkz/Cs5R9BiUPCuy7k5Wn7V4f/vU9ck3LJUYhHuQg=;
        b=UiI1uoJc+GNhXoYJSqecT3zYsJ7n/Ju1bXX30HEDKbXMyOEgr/InPIWmnQAzJxi5t/
         FJucrYTEzw9G8fVqXAqFa6w4O4sUcS9K1u/t9R0hqlkC4H4nxcAgkRgc++H7pAg2RJNX
         kKody2kACwFWz+hrneYz638ZW8W4GyVGD76Cc3Nv5NupX043RhsTSuvijYKL7sdSymLm
         uLHZPXlV9Jsr6HwlqpZSR4hqURp6lnK1I+h/yI6uITGUYUL2Q+dDJH+xyDaEZ1WpQlEQ
         rUnlCsXB28w+2LqVHVsLzBBnZevW0JT31sOu1m3KVPa4iuVPwxnd1PInqs90DuZO/DLt
         6ztQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSrOxMKS4l3bXtdDbLw2HX2hJtUYxATxuUOKenrmGsI54XLJK8lrD6ixlxZPWEJwScyhYgxH7r9Kkhv7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZrN3quKiGrho85I3ZXmUHoHGvtmVUYHi1jhRoeWbVJw+GdxIV
	8cU8jKmps/fApJiF/WyIe6J7N1Wp9K2ANyJOw8hwCb97KZP2SpuqW65usVsZQ/OwgAhfMu2bJWG
	D7DYFTioq1CI2Gta5tCwySMGBoaMlUFwd/AdJfQ==
X-Google-Smtp-Source: AGHT+IHiiD1Wxpt5KljDcBgPWhRDThoNsEdswEitl9/65WSjB9r2TORFgCr7iaa4bKqAvIytaQLpKQBnkTcRKQdPvCY=
X-Received: by 2002:a05:6512:3b21:b0:52f:4b6:bb4b with SMTP id
 2adb3069b0e04-52f04b6bbb3mr3408316e87.9.1721834251713; Wed, 24 Jul 2024
 08:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724-s_user_ns-fix-v1-1-895d07c94701@kernel.org>
In-Reply-To: <20240724-s_user_ns-fix-v1-1-895d07c94701@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 24 Jul 2024 17:17:20 +0200
Message-ID: <CAJqdLrr78NzGkUzYhCiFJmvWZDYbCFaeJ19XHwFh2VK2J4+VvA@mail.gmail.com>
Subject: Re: [PATCH] fs: don't allow non-init s_user_ns for filesystems
 without FS_USERNS_MOUNT
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Mi., 24. Juli 2024 um 16:54 Uhr schrieb Seth Forshee (DigitalOcean)
<sforshee@kernel.org>:
>
> Christian noticed that it is possible for a privileged user to mount
> most filesystems with a non-initial user namespace in sb->s_user_ns.
> When fsopen() is called in a non-init namespace the caller's namespace
> is recorded in fs_context->user_ns. If the returned file descriptor is
> then passed to a process priviliged in init_user_ns, that process can
> call fsconfig(fd_fs, FSCONFIG_CMD_CREATE), creating a new superblock
> with sb->s_user_ns set to the namespace of the process which called
> fsopen().
>
> This is problematic. We cannot assume that any filesystem which does not
> set FS_USERNS_MOUNT has been written with a non-initial s_user_ns in
> mind, increasing the risk for bugs and security issues.
>
> Prevent this by returning EPERM from sget_fc() when FS_USERNS_MOUNT is
> not set for the filesystem and a non-initial user namespace will be
> used. sget() does not need to be updated as it always uses the user
> namespace of the current context, or the initial user namespace if
> SB_SUBMOUNT is set.
>
> Fixes: cb50b348c71f ("convenience helpers: vfs_get_super() and sget_fc()")
> Reported-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>

Hi Seth!

LGTM

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/super.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/fs/super.c b/fs/super.c
> index 095ba793e10c..d681fb7698d8 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -736,6 +736,17 @@ struct super_block *sget_fc(struct fs_context *fc,
>         struct user_namespace *user_ns = fc->global ? &init_user_ns : fc->user_ns;
>         int err;
>
> +       /*
> +        * Never allow s_user_ns != &init_user_ns when FS_USERNS_MOUNT is
> +        * not set, as the filesystem is likely unprepared to handle it.
> +        * This can happen when fsconfig() is called from init_user_ns with
> +        * an fs_fd opened in another user namespace.
> +        */
> +       if (user_ns != &init_user_ns && !(fc->fs_type->fs_flags & FS_USERNS_MOUNT)) {
> +               errorfc(fc, "mounting from non-initial user namespace is not allowed");
> +               return ERR_PTR(-EPERM);
> +       }
> +
>  retry:
>         spin_lock(&sb_lock);
>         if (test) {
>
> ---
> base-commit: 256abd8e550ce977b728be79a74e1729438b4948
> change-id: 20240723-s_user_ns-fix-b00c31de1cb8
>
> Best regards,
> --
> Seth Forshee (DigitalOcean) <sforshee@kernel.org>
>

