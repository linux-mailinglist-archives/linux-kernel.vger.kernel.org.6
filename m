Return-Path: <linux-kernel+bounces-341379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1536D987F40
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5D62862D3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B59A17E000;
	Fri, 27 Sep 2024 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PUv5TyLU"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132811D5ADE
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727421567; cv=none; b=AKtJy/nBuWCmcIjgywN9PsQJIiC/4UJXcVpaoAdiNkeaNk2z9Q4GGT5Vgdk/iSFHN5Nq61TSSthratf2dnah/LGKuXYkohnNBqBeVl6kO/R3Lrg8RQcqGX71sldbtrpOrBgyUd0bcLFgLsl3+ttIuFI8mEnPrPktGSHOb/ScOT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727421567; c=relaxed/simple;
	bh=+LzaWjPm7GYS4ClcPcZDUGrDO1Ef/UvvMkMUilhTcV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcTQ7cRqMg9zKVvxwDj2+DYy47Ny2zqLcpAcqlyKHcTryZtKVioSa5TczYbE3x8Z/DiU1Fgyp9pP+QDrTYW2dHhTaLmRU0bTwM+ECciO3Xpru6izh9JRD/7wzNCNIazoxp/R29fAjjjr7S8fbFYip6hJBZvnU+o5SFfVNACycP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PUv5TyLU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cd8972738so224229f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727421564; x=1728026364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsWmxM/pizk5STQ8hxv/SQOUbip6yEiFmeKo7SGjTR0=;
        b=PUv5TyLUNiQHMWiZbIrCNlxFKQKRoDP3AKTGG0aKZ02hcA2QoNTxxjM3L9BydQkviB
         t8ioRhNbYjtDPSOV2Onidcp5BRC2+OTkOf4njEtA11SSvTQyVJu0H/KH5TQWl7//u1qz
         yOQnenZzlv/h6PxBlgXOAyDEELrWI8wb29uSlSTvwT+V5i7yEz/E3QujPOPDADuXnbde
         ZMm8B8kz4JNzWKz2zCGKcPuRtmQLjYKZ2YysQ8CPJaOCAbkZuoqX7xwW2xBjg9KeAW2W
         3JsUe7jiSzGZiHEd3gEOz71s7Kbtcwxc+cTQyK32WBhlpKl4vIjkQs9dtoohn5+iD8bn
         lZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727421564; x=1728026364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsWmxM/pizk5STQ8hxv/SQOUbip6yEiFmeKo7SGjTR0=;
        b=TyF3PyB9OSaTAK5GKpiJbAUMdfnFZlgHdo1fKMY1ai9bZnFR5P1wqi15sfsMy8TlAm
         KghBg/NpFlIEdbJJPL0abdL2Vo6CDyEaU6hD0k6DH1I16O3Q/TiD0UR19N+hyUb7wsw0
         h49sZq6UpVSFKv/U7A6wqJjZ3V5I0wMZDl8GjFOQ0UnThmCG6pv2OadU33sKiPwvxfwm
         g6tKMb7wbvaJBLH+7Zhx0GaMwmisbK5bIHpN2kJceBY4bi0ecii4QROAMDUAK721Afa7
         /h05o/LGGC6fYKZCYhswjlyyJd7RyzDDBuUsxFQd0v2XBGlDapRIbxrU2Ev2x8IihH+E
         lg5A==
X-Forwarded-Encrypted: i=1; AJvYcCXHKQPjsrpUuVcHTKOCugwVph+mZx/fabBjUdDOHuB4VKwodohvlygDeqlivilF5NhmF1txwtF/W5fPjRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7MufcPP/2c/C9foPzvok0NXu1BS01cLHIHseLucxr7EWfkyW
	BDGA0XGYpRIHSr8sUr4gYBZ3VPyaRziE7ZAeJrVARLn8B3Cm4fY+IZoU3tXcO+9CqksC/HudBx+
	vZeC2JwskygcFoLhU0R8RLXXBVyMFpZm/kCfP
