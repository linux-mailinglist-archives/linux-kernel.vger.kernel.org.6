Return-Path: <linux-kernel+bounces-347732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767AB98DDAB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25795281B84
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E8F1D0945;
	Wed,  2 Oct 2024 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BVp0aps4"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5941D07BC
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880526; cv=none; b=olRGXXcmuwQdMLGuNnGmbJBzb9c5ysGQjNYUPI6nK1EM/fopeRQjONfX9UjiyjW9pAIKyJsT/I8qZkeLmuEnZS2pDzXa/rifOC7ii1ae2Odd/RNIG8FD3VflxDm+upsqg0NkUt2xhzGoPXbcijv+Y7bym8bm3eiXts+EauQvQQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880526; c=relaxed/simple;
	bh=HMiK0zwqjbBgPABTJRHOa5ZD3490OiuleAoWqlhsRtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqOoQ/2vRhRfAr9py1z20VH4m5Smi6qEA0TLRaJUD65Tbqe0DwGo5QiKURxITpkJHb3HZs/xDp5voksp+bbpz4/ZDoC7YysuupEH237QGDFQdV5E/IFnwmLi9AoCqz0FZQq8a6M3j40CbaOxvDKEBtFUlyJXXpAOggQMIID7sn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BVp0aps4; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e25d405f238so5927053276.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 07:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727880523; x=1728485323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfiA8iz8SPT4Y6dlpykgPSummKteabSRWG8RoeaQ5Fk=;
        b=BVp0aps4Fn0E3QV2uR3vStYgL4CCL9j6AwAjXhRAH5uqwlpR2ZgrwhAP7bhIsVwSBR
         s8f97Dm/8RswqqKe3qPWYhkC2IIbWW45avUrA5G4JQbma4FGilNfNhd/1mkI9ku0lcTz
         BSGplGs2bklnJn8kJM76zhXK4HYSORBoGYK42Rj+7qw54B+b1qX/4SEGy0mEBB5LIGNR
         mty0+rHZoMOh0MrEYhGgiwNaGBs8z/i2D+WBYdANExNru2F46GPWBTLIsEdyVATrr7ez
         Z4hu4kF/hQ3zZZ9Ld7Ci7UcOGdkSRohc3Ui1tzRz1Aa4/AwAiieFwsT5ppdkb4jLQ/J4
         5Uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727880523; x=1728485323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfiA8iz8SPT4Y6dlpykgPSummKteabSRWG8RoeaQ5Fk=;
        b=Q+yqpEjom6oTbFddq448aUyzUkL8osBm5buGQTRKdV8syRh0BGt5oCrq4rTxkQwgpB
         tXY4oxReiTNO/6eIOlWYSUNNNSsKxjBSmpRPkZwQak5tBJtK/R64ywYvXtsC1K3bteR+
         UZCi2jurT8Z7SDxbXIxKtzWngm2l4Bi0eUWCon+gJQ7bGTDrkpY7d7gVu8mr7dnZ7EQ4
         /fmQPxFzMi8X2WZHw4nT+dT9j9zyXsIbcqITvMyFA83jiWaLcTitubaQkbUYoyVaW1n/
         H51NVI7RtvmpQONi0LnBya2ofL3BgjSxlDHLjoYPw2uGip8Ncha01q1uPkXmcQCvtsJd
         SLWw==
X-Gm-Message-State: AOJu0YzEuN7HoYZ0zcBHWFwZ229zHKDlnYbFAn8ZfG3sHanHTDGQB2z0
	AQPeqUUovXwzI4YTCG9/xxl/NGtj1ky03v34a8xt4nenThVSBPwW5aGxxIDOPv/9f5SVY+/auaD
	cOmUbjbxjKGE5vif0iKyTQYcabulr9fHEaiUY
X-Google-Smtp-Source: AGHT+IFuDUHLh1uo7vhqS3rdvyxiZSBzrHGGakgnQ99yLQ4HzeQUbU8chpQ55VsnWFyoKkXlnlqDVIQAJz6DBPGvF0Y=
X-Received: by 2002:a05:690c:888:b0:66a:ba89:d671 with SMTP id
 00721157ae682-6e2a3063451mr32569377b3.35.1727880523304; Wed, 02 Oct 2024
 07:48:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002142516.110567-1-luca.boccassi@gmail.com>
