Return-Path: <linux-kernel+bounces-577678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F360A72036
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48DE3B9E65
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD7625E800;
	Wed, 26 Mar 2025 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F6X62d2+"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B27F25E476
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022093; cv=none; b=Ai+SQBmjm91+fFE4gO6Y8bbEtUD62TUWDak4uFb5C2/Ish0CusPBemB2jtrhAmw7H0BZwkuNjEayaxCJ7UBMCwnAzh997ZXnEovBUc/V2odzyUSSoCZ6n4SOoCrDgqci95uFYJzn31VF0X075O+StzJBRvLSMcsLoDjobMKtDqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022093; c=relaxed/simple;
	bh=lkwNgZSqUlm9DJirk/oVV9tPmlsUXC77j/zjRQBf3B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cr5YoUrcQAOTQdwX6zaZuTvyU9hzbTGiRTHFQO10Xn5QqeafVlZJA7WepyWhIdP/9nqfV7drMmjz4+vZ1vqnUMkG4/p5t+9/TPvjC/B6aC96RfIT8619v38akTqshZCAIKII4gP76aqOQRNac8jscfq802tLbMyor54ucpLWUbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F6X62d2+; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ff1814102aso11841167b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1743022091; x=1743626891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KugdLRUS2IB/bWcBImczTBUF8xvxY/0i4eovnJ/pJc=;
        b=F6X62d2+OJfKCwhsA6Vh+qLbkDeDYnzecTxBZ15ubeyfAk61vWwZ84hUXEwJ7g2BYW
         oEM8vlHrNHVSukS3R+XmA9xwuEelzlnX/Vv/l36Z1qZp1i4O+S7SYuIaQ0qMbjVTxQRY
         9VUAfCQFo2HslAoLchRsXyWDpKfzSLpOYPyFiHKdFEj11TZF9GXxwAiszDzgqhhHkM8K
         pq+S4P2Csytc9k1Sw9nrc2g39a/1uaUl2LhAICIHHMb+xua1adF41MvYD2vPn2GYZVj0
         IVpVAwg//tQ+u268GeHltkrFYbQpmmlfg8Xk90bsrpmEX3rWqar989mwT3nMQK4jWLN0
         F92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743022091; x=1743626891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KugdLRUS2IB/bWcBImczTBUF8xvxY/0i4eovnJ/pJc=;
        b=ZzbkU7p68tSXzVM+/WVy1VvrmXmF8VSCezO0mrTr8XDXo24/0epXlZTOrL4md3YTXl
         Mwki2VQRPzk1tJ+7RaOeidtxPVn7qkyDq5HMKWMRktQjZrLo9GUPTevTnAVHH5CQHKc2
         U+FyxDC0lyTcEVHaK2b4moPID7WJZJz2aufSa9XtHqfvL3NGHkJNdbim/mWLjaNVk8hT
         sLZ8ZMW68vcyfc9BH/IQgt8HTZigwuYOxJ4DP9OCpgCjsbMnz6UCa9tC3KXwk471InSZ
         Hk9EMPQeJioXLtSylXLyJfj8Iex2hQP+LEyNm0eXmZtW0YCKSe+EZPI30FESulwplSgh
         esTw==
X-Forwarded-Encrypted: i=1; AJvYcCUzcN9LT6fT0kmZx3OAuprS2OcwuMLFEFjomVTY1e4YH1AZcUuwWa3Jw/3DxDddXnH8iJJwwYTPbL2Yscc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFz2rMMeUDtu7zILrj5te0A2nGDBDK86KlBAOfXg61U1OyUS2C
	uVQdy2y59lX3KLCD05gHNgmcOguov3358qXKzzd7TZSUoxle9+76qIzUn1MSUjm2LCs5tgeM4G9
	Unrhm33ZCzIR34il0rhk3VdoORggTi8k7RaTs
X-Gm-Gg: ASbGncv0xF11vpcgGGVjESvWg0Ts4MkQkrwGs3VL6PYkTOXiSHwf1H44rURy8Qeg67J
	4htDfmD1SrQdeoJQmnRlEYRpfrMe7XqUvaLv2+Qsug6pa7IubNRjJNwO9diU3b4LPXyfho0xHXI
	vtHb0mp7Or5MCqciA1DbiPIWhM/Q==
X-Google-Smtp-Source: AGHT+IH2jQrsJDcBGNU0CPjcKd4UHxAwQucgB3nqCzI3sVup8fdoHxy8f+YJtEB/KLQhTPeRracAiI//nfAKZ0B6MVY=
X-Received: by 2002:a05:6902:2808:b0:e5b:32f5:e38c with SMTP id
 3f1490d57ef6-e692ecfbe45mr7747622276.8.1743022090883; Wed, 26 Mar 2025
 13:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
 <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com> <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
In-Reply-To: <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Mar 2025 16:48:00 -0400
X-Gm-Features: AQ5f1JqLL8hQNV93T465HG7TmuUvsJm2aGb-Tsdg4Dg6IQiLpz7nTzcvVAy5xw4
Message-ID: <CAHC9VhT3D7X=4SpO5xbYm=JUwJqTa7tn=J6QMDBV96c7VBUw4g@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Cameron K. Williams" <ckwilliams.work@gmail.com>, "Kipp N. Davis" <kippndavis.work@gmx.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 3:40=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, 26 Mar 2025 at 11:36, Paul Moore <paul@paul-moore.com> wrote:
> >
> > From my perspective this is largely a continuation of our discussion
> > last April, and considering that you ignored my response then, I'm not
> > sure typing out a meaningful reply here is a good use of my time.
>
> What you are saying is that I have complained about added overhead
> before, and you aren't even willing to explain why new code was added?

My comment is simply that you have a habit of disrespecting the work
done in the security/ space (e.g. "security theater"), and despite
explaining how that behavior is detrimental you seemingly choose to
ignore these concerns and repeat the same tired language.

If you want to have a discussion about something substantive, I would
suggest refraining from insulting those you want to engage.

> In other words: why were new policy entries added? The commit message
> and the list explains what the commit *does*, but doesn't explain
> *why* it does it.

Looking at the pre-patched code one can see that SELinux only enforced
access controls on kernel module loading; other operations such as
kexec images, firmware, policy, etc. were not originally included.  As
this happened back in the v4.x time frame I would have to go dig
through the archives to provide a fully accurate reasoning as to why
SELinux only concerned itself with kernel module loading at that point
in time.  However, speaking solely from memory, I believe that the
initial focus was limited to modules simply because that was the area
of largest concern at the time, and many of the other file types were
not yet gated by the LSM hooks.  Moving forward to the recent pull
request, the LSM hooks do have the ability to gate these additional
file types, and for a LSM such as SELinux that aims to provide
comprehensive access controls, adding support for enforcing controls
on these additional file types is a logical thing to do and consistent
with our other work.  The fact that these changes didn't happen at the
same time as the enabling support for the other file types is likely
due to an ongoing challenge we face where we sometimes fail to keep
current with all facets of kernel development.

--=20
paul-moore.com

