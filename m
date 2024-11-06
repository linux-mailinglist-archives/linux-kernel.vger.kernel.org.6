Return-Path: <linux-kernel+bounces-399021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 765FA9BF9A9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35771F22735
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3BD1DE2CD;
	Wed,  6 Nov 2024 23:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K6qHlCnI"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A80C13A244
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934177; cv=none; b=nBQRGnnUzKyPSSzSfM9el/ucqXPX4MNWcFvcOmAFAH3ioDLiIdgR1JAAnC/bxI5/TUQVgT1w9uKZ5EKtzzbhevNIYlnmLvbbQTU+kRM2bMQbyGxZs2hmI37Nr7MW6xqzFiWcYJUOQDVyqaZNhiwuRoGGd7VJ2BefeH8eh+mflJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934177; c=relaxed/simple;
	bh=vBXPxdEdRZfjzaHPelGTnrLmAt4+mOFflNoOS2Ws6lI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjGF24UyNT3oForrFVja6PZfvOqmln0DgWe2brQ8q3AbbvRqL48on7Kji5hRxC3fWtai2moYIXFYhI2gpokDPG8yFjWXkXc/NVSKtGy48pDtaOY9k71Y1/NpHTWolldZ7r4WMSWF6fByrbOKZUddG/rTYjuSnfURu/Gx6fX84zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K6qHlCnI; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so299548e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 15:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730934172; x=1731538972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBXPxdEdRZfjzaHPelGTnrLmAt4+mOFflNoOS2Ws6lI=;
        b=K6qHlCnIhk3UtNBtNiN8OZHlywHOe611yQlkSwBAY7oQqn6uEtTerISSPLLcUDrBHV
         3IvZUDwNsOmFcUfUR2Dr1MJcdSAbNpK0imZF5kdEfIclPjmG0bw17FYWrptlEev2rPcY
         GHcfIVLsKCDnNwckN5+VhA893Y9KtufJSNwHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730934172; x=1731538972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBXPxdEdRZfjzaHPelGTnrLmAt4+mOFflNoOS2Ws6lI=;
        b=P8Q6Ni9yquGtbBGjic4nDvvlymNmmLc2gSv8J5mJKS3QHiY8YsQkhzXY/P0VTHkLu5
         Txl0ES5aifJZZLUw+XuSHcIsI18mk17/TtRM4rdcyCLM4436wmtQi2zB/pEUDlhp9+2w
         dS11UZQe04RtKnYVIEKXPnvC5yAy8HI/2HQu5qY+3EBAzXouss3IZu/MrnHn6gvo4LFw
         ALgkjdleaPaohwit4cCilzMFYn42ZqK+1g/NOk66ZhpvWYVvIoMCyKTNYEA/UV43F66q
         GVVEV5E3hMq+mfkDzmmmsn8qmRzUZaVYb0+YWFT+5A1n2amoNrvtPFpYRYGGBFh6cL6Y
         Dl/A==
X-Forwarded-Encrypted: i=1; AJvYcCU1wYexYeimqL5K0dcLVHqejIirGBgi+z4Gx3LYjG3mPqLHQH2NsOQm5ZC1h49HK0Rp4jlOdrVX0BWj7Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbO3rueyH3+azDilRRmTLrmGz/2EdzVoNDq9qQaQ0Ws6jnE4It
	cwXzB2naqVDbzcG9qXtuKmf3Q5GADGNc0vS/aZfZZopIeNpLJ3qYbyzXqdAW6N3HPaiTtuhbaYv
	rRQ==