In-Reply-To: <20241002142516.110567-1-luca.boccassi@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 2 Oct 2024 10:48:32 -0400
Message-ID: <CAHC9VhRV3KcNGRw6_c-97G6w=HKNuEQoUGrfKhsQdWywzDDnBQ@mail.gmail.com>
Subject: Re: [PATCH] pidfd: add ioctl to retrieve pid info
To: luca.boccassi@gmail.com
Cc: linux-kernel@vger.kernel.org, christian@brauner.io, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 10:25=E2=80=AFAM <luca.boccassi@gmail.com> wrote:
>
> From: Luca Boccassi <bluca@debian.org>
>
> A common pattern when using pid fds is having to get information
> about the process, which currently requires /proc being mounted,
> resolving the fd to a pid, and then do manual string parsing of
> /proc/N/status and friends. This needs to be reimplemented over
> and over in all userspace projects (e.g.: I have reimplemented
> resolving in systemd, dbus, dbus-daemon, polkit so far), and
> requires additional care in checking that the fd is still valid
> after having parsed the data, to avoid races.
>
> Having a programmatic API that can be used directly removes all
> these requirements, including having /proc mounted.
>
> As discussed at LPC24, add an ioctl with an extensible struct
> so that more parameters can be added later if needed. Start with
> exposing: pid, uid, gid, groupid, security label (the latter was
> requested by the LSM maintainer).
>
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ---
>  fs/pidfs.c                                    | 61 ++++++++++++++++++-
>  include/uapi/linux/pidfd.h                    | 17 ++++++
>  .../testing/selftests/pidfd/pidfd_open_test.c | 50 ++++++++++++++-
>  3 files changed, 126 insertions(+), 2 deletions(-)

...

> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> index 565fc0629fff..bfd0965e01f3 100644
> --- a/include/uapi/linux/pidfd.h
> +++ b/include/uapi/linux/pidfd.h
> @@ -16,6 +16,22 @@
>  #define PIDFD_SIGNAL_THREAD_GROUP      (1UL << 1)
>  #define PIDFD_SIGNAL_PROCESS_GROUP     (1UL << 2)
>
> +/* Flags for pidfd_info. */
> +#define PIDFD_INFO_PID                 (1UL << 0)
> +#define PIDFD_INFO_CREDS                   (1UL << 1)
> +#define PIDFD_INFO_CGROUPID                (1UL << 2)
> +#define PIDFD_INFO_SECURITY_CONTEXT        (1UL << 3)
> +
> +struct pidfd_info {
> +        __u64 request_mask;
> +        __u32 size;
> +        uint pid;
> +        uint uid;
> +        uint gid;
> +        __u64 cgroupid;
> +        char security_context[NAME_MAX];

[NOTE: please CC the LSM list on changes like this]

Thanks Luca :)

With the addition of the LSM syscalls we've created a lsm_ctx struct
(see include/uapi/linux/lsm.h) that properly supports multiple LSMs.
The original char ptr "secctx" approach worked back when only a single
LSM was supported at any given time, but now that multiple LSMs are
supported we need something richer, and it would be good to use this
new struct in any new userspace API.

See the lsm_get_self_attr(2) syscall for an example (defined in
security/lsm_syscalls.c but effectively implemented via
security_getselfattr() in security/security.c).

> +} __packed;
> +
>  #define PIDFS_IOCTL_MAGIC 0xFF
>
>  #define PIDFD_GET_CGROUP_NAMESPACE            _IO(PIDFS_IOCTL_MAGIC, 1)
> @@ -28,5 +44,6 @@
>  #define PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE _IO(PIDFS_IOCTL_MAGIC, 8)
>  #define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
>  #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
> +#define PIDFD_GET_INFO                        _IOWR(PIDFS_IOCTL_MAGIC, 1=
1, struct pidfd_info)
>
>  #endif /* _UAPI_LINUX_PIDFD_H */

--=20
paul-moore.com

