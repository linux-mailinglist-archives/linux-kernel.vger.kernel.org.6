Return-Path: <linux-kernel+bounces-514092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA612A35249
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 00:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B8E16A8D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E494E1C84C8;
	Thu, 13 Feb 2025 23:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GNFqPc/t"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451C18C924
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 23:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739490265; cv=none; b=C7DnzpSMGwZypx9YOXBXq+82/aGLJlwlgwdMnJodxXDNq0rUA8yfmfC43Xts+oi6BF+Zs5mAENOoaYUt8PMVkJdYr+wM5SBTlIt5i8jZ0pKTK0jD90xGThUihKftFRtWwOs2RoY8Fme2lhcDRumw4Whk/m2yN48hLWlawE5vauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739490265; c=relaxed/simple;
	bh=dVsGZ2QbNBgEEQsJ3N0ct2PlyNRGV/u4n5QHhnEVl4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R64OhxGSeAy79xciYY9971WfhtMKbbV7i2iPwFQaONsGfTsyr8f0uApFr6mUzRv+QMgvjIpliuQJ+jnuuzDj8ulHxURfsLHGXGDFwqBV8FQaPYBIVSIEWELNDdQLgnjVbgdXTAVHz9AXICW4+/iN5xN6Bb2ZGM+R8DH+ikeL7Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GNFqPc/t; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5ded4a3bf0bso3845a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739490262; x=1740095062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVsGZ2QbNBgEEQsJ3N0ct2PlyNRGV/u4n5QHhnEVl4Q=;
        b=GNFqPc/t4R9eJ+Akpw5Q0Znt5xaQLAhuFutp2SqDQMINuiiT+T+V+EM1lbcA7tjCzI
         Pu41FArE4kR3EscwDlzVZz3PeMgQLN9iNJECXd78M8iEY1EmVh1vJQd+rbOnQ+t7ODVA
         o9s/dRoqFTC03tbtP9H2a7nwj5LFVBO+ax9zJindgPZRiZxhFCoZIqC2kbOVs/ZHjNVb
         l5QofNNFls8EFsD9kJSXR+huLVVf3oo364zbayrkhcAbFKN/r/CMg2JPhmDLLcvV9utB
         KEXWkrjzajoGxgchfXeojRjem0BEODDzsEjUuHlA4vQj0qbxN/T9XggrS2VzlgNaHx/N
         /R4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739490262; x=1740095062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVsGZ2QbNBgEEQsJ3N0ct2PlyNRGV/u4n5QHhnEVl4Q=;
        b=mlff+OjvTtgxPXOh7aR7FSZLNk46RW6GOJKfeQiMGIbLqqLbBOl6EgVXLDQ2glUDGa
         lH+ylqy+QJchQIGLAg+/xHkv63KKvu/GgrsoMWxhQ94eojJngl7ZTU2QERN0ytt2lnE7
         MdBf9Jblq6oFMTf6DYhxvTensfwL7RuaCJvlpc2w/YvPj3t39ncm7iiAF/VLz86ux5og
         mCar+7c24hKe3qoUlq8dQ4mH9Q0nDl39FfY/CcEWQD6+mcNVaKPebeDQWI2EWa3L+/58
         IbtQjJCayGfqV1sy6lah/RS89uaq/OiUgTyjBzYnhsK305iXw/wxW2fU457fMCdaPMZq
         HQkw==
X-Forwarded-Encrypted: i=1; AJvYcCWLMx528rBP5EpoXRcJApTyEIeUhz34fky5nqR87/hdJt+QRvTlFTvdz1djDQ/dw1ID+aXrrxbVoRs/qOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylNmPbbJeVYCWUL39toxVpXCMIUsQN+np6GgxtLwnfqROfMIIn
	wLd92tMWCc20osgGeb+fExVx70t/zi1Z0mZ1otTTtK4MW5kKd1c3hVViZT0OH3Aa4L9S7FsAEXj
	DP+whz0VnQzVdIpEJILQ6d6lSXxXswMWusB9T
X-Gm-Gg: ASbGncuyK8l5yXPDxtdPfmm4pXlnpVFd8BEcffgU4TVdLJcp3p44yjFqp8NlTEgS1Ws
	/Q5nh7ZCdgn17knpJFwrKBTiN2Trejy6Xr9UT5ulBraf0qvT+2WmexUc80x08NfXEdtVDBvjpme
	rPn7/Zh5McgeIhdxHlRgQZpSlU
X-Google-Smtp-Source: AGHT+IGm01cg5lXnPENJRNd1+C48PQ9hSvIItt8iMZjfD3EhZKk+sWrYBSUTQQY66x78JL+AuJZJK5wE7TfflEc6Pf0=
X-Received: by 2002:a05:6402:c15:b0:5dc:ccb4:cb11 with SMTP id
 4fb4d7f45d1cf-5dedd20e5a3mr42098a12.4.1739490261366; Thu, 13 Feb 2025
 15:44:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z60NwR4w/28Z7XUa@ubun> <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <Z62N6cGmaN+OZfoY@ubun> <CAG48ez0Bt9348i=We3-wJ1QrW-_5R-we7y_S3Q1brhoyEdHJ0Q@mail.gmail.com>
 <60447cd2-a8da-4be6-80fa-a5639b7455b1@citrix.com> <Z65/Fpd9cnUk8TjE@ubun>
In-Reply-To: <Z65/Fpd9cnUk8TjE@ubun>
From: Jann Horn <jannh@google.com>
Date: Fri, 14 Feb 2025 00:43:45 +0100
X-Gm-Features: AWEUYZlPPC-C6uIAwuBtVNNECjbeEq0SMljhE-c1JcoBtUnN4mOI8Tinx9IpsKA
Message-ID: <CAG48ez20UKXNW0jy+eO9_DT8aYeKZu3GBE6wU2xGFTBwo_ChzA@mail.gmail.com>
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
To: Jennifer Miller <jmill@asu.edu>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Andy Lutomirski <luto@kernel.org>, 
	linux-hardening@vger.kernel.org, kees@kernel.org, joao@overdrivepizza.com, 
	samitolvanen@google.com, kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 12:24=E2=80=AFAM Jennifer Miller <jmill@asu.edu> wr=
ote:
> On Thu, Feb 13, 2025 at 09:24:18PM +0000, Andrew Cooper wrote:
> > On 13/02/2025 7:23 pm, Jann Horn wrote:
> > > How would we actually do that overwriting and restoring of
> > > KERNEL_GS_BASE? Would we need a scratch register for that?
> >
>
> I think we can do the overwrite at any point before actually calling into
> the individual syscall handlers, really anywhere before potentially
> hijacked indirect control flow can occur and then restore it just after
> those return e.g., for the 64-bit path I am currently overwriting it at t=
he
> start of do_syscall_64 and then restoring it just before
> syscall_exit_to_user_mode. I'm not sure if there is any reason to do it
> sooner while we'd still be register constrained.

Right, makes sense - sorry, I misremembered the details of the
KERNEL_GS_BASE overwrite proposal, I had to re-read your first mail.

