Return-Path: <linux-kernel+bounces-224952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C3391294B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F55AB2DB93
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E91768FD;
	Fri, 21 Jun 2024 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="j9Q3m6ui"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E160757F8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982598; cv=none; b=jI99T2q1tv4Zind3Goo7YRgQrumNShHqwp0HZqHgmwESUaAaqGGRd2Ie+9uc/5aO58FL7La04HXGHcENu/OWVLra8VdS/o75vRbp8tnz2fvMmtgpZIiOAPXB9mtNwa8btxYnAdc1oCry+6jz4ho8PHOy7X/Rc0fyD6y9dNihSeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982598; c=relaxed/simple;
	bh=iHNlBypQqnWvEq3zZsh0TVR1D0RIgs9Qb8YN4aw6Xp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbNbcUMmBklO/OOaP/tduE7A58knwOA+ghbtCwfGsC9KldQGhD8hVDkvK2sKEnom/pDlV6XXlOzM9eEtfP6WEMPZSKESy2sOBSkVeEf46n7qO/vczJjl/mhunGxnEYM+5xXZRmoQ211R4buiAIrci/kW8D+FO1TZHTPXc8d2K/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=j9Q3m6ui; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0272692096so1983187276.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1718982595; x=1719587395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHNlBypQqnWvEq3zZsh0TVR1D0RIgs9Qb8YN4aw6Xp8=;
        b=j9Q3m6uiYTXFmYb9u9DcFgKE8u9BrIHW3atvcRyevjWXpZbMG+iD6Ji2LdhJp0sgXG
         7ZW9aeNG/CIJwzPg5A4OiPOjH8g5c2ozfENBWvSZHGbnuqYqRprmwaILaVde8LPKz8ph
         +/2vANedVQFF4qszrE7pVHKnjte2g/AvU4sMxJFGMMHeGlsMBGn4oF1Fdl4E3qjbPdH9
         A8zhzpOyF/CFKv98aAEGYqbel+u+HTa1pjHs42TehN0wGF4wOoaHqRCuzikIKJEhknFh
         si46sbO5WtRm6FSPefeFZ1tcG9JrZygnb2WxCfE7kTy0lX3eVv/TbJEnKwaBU1zNtZPw
         PFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718982595; x=1719587395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHNlBypQqnWvEq3zZsh0TVR1D0RIgs9Qb8YN4aw6Xp8=;
        b=izX/cr+W6LasvW594QuZygdkc+bYol93foWv/oorYoR/4ljIL6aLx0xZyTPo4DYIDi
         HaI14dM8sKyrukWAzRzNbfszVlqLytL5YKjb64DbtTkq5F80WJIsNb1znoHhGHJ1uECm
         SJQxUdgAs7Qvc7p8rS/2V1qyxZmy2SAJUgpMg9LvzcmoEJ2T8dkwGqn4yit5BtoS0OjK
         ebkHhV61pPW/sgfT687TR6d4zfnzLYhcRY81232RBD6dgXbx2JAkigaUvcBvZ/pJ4EDC
         Fd6REhFEGPN4js+8VtG6AajJJO3wkiGy9E8yIvLvLpNOGdYEv5fonaQQc2MfC9Ps7N5G
         nGDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPDTgVapmCuEzF1TBs3H2hi/hNkSAN/KXyAvNiIsZzz6RAOi6BBBAcYYZFm3DAUhWWxF/BCKRmaTf96Vv2buMzdLGKnNEjcW2n3dy1
X-Gm-Message-State: AOJu0YzCisVfmWb5rlmy6IOqXLvUlIiswHF3bgQ3DDtKkpHh4EJoxNGr
	+1oOaT1jYsHQLj7hknwlLi8hM5o+XJzEzjjR/xuTJz6Dap9HY+Ed/mOWzqxMMgY/ex0FTU/vApq
	doYGMag4zWbM9DgSioOyEk+uu6bCstRrZwz/Bkg==
X-Google-Smtp-Source: AGHT+IEMfqe/p+KWPQj/U59OJ6pPq52NpQk1bFTQzunLjwN87sg82a9VsBUAQ//TFtPgISR9/iOl/OXUwE7g3JzrIpE=
X-Received: by 2002:a25:bc87:0:b0:e02:b745:b2c6 with SMTP id
 3f1490d57ef6-e02be201656mr8816068276.44.1718982595145; Fri, 21 Jun 2024
 08:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716811043.git.bristot@kernel.org> <CAO7JXPhWvLaaGqCGUZ_YCuja2T1ciWZoUnsUDnNPQ2b4yDB2Jw@mail.gmail.com>
 <ea45abdd-c301-4cf9-abb7-6983b73b2824@kernel.org>
In-Reply-To: <ea45abdd-c301-4cf9-abb7-6983b73b2824@kernel.org>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Fri, 21 Jun 2024 11:09:44 -0400
Message-ID: <CAO7JXPgmwnn=njmpMVGLNYQ=9hmmRPFeJ5d=o9VW81Vt2k-UwA@mail.gmail.com>
Subject: Re: [PATCH V7 0/9] SCHED_DEADLINE server infrastructure
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	Luca Abeni <luca.abeni@santannapisa.it>, 
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, Thomas Gleixner <tglx@linutronix.de>, 
	Joel Fernandes <joel@joelfernandes.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Phil Auld <pauld@redhat.com>, Suleiman Souhlal <suleiman@google.com>, 
	Youssef Esmat <youssefesmat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 10:59=E2=80=AFAM Daniel Bristot de Oliveira
<bristot@kernel.org> wrote:
>
> On 6/21/24 16:41, Vineeth Remanan Pillai wrote:
> > Sorry that I could not get to reviewing and testing this revision. In
> > v6 we had experienced a minor bug where suspend/resume had issues with
> > dlserver. Since suspend does not do dequeue, dlserver is not stopped
> > and this causes the premature wakeups.
>
> Ouch! I will have a look next week on this. Do you guys know any other bu=
g?
>
> an earlier report without necessarily a fix/work around is a good thing
> for us to try to reproduce it/think about it as earlier as we can...
>
Sorry my mistake, I was buried in other things and missed reporting
this earlier.

There was another minor regression seen lately after we fixed the
above issue- idle cpu was spending more time in C7 than C10 with the
dlserver changes. This was reported very recently and we haven't
investigated this much yet. Just a heads up and will keep you posted
as we know more.

Thanks,
Vineeth

