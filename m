Return-Path: <linux-kernel+bounces-228108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 349CA915AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2DDF1F223A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C08CA64;
	Tue, 25 Jun 2024 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcfhvtP0"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E41BC152
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274643; cv=none; b=oR6AsV+CLezm7Ov07Z3U2AmDbGa5BiyJuesZmYY1YRmpWNGYMIId+KsRAJbzBokSRGrj4OcTqr20cbkBlhPq4g+4dzFNd6bJhjbVJBKyf8tLGsymUssq3QYZNT0qUqBNuibOIbPMvkSa5DPjw0GCegfjbgqrg/WeiAEtESAV8pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274643; c=relaxed/simple;
	bh=PQCaIXBKRkTpIH7rHnct2JPFyefG21e52zzrGXOzSWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLExwW5q4ffiW/dJ/R+yC9iAyPG5iP+Npmcd35fISWK5Re3seDXQ44Yvhr0keKBcmM9kj062qxes1FGu1QslhPj7HExjL6QgZLP+HGLCSoH11RBCwdA3JWWbRqNbHV9yyQSKDyra4ljCj7kRfAw7PDdurQIcTpFezwXEulTya/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mcfhvtP0; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25cb15eed97so2434654fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719274640; x=1719879440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7AZEyQCZ5iHIrHP4p2aQPTDBULcrYpchoF8OaJtU/0=;
        b=mcfhvtP01Suk1tP2RT3cuEYG55TOsL/VKiScyC1WE6QgYw3r0lRC5PHTnx9c9frD7a
         m9z3osi7Nt7/oXmGKiY4qkfM2jBC9OqQyxD40t+QF/mu7g5biCnwuUwFdGE9sRypL9jF
         JNS3OhqlvpmTXJB5EpSnryzSzMOcwmRhPNUYrVr7IlWNO8kQHdl3CX6ErfcmScdi/WCo
         Y5S/GSXLSWY2X8Z4G5qLHedIsN3opE/HN4FSmfyVvlB5Ip/Ay/RdMwngWge4NEa6aGYU
         0Y5YDl8A7o1KDzo8n+xWRouqjFbptgqkL47jQewkgifbgQJnnuX7snTDD4wOQ/zcw/Lu
         xrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719274640; x=1719879440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7AZEyQCZ5iHIrHP4p2aQPTDBULcrYpchoF8OaJtU/0=;
        b=Fc5sDhh4+W/ueKQxpFfAbDkJxRRYMOiSEGmoU/fmEm0k5ld+3KLc4htiwuzhfAvUSD
         cgQTYPKCC92EJBJy7Gn5iEZ6r4sHIiNThRsoJBZcG2vaUbDmhq+nNbVAVXYCJrskeWol
         BW2BhLuHmrs6hQ5JrMTLy+KIeSpFG+hio1aMGKcGmvJ0a25XkeG4eFk6jyyM5CKwJQ/h
         /GbXHyNjVCKdETpsiXacteb3/H6kPB7tPd2xbKUv/4Av4cnQB6LEfXar+vWOFGtB8dGi
         nCkTGYJ0K6WgbXIt6c39C4kB9FjLWAJUsO19dvsao/QIDo7Bb1X+wosa0M7WMsim93Zu
         D2jg==
X-Gm-Message-State: AOJu0Yxr/B7eEesNArrtSIAJX7oRXoe/TWt9qohrpoT7eDdselg/feZ8
	Yjp3f3o1iSJu+79Zi57IGQwI32Rk9YV3aqTWlrTuFP/ieaTvufwAqsWlHXDanrVoV48whAb8X/d
	uViulNr24rAkArvZbnKLtkb1gtscSFQACZJwD
X-Google-Smtp-Source: AGHT+IEnzS7r1NSqg1iygUMu/HKfcZwvBqGLrIEQCn+Vgu3xfcYwn9pb+03j11Up8B3bVLoOarsAMQwjDfmrjCPmMOI=
X-Received: by 2002:a05:6871:14c:b0:254:956f:ff9a with SMTP id
 586e51a60fabf-25d06cc0d05mr5359084fac.32.1719274640285; Mon, 24 Jun 2024
 17:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523014540.372255-1-avagin@google.com>
In-Reply-To: <20240523014540.372255-1-avagin@google.com>
From: Andrei Vagin <avagin@google.com>
Date: Mon, 24 Jun 2024 17:17:09 -0700
Message-ID: <CAEWA0a4_-SLpW1Bx0ZS-nqhG5hGn6+_9qG5-jtHk1hrnHZcp7A@mail.gmail.com>
Subject: Re: [PATCH 0/3 v2] seccomp: improve handling of SECCOMP_IOCTL_NOTIF_RECV
To: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kees,

Are you waiting for anything from me? I think this series is ready to be me=
rged.

Thanks,
Andrei

On Wed, May 22, 2024 at 6:45=E2=80=AFPM Andrei Vagin <avagin@google.com> wr=
ote:
>
> This patch set addresses two problems with the SECCOMP_IOCTL_NOTIF_RECV
> ioctl:
> * it doesn't return when the seccomp filter becomes unused (all tasks
>   have exited).
> * EPOLLHUP is triggered not when a task exits, but rather when its zombie
>   is collected.
>
> v2: - Remove unnecessary checks of PF_EXITING.
>     - Take siglock with disabling irqs.
>     Thanks to Oleg for the review and the help with the first version.
>
> Andrei Vagin (3):
>   seccomp: interrupt SECCOMP_IOCTL_NOTIF_RECV when all users have exited
>   seccomp: release task filters when the task exits
>   selftests/seccomp: add test for NOTIF_RECV and unused filters
>
>  kernel/exit.c                                 |  3 +-
>  kernel/seccomp.c                              | 38 ++++++++++---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 54 +++++++++++++++++++
>  3 files changed, 88 insertions(+), 7 deletions(-)
>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Tycho Andersen <tandersen@netflix.com>
>
>
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>

