Return-Path: <linux-kernel+bounces-400038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6709C0818
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F242833F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0296A21264A;
	Thu,  7 Nov 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="lvO/ImY7"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AA820FA81
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987470; cv=none; b=KOGe/OWn3MN+Jwr57BDyjhM+JTMbambipO36zv9I/jNlsEn6SQBAHU74vhTwC7ETDP6/eMbI2fjTTwZo+wp6Kw4sWuHatiYLtglXIvYO+PoFlwPOV5J19j66OCe7y4tHtH/7LnENpU5RvLjW5ME2/aDTO1lqCubQWoi1bw2mwqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987470; c=relaxed/simple;
	bh=trEKegl2FHDDStbX9laY/xAPw7CpJ4etahs2VyqANbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2Y8h3fEuaJ7UheMQzsLhNjI11oRf/gOl6juSUgikQYa5BChUcYVoWGRMv/mWlFiYd0Na7h3LrNexVWM8LoyCA83KmWMOqs0yqiyB7UWb/rAvPmaope22A8QxACIYjigU/I6stz4AULO+CjbnGWVoJITo+abS5I4mII+op+U4nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=lvO/ImY7; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46090640f0cso6419001cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 05:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1730987467; x=1731592267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MIdUd/kCIltm47uXGOxpew8sXLXKVDb07NKzjiDMo00=;
        b=lvO/ImY7jRb4oJ9GCI9PAcPoKzU8ue9XWUKzZ2Oj31iiV4ldUmm5I9/exvW6/5I7Xh
         U5cd03+ShgHyW8a0hE7SmjPXYK1U2aDZ20PnFhph63ttAhNyw2+8tVPyPMd5PMD2KGpi
         2ADBNbqvByTwbuB8sfOezqqGI6CnnIAzLsNwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730987467; x=1731592267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIdUd/kCIltm47uXGOxpew8sXLXKVDb07NKzjiDMo00=;
        b=PrYA253bctJPH86iU8KWaIahpYxdIXO0vrnZpIsqwB9YFdSZ4e+CZTtNOboei3vsP/
         AZ4YgnL7ye+g/bP6W5zKxlQL+/iYMO9TaFBUIpSYeeJqgdK3JsP5iDxjEqL62MUJQ4yI
         ZIiXgRG2Gn0R8lNHJhikzosbuDCHPleWqUr3slb2b24Jxt74RPlQjBp75Gbgz9fymarh
         BbkuJVKcuY5ChskcwtDfcQo673+SZKiqr5eWIKJRBJKZBeDaSz+qNewbMBHd8e6btZQD
         ECuESv12IytwuTJNPgylS/q/6cAMGudSgpmwbS19jjLsgD1BjZSutGnbtm4hrExJ94/6
         KAfg==
X-Forwarded-Encrypted: i=1; AJvYcCWjxRO/1OsqMA/DM0R6MP4UpdaPOvkxCsYUepgJ5ymRZeAbv32R0zjKV6e9WT/j0Qna7nleW47lX7bKziM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIq9aCkfhoTxxbYyptJQQ/DpJFooQ+aB0CU5CQmPZWWTBCSD4C
	p9/MNmxMClSWnXaAMburdpg4dCxEyaVCsm4MwW2f0EI1Ry2Uz279GXbj+Tv2Qosg0HATaxL35Mu
	mTvbORh0NNDyC2mMyXIxCdB8R3vK0paYv+tv3yg==
X-Google-Smtp-Source: AGHT+IGMnmumBMb+3kuOO+F0xYzmD0dh5oV9KLJbqWkglpw859Yu8qzT99hqpfqG9orBIBT6bwMX6D9jL0g85BVP+Fs=
X-Received: by 2002:a05:622a:492:b0:460:4ef4:6377 with SMTP id
 d75a77b69052e-462b8646b74mr411352341cf.6.1730987466753; Thu, 07 Nov 2024
 05:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106-statmount-v2-0-93ba2aad38d1@kernel.org> <20241106-statmount-v2-2-93ba2aad38d1@kernel.org>
In-Reply-To: <20241106-statmount-v2-2-93ba2aad38d1@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 7 Nov 2024 14:50:56 +0100
Message-ID: <CAJfpeguufK_JN7y1ePMM6F4yZ5UCWbi-EJhoiWUsJpwG9vxXKw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fs: add the ability for statmount() to report the
 mount devicename
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Nov 2024 at 20:53, Jeff Layton <jlayton@kernel.org> wrote:
>
> /proc/self/mountinfo displays the devicename for the mount, but
> statmount() doesn't yet have a way to return it. Add a new
> STATMOUNT_MNT_DEVNAME flag, claim the 32-bit __spare1 field to hold the
> offset into the str[] array. STATMOUNT_MNT_DEVNAME will only be set in
> the return mask if there is a device string.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/namespace.c             | 25 ++++++++++++++++++++++++-
>  include/uapi/linux/mount.h |  3 ++-
>  2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 52ab892088f08ad71647eff533dd6f3025bbae03..d4ed2cb5de12c86b4da58626441e072fc109b2ff 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5014,6 +5014,19 @@ static void statmount_fs_subtype(struct kstatmount *s, struct seq_file *seq)
>                 seq_puts(seq, sb->s_subtype);
>  }
>
> +static int statmount_mnt_devname(struct kstatmount *s, struct seq_file *seq)
> +{
> +       struct super_block *sb = s->mnt->mnt_sb;
> +       struct mount *r = real_mount(s->mnt);
> +
> +       if (sb->s_op->show_devname)
> +               return sb->s_op->show_devname(seq, s->mnt->mnt_root);

I think the resulting string should be unescaped just like statmount_mnt_root().

The same goes for the option strings, which went in last cycle.

I see no reason to require users of this interface to implement
unescaping themselves.  Others beside libmount probably won't do it
and will be surprised when encountering escaped strings because they
are rare.

Thanks,
Miklos

