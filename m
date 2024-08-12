Return-Path: <linux-kernel+bounces-283339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A915F94F112
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33501C20897
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3368183CDD;
	Mon, 12 Aug 2024 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VbEL/7l6"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB1217D8A6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474844; cv=none; b=cO3PIDTrJzxlrSskcm5zzAxMdGTa9qW8loSVoNsLBd8nh8EyX0ce5YsHJe4R4SNZzy+0Zkoq9/FFgr5GNlvzVZp5DqTsdzhI1kNpCe3RwqR6J+2Wy7S8OHadSjGqqu/fS9TGCjaPN3WPttIesQDLFYIwacwORTLUY0Oe7N9IOP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474844; c=relaxed/simple;
	bh=BdVvw5wi8ulgbL0r425IYgyBXwtsKVJ08h7eG+xL5q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEYdVqr0h5N1U87R+06ZXao2cbRksihaXYq8P8n34Yiu7KrtdKj1h+Lx3LTfYKhykIEl9t8rSLTXgl8UqG2Qb+1DjzLsnwGutjAYPGWGTMvOqKai5rNRb8aFq2mfWZzvkSfCZg9NJSqwhZr2ujlEhesAyAV7dctHQoPVP2rEB5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VbEL/7l6; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4f527c0c959so1271267e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723474840; x=1724079640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1LfnoSFlT+OLyzx/vYttf9gF0d/fk7KCwIj4mtQAzU=;
        b=VbEL/7l6zEzAgEpHngOhJU7+vra/3YzhtTeLqHZgiqMm7QnJkuHKUGKoY+jp79NOhw
         9DMflT36Ig4isIiY0K1UGRZDbT1OzBHxWZlB+sQ/3zBchDoeE+FiK+l3fJ3XAZkhfAlO
         gupl5pIxZnOsqmdRmKsx/RgncbDZMYiSJ3cX/k0CPZAEWFZDocK2XZXv9Ci3kgI3P4Xg
         u0835w2YQ8G2tyEJTlqlD56TYpA5AdvIIh7BVyw42Xb41B6mHkHXW8p+uhXgl7AEl+nR
         D9MPtRn4qWnXN+eHh16gViKwXedb11GXDnMYbrTRRDFhvv2Hr6gJ2+2191WR3P+QYR72
         NWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723474840; x=1724079640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1LfnoSFlT+OLyzx/vYttf9gF0d/fk7KCwIj4mtQAzU=;
        b=fkgs0p/hqnGj5pcIvWQYMLfoI4f5midiQBtzWo8XY5WQClVZ9uU+hXIT9t8YVPQpci
         2Py+7bLT7lamrhcozuYkrWPv+pQbsuK0yCoSqZ5mg4rLKSGDCaA2vjj5hP4f9irZn7a1
         OQedkKR8p43DCc9AxR77P3znUZbQmYPi1UeNU0+77yWGOclioCW6ei7EFBpm09RGwzxF
         Y46SDz/C0P2Z/MKSl51d0wuEEa+HsEXhTFBHWKnTZCj6DfRfMAooInUFOgnIWjoAAEjN
         N/8RkY9RKh5AecPQl7LCRmQd/VnZ8mjZNuxKTJTXwfGMrfdvvJfl9927dACpfViSlT0T
         kaJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfSuqc0rRLEEoQXkZJ7xkf1D81qMGAJZdzEFA60ewEEfChGGsPHIOz3WA4Pfus8t1KxtM+hkk+g0f3Dg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+/3lmXa7N7/0L4Ofeb2az/senFEROmmbjMXCJx2j18yOmrHx7
	srVaBVrHhmSDPfm5kx30Bvepz39XYZLBNQQBZkOlinbmDMdnbqh5l0JH296ceH/pgb9OMfcVmuH
	Qlx+jcByfNjxUK45xaBV6nTUD0d1+gQ8anBig
X-Google-Smtp-Source: AGHT+IF0QTAbx41bggszGNeJJztfb6bYw1GrU0MEoge0vOkbY0MKZLCZxdKF6yLUy5pNifp1N3/5Fx2G7TY+Nwqu6lI=
X-Received: by 2002:a05:6122:2a07:b0:4f2:f1f1:a9f2 with SMTP id
 71dfb90a1353d-4fabeef04e5mr797889e0c.4.1723474839871; Mon, 12 Aug 2024
 08:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhQsTH4Q8uWfk=SLwQ0LWJDK5od9OdhQ2UBUzxBx+6O8Gg@mail.gmail.com>
 <20240812144936.1616628-1-mic@digikod.net>
In-Reply-To: <20240812144936.1616628-1-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Aug 2024 11:00:28 -0400
Message-ID: <CAHC9VhTVO1-KDBisD9sZjG+5mZUiSy6SOE=6c5_rGp5ApoC77A@mail.gmail.com>
Subject: Re: [PATCH] fs,security: Fix file_set_fowner LSM hook inconsistencies
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 10:49=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 44488b1ab9a9..974bcc1c8f8f 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -196,7 +196,6 @@ LSM_HOOK(int, 0, file_mprotect, struct vm_area_struct=
 *vma,
>  LSM_HOOK(int, 0, file_lock, struct file *file, unsigned int cmd)
>  LSM_HOOK(int, 0, file_fcntl, struct file *file, unsigned int cmd,
>          unsigned long arg)
> -LSM_HOOK(void, LSM_RET_VOID, file_set_fowner, struct file *file)

As I mentioned in the other thread, I don't want to see the
file_set_owner hook removed at this point in time.  I'm open to the
idea of moving it around, but as of right now I think it is important
to keep it around.

>  LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
>          struct fown_struct *fown, int sig)
>  LSM_HOOK(int, 0, file_receive, struct file *file)

--=20
paul-moore.com

