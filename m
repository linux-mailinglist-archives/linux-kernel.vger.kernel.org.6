Return-Path: <linux-kernel+bounces-276742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 017E59497D8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF4B2846FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2A71422D6;
	Tue,  6 Aug 2024 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aV+zU4PX"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831D13A267
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970615; cv=none; b=Dmeqlzt+zvlSr+fPHfzo6SEbJYrVxez9DUew0YCRTWQteA/ltIB1oLwBBsHeiw4QuP63fLd9EA61ayMPA4tfrfcFX21BkD0GYATL/KgbElpri0FoEc0g28De+A9pm03YYe2XRPXTuXPabyoiWaORezHy3C/itDO9cAljc9Q8ONU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970615; c=relaxed/simple;
	bh=DciIyaltMFYLMxZvjIfQj8LL3dvXxfc6HZ7aYdssDhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtu9KPzXqmVb2N9knnXvSZb6/BodHrZYuXea3h2OxCusT6QkLiJJkQAKDTKKRJiH9QBxL87H8RLOyuAZKzsVX2KEPzPr/n3rmC+sVXAXTyvbHM/ehXZszVzt3g0B5j6fkwgtNDBUNdd+aw2bgvwDf1R8GBqQXM8IrJYu7ltefQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aV+zU4PX; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso21652a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722970612; x=1723575412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Hlr295kPt+eGh8NSlH0Dz/t5X1B6Heu59VkOJqUybg=;
        b=aV+zU4PXNTM3fn7rhD4ZMQx/n/x65XZ+uP2lKo2ir5PY188Wb/if0lQbJT8F61dur0
         1bCHxYpWmPB1Mx1bjzaF744Hc9kXkEAgZN+SZXnkOuN9N+wsyS2fWXeMASgw7cGMtGET
         UvbtdDLmBk2Hss6GGok9oFW91Sf68TktMQ5BmTTOYrMEu2KDR9wvDjeZndP1ed39RuS9
         0CXFKNP0aT06azyXqHt8LbliWdt0A7nb5Q4x8UeGIzLBfk7sU9eY9ZK21OatAl+4CNju
         gn38DN4JZmihZ1mWzPGONn4cj/uCJrobJD/KgSp/WFoKX1SNJ2Ku5/rDZWfMplR0uc11
         q6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722970612; x=1723575412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Hlr295kPt+eGh8NSlH0Dz/t5X1B6Heu59VkOJqUybg=;
        b=U6LqEKiNSygRgpIKpeuqi++ucs6egJ7EMKG3yH1p57idWulzW/+Ozv8KHrwGNaULJZ
         NJV6PMsoK+a4Vzu+jXqins9gc2D9g3rZvpMuPLIXvTZi80h1+OfyKyOUhPefV8VWeGRb
         4sXdEA16bU0pjaaNN6U/NA4j+wRXi7enjSKgp0aiiznZjByzix5zr2P+yv8Vs/LAxkt2
         t+JPhcWywx9fEAeKJUVYuHedsU0vVy8hlrDPbyo6enfuhxroAbAkF4I8K6sQRyndKA64
         B4QIH9fwf1E1zulcru/zkHhcR3NmSNKeyp+1XdZS5oOtpYrUtYTvKMc6b+lYSAZqspRi
         GQew==
X-Forwarded-Encrypted: i=1; AJvYcCV5+fNtqQs30YHjJ8btAfv2sTD26GcKAMum3CgAZcEhSFsDB96Bv+t69e/uhZhE/oqZfhZmU7L1w9bK6o6MRMJPn8VDs4Ny5YhHcyqW
X-Gm-Message-State: AOJu0YzOTrFjjJZ5Ab/gvQOiUo3O9UwIoW68sTmd33eXY2WvoDgrbxI9
	tBDx34ZkEevBO7m4NA3ZFO76dRfDdRGNNHQ3dw+8IGiteYwHUYhF/7rslUtPTPCStN0mALJGipC
	v2MF/yqA/bB/cNttXZlM4QgWv+MCbUYhcJDXK
