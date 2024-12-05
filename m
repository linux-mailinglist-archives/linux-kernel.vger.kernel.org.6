Return-Path: <linux-kernel+bounces-434021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A469E603C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9081884F98
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EECC1C174E;
	Thu,  5 Dec 2024 21:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iMWPnM1N"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8281AD9F9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 21:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733435234; cv=none; b=QCUTeAn+ePtK2fbnZ+3y8aqAxzXFfH8G9Zy9Rood3MlBGush50pDUCzi8jQLaXl2/kxC6kcm5IoHeJhHRtUvLyKImXE9K+Ze1xdByCV5zTHSqqujrUyMNzVIGSFEElPnqKAVTgWuNu5FDUTmq4jbTQAHpfnudTudqDSBCEkZQBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733435234; c=relaxed/simple;
	bh=+gKHT17fpgTsmINLHM4S0SmcNBR2mCcCALCZpCPTW5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdUBZE8Yni2GeWFA0slvbzCOn8cYv1lOeqb0OJ/s7rvA+t09fjDvWjWvnPygoWyVSHdMWlSMQki+REYQFxU8miPtK3MrW3THnxSvKMKQBpb80TsjJ9IIWQ7MCuH36F94k0258/hdVHGCjhz679EGW5vq/c4VyKO2Vbpko5K4nhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iMWPnM1N; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9ec267b879so270544466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 13:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733435232; x=1734040032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjYtjeGjkvs46TYM5dfaW2DRd/CYlP7wpfZ+d9CfqG8=;
        b=iMWPnM1NPkiyAGcny0v22D1usaZyTsCf3tryIZQ+eo1VSGWC/B21NtEqThbxiIBz1m
         dBIw7O/RIbNWI3KUzteunALTulP8aZTnmLOPynwaABV/wy9I5WPMVDTumhz726lG3Lc5
         RJoTITGrXCWb1kqsIHS24c53yaohh4S03yD5HpHDYW+vb+g1RFgC1PKWsv09hezd6q+K
         klYolMLVP28Nl+g6CcYxTYwDisetPokkxGaXf0jVoo2PVxUsdAOn8QV075SEquhj/PVJ
         KngWIhASq6QliELo5BKxodJyI553h8DSAPnz9nsGUiw6KXVE98z0zsqiPPdly/EV8ZGD
         1+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733435232; x=1734040032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjYtjeGjkvs46TYM5dfaW2DRd/CYlP7wpfZ+d9CfqG8=;
        b=Q/PkhEGHwhW14HFN3zxDdBxzJBuye03gvZWFPmDNbahNubM+hZpLSm9V002kdSoHGy
         M5G56ERYyUa8gfBjP5iTq/IuX9ZFunT3qS4ov6r6VXJMLCLaBrE7JYJDVna4H6g48O7M
         MHzwVy9z6Vfz6spjFxEcYOG0SJPS8n/bDLYwEGLBI82O7jMU4kLXTYBzpdSbgaveIAcP
         Hol251Dap9E/oJi7u1IBbfyG5aFvLRNjWNLa04ShPbc65yq+0LPCY+HGbnfGQ6ttd/4w
         5pfSxH1Jz7JznPeQb4mbbDvwby37ysw3L1wdZWA1ffS+fzcbqTj8u6sA53R75XP21FR4
         qvtg==
X-Gm-Message-State: AOJu0YxqCoxTHLMBL+L3oyigzg8ZxoPy+Cr/uAP9IFw1bdj7mZ8bHWJ3
	kylJsb2nxjenGAH3gidoJEuWaeVZP3yH6RTiVwTGyKJSsnUOgDwtLjEoePYpugB+uwkhZ7uuqax
	8lH4KM8kvC4SYpCi2F3CVZAhgaEb0GpvJd/I=
X-Gm-Gg: ASbGncstARejbElfHnOJToO5oLTwjI+KtUKId5tfY64wKSsz8mFRtA+lrlbH9p2NMgr
	L9cKhuPwQiIILC/AJW6SFeAFQintHruqa6abqmg6SFu3CPzwmeg9JlvOanjwK
X-Google-Smtp-Source: AGHT+IHcZf5ixOy0ePP6V97akv7etJNrMoQCWsRlDuQn8hwvq5Ruba6r6jziGPpjaMWLkH1okE03hd1m8k2SgyJjOp0=
X-Received: by 2002:a17:907:2cf7:b0:aa5:1585:ef33 with SMTP id
 a640c23a62f3a-aa63a039cf2mr36156266b.23.1733435231508; Thu, 05 Dec 2024
 13:47:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205211632.1181715-1-jstultz@google.com> <06444675-136e-442f-918b-e7887d2c535b@wanadoo.fr>
In-Reply-To: <06444675-136e-442f-918b-e7887d2c535b@wanadoo.fr>
From: John Stultz <jstultz@google.com>
Date: Thu, 5 Dec 2024 13:47:00 -0800
Message-ID: <CANDhNCqpC7JxNVjUzsERaMh2VXxkhoGQwPqrnGAH89hgRZA8XQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] sched: deadline: Remove unnecessary goto label in pick_earliest_pushable_dl_task
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Wanpeng Li <wanpeng.li@linux.intel.com>, 
	Todd Kjos <tkjos@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 1:23=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 05/12/2024 =C3=A0 22:16, John Stultz a =C3=A9crit :
> > Commit 8b5e770ed7c0 ("sched/deadline: Optimize pull_dl_task()")
> > added an odd goto label that seems to be unnecssary, given its
>
> s/unnecssary/unnecessary/
>
> > called unconditionally from the bottom of a while loop and the
> > label is at the top.
>
> Except that it is not a while loop, but only an if.

Ah! Apologies. I need to get my eyes checked. :P  Thank you for
catching me there.

> Maybe, changing this if into a while would save a few lines of code and
> be more readable as-well.

Yeah, Todd pointed out the unconventional usage, but my brain mis-read
the code as being a while(). I'll resend with that change.

thanks
-john