X-Google-Smtp-Source: AGHT+IHDrDOUG/AmMlIoRw0wo1GPMlGh1gZWibkljWaiZn7raqCz/RbntzFE0zbPyOyQHpQFKf7vaA==
X-Received: by 2002:a05:6512:1392:b0:536:73b5:d971 with SMTP id 2adb3069b0e04-53b34c5f886mr21432958e87.38.1730934172383;
        Wed, 06 Nov 2024 15:02:52 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a9d20sm15439e87.217.2024.11.06.15.02.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 15:02:51 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e59dadebso295194e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 15:02:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX63eYJkhFy0+eQqpSw3Mr021LrkrJYEpi3XeHaGREzD3ClanvBDBvgjX/FAqIO2mZ3noigXN5fDhhSu8w=@vger.kernel.org
X-Received: by 2002:a05:6512:3405:b0:539:fcb7:8d53 with SMTP id
 2adb3069b0e04-53b34c5fa2cmr21132078e87.46.1730934170632; Wed, 06 Nov 2024
 15:02:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZyqSm4B4NuzuHEbp@slm.duckdns.org> <ZyqS0GP9h2hG2lvC@slm.duckdns.org>
 <CAD=FV=U7z-Lf_1T2cYyae3b6W5Joyp+oiRSp-iXe_3jz9Aqoaw@mail.gmail.com> <Zyvo7lFcnAddB9RT@slm.duckdns.org>
In-Reply-To: <Zyvo7lFcnAddB9RT@slm.duckdns.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 6 Nov 2024 15:02:35 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UTh=JGUDZxO74+ZRQbF+yzcWnBo-f=oie0msmBn2_00g@mail.gmail.com>
Message-ID: <CAD=FV=UTh=JGUDZxO74+ZRQbF+yzcWnBo-f=oie0msmBn2_00g@mail.gmail.com>
Subject: Re: [PATCH sched_ext/for-6.13 2/2] sched_ext: Enable the ops breather
 and eject BPF scheduler on softlockup
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	sched-ext@meta.com, Andrea Righi <arighi@nvidia.com>, Changwoo Min <multics69@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 6, 2024 at 2:08=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Doug.
>
> On Wed, Nov 06, 2024 at 01:32:40PM -0800, Doug Anderson wrote:
> ...
> > 1. It doesn't feel right to add knowledge of "sched-ext" to the
> > softlockup detector. You're calling from a generic part of the kernel
> > to a specific part and it just feels unexpected, like there should be
> > some better boundaries between the two.
>
> I suppose we can create a notifier like infrastructure if directly callin=
g
> is what's bothersome but it's likely an overkill at this point. The secon=
d
> point probably is more important to discuss.
>
> > 2. You're relying on a debug feature to enforce correctness. The
> > softlockup detector isn't designed to _fix_ softlockups. It's designed
> > to detect and report softlockups and then possibly reboot the machine.
> > Someone would not expect that turning on this debug feature would
> > cause the system to take the action of kicking out a BPF scheduler.
>
> Softlockups can trigger panic and thus system reset, which is arguably al=
so
> a remediative action.

Sort of, though it doesn't feel to me like quite the same thing.


> > It feels like sched-ext should fix its own watchdog so it detects and
> > fixes the problem before the softlockup detector does.
>
> sched_ext has its own watchdog with configurable timeout and softlockups
> would eventually trigger that too. However, that's looking at the time
> between tasks waking up and running to detect stalls and the (configurabl=
e)
> time duration is usually longer than softlockup detection threshold, whic=
h
> makes sense given what the different failure modes they're looking at.
>
> If sched_ext is to expand its watchdog to monitor softlockup like
> conditions, it would essentially look just like softirq watchdog and we
> would still have the same problem of coordinating detection thresholds.
>
> Having a notification mechanism which triggers when watchdog is about to
> trigger which can take a drastic action doesn't sound too odd to me. If I
> make it use a notification chain so that the mechanism is more generic,
> would that make it more acceptable to you?

Honestly, it would feel better to me if the soft lockup timer didn't
tell schedext to kill things but instead we just make some special
exception for "schedext" tasks and exclude them from the softlockup
detector because they're already being watched by their own watchdog.
Would that be possible? Then tweaking the "softlockup" timeouts
doesn't implicitly change how long schedext things can run.

-Doug

