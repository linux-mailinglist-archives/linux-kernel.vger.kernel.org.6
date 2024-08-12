Return-Path: <linux-kernel+bounces-283849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A5B94F98D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 00:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C4B1B21B65
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979C4198850;
	Mon, 12 Aug 2024 22:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ig4Il0MQ"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B97F195808
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723501631; cv=none; b=iQrZVej2+qx5QP9w2Bnv481F0UtcHRJrRlmidiIF+33+etlzZ9UKi+wvTlvDa52zgMAmoxxhZhVytuuW9hlFi60RYzqAoGEzPIxkyy9dkqY3ysGlFG5dxZhTHRkaJiD+oYDZyY0lBhMyUhSLrtLuVdnoSsqXnulQ9bgG234TWlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723501631; c=relaxed/simple;
	bh=dy7yOK5MzrqWEl/2qwfUfcl8WE2x7M7W0zWgkIY9jxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqztLke/zhJKE7JtAyFsKrEkueVSTvy7qj2+RD+Mgk5xDmyvES+XYkFmSV0GEXUP7x1y/53SMnQPEQkXwdHMQGBzNd3FCe3lD5eWCnjvzsg/0+PD6rZkaz+Wrsf3s6v67Z/eJFlW/YYaLxRO/pFwSPdBWETQ6fH10S3FrqvFYIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ig4Il0MQ; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e0e76380433so4331687276.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723501629; x=1724106429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGTDaCBmHOMVHiR+ZwnCuo7FNJpxQ7Tx+L0Axwmh5TE=;
        b=Ig4Il0MQd8YTXQ+EsgnKQ0zp79VBLraVEnqa0FH7vuWWtDbYeuk4jt1iAWcgWp0l2B
         /SRY2oEOBsepRWJMUklOeIp2UQP1DnNkrUPL/tdfCGw5wsUuhmI8TiEJXnrczmcp6h6i
         hyyYm6KlZysdVeX6yy6BY4XbvJhq4gCo87nZ6P+AxXll8zN7Iq3w/92en/1B8EMEzOPC
         pb7IYoDFXumQ0HV/abEfmSpeWlcpV/25iZ0t6ltaqX++O1xKh6YLeSOekvVwhuVN9lTn
         dYzlKXB3qq0UHoNB2xASJS7DQR9J5sTYwoeryyY5GObGTWVRULZi0dtBN2ohcJzciHzo
         YXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723501629; x=1724106429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGTDaCBmHOMVHiR+ZwnCuo7FNJpxQ7Tx+L0Axwmh5TE=;
        b=JW8+Dp79D96mLDZ8DCsdBVYefrHHa2LZSwYheariBx90UkumQzDHtaquoHXyJ+QYQ+
         xDTqv4cQy2yJEY3+ZSMFtp+XLY0woAWEy4hEY17UGr5ETEzli9/WOZQusu3mrVTqR4Hs
         No3EY8DXLfTsilJZD5YVmVBQRxkD5M4GiN7sdUoaD37dQd7hSECPJuZ0tNHzb+E499+b
         6UTAdkoXZ9cZmwRobpfG4a4Fq8/J5Zfx5WgIM0rLonXUjo6XRt8mkj/aTi+L+emnK4k9
         WrilGvivoF1IErLZH28jybq2movwLgzf8ojGDg19iH5oE0Nme8twnTnv4xENyuQ7zp+A
         rcQw==
X-Forwarded-Encrypted: i=1; AJvYcCUNdHY4BEAHF8U9kF1ZQVjn+/XGT0qq8+qVvzQlwDXiEVYPWdqO9OZLtKbJRruElgHWGlfGb85JiwlpgF6Cj96mLWlYq+71LF74Xkav
X-Gm-Message-State: AOJu0YzrU1fvvDINQGYch5UnfDeGsmbGTo2SE1OxSnILpTMPEvtwbMMf
	zgaEd0q7n3CDE64ckYEBRnd/cYXsdBlz+odh3tZ2UiMup3rx+afjkEUV+/iCNRQl8BMUZqJo3Kl
	jV7JpyTnfwRaSRfu0X+ACTiGXY+q+qikpUPI/
X-Google-Smtp-Source: AGHT+IFKS+2caDqbod6lgEZY+lXsHCMzFjTHVsd+WMqpxPo/oYF8GwR074R9hauT/EOenbd7MmFhLQe842tyQml1hds=
X-Received: by 2002:a05:6902:1883:b0:e0b:26d4:6d1c with SMTP id
 3f1490d57ef6-e113cec05f5mr2548017276.26.1723501629050; Mon, 12 Aug 2024
 15:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812174421.1636724-1-mic@digikod.net>