X-Google-Smtp-Source: AGHT+IGqnjXhVQ8xTsbaWkcVIDDJvOxlZLSRQjKaeRvd7cNiXjReNou5GDw7DnmVT3rHal8ocqevhsdfWvubnFMhvKc=
X-Received: by 2002:a05:6402:84c:b0:59f:9f59:9b07 with SMTP id
 4fb4d7f45d1cf-5bba28bb22amr26688a12.4.1722970611142; Tue, 06 Aug 2024
 11:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1722966592.git.fahimitahera@gmail.com> <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
In-Reply-To: <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 6 Aug 2024 20:56:15 +0200
Message-ID: <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Landlock: Add signal control
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, mic@digikod.net, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bjorn3_gh@protonmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 8:11=E2=80=AFPM Tahera Fahimi <fahimitahera@gmail.co=
m> wrote:
> Currently, a sandbox process is not restricted to send a signal
> (e.g. SIGKILL) to a process outside of the sandbox environment.
> Ability to sending a signal for a sandboxed process should be
> scoped the same way abstract unix sockets are scoped. Therefore,
> we extend "scoped" field in a ruleset with
> "LANDLOCK_SCOPED_SIGNAL" to specify that a ruleset will deny
> sending any signal from within a sandbox process to its
> parent(i.e. any parent sandbox or non-sandboxed procsses).
[...]
> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index 7e8579ebae83..a73cff27bb91 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c
> @@ -261,11 +261,54 @@ static int hook_unix_may_send(struct socket *const =
sock,
>         return -EPERM;
>  }
>
> +static int hook_task_kill(struct task_struct *const p,
> +                         struct kernel_siginfo *const info, const int si=
g,
> +                         const struct cred *const cred)
> +{
> +       bool is_scoped;
> +       const struct landlock_ruleset *target_dom;
> +
> +       /* rcu is already locked */
> +       target_dom =3D landlock_get_task_domain(p);
> +       if (cred)
> +               /* dealing with USB IO */
> +               is_scoped =3D domain_IPC_scope(landlock_cred(cred)->domai=
n,
> +                                            target_dom,
> +                                            LANDLOCK_SCOPED_SIGNAL);
> +       else
> +               is_scoped =3D domain_IPC_scope(landlock_get_current_domai=
n(),
> +                                            target_dom,
> +                                            LANDLOCK_SCOPED_SIGNAL);

This might be a bit more concise if you turn it into something like:

/* only USB IO supplies creds */
cred =3D cred ?: current_cred();
is_scoped =3D domain_IPC_scope(landlock_cred(cred)->domain,
    target_dom, LANDLOCK_SCOPED_SIGNAL);

but that's just a question of style, feel free to keep it as-is
depending on what you prefer.

> +       if (is_scoped)
> +               return 0;
> +
> +       return -EPERM;
> +}
> +
> +static int hook_file_send_sigiotask(struct task_struct *tsk,
> +                                   struct fown_struct *fown, int signum)
> +{
> +       bool is_scoped;
> +       const struct landlock_ruleset *dom, *target_dom;
> +       struct task_struct *result =3D get_pid_task(fown->pid, fown->pid_=
type);

I'm not an expert on how the fowner stuff works, but I think this will
probably give you "result =3D NULL" if the file owner PID has already
exited, and then the following landlock_get_task_domain() would
probably crash? But I'm not entirely sure about how this works.

I think the intended way to use this hook would be to instead use the
"file_set_fowner" hook to record the owning domain (though the setup
for that is going to be kind of a pain...), see the Smack and SELinux
definitions of that hook. Or alternatively maybe it would be even
nicer to change the fown_struct to record a cred* instead of a uid and
euid and then use the domain from those credentials for this hook...
I'm not sure which of those would be easier.

> +       /* rcu is already locked! */
> +       dom =3D landlock_get_task_domain(result);
> +       target_dom =3D landlock_get_task_domain(tsk);
> +       is_scoped =3D domain_IPC_scope(dom, target_dom, LANDLOCK_SCOPED_S=
IGNAL);
> +       put_task_struct(result);
> +       if (is_scoped)
> +               return 0;
> +       return -EPERM;
> +}