X-Google-Smtp-Source: AGHT+IGbqV+7LHAovIbkqm3Kg/XVEY3AlSu4eifPD4xqxKxH0tn1ynrzcwnFRwSXqxMrWZFvOn3GrOfRngqjpnDvIHQ=
X-Received: by 2002:adf:fed2:0:b0:37c:d174:b056 with SMTP id
 ffacd0b85a97d-37cd5ad2014mr1211988f8f.23.1727421564232; Fri, 27 Sep 2024
 00:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com> <20240926233632.821189-7-cmllamas@google.com>
In-Reply-To: <20240926233632.821189-7-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 27 Sep 2024 09:19:12 +0200
Message-ID: <CAH5fLggS7C4QdmDFqEy5KARUj+4oNWfstyno3d43joG5haysDw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] binder: allow freeze notification for dead nodes
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:37=E2=80=AFAM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> Alice points out that binder_request_freeze_notification() should not
> return EINVAL when the relevant node is dead [1]. The node can die at
> any point even if the user input is valid. Instead, allow the request
> to be allocated but skip the initial notification for dead nodes. This
> avoids propagating unnecessary errors back to userspace.
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://lore.kernel.org/all/CAH5fLghapZJ4PbbkC8V5A6Zay-_sgTzwVpwqk6=
RWWUNKKyJC_Q@mail.gmail.com/ [1]
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 73dc6cbc1681..415fc9759249 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3856,7 +3856,6 @@ binder_request_freeze_notification(struct binder_pr=
oc *proc,
>  {
>         struct binder_ref_freeze *freeze;
>         struct binder_ref *ref;
> -       bool is_frozen;
>
>         freeze =3D kzalloc(sizeof(*freeze), GFP_KERNEL);
>         if (!freeze)
> @@ -3872,32 +3871,31 @@ binder_request_freeze_notification(struct binder_=
proc *proc,
>         }
>
>         binder_node_lock(ref->node);
> -
> -       if (ref->freeze || !ref->node->proc) {
> -               binder_user_error("%d:%d invalid BC_REQUEST_FREEZE_NOTIFI=
CATION %s\n",
> -                                 proc->pid, thread->pid,
> -                                 ref->freeze ? "already set" : "dead nod=
e");
> +       if (ref->freeze) {
> +               binder_user_error("%d:%d BC_REQUEST_FREEZE_NOTIFICATION a=
lready set\n",
> +                                 proc->pid, thread->pid);
>                 binder_node_unlock(ref->node);
>                 binder_proc_unlock(proc);
>                 kfree(freeze);
>                 return -EINVAL;
>         }
> -       binder_inner_proc_lock(ref->node->proc);
> -       is_frozen =3D ref->node->proc->is_frozen;
> -       binder_inner_proc_unlock(ref->node->proc);
>
>         binder_stats_created(BINDER_STAT_FREEZE);
>         INIT_LIST_HEAD(&freeze->work.entry);
>         freeze->cookie =3D handle_cookie->cookie;
>         freeze->work.type =3D BINDER_WORK_FROZEN_BINDER;
> -       freeze->is_frozen =3D is_frozen;
> -
>         ref->freeze =3D freeze;
>
> -       binder_inner_proc_lock(proc);
> -       binder_enqueue_work_ilocked(&ref->freeze->work, &proc->todo);
> -       binder_wakeup_proc_ilocked(proc);
> -       binder_inner_proc_unlock(proc);
> +       if (ref->node->proc) {
> +               binder_inner_proc_lock(ref->node->proc);
> +               freeze->is_frozen =3D ref->node->proc->is_frozen;
> +               binder_inner_proc_unlock(ref->node->proc);
> +
> +               binder_inner_proc_lock(proc);
> +               binder_enqueue_work_ilocked(&freeze->work, &proc->todo);
> +               binder_wakeup_proc_ilocked(proc);
> +               binder_inner_proc_unlock(proc);

This is not a problem with your change ... but, why exactly are we
scheduling the BINDER_WORK_FROZEN_BINDER right after creating it? For
death notications, we only schedule it immediately if the process is
dead. So shouldn't we only schedule it if the process is not frozen?

And if the answer is that frozen notifications are always sent
immediately to notify about the current state, then we should also
send one for a dead process ... maybe. I guess a dead process is not
frozen?

> +       }
>
>         binder_node_unlock(ref->node);
>         binder_proc_unlock(proc);
> --
> 2.46.1.824.gd892dcdcdd-goog
>