In-Reply-To: <20240812174421.1636724-1-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Aug 2024 18:26:58 -0400
Message-ID: <CAHC9VhRp5hMsmZ9jUok+5c20U37XLiXmoEAguorTqRF5MQq2Gg@mail.gmail.com>
Subject: Re: [PATCH v2] fs,security: Fix file_set_fowner LSM hook inconsistencies
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 1:44=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> The fcntl's F_SETOWN command sets the process that handle SIGIO/SIGURG
> for the related file descriptor.  Before this change, the
> file_set_fowner LSM hook was used to store this information.  However,
> there are three issues with this approach:
>
> - Because security_file_set_fowner() only get one argument, all hook
>   implementations ignore the VFS logic which may not actually change the
>   process that handles SIGIO (e.g. TUN, TTY, dnotify).
>
> - Because security_file_set_fowner() is called before f_modown() without
>   lock (e.g. f_owner.lock), concurrent F_SETOWN commands could result to
>   a race condition and inconsistent LSM states (e.g. SELinux's fown_sid)
>   compared to struct fown_struct's UID/EUID.
>
> - Because the current hook implementations does not use explicit atomic
>   operations, they may create inconsistencies.  It would help to
>   completely remove this constraint, as well as the requirements of the
>   RCU read-side critical section for the hook.
>
> Fix these issues by replacing f_owner.uid and f_owner.euid with a new
> f_owner.cred [1].  This also saves memory by removing dedicated LSM
> blobs, and simplifies code by removing file_set_fowner hook
> implementations for SELinux and Smack.
>
> This changes enables to remove the smack_file_alloc_security
> implementation, Smack's file blob, and SELinux's
> file_security_struct->fown_sid field.
>
> As for the UID/EUID, f_owner.cred is not always updated.  Move the
> file_set_fowner hook to align with the VFS semantic.  This hook does not
> have user anymore [2].
>
> Before this change, f_owner's UID/EUID were initialized to zero
> (i.e. GLOBAL_ROOT_UID), but to simplify code, f_owner's cred is now
> initialized with the file descriptor creator's credentials (i.e.
> file->f_cred), which is more consistent and simplifies LSMs logic.  The
> sigio_perm()'s semantic does not need any change because SIGIO/SIGURG
> are only sent when a process is explicitly set with __f_setown().
>
> Rename f_modown() to __f_setown() to simplify code.
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Ondrej Mosnacek <omosnace@redhat.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Link: https://lore.kernel.org/r/20240809-explosionsartig-ablesen-b039dbc6=
ce82@brauner [1]
> Link: https://lore.kernel.org/r/CAHC9VhQY+H7n2zCn8ST0Vu672UA=3D_eiUikRDW2=
sUDSN3c=3DgVQw@mail.gmail.com [2]
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>
> Changes since v1:
> https://lore.kernel.org/r/20240812144936.1616628-1-mic@digikod.net
> - Add back the file_set_fowner hook (but without user) as
>   requested by Paul, but move it for consistency.
> ---
>  fs/fcntl.c                        | 42 +++++++++++++++----------------
>  fs/file_table.c                   |  3 +++
>  include/linux/fs.h                |  2 +-
>  security/security.c               |  5 +++-
>  security/selinux/hooks.c          | 22 +++-------------
>  security/selinux/include/objsec.h |  1 -
>  security/smack/smack.h            |  6 -----
>  security/smack/smack_lsm.c        | 39 +---------------------------
>  8 files changed, 33 insertions(+), 87 deletions(-)
>
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 300e5d9ad913..4217b66a4e99 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -87,8 +87,8 @@ static int setfl(int fd, struct file * filp, unsigned i=
nt arg)
>         return error;
>  }
>
> -static void f_modown(struct file *filp, struct pid *pid, enum pid_type t=
ype,
> -                     int force)
> +void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
> +               int force)
>  {
>         write_lock_irq(&filp->f_owner.lock);
>         if (force || !filp->f_owner.pid) {
> @@ -97,20 +97,15 @@ static void f_modown(struct file *filp, struct pid *p=
id, enum pid_type type,
>                 filp->f_owner.pid_type =3D type;
>
>                 if (pid) {
> -                       const struct cred *cred =3D current_cred();
> -                       filp->f_owner.uid =3D cred->uid;
> -                       filp->f_owner.euid =3D cred->euid;
> +                       security_file_set_fowner(filp);
> +                       put_cred(rcu_replace_pointer(
> +                               filp->f_owner.cred,
> +                               get_cred_rcu(current_cred()),
> +                               lockdep_is_held(&filp->f_owner.lock)));
>                 }
>         }
>         write_unlock_irq(&filp->f_owner.lock);
>  }

Looking at this quickly, why can't we accomplish pretty much the same
thing by moving the security_file_set_fowner() into f_modown (as
you've done above) and leveraging the existing file->f_security field
as Smack and SELinux do today?  I'm seeing a lot of churn to get a
cred pointer into fown_struct which doesn't seem to offer that much
additional value.

From what I can see this seems really focused on adding a cred
reference when it isn't clear an additional one is needed.  If a new
cred reference *is* needed, please provide an explanation as to why;
reading the commit description this isn't clear.  Of course, if I'm
mistaken, feel free to correct me, although I'm sure all the people on
the Internet don't need to be told that ;)

--=20
paul-moore.com

