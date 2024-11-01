Return-Path: <linux-kernel+bounces-393020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C549B9AEA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 23:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837CA282B65
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 22:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637241E7C25;
	Fri,  1 Nov 2024 22:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8pEqHLp"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636481D9667
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730501101; cv=none; b=VSgF4Fi1RwYAgkyeGs5TcqZ/VSCMVTAcYsVMbqvWXFelZJw5sFJvY6dxspZ8Pf2xIEPRllpG5aAwxHKuQ7bRIPBahl4eU/Gck9aEcTLDULQvyBs2Vka0zKm4DfwsncTN6o6NCTWo51mz8e52vnVE5QD5gHXXvbwuW/UhvuCegJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730501101; c=relaxed/simple;
	bh=tww+CAXs91Qqeg7ehztuvXzkX5L0+hkqCCOc7+Yt2+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VN1UT1dJ12Ou9ZN+HboLv1Ft18CMsGVfXK1iN3icbJrfjR31YyavKiCJlRjvEmDirqgxdqFkL1FNtyiIUqGkx+Jo5vO4kkEOP4PrviayFcj0MkqI6j158rRvDGRJY24KCtW3G1TG31/TWDJ7/b56UfY+QcLnGtoyGLovpfm9ruA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8pEqHLp; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so33525ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730501099; x=1731105899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+OHF9/d5wpYVW+gB/DYvvDEg0LTL3nHbhh0uESfPxk=;
        b=I8pEqHLpdeXkldb51K8P5+zE77enEsOGn8Jfs+ulFCY/xMatB8pwLpSRZvcNkeIVaz
         zElNXwyKXSEwC+/6FvbNEOh57SMxqFbIp8TJroucSAf1GWQtinbq0ioi+Luo167mBN5A
         oLDF9/fjvKr9MQ4uXCffkRDxdZAnJDe9Exg9GGdUnS0db3eN2EKEH6e3pb/HNG5OWtRO
         z+6Rg7SxDxWG224Y88aqdj80tXkP9ciQs5X8jagRUmshnK2nQqJxhBH2hKvj+qYZ12wW
         jxu23jampo2uSH5GNbNVoP01PziLEteQCPgpFk8PZ3qWG6SNUCBkQ/dQzNdUBlvJO/u2
         CsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730501099; x=1731105899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+OHF9/d5wpYVW+gB/DYvvDEg0LTL3nHbhh0uESfPxk=;
        b=ntyi1oQNH9JM2Tjysxac7xrOUYGV/9iDR1zvL/AISngwIcdgyoU43z76KX8spGlXlP
         t23aoOuy3XnxoPcobYjnGDo4oh2aqi2CR8Jk6amiJZIyABus5mnKjcLg0mwr9sbWB106
         oaCPv7fXeBxGXpVTO1mP4a6WNTrnGtnwnlE0OPnFKIZHVUfm5K+s6fMwUUVYFtX4zD4F
         Ma3Bi34LlEF6yqaZ8Z3ApSdT1sxGSfaHoIPpoqnPqmRuvyH7TqlNPeOYShS/yEpsJrId
         VfZGhBYJfo1Dd3sUDAPhGL7GuTHK5qIYN72KPrVpFkpA5i4Ad6HL84Z4YJYENI7Xb5+Q
         1V5w==
X-Forwarded-Encrypted: i=1; AJvYcCWjfD8rKXABaNazE29KjHobbf67aqEndyYzRXwxz+hnHL9As5zwU//ooOjViYlfh3XiULo/rMFKAz3Y634=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1/RpA4weDpesmKs1rF+z+NgNH+QYdWb3kIoDFqGooyewGd94h
	DMPqjB0En6j4txcluAi8QDAifgXT1CGTAMrlzgQPi+bnayI9JuNYnPWDaPRN/AYN/gmBfv33km2
	UABZ+kKgRKVR0aGnnB2YCqhYowi0Qnkrjhb0g
X-Gm-Gg: ASbGncsvfiwogJQ+PZHqIYlZ7mHgtoPmC4HzH6DwC0AyUpwHH9vNZ6u+EY6MK4/1Xe8
	IFPaNhOR2jGfdzzZt6xNDOT7c+JXlQ7E=
X-Google-Smtp-Source: AGHT+IGFvTS1CkkUfsRADjGNO9iJPaDQG9w00HkbIAdlhQX201Kv8MVYYPnstfeXKyBBXvjF8WTGZbfmmTcDh2jZZ7k=
X-Received: by 2002:a05:6e02:144f:b0:3a0:aa6c:8a50 with SMTP id
 e9e14a558f8ab-3a6bf22456emr317655ab.29.1730501099375; Fri, 01 Nov 2024
 15:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031200438.2951287-1-roman.gushchin@linux.dev>
 <87zfmi3f8b.fsf@email.froward.int.ebiederm.org> <ZyU8UNKLNfAi-U8F@google.com> <87o72y3c4g.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87o72y3c4g.fsf@email.froward.int.ebiederm.org>
From: Andrei Vagin <avagin@google.com>
Date: Fri, 1 Nov 2024 15:44:48 -0700
Message-ID: <CAEWA0a4Kz9exk04Wgx9UZ9YFfURnS-=50TWyhPHm3i-N-D_8DA@mail.gmail.com>
Subject: Re: [PATCH] signal: restore the override_rlimit logic
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Alexey Gladkov <legion@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 1:58=E2=80=AFPM Eric W. Biederman <ebiederm@xmission=
.com> wrote:

> > Well, personally I'd not use this limit too, but I don't think
> > "it's broken, userspace shouldn't use it" argument is valid.
>
> I said if you don't want the limit don't use it.
>
> A version of "Doctor it hurts when I do this". To which the doctor
> replies "Don't do that then".

Unfortunately, it isn't an option here. This is a non-root user that
creates a new user-namespace. It can't change RLIMIT_SIGPENDING
beyond the current limit.

We have to distinguish between two types of signals:

* Kernel signals: These are essential for proper application behavior.
If a user process triggers a memory fault, it gets SIGSEGV and it can=E2=80=
=99t
ignore it. The number of such signals is limited by one per user thread.

* User signals: These are sent by users and can be blocked by the
receiving process, potentially leading to a large queue of pending
signals. This is where the RLIMIT_SIGPENDING limit plays its role in
preventing excessive resource consumption.

New user namespaces inherit the current sigpending rlimit, so it is
expected that  the behavior of the user-namespace limit is aligned with
the overall RLIMIT_SIGPENDING mechanism.

>
> I was also asking that you test with the limit disabled (at user
> namespace creation time) so that you can verify that is problem.
>
> >> The maximum for rlimit(RLIM_SIGPENDING) is the rlimit(RLIM_SIGPENDING)
> >> value when the user namespace is created.
> >>
> >> Given that it took 3 and half years to report this.  I am going to
> >> say this really looks like a userspace bug.

This issue was introduced in  v5.15. The latest rhel release, 9.4, is
based on v5.14...
3.5 years is not a long time...

Thanks,
Andrei

