Return-Path: <linux-kernel+bounces-211776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E669056A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDEDA283272
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0556417C7C8;
	Wed, 12 Jun 2024 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UpyN8NMe"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDACE1CABD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205457; cv=none; b=mGueCrHD+TFqmXui9cQoKcKUlJ1UIJTPzVuZQr5uKLL+cv/CgtF+6EVTCxBMdJXAZq1ERkL0/kVgaqWfoBmZ51O2wOrTAJcuvmuTOI7vizRFj1YErqGzic9tuhefMfOAdSjbh5guV+cASJYTzct+b2khJFI31xMwYLdX4dM30m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205457; c=relaxed/simple;
	bh=wxqZM2FEq3dzaJDIifmIE2uNTBlslAiCloNUuclrU/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvJjQ8ngc1LCFCrHf/SNsYJ3va2QrA56orWqb5Ms4Oy0gkaThWIBkz1mdqFpluHHa3JQNuOeGqMI8eLDwkC5l8ELq+wGZ1ylUozEekCTCzX++DclLkJniZhVvd8hdODlT3XHB5/hib4UnOoT1xAuDvvxMQTcAwi890vVQcGISvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UpyN8NMe; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62a08092c4dso25938337b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718205455; x=1718810255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxqZM2FEq3dzaJDIifmIE2uNTBlslAiCloNUuclrU/c=;
        b=UpyN8NMeTp16BKJjsrYz4B433Oyo2BWmj1B6LQxw7d5z6JyuWzY3G8HTg+9aWxIPOH
         2VChhf6wI0As40bcuL7mOGBQMrjEfpShUzgYkYV48maZRyZ1uXQvtypx7Qi7Zr2IUGnS
         5H1/z7e3DcQYsrWQ6Ild5knJayUJdOEOAqBWL+WxhPhpbLe4H+54uXLb/QoFEHUdgfGs
         ZtDk4WgBtSC9v61UHgiXoEtwWhjPVBThmLsWZjSAMnms0BvIeF0rAZ+zp9yWlNpwKXsS
         ogr/SAzxcokaEBaxJRDWtlerdmOOcDg/yN36KWO0AExKU+CNEWswpF5dO+30VqsY0NQ9
         2m4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718205455; x=1718810255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxqZM2FEq3dzaJDIifmIE2uNTBlslAiCloNUuclrU/c=;
        b=EiNsl+cJKA/857/Fja2/4fdxcYKigqoZPZrzZENG4RHps/kJhkaXOGGpnOaxgBFlgH
         rmQ7rz8HSejaMzHfyZRLztSTf+/irvV/cSXciq0c3J4peDEahc3Jw+jTA/MuUFl3JsqI
         qPJgEftlcRhYjAPi3eAsUfzvavMcmMP9oW+02QfsZp6/StNADgpixc1vxkKEq6+2B8Y3
         enIIkh23t5nf9/AwBJDFAoVqffgJ9fAIrutFNgPUCNHa7sc6AU0wfrPGXQJpo7l02Wsy
         zjSd1ZYRs1A0XgWpQXun5hShAaKmUk/Y+XZ4fOP/nFH9ZYtrftEi+51OYN7H0BVY50kl
         OovQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZwCEgXTJwDUhcwclgtZKm48DtHuT7af8JdmwzvUMeppBg1knRyFwSSE1Ls9QrU66NoJfAcsCbqduRlgWmKClaLNery/GNqNNLl4LU
X-Gm-Message-State: AOJu0YyaxUx5w7T7KEmAg78yLaFELtFlX04fOxe6j/SQHEUcuJZoFvrM
	YsDQuM+0+Zq41cmobizGuE9bD4f0DfLmZzKMWNXs59G7rFcGM6BMGy8CCxLE2i6ZQL/qXnINfAP
	8RUFa6bxTdrHocAqXWdi3yg3piMGdXI3xm1yrSDxMMl10rqSZ547G
X-Google-Smtp-Source: AGHT+IGbA6oQZrc2QbahZuwofnh1VLlFDj5beFQEl2OmCIMsivekOzF2MmhCD3dscp1t52Xs1dx4D/EIPuLna7RTf1s=
X-Received: by 2002:a0d:c285:0:b0:62c:c642:89de with SMTP id
 00721157ae682-62fb8e3c5ebmr20422497b3.29.1718205454513; Wed, 12 Jun 2024
 08:17:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com>
 <CAJuCfpGa55gpKHBE_0mwRPsf0f1Wp5UK7+w6N7yZi-7v31vNzw@mail.gmail.com> <CAKPOu+9vcAK3ZxB783j5u1MR0YB9WLWjUBGoujZ7+=GZisRh7A@mail.gmail.com>
In-Reply-To: <CAKPOu+9vcAK3ZxB783j5u1MR0YB9WLWjUBGoujZ7+=GZisRh7A@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 12 Jun 2024 08:17:20 -0700
Message-ID: <CAJuCfpG+5e2mELmc=kCdbKjDPBSb4rvo03bOSYeASZnsZPOF4w@mail.gmail.com>
Subject: Re: Bad psi_group_cpu.tasks[NR_MEMSTALL] counter
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 11:49=E2=80=AFPM Max Kellermann
<max.kellermann@ionos.com> wrote:
>
> On Wed, Jun 12, 2024 at 7:01=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> > Instead I think what might be happening is that the task is terminated
> > while it's in memstall.
>
> How is it possible to terminate a task that's in memstall?
> This must be between psi_memstall_enter() and psi_memstall_leave(),
> but I had already checked all the callers and found nothing
> suspicious; no obvious way to escape the section without
> psi_memstall_leave(). In my understanding, it's impossible to
> terminate a task that's currently stuck in the kernel. First, it needs
> to leave the kernel and go back to userspace, doesn't it?

Doh! I made an assumption that this can happen while it should not,
unless psi_memstall_enter()/psi_memstall_leave() are not balanced. My
bad.

Since the issue is hard to reproduce, maybe you could add debugging
code to store _RET_IP_ inside the task_struct at the end of
psi_memstall_enter() and clear it inside psi_memstall_leave(). Then in
do_exit() you check if it's still set and generate a warning reporting
recorded _RET_IP_. This should hint us to which psi_memstall_enter()
was missing its psi_memstall_leave().

>
> > I think if your theory was
> > correct and psi_task_change() was called while task's cgroup is
> > destroyed then task_psi_group() would have returned an invalid pointer
> > and we would crash once that value is dereferenced.
>
> I was thinking of something slightly different; something about the
> cgroup being deleted or a task being terminated and the bookkeeping of
> the PSI flags getting wrong, maybe some data race. I found the whole
> PSI code with per-task flags, per-cpu per-cgroup counters and flags
> somewhat obscure (but somebody else's code is always obscure, of
> course); I thought there was a lot of potential for mistakes with the
> bookkeeping, but I found nothing specific.
>
> Anyway, thanks for looking into this - I hope we can get a grip on
> this issue, as it's preventing me from using PSI values for actual
> process management; the servers that go into this state will always
> appear overloaded and that would lead to killing all the workload
> processes forever.
>
> Max

