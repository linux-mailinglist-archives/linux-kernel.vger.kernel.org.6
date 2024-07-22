Return-Path: <linux-kernel+bounces-258966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0E7938F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBEA61C2031B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B353216D4EC;
	Mon, 22 Jul 2024 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hwsJz96u"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7967F16A399
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652376; cv=none; b=qY5OfiDiJp3vEE2s6HOKSfMw+8LHvYnG9OvesofwD3O1TgEec7x1/cmocgqYZbS0MUWwtjb6xD00JuD4uvhh79+ISoPICxtd1o3w909BWEkvO5b+Zf9Qv4YQ1ForH+dbqS+JQluzTWYQ29peezLjWf+JjeQLaAfnsVfwSNu/DUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652376; c=relaxed/simple;
	bh=08A40bbhznrlKFn2gZRVp22dL57vJ4Sag/bNSCApeS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvAvc1h8GSJr5mk4yXelzJRO9g1tG0db0H6OHF19Nv+6BxqMhHSogTGNsik+ZjGmtJuy7geBlJLcbeB54OW6C9iTzsVMUK/a+UzhWMEePyvDUXWUy21pjPS0r93cgEBj0JiVJT/SZNFVm1Yblk3X/HTmPBI3rmzc6pFWE4Ar6TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hwsJz96u; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so33947a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721652373; x=1722257173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkPk7qSJmsTXHG/tHIONPG7HUxcysTuWtB6jumYqrdM=;
        b=hwsJz96uMThGwx6LT8EhiTqTudkA+mR8pbojo27V60gmjZxGlV1KxUijcXPGzG8v3T
         3mnXTeSGdueTIAFvQgQH/RMJd+DxTmDfEfCG7OS48vwhBmmTEEJ7WiCCVhz7HmNwYk+o
         fxt2L7qHSCSPYNvrzCe/bz0ZY5JtFf58rAbcXjrxdVNH6a9PbnV1/GzVsR/jeSlRQgQg
         OfA9PtjZ960os9F7SJkJh+HdLROtJqUI6ZTpu3W9iEnvyNm8PDznWqloE/Kka5NUGFOd
         z2+CEXHS2d6RspBl52zGvYJDN9hHa/seBSmJPsdS3G0G2VwGvDgPFDDN6qwKYx5MItL4
         kJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721652373; x=1722257173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkPk7qSJmsTXHG/tHIONPG7HUxcysTuWtB6jumYqrdM=;
        b=qSpmA2d3td/DzzgQoPP1jfW3QWhs9mwcLIn0VYsKWD79DUxzkgVofmB+gj2KVU637A
         vjCtdUI/MpUpQYFiJO7q/LBZrHPlTAaTyBoEGyZ6Uuh/BQS6Pp+yKSqQnmAV6t2JLFOQ
         wrXvmfPlfxQpUnnEEtTAiN75Go9xgsWoJ/dPm2OSKTvtbbsIeizTBpYUp5cf+hBrgKk8
         kW7Iu59kJQUrI+o9waI7T9CxPHpqnhObx3iJnHWTLP8T7b1TnXqEa1iZ+Ouqzq5gr0H2
         MvB/CgyqsCtepDS/MSD+mC3Gzakc7mZ1cv5Us81S6ohbiM1zflfCXycVR2qzMlytYF3s
         11GQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1gNcoVPFFXXOC080mfZmsUcJqp1RLMCgIwyLbHZhf5CozJ0P21oTM2hQ+rrW48UleLv0QTz6yacyCW745e3lJohwKXS8LLlBYaKOf
X-Gm-Message-State: AOJu0Yzry92PXbpAk7fqpd5H0pwBr5jHoUB5YtLnKQiklgwUFRVumDi9
	RJqTjhLsL81dAz6dMwpCjf351ocwetOzgjtrkDJPkQXBYtB1y/4kHzg4I0KcMBfe4BjblGH2msI
	3ytIVoBogl4JT8kzssYU/oCLEBFkQ8OF2iEph
X-Google-Smtp-Source: AGHT+IHCi62PM+KOTFc8/S9a0uMCt8sBsWfBOfvWEaTCwIQZzIuRwZy1cJ/vucoCoYuRW5CLLmMrzJQs2JS1pzid0TE=
X-Received: by 2002:a05:6402:34c9:b0:57c:c3a7:dab6 with SMTP id
 4fb4d7f45d1cf-5a4a842af45mr220593a12.3.1721652371314; Mon, 22 Jul 2024
 05:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36958dbc486e1f975f4d4ecdfa51ae65c2c4ced0.1720213293.git.fahimitahera@gmail.com>
In-Reply-To: <36958dbc486e1f975f4d4ecdfa51ae65c2c4ced0.1720213293.git.fahimitahera@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 22 Jul 2024 14:45:35 +0200
Message-ID: <CAG48ez3MNJ9QiULabERc-SWQLx4T80_UOvsqCVFXTi3yxeeMRg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Landlock: Add signal control
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: mic@digikod.net, gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, 
	outreachy@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 11:22=E2=80=AFPM Tahera Fahimi <fahimitahera@gmail.c=
om> wrote:
> Currently, a sandbox process is not restricted to send a signal
> (e.g. SIGKILL) to a process outside of the sandbox environment.
> Ability to sending a signal for a sandboxed process should be
> scoped the same way abstract unix sockets are scoped.
>
> The same way as abstract unix socket, we extend "scoped" field
> in a ruleset with "LANDLOCK_SCOPED_SIGNAL" to specify that a ruleset
> will deny sending any signal from within a sandbox process to its
> parent(i.e. any parent sandbox or non-sandboxed procsses).
>
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
[...]
> +static int hook_file_send_sigiotask(struct task_struct *tsk,
> +                                   struct fown_struct *fown, int signum)
> +{
> +       const struct task_struct *result =3D
> +               get_pid_task(fown->pid, fown->pid_type);

get_pid_task() returns a refcounted reference; you'll have to call
put_task_struct(result) to drop this reference at the end of the
function.

> +       const struct landlock_ruleset *const dom =3D
> +               landlock_get_task_domain(result);
> +       if (signal_is_scoped(dom, tsk))
> +               return 0;
> +       return EPERM;
> +}

